Return-Path: <linux-kernel+bounces-789309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D8B393C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C477AF9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E62798E1;
	Thu, 28 Aug 2025 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOpTkRpR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557671CAB3;
	Thu, 28 Aug 2025 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362418; cv=fail; b=cq+CCQRb91fT5qiQ3bOXI6vVrfyaaIZVVqvNV6c7wcJklJ/YLPzFyQ9lmkMwIrV2WSVNoOGoOnnmF3nqbO3gkYrHxPqU1w+5yE4AllODwU44QdrN1TpstISGjWjulXmpNS/S7Xn+5DZutqOOmDoOjw+PhiDuxtA1GjvJjnaB/fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362418; c=relaxed/simple;
	bh=IUR7iLGUG2imeovWIflp3QthVgcnQsBjGu26kMA0JmU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NSjj90oGTFwwNuWzAG5oyRl07fKRQVnXNGUwS0X/278yyFV4/MSGGKt6aeCkHYiQhUe3Pen2m5YtfT5bYccjKe+0m/P2wZIxd6Xd8n/JllGtwfH5bQivanbzQGVCbIFLN6h8l3PjQn9YCF2gnnkpGk/BAQwHbseVDGSsWfiNHmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dOpTkRpR; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6wNPVgA9jBb4PIDgScFdzqxNCRjxdiUbmJUrYbbmQqPiThfr3+4Js7Aba3T6nfi0O1f9JjhHwgjjAezHpUqLFGQsvsHu0D3hzy9W+79XkcdGBfHvAiVza7gDBMj55cduWRp0RaJBnJw/fV67CS4yAeTZ+bqz9yDzIE2MnSyaymskT8I5PfH18NK6FgFfbrsElLbNK1tEcQbHTo/vUl/HEsn6abAX5HkagVO3muInMog0AutxWeqyai09Z6nk4cZ42jHCUlPVpISKXgs70WAMipbTJleDSmbBHe37wcM+mXjII6NLhaYW8xAFNxRDFX74GG/5eE8zo5ovJ5mDD0yGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KglDMGZKg8fVvp5hwq7WOX6jfjLPkGulD5o9OQTuNuQ=;
 b=blg571oR40Y90kTdPMjvQi0WQ1BVjSC4ssOgtTGj58ylYO2mcSvk2Fe1eGhcAwd8unUByBfOM0HWaiGV2MizJoZxCD+/cnIfuVgsSGFYFbzfS0Rg94bF/y7+TqWMJM7fpZPAGHWm5JZOb8FDL40Mf2cAa3dGAWEaxTzM3dj3a1oNQ5WarqgyurB6A0g08b7RIN8UfuWlm1WExrn8wGCMvYhPDwURjrLsnlY9zreE4HsFYz7o8bxBZY9X7akSZLwwa6bTlbKzCQoaaBtFekvxwiMy5wBtXg7pJJQLKreHtZ9swt3UCHI6x24nLynxh7f2htzys/XDCQwxQWVqPur91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KglDMGZKg8fVvp5hwq7WOX6jfjLPkGulD5o9OQTuNuQ=;
 b=dOpTkRpRfAld9zeVdW8wGABo9qA6NI4a7orP5Hf3SGZ4vC7Gw5qqyM3rq3Ta6LL4utWfXHiOzrPv2cKv3gn1SRiG3Is3nOSWEpzw0BubP+GLFEvNOdHBELPdFMoFvVQk0b0TEWFh6EntuFe1Mq5yIKBT6OKT3eXugBWn9jjFkWNGqT6O7av1D4z6mz8gQX6DNTZywTP4F62wBpkSEeEo83kXErPldYN56kcB385gYxOrWWLbBhGSQ98xRhB5bT0WT/UFhkIDcFXycxUbR6lOQmu1i4ZrLs/9yh2fg4adK7pRb5EpnwLBE860R7wPtbWPpQA0Fqacn6xrTXIW+GPaiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 28 Aug
 2025 06:26:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:26:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 15:26:47 +0900
Message-Id: <DCDUIFACG791.3SCF7302W8JZ8@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Christian S. Lima"
 <christiansantoslima21@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
 <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
In-Reply-To: <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: f681e5aa-838b-4546-5cff-08dde5fbdf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdEQ0p0UVlXenRpZjNtRjNXcjdXTy9BUHJhbmpKS3RpWXYrcWVaclhGOWF2?=
 =?utf-8?B?eEtGcHVnNTlFVVVBL3hPb2VDazdZdlI5TG0yMXFaL3Y0UDZqeHhFWTQ1VGRT?=
 =?utf-8?B?U056RCtiUXlVT0FXb2NIMGkyNWlVU0RpVzdvSUdxUnV2TmRBaWNhb2g0N2pS?=
 =?utf-8?B?SlVlNXRmUW1qU1B1ZVdQS2ovT1MzVGsyNDk5UWtMNzZPSWpSWG1mNzFSZWp3?=
 =?utf-8?B?bWUrdy9WNGtPYktVZnJERjBwUUlUUCtkaHRqT1hFZ2RQTFJjak1QcVh3VzI4?=
 =?utf-8?B?S0pVbnFSZVQrQkZVb29UZmE4Y3N1RlZmZlZaUVhqUUZwbnBCSXR2cUNVK1kz?=
 =?utf-8?B?VTVucG1xQ1NmVU1JcUl5MnRGQkNCTHFoWjJuT3FRcVp4UWVEZEhWT3d4MTR1?=
 =?utf-8?B?bE80VC9rS2VtdnRmMWxMK2pxQWwzYTgwUjVWZldwbXpTMjlyNE1EbmFWS2Fa?=
 =?utf-8?B?NEtFMGpFcW1xSng5RlNaQjBsMWZLVi9NM2Nhdm5xODNwM3BWeUkxWnlFcGdF?=
 =?utf-8?B?RmFqMU9rSFI2NThZcE0wbFFXZUJraEZoZ3VKSnJIMCticFpvM1ZZTWR5VFJw?=
 =?utf-8?B?YTVad09BRzcrUlVmN0FnSmdSS1lDUGdGcC9pcDZHckFKejlwTlhkM2UrVzRH?=
 =?utf-8?B?T01vcVhxWXBOR3o1QzB2SFFqUHBMNkJaZ1lZWElRdjA4clhqb3RWcXFubG0r?=
 =?utf-8?B?bWpLZjdSby96eXRFWmh6YkNlYkxicGhuc2ZnZ1lWKzlGOGhyTnN5Y3IyMFNS?=
 =?utf-8?B?R2sxVHBHOUFENE9JeDRQODIxclVTQ2I4UlUyT3BwSjREMjdibzFCOTYyMmxI?=
 =?utf-8?B?L011M0tsNE9UalNwWTlldmtZTlhJcm0zVjY0SEFoNGFoeHBGS1orVXRqSVlm?=
 =?utf-8?B?REkybzNacXpuWHFLdzZDUU9DdlpPWW5sRnZNNXRNeGVlMlZ0SEpUWjQ2TzZQ?=
 =?utf-8?B?NWMwdWQwR3ByNElWbUVNL0NQbmtpVnNvZ0ZGNmg4TFJhZlI0cUI3dk1QN1cw?=
 =?utf-8?B?ZDBvbndvbWpVWHNRbnl3UC9vU3BoSnZZbDZPcTdCZ3dqRzJTdXdDVlhLTWRS?=
 =?utf-8?B?YUxsQWtJS1FEbDFOdEQraXVmazQrZFN1amZ5K0M3NFlBR05Ua1U3Tmw4V29s?=
 =?utf-8?B?Q2xJQUM4U1ZHcExnV0xLYjVuaWhYQUNWVlJ6aW9VMi9nTkRUQ01haVZJRFpG?=
 =?utf-8?B?d0k5VFNmQTVSYS9ORXlxUUQzV3JndXF5ODJKYTFWRnkyK3c5bkxMclYwQTRD?=
 =?utf-8?B?WDIyeVZmZmx1U1BKaDAxaDExK3hBWWVRaS9aME9Ec1NPZHNGSTdTVUVJRHdD?=
 =?utf-8?B?RVpXN0crK3pxaHhKUkVsMXo1N0s2Mm5qUGlRd0lPYjZVUmxxb2ZEcS9Oakcv?=
 =?utf-8?B?YU42RHdvbkhYMkpIMFJyMXBBeE9vcEtmSVgyeExHTVRTVjhkWHBQQkx1TWlr?=
 =?utf-8?B?MWhldHl0STAxUzBJNDJjQkZSWVRqMG94RFhsWlhFSzRHRlhUOWY1M1BHV3hF?=
 =?utf-8?B?d2FJTmxTNEljQnRuQlhyNjl4WnREUlpQSTF1OXJkVlRNNjk5c05ZcmNtSUVz?=
 =?utf-8?B?TkFrTVY5ZktiajB2Nnp1MHBIK1ROVjNLMzhNaWJFS3pES1pHdWdVOXJGYzkr?=
 =?utf-8?B?UVF2dzc5bmJ3eWdQdnZMMU5RSzlZT05xMHBYUkQ0aFhxUHFQeTlLeHdCbFoz?=
 =?utf-8?B?VVIxaFcyUUFPU0IzOG9EcUlJRHV4RXM1d0dXandENlNYYlo3K0lTVXgwVVJZ?=
 =?utf-8?B?dCtxdzcrWFFSempvQ3BGVXllU2pZNUtpcm1SODhFMmlSdmtNSXB3L29qZlZ4?=
 =?utf-8?B?Ym1vQzNoZytWc1FadSt3SlM2RzhUd1gxTGtpRG9XL2tONnBuMWxzRURyZ3Iy?=
 =?utf-8?B?L1IvVWptT1R6eE1OeDFZSEN6SUtEeWJaZG9NdXJlR216WDVMK2N6dXMzb3Zr?=
 =?utf-8?Q?euhxUvG0dnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNDT3hSYWw1UElFK2Z5YUpSQmFWaHI2aTBTQng2TmdJeDNLTlUvb0NWQXoy?=
 =?utf-8?B?Y01WL0szU2ZxTy8zZmF6ZjlBdmRvRjNpd0MvRnlzOVVucm4yUHhQbmFuc0lN?=
 =?utf-8?B?RmlVNGYyNjViWVBxMHhiSVdBRTVuQnliTGhxMFFQd1psN2pSMnFSQ21DNDA5?=
 =?utf-8?B?UXZPMU5LWXZIN1FWUklzL1BzcWQ3cEtQYTI5eTcxdkFNRlF5dHA4eGc0WDRn?=
 =?utf-8?B?NGx2S0g5MFFlZU1qbVVCK01ZSzZtdkszMXNEdmpWdUhsNU1LSXozQmk3MWJk?=
 =?utf-8?B?NC9CQ3FCeldwOG5KSHBReEpDd3NhTUEwc3d5T2pXdUc3QlBsWmQyRlZMdmJi?=
 =?utf-8?B?aGZ4QXVnVDg4QUVValdDSmRUcjlzdUVzLy92dXluZGc1aEVrL2UzSUJMSFcr?=
 =?utf-8?B?V0FoUHoyMWY1eUlTTExYZVUvOEZwcHBoTEpUR3A4Z016M3cveEo5Wm8veWxE?=
 =?utf-8?B?L1FvRjA4UzFtclhzNkVSUjRDd015WUpGV285QzRWeFh1Z1dhOHBkeEtWb0ZF?=
 =?utf-8?B?aWI1dlMycHBWOEZTRlBCakFvaHpEQmFXVS95akdoaEVnNExJUHYvaDZWUjc3?=
 =?utf-8?B?RlJBUVV3MDBPN3BEWjdBTEdjcVpjckY2cWVvdTBpVnN2Q2Z6M0VGVlpMV1NK?=
 =?utf-8?B?TjRtT0UzVWhDVWV4VmJFZGFmZFhwaFdQMzFTLzgrQlpVc1NBWWdMUTBwaS92?=
 =?utf-8?B?RTBtck1UK1o1Z0VDYXZPeVRSR2FJSHI3SVVYVHVXeEJ6ZlVxdjNhL2tIaVJV?=
 =?utf-8?B?Y2s1SmRlUVhid2RmbzVlVWlsTGt4Vk5OVzd0L3FBaWJQOUFwQ3ZkNE0yN2Fw?=
 =?utf-8?B?VVhFcHA2NGdRejJvbjB0SG9zTkkrOXU1bi9RU2VoWENqUkpmeWFDT01oL09D?=
 =?utf-8?B?NUtsRTlPNWVVSklyT1VBa1dyelVjdnpZaDJzNndYS2JxMktBd1MzQ3U2cG9j?=
 =?utf-8?B?cW55N3N0dllxZHgzUlpsRDNjWEM0aFpZT0FsUnFJYUIxZkVuZG5lVmp3S2Q0?=
 =?utf-8?B?SERRR0lneHI0bUJITnZLYmpmYXQ0MmZZeFJTbUhxWDNxLzlLbFRoQUJySXlU?=
 =?utf-8?B?U2VFcDJyNExiS08wckoya09FZHU2ZUlqZ0NKRklvUWlKQmhzbGVTYjRMenJx?=
 =?utf-8?B?bjNuTXM0dDd1T3pZNGgwdnJWNFBGMUlEc293NVh3ODk3Mnh0T3FmdWdxaHJm?=
 =?utf-8?B?dEZQY2lKZEk1alVIQjZnbXpyc3YzSzFDalo0Qzc0aHR5OGtGZ1BrN0oyblEx?=
 =?utf-8?B?bGlXODRLQjlCN2I1aW5wWjQvM2lHVDgzVHhRYXpWNTVFSkVGblFXSHVoTTJo?=
 =?utf-8?B?MzJXanhaSnI3bjNKdzJxZEdpY0lIeHY4M1V1dWpSUDk4aWZLU0NORmpFelFH?=
 =?utf-8?B?clREV01OYlBQUm9DTXp5ZWh2RHlrQVJ2dnB2SW9KdmlucTVoQmxRT1VtSDhw?=
 =?utf-8?B?SGJUMnNDRzBuR0pIRStjVkRvQWxxQWcyM0F0d1hXc0h6dTRhQ3FZQURMZ21I?=
 =?utf-8?B?RkFMUjZlV0VKVGo5eDR5R2gzZEkvODJUTXBtR1dETVZqQXEvK1FsYTkrMkIw?=
 =?utf-8?B?ZVFiNVVnWVRrZXEyOGNCOG1IYm5QZkhva0FaZEs4ZDBKeTlzZ0lmM05iMDBv?=
 =?utf-8?B?Z2JHUFhVbitNaXJ2WFZxejgrbXdlbU9KdGNZUmc5L2pFZGR4T3MyeW5PSDJV?=
 =?utf-8?B?aHJBSUp6ZC9BUnYwTEgzcDN6bm44MUE3UzBQaFQvR3U4a3ZZaXJubmNvSGE3?=
 =?utf-8?B?N095bnA2NzlPKzM0QXB3aFlmaWZjSEVZRnhFNW8zYkFyRDNJOTgwSXEvYXpx?=
 =?utf-8?B?NVM0UUFEdmVHT1huUS9zV3lBYTZZcnlUaVFHcUVnNWV5SWlwQ1BKaDZkejVh?=
 =?utf-8?B?UXVKRG9vSmpwN0FId01rdFFJVFFkakxkL1ZXTW9oNmNYR2J3RWxBSTZvZ0Vo?=
 =?utf-8?B?K09hMEt5cEFYb0svZ2ZNZy9hQmd5RENjN0dEdGRoWFc0d096SXFZZVN0TDEv?=
 =?utf-8?B?UkhlY0xIYmN4cElpZGh3MWlINXROR3pMOHFtQnlIclpFWVRCVFFIRXh3aHlL?=
 =?utf-8?B?dGNEeGZubmxBOFZxYXRaMTdCem5rU2pFbHJONFdwYjJac21LeWJuK0NMNnl3?=
 =?utf-8?B?a3BGSGtNWnY3a3hpRE8vUzRUdFAxNXZzV2tiS3pvMUpXamYwd2h6SHExUUpB?=
 =?utf-8?Q?SRzVgjU58C3oWQoGJTSzg1oNRC3WlvlzZg4Mw5XaSVSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f681e5aa-838b-4546-5cff-08dde5fbdf99
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:26:52.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvWRZkfAgm77jcqKliOnAidtbUsMh1CUczcoMVcupKUIK61oqy3VeMW26KJng3uElBJD7dwzlukP5YCbZNzRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

Thanks for the feedback Miguel! For the record, here are the changes I am
planning on applying on top of this version:

On Mon Aug 25, 2025 at 11:51 PM JST, Miguel Ojeda wrote:
> On Sun, Aug 24, 2025 at 11:31=E2=80=AFPM Christian S. Lima
> <christiansantoslima21@gmail.com> wrote:
>>
>> Since the `is_aligned` method for pointer types has been stabilized in
>> `1.79` version and is being used in this patch. I'm enabling the
>> feature.
>
> Period -> comma? No need to backquote version numbers.
>
>> Even enabling in `rust/kernel/lib.rs` when compiling with `make LLVM=3D1
>> CLIPPY=3D1` a warning is issued, so in order to compile, it was used
>> locally the `#[allow(clippy::incompatible_msrv)]`.
>
> I would perhaps try to reword this a bit.

Reworded this to:

Also add `#[allow(clippy::incompatible_msrv)]` where needed until the
MSRV is updated to `1.79`.

>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1119
>> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Please add a link to the original suggestion if possible. If it is the
> link above, then the tags should be in the opposite order.
>
> Did Benno and Alexandre both suggest it?
>
>> +/// fn test() -> Option<()> {
>> +///    let raw =3D [1, 2, 3, 4];
>> +///
>> +///    let result =3D u32::from_bytes(&raw)?;
>> +///
>> +///    #[cfg(target_endian =3D "little")]
>> +///    assert_eq!(*result, 0x4030201);
>> +///
>> +///    #[cfg(target_endian =3D "big")]
>> +///    assert_eq!(*result, 0x1020304);
>> +///
>> +///    Some(())
>> +/// }
>
> Should the function be called? Otherwise, we are only build-testing this.
>
> Should we just remove the function and to it directly at the top-level?

Changed this to call the function and hide the unneeded parts:

--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -16,19 +16,20 @@
 /// ```
 /// use kernel::transmute::FromBytes;
 ///
-/// fn test() -> Option<()> {
-///    let raw =3D [1, 2, 3, 4];
+/// # fn test() -> Option<()> {
+/// let raw =3D [1, 2, 3, 4];
 ///
-///    let result =3D u32::from_bytes(&raw)?;
+/// let result =3D u32::from_bytes(&raw)?;
 ///
-///    #[cfg(target_endian =3D "little")]
-///    assert_eq!(*result, 0x4030201);
+/// #[cfg(target_endian =3D "little")]
+/// assert_eq!(*result, 0x4030201);
 ///
-///    #[cfg(target_endian =3D "big")]
-///    assert_eq!(*result, 0x1020304);
+/// #[cfg(target_endian =3D "big")]
+/// assert_eq!(*result, 0x1020304);
 ///
-///    Some(())
-/// }
+/// # Some(()) }
+/// # test().ok_or(EINVAL)?;
+/// # Ok::<(), Error>(())

>
>> +    /// Converts a slice of bytes to a reference to `Self`.
>
> An intra-doc link may work here.

Wasn't sure what a link to `Self` might link to in a trait declaration, so =
left
this one as-is. :)

>
>> +    /// In another case, it will return `None`.
>
> Ditto (also elsewhere).
>
> I would perhaps just say "Otherwise," to simplify.
>
>> +    #[allow(clippy::incompatible_msrv)]
>
> If this can be made more local, then please do so; otherwise, no big deal=
.

Moved this closer to where it is needed:

--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -41,13 +41,14 @@ pub unsafe trait FromBytes {
     /// and is different from zero.
     ///
     /// In another case, it will return `None`.
-    #[allow(clippy::incompatible_msrv)]
     fn from_bytes(bytes: &[u8]) -> Option<&Self>
     where
         Self: Sized,
     {
         let slice_ptr =3D bytes.as_ptr().cast::<Self>();
         let size =3D size_of::<Self>();
+
+        #[allow(clippy::incompatible_msrv)]
         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
             // SAFETY: Checking for size and alignment ensure
             // that the conversion to a type is valid
@@ -63,13 +64,14 @@ fn from_bytes(bytes: &[u8]) -> Option<&Self>
     /// is equal to that of `T`and is different from zero.
     ///
     /// In another case, it will return `None`.
-    #[allow(clippy::incompatible_msrv)]
     fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
     where
         Self: AsBytes + Sized,
     {
         let slice_ptr =3D bytes.as_mut_ptr().cast::<Self>();
         let size =3D size_of::<Self>();
+
+        #[allow(clippy::incompatible_msrv)]
         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
             // SAFETY: Checking for size and alignment ensure


>
>> +            // SAFETY: Checking for size and alignment ensure
>> +            // that the conversion to a type is valid
>
> Period at the end. I would probably say "Size and alignment were just
> checked, thus ...".
>
>> +    /// Converts a mutable slice of bytes to a reference to `Self`
>
> Period at the end, intra-doc link if possible (ditto elsewhere).

Changed the doc/comments as follows:

@@ -38,10 +38,10 @@
 pub unsafe trait FromBytes {
     /// Converts a slice of bytes to a reference to `Self`.
     ///
-    /// When the reference is properly aligned and the size of slice is eq=
ual to that of `T`
-    /// and is different from zero.
+    /// Succeeds if the reference is properly aligned, and the size of `by=
tes` is equal to that of
+    /// `T` and different from zero.
     ///
-    /// In another case, it will return `None`.
+    /// Otherwise, returns [`None`].
     fn from_bytes(bytes: &[u8]) -> Option<&Self>
     where
         Self: Sized,
@@ -51,20 +51,19 @@ fn from_bytes(bytes: &[u8]) -> Option<&Self>

         #[allow(clippy::incompatible_msrv)]
         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
-            // SAFETY: Checking for size and alignment ensure
-            // that the conversion to a type is valid
+            // SAFETY: Size and alignment were just checked.
             unsafe { Some(&*slice_ptr) }
         } else {
             None
         }
     }

-    /// Converts a mutable slice of bytes to a reference to `Self`
+    /// Converts a mutable slice of bytes to a reference to `Self`.
     ///
-    /// When the reference is properly aligned and the size of slice
-    /// is equal to that of `T`and is different from zero.
+    /// Succeeds if the reference is properly aligned, and the size of `by=
tes` is equal to that of
+    /// `T` and different from zero.
     ///
-    /// In another case, it will return `None`.
+    /// Otherwise, returns [`None`].
     fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
     where
         Self: AsBytes + Sized,
@@ -74,8 +73,7 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>

         #[allow(clippy::incompatible_msrv)]
         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
-            // SAFETY: Checking for size and alignment ensure
-            // that the conversion to a type is valid
+            // SAFETY: Size and alignment were just checked.
             unsafe { Some(&mut *slice_ptr) }
         } else {
             None

Also, as suggested by Alice I am re-enabling the implementation on slices:

--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -94,6 +94,7 @@ macro_rules! impl_frombytes {

     // SAFETY: If all bit patterns are acceptable for individual values in=
 an array, then all bit
     // patterns are also acceptable for arrays of that type.
+    {<T: FromBytes>} [T],
     {<T: FromBytes, const N: usize>} [T; N],
 }

Unless someone says something by then, I plan on pushing this to nova-next
tomorrow.

