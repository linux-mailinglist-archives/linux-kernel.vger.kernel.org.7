Return-Path: <linux-kernel+bounces-886404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE17C35751
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE94F90E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72614310655;
	Wed,  5 Nov 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YoO6DL+B"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D72E2851;
	Wed,  5 Nov 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343116; cv=fail; b=HbyMqxEbMGzTHD5dI9D2MGXh+EwI4jRSWII/+PqCS3u28wVHonp9XbsTrS9u3js+LEZwh46x2KZ4HGYY+crnF0XgPsnFqCCpRDqA3YUKZlR5NViMNl7UnWnFJG0mtrf2UFffhXLVtvL4VhhcU28Q6bDHd8X9FyIYJMTsQi3SK6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343116; c=relaxed/simple;
	bh=lOT2sBTzapnwrETQGT9RJ2RBkGRNH8L1jWKZNZeGhXU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=G8dhtDnpSl9hD7IzmySGGlF9k6rGV6GSjZAEtLzsreQjHDH0rnjLdSaD5ontxjpCwsEYPnhwoEI/BFgwuX6jZty4Gsh/tJm3MrdW8MQIQxtW8wxHzXBGCgI02VPBQiHLA0yz3G6ZSFTcfdLZFonQN3Ccsjss9OhIjlbVb9qRtKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YoO6DL+B; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN75x/ZJ/cxSUHvmmY1svG39dQ+g+B1kuYW/TUG/wt0DiTcPaKPDoe5DQgk+H8MGWnxOz2oDjs+55WpX40lVIOZ7PqycBo/yX3RCKjNJucASBqXliOm5XosLtdahayS8nT7VUMcrv/k8gFSdSmRu/TV5RMq+ORaKJlLHYvlJf4tTW9zWWGGrskU6elMIciTc2dEqbzWCJ3MhzwyhjDZegSfVI4jh09BvZOsgu317OU+7QbOc7p6RZQ/TOHkO6nPIoSLjFQttjqdT1NyFevJREawhZ5jQd22GcjYAWFG6ZCgxxqNyZFPunaKVQ55uakWeiCR8SqzyKgTA2GL/tqyKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOT2sBTzapnwrETQGT9RJ2RBkGRNH8L1jWKZNZeGhXU=;
 b=HMnCaFU8pA3orJsDauDcEZPT8DfDkups8jDRPfSmLQrk9W9chJ0TozcOVWOriHu4K/R89BPp51riR+T1AUrbLwVEG3sJg+IWFe5FT/FICnUC4amvQCjRkNYMzVj+dZ2MvTpUFEHoDFbIzxoqAaS+mWevoofxNMSjq32m77xYqG3flaWcPMLqDJIBVyyKTHtxTQORKL+qkMfj03Kb8kbChFpJ+y6QV5fTqt5aTff7SmyF975F+ufB0WOy972F0abSygVX/2athmdvdZxktBfswyGgQoDuZkCNg6Wq5RixIDe4tZUcVcaCaIZmKGBnIfq0N0/YzhtSLph7bs2R02n+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOT2sBTzapnwrETQGT9RJ2RBkGRNH8L1jWKZNZeGhXU=;
 b=YoO6DL+BxK9G2tP5LJCdKj+mKQSDfOcrOIb203sQnEancYj6NUcKZHwNJYqcJWSNOsO+oKmYhu5eeGaPk8ivHUo4shIE0PxGyjG/qH5l0uMJrJOlfGDz5h2z/HkFiWZfmdjVgVM/72/5FjKIWenWYYObJ58zNVlcAt7GAavnfDBvz1GQwRx8Al6MhLhwbf2C8H3D7c+5ZC88cMJD/BtYqsquQvtPNtbYqLeMRVGROVMxpzTtpCQ+AuyTUj+tP2HoJWqPQGPQClUjkB0IgnZDDJwADkYJWTkdM2BWD+UCMUhtS0Q2MguFbpUZyJHrd7lLnacbErwpVc3kcdExP3R64w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:45:12 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 11:45:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 20:45:03 +0900
Message-Id: <DE0QHP0YHN2W.2FG5CD7P3A1XA@nvidia.com>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family
 of methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
In-Reply-To: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
X-ClientProxiedBy: TY4P301CA0077.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::9) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a165b1-4e9d-4864-8014-08de1c60c425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVFPWjFFQjJLLytocHAvUTBidm9DZFpjTGkzemwxQzZxMFFsZS9mUWpWbVo4?=
 =?utf-8?B?Q3JCMWNUY2gvcHd5QkdKZ1R0U1NPdjNpR0VMSisxdUtPZmZqQ1dXNkN3R0cv?=
 =?utf-8?B?ckxINkI4ak0rQ1phSlVoK1gwOVpSSXNnNzZSK0tQcEkyM05mbi80NklIbmR5?=
 =?utf-8?B?WWJRMEI0U3hSTjZGckphSFJjaS9mY2FJbUJ5SEVKSGw0SDk3OEJVdDQwbllv?=
 =?utf-8?B?cDVuMGl4TmZ3eUdlQ0xDbG1mQUZlRTUzUG1tNEJWaUw0eGcyMWczaWpkbEFJ?=
 =?utf-8?B?VjNEOERhNDRMZlJrMk9jOTd4UUVvWGpZbG1IZXRaZXpGQ29rTllHQU9OMm5S?=
 =?utf-8?B?bktRN3lBaFFTQ1Q0K0pZcFdXbFFVWjAyV2F5bkptUFpnam04TEZ2WFM2WWZq?=
 =?utf-8?B?dlRXdjdBMWZncUlsWFNLTWVqYWMrU3V3eHpLdDArSjkzY0RtZ3cyczREZ1kr?=
 =?utf-8?B?YVc5bzVSQ2lTaXVsQUNtNzVid2lUeDZiTnBid2l6OGlMajFMaGV2UjlEWlVx?=
 =?utf-8?B?akgzRklaV1kwN3RKbzNweFM5eEdWT3kyWFFEOXFpSTdrcGNZd0cvZ1ZoUEJ2?=
 =?utf-8?B?ZVNKRUlRUUdoWXlpYTBETTJTdWpzUUxKR3loaDBzM3hIU2k0VFNVTEEyZ1F4?=
 =?utf-8?B?ZG5aU0JIblZPVlp0NXZ4cFJLK0UybXQvY2RIM2tNUkV2UHpId1lmZ25iVzZS?=
 =?utf-8?B?VHFaaHFpVUNKdVFRdkVMK0dQRWtvNDJPTzdaS1UxQkZPbzVtb3F1SUZaMFVp?=
 =?utf-8?B?VXE3UExJSDIwMzV5V1N1dHlSZW8veWYyQXJ6K2tHVFZwWXpKVkJzVFUzQVFv?=
 =?utf-8?B?ZnpMOFhHZ2tNdzJTNi9zbTFHdzlwdW4rMXVsNFpLbTZUcHJLSnVhaytEcnJF?=
 =?utf-8?B?UmZaUVJac2FOVEROb2RQWS9zazJqR1hROHNWQSs3NDdiNWtzVjZoVUNzTEcx?=
 =?utf-8?B?U2xKZmJWS1I5UUlrcUpJN09tOVFyK0pUeXUwcXRHM1pJWDh1SkNwbVlMR3Ns?=
 =?utf-8?B?Vm85M0NMM21tUXVoekN4L3Q1TEZtRzVhRThPZmlILzZSTUw3STRuYXRGY1lY?=
 =?utf-8?B?T09qMUpIQ0xvajhOMmp0WkIwMUZBWndDY1Ixb0UyMURIRTZSMG51WlQyeHkx?=
 =?utf-8?B?dW1LZnUvUFFzTHZsbzRxSmJlSVNUN0hEQmNENjdjSnJpdGhyMHRLVTVYMEVq?=
 =?utf-8?B?WUtJYWYrdURYQytMWFFyRjNJK2dVUkhCdnY0eWlrR3JvVnJ3WmNud01MVG5X?=
 =?utf-8?B?Y3ptakxqTjdEM3NnN09vNnVqN1dIWWZNM2trbkZCZDJXMmZ3WmFpLzJJa0ly?=
 =?utf-8?B?R2hXdU9tMG9Jdm82OTR5OVlnSGJ6MzNjK24weUxRL3c2SllQNTFtUWhrd1lN?=
 =?utf-8?B?MTRuR0JzR3Y5YkNIQ2FtNnd2TjMxV05BTkoybnJkcXJKeFNucFRKcnFhcThk?=
 =?utf-8?B?NEV0T3orY1lZdTN5dmt0YWEzdWdaY0h4QzNQMkFjQjY0TlJidlJlTWdlcnhF?=
 =?utf-8?B?ZXBiWTJkNjF6ZWpCeVFvUXE4TktpalpsQ3ZJSC9sNHByNG9xUXRpYm9uQmpD?=
 =?utf-8?B?cWk4QVp0akI1M0MzZUxQSklad0FUOE84UVJKeXpXM3hSMmhWdzd0T3EzK1NU?=
 =?utf-8?B?dzI1bzQ1U3N4dHpFVlBROGMxNmpJVWxsbzBneWkya0taMmx6a3FrSlpFSDJP?=
 =?utf-8?B?cVV4YzZtaU9INW9xZ0wrd3JDSFk4Nm16RDVoMG1SMzB5NHo5UHJlVFJ1aGVT?=
 =?utf-8?B?aUxpMzFNK0plRmtDZWZPaDg0RExuZWtaQjBRZllBTEVxK2hTVnducmkvSXR6?=
 =?utf-8?B?blo1d2FQb0JRQllOLzlTazQ1S0I1WC9hZjR2VUdmeVZuSkhiRWNJbFQ5NXI5?=
 =?utf-8?B?T2RwZkIzNzE0dmg5VkxacTNHRitYNkNkeG9OeXlhajJqd1RyM1ErQ2txdkkz?=
 =?utf-8?B?U1VOUkZvT292OHBrTzRUbWIwVTVUcE90SzM5ekZKRFhJcWlxelR6T2h1UlJF?=
 =?utf-8?B?dmRpOTJWZW43TE1QWXN1ODNLb2t5R2I5c0tHMVBtVTJXb1VXZmxORjRwdVg5?=
 =?utf-8?Q?l1YnNx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2t3QnkrNU5CWEo0bFpLYzZ1Z3ozM3dqSlY3aU13cksrVDFRLzMrUWEySzRX?=
 =?utf-8?B?VGRKdEp2YmJOUTJaVzhkTENDNkY0aXFPaHBOSEhPcnZBVDIwUHJHMk1yL2Yx?=
 =?utf-8?B?QkdDTkZLRW5KeGFSeW5ReHNGaHdYRmQwNzZEdEwrelJZZEdpZXVqb3IyVkdM?=
 =?utf-8?B?c1dzNXROajFqZ2FwUGRsK3I5RGhNcUZmUDIwb1RWbW4vdlU3QjQ1Um5Rcmlq?=
 =?utf-8?B?TU9MbXFIRE9hTFRZQVJma1FmWWJQcGJIVkVQa0wzSHRPREVsdEd2TmVmdTRZ?=
 =?utf-8?B?Q0p4TTRKU3JIWis0UnliZjNpd3pYY3BUVEprTU9BTC80UFhMR1crU1QwRG0w?=
 =?utf-8?B?bVQ2OS9GOWNzcGs2dzduZW8xTHl1aW1XcjIzY0RBMlVmRXBuRmd0SmxUMXE0?=
 =?utf-8?B?RjViUjJ0eTl2VCs1VW96VmZRcjV5SHNWMGdsdlQ3WkNBZEg2MFBQTG1BS0Zk?=
 =?utf-8?B?YktmK1doSGhSRm1Zb3VtNlkrZUdIVVpJcm1teHNxbExtTkZiUG9BYjdlN0Rh?=
 =?utf-8?B?ejJ0djJQSWVRYWYvTnBBYi9kVjJORVRaVithTVJnYStQTFd0cFZnN3NCRnJF?=
 =?utf-8?B?R2FaRmpxMVkzVFdSZ1ZjVk41M0FTVHJUQU9QbGVlanBnSFNzM1pqaUpjQkFG?=
 =?utf-8?B?eTRETnllckFCUzI4eEFTbFErNTZNWTdyeVNRdDdvR2tPa0ZodTZlZTBaOG92?=
 =?utf-8?B?YWNvSDVYM0FUbGo5UjY0Y2liUUd6ajdzb3F1Ry9oUXZLT1lHMUdOZUJIYThW?=
 =?utf-8?B?dlVETkFKYWVoaWYzdHp5b0VVLzdWTTB2MEVDRkV1TW42T1poeEtkdC9ZblJU?=
 =?utf-8?B?bEZkOHRtWm1ZZlhJTjQ0TGI5SmxYWVA3Q1cwQ0huM1VsUmJWTTlyRmp1bThP?=
 =?utf-8?B?aU5TRmRtOWdCdkloY09BUmIwYlRhQWU0U05ZTjBtVHNjR3hEWWt1bk4xWHRM?=
 =?utf-8?B?SldKb3NadlZ6NkRCNlpPQnpNK045S0JWUCs2UlhyaFdUbC93UmFxQk1UdFpj?=
 =?utf-8?B?dHVIM0lJdEIvWFVFcURORnhuN0lqKytzdkxqRjJPeWNyNFlrUTBGTCtQdEQ3?=
 =?utf-8?B?bkhleHVhMWZFZitsbWhScEFOZTZFdXZVci9Vdnl3Z2FVaU1haXpmVENLZjRO?=
 =?utf-8?B?bDBSWXV6VWlScUZrdE94NStYdEVVam1uUG1tNGcrOHdJVmNrZUdWN1ZPMXRt?=
 =?utf-8?B?WWpyWlM3S1kveWo3UnFzUDYrZllrQUd4eWg0NzU0M0pwQmppRFNBditRcnV5?=
 =?utf-8?B?bmsvT0dQVGQvY0p0QmY2aUJYeVVYcVRZOVdFN2NYUzhrbUVNelJNQnUxVnFZ?=
 =?utf-8?B?RHRaK0VDVGtjWmdlOTd0T0N4dUN6TWxnMFZ4UW9pc2EzWTFHaGZYSm5XeWl1?=
 =?utf-8?B?K3VqR2EwVmZ0OUl2aWZXZTNJRGp2dkZUbjRueUhzaUkvUm4vMklwWmlTWUZl?=
 =?utf-8?B?czFXYXVpTU5rYjdKM1p3UHpTc3c4SEtTQmdGajhVaGxPeStWbUtqQ2RvSkVl?=
 =?utf-8?B?QlFHa2E1SER3KzBnTHpYd29JaGFqdnhyOWw2QUJjdWp5NjJialFlK3JYRm8r?=
 =?utf-8?B?YlRpTE9hM3NwbE02eVhLVWxUU3FmOUswMFE2bG4rNjVLWW0rUzZOR2xjSUtq?=
 =?utf-8?B?aE1BOS9lc3pzMzhtSjNsSU1qUmh2YzFRYURqN3hGYnZwOWZORHBmRUszcmEv?=
 =?utf-8?B?QVpsQms0U0ViaDU1YkZxVGZ4aXBRZVhOWTZIc0k2QWpvSUtaaXdXZUdJdzJH?=
 =?utf-8?B?ZUpzNnZGZnZibGh4QVkzMjVnREJGTFFWVXE2WjR4SFpBMWZiaDJrdlVlVXZD?=
 =?utf-8?B?TGJUeFZnd1R0VWRVWkhxdkxvOW9nZW1MZC9PV3hrSk1Fc3k3aFFXOWQ3WTNB?=
 =?utf-8?B?eEh0MVFqTWJaRnJFMVZ6d3F6c0RTTnIwcUZxUjlYWmkwWUNMMzVHUmpNMitx?=
 =?utf-8?B?Z3RWOUkrTUx0MkFXZldYdUY4UkZUcjNxZ3ZDdlh0WDk5MlZ4ZFQ5NklROHZW?=
 =?utf-8?B?VHY4U3B1b29ZS3ZaMmRIQk1TQUNEeHh4TTFidlU1eFVaUENpU2NoalppQ0My?=
 =?utf-8?B?L1NEUWFrQ2dOVWhWWmFqeHRSSWNSc25IODc4NVg3eG1NaStxZ2d6d25PU2Nr?=
 =?utf-8?B?dEtPaXNsMjVHWnlwaUVxWjF2SDY2OXpYcWJMYWQ1d1I3Yi9kTktxUlJHK3NC?=
 =?utf-8?Q?rlOIUU1Oimbf1y66Uldy2xomD2H1V3XwryykzRkCMLpC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a165b1-4e9d-4864-8014-08de1c60c425
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:45:06.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSSoeCj+7hwzV3ujsyQXwBE+jiLRkNIrgUrzo8dsuf1m5rZ10wf8yWAJtLkFdthSs0J0P7uaD4aI88QN1orOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

On Sat Nov 1, 2025 at 10:41 PM JST, Alexandre Courbot wrote:
> The `from_bytes*` family of functions expect a slice of the exact same
> size as the requested type. This can be sometimes cumbersome for callers
> that deal with dynamic stream of data that needs to be manually cut
> before each invocation of `from_bytes`.
>
> To simplify such callers, introduce a new `from_bytes*_prefix` family of
> methods, which split the input slice at the index required for the
> equivalent `from_bytes` method to succeed, and return its result
> alongside with the remainder of the slice.
>
> This design is inspired by zerocopy's `try_*_from_prefix` family of
> methods.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This patch was part of a minor Nova cleanup series [1], but since it
> requires attention from the core Rust team and is buried under other
> Nova patches, I am taking the freedom to send it separately for
> visibility.
>
> Since the originating series makes use of this, I hope to eventually
> merge it together with it, through the drm-rust tree.
>
> Thanks!
>
> [1] https://lore.kernel.org/all/20251029-nova-vbios-frombytes-v1-0-ac441e=
bc1de3@nvidia.com/

Pushed along with the rest of the VBIOS series to drm-rust-next, thanks!

