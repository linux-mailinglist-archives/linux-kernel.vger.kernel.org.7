Return-Path: <linux-kernel+bounces-888228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA38C3A3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 643664FAF8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60642475D0;
	Thu,  6 Nov 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRPLceBY"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758426B08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424517; cv=fail; b=tG6LeGzS1lSgtFK5ftVIF23FaGmav33p025PSu1EWsVfwHpI1GFfTWF1xnMSdLNOWri9BwS8wF5sAsvIHFmDC/2bbMS6rQ/qvj2BITSx9M+KTuct3kNKWmrQ6QEF86CADPFdFMfebhy5KWmfCCtCJDV3Hc/wFKXmLqBb87ii0Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424517; c=relaxed/simple;
	bh=azWRBOrFvatSeqVqdSLqGsvXqypoicJIvrdmKcdG5n0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvfyK3JQBm7STCD1a3mHtZ9rlbBaNwFr95ziNc0o4THXJRFgQCRlyCGtil3f9CK6N/56+NKtqIzyLp/HKonQgf8HEtjMb/6Yrf3QQp/Le4LQIYAtULIF9v2KXA4sXnJrIBQOc3sVn5ptGtrX2RQc5uRWfdP2vmh5edVV3JVfVjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRPLceBY; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xcr5JxZFiCBYrfpDxUavHp64JL3QR/Xj5z7j99vOEBmfHkWqO2jrQq+XqGH0zLjZszTt4aWrd7w0Xyjx3kKy8bkP7coTD1pqS0eoVO7NmGM5sC4Gnu/5Esn616EUfT2TgHFbT2MTMNaxSO1NE83QoQce5Tibn5EJ4YhePyps2I0cgTIQALGxwKgweJ3uB4nbcq3y1nhXuMfqoziCXG8l56mDwnX2uDJ/gdl3O4C4G4GIjQEFrp2YepqT3/QI1sZIqOCheRCWxn+hFZsmWFJCuCOu/xiIEfM10Q19C8xUQz6wAvLmhqOhtM6IlBwRPC0xDd9TUw9JAhlDaQhysfMhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Do9GHSa/EyruZ6DFAbwjbN1kYLLAE9mIZnBKHJ+kQ=;
 b=YzTTKPx4OtC2WGYaeiUG1hlktp2pcCjMZAAYMqwodvGsupig0IuBf5pUK5yL63MHMlhDQTrLtJV8nZoa5xkYrRHKDSAuGA1HWdrKSlVZ5rNb/V7aVBiRUMM1InVwnFJO+2PDRZ9UArnwm6a1J6GhWrHY4Gr3q+V9e9Dc0exWJM3WNV5iIwBdBZSpo5VRaJdRnbzlE3sBTayZwwb6gxhm5EvXs+7938yRkpBoDDhI40wQsTV37u0VeBF0xbHAywzCIMQE32FXYM9ZxtrbhLLdQhtp7kDpsgHnuxikc6yKMjNlxJxx8nfOFY1wHMrnBm2UrzLtdPv0uPgR8JhpPAd0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Do9GHSa/EyruZ6DFAbwjbN1kYLLAE9mIZnBKHJ+kQ=;
 b=xRPLceBYdNAsPMiD+4aPktoxLC1MPdSgHB3eFDX01+e8GzSI7ZBfCgUT/yB2FwebdQerYjQiaF2MDdJvhvxJIJSdiYO+1q5rOApdxoiwawYpxdrPG6GUSKHzIRnPN6ZlAJCTunyHAFz8u5OmLccyCniscJ39+9zTEe9dK02Pil4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:21:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 10:21:52 +0000
Message-ID: <a3830a0e-5491-4bb7-8685-3427f4874d95@amd.com>
Date: Thu, 6 Nov 2025 11:21:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amdgpu: jump to the correct label on failure
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
 <63ce6781-439d-4425-a3e9-f1d233a5abea@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <63ce6781-439d-4425-a3e9-f1d233a5abea@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:408:e3::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a28f03c-bd02-48df-facf-08de1d1e4daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHRpdFo4TW9MNExFcnNwVFBjSkIzczRUVUR6aDRpdVluM2g0Q1lzSjF2OEFE?=
 =?utf-8?B?MCtOTFNwYWVsQXpCa0NyYUJlVkZ4MHRDN3BYelVDd0dMQllWQTA2WWRYRmZj?=
 =?utf-8?B?cUpNcndyRVFlckYxRXhzM1ZDWGRWcFNIWjdRcUlMWVhuM0tPL21qcUFLbXJF?=
 =?utf-8?B?dW5yOWx6LzNtd2dySlp6bzZVRkVmeWhhQUFFUFJNZk5VakJkdEF0R3Q4QjVQ?=
 =?utf-8?B?d0R3d0FyU0VoVDBBcjVZN3ZZYU9IWW1qd290WW9XTGZtY1FkRnovY1dqMVJF?=
 =?utf-8?B?eWRNUGRmaER5dDEwalo0MUQzdGJpTGNDc2xKM0plYWQweC93OVAwaWhMSEVF?=
 =?utf-8?B?bGtYbEE4TWJTaFMzcHZOVndLT2NRYWdnUVlmNTBLa0ZUemN0QjJod04wc0l3?=
 =?utf-8?B?RG9CbUFsb29pY3k4RE9GcDlmQzZYLzNTWTRHU3prRHpWSGZyL3dPR1ZYQWN6?=
 =?utf-8?B?RE1oY09lUUswaVJ6eXlrQk1kREEwTVdRbDZiVG8yMkoxTEFQUkhpYVNyNjBy?=
 =?utf-8?B?TUZBWkM5MFREQ1dwUU1BK29uR0N3cmtpbTFLRy81MVA5bG4xdTZ0R09PNlpL?=
 =?utf-8?B?ZWU5KzcxdnJNQTJab3A1b3VOTHVWTC9DdlNzRHBOYnI2cVRobUw5VEZCUDYy?=
 =?utf-8?B?Zm1NQmI3bXF6dEtJZ1Nsb1kzZWRjNHA1aTNlem0zOXowQWZiRnkvajdPMDBt?=
 =?utf-8?B?ZHkvK2lFWlBkUWtsN213VGpseVlZanRIbml2c25qRDdLTTRmbW1QcDhOMVNB?=
 =?utf-8?B?RG1lSUxsYTVodm5jSlljTkt0WmNsbjZXR1hDUy83VWZacXRFa09aWkViV0tB?=
 =?utf-8?B?aFRRem1xRm96OHRrVkJMQ0Exc0ZQdjBwVVZSTngyVFI5VmhrSHlaZ085cHdN?=
 =?utf-8?B?TE4vdlN1a2hsUWdQTTdHcDFjZTEyM2xOLzNJWVF2a3AwTDNTb2xseTFNNFU2?=
 =?utf-8?B?M1hUYW4xQk9xZER6WFFxRG9xK0pQZHZnL2xWQVB1cmxrNHc5UXUxdzUrMkk0?=
 =?utf-8?B?dXM4anVVZmRuYkx0elM1d2NyMmJPM1hOVEN0OHFoWkYzWVM1cWpRNlNMOEZt?=
 =?utf-8?B?L2toeFJVWUk5ZDlXN1huNlJIK3lCcHZkZU9WUGNja2FGTS8xNUZaTVVhU284?=
 =?utf-8?B?MWtOSlgzQS9iTk5FVS9uWDIreXlHMmMyL25aYjdGM3VBVGsxeGRSaEc3R2FV?=
 =?utf-8?B?ZWRxL1NKU3VYM1NxL3ZLMGxzVk16MGlXZjNyZHErSkgyZ3hVT3QvbFZRMUE3?=
 =?utf-8?B?anB2OHZwdVZBRjNaeWtTVUpRNUVEM09nS2tYQUlPemVMT1BxVytiRzFqRUxS?=
 =?utf-8?B?Ykd5Tks3NnRVVjRXK1JRWHl0S0E0VkMwM1pVM2YxM1NqWHRZa1UrelcwanFh?=
 =?utf-8?B?ZmFPMUxjVWNaRVdIdTRlekYrZVFLSGdkNFJVd2MxQytHQmIwdHhSMGJIUDhh?=
 =?utf-8?B?QmxaVEo4dDc3UWg3STVXdFJPOGNYYXZqTVZOSmVvNUFPYWp6YjJ3MU53RnZn?=
 =?utf-8?B?aUUrQW1OamdjU1NWNFplSTdRVmdmQXozenU4YVcwaWl0ZmRGNzRMcSswdGRi?=
 =?utf-8?B?NHNUaTM1azB4am5QbFV3cDFJT213Tm1HcCtwd052cHZKbm10dDZ4cmlXRlpa?=
 =?utf-8?B?d3R6Q3FGRE1hcUw5NHh5bzR3NXQ4S2NndXhWcjU2MDJLdGdkQnlXMjhLRndM?=
 =?utf-8?B?Z3NMZTQ4dnFLaDlZandhdEtHNkh6NG1zbURKZHBXWmF1bW9HREJxREh6UWNq?=
 =?utf-8?B?K2VORU54RHVPTmViZStxNWNzRE01NE01ZVFtSW0zaUFFVmhKb0ZHZkd1L1N3?=
 =?utf-8?B?VmJVeEVmU2owTUpmOFd4ZmdPK05JZU5jNGorZnZsUmx2UHNTUk1TY3RLcXd4?=
 =?utf-8?B?S3NaVkJwdHNTa3NtZDl5N1JWcnFJSWRLeWZCdnBlbDFGMUtwZzVjUEpFeDJo?=
 =?utf-8?Q?naDAmT7+t/zvAWOOkAlfE89aBmdfDS6i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak5lWGd4REgyUHhYdjBsRzZMR3htQlo4bFV0RXFoa0NWY0JacU5EWWdEOW00?=
 =?utf-8?B?WnZ0YVNOaU0xY3BpTE1vKytDRUx6UTl4NW41QWF0VlR4eTUzZ2o5dDZUMEdp?=
 =?utf-8?B?T2dwWTJ2UlRGa0JheENCVWVIVnM0T1dkSktMUGFaS3FQeEZXaklyWXozRWFs?=
 =?utf-8?B?T1g4SEoxWHNmZXNhbld2Q0RNeXJlWHg1NFIxdVZsWTNIanZ1K1NDWlowMmFm?=
 =?utf-8?B?VGkrNTNJdS8vbDQ0NzVRRFdSYXhDRldVOTAxaEwrRUplc1o2NmJ6VXB2Y3VY?=
 =?utf-8?B?RnBDS2dPSmxWVDR6bjN6dTVXY0tqdjFGMkxjMTArcVRKU1R1S2xjbk9XbTBw?=
 =?utf-8?B?MlV6Wm16NExZZ2lBQ2NTVUp5QkUzVlcvZ0VPUDdLdC9idWxHYXRzN09ObXVU?=
 =?utf-8?B?bm5Nd3IwVVZNcklJMDZTTVVVVllVNDR1dUgyRkhTdi9sUGg5TElQRVAyNkMz?=
 =?utf-8?B?YVFIM0hsWFRaVDBTckhPTFVIRkFxcnd5MTczOHJENTdYd1J6aGNpb000ODVr?=
 =?utf-8?B?Ymt3SzVtQlF4Zmw0aU9weExXZzU4QU4xVXZHUk1UWFZLMkxSL1hyQnVHWXlt?=
 =?utf-8?B?SnVnYmRpMU40d25YaTFIOTROY2tHa3RDNUdjYlRBakZJNVJnU2hyMWxWc0VU?=
 =?utf-8?B?SHhhTndBbzYvSnhKV0lNUS9mNHp0bVl0bVdhQ0pQTmFwaTZRMkszNnlEUUov?=
 =?utf-8?B?ckd0OUNQWUpJL0RxWHhsTThPRTNlSkpyQ0JXTjBaVFRXbHZFNVNlR01jVVU0?=
 =?utf-8?B?Y1FSL0Q0K2NSL0oxTkl3M3RBUWRxVitSajJqRS9YalMxUkV3TCszZE8wbXhO?=
 =?utf-8?B?S2FLWEVjbnFYcFVWL1NjUEttOGt4ZmJNRHZTN3owMkJFK1RNVmJZeGVIK29B?=
 =?utf-8?B?ekZZeVBKWitGbjFiWkNPdTZ4bWtydEJHTGtMZkROL1Y1VllSeUx2QkEwRUdG?=
 =?utf-8?B?Nmt6OWtmelZYeHhlYzhrZ2hSMURYU1dtOWw5dG5MN0pvWGJZTDcraUtKd1VP?=
 =?utf-8?B?K3FjKzl3ekx1TWVhM1NyeGRYNWJwdURFdDdJMkJCS1J6OE8rVXNDOHdDSmlU?=
 =?utf-8?B?Zm5sMndlbTdQbDdRQXZsT2NWYk44dHUrQjJZWXFBYVJqWHVNNVpDdXhlMTND?=
 =?utf-8?B?WDlPMjB2QkV2K3gyUzkwTXN0UVZOTCt6eUpwNi85NndZVktyYXlNMXhSd3lS?=
 =?utf-8?B?bTd5MGdnUkxEQ1luQXkvVHkvZzRuQ0tKSTNhalU4RjRTWXRVTjlpeVdtdUFE?=
 =?utf-8?B?RUtDRWJ6TTNZRW9yM3BKVDFwSmRhTzFtemg1TzdDOXpSTWRuQWJxNFVQK01k?=
 =?utf-8?B?N3hML1loeXpjalo3OHlBdVFVcXJWVHRDcElCWjR4ZVg1ZFBEVEt0SFBDbmU4?=
 =?utf-8?B?ZTlKbTFSOThaR0xkbVYzc01aQ3ZjOW9wOFNNS2Rubk1GeDJscUg0QkdqbEg3?=
 =?utf-8?B?N3VDUWxlcHk0eDVKRGNGcjlZNWtKY3NtRUhCWnhuRHJHR0E1NDBZS2xKekNy?=
 =?utf-8?B?Vk1VOXlDZTF6ME5oVFpwTG5Ma2hoa0JEdVl3OG13UGxYRVFTd2tTNEVEeE5t?=
 =?utf-8?B?KytHSG5ONGRuWUdGQWlMZDNLUi9kQ0tnMWxoc2c4M1ZXRVdRSnlrUklvcmZm?=
 =?utf-8?B?MFhUYndIVXkzQ2tHT2NzZnJmQW4wdVdpcGQ3Sk5tblNvZVhYdWs4dFhDQUll?=
 =?utf-8?B?WmxaaGlSMUordlV5Zy8yVmRsQW9PR2VuVG12dkdMd2l0eXBrWWZZUWRPdlBF?=
 =?utf-8?B?ZFgzNjFxNjVVRU5XWExSUVR5NnZPSUZpQlBKMEo4T0kxRmFiaTcrQTJVb0Rm?=
 =?utf-8?B?aTVOdEpwa2w5Sy9mZk5JUDlTMzdKOWlXanAwR2hWNkpkb2Jka3kwUm5xdVVU?=
 =?utf-8?B?eTh2TG0weTZzRTBKV0VHTmJmMUFSYUJqTkUwWFhzaERxZVd5TXpkYkpwckQx?=
 =?utf-8?B?Nmoxb0pvTTlIWTFuQm9OMmNQQ0xhTW1NUWI0aDE2RjFqU3c5cVI0eHBNVmZG?=
 =?utf-8?B?eEsvR0pxcExIenhQK3hFVmtlcFQyRnl4VzhNbU9yTHpEaytqMUhsY3NIMTJP?=
 =?utf-8?B?b2VPVUY0dy95N2FtOVNoTWJPdW5Zb2V4RHNWeHloOTFLNFl0UFdFZXE1NElZ?=
 =?utf-8?Q?yd7EdWG/dYJZzHz/X4ZOlxCcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a28f03c-bd02-48df-facf-08de1d1e4daa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:21:52.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOG+HMsJChDl8ImcPK8Gwo6ncvLHzaiEM4SBeh6d+ZoyZA7bcbDInGzdDKaPOxs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On 11/6/25 10:56, Tvrtko Ursulin wrote:
> 
> On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
>> drm_sched_entity_init wasn't called yet, so the only thing to
>> do is to release allocated memory.
>> This doesn't fix any bug since entity is zero allocated and
>> drm_sched_entity_fini does nothing in this case.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index f5d5c45ddc0d..afedea02188d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -236,7 +236,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>           r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>>                           &num_scheds, &scheds);
>>           if (r)
>> -            goto cleanup_entity;
>> +            goto error_free_entity;
>>       }
>>         /* disable load balance if the hw engine retains context among dependent jobs */
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Christian König <christian.koenig@amd.com>

Since this is still a fix please push it to amd-staging-drm-next independent of the remaining patch set.

Thanks,
Christian.

> 
> Regards,
> 
> Tvrtko
> 


