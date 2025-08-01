Return-Path: <linux-kernel+bounces-753401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3494FB18266
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E276586AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D52586EE;
	Fri,  1 Aug 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5VzhVrQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C15256C71;
	Fri,  1 Aug 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054666; cv=fail; b=VbjjbQgvCDRkhImB3CbJm7xvfUirEcIcRpH4DjsOlcUBzkhKZyGMeUFNJD6OHRmhIvrwNKXm28mac+U+lx701QHwZQ/Lty7h2zJ7F4zMmn9XiWdv6kJG47JpAehEL2iAy/nw7JI8NHW1SURJbFQ/NDYL0Z6ZYAwAGGPo+GO2Vj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054666; c=relaxed/simple;
	bh=hWtrGPMV+OExqxe5/ljRsNaFlCnDFxpAOfz5ZCX3eXM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HtCbgAa2p8oZxt38mcRj0N5Yq9x2F5cI6GEClUO/jrCJ/Ak3RWjg3pCxDtd1E1eQRMq8Syoh9HMDEo1iWYhvO2L/JWUiNUUOvg8+qpYmJCpwbs0AGY6P5e9gekmtozqtbiVNeNVxRwwbebQypzJGIQgVddWlBj16QrttP2dd/ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U5VzhVrQ; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8ZwcyZHghv8U2blLpp4c/uRtaowP1tD4EcIhemthnnOi0YdlGphnuKJmAHbpa4Fdqs/kunn1sR8ueEMxMDqpyAFttffAdi6G6CGsQcb/j21sp53JRu8eBrx+gFqWYEn9HGe4VijGj0ZnYiUICIIj9wVY3ouG72t3PWyQDEvHZIYc5iVrgE1oZCBTJ5/uFSVjQmN//zujV0PsEgAcOgLKhl132uZSmcqSTMLwW9q/4LDRozSKUeOx/atUbCwBMnhtUTLb8nGZKdMZKqPDw7tuCHZclWpBckctB2S565R7e4n4LpjXGrAjOCxI3WnPDH4f11U12NQqgeBwXlj99MX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es7PRYYg9kDPqP2lOPXtYzDo0hNbLQidAQorYkDemso=;
 b=ESK4KFtLeOOEL5BasmWBBP71l4c8OwwUj3w3KG3mIStjT/QTvYb1DzlgPJBzHCJjElF8x7NaLk9UGgw5coW6x+Qqgk+Tk/gxnwJI2bNlIqH9Pfq0pYj1sSsrLRSCkYT6bMzx2DrIfOHDdAQhidIi0iPqQkvVTgY0xz+LOT5R59Gu6/ikWWFd/BJ2vKGZlQ1RfDsThf8MGoiB/x4ICm22KG0+kqhrAlcbUv20vZYn/Y6m5R9A/kELXS+H7h98UyFDp+UDb9RYUhb9oqRH/e2gOQrfDHLQOj2WpY1IanF59M/j0/P1s9LGuqhSaYPCT4mWtHCBns3QXWifN9ZnQrSXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es7PRYYg9kDPqP2lOPXtYzDo0hNbLQidAQorYkDemso=;
 b=U5VzhVrQ3mgK7JqSf8m9todowa4VD3NqdIJuXn9RlV9DzpnmpavXAlR2ReYvGKBtLTTlDIG0SK8iFGMXptt/Ki8tdVfiPNNi6f4BlakQPOjD1PleZn2zaNLg/OLuaVJ188/CI5DNmmQxuZ8TtecxUiCefcIv8gPNRzIq0twhk4DjXCiJBV3k5R5cc5PCqG+7FoT1J7Zav2ipt7WYAPmFQFKxn5KRblJsd2RWMXXp7oUQhrfTfLO38z9Y5Py+WmyKmYUx3bCoNSlZXSzwkwTX6Jtz9u+CKP/7VH6FCGePgUUYClx7ET0FGo5kvtZVIUvjQNehVH+9JDTmPfwmGjMy/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 13:24:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Fri, 1 Aug 2025
 13:24:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 01 Aug 2025 22:24:09 +0900
Subject: [PATCH v5 1/2] rust: transmute: add `as_bytes` method for
 `AsBytes` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-as_bytes-v5-1-975f87d5dc85@nvidia.com>
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
In-Reply-To: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: OSTP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bd6401-fac2-4079-f8a2-08ddd0feb9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG9GeHlJWG9JNDBpSTlEckl6b1hDZFlsQ3VKN3hUbGlHVU11UkJlVHZQS1B1?=
 =?utf-8?B?RVFUZUhrWm5WWHovdlRJaldPZStyUHZtL2sxK1gzQlRBVjBzOW4rbUphNEpG?=
 =?utf-8?B?TzF0NlgrcXh6Yk10OXdDWDRLaGQxUlhFSzZwajVwVEZJUytiNXQ5Qkp4UUEx?=
 =?utf-8?B?WFVqR3NMR282WUpIVU5TYk5ERFJqZHRrQk1RZkVCT3dSVFBRclVlMTI1VlFq?=
 =?utf-8?B?K3U5Tlk1d1F3QlNkcXNPOTFaZEI3U0pIT3BxS29aeUFjOU1PMk9lR0g2L3Zp?=
 =?utf-8?B?c2ppTWt1YnFBRGVpRkJRbHNkQjVUZmNNaFhIOWtLUzN1R0d2UFh3M3JnR2xu?=
 =?utf-8?B?emV6MmljY1lUU3NmS01sU1ZJWFd0eEVOZ1dRV2dvQ1dTTjJhNGVxVVkrSWxa?=
 =?utf-8?B?SENCV252VzhzY0xTeWNGMkliZVJoZ2prUWpOYmlsL01jZENkRWZhUjM0aGEz?=
 =?utf-8?B?Mm03QURhZEV6MkUrR21ZeTdkU09vajZUK1ZhY2Z5bnh4aEJta2pZSzg2TjZP?=
 =?utf-8?B?OTRudHZsandlNGZQU3kySTQ2eUZyT2pFVUI2MnUrQUlxbDdOTGJYdmg3YVll?=
 =?utf-8?B?bWV2TEJrbW55Q1NtcDR3WlhhVG1TeVRpSklyb3lQNnVRSlNwTENRVFVFdVZ3?=
 =?utf-8?B?dkt1b0U5cFlUd3lRN2lrRmRUemM2RWgvVFpmMW5DSTZYc3VQZi9mUzBQeitH?=
 =?utf-8?B?VG56SVByQUpvYTQ5Z1p4TWVnbnRQMENPMnVBaWlMQVkwMUpQN1IzOFVHcHd3?=
 =?utf-8?B?TGFNVkV5eEM1RmRDc0p1TC8xZGxWOVRSdUJoMmZkdmdBQkdockwraUxFMmtF?=
 =?utf-8?B?ZXZsQndYQ09JVVZFU0kvWTRLQWFKdlRvQ0V1VVlxMFFUdGFBdkM5N01KWTlx?=
 =?utf-8?B?bFhTMnNQakpzZ0JIMDJ5UzRlUjJ5N2RwS095cU5YZHJkSFNLTXFBZEdST1hM?=
 =?utf-8?B?V3V1ci9oVXhXTll3MHFINXpUdkxuSFdhaUNGUS92OG9yaTNVTGhZRmVDdU0v?=
 =?utf-8?B?dERIbGpUMThIMGVKRnlady9RZjVRNmRIU1dIWXZ6ZFFSVDdwUUl5NkozYkU4?=
 =?utf-8?B?ZzJYc20wU2NvMkdvbTRNd1lHZU5ldE14bStsVVMzMndmN20weGZJRzZWWFc3?=
 =?utf-8?B?LzJobzZKcmRpdDEzNWgyQTYxWXhYRDRZSi9MTk1ZbjJYcDBGQ2RqTTdZa3Q3?=
 =?utf-8?B?a1htUVFtWDBmMUY5eWNHc2I2MDU3MzYrNFY4QTh3UlBua1ZYMWhPK05GQVdy?=
 =?utf-8?B?QXdzQmlLMGtteDdhSENFTmsxSlJVOW9yNWtDSXNzM29pd1c2VWtpalRXeTFN?=
 =?utf-8?B?RmhLd0lZY3V0MTRRVWVBanIrWk95Y3BJcit1d2RHdjVmTTFCd1llaVFOM1Rt?=
 =?utf-8?B?dUROZUhxZmlnVEhUZEUvOC9PSU04MkdhdkpESlBnbTdWRXpybGhwVjluazVy?=
 =?utf-8?B?dzk0SDl2SzdJMm4yN0wyeWg1Q01LNHlISVVOR2w5TzZORVpZQjZHOGpmV3F4?=
 =?utf-8?B?UjBnV2hkN2tpNVJMdS83alhmL3IvMHViWVJpSmt2Y21yUUYwRjl5UFd1VjRU?=
 =?utf-8?B?Zk1UR0tZekVuV1BiMmMzR0lqTEgwS2NEZ3Y0SlFTVjFrekdBSnVzNUlGeW1x?=
 =?utf-8?B?Y25JQzVWTkFXK0dsSHVsYVdTTHNiejQ1WHM1R005WHRuRzkwa3JKaGhIcS92?=
 =?utf-8?B?S2JjK29HNUxFMTRWbzJydFJpUnhEWFY5YjlRSEszQzg5MWJ4WGxLeXhLUnR3?=
 =?utf-8?B?UWQ5ODNaUEZiN25sWE5Rang5UFZRRWlHQ0JFdFNDcE1mN1d4d3FITVYvTnFO?=
 =?utf-8?B?d0sxNGF3ZXRtbFZJOUNwRXcwYlM0MzRDdEJ4dEY1L2pQVnRXV25lcmFHek9K?=
 =?utf-8?B?NWxqT3Q4QWxSTjNEVjJTdHM5SjJFZlRCMUYzNFR2NFBnWnd6UzI5Wm8wY1Vu?=
 =?utf-8?B?YktrNG9aUjFYTG9Dc0NwcmhkQWNPN0tRbEg2ai9hUWxrU2FycWJFQndpazBV?=
 =?utf-8?B?SHBBRXI3QnBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFCeVArd1NwWHEzS21RVzhDbDB0S0pMaGN0Z3E3QndKOUM0V0JhVGdPaHVT?=
 =?utf-8?B?S0wvenlvczh3bTl2RVVJZXlvRDhKa1RXTVRDbE5mVXhIMnNKdkJRK1pzKy8r?=
 =?utf-8?B?ZVZIYkVsS01tOGEvM2tYSTNGd2szVVZ5RHNzdU1TSlBmbVhXZjNVaGRXVFVt?=
 =?utf-8?B?S1Q1c2o4aWl1dEtJenBsTStnK2YxYi85U05DdnlkSWFyVmpDbXdCU3pPa3ZJ?=
 =?utf-8?B?azhTb1JydjkrRGlUR1d4UmdJVkVOQ1VmZU1CbDVPejhDbmlkcnVIblpjc20z?=
 =?utf-8?B?UjU0T25JREs5VVZPMWtOMWFodXRCU0FCMTk5a3BsNkd4bVUwUFFaaWpHVHZT?=
 =?utf-8?B?SWlhYlo0cU82eGxmSllEZ2JVZVM0SjBLbENLVFc1VDBNalUyL21HdldST3lq?=
 =?utf-8?B?UEk0NCtsRXFNbFpXcENVR2Q0NjN2R0hjbzIwVFBvV1Jtb0hoQ2Vkd2xpeTVW?=
 =?utf-8?B?aGlBTWtvaytjSkpPM1cyZVdjcWJRZVVtL2JvVXVOZU5naE9vV3ZXVXNpbFo1?=
 =?utf-8?B?OUFkYlJIOHBHTGt6MEU2SE9KTlJoUkd3M05BeHZ3MFZWOXZSeWlBUDBKbEt0?=
 =?utf-8?B?QVZtMjRhOXREV0hLMGJ5b2ZRblMwTlY1c0g5aU9UNUNjTHl0ZUxjTEpiWStx?=
 =?utf-8?B?dTFxdFZ4YVBleU1lWW4yNS9WaHhIYTVoNGJYd25CREVhTi9YSFE2U29iY3ox?=
 =?utf-8?B?cGg3dDlMZnZWMG5tTnVzcUNOVVBWSHBUYVVtcHNXZGFtNWQyVHlzZUlTVnMv?=
 =?utf-8?B?dWE2SmZmRXFjWDdCaEI2ZGNYVEF4L1FYeHN4bWxNS2pLRHZIMmp4TjdPTFRE?=
 =?utf-8?B?eDc1cVpwOWhFcktBNzgzSW12aGJON2RJZGtZeXVlcjhlYXFzYjhxNUhiZlpT?=
 =?utf-8?B?VkNIQ2dDMm1VWUxiT29DN0pkWjM4K3YrUy9WQ1ZUaDhhb3l3NFZmSVhDRlo2?=
 =?utf-8?B?dEpacUE2eksyS3IrZVJEV01VNUpDMUtmQnpQZDUzZjVKY1NDaEFhNDMreGtw?=
 =?utf-8?B?MWQ1NCtPNnlVVVEvcVp1OW1qdmtES3MxME5RbWFPcTU1SFkrdG5MYzc1Smd5?=
 =?utf-8?B?K0dsMkJDUXFjR1c2Q1RSSUVYbFJYWG0wWjluT01xd0ZReGQ0VHdpNjE4L0xE?=
 =?utf-8?B?dndoWWxFTXZzVE4rNHhQZFJRRDVvVm1NUmRrcjhyVW45S2h2Rk96LzA1ekFa?=
 =?utf-8?B?QVNpTmhsaUpwRUZ3ZjNKeDZqZVUrczY0ZXdBd3lmOWg1S3lPaURZdGU2SHNl?=
 =?utf-8?B?UWVQTmVjbXBKbjYwVTdqWWgxQ0l4SUFWWjc0c1dWNVoxdnI0UVp5TlVYbXJW?=
 =?utf-8?B?aUwxVUV4anFwaThkUiswQ1J5NlYwa0dYdE1tcWh4SGRvS3FuVXlXOGhjc2U5?=
 =?utf-8?B?ejNlT1l1UDJsK0N3ZWIyRFhQeXRQZVhCN1Z6cXFOWXFJQXBBOG5LamZhb1lq?=
 =?utf-8?B?OExFUGlVN25DaTZjcENTVUlCZ1FDUFF1WExENmljSDFEWWFidVJMOXUzSlJl?=
 =?utf-8?B?QWdGRElRazNyS002MVRHMmVDbXhDNjkyVDFjN3dCUno4V05PcVdpOUVjTGEy?=
 =?utf-8?B?MHptQW0zU0NCdGJsRUo5b2g1cWlybGtKSTZRdmxUbDZrUm9WVmh0MWJxbVcy?=
 =?utf-8?B?WE41Vi9CVFNGVXZWYnFhTjlYNTFmSzZsdFFpSVN2VEhFQ2hyN2JqK2FnbDB3?=
 =?utf-8?B?VU1kOEJPKzczc3ZJbjNxVjdJMEZSd00rUGdwcENRKzc2QWZhdlNwNW1Nb0Zw?=
 =?utf-8?B?d25tY2M0N1FIbFVnTVNFS0J6bnkwNXhKMkZPVHVoRm1yMFBIN00vTVV0VnB3?=
 =?utf-8?B?aFBCSFVsclBkVWp4US93Y1pWTVBNbmkwZ3VzTFkxaFBhZ2xmK1RWQVEzVW40?=
 =?utf-8?B?ZVZQVlcrVi84VnNDZmJXd2s5ejFTdVhqMm1qT0JDaGQyRHh3NkpIRVdLUCti?=
 =?utf-8?B?aUF6OHhtNnd6ekF3Y0NLaFZUbWZqdjZ3OXZHNmlqSVcwNFJDRXBvNTFOeDkx?=
 =?utf-8?B?STI0OWhyeTlOWHQ1U3YrZVR4eXVacDBGMHJwWXo0RFVCRTdrT2tVU1R1WE1Z?=
 =?utf-8?B?NXhsNHJaVEJKaUJaWW9pSEQ2am5BRzNHSXl3cGtaanRPdURDcEUwWmlQWG1M?=
 =?utf-8?B?Sm5FUlM2WTVJQ3NxaDcwaW83dmE1dkRxWjY3MnpCNlcxUXZKOHpGdXl1eTlO?=
 =?utf-8?Q?1VOdwEEyoS80s2vrK192c43eILVNL2I9phhbZ/E42wAR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bd6401-fac2-4079-f8a2-08ddd0feb9d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:24:21.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twJrpmtD87J+DZK3YkaTuWO7GChDzgDo11EW4vGDUTMBppuUP8nraFMw7vqU9c4FjzrFb7r9JkwscYguFLHbtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

Every type that implements `AsBytes` should be able to provide its byte
representation. Introduce the `as_bytes` method that returns the
implementer as a stream of bytes, and provide a default implementation
that should be suitable for any type that satisfies `AsBytes`'s safety
requirements.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/transmute.rs | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37b90150de86699f114a2ffb84db91..08e6f0ff92a563e90895efa31f31f887aa05a0ae 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -47,7 +47,17 @@ macro_rules! impl_frombytes {
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// Returns `self` as a slice of bytes.
+    fn as_bytes(&self) -> &[u8] {
+        // CAST: `Self` implements `AsBytes` thus all bytes of `self` are initialized.
+        let data = core::ptr::from_ref(self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for reads of `len * sizeof::<u8>()` bytes.
+        unsafe { core::slice::from_raw_parts(data, len) }
+    }
+}
 
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {

-- 
2.50.1


