Return-Path: <linux-kernel+bounces-745148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D85B115AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CC61CC5B91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAB1C9DE5;
	Fri, 25 Jul 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGb5dtVb"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8915B54A;
	Fri, 25 Jul 2025 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406251; cv=fail; b=izSmBBxSN0b3pmqERtjphBhw8OlUPw9MeNFX4+cn/o2FEaPGa6oDUlKMiYmR7UVSSQ7dIvMM+eeyUi4ijnIl+QjEY29WM9O5sZJqIBJOsigMOS01XE17sfrJ4eELVSGlYgpqFciiMA9GA+591DbQU5ma7tKYs2NsV16XREfbpjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406251; c=relaxed/simple;
	bh=+rRKO8Pdh4Z2jhFZGK53K7Az5GAbGMKmMD0qf0lSsWU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=eGmOwS2OR8vBPwnBt7iwL3crHOrWbfaAhJhqK/xT3DGMXCqRFI+SEwu0xVhThDTbRU5q9rLE9keStGJn4jpcNvuJ20lb0f/GtHAccmuwA/qdhZj1kY0O58wHau+dlTqvr3rSH6JgpmGhIAJOKAwAneCa47uCV9c9W38IehbEwAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGb5dtVb; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHgSF32IIOz5Z0hGsLRE7yToy5UE9u0Kdfh0tM2BG1nPWd15ZwL6SX0BoEnUVucD9upAXjWxAnX/e0T/+1UejMkjFGQaHptzcTKG5dxcs+acu4OwTF3TeEgf4zJpbhTkPwVj7f4N9dcBwNxWmUaamZXhwO4RPzrsUnlho7g8LenGFpNgESQlj1AcuCfLb7ugmscHSTzmHFtqva4I+16o0tSdchF3IIoqfQs+MKu2JVRGNGwhyhLYB1MkTHcqe3DyYJxFZxBKKZqZoBoLiGSlxoNqhMmsIkZK3LHgN1UFcvj6pqNS8kO+VIYKSyILNRd8MaXtKwrW50T2IJ6vvETDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMTunUj194bBWyjcf491LgLkQxK7YbW+SSB8KvWHsoM=;
 b=LUVT8KuETE/KeLM2CHfvdi5jnUjeapmTHyN6jSaE+TzOMUbWsrsSS+fBYVNJAgVun5l6EKJUq1MGSl14VXv9VvCp21iFvbKijdxk7LWuhONt+c8VObYCkvM3xTyM9Dz/QIaJblIe+sPIen8AQXHgdU+YkF1BlvEznNUVyjAnB7xmSsvd/Z3kNUJLsvp1xzSjI45P3sQgUG4WhxZwrJFvifzB0/X+R26LQMtkFp6w6Gqrr7Ls5nHThsxbO/JP3Q/8BYh1cmV4tjTFJAg3wTDd6c9MiNYTUp63TLn2s3MZbqcn2mHocsSiY894TfL2aJ20ya13ZlfSVpv/i9qx51dvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMTunUj194bBWyjcf491LgLkQxK7YbW+SSB8KvWHsoM=;
 b=qGb5dtVbGVhHPgWcnGpPGiudhGRgni5x0RtKff75um7kjvQWg0mySL5L0IPmz4343ivau9Chdspd3jY+zpo+VCCTwJVFFbHqi8uZ4/hZFofsF220Po53l8XnwIEK5lMG8BDLlQe23LZgBlCsmvRV2yzdb6YBepiBmlY2f5F6UF0ZgUj6FTTqUK2JeX6/QCxBU1IbFsv8j0d43guZZlsWPgwnImcXW/eeaYKsizOYOBVK7gQLlzobLh5ReRQ63/vByv07lFYXPZx374IyJJUEw/5pS5NXxP90wR0FL+Ya61SO4c4476qIUteeS5dJXfXOiAHzoYQ8gRGrE8Wwdz86bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 25 Jul
 2025 01:17:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 01:17:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 10:17:20 +0900
Message-Id: <DBKQMYTGDFDY.2N70A5XF1TIIM@nvidia.com>
Cc: "Frederic Weisbecker" <frederic@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for
 Instant
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Boqun Feng"
 <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250724185700.557505-1-lyude@redhat.com>
 <20250724185700.557505-2-lyude@redhat.com>
In-Reply-To: <20250724185700.557505-2-lyude@redhat.com>
X-ClientProxiedBy: TYCPR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f0fe48-c753-494e-207d-08ddcb1902e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pvaGtXdVlFRVQ1VEJKY0lMK00yVFpSdXd0U1hubGp1cTlmVTJGVG5YcW5h?=
 =?utf-8?B?Z1FNaXNYVSt5QkpKZFF4OCtyejNUZVZ3b09oZnJBS09lejdOTWIxb0ZPTWVj?=
 =?utf-8?B?SGdRbUl2T0U4K0t4N2ZwUTdNVmNHUTRBaUpZdzA0QTZrdnFoQ0lNTThmaTJl?=
 =?utf-8?B?WVVIN3JqWUVJdUhjaHlDR1l3SXpZYmFMUlhTUG5qTEJJWDJFdjNXTGx3clFI?=
 =?utf-8?B?SEduT0ZJbXoyTWQ0SXBnQnRxaDdOM3lEUjg1S2JJMlRzQTdJdXg3UGljZmh0?=
 =?utf-8?B?eUMzVlhRK2lGZ21uaDh0V0VuZGdMUnRxZEFpbWFUc2YwRm16YUJiTlVIVi85?=
 =?utf-8?B?VXh1NXN5b2dLbWhwUG5BSjUxWmxMSitIYldoT3AyczJiSERJQXJIdm9td0pK?=
 =?utf-8?B?QVNseE9EcVoxMWF2T1k4Q05meTBQaVFNMjd5MEdDQmFZckdHYjNhRHlTSzNk?=
 =?utf-8?B?QTgwZlpMdXZMcE5tQ2wyZXVDSVRwMDBIWHppdEhZU1dyajhMd0NITS9HVFpX?=
 =?utf-8?B?UDFmR2pVbFpFOUw0aGM2TXJJRjZHQzg0RHVzS1dscDZicDVZOXlPUUw3ZDZN?=
 =?utf-8?B?azBpRW1BaVpxTm9wZEtPK1ZsNTFUNFdSQmJxNDRrU3l3ek13Nlk1WmRwNmRW?=
 =?utf-8?B?WmtXVUQ2b3NNQzNuR1ZpMWhlTUJrNFNqTjBoWGdGNWx3QUJkeEEzaWtKaEI2?=
 =?utf-8?B?dGhtTzRZN05sSlJzWVQwODdRRTNnNkxKcTVheTV4aDN3Wm9QZkhxbUY1RUpR?=
 =?utf-8?B?U3BrTE8xOC9QL2IzQnYrdTBWWmFvZWYrbWROUU16YXIxMkFDcE9DalkxcENX?=
 =?utf-8?B?YTNsdWxVNklGN0F0OHpnMHJLdW8yK1JCQU5TZmRJZDZXVUdYamx1U0Zuc1Zp?=
 =?utf-8?B?WWd0NUlrc2Y3SFo0RjBCYWc1em1ZamkwdVdhNVdNY2hFODIrR2FEcUNrc0h5?=
 =?utf-8?B?QnJ5RUxYOFFoZTMxb0lnNXRTVXRId0R6dXk5akUzZzE4eHluaWZMaTZGcXI5?=
 =?utf-8?B?QVk2bUpiSm0zbW1nU0dmZm04TUJaYlJrTFFTbkNkRy9XOXNDekEwUG5LbHhK?=
 =?utf-8?B?c1BrZ1pqZmFVWWNSU0hBZCtnR1Y3ZFNFcWpGNzBYdHZDVzNCSEkxaWVQbGhW?=
 =?utf-8?B?VTl3WmV3LzFvaUdtTG4ybkQ1RWw1WTYrME5UTG50SG1CY3ZlbXVTV0Y5VmZ4?=
 =?utf-8?B?TnlIYlMvYSsyRjRnODJYcDM1anRxU211YWVBWTlNRlJER3lvdmQrclUydExT?=
 =?utf-8?B?SEtmMnRySWVWQjJqUzRkZm1EV3NoY0k5cG1sanM5aFl5Y01LQ3RoQnZBcjhm?=
 =?utf-8?B?elJvOXhYWnIyTWErSlVUbStRbXhOT2hEWk1XUVhuTTRwTWJJaGVxVGZrYmZn?=
 =?utf-8?B?a3FHQXZPcFRwSzhHTUlISVFPczc3Z0U2aytaM1ZGTFZsWnBFZEhMSjFKYXpS?=
 =?utf-8?B?Q3VlcG9HbWJLQzg5T2RvampsUEg3dTBDdVVicm5WU2NTRlQ5T1FxenBDbUlh?=
 =?utf-8?B?Q2tEOFRzdWVvZDh6b0U5L05SRVZZeFV2ZWRrUnNlejkyZWZxdjRFVkY4RThJ?=
 =?utf-8?B?Rm51UURzNVNPUEZ0RURoOCszRVVJY056WUpWZWYzQWZ3RWZEUE1wVHJtY1Zp?=
 =?utf-8?B?WTR4cTBTWHgvTU1NK2VZeEhkdlJsM0MyZ29DSFpodkJ4bDIvaVFXUDlESWsw?=
 =?utf-8?B?K01icFU1U2duUlcwd0JSOU9mL2FPYU5GclpUN25zcXlCZkRjL3c1N29EY3V6?=
 =?utf-8?B?YURVUmdFUUpsVG1kbmhOQW5QRFZaaWFkcCtTUG5iNmI1bGdBRUN6Q2lVSDF0?=
 =?utf-8?B?K3dUYlg3VDgrelRwWHlhZGdDOXd0ekVXYjR2b20rNjhTVEpZMzlLYmI2bUwy?=
 =?utf-8?B?aFFqMVhxNmJ6M1dSczIwSllLT0F1YmNacDE3WUJBV3hpUTVFRGJtNS9jZHFa?=
 =?utf-8?Q?2pOls9OlPm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1QvLzdlZ0UwMm4wUW5PUTJWYzVEY0dOcmdvTDRaZWQwNFZsOEY0Nk14UXg3?=
 =?utf-8?B?WVUxM3FycUJCcC9YSjRQV3dVZTBza2QxS3JYbm9xUll3MCtGRVJRZWR4Und0?=
 =?utf-8?B?UzlUOWo4YzNwNUozdEJpRHdtdnpqdmMrSzdET1pOV3Y5TE9ua2FWZlJRZUQr?=
 =?utf-8?B?Y0lXMXNBTDlnQWlDK2phN3phbzlHd0dFMG1GOVBqbVVLbm5hZVBwQnJLMDI4?=
 =?utf-8?B?VFhpVTIzOEQ3TEJWQjJBOWFsZUNlZ1B6WE9SUC91UTlNcnEzUHNETE16dk1Z?=
 =?utf-8?B?SW1NblhTMkl1NDcxcS9ER2pqZXJrVXBUMHhrMElLbWhWRXlja1hkZHVoU1Ja?=
 =?utf-8?B?S2dmNGQzUzhHZU9JblBDdjEyMDl2TktoRHRhcy9yWTlEOVRvd2E0Ry9JdWR5?=
 =?utf-8?B?TnE1SWxKMFdGSm9PSVNmd1BXZ0tJMTRoUjg5ZS8zNlNoK1MybGMydHg4ZHhN?=
 =?utf-8?B?eTVqVDBrZ2hlZDdPbmhGUDk0elNSbFVRdzkvR0tMbGlSVFhOMWVEdkZEL2Vi?=
 =?utf-8?B?cWdGU2lETVZDbXB4MUk5SHozajRObGxENWswUjcrZ0pZMG5TblIvWmJlR2hO?=
 =?utf-8?B?TTRIR1RUNTNXQmpGQUdSaGVmSk5WYzU3czZrUFoxUDZvUjBFcnJweHczamdJ?=
 =?utf-8?B?b24xTS9XZmpqL2tMSzRqbVZ5b0I2RFVJS3hHUkY4M3YwK1QxaFZnWkI1VHoy?=
 =?utf-8?B?djB6dDlqWEhWcVZ0WE9HWGlRU1pXblVaWGRZa2RuV3p5bDFOV0lNcWlHSE4v?=
 =?utf-8?B?TVpmV0FoNFZrRjlOZDMxbys3WExKT1ZwSmpQb1U4dWJwYXNxNUhtQm1GT2FW?=
 =?utf-8?B?MW0zaUhhM1BFTE9wTW5ON2pEZlpFNlR0TjlBT3FRaEpqemM3VFM4c0VoaHFT?=
 =?utf-8?B?NHFmelZJODZXSCtsazRNS3IvSmU3VVlWVHhXdmpuLzFNRFZMdFhIK25VT09P?=
 =?utf-8?B?Zll6N2IrK2VuV2hwa3pXZzJTR3NkcGQwTEx0ek50M0pjTlI0dVprenMxdVpQ?=
 =?utf-8?B?ZmQ3Y2QwTTBONEJ3T21xaXpya080Tm9FVmF0Q0hpR0hlMWs5b3lneTBFMVow?=
 =?utf-8?B?MjRKaVFpVlpIdGxGMGQ2SEdsMXZUbm1tOFR6QXJGK3BlS2EyMkliOGg0Q3JP?=
 =?utf-8?B?dnVOYUhxdTRHMEE2R2pvakhwZ2RSWEFEdHJFZWZHT2ZqdVFrd0VRcDZSN1hY?=
 =?utf-8?B?ODFsOUNPQzI5WjJQWGxSUjVYbjJUcGQ5ZGFrajdpVjA3Q2JEb1N1L0U5TlhM?=
 =?utf-8?B?Umt6dS9NNFJKR0xuTm9VUjYvdzJGY0NqQWRvcys5TUkyYUY4ZlUwWUtheVox?=
 =?utf-8?B?WDlJelArV1B2VkxTTElyK3A2NkVvYVFkTTZqR2prNFFOTmdRZENyUjZKS25Y?=
 =?utf-8?B?TmE2K1ZzWjkxRks5U2xJU1BuNVFCNlNlVmJQOUdwclN2MHZXSU0yd2xDcHk4?=
 =?utf-8?B?RDJwdU5JelhTcm1SekgzcWlsV2NZT3VoZ0Q5d0JEWkR4WGNtbXRmR0FveVhR?=
 =?utf-8?B?OUxGeUZrTDNnWEtFd1lNRjJSNW5KeS8rMVcrd0w1NXVRS1ppMFdHSGowVE1F?=
 =?utf-8?B?SVdVeHR5alQ3b3dXVjVPVmk1b1RWNDI5UXREVlpBenprc1k1YkNVWjkxU1B0?=
 =?utf-8?B?K2RoTDRqWnlOL0w1MDUvZVBJc1hDSHRYZXNvaTdKSkdITm1YbGxzZzYyMytL?=
 =?utf-8?B?REhPZmhWOWV6TmFKY2Z6U1NkeUQrZ1loTm96T2NVS2pEdHlIaWRaMWgyUTd6?=
 =?utf-8?B?L0JZVWNWempPM0lXYkZXSThaT3pObnBhbnFNVHlyNk5zMnlndXVCRWxJdEFP?=
 =?utf-8?B?UUc0bEk1Q2d5cXlzblMyMzVxL0swenc5VXJGUlZtNTE5RnhqdGF4clhWV042?=
 =?utf-8?B?dHR4ZlNvRHRYcWJVNlRINjVPNk15WUgwVjJZOHk2TFBJYWNsMytSdXhqTVlG?=
 =?utf-8?B?ZzlmdW1qa2RBRlByRjhPWGlvZEF6cFQ1TWZMbVBxaTlaWmg0UlBINWwwSENa?=
 =?utf-8?B?cytuWHZVYWRrR0kzSUpnWE9YMExkWC83K1ZoWTBJQlRJMnoyK1Nzbmg2akJM?=
 =?utf-8?B?MG1rOVpva3dUNEI2bmM5dE9EZmtDdFY3QjBxaUl4Z1NGUDB1VW5peU5oblg0?=
 =?utf-8?B?MWo1bGhQTUNaVXczZ2M5UG9hL05wNklhSkExaTlYM2VYVUxpb3lNS2RDV0Iw?=
 =?utf-8?Q?tJUCRCek4EiNOg4ugIdcI2DmuPT8uI6uGW6xoXQjV8ct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f0fe48-c753-494e-207d-08ddcb1902e0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:17:24.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjMjcXPUjQqcNq5tz8X3SmmcBp1RTH5pAyGcxzNB1ophlTOhF5kDZ39vVE3X0rSfK8s1Z6hKAT750zSWM9UhwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Fri Jul 25, 2025 at 3:54 AM JST, Lyude Paul wrote:
> In order to maintain the invariants of Instant, we use saturating
> addition/subtraction that is clamped to the valid value range for a
> non-negative Ktime.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/time.rs | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..ac5cab62070c6 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -25,6 +25,7 @@
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> =20
>  use core::marker::PhantomData;
> +use core::ops;
> =20
>  pub mod delay;
>  pub mod hrtimer;
> @@ -202,7 +203,7 @@ pub(crate) fn as_nanos(&self) -> i64 {
>      }
>  }
> =20
> -impl<C: ClockSource> core::ops::Sub for Instant<C> {
> +impl<C: ClockSource> ops::Sub for Instant<C> {
>      type Output =3D Delta;
> =20
>      // By the type invariant, it never overflows.
> @@ -214,6 +215,32 @@ fn sub(self, other: Instant<C>) -> Delta {
>      }
>  }
> =20
> +impl<T: ClockSource> ops::Add<Delta> for Instant<T> {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn add(self, rhs: Delta) -> Self::Output {
> +        // INVARIANT: We clamp the resulting value to be between `0` and=
 `KTIME_MAX`.

Not directly related, but I see `KTIME_MAX` being mentioned several
times in this file, but it doesn't seem to be declared anywhere in Rust?
Shall we have an alias/binding for it?

Otherwise,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

