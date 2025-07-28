Return-Path: <linux-kernel+bounces-747965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E418CB13ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4D716A6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561526772D;
	Mon, 28 Jul 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2nJ4+ec"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322C26739E;
	Mon, 28 Jul 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706890; cv=fail; b=A53u9LZpuzyOqia9drKrccZ9WrcIm5eRMAcv1thZLENmfvUX6Sk9wKTP+U5C4A+OwpJsEY3jNcKLVLuaffhAmYGhtbiE1v5uv+Xfear+7BzymvMHnU49S8+UrSCCgGmDq+jMNKHT1zHZCt85XpUU9AzZq50jkzsKhfNpJCHyVak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706890; c=relaxed/simple;
	bh=TFUxzJXq3omBp56KmANoMBYZR/rSlNvi4iOqP8N3HDA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hAxZnePe1JzEp1AfxrN/pvGhSIr5eJXNvNnoftovXpG+ugcrttOi74i7w+Oq8rURF2MBMgeHS1LFF1nsf+bzcgWqMawNNs2y8M/cm2z9AZlLpPoeNLrQgibUUKN3Mzxoc/3Th9mxo9/1qR83hIvekwvVAyp2VBRwRjoVKSHBLqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2nJ4+ec; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1nAYHLeikhRGJLUjdKftmwKxNf+YrFsr7O3qAe6+ZODNCfvc5LQSaRyYi10RAhcacUs2LjGOVXJ/pgYNo33ecZyK8XD5Y4ssPL3hICu4fSgR19pzRHpzSvpnwY/eSCrAqc/berE4Mrq+FfIxabCCfwCG1aLdUbWgBfkPyzCl9EoQhgGqESQn3FKy1gqw07FjnSPXZuBC+p4Zu0EvgIkUml1RRSOo5bz+QVevOQ67LHRnOcVIvxI1ChUxaBVmIfdl/2NPyFaevRAmGR+RGUKZs55VcA279UxfG9I1hWV6zo/0QWvUeYYItnRPAqGfz/GZx5DF/055pOitb+SCV9ldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLNtD5FNcikQ3yWgOAxSWxHZwCkmvAvMD8SesIYL7fM=;
 b=xQI3qu1qIilt9vDQ2ygSB3zyE3VAXNj/+HiGYdRyna4yS++K3uppRmh5EksOsE3yxo1fH1RIvX86PFT3XgYJEroey82brRUazfXFwCtJ9qkd/gBxaVBCo+/ntFzQh82OW2lUbSjCevgRhmFbl50B98eePIxfcoOWJYCkWMjJFaVyEZIWrGyR4B/As/JycRuegaSNXlfnuylLYywlacjEcMjfL2F+s5/tsst2E4QEw6PxoistMmtcr6AP9v+lEpvSm/BIMznTOLJKmnwYIuGem6apkiIP4ZQh+nVYWDnZzfGKzSUrnS9AAc2SxNfysYU8TE4yEQH0zWVhKVpHOwspag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLNtD5FNcikQ3yWgOAxSWxHZwCkmvAvMD8SesIYL7fM=;
 b=h2nJ4+ecs/cAwhvuMKR2vnzXJ0baCBkgmYYgvoTcV7ahbUJy7CNfaj88GL9EneRHwzER3GCjMwUxafgwnSQ/UdUODQmI7OFzyR6JGAtywCVEugU5c+eEhsUyJ4zcPq/v7zTfpOUETEdIvraClYNEnkkf9NL3k1eUgMzQRxMvINzV/fsGvMbZe6x9BSiEwWpheBizJ4UFOFiRIjFzjI1ngekiZp9lyciIXTgvPjFdQzRsmYYTvqzeIpoKf3rpq0k+yOCZ5H8Y+gsvL+ND/CH5n9ixuyWxtQKkktrPx/hTiSt5XCvL35PP900XqEOL2UNUonZKn3uQCwq+EVmOzTA88Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:48:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 12:48:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 28 Jul 2025 21:47:52 +0900
Subject: [PATCH v4 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
In-Reply-To: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
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
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: d08b9035-7f3b-46f5-5684-08ddcdd4ff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0dVRVoraEtVa3FQS3ZIRVZMbUlXdWw3RDkwTnJDZFNjQ2NRQkxFM3BBcDRP?=
 =?utf-8?B?RjBSRm5nd1BGZWNDNm5FWDN6Nis5WXJSZDlEQVBuMDJwMjg4cy9yOXc4Q2JL?=
 =?utf-8?B?UnROWXB3aHZFT1FjelFUakdlM1ByQTQzTjA0UU1DeTBaakN0ODdETlFOVXNq?=
 =?utf-8?B?bjE2SHYyQmp1K083dnpjZkJ5UnhqZVhycHkwbjkzUHQvZFBONk9sTXAzWnht?=
 =?utf-8?B?bDgrU1JBTlpzank1ejAySmI1cDk4bXF0T3hDNlo4TFIrOEJtTkxNRjYveHhC?=
 =?utf-8?B?SkZkWFhrRWpObDZabUtmWWJXdmZ3MG1TdldzU1ZuZ3V6R0RzZmtUWEdqOG1S?=
 =?utf-8?B?T0xnbGhvVEZ1OFE2cmxHbndyQkh1Z2tGaTVHdmR0NUcwNnQzNDg0Y3Zub1ps?=
 =?utf-8?B?VGtJbktZVXJibDFRVkQ5WWJySDNDRjdQS0g1ak5Fc09EMnh2ZkxHL3BrTHAv?=
 =?utf-8?B?enNTdndtdm1BVVdPQUhYcmpNNEEwYVVUb1AyRVd2N2p4R0g0Wk5HL2RaWFUw?=
 =?utf-8?B?ZFZ3T256Rm1LbGw5R2tFcDk2bm92YmxkNDVGZmlRTzNqOHVQcEM1UFVLRmU3?=
 =?utf-8?B?ZWpqamREeGd3NjN0SmhnMjBXRjB4clRGeTdNVFVVb2dIMGlDRzhGbHNPN2My?=
 =?utf-8?B?STJYS21MK3VjbUNidXJna1FpOCt1WUNEUDRmYkVGWEVscmIrdnlxeFlrS2Fj?=
 =?utf-8?B?dWhjQnFhcGVabUhEbEVWYmZVdncxeUpNTTlHRXdXaTgxNU9LMklyZ2l4bE5h?=
 =?utf-8?B?YUhmeVN2Zkw4MlNhYlZIdENoUFh6ZWVXRlBwS1JsZU5GR0IyNFdKU1VTYzc3?=
 =?utf-8?B?OFBTQzFWc2d0U0FsRTUrQ055WFFDdVVvZXBUbHRxOXczZFl3Y1Q0YW5rL3FQ?=
 =?utf-8?B?S29DdGhOd2o1dDZJTkY4ZTZqSmN6amhLQ2dLM255QTlxWUIwYlpaMVZKNERQ?=
 =?utf-8?B?bkRkZnJSejBTa01ENktjM2lxOHRKeER3ME9zWmRDZTZYdFRtekZ1VjFtSXFj?=
 =?utf-8?B?MUtQWHNaR3IzT1BMVFVUWmkvQkhvWnJ2ZkppZlA5bk1mcnBHLzZlS0tZOWVW?=
 =?utf-8?B?WWIzN0xqYncrZjVXb0pBMWE5MGJOS3ZsRGhFVkNNdXVzMTZKbnVxNTlad3hr?=
 =?utf-8?B?VUJWMzZvbE5xV1k0YlhkN25YYjFjSzNFejNnditpU2Q0UXlUUjZmRFFzbDRU?=
 =?utf-8?B?Vmpqb0YwL2RoR1B6YVRqYjc1TFYyN0UvbVZ6NmFId0NJcjZLN0NzcjVPbU91?=
 =?utf-8?B?L3Z4WFFJbXVqaGZhRnI0N25uMThWZUx3Yk5SMWRBM3NDamRScFMvWHlTZ2lx?=
 =?utf-8?B?UUwzSGJnOFBEYWxmR3dHeTIyRmFWQUY0dko4VDZHbXpkOTkwUEwyRlV4VHZa?=
 =?utf-8?B?TFFheDRnWmIxU3VmTS9yeUZNNFhlbDRRYjFBVXV5eWFXOXZZVG1mSHIyd1p5?=
 =?utf-8?B?UTRMaGpYY2NEclR6VTd6STJMdW5saGFOUnhubVZLNWJmMWZBQitHRWUxVkpF?=
 =?utf-8?B?WExnRUtGalB4K1Y1bkZDTnhoVHorWSs0S3Q1MW1QbDJqbXZiVVN1bWRHeGVW?=
 =?utf-8?B?KzlqcGUzNEdGSUxnTEZQY1dFdjBna2l0Qzd6V0F4b2hmcWxTQXRhalhjV1BQ?=
 =?utf-8?B?VWhsalRuRHFMejV6ampLZUJHd2R6eGtjYkdYRGovcmVTZ253d3RFeE1MdlVl?=
 =?utf-8?B?QjBIaDdXcElJVjlwRURONk15UUJTdzluN0x5SXEzMjZHQVZxSVF3d3RtNnVz?=
 =?utf-8?B?QW03cmJqc2d3N3VVYXZ6ZFh6N0psWStHYURiQkZ4TFBwY2VReFp3UTF0dDJa?=
 =?utf-8?B?cjJ5ZW9HM0RmQ3pXVi9NYThPU3J5MTM2YUw3VTJqNTFweTdwaUhET0tSREdp?=
 =?utf-8?B?LzRWYnByc0Y4U3Fkc01tOWxwRTZINGE5a0plNTFTS3FaOGVOWmVsQnNsdkpl?=
 =?utf-8?B?VFVRTjRjL3pSMDF1c21OUWE1MHdPYUJKQkFKSGwrQUNpU0J5c0dxd0pFZ0dL?=
 =?utf-8?B?N1JZTkVVdzVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTE4Nml6aFV2czFpbVhJb201WDh1OWkyOWJWZlArbjRQUEhxa3hVRGIwYmtP?=
 =?utf-8?B?bW5oTzRjTDcrWVVFeTFQVktualFUQWh3eHFpR2N0THhxd3oybVVHUmhjNDBI?=
 =?utf-8?B?dDhQaGEzYVB4bzZtUHVXbUJtWGt1T1hHS2RpT21MQ0hoYVZjNXFZYVNkMVJw?=
 =?utf-8?B?ZjB4WXVzdUpJbE1oOVR4b0JWZ3dCUElDK0QyYnlldytKby8xdTFNVmgvRnVo?=
 =?utf-8?B?YUNLSlpGaERXRE95Uks1aHBPV2xPU2JDWm5MSHNWemRnRjY5VGFraTcxaWoz?=
 =?utf-8?B?dWVVNzBadGlVMUJRcnRsVWMzWGVrNk5KR1lXWWhNdUpwbDhpclhuZWNZYUJq?=
 =?utf-8?B?Si8vd1RSYzlPM1kvZmhGdmJ3U3RjdXhXcWFsalZ4MWFBYnloNU9LWjZpZlY0?=
 =?utf-8?B?RGI4N2dKa1lUbFNRK0xabjJSQjZBR0cxdm1MTktDWGQrSHJTUXRzcnNWbkdk?=
 =?utf-8?B?TVV4aWIySlo4OENPOUFScGdhd1ZSbnZ5elVBUUlXcGdaQ0xYUm02N1hxT1pi?=
 =?utf-8?B?dzJtK213dlg2blk0Z1RxTXVyWVRiSU1LNDBlcDFBNGVxK0FuSS9maHJZSVZz?=
 =?utf-8?B?SXAzMjBINlNBOVhWeTBuYWdhb1lxOTEyMEwwaGd4c253SmZCSFJvanJoeWdQ?=
 =?utf-8?B?RkdyWDk4TklaQkdBbDNRSng5VVBnR3F1YzRmRmhNU0o2eUQvY1M5bHdpakxq?=
 =?utf-8?B?d2xLRm4rYXlSZ1ZmTXdJM1g3R3RNZDZ5cm5QWjVCT0VWMWJLZVhSRW1kRmUx?=
 =?utf-8?B?UHp5cmdFVllMdVE1TG1YeG52dGhJRndrR2ZXQ243NnBOY1R2S2o0OHl6ZDNh?=
 =?utf-8?B?UmN0L1h4SmlZeXJOdTZzMWt2ZTZxeUZyd1pkNGFKcGhwK0RpY3VWL3FTRUtS?=
 =?utf-8?B?NlRuc2JXWFhXUC9sTmhyaFdZTmVqKzNxdVkyUjRRQS8wdWxXVXNpS3pqMHFL?=
 =?utf-8?B?clRXUEVhU1RKZWNpS2hnbklNTU5lclIwZ1BpN2kzWUg4eDNWNjlBUkFiRnRX?=
 =?utf-8?B?di9VTEF3K1dKWlZQY3ptZGZ6ZE5MTER5cjVwRzMxSWNHc1RvZDErMGpQeDB3?=
 =?utf-8?B?Z3V2UGxQa1RYUXVyNHF0cWlKWXc0YnNFTEptaGZ6OU5jR3JtK3pYRXRuVnQx?=
 =?utf-8?B?RHZ2d3JEU3VXbG5SYXd2N3ZTNjBSZC9Eci92bDlTTkl5NWh4NmlRSi8rWWFW?=
 =?utf-8?B?UmswdXRKUkdBdVIzcVNZam4zc0JVeURHbXcyVW9rQ05iZ29YYlNGM2l1bjg2?=
 =?utf-8?B?ZWZZNjdaUVFLK3RsQVprMzY1Y0hhd3F0emdGSDlSLzRSbVRBYXZQZm5vMklm?=
 =?utf-8?B?aFdVTXlkN29KeDRDaFZBa0ZYMlBNQUg4RVAreENueWNxaXJEaTNBNGdwR3VD?=
 =?utf-8?B?Q1YzdzNiNk9tWmJ6ekdpZm5pUldsMzRFczlUZ0I5T3RpdFpXcFJFUStBUEs0?=
 =?utf-8?B?WEZqMEZyclQ3eGQ5czI2bWR4NytHSUhRd0pKZDdkMUREd3pFdEdPTksyWFJF?=
 =?utf-8?B?ZnBvRW92R0RmUTY0OXFkeWU1eUIzSk9lcFNtcHMySVlDM1RwWUtScEl4SUpT?=
 =?utf-8?B?RUhtdGtNR2hvbVJFZmtZOWZpMWo3N21mb1pBWGxiMGpydC9mM01wckRaaDhl?=
 =?utf-8?B?eDRTUmQ2c1NkYklYNXBybkw2RFFmZXdHb1VxTkdMMFJSY3IwdlhuenRVejJq?=
 =?utf-8?B?TndtQXhpdG5zMWFUaEpGUW5YV3NEV2NSVjlxamU2OUl3MWJrdW1kcmR1UG40?=
 =?utf-8?B?cUNEYzNHSEs4VytLdTVhbThVYUluY0x6eGtZMlNjZU10WlQra1J4c210TnU2?=
 =?utf-8?B?Wk04M0d0RVFDY25HSFNtcHlGcE5KL2l6RFdHREdnY0d3MWg2TFhZeWE1WlA0?=
 =?utf-8?B?VUMxSCswRTh1QzE0QlhEcGJVaURFVHh5VHR4QUQxQ2pIeTFUTXNKaXpRakM5?=
 =?utf-8?B?aDBnSkZJL3NIRTVkTFNza0FQU2oxQU1QTDJPZnVIUS9LN2E4Y3p2NERUQks2?=
 =?utf-8?B?UVdjaVUreTVuQmVBT2JVQndiZE9KVjJvWXk1UmxzcE9uOWhPYTFFWWxvZ20z?=
 =?utf-8?B?UTRZcmFhSzhJeXdVZXp5ZW1JSVpNVlhtY1FYRWZSdFFXWFFLQkt0SkFZSmg3?=
 =?utf-8?B?Mm1qYk1KVmd3bllyTWpZVnE5OGxrOHF4OE5rWVA2YnVjc3RvNjQ1VHNxRnBP?=
 =?utf-8?Q?k/FXC00SZG6H2m7TuOYHXYXmjdeJyq/aBhnex1tvlbjp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08b9035-7f3b-46f5-5684-08ddcdd4ff86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:48:06.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTLrmZafSR307Lczg3659BBI6vWDSYGhqJ2VbvlZc3OlKn6fhdnJ0C/VYKpnAkA1vVufLe5EFmfsGDLrBF603Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

Types that implement both `AsBytes` and `FromBytes` can be safely
modified as a slice of bytes. Add a `as_bytes_mut` method for that
purpose.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/transmute.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index d541c9960904d8c7f755351f22d06e4e8dbd546a..000fda2a78f8e6e8378bbe93cddd8a5008db20cc 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -56,6 +56,19 @@ fn as_bytes(&self) -> &[u8] {
         // SAFETY: `data` is non-null and valid for reads over `len * sizeof::<u8>()` bytes.
         unsafe { core::slice::from_raw_parts(data, len) }
     }
+
+    /// Returns `self` as a mutable slice of bytes.
+    fn as_bytes_mut(&mut self) -> &mut [u8]
+    where
+        Self: FromBytes,
+    {
+        let data = core::ptr::from_mut(self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for read and writes over `len * sizeof::<u8>()`
+        // bytes. Since `Self` implements `FromBytes` it can be represented by any value.
+        unsafe { core::slice::from_raw_parts_mut(data, len) }
+    }
 }
 
 macro_rules! impl_asbytes {

-- 
2.50.1


