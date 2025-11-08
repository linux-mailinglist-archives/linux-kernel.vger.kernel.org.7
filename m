Return-Path: <linux-kernel+bounces-891263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6CC4248E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668733B1EE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE42BEFE4;
	Sat,  8 Nov 2025 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3nFd3wl"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC982957CD;
	Sat,  8 Nov 2025 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568655; cv=fail; b=LmKuQtAYgbgoybyksVXH/08q3LTrgXUeOYqLRLdokhuMlxHMl5Ts19stLJlYJ189jBlhLxP6Kq8sgIwn0ZmgziOSQFgqOzdjcm22PY71KndTnxqgE9lg//zyG3ql5tzTMTtemJI9ahZTNmAHgCB5ssuPJY/Aklt9aipie1vNqxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568655; c=relaxed/simple;
	bh=DL3kJl47RLagLZb1lIAI+66xNgj7zmKgM369lPKqfyA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PgEfl0cuX6ldKKTvvX+weih9Yt3BK6s41iN5+aIowtqTNtUwE42XqaJEkEifvd+35vpcyqN0pDHCrnUNSG8lkh6ivXsskZN6xAvgKr5uEqYKVOx+tuaWs7fua5NGCPsHi19edXQPp3gTuJ6PRV5dgi5R3sPvDUWqUiejyypaIBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3nFd3wl; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/Zl21PyigOGwPFuoAi7Ut3WEzVKW4AJZXYtUYaDNJxQtx1r6imv/JPZTg97fc4j0nIycVdvTDhJP8e6XOwJ81oJWVdkQ63XcKg7jrY2no6jBYP7fZPwaR9B79SNaFCIj1oOWLg8dIkU4DVYFucOu+k5xxCneB2rE84S13mYHJNKkUUMWkrNJGfacXDm/liTq9+NEuVu3L4ViArXhZrXWFYjEpD8TnhcA20KWXYt+midSiJmKTco+jevG7FEkEul8wk7Sy54fo8cjpxnIKNk8pfaEgnr2XdTyA7vP0WLenCTs8ySV/6wKZn37m0bb3RFKv+up8rpHb061XjkaZNDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ5uwyub0ifIcMx3+z4SZwPIsfyMINSer7ZBtFNzBWE=;
 b=ivJ59HBpfCrWOCQbSBmF5ubzmaYWWWUs8bjsg5ejDw43Qnd5/WJk9tCGm3/VlX03nlF4a3eVsfksN3g3yaWtBWUSzFXMfS92MzEpCBJIgdZ749A33JHudmAHQIgrGiLr1WI+kUy+sXkuJRn+/BNQD4pYq2K9z5GHNuE61bvDU0BR5BIXseLlUC4NGGCGmU/7+VJnV73QMNfMENYLqdJ8IKDoH+xm6yDnO1HHUxNGr4X6Nu6/ZtYIWx/Nyztvvq2yb9Xql23giKWYdaBbA/qXIoh/xuNxy4uzz1qcrA157qQx08ug35b98ApztXJcFICrU4PPrvqu5zzUXy8IgKqYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ5uwyub0ifIcMx3+z4SZwPIsfyMINSer7ZBtFNzBWE=;
 b=q3nFd3wlDmgWH4fNlDULdvxOm/QLjPzQa5+cwEtKVjXTmtXWQj0EXb/uM8BM2Htd9A9vD7LlM17adQdY7CAvthLYy0m4dDfWBso3Pu03/a/AcRqVXGEz7ulyQ2WdS5nxqR4SH+2OExFDo5l6tC7AlLxms/3PSTmf6FKLmaB8brRcK3qjDEyQ9oorhC7lZ2Ws4NIyQ5DGdv6t+06HOU6ZXkphL+km2TsrG0j62OsiruI1Yq2OaXIwV/IzwjQpOAk3KiF26/XheRsyj4ggcQSH9z9n82Dd+mV18jSlmCE2L4R6Wg63Rwqkd0DNVgpBUg21T2j75kwg/m2WoZKWNi0mIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sat, 8 Nov
 2025 02:24:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 02:24:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 08 Nov 2025 11:23:47 +0900
Subject: [PATCH v4 1/4] rust: add num module and Integer trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-bounded_ints-v4-1-c9342ac7ebd1@nvidia.com>
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
In-Reply-To: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1d7fb5-1bbd-46ed-0167-08de1e6de4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm9aTHY2TElvMmg2eE5WVEhoQm16cWdMUGUyR0d6VnJuUHNQZlgyMmVBWnR6?=
 =?utf-8?B?djZTajZhNGxoMXZrbXFkeGFRTHJuaEw2NkxvUjlyZW8wbTFUY3I2RkdTZmg3?=
 =?utf-8?B?bXRBUW81T1RBQThKSDlzREt1OU0vdkJBbkk0aWRsTXQrN3Vyc2xXTGNqYmFR?=
 =?utf-8?B?bFora2hrYlFiSjBlYm1RVFZJSkxmcG9tNHhWVUhNUzA3M3djTDRKeHRtSDh0?=
 =?utf-8?B?ZmZnb2h5eE9rTFFPK0Y2Q1U3US9WSUtMbEdqZUZ0UkxUQk5sNE1NcTlsMytw?=
 =?utf-8?B?WHVMaTMyeDB3a0xYWm1oNWdTbTZESWtiMkFvUHYrV3hNNS9lNFU1eG1ZRFJ5?=
 =?utf-8?B?K3FEclJQZFdiNUdSREJjQjJhMmVuclJiRUhyWERTWHVYWWJQMDJlazBneHdX?=
 =?utf-8?B?citndSsyM1o3ZjB3c05HSDNDQ3V2QTlWTThuaHhNTnJFNy8zNyt1dlFZR05J?=
 =?utf-8?B?WWJpM3IrVXczb3F1MEJ5citCT3d5STRlYVpmVFNtclpBelg0VlVBSHIxSmpU?=
 =?utf-8?B?Qm9PWlNDdzd6Z2MvNmxXdkR1MmI2YzBWa2RLajJBNU1YUXFFSUZoY1VyQnVW?=
 =?utf-8?B?NUdoeHU4UUJ3NmoxRG5weVljV2N2YUY2UUdkclFVRi9Kdnd2TjVmeVNuMzBH?=
 =?utf-8?B?dGJobE9QMFJFaVhaRG9LS05JbzdFTytMUU8yZjBTa2ZUbUg4UUxlVm1xMkRG?=
 =?utf-8?B?MDlGdmhxMjV6STFRQ1N3ZHEwTTYwdm9Md3ZpZnJ0QkxYNGZvenlxUW1JODJU?=
 =?utf-8?B?NHhZM3l5Vk5qd2duUmtjbmZvQlI3VGF1Uyt5M25qcWlMVHQrSWlqQXc4RHV4?=
 =?utf-8?B?ZVFHZjcxcDFmbUptMnNwaFZBZWxKWXhkaDdGVlJicllWWjZicm45NFA3aEF3?=
 =?utf-8?B?UDRQWGJGbGxNZkthd0RmQVhYYmEvcnM1bHBuOUZvZGZTWng2bm1CZ2xVallm?=
 =?utf-8?B?NlpFN0dYUVNkYlRUZFovZStWQThHSEhqeUgwbTVjZUVLbFlHU1B3U2ZobWxW?=
 =?utf-8?B?LzZUa200ZG40cGVxWEcxRDdqNXBKUmVyYkFoUFlYQk4zSHFMUVlLM1pTRWZJ?=
 =?utf-8?B?N0lXYnVoOG9NZlgvZDlWWUVkNTlCUVpKVUk1cTlSMFcxMU1XRXgvSmJTckJS?=
 =?utf-8?B?UjhXcC9TaURmeHV4TzRyWTQxMDBuZnpOaUE1aVo0SzRPVk9DOVlNREhmckZa?=
 =?utf-8?B?SVdEZ3ZtQzZzeG1XTU9ySVRocURGckx2WFNyUEhhK2VjTXRwYysvai95UzFV?=
 =?utf-8?B?UmlVQnVJcmIrL1FYSzNBTmR2ZW5sUmhrVndhZ3VrVmdvRnRRUkFETG9xVG5E?=
 =?utf-8?B?bTVCb05jQnZkd05IK3gzRjFWNXQ2VFFib0xMakxMOWNNSGp1WTZCQVpVSjBr?=
 =?utf-8?B?c3E2L2hydmUzTGRSekk1YUlzMGE2Z3g2dUw2d3NudUljRnd1cG8wYW5lNWlQ?=
 =?utf-8?B?eVlqdDNOT0ZKTUVYTmNDZ25yQkRkUmZER2ZlSnB4cXdySGc4SGxLQWJhRTZr?=
 =?utf-8?B?ZHVkdWxLZUJFalFDTDFrbjY2RkhBNHcrMHc1eVNjZEx5aklOL1ZPcTlXNjdF?=
 =?utf-8?B?MjNlbEEvNGpKUVJOdjlBbGJFQytKamhBOTdTV0x1UzBFOFVXOHJ6cFhCcjQ2?=
 =?utf-8?B?bnNOVndSc3BrckdzNDhuMUQ2d003dkdlbmF2S1BKMTU2Z2FOT2FjVnFuYlhn?=
 =?utf-8?B?ME5xa0VsbFRPSisyZHg5L2FJZ1R1dXFjUnRjLzR3NERwbXh6SW1qWnhnWllD?=
 =?utf-8?B?dnhzRlZhdGlld2dFUTl5VE1ETzZNZUVtMERKcjQ5UE0xRSttVGhaVVNxb04z?=
 =?utf-8?B?bW5sZ3FHY3cvcGgxNFVnME0ySVJYQjRMeStGS25hdEVEQjhPd0hab0pLbnNO?=
 =?utf-8?B?LzNRUENNaGRyeTYvSlh3NkpzejFtUllEZWlsd2hTNHJaeHhWZmYvdXFkbWkv?=
 =?utf-8?B?SFlsNFhBZ0JVaVd4Z1lPcENDVk93c0U0UG5FSzFxSUs0VWZPN0V1aEI4S200?=
 =?utf-8?Q?pKJ/T0ALQ9fj95sYR/VMTIZHVdEq64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFXeS9XMlpDcm5UQ1JNcDFmYnRQNWNFRmtrUlBucUpnZ1l5S2EzZWVPSFM3?=
 =?utf-8?B?S3ZkU1pGR05FeWhnZmNsRnZQMDFjL29CY0hWRTJFZmFkQnJHRkE5Q0V3REgw?=
 =?utf-8?B?Qzhnd2c5QXIxcVhXc01mUCtOVmdxc2QvYWY5ZklESEhsMWJodG91RE1MQ0xH?=
 =?utf-8?B?WmNPNFhsTW90MHdrSDdKNGF1TzJvTEp0MEpvTnNVRGFuU3VMdVg4dmtzaEpK?=
 =?utf-8?B?NXpodHpzaEFtK2xaeGZMZUhiQ2gvaTNwR1hVem43K0ZaV2hOakxPMTFINkxX?=
 =?utf-8?B?LzBHZy9vZVZWTWlGNW9RcjVuaWxqOHRzS3ArdnNWRkYvYVRmelVtSC8vL2J0?=
 =?utf-8?B?U2tHSDlGU0VYVzlBSkF4Y0N3eHdzWWYvSjNIOEYzRkgyVjU0M1E5eWRxREF1?=
 =?utf-8?B?WTkvRVpRdkFSVGh6NGQrN2ZlZWJtd3Y2clY4UDhNZFQzc3dJWlhRYkE1ai9j?=
 =?utf-8?B?YjYzM2FNYlM1ZWwyblFpdHF6RDhUaldRdDVTYUh5TkJBcjFROXF0eW5xVUNp?=
 =?utf-8?B?WmROb3VkVVRlRmFnMThwQ1hyQXR2SURiTGRYNDFpVTZ3bGNPMmhWTXpHblBn?=
 =?utf-8?B?d1lvUjNTMHg5TkpCMWdqNVA4bGx5YVIwQ1YveWVQc1Z0YXRKNzd1aFQxNWVF?=
 =?utf-8?B?RnVSa2RkdE1DUFRzeWVPTWpMbkZwUllyMy9rL1RZK2J2cVdQSHZEY2lYWjNi?=
 =?utf-8?B?dEZPemtBYmNYTEliM0kyVUhhY1NwUVB0Tnp2elVicmVxQkEraGhuL1IrdXlL?=
 =?utf-8?B?UTcwVUhVV1ltT3dsbVVGS254T3krdEQ3VDVFL1JPQkhhWDgzWDNCR3UxVWJK?=
 =?utf-8?B?czJjNngrcXJPQ1lJM2xQQlM2Y2d6a1hXWUo1c3RRdnRPclJZdjhWaHdpNVBP?=
 =?utf-8?B?UWFBYjRPaFhwQWFHVjdMbWR0R2pNSXI4RjU2VFd4SmdKc0VxZlFuS0xESnFU?=
 =?utf-8?B?YnFZdXp4NVg2WHlOeVB6M3psWHFPd2w4bWduNFQ5U0hnc01mWHRvUE5MbFd6?=
 =?utf-8?B?SHBVU0NMdnppQzhteUgzcGhmZi9rRm0vblRJVkNZOVFHT3VUcjl2WlFBMWtT?=
 =?utf-8?B?Rlg5b2l0SUVrRTRWRTBMd3JKM2lhblRkU1ZWMDVaY0tweVNyeDhYemxGRG9D?=
 =?utf-8?B?aXF4TENXVFRLdmdybkxaaDFNczJiNlBzYVlXT2h4ZFdWVzJ6MHBCTkY0Wlp1?=
 =?utf-8?B?MDE1K3JJMXFKQWFOa2FJL29CbkhtUGFMWnVEYTVFeFM2dlFEcytrWDRDTjB5?=
 =?utf-8?B?L2d6Q3VGRFNVOTdWWlU2VWZCcytNUlBjZmgvaFVQQ2p3Rm1GN3NlbGdxV1d5?=
 =?utf-8?B?VWhEeFV2R0VxT1JIQzF6U0RNVWNXcFZFMHNyZE5WdTE0RmgxTUtjdXQ4Ulh2?=
 =?utf-8?B?Ynp5M3VOUHFmNFczWDQySjNsWFdMSlhaaXFvT0ZKWG16TXhIRVFXc240NzM3?=
 =?utf-8?B?aUJrTTN3R2ZLTGt1OTA4VTYrVTZDRmkzQnQ5OVd0eG9IWURpQVFuR2lXNnBH?=
 =?utf-8?B?M0RQZHdySGNnUG9uMW1FMC9tZ0c2SDhCaVJrcW00eWt2OU1EUnVZcGhtR0sy?=
 =?utf-8?B?bkhzZ01obW5Fb05hSWRPellheUlEL2V1VmdoY1IzWmtWazZFd1VSeUFLd2tM?=
 =?utf-8?B?Y0s3VEF5NHVzRU5BNlF1ZndjYUNkM3F4SVFhTkxQVXFtRi9XZDFJc1ZxVmkr?=
 =?utf-8?B?eFNNeTVxTlkyM2RpQ1REM08xOERsOTlQVFRGcUhmY2R0MWZnSFF2cGlnU1RU?=
 =?utf-8?B?NU5hZEZRTTNETTdIdDducS9nMkpUem4xbW5yU1lyQTRQd3VLMmlnN1VYcHg5?=
 =?utf-8?B?VCszQlphd0k4Y1h1QkZCMjA1STBhSnl0ZmJ4amVVcy9XOGYxVHpzUTMxblRE?=
 =?utf-8?B?UjlTK0ZNdTJ2ZnRRcFFZWkpjOXRNcmcwNVVJVWpJTG9rNW1WVDMrTGlaUTcy?=
 =?utf-8?B?R0VlRjVnMHE0TVpZYmE4R0pqSDRZdXNqS0ZHeGxyWDlFdjZTSDBpeitkUWd1?=
 =?utf-8?B?OGZTaEt3amNEZWRZcmMwTmlmWk1ONHJTaE1Pczgva1dSNW1YalArK0k4ZWxC?=
 =?utf-8?B?ZHM3TFZtYktjOWhha1U3VXExOWtSRWFRYkdBY0FxTExraWtpSTd2RkROQi9r?=
 =?utf-8?B?QW1ybDhJQVRpZkVXTXF3SC8rTFZXdGV4bUw1TVZ6L1ZBY21iejhPVnNXV1dE?=
 =?utf-8?Q?j/lxBT4n78VUkYpE6448lOOryy58vjUDbqIb0M6Modm+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1d7fb5-1bbd-46ed-0167-08de1e6de4d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 02:24:07.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K05Z/q1lvRPQqDIJ/C3pJle4WErNt9Ya+9h9e8IHC0dF+paggTHO8vFuYyRyi6wY1xrTJoeML2RfYWupvPSKXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Introduce the `num` module, which will provide numerical extensions and
utilities for the kernel.

For now, introduce the `Integer` trait, which is implemented for all
primitive integer types to provides their core properties to generic
code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/lib.rs |  1 +
 rust/kernel/num.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..235d0d8b1eff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -109,6 +109,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 000000000000..c8c91cb9e682
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Additional numerical features for the kernel.
+
+use core::ops;
+
+/// Designates unsigned primitive types.
+pub enum Unsigned {}
+
+/// Designates signed primitive types.
+pub enum Signed {}
+
+/// Describes core properties of integer types.
+pub trait Integer:
+    Sized
+    + Copy
+    + Clone
+    + PartialEq
+    + Eq
+    + PartialOrd
+    + Ord
+    + ops::Add<Output = Self>
+    + ops::AddAssign
+    + ops::Sub<Output = Self>
+    + ops::SubAssign
+    + ops::Mul<Output = Self>
+    + ops::MulAssign
+    + ops::Div<Output = Self>
+    + ops::DivAssign
+    + ops::Rem<Output = Self>
+    + ops::RemAssign
+    + ops::BitAnd<Output = Self>
+    + ops::BitAndAssign
+    + ops::BitOr<Output = Self>
+    + ops::BitOrAssign
+    + ops::BitXor<Output = Self>
+    + ops::BitXorAssign
+    + ops::Shl<u32, Output = Self>
+    + ops::ShlAssign<u32>
+    + ops::Shr<u32, Output = Self>
+    + ops::ShrAssign<u32>
+    + ops::Not
+{
+    /// Whether this type is [`Signed`] or [`Unsigned`].
+    type Signedness;
+
+    /// Number of bits used for value representation.
+    const BITS: u32;
+}
+
+macro_rules! impl_integer {
+    ($($type:ty: $signedness:ty), *) => {
+        $(
+        impl Integer for $type {
+            type Signedness = $signedness;
+
+            const BITS: u32 = <$type>::BITS;
+        }
+        )*
+    };
+}
+
+impl_integer!(
+    u8: Unsigned,
+    u16: Unsigned,
+    u32: Unsigned,
+    u64: Unsigned,
+    u128: Unsigned,
+    usize: Unsigned,
+    i8: Signed,
+    i16: Signed,
+    i32: Signed,
+    i64: Signed,
+    i128: Signed,
+    isize: Signed
+);

-- 
2.51.2


