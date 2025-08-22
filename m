Return-Path: <linux-kernel+bounces-780872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F6B30A47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82A53ABF85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC592F50F;
	Fri, 22 Aug 2025 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnLYEIrv"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BE6FBF;
	Fri, 22 Aug 2025 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822423; cv=fail; b=ez4qui3z9X9YXEiEh7+Mlq8PHTZF+Ra3oLzfnpMtw1YcLrLyDasdGG8kjs4ygKDJHqbNTI8OIumzm8veGUEbXVbWaVC8jOSKyxUOqOMLpW8O7nJI90++3SHF4zEaTQJBU8ZpDXvPc4tSrAt491E8zMIl5Sk0fbo7KS0WPN2Qnpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822423; c=relaxed/simple;
	bh=WR6ugRuBMlOLsrAD115TV/21mDSf+XD8jwax1bgs7ho=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=atIHuRJxACce82rfSEQDFQUgt5OIt4/b1f8ngE/1jVWQ4m6ap0I71fCL7WTucF5bX+tBqg9UBOsyolB94kKVZ5Go2TSvvxE7OC7KZ7ULRELdAhWBn+B0Rt2fDx/Jx77YubaPYmTiqK1l7gozAESPSX4bbICGz8BZRKbJ1PECxCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnLYEIrv; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2DWvKDRp7KDuI21uBzeal7P/vG4o4fELMcu7usmS9isNLjnc+fJLuSMj8b0QcmWhovuFDE6GpkfeVlvitzzQMPbqhf35pI+WkHIQrEZXbI8xdP/GvRN08bmtVA+V6S4WDQz+DbFqJT1xddMn4IBthRgye3i2RZTNht2brM1sWM4CoCzD6XpO6/jsJMKYpv+n6dWSO5Lel/EG2IV8UnSQgNQ5N9EABfheRnge29U6hm7koDABEuAxlvwp5qpDA1OhvKFIU4BHmjnMJMFiSjAtymyacKmLCgdJ1OjigEnuANyVWrDe9qLasjpMgV1cF77fHRHskcqUAJiuwqNWAggZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR6ugRuBMlOLsrAD115TV/21mDSf+XD8jwax1bgs7ho=;
 b=RkAul1XHgrUlUoRDVlyEFl1NUq40aqq0rfLdcaZSKkEsw5pmiTogfvRbmz8xGKNLB3h5Dy0t3x84YEPOIm15zXvmjhGpLCe8BDc4O9Lk9MTaU5YGcWWGrQjqJ0Dr2WkOHNu1SDLHCSAnfpY5Gr6yyknDqae53G+YCdUmsKkqqWhwnI5cW/f6EgZithLX89jbifmSKszgebmF3KFoxtgYso4fvDVEfOEJupYLwguEtnbpU1+mdN6wyHvGwp2uXW/6JEDM0fnPs0x26NBzcj8gS82eEyKv/0NVBrcceiweACNLQvJOFi85iLWluGAqby4HwEQuN8ysLFfMBxIrutePUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR6ugRuBMlOLsrAD115TV/21mDSf+XD8jwax1bgs7ho=;
 b=pnLYEIrvvQIdpwvQW9qjiu4b800LGpn9keb87CwKxFphBOI0Am2u5lsRxTxeZGh67XBXGpk3JvR6REIHi0i0+DRMx7wjndyU5sgpIxVsAVlDT8PegV+GBhp4nLQNtYOO/TkTnIFDdugduXzjFkZNO6EbkYqUQHOlSXhvn5X/FDKrywZHg9F5mfLJEGNpIZOYpVM5Ylu/rg0qQTQaLDgyQQDu0P54TMcM+5AKwjS54nkmQuPDrjW9l7pJr64qsSt9zynGEFNAYLmLDiE/0EuyXRctaBxRdEvR4oGV4/yvjTO6Nbt0rmFuhKXRm0fvnczrHFqFB0/2WmHtcR6TxoKhSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 00:26:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 00:26:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 09:26:52 +0900
Message-Id: <DC8J3KO6Q4I9.1YUAGOIYC2TOH@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] rust: transmute: add `as_bytes(_mut)` methods
 for `AsBytes` trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
 <a327ff52-c37d-4f51-8d19-d6b1cc858d79@kernel.org>
 <CANiq72=LhwvvsN4A1F+3CffTF59=Gpq-B0hzQOszMPhTVo0hug@mail.gmail.com>
In-Reply-To: <CANiq72=LhwvvsN4A1F+3CffTF59=Gpq-B0hzQOszMPhTVo0hug@mail.gmail.com>
X-ClientProxiedBy: TYXPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:403:a::31) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: e294cbb7-7088-411c-d4ea-08dde11299b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDBERTluMnBYY3ZyY0xmTjhLY201QTVjSHlLbjliY1BQRXRLVVZnZkVIbFVv?=
 =?utf-8?B?dU92WWR4QTJURWdqVDVXL3l5ZkE3S0drTC9GUFA5L0Fsb3luQ1JGenRGNTZK?=
 =?utf-8?B?Y1A2RTNLc1BZMDMzRXY4VkJLalFFNW1VZ1VKYzlQOHZTaWcwQS8vNmRXSFI2?=
 =?utf-8?B?OFFZWWdVaXRTamdDaXZGZjU2ekhFbDY5MDhLZ2tnZzBzOThyKzVwL2VsMFlh?=
 =?utf-8?B?UnR1QXhQb0taWitHMS9rak9USWdHbytnOExmQSttenNuVld4a21iQ0ZvZmZs?=
 =?utf-8?B?cE5mOUNVSmlHd2pERVBaWlBQOGpjcDdPUzBPQy9nTTFzOFFtYUg5M3BRTTRq?=
 =?utf-8?B?NjljM3hIKzJUeHNmTDRNa2w3enhsSWhvbmVybVJKb2lLQ1ZrTnU5S005dUlE?=
 =?utf-8?B?WHdCblg5TU5Zd0ZnWjh4bFYvNG1Xbkh5L01jaVJjaWMzTDNaWEd1b0VKRGIz?=
 =?utf-8?B?c2RhSk1VamVRWERJSU5lTis1QTVUbE51SzVtYWRiV3VSNHgvZTMrYU9PQjhI?=
 =?utf-8?B?SDRYU0QxOTAyWUdpMVhwZEROdStSeVhCQTE2cGtOYnVQRUNra2FtaHJJR2Z4?=
 =?utf-8?B?M1d5REpjMEJkK0I1NS9sazQzNWNUR2V4RmtvZkR4a3A2UldmZWpZY1dJRW9w?=
 =?utf-8?B?YlcxNDVELzVRQ1d2VVBHVnBUVThqL3NmSERhM1dlR25IaTY2Q0pGOHpTZUpC?=
 =?utf-8?B?czlYMGd0M3BNQWVPNDlrenVPTVl1cnhqSGwzd210RDVoYjlHdzdZdTVGRkN0?=
 =?utf-8?B?Q25aYkEyTHpSTGppRmdJZUk3SlFiQlNIb0c0UUpSM09qYzZuRTdJOXBTNk1E?=
 =?utf-8?B?dWt1b0lwM05Zb1JUalkvKzhhVTE0UExub3p0R3Z4RzFoY3BRSVY4SkgwTFhx?=
 =?utf-8?B?akJZQkwybEdHYWJKK3NOUWU0cVNudnp5YXcwK0ZwN0pCSmFlNlJGRElqR0Vs?=
 =?utf-8?B?VVk5R0dsTXpML0RHcW5JMjdSVHZreTBsR0U1dHZiOG11MFpjM3pmVitHMDBi?=
 =?utf-8?B?bC9uTW1iZmZxdzJMZ3dWcU1ZSm1OU3owV1RSSVc0YTNyWGtvL1hOaE5aUVlP?=
 =?utf-8?B?T2NMeG9MczZwdXM5eGdoNWthRytqTUpZckFUYkk0eTlLdFB0YVE0dktSVXBM?=
 =?utf-8?B?Yk5sbW0xQzdUMFIrTjhnZ0lpb0krWmh6dXFRcEdicUYwZGhaNkU0R3o2aFFT?=
 =?utf-8?B?VGdIUkV6czB0RklXeG4rRTVYZThmMmYvVmRwYzhKVzl5WkpWbUR2SGFSNk1S?=
 =?utf-8?B?dFB5TG45dFdyODIzSnF1OUI5aWowczRiL1N4b0tHbGUrOEs0VVkvU0pqSVZZ?=
 =?utf-8?B?V2U3TWdwUExCamxvWXhpQ0tOTUtQMmRHN3MyZTlaOEpPNU9rU0FpV0VOUnlC?=
 =?utf-8?B?SEFnWmg5cDVVUEZ2UkFTT0I2dFhaQWxCZmJiMk42aU1lQ3FlaTE0VUZEWTJR?=
 =?utf-8?B?YVhaOWhoS0FpRk5uTktxcGZxY2MveXVwYlBJL09pb1NkK1BOQWJvRFRuM1Iw?=
 =?utf-8?B?Sk1lejVkOE8ybkNFdmpaa0lBZnY1OTlWYklnUHJKcjduMy9YcXRKWnhqeEtZ?=
 =?utf-8?B?TnJWT1cweXFSSmV3ZERkNUFKN2pjVFc4aHJsalRmbHIyK1VNYkJmcXA2YkRu?=
 =?utf-8?B?NC9DUjdDQW8wYjl2Z05GRC9hZ2FtVnErNGVoUncxT0M1NkRvSmYzS2dudk5x?=
 =?utf-8?B?TUZtOGxvYmZtaXBaeW5BS0ZGcU5GckxFbW94R2taaUhldEFsdFA0aGRUQktu?=
 =?utf-8?B?dHdncFVvMnpNeTZwekl2ZC9ROSt0YWIvWU9OdnNENEJRL1Znamw3dzNIWXhS?=
 =?utf-8?B?TmRNVFg3UDJGMzRuWndtc2V3MUUycVA4dnRaNlRHMGsreU5uS2N1M1pFVGY3?=
 =?utf-8?B?RzlOQng5RDlyblBVc3g0OWtPbm1wc28xUjVSVHVERTF2ME9rUlN1Szh0dzh2?=
 =?utf-8?Q?UZKcsPNnhm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTk3eTlqamh4NXVFRzBjWkM1bGZjTElhVFRad2NYVkRHWlQ3aUpVRHBhYjIv?=
 =?utf-8?B?dDBNS0xvZmFCMzhmNU4vNExweFJDTUNKcXN2YXhaRTc4UlE5QktDNkN6ZllE?=
 =?utf-8?B?V002QkExbVVrUHlXWk53SlphOW5zSzVWQXlLekJMcWNiR25TSVZ2UW5VKzNE?=
 =?utf-8?B?ZVB2R1YyL2s4MHFBeXdaWG4zM3g4bUZXYmlYY3hFeXYweXhSbmtlK3E1ZXZY?=
 =?utf-8?B?TTdxZitYbUZpOTE1cVZReGQvL1h4cHQrYnFVRWp0SytZRDJRZ2RZbVRQUUJv?=
 =?utf-8?B?Z0VQQU8zVjlTUUVxZGVDZ1g0aG5DWjNUSmRNOHpzaVQyazM2Nm1hTU9PZEk5?=
 =?utf-8?B?aTBkcm9KbTd2cTNqV0dJcUxublErSVpKRkZLUGo1aThBV1FQdVB5bGlUVDZH?=
 =?utf-8?B?a0VHNGdSTjRESnd1WllmaUVhVGk3eTlQendBSWxaWXJROGJ2eXNKU3JEOVpS?=
 =?utf-8?B?VVQ0WjMzM2g0MW5NMkxuazV0clpwRWdDY0IzWWtpRTRHMWJsaVpPcEpFMm5S?=
 =?utf-8?B?TjNRWEgzZnFwVHJJSHR5MDFlZ3dPL0RCZDVVU2dsM3JsVmFlbWhKQTdWZ0dy?=
 =?utf-8?B?WkE5WDFQMlRCVjIvRzczUVcycHRDWTV3RDFDbExTVDcrRnVhcHdySWVjaFIy?=
 =?utf-8?B?WTFSY29pZGQzYnM2aGlEMzJLRzZIbXJWMWRJSStqSHI0ZnoybXVuL3BPRU9n?=
 =?utf-8?B?eWtQU3NZSDRuN05aMXVSR0hhelNmdGZxOXpLU1R2eG0yR2g3bW5UOU02aHNo?=
 =?utf-8?B?cXFGL0lBTTJYVk8yQmhyTkxKZHVSd29vb2xlZkJMVlVadVFzdkRkYjNVU3or?=
 =?utf-8?B?dkdGNjNZYktqckhla25CSWlLVEc3b3pMOXF2WU5adFMwMU5MZjgwcER4VFlY?=
 =?utf-8?B?RlA2OEU1WjRaNTB6V3pTZ29wWXJGMVNHUDh5d2E2bnl2T0hYK2V0dklNN1FX?=
 =?utf-8?B?UWswYlYrZHEybUQ2ekM0bGVpdFUvQjNTa25vNjk3TEZkVmFzamJFL2p2MzZV?=
 =?utf-8?B?TUVSS2cycm1YYlhsbUhoREE4RW9wNEpNWmpWSU1KR2R6WjZyUVRzSC9BWThO?=
 =?utf-8?B?S3p2VFFjZnJibnlsTmxmb0lnVXpaK3BPT1N1OVhGaFVDMXlkRVNyVFkrcUJv?=
 =?utf-8?B?SnlyQ3VkbS9OMVRQejJib2tBMGVnNGU1UmxuQitqWk44Rm5PV2U0cGcxZ1Uz?=
 =?utf-8?B?czlaQVVqeThmdG83T2hzdURhZDJKbFFkWHRsRnorcFJjbVhwWVJTZjR6U1Z4?=
 =?utf-8?B?S0QvTzBlMTlxM0ZSaDE5N1dzelFsWjd0N3ZlS2dQcWpFbU03YkJYN1ZwUkhk?=
 =?utf-8?B?UlpkczhpbGsrSWN6WTU0bmlUY2haRkJtZDRBSk9mWVFvTDk1eXJ1UUJ5UTJL?=
 =?utf-8?B?dG5yZmNLdGNCWDNlcVNGVlpENmFCcHNMcXhsckFnR0RTM001R2E0My93YWJy?=
 =?utf-8?B?dVdRMDBBT0t3TlRQSGdFZ2pXZC84NzUzR3djOHBNMmtlcTU0WWpENU1CSXFQ?=
 =?utf-8?B?aXBFVXNIV2ZpYmxRLzRic1FIRmZFTkN6NmViejNBUWZ5U3ZiUkt0WEJHbHRu?=
 =?utf-8?B?T1pzMVZxN2llT3d1QXU3b0ltcGp4dDZJRmEvdXFSUWkvbTFQY3EybnZPdllK?=
 =?utf-8?B?ektOcG5XRmtEaWtHZ0h5dThacmdSR3Y0Y2lrT2lTRVZMK3luNDZQb3FHYXBT?=
 =?utf-8?B?RXFHenJkQ1YxSUhWZ2xLVjVDeGk5VWlGOEFyRkIxRlU0cyszNDhpckxKejF5?=
 =?utf-8?B?dWdPTEpQQzVjMDc1Vys2NFRyZWVKSDU0NlpWMlJQcmZZcGQraDVRVHBzZEdi?=
 =?utf-8?B?TmltNktRY2FDTm5SOWdnZkxmb01QVDd3a3RpWG95L3NuM3o4UCtqWDJ5WHNp?=
 =?utf-8?B?L283WmxRb05FMVU3eDI4Wk9jVVZTdzNhUFRHU1k3UVFyS3BZR2xkbzFIZTRv?=
 =?utf-8?B?dHBtdnFJaGlyNEZHNFdFYWQrd0RzZnYvWi9aeE5VZ3Q3QkZLaGptd0dVeFpz?=
 =?utf-8?B?bGxDMzhkallraWxheEdjSjNUVUlzL0RrQkx0VGhDQ282Y3ZDelYvR0NUTXdp?=
 =?utf-8?B?ODU4dVRUOERheGE2SVZyYi9NR245cUVoSGJ2MEI5NGs3NmlIcFlMQWRaVFFi?=
 =?utf-8?B?SmVPWUdhNmVwT3NIblBGZklJUU56TFcwT1FxVGJkWTlyNEx4djJ6NERWM0lu?=
 =?utf-8?Q?zZbxY+PkwfluVAMPkCvpt31P9lQ6wu/HeDllZI0ShLO/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e294cbb7-7088-411c-d4ea-08dde11299b9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 00:26:56.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqXF9ZRT7QlekbQgvpoFgTAs+nlnOgHBXITqH6/TGTxszYpCZmjmVj0u5+iGZq0n8Nmjeu9MF1JhFvJFGMKqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

On Thu Aug 21, 2025 at 11:38 PM JST, Miguel Ojeda wrote:
> On Tue, Aug 19, 2025 at 11:49=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> Miguel, any concerns taking this through the nova tree?
>
> If it is needed for something this same cycle in Nova, then please go ahe=
ad:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Miguel! Yes, we are planning use it this cycle in Nova.

I'll push this into nova-next later today.

