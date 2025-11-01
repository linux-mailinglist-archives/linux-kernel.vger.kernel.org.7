Return-Path: <linux-kernel+bounces-881328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7811C2804A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4AD3B33BE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F33F9D2;
	Sat,  1 Nov 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1s+v6YP"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E31531E8;
	Sat,  1 Nov 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762004490; cv=fail; b=AaA1oVWLhJjJZMF5f8/EUV0ThSNd3V7cc0CdYFAuJRIT9y9d6UB5Ctuh+2vx0gS54cD5Hhh5slnjIEzq/j28ms0cLGgJj3gowQZOSq5Ozr57jWH779NcqKv6QWqcDNl8D+LvTVS1WC83SlrKUjmlpa4Lg7OLPfCvzlEvrKIFFsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762004490; c=relaxed/simple;
	bh=EnbZhUybhChOHP4WSaLvcp9UkwMGg8nSGKDILNK9ah0=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=gpAjKG0WleI1Knw/3OaPyWr3iHWpVax0AeHR/GwuNR/UOQPcie/++/04RKXupn/NIKcl7tB0YW1dcvQGoCkjspCauhS/ejI37MXE8FO46mrwm3IEx3jszm7P6HvBxqyFl1KF3/tyF/yGTXf5b9jwQ3YO1iRxOqRPKeerEShMHIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V1s+v6YP; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfai+uCYI9ODptfHBHytJpdyIGY9dE82dLdKiWzVmNAFUc34u5RjzPU9gah3q0z+MPhxCDhuMMGbgQob3QDZgU1pst2KTLTSVWDOj3VGk5E3oGn5smuKort6i9VlSKsS+eSQbbjRmg8ajM5JVOCaqQSn0S9In5/cim+Rpa7aW2pcYGCbv65fqWnvNKYr0qGFX0R47EGmHns+rSpiri6/A0msuXFELo2dxQOyWOa/RbJo1BgRcfGl/seN5MadvVD0E6HXW36TY+t5/Z8gfn4Vo1OXkGJpvRMgCu0NHtqQaruGT5uod497U0n9rflFOFe97puvMLvvmix0M+l6yhTw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDpUf6Y7UEk1KOPZLJwxRZMdouHmjltknRMTyupzuiU=;
 b=qf6d12xdKB39WyyccZ/NJ9dxAvp75ZcB4ShPtn5RgZHQta1VJHut4tYNMHATEfINU3mOtTAAjt34bOlOSw0NuwulUIC9g4ZGRQlWo/2ojw/y5E7+IOZHkNI1m/DaegDggYTtWXVFovzw/Dsrhu2gnptccATvDaYTP/Uq/sBT+HFnb0A4tkDRxokatLoZ7nozk87a9tomdmSjO0CLB7E/Al2E2UmX0sUSfkNXTZd9tBYTKp4LjAvdcSNCH/wBlEczQAaptDm6PbaCCRPszBAcd7zgAJiRhTf/Lw3DYkbagLv8zxUlyWSFfF7IQtm3pj++AiAl6JMLkjIFb8wZeSFt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDpUf6Y7UEk1KOPZLJwxRZMdouHmjltknRMTyupzuiU=;
 b=V1s+v6YP8UP1akdiwp7EZHQ5iXJhLQ5La0Xc5fQrxB26HBhG7R4Eyczv6ALPE4Lo7pfhHoOI4aoJbBmlKByYLsWSZ53bFYcqMNkawQsPoSRdfsZiBu5/8yOVmbiZWgr0dqv8bvqZFecBpByq+rDFaWbD1obAveElxScTJSY7h5AYtCyPzanKDrm4dDfU139xM7V4+aTwzK4XT13ihmkec9EPIdc3ppqvrOC1c7edPlHEX0lDiB5TLqiLK6rY6I2aDNJNeJc/LMw1X7Wo3Q08y7jux6uhdDZvEpeSxtlc16DwdSWKC3NcHkXMNLOt41G9KWk6rmWn1XmRW5l/iWHbJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 13:41:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 13:41:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 01 Nov 2025 22:41:21 +0900
Subject: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family of
 methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAOBmkC/yWMQQqAIBAAvxJ7bkHDovpKdNDaag9paEQh/j2p4
 wzMRAjkmQL0RQRPFwd2NoMsC5g2bVdCnjNDJapaSiHRKFy8281zUsDD08I3NsZ0XaumWSuCXP7
 6uw5jSi+u/wYXZQAAAA==
X-Change-ID: 20251101-b4-frombytes-prefix-6bb9984cda4e
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OS3P286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4011c924-ff63-4dea-44e8-08de194c5a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVArWHFrL3l0L0lNTlVRUk4vZ1dEZitkWHhTSDZrYWpsUzBjT1dwTjE5R0U4?=
 =?utf-8?B?ODdMandaWVVkYlNWZmdOcDJNdlhCaU9qQjRIUlc5bXhOR1ZQaEZmYlRENEdp?=
 =?utf-8?B?OUFkbjNZSlFxbDJES2RmQXZyVGlyM01zckgyQzhjWUZiV09IcWw4T3dwYWVk?=
 =?utf-8?B?RkRhVXpzdHg2WmR2Z240bTNtQkUxQWVldkR2ZUZXQXNndjIxUnk5NGFRZVZa?=
 =?utf-8?B?b0tidUF1MDhPaXFZSHlSdnB3SEZwQ0NxUk1KbVFVMmNrakJOZE95Mzlta1hm?=
 =?utf-8?B?VFV5ZmFUYjVXVXBNNzAvK0kyVi9uMWZUZ0Fxc0N4c2NJbExmUVBabHNIQ2d1?=
 =?utf-8?B?bmwraFNyQVdtdWdsbVp3d1o2MmtuREdkd2xDbmd1REVob3Z3Ukh0RjBFZkRH?=
 =?utf-8?B?SkhSOGpUeUs4Zzd3ajhldFJZcHY1R3pxbll0ZHRFazY5SjhESDVoVEJEdjZo?=
 =?utf-8?B?Qk9vZ2JYaThIak1pSW4rNEY1dC8rV3EyMEg3a05FNU8zN05MTE9wYVRLbXNp?=
 =?utf-8?B?OTFJY1oyRm40KzBBMWFZSkM0ZHpHVTVoWlF4R3NXNG54L3QvZHc2VDBDRTZ6?=
 =?utf-8?B?MmJKNUpzRzRBVnN3Rkc3bUJWeXFCNExSZnN1WjlGQzVSTnpvTWsxR2NiZ3VH?=
 =?utf-8?B?S2dyYlJ5V1g1NDdKa0hPK0NNc0tqUmFiSk44NWE4UTVDK0Q0bUg2ay9xakVt?=
 =?utf-8?B?RnlZMFRJYXErbzh4TUM0YS8vNktWSWErRllZVDkrOS9JMEtYS3RKOEVza1N1?=
 =?utf-8?B?Ym91cnNvQjRuK2tWY090NTdBMGpQcWxDbWNYV1M1S1RxVXhXdXlvZnFqenZp?=
 =?utf-8?B?bE9iZEszVVVtZzQ0SitBY0xDM29XTHZkTDR0bXNHamZxYjFQVjFvZkFrRVNP?=
 =?utf-8?B?cC9JdGZIRXVZVUlnZjVZazhIZlVLNFJLaDJFS3ZsS09RWXB4ODVPTnZaNm91?=
 =?utf-8?B?Nm1TSGhvSXVLWmdwdElvRzZudDBiMTFxZFdJdXVlSExGbHZRNEVBVjlQOVlK?=
 =?utf-8?B?bm50aTdvcWlUSVdZWFZ4TGp5Yk5BK0pUK203c3FGd3AxWXFrTHE4blU5Ynhy?=
 =?utf-8?B?dWx0bHZQYzVXa2Y3aThiQ0hXVFkrYzNYTHByVU1RcmhxVWNhRXk1b3Fhak9t?=
 =?utf-8?B?Wit2MFdGdzdOZHRhbURoUkphRzVHSzlYTkR3L1kzd3QzK0tQMlRpc3FWK2Vs?=
 =?utf-8?B?OXR5b1h4ekdKL1R4WnZxOXQ0dzZLL2ZIaG4zN3lLZktza0dFcm5ZbDUvc0Js?=
 =?utf-8?B?TERoVVN4c2ZoU0dPYUpxYjEzQjFXU3FlZDlCL2FrNXNTMUZmMEIwM2lBREo3?=
 =?utf-8?B?TjJsazlJYTg3Y3NUcmxjYlZrbUlUVnV1STYxMjFMMlBkSmtueUNxeWZoeEZI?=
 =?utf-8?B?bEhQS2VMUHcvdG84aGxiK1JBNVZmcktZQnBhd0drMnpTT1dTcU1yd3FaK1Mz?=
 =?utf-8?B?akU1S1JuNW9BdVhTc21QUGY3MVFnOHhTaWJ3VGdYT3BRRFZsdytWOU5rSjNi?=
 =?utf-8?B?VGordmFFZnJ6RitNZmtkTWlRS0s4aTV3THhIZmZvdmtNQk8yWHV2eEFtejRE?=
 =?utf-8?B?UjRZUjBkZTR5WEkvY250THU4aHdyWXphc2g0UThmQ1gwZnlqTy91ZmRBZzkr?=
 =?utf-8?B?ZHFVZWwzQW9lN0paVWFBVllZbGZEeHJVd2U5RHVha0ZDbzNPNENlcWRqQUtm?=
 =?utf-8?B?K2lJcmNtQjlLZjlZbEY5Y1lsWWNhcXY5NHJUanNycXBhUkJZVWhSanRCSDZD?=
 =?utf-8?B?RDE5VzhLTEllazNISkJUYmIyY2ExbHlyMmowMDJFMXpYT2RtQldrRkhKOStF?=
 =?utf-8?B?QXExYmszRWpKMWhISmQ5LytuQlNxSDV4THJZcVpweHdENjFGYXdxMkwzWjNj?=
 =?utf-8?B?aVVnbk5uczdvbkZhcDdwK3VqN1ZVaTZMNGpqYTBXTjBwSlNEQmJySHVOUXZy?=
 =?utf-8?B?Ti9LRmtZSHFiUDhLZjFlZUpMS2cvdlphcWp1Z2dNOWdsWlFnajJsWVRzNDdj?=
 =?utf-8?B?MVNlRHZjajZxd1VpekhKMzdZUGs5b2Y1clJTS3M2cVZPLzNndEh5UUtWQ0dw?=
 =?utf-8?Q?1I4/Za?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU96Q0IvWTNjNEo4WG5keXBJd3Z3VGovY0NVWTZnekx2TEtadkpyMzhTU0xu?=
 =?utf-8?B?aDdJT2pTUnpBaVJ0MTViNzFPdXp2SGJPU01nRVR5cFFaaGlWVG1ZZElpSDJO?=
 =?utf-8?B?azN4c2s4U2FwWkI5RHc4WnNkMS9zaFkwODhIMDNGZDRyaXNaNC9ZNEJTVmxO?=
 =?utf-8?B?QTM5MGJZc1RqQUpDR1AxV1BMNWhqb3ppaUNLSEZrWVpmVVBjWUFVR3BxWW4w?=
 =?utf-8?B?R2lsbXNSM2JDZHY5TFRybWdiZ05JaXg5c3MvVlRvQlhSZWV6MUFOOVFjWjA0?=
 =?utf-8?B?dllRVzVsRmRiMUxyZFliaHQyT2pWVFJWREJMT1hMOVlUc0ZFT0dvWWN0S2ly?=
 =?utf-8?B?bGFwOExRczZrRXYrbHRBQmJWa0RBSlNqUVk5UnFTVTRVZlFBd29zZG5hQTNO?=
 =?utf-8?B?bjJ6SHhoT1dMNXRuaDVEWk5KVlEwUm9HMTlVVll1c3owMTZCTHp4TUx1Zk9E?=
 =?utf-8?B?T0l0VFc1SzR0OUNwWGgrNkVXcGhScWhTUjkwdk9PNm90STIrYjUrT1kxVHpx?=
 =?utf-8?B?VWJCeGlUN21oMFJ3QUlFSUd5UEExNVlQYVkzOU9pVmFaaDBIMWZvUktPVnhj?=
 =?utf-8?B?WkYycU81M3cyOTJLeVZhT1Z2aSt3dzFmZzV5Z1RpTUUrY3RqWHk3SFhDTzFt?=
 =?utf-8?B?MUViWm1rVWtzT1F4ZVJ6K2I2Uk1wYTlUVEdXQ1ZRanQrNGhpc3pHRkxVRERr?=
 =?utf-8?B?K1F0K0dLMzJXK3hZS0hWY1BiT3J4ckhVWkNGbFF6RkFRRGJwaUpuNVNmM0p6?=
 =?utf-8?B?TnFNaC9jMmlHTnpzcjgxQ0lLL1RUY3F6d1hjQWtEV2JzdFN0Um8zWnFsT0RH?=
 =?utf-8?B?NG1mb1Q2TDh5K1UxbmVGaWJxNGlRQThkWTI1bk1pV3pxTmdibkpzek9ad2dU?=
 =?utf-8?B?RlBSdlBUZHNEaUtEUE1HTzlDN2JtVklPVzdsY2JGeGFoTUNBQ1FKYUlOYmY0?=
 =?utf-8?B?NjRhQ1JUSkpGcjY0alNvdE9yRXNjZElDQ0oyWG1HN0FmbGRBK2hSN3h1dnpo?=
 =?utf-8?B?VUN0SlVydG00d2UwenBiTGZFY0VpNFZSUnJwTzJCUWpzbDF6aUhZZTZ3SWZl?=
 =?utf-8?B?c2ZJNnB1VldqZDBBaWMyeG5abUxlb3ZldHI0VkE2QVNiM255d2dCa1dDUXRq?=
 =?utf-8?B?TEY5Vk53cGxpRG5iSURSM2JzSTFPZStUSWpGODc1RTJWaGM2RytGazNGL0ZK?=
 =?utf-8?B?U1QwbWp5cUVTekp3UmdRZjNpbWNyajYrU3JGd1dGVHBybGZmNUphV3RNVzQr?=
 =?utf-8?B?VVFEMEhKZjNKcEZlZnk4Wkh2UjJ0QnVlbUswRCtXai94VUxPdTRsSDhzT2s1?=
 =?utf-8?B?TnI0aDNDUHZLdTVXQjV6NFpDMEg1THFSZERHRE5OeXBUbTZBaHlUbmFyNkw1?=
 =?utf-8?B?bzlZTkxlVDZlU0ZKdjcwQUppUXVYak1HMDdkNjJQSVBNdUFBQ0x5WEN5T0lj?=
 =?utf-8?B?b25hdS9yTTBwMzRSK0daejFGcis1eGhFR0VKVGgrOTZ2UFhTOFJpSWlXaExj?=
 =?utf-8?B?K0JNTGorSi9NeitMa0VlZDlIUzhQTDM0RGdXazVkcjVqUTE2KzBITVgzOERB?=
 =?utf-8?B?U0xnZENEaUZxZW1qdnlFVzlDdWZyNjdXQm1pNUdhaTFhMUZTU0wrb1lJbjcv?=
 =?utf-8?B?QkZQR01BNVpHbHlia203dldhN09senBFTnhyUGpYL3FvQjBjaThVV1BncnJX?=
 =?utf-8?B?SHNPMWNtek42ckJsY0ZxNTlIWWdHVTRZVzVoSWZFcCtiaFh2V0l1RTBwK2tV?=
 =?utf-8?B?TWVZOERQbmdvQ0dpR2JhdndRN2pRTFpmSXNQMU51ZEUzdys4R215TWlLQ1hI?=
 =?utf-8?B?RG4wdng0Tm1HVUpEWXd5eEFrNnNTMmN2MlNJcGdENmxFQzdQTUQwTUxFNHND?=
 =?utf-8?B?cUtoVzRONVJIRFc3VmhoTWcxS0d1U3Z5MUkyOUwxOVhKSHdEZ2ZLUVdDcWpz?=
 =?utf-8?B?eG50eFhXZHBOWTJuVGRlb2UyMENtREdpdlcyMHE1TXBYc2UzYmFERjVUZjhN?=
 =?utf-8?B?UHl1eVZBQjBOcmFjSktHZktlU0xJV09zYWcyalZvYWFJN0J3OTlGMER6SXZm?=
 =?utf-8?B?SzIxQk5uL1hLNFd5Wm9iem9EQXZCOUI0WHBKaGw5Yk1HT3IrdzhNa0ZKYThZ?=
 =?utf-8?B?YzlTRzVyRTluWlZma28wbElBSlZzNmZ5VUhaTjZmN0tBNytiWi9qZXNzTFpF?=
 =?utf-8?Q?tjITIb7DTLnJ4mC6Xfvh4jIRdax1Pi6b5DfsYClcvfay?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4011c924-ff63-4dea-44e8-08de194c5a30
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 13:41:25.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65bMLNsBJw+Kzw6vC+kopFK2pzBaKMIiQFnX/ATHxkD+KuwNQ+r9HWuMCSqdX25O7xZeGw2RFp5OIQuPE5YDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776

The `from_bytes*` family of functions expect a slice of the exact same
size as the requested type. This can be sometimes cumbersome for callers
that deal with dynamic stream of data that needs to be manually cut
before each invocation of `from_bytes`.

To simplify such callers, introduce a new `from_bytes*_prefix` family of
methods, which split the input slice at the index required for the
equivalent `from_bytes` method to succeed, and return its result
alongside with the remainder of the slice.

This design is inspired by zerocopy's `try_*_from_prefix` family of
methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This patch was part of a minor Nova cleanup series [1], but since it
requires attention from the core Rust team and is buried under other
Nova patches, I am taking the freedom to send it separately for
visibility.

Since the originating series makes use of this, I hope to eventually
merge it together with it, through the drm-rust tree.

Thanks!

[1] https://lore.kernel.org/all/20251029-nova-vbios-frombytes-v1-0-ac441ebc1de3@nvidia.com/
---
 rust/kernel/transmute.rs | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index cfc37d81adf2..cbea8ab10a2c 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -58,6 +58,27 @@ fn from_bytes(bytes: &[u8]) -> Option<&Self>
         }
     }
 
+    /// Converts the beginning of `bytes` to a reference to `Self`.
+    ///
+    /// This method is similar to [`Self::from_bytes`], with the difference that `bytes` does not
+    /// need to be the same size of `Self` - the appropriate portion is cut from the beginning of
+    /// `bytes`, and the remainder returned alongside the result.
+    fn from_bytes_prefix(bytes: &[u8]) -> Option<(&Self, &[u8])>
+    where
+        Self: Sized,
+    {
+        if bytes.len() < size_of::<Self>() {
+            None
+        } else {
+            // PANIC: We checked that `bytes.len() >= size_of::<Self>`, thus `split_at` cannot
+            // panic.
+            // TODO: replace with `split_at_checked` once the MSRV is >= 1.80.
+            let (prefix, remainder) = bytes.split_at(size_of::<Self>());
+
+            Self::from_bytes(prefix).map(|s| (s, remainder))
+        }
+    }
+
     /// Converts a mutable slice of bytes to a reference to `Self`.
     ///
     /// Succeeds if the reference is properly aligned, and the size of `bytes` is equal to that of
@@ -80,6 +101,27 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
         }
     }
 
+    /// Converts the beginning of `bytes` to a mutable reference to `Self`.
+    ///
+    /// This method is similar to [`Self::from_bytes_mut`], with the difference that `bytes` does
+    /// not need to be the same size of `Self` - the appropriate portion is cut from the beginning
+    /// of `bytes`, and the remainder returned alongside the result.
+    fn from_bytes_mut_prefix(bytes: &mut [u8]) -> Option<(&mut Self, &mut [u8])>
+    where
+        Self: AsBytes + Sized,
+    {
+        if bytes.len() < size_of::<Self>() {
+            None
+        } else {
+            // PANIC: We checked that `bytes.len() >= size_of::<Self>`, thus `split_at_mut` cannot
+            // panic.
+            // TODO: replace with `split_at_mut_checked` once the MSRV is >= 1.80.
+            let (prefix, remainder) = bytes.split_at_mut(size_of::<Self>());
+
+            Self::from_bytes_mut(prefix).map(|s| (s, remainder))
+        }
+    }
+
     /// Creates an owned instance of `Self` by copying `bytes`.
     ///
     /// Unlike [`FromBytes::from_bytes`], which requires aligned input, this method can be used on
@@ -97,6 +139,27 @@ fn from_bytes_copy(bytes: &[u8]) -> Option<Self>
             None
         }
     }
+
+    /// Creates an owned instance of `Self` from the beginning of `bytes`.
+    ///
+    /// This method is similar to [`Self::from_bytes_copy`], with the difference that `bytes` does
+    /// not need to be the same size of `Self` - the appropriate portion is cut from the beginning
+    /// of `bytes`, and the remainder returned alongside the result.
+    fn from_bytes_copy_prefix(bytes: &[u8]) -> Option<(Self, &[u8])>
+    where
+        Self: Sized,
+    {
+        if bytes.len() < size_of::<Self>() {
+            None
+        } else {
+            // PANIC: We checked that `bytes.len() >= size_of::<Self>`, thus `split_at` cannot
+            // panic.
+            // TODO: replace with `split_at_checked` once the MSRV is >= 1.80.
+            let (prefix, remainder) = bytes.split_at(size_of::<Self>());
+
+            Self::from_bytes_copy(prefix).map(|s| (s, remainder))
+        }
+    }
 }
 
 macro_rules! impl_frombytes {

---
base-commit: 9a3c2f8a4f84960a48c056d0da88de3d09e6d622
change-id: 20251101-b4-frombytes-prefix-6bb9984cda4e

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


