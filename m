Return-Path: <linux-kernel+bounces-773455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85997B2A07E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22FA5602B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2A26F284;
	Mon, 18 Aug 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1D9vER5"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190431B108;
	Mon, 18 Aug 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516506; cv=fail; b=G2M9KbqSQqOzDFSlhkZQVlVlbYtrGY5udxZLZS1InucG1lxVLtkCiIdEA5ZAdZ83i0WogrJkCZCleF+1020Fn/No0hluIAlO/fhYedfFUg+IPDXiBi8O0Wv8G1Asfjkjb8TP0FIg3M2nm6FPYkdiiFEId6xOw1tdEMNc/3oa/UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516506; c=relaxed/simple;
	bh=ZitthbqWkJkL6YasGMWH28GCnZKME53x+45FZwZJ17M=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hg3IeXZmXRywZE9nSO/6yrSW5Q4Mi/BOt09ZOfo6LkKw48pxSmpclzgDux4+ckxeXaMPNnLQOL1/vuEByIXDmFIAIucps+2zK9R9Jm6O9gfWJOe8epN3cVQnLQ82168W6+8Wbbtx7gI5JeiBv/oZG23Ti0AIH2Ci6aomdTTs7nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q1D9vER5; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWXp6ghC4B5NDihhUEHaTIt+/fi1soifqNDs6jwiodaBxGjS17DOoYaU8DDb+U0tiKFP0G1NCUuNsiwRB6NuUOg8lAnYH5Oc/x1RTqcSF0tDs1N8eJ0XCfVrWZoeBO/0JtV8iFHx8HWgq/eNU4C/FMzJ+iVP8eqYYQkXYr5Xreno/+R8yaMUMGxHZW0R3eV0jFyjQ47rsaDDy+6l37IsfZTGF9dHKsRjd/jETGr05SM0bBLwk51R7oG4G5JxYj9BFiW0ChzvbY8ibFCiUjn8yWtevYPCo3Chc1y5Aavp0Fs73+/f51hOU9ClHmLeDjAW8sfstPkhqDp5HoPjnYvhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmVWOgf2O8eslEStxJRsg1jMOYc3eLoxOnKKIuOwcnQ=;
 b=KM11QNRxwSsubX06e6MSciFgtqdd/7j3nNQ6Dh/tjE3R3Jrfk3qmQRAyMGuGkrBN8OFwpyuXb1PJSzAH+plIKd20wXw75tbebA8amnqPMzt42H2xvaMnx6H54g/NylVME1rbtDrqdbMKWtZuGOdG6xhfxfYT5RHjFd6xGCegQMtr+CnjBNcXGiYLWWimyq3XP5+9jWCXB3XxaWSmH7rtVpqjTMwMwAng9NfvgdchLV24hmlzrlh92feZEh9g9M7mYRHler+7ulxbWqpUXM/5SCMW5ayVFi3s+qCnevE3uo5otDDAE1y/vlpzz8m4tgR6Mw3QISMjuniGAK1cCFZdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmVWOgf2O8eslEStxJRsg1jMOYc3eLoxOnKKIuOwcnQ=;
 b=q1D9vER5W7GUROpcOBgOP5YeSjxGJq1GabhuhjnfgTHPpHFOQXpsYnHwR2Bn6ccWcyB9j28WhCYkqOKNgykxrROnDN7CQSwdqUwbmO0cFZwzRX1nWtIOn+0GK6CeFKMwZYgNLLhFcujoQ/AqIM/xAkg6O8QKZzmXszBt6G41uV0RwZ2pWOYj0fGCpuPBdkBIV7Xv3GLs+kkDp1Je8beLziFcT2dqIeLoWOy4ExnNWeDiTb2uxDiGQ5fhwkFOFS+AkXijaaq71QHDpHm32LbvtlLpfJRIfTLnlqCuMnneYRVUnSNTHLFhk6gl8kcX33nJQseobvAObYF1k1/XOXuqqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 11:28:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:28:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 20:28:18 +0900
Message-Id: <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
 <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
In-Reply-To: <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
X-ClientProxiedBy: TY1PR01CA0188.jpnprd01.prod.outlook.com (2603:1096:403::18)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a75e7bf-75b2-447a-9f9f-08ddde4a5610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEJmZG9BaGlIYTFIdjBzaDlXdW1lc3hJMXVmbHdRckV4NkoxaGgvTTg1S2ZX?=
 =?utf-8?B?K0p5OTVBZnZ2Zk1PYlRMZG9LaUlpcmxtQlkyZlVPVnpoclNMRU5mMHBQT3Jz?=
 =?utf-8?B?WWJNK0ZPNi9kS25BZHFCUEdmY2luTFVETUk0TW12REJHbnFCb296alorK0Jw?=
 =?utf-8?B?dWMvb2tuSDNIQ3RFT0tqMzNIV0VxWGk5REVDVnhWV052bXhPR0hPL2FCT1kw?=
 =?utf-8?B?Mkk3d2tOaU4zekVCZVVhajNSVXVqbW9GT3R4RU1tc1dZQVc2WGVOUU5yMG1L?=
 =?utf-8?B?STAwSXl4RHU4OWpvMmNMS3JBMWZwQ1RaV0wvZFV0aU44eWpSZjg5UUpLenp5?=
 =?utf-8?B?OG1GT3laTlVSOVAxcHZ0OVorN282VUNtVWwyK3BQUkQxd2lXeklUbGhDS3h3?=
 =?utf-8?B?MThEK1NDWGp0bng2UUorSnVMRlJ4KzIxYTdvTzFYOFg0cktsTnhKMWFPSjRQ?=
 =?utf-8?B?ZHdZM3lPVmpyckVBQ1EvR1R3eDRuL2QxT041b0lyc3RkS0pPdkNHRUcwUGZF?=
 =?utf-8?B?aGx5U3FzRjF3YXZITW0ra0VnR1NXUWQ3Q2g2bHdvRk5VREFkdUZPZGU0cnBn?=
 =?utf-8?B?RGlBMUV6V0lNZENzTktYUXRjQ0hFc3VyVm9NSzQrZWxsdnFWT0E1OUpVNWRO?=
 =?utf-8?B?N0ZGdU9TejczTDZETmgzOGVPdmZETVNmbGV6MmpxL1dybC9nVGtidCt1alpR?=
 =?utf-8?B?cHhPL1BqaU5UdFNZdjlodjY0ZjgrTXJxa3VITTNVamN3YVNwckx1VUYwWFdz?=
 =?utf-8?B?dHgxbVR2cEo0b0VMNUxmamxDdVY3TEMvN3UzRks0ekY5d0F1Z21pRFVUUVhh?=
 =?utf-8?B?Njl2UVJ1cG1sNU5YUWl1STBNUHNOWjBjclFaTVNYL0lYcEhpb1BONHlYZ1FG?=
 =?utf-8?B?Ty9DbElYY0RFQiszczNYeVVUaWMvN2NwbXRvOUd3cTRkUk1XQ3VDOVZWa2Rz?=
 =?utf-8?B?TDRob2x1S2ZyTDIzNWE2YWJVYlQ0cHMxWjVlQ0lTUW1hb1k2Sm42T0RNVW5r?=
 =?utf-8?B?S3BCSDVseVlKTTN4emp1RzhhWTFYNkwxZnRjZlNYTkJOOEJCZjBMeVNVbVI4?=
 =?utf-8?B?amsreVJ5VjByMzlvc205eW1zcU1OOXZsbEFSQUsrdVd1eHAwYXlMcGxPTDJn?=
 =?utf-8?B?VW1CQ3dpZ3AxNlgxOWNSZ3E2ZmIzTW92Z0VrRXBRQ2t0TW42UHpyZndHSncy?=
 =?utf-8?B?YjN1VzF4N1FNN2VIbkNrK0t5UVBqbFp0MGRRSnRKSlp5YlIvU1ZnMzdKUHYv?=
 =?utf-8?B?MEtjMVBqNWJqYzBOMUE3SUF4UjN5aEphU20zTzBWUmFYRFRuOHVuaEN2aERw?=
 =?utf-8?B?WldzWkFOMjF2VmpvRUozNWZwSUNWQ3VHWmk4dU5WaHp3WWY0RktBaWhvZFdl?=
 =?utf-8?B?bmNLV2R4T2ZQNDc3K1FTV3FXTS9GZWR0L1g4SDloY2NSOThqUEVwenl3QnI4?=
 =?utf-8?B?RlBKOFRsWUZLbit3V2loUndpZW5ETlNIaFhpcXhRa2g2S2tXQ1oxNHA3TEZO?=
 =?utf-8?B?dEo5OE02ZXoySC9Vd0dMemFyZHUxTmR0cHNlMzFwVkpLQ1hOR1d6QitKZE5C?=
 =?utf-8?B?U3orMytEKyswQlZlc0ZDbVVKSHR1eHJVVG9sL0VwdmM2TzRVOXhGNEVLN01B?=
 =?utf-8?B?Qm0wSWpQTHRsd0VPWUwxU21xUG1BOFBKc3Z5cGxPUmc4ZTBQTFA4RWN0Ry9y?=
 =?utf-8?B?SnpTRkROT0dmT09QNmlhZGNPdmVPRlVmU1dVM0ExK0hqNlBpdWN5ejFBaUtH?=
 =?utf-8?B?WUMreUtWMWFSbnhITVhiQ0g3ZkI1QUt1ZjBkT0dhU2F0TForeUxiclQ1NHlL?=
 =?utf-8?B?NU1TdHkxRzQ1Z05wQkxjMkdEWFRwdks2bGQwQTMrYUJvVHlIb2lBSXcvT0o2?=
 =?utf-8?B?YlVJUHppejc4R1JOWTZHb3FtWW5vSEprTTY2blB3emo1WlNIY21HanAvY0lT?=
 =?utf-8?B?eHlOYnloU2p3UEdmaTg0RGZEMHU5N1ZPZ0UrZzFpODMyWHRFTlYyVmFiTll5?=
 =?utf-8?B?Z1RXUzdTemd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXV3eGl6M0FNV1B1RDhHZlVwN2RkbjlCcy9uV3JtYnVERGpnOVJ5RGd3Y2Qz?=
 =?utf-8?B?Szd4RE5VNE9mM3haZUJnU2FXcHI3T3NoalUzSThpc1RlUFBnS2tKcGFKUmx2?=
 =?utf-8?B?SlhwbEY5SVVDbEx3Z2tKRmZleGx5elJobkMwU2g2bkRuZDQxZDFkNDd0ajls?=
 =?utf-8?B?QUJxYzJZRmFOMnVDbHpTbkdPeUh5dEd6RjZGYTEwQXkzb3B6WE1xa01qSnhK?=
 =?utf-8?B?U29CMUo1WDJJNXZKdzZFb05yVEVLdWM3SmtQUXE0OWVFUEx5amNvMWRkenVp?=
 =?utf-8?B?Tnp0U3JadGhLNG80TUJGT1REWVA1bDZ1L3lGVEh5Sk9meFFYT1RCbjIrYlVv?=
 =?utf-8?B?aW4wVnVNR04yZ0FTRUE0dlNMdzdKbms2MisxWGxsZmdpNnROalNsY2lSc1BY?=
 =?utf-8?B?U09oS3BJNzNBZ1Q5Vy9YcW80ZEprRDBHVThyeDA3dU1xVHNyaERNSEptRXhX?=
 =?utf-8?B?WnQ3eHVoMWNnWC9CSklyR1d4V0VsekJvdm9MZkR2VEIvWUc5NGxxeHZNK1Fu?=
 =?utf-8?B?bTBGQmQyRUdYZFVuSkowdTdjMjE4QkhGcE9aY2Y4S3kyV3lkc0YxMU00YU9n?=
 =?utf-8?B?ZzdsUXNFRmxPelZkZ0YvcjVGQmhXcGRTbmhHT2wyOWp1RTBOMnpJN1ZiSWVj?=
 =?utf-8?B?KzF3SmJpb2xPSXVsNjUvamkzcGp1bUVVbGl3VTd6RDU2ZkxtTk5jM2tUZVRT?=
 =?utf-8?B?OHl1WkVHTUJaQS8vVlZvTTVScXlBTE9xYXltam5USjR1N0FPejZ2N0hPRU5K?=
 =?utf-8?B?YVg3VXA5clFCOXlDeG1KbGl5QWdCZm45T3VaWU9sSlpzeFJBL0NZS3RPZHN6?=
 =?utf-8?B?eHA2Tk5xRXVETnJuL0hNSHF4a1FNRElqQ1ZIaGdEb1p0NFhHOGpGdlZ6akxy?=
 =?utf-8?B?MGhZdEU0aXRmcDc3VnIwM1J2SDdWd0UvS240N2tmUitLNnB6b2h0cGtWc2E0?=
 =?utf-8?B?Q2hSRFNKei8yUWM3ZU90Wll5TTgzTDhYUXVnWndQKzd4SjkvVnBEc1Y2Y3Nu?=
 =?utf-8?B?emx0bzUvcTNNWm5zRk9CT3hQNmJxOENLaDhXT1RET3RSVVY4UkszOUtJL29z?=
 =?utf-8?B?QzdBcGpwNnhWMkdZOWxjNlhIekpqMk5tdlNuYmlFalZnUWFmaTRlU1YzenJS?=
 =?utf-8?B?Q3duTGhsUU9HUzIybzAwT0llVlNkU0E2UUNvb0IvdkYvMnEvaFpqVGRNZlV2?=
 =?utf-8?B?WFh6V2U4V1Y5ZU9rN214YXVtWGk0RXVpNFN4ZDhIZ3gyWUlqV3ZDMXR5Y0ky?=
 =?utf-8?B?UzRIb3o3VE5ZdHQ4dDJab0puWHN0SnUrSm8zZlZTNFI3YTVXcWxZQVRTWjN2?=
 =?utf-8?B?blY5S3lwanRMbDRUNmFrMXZUdkRxbHhCaTE0R2NDYnNJYWw3MzRhempzM0NY?=
 =?utf-8?B?WDRCdmdiWTFFZVdCdXdTUk4vdnVoUklMUi9vUklXS0srM082QXQ0ak1JUElI?=
 =?utf-8?B?dHZCKzVKcnl1c2NXS0VVaWtVcGZOYmpnL1Q3WWlnT2ZNcG9CeVhTREFUbTFj?=
 =?utf-8?B?YW5zL1VRd1RHUG5XTmU3WURpM2VEY0VmSkJHS1dpZW1pQ29JRnZtMmM1RTBI?=
 =?utf-8?B?T3FDSEZncGJaUU1wQ2pvTi9UMUtJc2Z3RzVtZ1JIQmZQTEtTRmRpOW1qV0FD?=
 =?utf-8?B?ajE4L1o4eVdJZU9wd3NBeVBCbmp6MWd6R2Uwd0IwU0NlMTdjNEthQnYwbUVp?=
 =?utf-8?B?NUlIaHJEbVNIZFE1V1RZVDMwSjJ1LzBJcEp0VFRtQkhoVklPR013MFRHclRW?=
 =?utf-8?B?WEVValJ0TWRTUlRHNWd5eGRKVXlCS3pXWE1pYUNDak9iUnprS1RYc3RpK0Nh?=
 =?utf-8?B?MG9iTStxa20xeVBMc2FYNjZtRzRpVzFaYWUvTFhqS2hjemFueG55Z0IrVndE?=
 =?utf-8?B?d2xvNGdnRXUyZ3EzbGY1cXZJZUtOdm42ek1EdXZYSnFhNlpSYisxOHNRVFRJ?=
 =?utf-8?B?TU1iUURyTUMwU0l3UXVXRkRHbFNUR1grNGErMDNDc09mbmhJQnRDOVEzSjIr?=
 =?utf-8?B?c1JSOUhCSE1PdDNGQksySEMyNmVUUXdtWXJ5Rit3SHl3dGpOd291bUVlRzJ2?=
 =?utf-8?B?WFNzemNYQnBKS1lITnNuVXhvKzk3eElGSklWaTRibjl5cWFXait3bUlyQUVx?=
 =?utf-8?B?OWx5N2RYV1U4aE9tSTg5clVNNXRhSFpvT1VHUDc5RTNkM3ZLVWlVK2NWR2V2?=
 =?utf-8?Q?kSEF9ufboc3+KsSj9LjrsXEaHKgAjmri48jkK0/Pf9UP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a75e7bf-75b2-447a-9f9f-08ddde4a5610
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:28:21.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxp+Dz7Klds5XPWMPMATwhtnGYXfRGZ05lpXeOcjggz567KtwNJZmHrN2g0ed+OMVnSudy1O+a/QgjLOOxrASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

On Wed Aug 13, 2025 at 3:00 AM JST, Christian wrote:
> Hi, Alexandre.
>
>> I mentioned it on v8 [1] and v7 [2], but the tests that break due to
>> this change need to be updated by this patch as well. This includes:
>>
>> * The doctests in `rust/kernel/dma.rs`,
>> * The `samples/rust/rust_dma.rs` sample,
>> * The example for `FromBytes` introduced by this patch which uses `?` wi=
thout
>> defining a function.
>
> Sorry for my inattention, I'll fix this in the next version.

Ah, as it turns out you might not need to.

We discussed this patch a bit during the DRM sync, and the consensus was
that it would probably be better to keep things a bit simpler for the
first version. The `FromBytesSized` trait in particular was not very
popular; a better long-term way to provide implementations for
`FromBytes` would be to use a derive macro, but that's out of scope for
now.

Instead, we agreed that the following would make a good first version:

- Make the `FromBytes` trait depend on `Sized`,
- Provide default implementations for `from_bytes` and `from_bytes_mut`
  directly in the `FromBytes` trait,
- No implementation for slices for now,
- Consequently, no user code will break due to the addition of the
  methods, which is a big plus.

The simpler version that would result from this covers all the immediate
use-cases and would be easier to merge, which will give us some time to
think about how to handle the non-sized use cases (probably via a derive
macro).

Do you think you could write the next version along these lines?

I feel like I misdirected you with the `FromBytesSized` trait, so please
accept my apologies for that.

