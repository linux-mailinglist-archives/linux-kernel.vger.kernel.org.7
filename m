Return-Path: <linux-kernel+bounces-892307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B1C44D23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55EAB4E6CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E326158C;
	Mon, 10 Nov 2025 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XxdJrUmB"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063926056E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762744394; cv=fail; b=YPLtfL8V7PfU2/FS3qa0A10Bz0hBWYuBdLXrrCoUzWcEXq4ez7KbxpiEdY4yQ+jloV/qZthrN71WNf7QOw/oM+dXMxJK6TZl+o4+Q6+uocZNZA/KS0/hg0j0DoBKlXbg+1rPU2DJkaYo6Ed6jhkZGXhTmwOp4vnkclakGw5o6iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762744394; c=relaxed/simple;
	bh=7eK3DUaeOcT/IEdcy+eJCGr9/LAjyIrVhISl7gQ8zTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1aFxVTmsj5HENWwCUp74bYPtTE0NiAA8EJqrcxtxhg2QMr3mSgWdovYwHSy22gE13bYJqIgxcEraVCiNTeSVEJc4IsP95WItxb38UkgGG/Gnh7afQvA0jFy1m3FySHz88Eq9Vz8293aUUKH43ciRZzx7oJY0ulAQQzOy+HhXiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XxdJrUmB; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY64eMJQj/62q9y6HAF1u6Q4kWeYCsz5BuPNAB2GzFQqI22mWeWohoMJTJZQiryPilYuo6JrTqA4DfXorwiX5UNDqTDAJ2FWSu8n5gD2rkSRNxqEqqSDNT6mf2fLEDsgP8dzRd2x6H6HzYt7clf5fdN+nSQiZeHO7QzGNPy9CHPWKfvx9HWXr65HKYU/Tn1u+ZFfDLQwHvdQGdCV5yeuh1MW0N3X9xc9zKz8H2pk+XYKgth8sbg+drbbV5TcnmE5xscii1RugpRm19Yymqb/VvpYlq44st15Y6H68tpsmxtqecIH4A1tuQm1ZNzfNB5mg8DxYPyrJ2EvkWnDrk867g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAN5VqDaeKalvKwETlWE67qEdKoFyLXKfyHBoLE+OG8=;
 b=FH/R8naJjKXVxuBK1kx7353JWn/zluB+D8hXv7Re/j+5Ws2KwAFVJP4sizKjrAnECYG5Tfe3ov0lxXOS51gSd1peeAK4EBKMOc8sKIzNkVeLOQSY3pwXYaLhzekVZLgeqPBdqJn2nLI655CzGhmFmtqQimRD2/v6rvhFtr9moz6l1hIG5n2Ck2z8g3pRkHRTChUjvVRpBhD1KjDTqKMCQ9aV1/qZk5T9P/vbXKcfBHQRvX1gwvqu7VAH2xzKE3yo+1m0t6fBGSW7mJAV8WzyOCM4bR5PGJbN8nvDWs8X9AQb+f9IR3maB1r6E0K9uSPcneFQ0TG/iZyXEQSVVwyYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAN5VqDaeKalvKwETlWE67qEdKoFyLXKfyHBoLE+OG8=;
 b=XxdJrUmBzX3ybz/WP3bdLtnjcR5j8+5I86VhrBElgwxkng3gq+ls2HSO/bRBD8vQJFj1iZpnv9IeZ6qoY19ifSB6GVzCi2XHbsunaBMF+N8Lk7fOlxXFIbx/xeVOKk3qKH9EazY1V6ETPRGwmrQfDqfHLDY0UPAY1LC8YGIcbPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:13:09 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:13:09 +0000
Message-ID: <c8854e18-94bb-45b9-8e82-67db5db9a02b@amd.com>
Date: Mon, 10 Nov 2025 11:12:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates
 a new BO
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, pratap.nirujogi@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 alexander.deucher@amd.com, benjamin.chan@amd.com, christian.koenig@amd.com,
 dantony@amd.com, gjorgji.rosikopulos@amd.com, king.li@amd.com,
 phil.jawich@amd.com
References: <20251105232108.107765-1-sultan@kerneltoast.com>
 <a6063bc0-4ba1-4cad-9045-5fa31ea4ed7a@amd.com> <aQzv00We7FyKAWk7@sultan-box>
 <cbf09540-df4b-4e2d-9e46-e6893af79fba@amd.com> <aQ0FkZv_l8UPLhvr@sultan-box>
 <5b1c1686-c48a-4f43-80cb-941c52dc103f@amd.com>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <5b1c1686-c48a-4f43-80cb-941c52dc103f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0093.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::33) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7623c59a-cb10-47bf-7192-08de2007130b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUt4M1RlcGEvMGlTZklSbndhMjBXdzgwUk9BSmZVSHdmK3ZUblBRR0ZJTlh3?=
 =?utf-8?B?eS9DbStabGhIZW5IM3RSeFpjVDV6azlQTDNSNjB6ZnZTZUk5YjRkdkVSUmxh?=
 =?utf-8?B?NFhMYThuNHNGR3Y3UEd5bHhhdW1qZnpSemUrVEwzY2lOR0RKdU9hd1dMZjVz?=
 =?utf-8?B?cUdUMmZHZ09NRXgwTXkrVGpDYVVMaXhDbEdFa2c4YUF4QkhMbUF2YVAvdjJR?=
 =?utf-8?B?czl5S2htUmVtd0R6cXEvUTJmMXFHc2JrYWRHanV0OTA2S2lsUis4ekcxR3h6?=
 =?utf-8?B?czlQN0M2a3ZLT1pneVRuaEFJVXkxS3Y5VDNBMS9IaER4LzFUMEY1NGE2MHRi?=
 =?utf-8?B?TVJvbTkvOXM4RmE3VG1zUUpoN24yNy95VndNd0ZZbUFKaDBsM2c3cTc4SlFX?=
 =?utf-8?B?S2RBdS9MMUR5bllrNVZFQjdmckhUa0tsd2RmSlFMSVJ4K3lHVDJaNlc4cDJ4?=
 =?utf-8?B?VENiSnFRWHBjTGtTSjB0OVRkelJrSEpOVmJKWXZsZHNFQmZQeXFwNVpRcCtN?=
 =?utf-8?B?bE8xODQwSlhZeGJvUGtVZmdNbTdNTUpQTStSK3NJSHAwb3JwUzRLdlB6dEJu?=
 =?utf-8?B?ci9obEd0TXlCUzIvZGhrS1pVdnhYSlUwbGltaDRZeDdkL0R6M0k0VnhpeExs?=
 =?utf-8?B?ZXE5Z2lxL2ZjZ2dYK2JxbGNaMU1ydTAwcHJWRnZhYmZNZ3hRRHNOZGRpUUVx?=
 =?utf-8?B?K2FmMHkxOXVSeWpmM3VTc3RKQThkTzdLS1RvTUdhQWFLUUFyMU1yTnJzV3Vt?=
 =?utf-8?B?RnlkMGt1bHlZa0g2YU8wb1hzanVTcktxODZPRGhSWEdaeWtaQXpQcy85RkZO?=
 =?utf-8?B?MGM3T1g4dTVrdTVySkRxcGpWTnd4RTVNU2t0SmMxWS9vTVhBRWE0YzZ3V2Zh?=
 =?utf-8?B?NGxDUGR2dVFkdlZWOTd4SWYvTG9xS041cGxzbGg0enIyMmgyaE5qMHErU1FD?=
 =?utf-8?B?VmtFb294V3N2SXJNV0JtaUNOckd3cXF4bmFFaSt2dGx0WStuZmVLOWRrdlYv?=
 =?utf-8?B?NjdZRWVaa3c4d001RlBhSnB3TnZ3cmVuRndSMDl3ZFNBUTU3aW8zb2tzMi9O?=
 =?utf-8?B?WXcwUlY0RGZWOWI5UWs3eXhCY3hkd1NOeFczUjc2QkNuYzB3ZU9xb2JISklI?=
 =?utf-8?B?Q0JHVGdUVi9qVGoxTnd2U3B2WEZGeG1DcGUza1ozckczajh3OWxLNHYzRUJO?=
 =?utf-8?B?RDRjWGNLZUIyRHhuQmJyNTBiS1I5Rk5tY0V2WHJxN1ZwR21rQkllSE5TTVJj?=
 =?utf-8?B?bEZLVGVsc3ZzS05XNGtVMjFYVW1TcnFERmFob2FNOUd3S3l6NkpwUVk2TGc5?=
 =?utf-8?B?TW9pWlJtYWhzcjRPaG5zb1FLcWVmczFycHk4c2l3NUR6VllYbmpxaUVwSUd3?=
 =?utf-8?B?ZldNUS9mUW1MYnZOWkduRlkrY25xZkRHNlVJVy9UblVsbXVyRzVCWDduVld6?=
 =?utf-8?B?disxdGJoaXU2eTR6ZUd2RGx2WVVXbEdYYmVoUDcvUkFkdXFpTmt1VjJDY01V?=
 =?utf-8?B?RXJiYlY3N0szWURGM1pSVlpwY0FXeEJqTC9RMFAzMG9tZThVbGh4ZTN3cVRB?=
 =?utf-8?B?TWVYQTdJSnJ1N0FPWm1UZ21CNkxXUk5DSVF5MExaRFpxMSs2cXFHV2FQWWlw?=
 =?utf-8?B?UEFtZnQ2Y1E2bjNMb3NkOUFTSHNXeWphcVBmdkRLRXIwODkvbXJJYzhhR2x6?=
 =?utf-8?B?dXhlb1I1TEp0WEVNc3RBb3g5QW1yQlBubmpCdERKdkI3YkFKeGh2NHJZREpO?=
 =?utf-8?B?N3VOOGpWaVM5d1k1SDFNUUhWVFBiL0ZVUERjTDRFWCtEd2duOFk4YXF4Rk13?=
 =?utf-8?B?SEw3WU1pSC9HVW9yekhLUWJ4TWdIUFBVaGF3Y0J1L2RWOUp1cmU2TGYzUTc1?=
 =?utf-8?B?dFlJUjU3MXNOTVJZdEsvdmRhV24rbzJiZlZ6QTBCSGdWS0JXQzR3S2F6YzFF?=
 =?utf-8?B?Q2srNkFVaUpCR2h0ZEZCNmtScGhRRXpPUUU5MWhCRUt4enRCTXNXRG83d3Nn?=
 =?utf-8?B?cDQ4VmtxblpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTlwWktJeDlHTlJRVzN4Q1dhc2hXWW9GdHpRT29KZUV5K1I0YmFRbmJJSi9w?=
 =?utf-8?B?V2ZRejNldHBUZko3N0c3YTNsYWtZMzJlUmh0SkJnaGdTbEoza0FXbWJyOEVp?=
 =?utf-8?B?R2hOMUsyQ2ZCQnR4Z2ZoRnNPVm9VTXMxTHhrNWFEZS9RaFlxNWlEVDlyTStJ?=
 =?utf-8?B?azZCQjlObTRvSmo3SjFrSktvZXJqRnZSZUU3NUREUVA4TXpIWUxRLzhJNEdN?=
 =?utf-8?B?NUpOMkQzbGM2cjMrY05aZHB3dGtMZ1gzRE9nQ2FyeTVqZkRSbURyUExrMjJr?=
 =?utf-8?B?ZHM3OTUyRmZMV1ZaRGZob2c1L3JZNXIrSC9OWThzaEZPVDN4K1pTRGE4ZHoz?=
 =?utf-8?B?NHF2c2tvYXFqd3hGMlZQZ1d6QnU5SlVPK05ZSDY2RDFyMzRQbFF3RUtYOUZ0?=
 =?utf-8?B?Z2o4bm5KTWduOExXNVM3UGc0NnlFazhrSnRtRmFOUkpWQUpLTmJ2RHh4UlpV?=
 =?utf-8?B?ODlvNnFMdWIvWERLVXRKUjBFdzZCVWlndXFQbTcwcHZYQUpjVTVGcXk5aEk4?=
 =?utf-8?B?c2N5Ymxra0FJbGpPTFJwcDFrRDd6UnFmVTBES21ZT3BJK3hlMWovWFBldGFj?=
 =?utf-8?B?cmpJelhqVytKSWprTFdDbmlNRFQxOUJyUDRlSHZIYlNuU2ZrZUJFMCtwTC9m?=
 =?utf-8?B?dXRWSlhLZllkQUQ5NUw0ZklmU2ZDclJTWG5MOGx1eE8vdm1BUElsNVZUY1JV?=
 =?utf-8?B?cXpqYk9JMUlKVDBvTjYwcDYrRCsyNGtTcm9TTHN0M1AyTENGelVsTTVxa1ZK?=
 =?utf-8?B?NG03RkVyUGx3Sm9yZjlIalNWTVp1cG8rZkQ4OW1rUTBLQWVzWTJ1VVBMRXJX?=
 =?utf-8?B?TlM4RjdOWkhtNHhYRjhZUE9ESHNud0xZSFFIUUxvRml2NkIvV3hlUXVaNmo3?=
 =?utf-8?B?UzFvSENqblo2OUN0cDVzNG1LdFdXcEtTV2g2VzI0aUM3WTBaNlZGSTNsUXpE?=
 =?utf-8?B?SXM2QWJrZ21ZNTl6M09ZSkFjN1FTcjA3TktnMk5vMlh4bnd2MHMyL1JxeVBo?=
 =?utf-8?B?RXVrbXlaYXlaRERpdGRtOTQ2Q2I1aVFpRXlNamF2Y3l6OTArTGsrV0FEOHVw?=
 =?utf-8?B?VVUzbE81bzJaa2h5L2VHNEw2SWQzNi9lTEVEWVhYL3Bmem1ZRlFUT1hnL21h?=
 =?utf-8?B?bndqNGw3WlljZVR2dE5WbFZSM3ZmS1BYQ0RHM3pIS3d2Und1cXRHdXBFcW9Y?=
 =?utf-8?B?dzVBWTdzRU81S20yUm1VTzJyWmhGZGE2QVpyR01obzA0NlZLelViSEgxQ3ZG?=
 =?utf-8?B?eTVubithZTFTZy85Qi9jL1M0K0NMdUc1QnRyZy9oQkR4QS9MZHFkdDh0ZFR5?=
 =?utf-8?B?NWI5UTQvL0plYk84MXZwWFdYblQvSnJVdHVYdU1iWUlvcHdjbDBCbVVzendC?=
 =?utf-8?B?a3pZeHREeGxxYTVoWkRQMVNJQU1FMlNlNmR2N0xXcUk1eWtnbFBmS0JLSzMr?=
 =?utf-8?B?R3U4bVBESEN6c1Jvc3VpeHJISzF4SVB6L20wVjJWT2xKcHNpV1d5bUlCaWRY?=
 =?utf-8?B?WTVIS2ozbnJicTd3K1pNS1hjdXpuUW9jY0VUOGFBZTJaa2w4NGI5NGU1UlU2?=
 =?utf-8?B?VDBMNG1PbDlSZFpGWjNHUVlJOU1tWUlDZUFBNWRFaS9OUm1lUHZZekEvUnVy?=
 =?utf-8?B?ZFhkRk5ScUxYVmE0SVBVZGpWODRoeFU3ck13SjkxeVVxVnhhNS9GdHpRUmNm?=
 =?utf-8?B?RHY3N0pCV3pHakM3OCtNV2xvOS9hM1VBdDlTN0hGY1J3SHJmaTdEbmNZUml1?=
 =?utf-8?B?Nkl6b3dsUWM1bWJJWVlORVpVTExJZTFvQmpaaG5iVUxrNkQ2QzBjblp0cnBM?=
 =?utf-8?B?clVmMUpsTjJ6Q0VlWW12eE4ySThWM1dUaExPL1VvSU5NNjlwN2VuaWFIelRu?=
 =?utf-8?B?eUZOaWQ0VlBJSU9OaXVHN2M0NG8yMnU4clErNTNoTFJGUWQ3bGRBbURKak5o?=
 =?utf-8?B?YzFMZktjdkhFN0ZOWEhkbHRuWTNTSnJlUVlEZ1JDT3k3OEJrV3JyQkpHcDNl?=
 =?utf-8?B?UWQwVCthQUZDc3FRTXNYalppNEJ6ak12ZUNTSXJoNmt1VHdHUDlZYlFlRTFC?=
 =?utf-8?B?R1RFZVhmN0RkQjFuUGNmSDdLZmttWjRuZWVLaFIvY3BHOUIzUHhkdk5LdTJj?=
 =?utf-8?Q?JZgc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7623c59a-cb10-47bf-7192-08de2007130b
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:13:09.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkDMNAW6vzjglZ1Hfu/+u+XKPxlIBC5pOnCrx+1zN+gtrWWOe/bMfu6d7Vw3Rdiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

Thans Sultan & Pratap,

So, based on the discussion, the ISP driver will retain its current 
implementation and won’t do unnecessary init to *bo before calling 
isp_kernel_buffer_alloc().

On 11/7/2025 4:51 AM, Nirujogi, Pratap wrote:
> 
> 
> On 11/6/2025 3:31 PM, Sultan Alsawaf wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On Thu, Nov 06, 2025 at 03:08:44PM -0500, Nirujogi, Pratap wrote:
>>>
>>>
>>> On 11/6/2025 1:58 PM, Sultan Alsawaf wrote:
>>>> Caution: This message originated from an External Source. Use proper 
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> On Thu, Nov 06, 2025 at 12:46:51PM -0600, Mario Limonciello wrote:
>>>>> On 11/5/25 5:21 PM, Sultan Alsawaf wrote:
>>>>>> From: Sultan Alsawaf <sultan@kerneltoast.com>
>>>>>>
>>>>>> When the BO pointer provided to amdgpu_bo_create_kernel() points to
>>>>>> non-NULL, amdgpu_bo_create_kernel() takes it as a hint to pin that 
>>>>>> address
>>>>>> rather than allocate a new BO.
>>>>>>
>>>>>> This functionality is never desired for allocating ISP buffers. A 
>>>>>> new BO
>>>>>> should always be created when isp_kernel_buffer_alloc() is called, 
>>>>>> per the
>>>>>> description for isp_kernel_buffer_alloc().
>>>>>
>>>>> Are you just going off descriptions, or is there a problem with reuse?
>>>>
>>>> I am going based off the ISP4 driver's usage of 
>>>> isp_kernel_buffer_alloc().
>>>>
>>>> This fixes the following crash I experienced on v5 of the ISP4 
>>>> patchset:
>>>>
>>>>     [  175.485627] BUG: unable to handle page fault for address: 
>>>> 00007f6b1092e888
>>>>     [  175.485799] #PF: supervisor read access in kernel mode
>>>>     [  175.485840] #PF: error_code(0x0000) - not-present page
>>>>     [  175.485869] PGD 0 P4D 0
>>>>     [  175.485889] Oops: Oops: 0000 [#1] SMP
>>>>     [  175.485908] CPU: 15 UID: 1000 PID: 57022 Comm: cheese 
>>>> Tainted: G     U  W           6.17.7 #1 PREEMPT
>>>>     [  175.485921] Tainted: [U]=USER, [W]=WARN
>>>>     [  175.485933] Hardware name: HP HP ZBook Ultra G1a 14 inch 
>>>> Mobile Workstation PC/8D01, BIOS X89 Ver. 01.03.00 04/25/2025
>>>>     [  175.485943] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 
>>>> [amdgpu]
>>>>     [  175.485961] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 
>>>> 24 30 01 00 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 0f 
>>>> 84 a9 00 00 00 <49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 48 
>>>> 89 04 24 e8 d6
>>>>     [  175.485976] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
>>>>     [  175.485988] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 
>>>> 0000000000000000
>>>>     [  175.486002] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: 
>>>> ffff97b14e097b20
>>>>     [  175.486012] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: 
>>>> ffff97b085af04c8
>>>>     [  175.486023] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 
>>>> 0000000000000002
>>>>     [  175.486031] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: 
>>>> ffff97b0a0f00000
>>>>     [  175.486037] FS:  00007faf60ffe6c0(0000) 
>>>> GS:ffff97cfa7133000(0000) knlGS:0000000000000000
>>>>     [  175.486046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>     [  175.486058] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 
>>>> 0000000000f50ef0
>>>>     [  175.486067] PKRU: 55555554
>>>>     [  175.486072] Call Trace:
>>>>     [  175.486081]  <TASK>
>>>>     [  175.486092]  ? smu_cmn_send_smc_msg_with_param+0xc0/0x360 
>>>> [amdgpu]
>>>>     [  175.486102]  amdgpu_bo_create_kernel+0x15/0x70 [amdgpu]
>>>>     [  175.486110]  isp_kernel_buffer_alloc+0x56/0xa0 [amdgpu]
>>>>     [  175.486118]  isp4if_gpu_mem_alloc.isra.0+0x45/0x70 [amd_capture]
>>>>     [  175.486126]  isp4if_start+0x3a/0x320 [amd_capture]
>>>>     [  175.486141]  isp4sd_set_power+0x96/0x1e0 [amd_capture]
>>>>     [  175.486148]  pipeline_pm_power_one+0xf2/0x110 [videodev]
>>>>     [  175.486155]  pipeline_pm_power+0x51/0x90 [videodev]
>>>>     [  175.486161]  v4l2_pipeline_pm_use+0x3b/0x60 [videodev]
>>>>     [  175.486169]  isp4vid_qops_start_streaming+0x22/0x140 
>>>> [amd_capture]
>>>>     [  175.486176]  ? isp4vid_qops_buffer_queue+0xb1/0x140 
>>>> [amd_capture]
>>>>     [  175.486185]  vb2_start_streaming+0x79/0x140 [videobuf2_common]
>>>>     [  175.486192]  vb2_core_qbuf+0x3b5/0x480 [videobuf2_common]
>>>>     [  175.486200]  vb2_qbuf+0x98/0x100 [videobuf2_v4l2]
>>>>     [  175.486208]  __video_do_ioctl+0x480/0x4b0 [videodev]
>>>>     [  175.486219]  video_usercopy+0x1e5/0x760 [videodev]
>>>>     [  175.486226]  ? v4l_s_output+0x50/0x50 [videodev]
>>>>     [  175.486237]  v4l2_ioctl+0x45/0x50 [videodev]
>>>>     [  175.486245]  __x64_sys_ioctl+0x77/0xc0
>>>>     [  175.486251]  do_syscall_64+0x48/0xbf0
>>>>     [  175.486260]  entry_SYSCALL_64_after_hwframe+0x50/0x58
>>>>     [  175.486268] RIP: 0033:0x7fb03371674d
>>>>     [  175.486275] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 
>>>> 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 
>>>> 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 
>>>> 25 28 00 00 00
>>>>     [  175.486282] RSP: 002b:00007faf60ffc9d0 EFLAGS: 00000246 
>>>> ORIG_RAX: 0000000000000010
>>>>     [  175.486292] RAX: ffffffffffffffda RBX: 00007fafb40050b0 RCX: 
>>>> 00007fb03371674d
>>>>     [  175.486301] RDX: 00007faf60ffca70 RSI: 00000000c058560f RDI: 
>>>> 000000000000002c
>>>>     [  175.486306] RBP: 00007faf60ffca20 R08: 13455f273d2513b9 R09: 
>>>> 0000000000000210
>>>>     [  175.486313] R10: 0000000000000215 R11: 0000000000000246 R12: 
>>>> 00007faf9801c4b0
>>>>     [  175.486318] R13: 0000000000000001 R14: 00007faf60ffcad0 R15: 
>>>> 0000000000000001
>>>>     [  175.486324]  </TASK>
>>>>     [  175.486330] Modules linked in: ccm hid_sensor_prox 
>>>> hid_sensor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer 
>>>> kfifo_buf hid_sensor_iio_common industrialio hid_sensor_hub rfcomm 
>>>> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device amd_capture 
>>>> videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc 
>>>> pinctrl_amdisp i2c_designware_amdisp uhid cmac algif_hash 
>>>> algif_skcipher af_alg bnep uinput nls_iso8859_1 vfat fat 
>>>> snd_acp_legacy_mach snd_acp_mach snd_soc_nau8821 snd_acp3x_rn 
>>>> snd_acp70 snd_acp_i2s snd_acp_pdm joydev snd_soc_dmic snd_acp_pcm 
>>>> mousedev intel_rapl_msr snd_sof_amd_acp70 snd_sof_amd_acp63 
>>>> snd_hda_scodec_cs35l56_spi intel_rapl_common snd_ctl_led 
>>>> snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_hda_codec_alc269 
>>>> snd_sof_amd_renoir snd_hda_scodec_component snd_sof_amd_acp 
>>>> snd_hda_codec_realtek_lib snd_sof_pci snd_sof_xtensa_dsp 
>>>> snd_hda_codec_generic snd_sof snd_sof_utils snd_pci_ps 
>>>> snd_soc_acpi_amd_match amdgpu snd_amd_sdw_acpi snd_hda_codec_atihdmi 
>>>> soundwire_amd soundwire_generic_allocation snd_hda_codec_hdmi
>>>>     [  175.486373]  soundwire_bus snd_soc_sdca snd_soc_core 
>>>> snd_compress snd_hda_intel ac97_bus snd_pcm_dmaengine mt7925e 
>>>> drm_panel_backlight_quirks amdxcp snd_hda_codec snd_rpl_pci_acp6x 
>>>> mt7925_common btusb drm_buddy cdc_mbim mt792x_lib snd_acp_pci 
>>>> cdc_wdm btrtl drm_exec snd_hda_core snd_amd_acpi_mach 
>>>> mt76_connac_lib snd_hda_scodec_cs35l56_i2c btintel 
>>>> snd_acp_legacy_common drm_suballoc_helper cdc_ncm snd_intel_dspcfg 
>>>> mt76 snd_hda_scodec_cs35l56 snd_pci_acp6x cdc_ether drm_ttm_helper 
>>>> btbcm snd_intel_sdw_acpi snd_hda_cirrus_scodec snd_hwdep usbnet ttm 
>>>> snd_pci_acp5x btmtk snd_soc_cs35l56_shared ucsi_acpi kvm_amd 
>>>> mac80211 snd_pcm r8152 i2c_algo_bit snd_rn_pci_acp3x typec_ucsi 
>>>> snd_soc_cs_amp_lib libarc4 spd5118 bluetooth mii drm_display_helper 
>>>> snd_timer cs_dsp kvm typec snd_acp_config hp_wmi snd cfg80211 libphy 
>>>> amdxdna roles cec snd_soc_acpi ecdh_generic sp5100_tco 
>>>> hid_multitouch irqbypass sparse_keymap rfkill rapl mdio_bus video 
>>>> gpu_sched amd_pmf wmi_bmof snd_pci_acp3x soundcore amdtee 
>>>> i2c_hid_acpi serial_multi_instantiate
>>>>     [  175.486384]  i2c_hid amd_sfh thunderbolt wireless_hotkey 
>>>> amd_pmc platform_profile wmi mac_hid i2c_piix4 i2c_smbus i2c_dev sg 
>>>> crypto_user loop nfnetlink ip_tables x_tables dm_crypt 
>>>> encrypted_keys trusted asn1_encoder tee dm_mod polyval_clmulni 
>>>> ghash_clmulni_intel aesni_intel nvme nvme_core nvme_keyring 
>>>> serio_raw ccp nvme_auth
>>>>     [  175.486394] CR2: 00007f6b1092e888
>>>>     [  175.486402] ---[ end trace 0000000000000000 ]---
>>>>     [  175.486409] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 
>>>> [amdgpu]
>>>>     [  175.486416] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 
>>>> 24 30 01 00 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 0f 
>>>> 84 a9 00 00 00 <49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 48 
>>>> 89 04 24 e8 d6
>>>>     [  175.486422] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
>>>>     [  175.486429] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 
>>>> 0000000000000000
>>>>     [  175.486433] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: 
>>>> ffff97b14e097b20
>>>>     [  175.486439] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: 
>>>> ffff97b085af04c8
>>>>     [  175.486444] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 
>>>> 0000000000000002
>>>>     [  175.486448] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: 
>>>> ffff97b0a0f00000
>>>>     [  175.486455] FS:  00007faf60ffe6c0(0000) 
>>>> GS:ffff97cfa7133000(0000) knlGS:0000000000000000
>>>>     [  175.486460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>     [  175.486464] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 
>>>> 0000000000f50ef0
>>>>     [  175.486470] PKRU: 55555554
>>>>
>>>> Admittedly, it's my fault that ISP4 stopped zeroing the BO pointer 
>>>> argument
>>>> (&mem_info->mem_handle) passed to isp_kernel_buffer_alloc() [1]. But 
>>>> since this
>>>> issue slipped past Bin and presumably others who reviewed the code, it
>>>> highlights that isp_kernel_buffer_alloc() is not working as expected 
>>>> in this
>>>> respect, and the description for isp_kernel_buffer_alloc() 
>>>> reinforces this.
>>>>
>>> Thanks Sultan for suggesting this fix. Yes, its hard to believe that 
>>> this
>>> slipped through until now.
>>>
>>> Instead of initializing *bo=NULL, I suggest ensuring *bo is actually 
>>> NULL
>>> before calling amdgpu_bo_create_kernel().
>>>
>>> int isp_kernel_buffer_alloc(...)
>>> {
>>>        ...
>>>        if (WARN_ON(*bo))
>>>                return -EINVAL;
>>>        ...
>>>        ret = amdgpu_bo_create_kernel(..)
>>>        ...
>>> }
>>>
>>> This way the caller will get to know parameters passed are invalid 
>>> and can
>>> take care of initializing the handles appropriately.
>>
>> Hi Pratap,
>>
>> I am opposed to this idea for multiple reasons:
>>
>> 1. *bo is an output parameter from isp_kernel_buffer_alloc(), so the 
>> input value
>>     should not matter.
>>
>> 2. The only correct value for *bo is NULL when 
>> isp_kernel_buffer_alloc() passes
>>     it to amdgpu_bo_create_kernel(). Since there is only one correct 
>> value, there
>>     is no reason to burden callers of isp_kernel_buffer_alloc() with 
>> intializing
>>     *bo to NULL.
>>
>> 3. This adds more code, another WARN_ON(), and another error case to
>>     isp_kernel_buffer_alloc(). All of that can be eliminated entirely 
>> by just
>>     initializing *bo to NULL in isp_kernel_buffer_alloc(), as I've done.
>>
>> 4. The reason *bo needs to be NULL is an implementation detail that is 
>> internal
>>     to isp_kernel_buffer_alloc(), because amdgpu_bo_create_kernel() 
>> needs it to
>>     be NULL in order to allocate a new buffer. 
>> isp_kernel_buffer_alloc() should
>>     handle its own internal implementation details instead of punting the
>>     responsibility onto callers.
>>
>> Sultan
>>
> Either approach works for me. My main intention is to ensure the caller 
> passes the BO handle initialized to NULL in this case. That said, 
> initializing *bo = NULL as you explained is perfectly fine too.
> 
> Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> 
>>>
>>> Thanks,
>>> Pratap
>>>
>>>>>>
>>>>>> Ensure this by zeroing *bo right before the 
>>>>>> amdgpu_bo_create_kernel() call.
>>>>>>
>>>>>> Fixes: 55d42f616976 ("drm/amd/amdgpu: Add helper functions for isp 
>>>>>> buffers")
>>>>>> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/ 
>>>>>> gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>> index 9cddbf50442a..37270c4dab8d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>> @@ -280,6 +280,8 @@ int isp_kernel_buffer_alloc(struct device 
>>>>>> *dev, u64 size,
>>>>>>       if (ret)
>>>>>>               return ret;
>>>>>> +   /* Ensure *bo is NULL so a new BO will be created */
>>>>>> +   *bo = NULL;
>>>>>>       ret = amdgpu_bo_create_kernel(adev,
>>>>>>                                     size,
>>>>>>                                     ISP_MC_ADDR_ALIGN,
>>>>>
>>>>
>>>> [1] https://lore.kernel.org/all/aNB0P18ytI1KopWI@sultan-box/
>>>>
>>>> Sultan
>>>
> 

-- 
Regards,
Bin


