Return-Path: <linux-kernel+bounces-783050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20071B328C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0A11C264D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C02512D1;
	Sat, 23 Aug 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Su0r0GV0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396C1D555;
	Sat, 23 Aug 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955376; cv=fail; b=ocnyy6hC7UTOFvf4SLhITADqQtbIC0EALhjBhPDZgLKfwJYQiyv1sRn6K0RjC/TUuBOcaJczzZEnXTz5WcwG2PyrEwZvAgtXUq85+qS9NXmBgqY5ZF1MfGvQLdwSVPQ3U2V8nCxxLvxUbcnAu3e8JW7LFlkLsOoe5zAPI33LcTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955376; c=relaxed/simple;
	bh=qSTfRnGETxydqTp00QgU9dvVWJcw/S5aVdQBHg8Uo0g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=c9CC1ubxn2H0tMFhSJ+3iN/L9wwnNqEGR1VxfBSHfUDiKYHwhXk5d82q5nH43h+OAm/+hB3Foo0xlY710ZngixzEf+pGVTbA2DayicSZVMeTy+eLiCfFXnnFhVu9T+9+5hIU75Ec85OCf/SDQ3dOURepMcJpmPwrhM4D+FOpMPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Su0r0GV0; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHNWILfjjPqhIafGE8K+fRxDoyDxGnTpSHOVXAhBFdLMy8tsUpgcNTnffGfsEcl7cpBdfZAz9qRMFTgUecSNVqVh/yrjtifOARa3KLMirDj1TLqHfXOBiaV8ghuwdUskeumKIXUi9rDId6TJbxEjLm2tuTgZIjZ8Nxu3M5azhCzNpu4D814DOaf33ntg5mDqDFupT6gM4ipF8Wu93MvZT+v1aY0+YLAyWBAHKuUgA7u4jftuRpvQRdRWrK6d+elIPiXGSSxoBFxc69gOEh2tcwUU1cJNC0HO9wCU93d19FJJ1bwrg9E2elE662+pAIjsK63uNdG21qnGLJZDGO56TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1P8Qv1cl5jQ9Ry7WCJlXhrk7dZ924oKf/gsPLHXAYE=;
 b=ZB8plo4wdX/wb1iQq2xALVKSyfCqBEr+pd2XgVBogYbnASPnUjm+vApgUBLIdD3tCmnn1Rei1clsXifXcuIlm0OBN+F0nFMp0WBr2cCVhyAXJTvINNoIpu+Uo5cq+YdB8NTUlhd4UhHO+al2vnacrJmQfgTF1WY7hSTvrtsalwcy4D6JIMpKTb+b2tew9hNPSZZ9/ylYIYbVNsZu1razAV3VtK1wRTXdbHaGeQdVaJIrAmgRAet67AJSpHQiX4rAqUVr0QBfJkGVaVEpcmZ9a7tFeJcHS1tHEevQUAQXPsV3nDMO1oU3HdRq4691Bem5PqhaXWgjAwjnkrmJ+wJRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1P8Qv1cl5jQ9Ry7WCJlXhrk7dZ924oKf/gsPLHXAYE=;
 b=Su0r0GV0h1bQW1Y25bSAVlvkqIrBwXgFW3E8SHELmZautnLHDmFSOQ8KUDPHfuognUqifQYN1vXLTwJzoVqLYUxWvwUpqMWCOKTxf8vKNgbzI/59/GoQk/GgBq/i1cz4BZGB7zeOCesyCklbBFh2lUU2BbB42OKXl12R58u8q48u9PH+CQiJJgusniYUXbvBC3aWGsi3arWttdWXWQiJUB9SwmMU7ad12MKbSK4xEkfFOIp6R9qEDdKmtEzpDhMLIa3OYXJvRTzzoCPb0CNAi71QvX8WSZp/yxmF+8M00kV8VPPnlA9FLB1LOfaLMAG4GVJOUM58KXFBM6qSAxbIcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Sat, 23 Aug
 2025 13:22:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 13:22:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 22:22:47 +0900
Message-Id: <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
In-Reply-To: <20250820165431.170195-4-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1a7fb-4eaa-4642-a2dd-08dde24828aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGo3MG5HdU1lZUJTS0F2Wm1tV3J4RFV2d2thOVNqVzNwdk1rR0ZtcHZ0TSta?=
 =?utf-8?B?c29OOUxab0kxbis0c1JsSTBvRFkwU2FZMGw3b21DRi9kRGs4YnBqbkt0TTBh?=
 =?utf-8?B?WTVKWEZLV0xybkpIU0NKUU13aVl2OW1nYS9xSzNPZThyZmJHY3g3ZkZCVXpk?=
 =?utf-8?B?czAyVVRQWVBlMnF4WHYxUXl1a3lCeUVFalNmZjFzaW5NTlFHUTRBa0dWdXl2?=
 =?utf-8?B?ejYyM3BKSFI0TTFwYzJGOWxzOVAxcHo4c05ydGtDWW9WdW54RmlwcGFZQjAy?=
 =?utf-8?B?b285MlRsWjh5M0t2U2w1Qkg0akRFTnF0RzhRTWpzRHBTbXNrY05aU05PanpH?=
 =?utf-8?B?WnIxeFVLSjU5NUdWbDFyeTJCY3RySGozM0RmVEJRekZrQXQyU1BYQzhOYnB5?=
 =?utf-8?B?QTdBRXNReWFBcHVRS2VJbmhwVEw0azRGd0hScGJzdWphUEJtTHF4SnFxQUdP?=
 =?utf-8?B?Vmo5MnBmaW4xV2h2cFZjeXM1K1ByMWhIaDVpY3JDVEcwRmlMUnJhd1JxYjhp?=
 =?utf-8?B?V2lQRmlTQkxRcmdwMHNzb2lOZGF2cUM5MU5nc2QzVTBDeTFXN3FzbDRIcXRX?=
 =?utf-8?B?ekFQb1hEbEZlV1lLNTYwa3dUdnBPbVFLZVArSVY4aUw2aW5DWkV5NHo3Ni9G?=
 =?utf-8?B?SXUzK2hOcHA5aUU3UEc3ZzFXK0xFcmJzejRkeEhIS0UyUStyWTR2ZW9OYWxG?=
 =?utf-8?B?c3htN0JncE1kTkFwWUcvK0t5UUUwa2lXNmNPV2tDMDg4a1FES2J2TzlsNUo1?=
 =?utf-8?B?bVZnNmNadlZuWWtNc0wwQ3ZZTDgrK2I4bkd5SisrVkk4Q0V0S01hSUVteERj?=
 =?utf-8?B?TGN5ejVOWjBPUWluaEdHQW1vU0g0K0ZSQmFNeTR0bjYrYUxNUGtZMnY4Sk1J?=
 =?utf-8?B?eDlXMFNHR2Z3RzdPbnpBNWo3bVZFRkhBdnc5aEpHbWEvTnQxajhNc3cycXZm?=
 =?utf-8?B?L3UxVXFmZGFhV0FycDNwWHp4aVdDUzdaS3c4eFpUeXI5d2xua0VsOW8xTFp5?=
 =?utf-8?B?QmlUWTQ4UXJIaElLTmxuajAyOG9VVFFPT3poR1ZpNmtnT2Uybzd3UnRjWStD?=
 =?utf-8?B?Tk9STkU2bXdjQ1RhZlNnM0NvWXBjcmdwaitQSThqSFVkMGR5Yi9wQ2hSc2d3?=
 =?utf-8?B?eWtsTVNIb01HVTMvOWVpMEF1aEdvaEx2Q0tUallXWXZMNFZtN0kxbEo2cGVX?=
 =?utf-8?B?eEN5dEpiZ0tYQ0N1d2NNbElMa0M3Qk1qUFlqbExyNUxpbUM1di96WUMvcEx6?=
 =?utf-8?B?c0ZJc0VsSnFIeTU4TXhGcnVuYmdJc3pJWkNXcVI3cjRDbDUrMDJUYXVyVUlS?=
 =?utf-8?B?QVhBWmE1Y1FmL2dwcDJ1clZieU9CWFhMTzNoZmZuV0hLdlFnbHhLc3krc3k5?=
 =?utf-8?B?K3NHeGhvUmI4ZWxDN2pjUHB0VW5HTjQ1eDNTUGRyWWk3MDNwM0VUd0lOeWEz?=
 =?utf-8?B?YmdTWjVhazBOcGUwUVVVb2VrK3VhcEJFQk5XQlRqOHRiSEVlNlBtMlE1ejlU?=
 =?utf-8?B?NnRtUlVraUZ5Q3ZET1JacmxZL3B5eGo2RW9zelZuSitFcmZMTjdrUFFtYVh2?=
 =?utf-8?B?Yk1BNnIwN0J1Zy9vbWFHQnRscGd5aFRPRG92S2xnaWxJWTYxYTRLTWJXZnVV?=
 =?utf-8?B?djFCVUxyUGZBa0h2TXcxL0F3V1JCMm1VRVg4eUlWV21oeDJMaU0zYTQ5TUov?=
 =?utf-8?B?MDd5K1dVa2QxNUJYV1JPM0xOc3Fodkl0ZzJoZWFQTFZkejhRbzUwOUNGQW8z?=
 =?utf-8?B?MmkzdGNDVnZvNTJaV1lhaDg3SXhlUGxGYlVYVzVMM0J1YUxuZnlQWnAxL3Nu?=
 =?utf-8?B?aEFlRk5CZ2ZBNXdpRENxNkJxM2FweGc2dEdDVG1YMUExZ2dsWDVPcERoM1FW?=
 =?utf-8?B?OHV0N0NoTjBSVDFMTUdjWTYyYXlQK2lCY2JweC9oUTEzU00vbjVZQ3ptK0NO?=
 =?utf-8?B?RXo1VldOWlF6RHduZ1MvMUpwU0NNNmhkSitqbGRtc1M5Rk5mSWNpayt6S3Vv?=
 =?utf-8?B?bDlvamxGQmZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1vNWJZVndBODhGUzE4T09KbjFRdEhBUGZ0VDk1VmZnemJ6VjJUUm0yN3pK?=
 =?utf-8?B?a1czUDFMR2gvSDA0cGJQZ3NrK2JTL2xpcWZPZlN4N1NZQzFnTjNRZzVoWEs2?=
 =?utf-8?B?WVA2VDJnMHlOVmdtcmlIRHJ3R2JaZFVXcjkvb1VuK2JsSXVCMmpLUXBjdTNq?=
 =?utf-8?B?YlZHU1M2bzRBL1drLzR3Wlorck5yMVJhNWppMS83aHdjQ0haUThhb2VGREFa?=
 =?utf-8?B?UUhRTTc4RkdFNTJHdUs3dzMvalVmbGpodDk1RUZHMGRWUHl2bk1QN2trTVZN?=
 =?utf-8?B?dTRaeW9RRUJtQ1hYOUdSS2FHUjYzZGZuSlA4QjMwaVdYWWdtTVNnV1djdHhW?=
 =?utf-8?B?QTZZZ3J4KzJtd28wZGdVdDJ0aWtKS01FYmcwckdxZkdPVlhyR2srZGZvYWxZ?=
 =?utf-8?B?ZDhqUkM5T0pLWFY0Y2FVL2RqTi83S0M2VnlvVm04V3FtSngrVm1LaXJ0enVl?=
 =?utf-8?B?MU9uTVluVVhIWXVpYVAvMVJSUEFvVmtzWUJtMlV6UEJDZG9CWitIT245UWpL?=
 =?utf-8?B?ZTdROTNEUW13dlM5WU1raTlIL0hTV3BhcWFmTUdRU2NJSmowS2pubWdaSmlY?=
 =?utf-8?B?c2J4eHVkK3h3UktZN0g2bmIvNkEzNWFIMEM1S3JOZWtpZytrRGZ5cjB1NUM0?=
 =?utf-8?B?cDRVZVIxU2M5SWtmSjhwQWU1VjR3Wkx3R1BzQVR5NTJ5MzQ2Y2xEYmxsOWl2?=
 =?utf-8?B?eU5wU2NTWmpYcXAzQTdJYjl5T3B2NFlKSStQQmRTVEk4Q3ZsVEw4SWNCR3Ix?=
 =?utf-8?B?OG1zMVNGak1BWUxLRXVtZFRlMlVHMEg3Q2ZwUVNwY1VDVk9TNnJxWjc0TXZQ?=
 =?utf-8?B?T3d5Ni9aZFM5cXc3Z1V3WDVpaVdTeXk5REVqTEVQSllSTm82eDhUaHZ6Y293?=
 =?utf-8?B?elY3TGNXVmR4TU03NE1vengxdDRKNUhUUHBFWTdsT0lVMTIrcmJkRlJNRWZr?=
 =?utf-8?B?QU5LY1JWU1c0S1k3MHV5Rmtncms4V1l2eW1rQkxkZkduTWthdFJ1eVR4QjVt?=
 =?utf-8?B?dTQ3WCsrM0Y4U0RjYkRVejF3bWdOdHhLUUpJenNjbWZrMU5aaWxEZEpZQjdy?=
 =?utf-8?B?dHVXamtSOVdiZC9nVi9HOGtaaDFUNUdLVmVBVzFsNzRWSnZSOWo3QW1xTXEr?=
 =?utf-8?B?bzhRS3dTVVI5L0N1UWRlM3Q4MitOdktPOEthRHphcWlSeDdFRlhGQytYdElN?=
 =?utf-8?B?VWYydEo5N2I2Z25BaXR1WHZpbjN5c3VVWnJKZmc3cTBFeGIvbWhRWTA5Y3I1?=
 =?utf-8?B?TTNtdGNxMlVaVW5hNmI3VkVFRlpDUHQzQ21qZC9Bb1VSaE1MUlV2MkU3OUlw?=
 =?utf-8?B?ODJjWXFNSUt4bzdrRWluN0dLWTdDMVZ0cGZpeEN3Qi9EMHAvQnUvWm5VQzlv?=
 =?utf-8?B?N0RuR1dwUkFMbi95QWk0Y2lGYW5lNm1FTVFXTVBXWkJ0RXRrS29aUnRrY25G?=
 =?utf-8?B?OFBQc013ZTF5VVg3ZFhBemdNOFN3Lzh6QWpvOFhjZ1JZM3QrL003ZEkzaFNL?=
 =?utf-8?B?aUdhMWxvd0hlR3FOdTFuWkZ3SnpiMjZZdXlSUzN0TjJmUkFWQnNadWprYUNC?=
 =?utf-8?B?eTJINVVabnY2MHFYVlJldEtvRlg5K3lxK2Jwbk1uR3ZQNW9Wc3J6Nk41eXp2?=
 =?utf-8?B?OEM0TnhFYWVnZWh6by9Tbm1ocHlmL3lObEtZdWQ1RkVJMlNadVhvMTFOQkkx?=
 =?utf-8?B?WHV2T25TR3dGT2pwZ0kxYmtrSGlxcmlCN1BKelBBbGsvVUJOT1dHVG1EZGNQ?=
 =?utf-8?B?UWtLc25RVTAzOGtBaFhpbmx6MWE5Y0szdEJEQjAyUzhGSEIzQ3ZVQUtNanBt?=
 =?utf-8?B?OGxQc1JqZ2p4Yi9jbkdkTDN4V2cvZHR4TkxvL3h2QzBtOEVudzR4Yzl4NkVn?=
 =?utf-8?B?SEU2TGZpazFVQnVDZkIyU29zOXlYOFEwRTBKdkxzcCtBR0Z2MXNZVExSMXlY?=
 =?utf-8?B?MTBpL1RhRDIzVEJUVmJjR3lQaFdYRUJhRXFlLzhORThDMzNwbEhIL21sT2V2?=
 =?utf-8?B?cTZvOFltallTamNhd2VvRWxLdGhpamRWRnVDeEprTjNKNGpxTEFXZnhJUDUv?=
 =?utf-8?B?MlgvVnhLQjJtK2h2VEUyT3dEMldTNUcxeENmZVExbVAvYnZhLzNMbGt0L052?=
 =?utf-8?B?S2NmK0dQeVFvcTl3Nm9VTFEyYXNVSjFLTCtHV3I0TCtZMmhNVUdNS3ViMmFQ?=
 =?utf-8?Q?fMa1R4DBMbeha/rCdeKXqJj+l7bKJYnWhFKYJhY8wSNK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1a7fb-4eaa-4642-a2dd-08dde24828aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 13:22:51.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k26k+39ucczQ8rwJOZgObfG5wEqODEIriPzVy5I40fPrYRDwhQn+/l+2dvIE42UVlTqAwil8q4sCfhl2+xkDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
> Add a safe Rust abstraction for the kernel's scatter-gather list
> facilities (`struct scatterlist` and `struct sg_table`).
>
> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
> pattern to provide compile-time guarantees about ownership and lifetime.
>
> The abstraction provides two primary states:
> - `SGTable<Owned<P>>`: Represents a table whose resources are fully
>   managed by Rust. It takes ownership of a page provider `P`, allocates
>   the underlying `struct sg_table`, maps it for DMA, and handles all
>   cleanup automatically upon drop. The DMA mapping's lifetime is tied to
>   the associated device using `Devres`, ensuring it is correctly unmapped
>   before the device is unbound.
> - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation of
>   an externally managed `struct sg_table`. It is created from a raw
>   pointer using `SGTable::as_ref()` and provides a lifetime-bound
>   reference (`&'a SGTable`) for operations like iteration.
>
> The API exposes a safe iterator that yields `&SGEntry` references,
> allowing drivers to easily access the DMA address and length of each
> segment in the list.
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

<snip>
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by =
`ptr` is valid for the
> +    /// lifetime `'a`.
> +    #[inline]
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::scatterlist) -> &'a Self =
{
> +        // SAFETY: The safety requirements of this function guarantee th=
at `ptr` is a valid pointer

nit: "guarantees".

<snip>
> +impl SGTable {
> +    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` po=
inter.
> +    ///
> +    /// This allows safe access to an `sg_table` that is managed elsewhe=
re (for example, in C code).

nit: "to a".

> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    ///
> +    /// - the `struct sg_table` pointed to by `ptr` is valid for the ent=
ire lifetime of `'a`,
> +    /// - the data behind `ptr` is not modified concurrently for the dur=
ation of `'a`.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::sg_table) -> &'a Self=
 {
> +        // SAFETY: The safety requirements of this function guarantee th=
at `ptr` is a valid pointer
> +        // to a `struct sg_table` for the duration of `'a`.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    #[inline]
> +    fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.inner.0.get()
> +    }
> +
> +    fn as_iter(&self) -> SGTableIter<'_> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_ta=
ble`.
> +        let ptr =3D unsafe { (*self.as_raw()).sgl };
> +
> +        // SAFETY: `ptr` is guaranteed to be a valid pointer to a `struc=
t scatterlist`.
> +        let pos =3D Some(unsafe { SGEntry::from_raw(ptr) });
> +
> +        SGTableIter { pos }
> +    }
> +}
> +
> +/// # Invariants
> +///
> +/// - `sgt` is a valid pointer to a `struct sg_table` for the entire lif=
etime of an [`DmaMapSgt`].

nit: "of the".

> +/// - `sgt` is always DMA mapped.
> +struct DmaMapSgt {

Minor point: I'd call this structure `DmaMappedSgt` to highlight the
fact that it is actively mapped. Or alternatively document it and its
members so that fact is clear.

<snip>
> +impl<'a> IntoIterator for &'a SGTable {
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    #[inline]
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.as_iter()
> +    }
> +}

While using this for Nova, I found it a bit unnatural having to call
`into_iter` on references intead of just having an `iter` method.
`into_iter` sounds like the passed object is consumed, while it is
actually its (copied) reference that is. Why not have a regular `iter`
method on `SGTable`? Actually we do have one, but it is called `as_iter`
and is private for some reason. :)

> +
> +/// An [`Iterator`] over the [`SGEntry`] items of an [`SGTable`].
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item =3D &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        let entry =3D self.pos?;
> +
> +        // SAFETY: `entry.as_raw()` is a valid pointer to a `struct scat=
terlist`.
> +        let next =3D unsafe { bindings::sg_next(entry.as_raw()) };
> +
> +        self.pos =3D (!next.is_null()).then(|| {
> +            // SAFETY: If `next` is not NULL, `sg_next()` guarantees to =
return a valid pointer to
> +            // the next `struct scatterlist`.
> +            unsafe { SGEntry::from_raw(next) }
> +        });

This might be missing a stop condition.

For reasons I am not completely clear about, the number of mapped
segments on the device side can be smaller than the number of
scatterlists provided by the sg_table. This is highlighted by the
documentation for `dma_map_sg_attrs` [1] ("Returns the number of mapped
entries (which can be less than nents) on success") and `sg_dma_address`
[2] ("You should only work with the number of sg entries dma_map_sg
returns, or alternatively stop on the first sg_dma_len(sg) which is 0.")

`dma_map_sgtable` stores the result of `dma_map_sg_attrs` into its
`nents` member, and makes use of it in its iterator macros. See how the
"regular" iterator and the "DMA" ones differ in their stop condition:

/*
 * Loop over each sg element in the given sg_table object.
 */
#define for_each_sgtable_sg(sgt, sg, i)		\
	for_each_sg((sgt)->sgl, sg, (sgt)->orig_nents, i)

and

/*
 * Loop over each sg element in the given *DMA mapped* sg_table object.
 * Please use sg_dma_address(sg) and sg_dma_len(sg) to extract DMA addresse=
s
 * of the each element.
 */
#define for_each_sgtable_dma_sg(sgt, sg, i)	\
	for_each_sg((sgt)->sgl, sg, (sgt)->nents, i)

The DMA variant being the only one valid for accessing the DMA address
and DMA length (the C does not enforce this however).

So only calling `sg_next` until we reach the end of the list carries the
risk that we iterate on more items than we should, with the extra ones
having their length at 0 (which is likely to be a no-op, but is still
incorrect or at the very least inefficient). We can avoid this by either
storing the value of `nents` in the iterator, or, (which might be
simpler) follow the advice given by the documentation of
`sg_dma_address` and also stop if the DMA length of the next one is
zero.

[1] https://elixir.bootlin.com/linux/v6.16/source/kernel/dma/mapping.c#L233
[2] https://elixir.bootlin.com/linux/v6.16/source/include/linux/scatterlist=
.h#L31

