Return-Path: <linux-kernel+bounces-753364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A78B181EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B0C7A65E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AF2472B7;
	Fri,  1 Aug 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K6dIM0Tq"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36E2472B1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051825; cv=fail; b=oddlb5myU+TqdiazZLe4o8A4qjXyripvyd/YApICOq/Y0CPFRRbBDff6GmWus1HEAahMTxJ59gA8T4hoJuGWycJaESwtzGp8cJwWuK83NzeJnUzwsGtTi1RmVu16Fv3sk7NZZx3VBy1vJuWDIXVQGY7ObU4WFAaCo/0r0Pz9wB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051825; c=relaxed/simple;
	bh=tiBC0fYYViY05blo2PWdaduOS7HAAveCNbzi7MDZlno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3L1+1E0Qq0OA5bNlj8J2M1R2svm4+GcwcZMu/VF4TATIGNsWi7NXc+0PNYoHZ282RhViQe0vwFC+USUY4QR9kufxV27soyrBjpft3TQIa2oRWZgLgW1A7doxEwagbnFPXogRtqPzVFlLspPpbi7vRviO+smLiX+A6RggZMXPQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K6dIM0Tq; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SenzfK5jeN+tUmnP+2d4ZrQjhk24yrcuA8HlSB0eHokpLr8GAgMyEdAmejeD9yFwvmGJd8ssEl1YnLx/LWazxOdXpcpq99NUjANaWO3llOlwoNH5LWMqmbA9anO8iIxjKP1k1BNn2w+l8LmymZo3JqBT+Iq8PujUBUhShQU1F1+apD+0CGhQBfESvPoT9MPJdkwT0IMn0nWnbJm6rb3aS1P7DXwUUVMPu/QipQvuIurmgrBzMqWY9fGwjitUO3w2ri+Me39m3G5WmiGWGVo+K/0dlqsF70rM6cldJSBRF3Td8grIpiqETCjpoC9mvU+XMLOVlzycrJr+XRhHnBhaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBvhVPsnjUyN/nR0AskCtv4uk+XHE+W9UcNINlo+yGI=;
 b=fiqfkvXr9QjRJ3O34/edb0GNNEfqODWAXQmTnA1WgTjR6Kg0K7kwKam/PgzeInWtlhbLYjigsQQajqNIo92uLAVfKAlK9fuQsKYm2atkmYKDvBOVViduypmY+w5yLXmps+m56waUX+Cyk1lZZ8Ks6UlJmpx5SPIJw2x4hAFUxKaGvQ87nyUF8GtQB7hFIQvDgL8wh6r17UVteUOshpZWbgWc69vsbSCG5LEV/CU9eiFIcfdtlGF21uVws3rgVFD+736RKuKQdVxpuyXNrd0o9/fZ83Na+QYvJd0RBKsiYrV0SBHL7NzYJdjEUMkcJULrNl4ZENKYfCcM3Mh0DYGqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBvhVPsnjUyN/nR0AskCtv4uk+XHE+W9UcNINlo+yGI=;
 b=K6dIM0TqxNvr5H4aFCYtg5JP6YgTZFg1/H2erEM5y53XYxJ7W3cJxRJ+VZRv3JRb64T2ksQCkfH5RZjlIxMzZZSBwQzOXrqEQYJtY2cd7MA+dP7WCfucbWNtgi25QyB4cGCu7BAlpcxDF5Walw3giNoWVVT34NAOgSejbm4x3RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 1 Aug
 2025 12:37:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 12:37:00 +0000
Message-ID: <a6528c4e-b42b-4cd9-84cb-ae8e109e3430@amd.com>
Date: Fri, 1 Aug 2025 18:06:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Unify pm and rpm suspend and resume
 callbacks
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20250731163550.960686-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250731163550.960686-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: d27627a4-94cf-4593-c83e-08ddd0f81c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZhdnJIb0tlM1NRVFM1LzA5emhpNTJ6TmFxcGFWamlZMEpuekE1bGFYVi8r?=
 =?utf-8?B?Z3ZYelZRQm9TaEQ3NUM5MlpyeE9rTFgzcWJIS1FjeTJyQXF1ZWRZY1VaQVA4?=
 =?utf-8?B?bm1NdWdaOXU1b3UxU2hFakcxZS9mV091V21neWlEWEhQYk1oZ3pKbHVXdVVE?=
 =?utf-8?B?MVRESjZoMmpPUFdvZVhnRVZja2l6bndhRTBubENHaXgvNjJ6bmI2aUVOZ1VP?=
 =?utf-8?B?dkQ1eTRLbDM5d1RVZlV4NEgwLzNjaHovUWJlVk5tUGJsUjc0UFJiaGo5Wkta?=
 =?utf-8?B?eTZOYXBxcGZPRElhT29xdmJINDRkdXdUY0dCUjY4VkFzelNwQUFOMHVQWUs0?=
 =?utf-8?B?eTRnUkZRUTZPOFJ5S2o3QjBNV1o3dXgwZ2RVLzdxNW9US2crdVhSQnBWWTFJ?=
 =?utf-8?B?dW5BcDMvUWpSWWYyZ0liYm5oTWFndkdQRFphWjd6T0NvS3ZYYUcwYnVuTVRK?=
 =?utf-8?B?bVFOTEptNzFoeEVlV3NmcHAyWUQwVHhEaDRCZS84NlRQWmhTeVJNRVp1K3Zi?=
 =?utf-8?B?b1hSbjJMWk5oMEEvdjF3dXkycytkYUpUdUNMTVd4NXFFNlpZVkV6TUxiVUNs?=
 =?utf-8?B?dVluVDRTZ3h1THdGR1BDZmFmY1VHaTJBMUNtc3B4RUQyT1owMlJLNlJxbTM4?=
 =?utf-8?B?TkM5V0hTZkZsVFdHTGE1cEpKR3FmdXBOR2YyaWF6alBBcEVMK1g4RmNuYkFL?=
 =?utf-8?B?VmZqSThVQVp4MGJwT29DTFFTdU5mQUgvZjBtVTNIOElROW1IUStyZkNoaWdJ?=
 =?utf-8?B?U25YOUZBdzlkbFY3b0kveUVwWmo0V2Z1VjZtV0ZOSXJCMGMyU1RwUVJwMkw5?=
 =?utf-8?B?LzBvSkRPMk9MZUpPbFpEYUpsdFRGc3lUbG9GNDVwRVZtMys0c0JWaTM5bWRZ?=
 =?utf-8?B?QmZjQXFmdW9Ea2hhem1PdmN0YlBKM2FaWnNnNmQwbTRGa0pGNVFEeTl1b3FM?=
 =?utf-8?B?TkNwRkxzQkZhRGpPUkJzT2NLcGJscjUycVMvS3VSd2NMd3pXNkY0Q0pxOHBl?=
 =?utf-8?B?VHJqZTdyZnp1T0RyeGh4MDNzMlJHWThJcmpPUG1sUVRqNnhra25adGZhQUhi?=
 =?utf-8?B?YlRnV2luT3NmTUdFOUFoak00bUFmWi9rNXNSRnVHRHVWZVd4dFBBd01jeGRC?=
 =?utf-8?B?R3YxYno2NHZhSTUyK1RkdnJSSlBMNVhUMUUyWnFGTkJlWkl1R2tnQXl6M2dB?=
 =?utf-8?B?MnBlTExYQzFoQWUxVFdhWUJTQlFYVWg3Mzd4eVlHV1dweExNakxqd3FHanV2?=
 =?utf-8?B?RnYvRnYyeGRFaXBjVzhVVWtnSHFPYVBWaWphNjZxSTZocXR0dU9mdm5RM3RH?=
 =?utf-8?B?SmxWZTRvbzIyVm1OdGUwV09NZEZaV0VVMEdPbTYvZFpXWWR3L0V6V1h6M3FP?=
 =?utf-8?B?UGtJQ1pnRmwxZUdHWmVlSElRU0dCRmtXa2habEQranJ2MEdJaFhXR3pYbFFN?=
 =?utf-8?B?azIxNHh3RElPbVQrdFF2aWhyb05aRzdmbzBhTXJnU29IdVFnZ0YyQzFkSS9H?=
 =?utf-8?B?Mk10eVpLMDZ0cVFacnF2cmQ1TVdqdkNmbVlyaUtNMGVYWmloamZETFRaaHo1?=
 =?utf-8?B?ZnlFeC9mcEI2UVNiNDhEMGwxRGZ3TDVsYXY2bDUxVVRuMmxTT1NKYTd6QVQy?=
 =?utf-8?B?K2FEYm0vZnRCYmN6YVBoY0U3KzVucUFUVHF5U1BOWk9pVXM2Q0c0bWZuNkdr?=
 =?utf-8?B?T2NLNzhjK2QvRXAvUmRmNE1la3BBMTh1aE9rMUJjV0dGbjUxQmhHQjJPdkNm?=
 =?utf-8?B?OCtiN3VHMTRxVG5wTHg4dTZiSFFualBrMjBPNDhZemJZeGlPNVcxZ1lTd3pv?=
 =?utf-8?B?YURJUFhnQkNGaStNbUtNdFE2UEFMZEREcHJ2SmpHdFFGQzg5MnlVNEJLNlpu?=
 =?utf-8?B?M2tUT1FnRFMxM09rS05TUjVkcGxVbFJyWXZSeVFQdW9RbWFvcWVrV0k0cFIy?=
 =?utf-8?Q?16wb4C/yZkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVkTFhvRWpvWUJBTTlNY2tRc2FqRlo4UVUyM1lFLzU1QW93STM2Q244V1po?=
 =?utf-8?B?bG8rcExoWnRpdVFiVkxweWF6OUFPekN3NHZpbW90U0FIcXpIdklpWEo1SkJE?=
 =?utf-8?B?Y1BsWklSZGwxSExkdXRJdTcyem9RN2tYTkh6WkdsL1pwcjdkYWRLbWllSHNL?=
 =?utf-8?B?SFVwUHlma2JLUVZmaWExVEtPa2lOVzQ1Sng0R0tWMFlXTEFOYkRheXh6aGJ1?=
 =?utf-8?B?K0d4dSt0N2lkdEVMVVVzdnVvLy9ySU51ZFZXWVlkMFpjMlJPRVJ0U0l6Q1ZL?=
 =?utf-8?B?MUhBODdKTjRtL0pTblEzcGRTZnptNVU2ajIrcUpoa3kwcFphMm5uWG5xVFZ5?=
 =?utf-8?B?VXI4djFWdGJqUERuUHpGSDl5WjRhVlNkR3JMUS93NjUxQ3ZKckZoUGRjdkh3?=
 =?utf-8?B?WDl3R2lEY1BsV2xFK0VRNFF1N0Z4ZS9qQjYyaEVBUEIrUWVCcTFiN1VWdzd3?=
 =?utf-8?B?ajhCM3JVMDh2T1lZVTRlcS9FRUlBUGlmeWFUamtqYzM2N0NxaVJhTkJUQTVj?=
 =?utf-8?B?U2hjTldSZjFmcTVoOTRlR1hzbFVITTlQSXZHMERLelVPa3RnV1Z2aXhDNEx1?=
 =?utf-8?B?UE5kTTlER1h5OVhDZ3BMdXdhell3cVlJWEZSM1hRVmxCb3lXUzR2cTkzeVFO?=
 =?utf-8?B?NVVHZmFVMHUzckhTNFJ6RUZEZVlxV3VGRUhmNCtUdTFmaVFjR0QwalQ4Slp3?=
 =?utf-8?B?NkluMWFQSEJJK1psbmNDS0h5NmxvS1o4aDI0YU5WaGJXUGlLNlBmaS9XREFD?=
 =?utf-8?B?V0o1QUQrNVliVDJiblhFRDJIMzlOVm1ON0k0SXNKbisvOHoycVZVblZoYmV0?=
 =?utf-8?B?alU1NmVUOS84OGsxRGtneTJZRXd1RWQ3WFJVVUgyQXl4dXB2RG1DdjcyVlpi?=
 =?utf-8?B?Snd1djlOY0E4eTIzVENuOU5ZeXBJMHlRaG1IVXZhSHh4TFZKdGZuNWtBQlJv?=
 =?utf-8?B?TWRvSXozanU0RDMzcndVNU9hS2oyenJOL2htYXpLV1JXOWN5VXpzWDVKUnVL?=
 =?utf-8?B?TTJGUkNvNmh6SDNlVU5ZSHZQU3VVd0lIU0FkOG9iV2FvV1hVcmw2NHNyNjFo?=
 =?utf-8?B?VEJFRUxKK3ZxcUNDeWd1ZEJzMnlkZGJWQ3IyZUwySk1BSGpPV0F4dEhEWm9F?=
 =?utf-8?B?bXkxQUJrejJJMy92ajZkL0VvejBkUW5ZRFhqTXkyZCt5UzM1dlBnVnd0dWxv?=
 =?utf-8?B?VEJKTTVvcE1mdUQ2S3k4RDhweHJna3NuY2ZCNStLbVp5NEg5L0tPRWpwYWcv?=
 =?utf-8?B?RlBHYVhmSnpTYVVyV0poVTJLU3FpMFM4NmpUS3owOEptQVppQlhIcld5bGdo?=
 =?utf-8?B?bGk5bjcrVzdyYmVGMlhLKy8rU1lJRE9qa3pLVjNObWkyUy92enNGa3BrdTA5?=
 =?utf-8?B?RklpWlRiaW1qcGdnRFRNWFo4UnNaaEdyMStKYmc2enhVYSt1eC9udFlETTBz?=
 =?utf-8?B?M1MzNTBESGpJekZjN09rVlNRUnNKZEJNVkM5WldmRFFpdnhvSVZBcG84dDlW?=
 =?utf-8?B?a21ySHBYNWE1UTY1UHljYm40TW54YkFwRHl0cm9FcUZzVGR0RnIvdG9KRDJO?=
 =?utf-8?B?SHkrRXBXR3BYM0hrYy9IaTRacEZGUVQ2SGVsL2VHNlRGNDAwZ1B3SVJWWmha?=
 =?utf-8?B?S0lDNUF0SlB5cVpwQ0Nmei9ucHVPa01SSmt6UGVzbjQ2UC9xR0NMK1RvdXRF?=
 =?utf-8?B?dkIvcWRBTFpHU2RobnFxTGpzS1dvMXpIdVNQTHQ2MVhYYnAxR2NxYjV1UkhO?=
 =?utf-8?B?NGhaUUFWTElxUTBBZmNBVUpINDlsK0kzakJoUDFGN3AwSE1LTFU5ck1pYzNn?=
 =?utf-8?B?K0NuR2hjejVsNXlwTXlvS1BiZHc3b0JoblkvNWhhdTk2SHRyOGxXN244a2Nl?=
 =?utf-8?B?cnVGNk5Pcm1RMVdadm55THdUSEIzb1dSWFZ6M0FOcUVVNmNaeW91QTkwQ2FW?=
 =?utf-8?B?MGZOL1NvRjVKRmVoWUM1Vll3VzdNbGQvYTg1dEtzYXRPWCt4OERXSlFiNHAv?=
 =?utf-8?B?STdCUG43QkVLa3dUN0h1TEd6eVBZSWQyZmxjN0I3d1orcFhwR1hxbllnUWph?=
 =?utf-8?B?ak51WFJoQzZOYTFzbGs5VkV3QlFPQ2llYVU2Qm9KcUFjbEFBTXFySW1GREJZ?=
 =?utf-8?Q?lX+LTscvx4O+qYfYJC+DOhYx3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27627a4-94cf-4593-c83e-08ddd0f81c4b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:37:00.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxF37Z7DN/DPtbPx9l0IYwgGQG8BTn4m6/pArGl2AoVKcTUutWlh7dltck+ohQzGY5DZh76BDIshoQk4oLl4iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

On 7/31/2025 10:05 PM, Lizhi Hou wrote:
> The suspend and resume callbacks for pm and runtime pm should be same.
> During suspending, it needs to stop all hardware contexts first. And
> the hardware contexts will be restarted after the device is resumed.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c        | 32 +++++++----
>   drivers/accel/amdxdna/aie2_pci.c        | 41 ++++++++++++--
>   drivers/accel/amdxdna/aie2_pci.h        |  4 +-
>   drivers/accel/amdxdna/amdxdna_ctx.c     | 26 ---------
>   drivers/accel/amdxdna/amdxdna_ctx.h     |  2 -
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 74 +++----------------------
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  4 +-
>   7 files changed, 69 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 2cff5419bd2f..7444117f0e17 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -141,9 +141,11 @@ static void aie2_hwctx_wait_for_idle(struct amdxdna_hwctx *hwctx)
>   	dma_fence_put(fence);
>   }
>   
> -void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx)
> +void aie2_hwctx_suspend(struct amdxdna_client *client)
>   {
> -	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
>   
>   	/*
>   	 * Command timeout is unlikely. But if it happens, it doesn't
> @@ -151,15 +153,21 @@ void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx)
>   	 * and abort all commands.
>   	 */
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	aie2_hwctx_wait_for_idle(hwctx);
> -	aie2_hwctx_stop(xdna, hwctx, NULL);
> -	hwctx->old_status = hwctx->status;
> -	hwctx->status = HWCTX_STAT_STOP;
> +	mutex_lock(&client->hwctx_lock);
> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +		aie2_hwctx_wait_for_idle(hwctx);
> +		aie2_hwctx_stop(xdna, hwctx, NULL);
> +		hwctx->old_status = hwctx->status;
> +		hwctx->status = HWCTX_STAT_STOP;
> +	}
> +	mutex_unlock(&client->hwctx_lock);
>   }
>   
> -void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx)
> +void aie2_hwctx_resume(struct amdxdna_client *client)
>   {
> -	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
>   
>   	/*
>   	 * The resume path cannot guarantee that mailbox channel can be
> @@ -167,8 +175,12 @@ void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx)
>   	 * mailbox channel, error will return.
>   	 */
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	hwctx->status = hwctx->old_status;
> -	aie2_hwctx_restart(xdna, hwctx);
> +	mutex_lock(&client->hwctx_lock);
> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +		hwctx->status = hwctx->old_status;
> +		aie2_hwctx_restart(xdna, hwctx);
> +	}
> +	mutex_unlock(&client->hwctx_lock);
>   }
>   
>   static void
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 3474a8d4e560..8b6f17430d3a 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -440,6 +440,41 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   	return ret;
>   }
>   
> +static int aie2_hw_suspend(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_client *client;
> +
> +	mutex_lock(&xdna->dev_lock);
> +	list_for_each_entry(client, &xdna->client_list, node)
> +		aie2_hwctx_suspend(client);
> +
> +	aie2_hw_stop(xdna);
> +	mutex_unlock(&xdna->dev_lock);
> +
> +	return 0;
> +}
> +
> +static int aie2_hw_resume(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_client *client;
> +	int ret;
> +
> +	mutex_lock(&xdna->dev_lock);
> +	ret = aie2_hw_start(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Start hardware failed, %d", ret);
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(client, &xdna->client_list, node)
> +		aie2_hwctx_resume(client);
> +
> +unlock:
> +	mutex_unlock(&xdna->dev_lock);
> +
> +	return ret;
> +}
> +

You could avoid introducing goto in the new code if you used a guard. IE:

guard(mutex)(&xdna->dev_lock);
ret = aie2_hw_start(xdna);
if (ret) {
	XDNA_ERR()
	return ret;
}
list_for_each_entry();

return ret;

You can drop a few lines from unlock in mutexes elsewhere too.

>   static int aie2_init(struct amdxdna_dev *xdna)
>   {
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> @@ -901,8 +936,8 @@ static int aie2_set_state(struct amdxdna_client *client,
>   const struct amdxdna_dev_ops aie2_ops = {
>   	.init           = aie2_init,
>   	.fini           = aie2_fini,
> -	.resume         = aie2_hw_start,
> -	.suspend        = aie2_hw_stop,
> +	.resume         = aie2_hw_resume,
> +	.suspend        = aie2_hw_suspend,
>   	.get_aie_info   = aie2_get_info,
>   	.set_aie_state	= aie2_set_state,
>   	.hwctx_init     = aie2_hwctx_init,
> @@ -910,6 +945,4 @@ const struct amdxdna_dev_ops aie2_ops = {
>   	.hwctx_config   = aie2_hwctx_config,
>   	.cmd_submit     = aie2_cmd_submit,
>   	.hmm_invalidate = aie2_hmm_invalidate,
> -	.hwctx_suspend  = aie2_hwctx_suspend,
> -	.hwctx_resume   = aie2_hwctx_resume,
>   };
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 385914840eaa..6b21909841e0 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -288,8 +288,8 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx);
>   int aie2_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
> -void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx);
> -void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx);
> +void aie2_hwctx_suspend(struct amdxdna_client *client);
> +void aie2_hwctx_resume(struct amdxdna_client *client);
>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>   void aie2_restart_ctx(struct amdxdna_client *client);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index be073224bd69..b47a7f8e9017 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -60,32 +60,6 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>   	return &fence->base;
>   }
>   
> -void amdxdna_hwctx_suspend(struct amdxdna_client *client)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -
> -	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	mutex_lock(&client->hwctx_lock);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
> -		xdna->dev_info->ops->hwctx_suspend(hwctx);
> -	mutex_unlock(&client->hwctx_lock);
> -}
> -
> -void amdxdna_hwctx_resume(struct amdxdna_client *client)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -
> -	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	mutex_lock(&client->hwctx_lock);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
> -		xdna->dev_info->ops->hwctx_resume(hwctx);
> -	mutex_unlock(&client->hwctx_lock);
> -}
> -
>   static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
>   				      struct srcu_struct *ss)
>   {
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index f0a4a8586d85..c652229547a3 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -147,8 +147,6 @@ static inline u32 amdxdna_hwctx_col_map(struct amdxdna_hwctx *hwctx)
>   
>   void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
>   void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
> -void amdxdna_hwctx_suspend(struct amdxdna_client *client);
> -void amdxdna_hwctx_resume(struct amdxdna_client *client);
>   
>   int amdxdna_cmd_submit(struct amdxdna_client *client,
>   		       u32 cmd_bo_hdls, u32 *arg_bo_hdls, u32 arg_bo_cnt,
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index f2bf1d374cc7..fbca94183f96 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -343,89 +343,29 @@ static void amdxdna_remove(struct pci_dev *pdev)
>   	mutex_unlock(&xdna->dev_lock);
>   }
>   
> -static int amdxdna_dev_suspend_nolock(struct amdxdna_dev *xdna)
> -{
> -	if (xdna->dev_info->ops->suspend)
> -		xdna->dev_info->ops->suspend(xdna);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_dev_resume_nolock(struct amdxdna_dev *xdna)
> -{
> -	if (xdna->dev_info->ops->resume)
> -		return xdna->dev_info->ops->resume(xdna);
> -
> -	return 0;
> -}
> -
>   static int amdxdna_pmops_suspend(struct device *dev)
>   {
>   	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	struct amdxdna_client *client;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	list_for_each_entry(client, &xdna->client_list, node)
> -		amdxdna_hwctx_suspend(client);
>   
> -	amdxdna_dev_suspend_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> +	if (!xdna->dev_info->ops->suspend)
> +		return -EOPNOTSUPP;
>   
> -	return 0;
> +	return xdna->dev_info->ops->suspend(xdna);
>   }
>   
>   static int amdxdna_pmops_resume(struct device *dev)
>   {
>   	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	struct amdxdna_client *client;
> -	int ret;
> -
> -	XDNA_INFO(xdna, "firmware resuming...");
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_resume_nolock(xdna);
> -	if (ret) {
> -		XDNA_ERR(xdna, "resume NPU firmware failed");
> -		mutex_unlock(&xdna->dev_lock);
> -		return ret;
> -	}
>   
> -	XDNA_INFO(xdna, "hardware context resuming...");
> -	list_for_each_entry(client, &xdna->client_list, node)
> -		amdxdna_hwctx_resume(client);
> -	mutex_unlock(&xdna->dev_lock);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_rpmops_suspend(struct device *dev)
> -{
> -	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	int ret;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_suspend_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> -
> -	XDNA_DBG(xdna, "Runtime suspend done ret: %d", ret);
> -	return ret;
> -}
> -
> -static int amdxdna_rpmops_resume(struct device *dev)
> -{
> -	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	int ret;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_resume_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> +	if (!xdna->dev_info->ops->resume)
> +		return -EOPNOTSUPP;
>   
> -	XDNA_DBG(xdna, "Runtime resume done ret: %d", ret);
> -	return ret;
> +	return xdna->dev_info->ops->resume(xdna);
>   }
>   
>   static const struct dev_pm_ops amdxdna_pm_ops = {
>   	SYSTEM_SLEEP_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume)
> -	RUNTIME_PM_OPS(amdxdna_rpmops_suspend, amdxdna_rpmops_resume, NULL)
> +	RUNTIME_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume, NULL)
>   };
>   
>   static struct pci_driver amdxdna_pci_driver = {
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index ab79600911aa..40bbb3c06320 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -50,13 +50,11 @@ struct amdxdna_dev_ops {
>   	int (*init)(struct amdxdna_dev *xdna);
>   	void (*fini)(struct amdxdna_dev *xdna);
>   	int (*resume)(struct amdxdna_dev *xdna);
> -	void (*suspend)(struct amdxdna_dev *xdna);
> +	int (*suspend)(struct amdxdna_dev *xdna);
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
> -	void (*hwctx_suspend)(struct amdxdna_hwctx *hwctx);
> -	void (*hwctx_resume)(struct amdxdna_hwctx *hwctx);
>   	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
>   	int (*set_aie_state)(struct amdxdna_client *client, struct amdxdna_drm_set_state *args);


