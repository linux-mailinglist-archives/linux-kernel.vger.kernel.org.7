Return-Path: <linux-kernel+bounces-781015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9AB30C52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28C67B358D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCDB267387;
	Fri, 22 Aug 2025 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maXK/3Yv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9B433AC;
	Fri, 22 Aug 2025 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832205; cv=fail; b=RszwKOCPavpBEs6pcXgBfFsZXv/OHY613bIPcMxpsOdOliTbZMWStzFg/H2kGj6oQP4IKkdjimq8flg2VNUI/w0Z8vta7u3Yx1l5ro6D0vwQMHQFic2VQE+HxT7SKmaTAuEF7OQ8zwY/c/73rNbhcvDI1/3EyauJAa/ySmTx1xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832205; c=relaxed/simple;
	bh=kGiIRm3mDybfdwRtmhp7S5gQWbfWAtNIbxhFVDbD5Aw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=u5rsYnpreoeSE+6lcnNIdi+tvqKIdXO03+Xy/IDQzWaf1e5Dd5+VGkBOMiRQnTSu96GxaGe6TEfLh8kLVF1sG3W0Jz45LzAEpUww2R2v2DkZZ4rPcecb8ySvPyltkdMtbmzVzPeyxGljilTvoV4GqGe3dDxht+qubl7t7vQnmjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maXK/3Yv; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3t2+rtyICOApJKwsPxBHb8ZCZjKTAi4304VCyEFdZJZAil9jPDJXzY1IdJ+ang5dAQI9rww8ptpsIJoF8XP6ktcBuA4tkkzUx5KJDX5w3i1uhlwrX8tHt4iGwgPiFEfR4VxKx5ZOq1Gy5APPiKfYhIgqugVbcwScvitjeSA0jslibIP+Lds3WEFrjn+SUfZqkCqrbO9HuI6ccfSh5m/X9c7lK1yUe0ne/8UK2M93aY6zAleV+7PRgdCpLlYEYu+5EhLgqnz0FV/szkEqGZtVVovDwl/9IBslwl3KL2bKPOGLThttDi3BnmUWRO6s+P+vHA1TggT9rZKTedgYFud+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGiIRm3mDybfdwRtmhp7S5gQWbfWAtNIbxhFVDbD5Aw=;
 b=OtIjMvNjFzxA2KEq+bCnhR9lFdOIk7scI2XeLONLsUXZSHPl6bNoTINR/aW5ryEe+6oxenbphhNn538NVR68ledzEbopWZBzpvphwMsscAJIO0TUbhJFEAqNZCrWpyQNwR9uwpKLZdU62DnU0tva3YtTQ0JusSn1hSwITWXKBA5E9IBvDtPDQ/aA1X/y7RAzT9QGXftgg+eQ7cPjl3lbZATqtZZjv2KsSkBaBREcC+IdUI3dOG00EdRdORSYEWuF4zEFX2kJuMf0rUZCHg8sd0T456jsCoRYfR4mkkB8K9Y3Ps+nLToOdWxjZNsAsQAjdD4S7k5Eq9oL1rzcGyGBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGiIRm3mDybfdwRtmhp7S5gQWbfWAtNIbxhFVDbD5Aw=;
 b=maXK/3YvXZtNuuLHsyej812/33zZTd6gbtpLJRBtKoy5z1YT2Wpl8vl0FZ98n7I+QOBr+yNSwWAYbwEQHgOfthJsxTYt2Q3pDCFXkFoWPMbz3dOg71uUs4JjaTzeI1G2t+RmmxCpH9mSlWk54AQ9REeUfiUMfO0X4kFK6cz4W1cECUk8tGpCkC60Om7JUfCUWQ0B/CoRPLBLojPc1N1bLe9PS8WDGSOXt2tlXPRsI2R7VxO7IWDgkA66x/NGq66ON+LXm9Yu/urH5UK0EI97MVxJAoCzVf18HNh1Q14hTtm19dEyzGWcE+ftz9YPmGpjJOND2n0sCF53ei/2weMNCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 03:10:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 03:10:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 12:09:28 +0900
Message-Id: <DC8MK2TAQ5D7.GHE5F2OREOD7@nvidia.com>
Cc: "Christian" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
 <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
 <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
 <DC828042PKDV.16NDVKIGBNTJH@nvidia.com>
 <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
In-Reply-To: <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 19197d05-eeb0-4a0a-7805-08dde12961f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2FMTjNtZEs5b0FNR1hpaFpZZmlsM0dtblpodjc4T0tNdUw3emh3STU5WmRI?=
 =?utf-8?B?UEppNGtMazZJT0Y4V0JTbDRkaWZXZUtGM0hTQUtPaVhOMUFBWTM2dmRkaE5M?=
 =?utf-8?B?T014ZHdxcGdDdmNlaTVkR1pwTG9RNXd5bTdBT3pkcmUxaXRZNjRBUWJGdW40?=
 =?utf-8?B?RkV5VDR3RlMrV3Q4eHBmRWpuSTk1bmFtQVdRcFBjN25reGg3dkNZVEtYUjl2?=
 =?utf-8?B?Tzl5aC9rZDE3VndZSGgvd1lFVFdXNUFleWRxck85b0l5eFkzdTVIMGN0L3Bu?=
 =?utf-8?B?MHh6MSsvcUt5blJOVzh4VzNvTmZDSjhPMzBIYnFvcXFzeCtmMWVIRThhajBD?=
 =?utf-8?B?aUpNcEFPN1Uya2M3dlprVDR4SE80ZlhjaWZ0YXNOdVQ3N1VtTjRjYmtmTCtX?=
 =?utf-8?B?YmtuNGRFS3ZKU3JZL1g4ZkU5aG5CcEVpcVFNejVvR1ZSZHJpWGFTSmhMZGQw?=
 =?utf-8?B?aksxZjBUcEdxeE9ndExzV2dwRGdRU1F2c00vMURLVGMyMXNUeDgrb1EzMVAx?=
 =?utf-8?B?R0d2NHo4YVQwUjJIdVJkV0tuUC96QXp2MlA5NzNSUVRub3MraTdUTkpnOWFx?=
 =?utf-8?B?NUx0U0pORk1rRnZWN0ZHOW5CR2cvUzI1N3NkQ0RweFlqZG4zSWk5V0EzLzJv?=
 =?utf-8?B?N1hybkZiMU5DNU5DZ1p4WnFTNWNQa1BsR0hEb0FlaEV1S0VNVStvMGxoZVlt?=
 =?utf-8?B?RWNCSGZtblFubUdMOFhyYW14WVRkZW81ZXlaZUpXT1dhdG9jYmdiWXVKS3Bk?=
 =?utf-8?B?OERwZndwamNaYk1tWjlnbk11OUhQK3ZFTDJUR3BTNjlmR3FuS1oxcFBCY1A5?=
 =?utf-8?B?bFVWcENLMVRSTGRIa0ZQaEM5Zk44dXBnQTBSeDBlUGhDSHIzb01XQVF5dzY2?=
 =?utf-8?B?MFhvWXdNb3haanBtdjVrY2c1U3hWVlpqa0pBMVJ2SVdubTM1S0VTaThjbXg3?=
 =?utf-8?B?L3NrNHNoMndUYmE0cFRIcS9pcm1oenEvcWlWY21QK3padXdnRTNFNjhacy8z?=
 =?utf-8?B?Z0tCUlVrQ3I3RDA4cmRpcHd3Z1Q4ZUhLdkNTVWNXb1hvdDJxT2F2dkwrZlFT?=
 =?utf-8?B?ek1QaGNMQThPOXlKVFBSaGZrd1hzWlFxckx6WFJCRUF4TWFEVVNrT2pNR3VI?=
 =?utf-8?B?MDdtdFpWcDJnbHVub0szeTVMc3hzVjNDUEtTWmlZM0lhdUxNL2M5N1NOWGhv?=
 =?utf-8?B?TW83eklYTDVTT0xxRkhXd0JlaXZiTHpwbnkwenZzZVkvelVMVlRVU0ZDRkJs?=
 =?utf-8?B?RUlsSE85eTdDWWQxQStHNTZnbFY2ZTdxckk5SUpLOEhBa0d6RzZlZkRTV0Nt?=
 =?utf-8?B?a1lsdXBnR0hTN2d6N2R6R3ZPVGpWeHpEZlZ3MTlxek9SYlgyaWpENUdzMXBK?=
 =?utf-8?B?aE5GTkxlaGQyemFoUlFzWFpPcXUwbStNekIraVQ5dU95ZjBZdnFRdXYxUlRp?=
 =?utf-8?B?cnE0emNpbDJQcDRmV1JLV1NVTGFlUkJBOFd0K1kzTCtERFN6Um95ZFptcWlE?=
 =?utf-8?B?NUpZa3NMWXV0N2ViUW45d293Q2J3UEc3MUM1RVNZM3p1M0NySHROWXpoeW94?=
 =?utf-8?B?SFRiekVYNkxYaEh4cVNYS2FLcTVXY1ljZVJJZkpoK2ZxQWhkSFVCa0Nvc25k?=
 =?utf-8?B?ZC9aMHhpZ2U3bVpDMGY2UjB4S0pRTkcrUEVoTEtOcnBZWVV3TzdGYkNWa0kr?=
 =?utf-8?B?RkdHbU5hbnFRVGt1OGttQ1hkeTl1ZW1RTDJ5SDg5c3c5VlVVZUFlVWpVeVc4?=
 =?utf-8?B?Uno3WTY1TG45ZTFJbzZIUW1RcnBxZUZObVhqWTNqUUdlcHQ2ai8zMGdWRDBP?=
 =?utf-8?B?M0YvRVhQaU1OSGhYeEhxb0VydFNkU3NKMmc4Wm51azVGNFZWa1hNOXIxa3VJ?=
 =?utf-8?B?bnlaWHNJSzNWOUxveXd6S2VZWDVVUEdpQ0ExWi9OdFYxK25DTEp6VW5mdHh1?=
 =?utf-8?Q?04sEqK1RQmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2JKcXNtYmM5cTVCRjVtL2ZuVTJnYUNJeHJ4VFlSQ2lLVU5kcWtzUDduS3NO?=
 =?utf-8?B?Y2hOYWZpL3Mrb2tjRkxSejUvbllHZjZsenJhUHJDV2NheHJNQUpLTmhVSlp2?=
 =?utf-8?B?T256QW9VVmsxYVdwdjkwRzJ1SUFBUjNvR0hOajVucXY2QlVKaS9zUlQ4cnBl?=
 =?utf-8?B?RFBhQXNGandzUjZHc21NYXlnODA0dC81VnNxbWluMDRuRlUxdURnOGU2N3Nm?=
 =?utf-8?B?RTRHeEYyZ1c3UTF1MnFJUnRtb3Z2TXNsSFk0aVMxR1BYQURhcGoxZlZpMHNB?=
 =?utf-8?B?N043V2JvUlU1c0V5dERCT09aTTNvdTRjZmpaUEtxbDhXTVEzQXZNNG03UmZl?=
 =?utf-8?B?R3ZjTTZhWDdGemtGWTNKdkpWeVhFT3RmMnNkbllGR1U0d2pzYlFFSjZGb3M5?=
 =?utf-8?B?TG1uRGtKUXBnY1RhNFF3THg1Z0k0NzB1WGIvSFJhRXBPMGFvYmk1REpWMHBw?=
 =?utf-8?B?bnhoMitvU1VBVVY4NEFuOFRKbUNIV3RYcDJtNU9NQnU1SzlCbDd6Ung3MVFL?=
 =?utf-8?B?bFVRZEN3dFBtS1BrWHNQcndkVEVLVTlNd0tSVzBqUmVvRlBicnVxOWdXNXNF?=
 =?utf-8?B?QWJSa2VITU9NcCtaaUJpejFWMnlOOUN0a0VwTWhkVFNKbkQyWUQ0MSs2T3pT?=
 =?utf-8?B?UkpoQjFMZEtWbDI4OGpybmI0dEwwSDdvMXQ5Qmo2NmpvMEhnWGR2RGlmVmU3?=
 =?utf-8?B?ZTdiTGdvZ3AzektxcTJSKzFMUlRIaUltb3R2SVpTQmpXU2hodjhvN1NuRmlV?=
 =?utf-8?B?R3gvZTdEUDYyRFMwTWpNaENrc21wZXF4d3VqK3lIRkR0NFNrNU9vb3NrSXRH?=
 =?utf-8?B?SzNKb3FvclBpUm9EOHV2cGxOc0FTMXlkV0l0OVFXVFlKeThVM2RUcnVIcS9p?=
 =?utf-8?B?MzBPT3VZN2RlOXJNQ2ZmcGVzSGxGVFNoRGd2L0FPMXk2QkUzeWxRWEg2K2dU?=
 =?utf-8?B?aDlBMGdGc3lsM3ZTL2ZGeitsT29hSW9pVGNvVUo4MzRMV0hPNUpXUXVKcGlx?=
 =?utf-8?B?czA1a3VmVVJGTG1qWGhVM1FaY2RMNEhObERGRkhPRE5yVkl1ZTVHZ2hBZ0ZR?=
 =?utf-8?B?MVFkcGhFejBJTlVHbmJSSWZZcjBMZFhGOHcxc2lHS0NCY0lPaTBVeGRIQkpp?=
 =?utf-8?B?T1YxbVlsQ1p4SnFWMU5BTTlzTzFvSEkxZWtVcHNzeWIwREQ2ejlvTW4rcloz?=
 =?utf-8?B?VVVrWlNZL2VwNE92czc2dFFERjlHZ1NQeEE4QU05eHo1a3ZuSG9KcUFxY2FD?=
 =?utf-8?B?Q0kwMnBPc1I1dWNxSHEzTGU5a0l2MjBtR0RNM2J2TXl1WU4xYmQrRko1azJF?=
 =?utf-8?B?N3Z5Sk85WHdZeDUxalB5YXBiNkQzTzAzVHcvZ0cwUlVKNEhlSW9jRU40YjV6?=
 =?utf-8?B?TVdlOHB1dTliVXRLVUpoMHVEWW5oUXcxREF0Umgyc2crT2hNVWlGS3RYYjVE?=
 =?utf-8?B?d3JSTWV5eTVuV1FpZHEvMTk1Rjl4ajRTVTNSUURWSytVLy9RQk5keXo1K3dU?=
 =?utf-8?B?UnJiUDV4TjBDT1pVNVJ4Sk5zK1ZvWi9GOExSd1FXSXFKS05lQzE4R3Y2VExr?=
 =?utf-8?B?Z0NDOFl3NnJqUVFlbFhDbHI0b3FOV3k2RW91T2svalJrTit5S2FXWFBQdmxE?=
 =?utf-8?B?ZDNxcG9IK0JlbUQxSGE4OTRjbVdneEd4bkdiMnYzNE5YZTd4MENEYmMydXVW?=
 =?utf-8?B?dnQyOWN3V05sZ2VBOTZpZFVQdCtqakVZMEhzWkIrclpJNjFCTldXcC9kUm5Z?=
 =?utf-8?B?R01sNHJqUG4rUHJrT0JyL3ZTcGcyVWh2MzZBL1hGVkt0enpaTGRUWW14VUsw?=
 =?utf-8?B?VVdqL1pwcDdoa0FNS0lRSFM1d1ZHWnZSQ2NmZHFtS3JscCtNcTRsWG5ZRmUw?=
 =?utf-8?B?enZCVUlvUzVGMnBtOU5wejRkd0F4eEwzTDN1dE4zT3N1NDAwTURWTUFJNVlM?=
 =?utf-8?B?cDRJdEZNS1A5Q3hpdUwvYnJYU0IzZFJLYVdGU3N2bVVaajdtTTY4SVdaUFhY?=
 =?utf-8?B?bldzZmJEV2ZQdTk0MFZBenNaYUZpM3J0emhJdVRsMWw0Y1RwU0liZDJBYTgv?=
 =?utf-8?B?VGxGdUJWMXJlQTh2TTl4ckVxUC80N1hUMUdtQ0JMVDVyWDVSK3duYnZkODBP?=
 =?utf-8?B?c0YxWThVNWVsd1JEM1lFYVJFTVZXb2NSam1FTUFHQnFaZjBNTVRhRFNRc3Bu?=
 =?utf-8?Q?OhSyHkx/GKYlYsFTmu7KspIxZ9cF+ZgbIZcYlwidcHWo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19197d05-eeb0-4a0a-7805-08dde12961f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:10:01.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa+fWZH6/2YlTRdWugqdUCrhiPveByOhSH0cnKFnzNITgKzNlmUuKTFMlgtkYQUc4Wd3f8sK2b1Ui7S6N5qpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

On Thu Aug 21, 2025 at 10:50 PM JST, Miguel Ojeda wrote:
> On Thu, Aug 21, 2025 at 1:13=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> (adding Miguel as a heads-up, and in case enabling a feature is not as e=
asy as
>> I think :))
>
> Thanks! If it is internal to the crate, i.e. not something generated
> by an exported macro that others can call, then that should be enough.

The methods making use of this feature are definitely usable by other
crates, and can also be inlined by the compiler. Would that be a
problem?

