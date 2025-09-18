Return-Path: <linux-kernel+bounces-823307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1AB86165
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F9254675B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB23191C0;
	Thu, 18 Sep 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0d0ZDgSn"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61431A7E9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213832; cv=fail; b=L9Xs9jAmiuJgJOGoycSqo7EJrH+i1uCxioIe6jLsBy3MC2/DLtb8leJ3QVn6iWCKkxa02X2tRh6Gt2WlccF++H1WuQjy60xtzpo4pS9ypnyRKnA7iHMyIazqJHXExIJ1D501Eg7pN+G06YqPo8Uj9l6AYhkIrhSTWj+020H0zfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213832; c=relaxed/simple;
	bh=xHjMoO/PysGpiMSEwKOa0wwWLbxRYwwHP+Nip96vlC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gq7L4fpfxFcHkKE37nO4aDnkbYA4YpCzYagxc9xuw+nrG77yP/6qijdCyfBFqn9fh9SUR94fU9rMoCS6lzKpnrBnsq1DWKC39Y8BwpsAfLCxUdYTUmcv542vnQu72l+K/LIBEHKekrCU8oLe99XGLsWLjre82cyYdTcBFqt0EEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0d0ZDgSn; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF/WgPAm+nwwfEkO2ld5hL5IvMtA2Wv1myxQNDCB3LT4gPuc/6ccvou9VZPeSJls3cWF3vmsb7uMQWpuherEJspVRmZ1GHiB6S2zJkyI5IM935RjfB7Tfs+Ksww0gRpjCIza2oeJDdm961uUDupYtnJ9OTHtNsrbfQhTGXweBQlMSCkCB0orH0cdMzJ7l5NBl2KeV4xmoJahugl2oaoURea+Veyz8IheGY+EAIkNWHFMhFz+G8Cl7DNu8ICdRf2dui0xIb8VUxWc0gEqlO95/aAxJ2J+0e5I2gMefzO/Yigx3h5a6koR/fF2Tp0OuVTlduNmmGAB4+lecmvyfKHP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzk4dYY7eUrlKk6kKCYYaz7UfMs5e6pMOJZEKXAf7Uw=;
 b=B0sFbuhJVRO34fBxcBPi8GtBontX1PFR/jL4Bs1GCGblg5Cg9n/Oebn/OFAvf35/618rJWTaz2lJcYbv+umjlkeBbgXjgnK/L+mIfifM7E0OA02RWfft9hMltLH8SHLAhonD+8cmF5y/wDdIOUav2501OBOA9+1N4d+nuObtjyxo5lZi9ktBcaZpyFsdskexuhUWbIjvOfpUQhtz4yp8j/yhNXa1jdYXu3Ycswj5rlFuM8ufYWfazjrOR0tCVEVtG4dpoMVyq+twH15WdqEb7K5McKKV47Fw3LRha9/LIUHqAUNkDGpIS0FAIWe4TX9QNdUBpZcBrlVZqfWlCa2soA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzk4dYY7eUrlKk6kKCYYaz7UfMs5e6pMOJZEKXAf7Uw=;
 b=0d0ZDgSnV+HL7QHOL892qYNvT3CURrYuDJnxLSkUCQBHsIbf3jamr8pQwDP2MB1cjoS6/qQZsv+Fz74pS8215m70Kkn01oBqVe8rnK45NEtpVbXhVQJXtLBfqlBZXGg/w7GSDmTBs+EHzhdmeEQ1T0KLIMXNJOEsqn3/FgcJ+0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 16:43:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 16:43:47 +0000
Message-ID: <7e5dc364-e8c1-4520-b530-9e48cf86e9c6@amd.com>
Date: Thu, 18 Sep 2025 11:43:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume
To: Matthew Schwartz <matthew.schwartz@linux.dev>, chiahsuan.chung@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, zaeem.mohamed@amd.com, misyl@froggi.es,
 linux-kernel@vger.kernel.org
References: <20250911174851.2767335-1-matthew.schwartz@linux.dev>
 <ccdc6dda-8341-4b77-a571-e0642499e3f7@amd.com>
 <8f1143f0-e70f-4187-9a2c-4e825ed9c63f@linux.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8f1143f0-e70f-4187-9a2c-4e825ed9c63f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 42151af8-827b-401f-2085-08ddf6d28a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkdKbTcrMEpsQVNuT0ZLbHpEa2xQY2JtOGtsa1YzYTYzS3IyN3JMK1BKaVZP?=
 =?utf-8?B?bG9WNjFjcXgxaVcyem9GbmpYSzF0a0s1b2dJRWRmYVJhT2lWMGJUMlBSdG1L?=
 =?utf-8?B?am8vc0Z2enZxZDQ5OEJNZW5CVWlrNFpsRHh3ekpRdTN5Q21uK0UrT3lQdk9i?=
 =?utf-8?B?akJKaVZEYVQvTzd1UHVxbFhkS1I2a3pFbWFUZHh5bWE4U3ZwSjAyUDJxUllp?=
 =?utf-8?B?OVlqQjVzZHE0SE9CNDRmTlRzaEtueE92Y01GeUdOak1VOVo4SXNqZWNZMHIv?=
 =?utf-8?B?Vk5IL1B6Q2R3MER0SlN4UjIwakM4S0tEYTZJaFBPQVVPSzZqRms1WTJlS1NY?=
 =?utf-8?B?V3pYOFp4WlMrakFEYys5dktmRzdONkYzbkpuZkNha0d6UGRKeWVHbG5KOC9I?=
 =?utf-8?B?VTYyc05FZWVFajFhSXVDd0U3ZkRkby96ZjVjMkZ6RFlkcmNZUWRMRWVWSVFa?=
 =?utf-8?B?bWZJTFFHekZrS0NyQVR4YndiS1hZcWFmSVh1UGYwZThyUXFFTmlPM1I2Yk02?=
 =?utf-8?B?aTE0QmZmZFRKbVJ6OXh5Q3IyYzRQSkpRZ1RPbDlzRkVJQTRSUloxL1R4bkJV?=
 =?utf-8?B?dExWS3lUSWhFNFhUSjRDOE9pREVmcXhKTUhwdW1MMlJscTFIeHdycFpNUldo?=
 =?utf-8?B?WlVNRldUMVpJdVBwN0d2Zm44UXh4WEV4R1pWUlNiNDRtMFBWd1R1L2d1YXhL?=
 =?utf-8?B?TlVkZ0JiaE1PbUJqeFNzUTBIT01JVitQRXVVdVFVV1FPRTA2YWtvRS9FVTJz?=
 =?utf-8?B?ck05VWZVK2VORTFaaTlCbCtENmtUZDNLNE15RCtoNlByY3c1bkJzdUUxQzRZ?=
 =?utf-8?B?NTlSYmxiczRSQ2NPcmxEa25objVUREZtT3pwekVDUE82YlZkVEV5RE0rUHlq?=
 =?utf-8?B?cEhnWHdoZ1lORW12V001NTQyUUdmNVNqT3RGeGF1NTUwZTRCK2pZTFZZeHY2?=
 =?utf-8?B?TkREcDVFZzF3UmFoVTd5Ty8xL25yeFNhVnhsUWUwVG10YlhrbTdwc25US3Fv?=
 =?utf-8?B?Zk9SSE9XWWdXK3ZkMnNLSnN1YVd6VzJyS3JJYTFGeVYwb1I0aElRc3pzYktK?=
 =?utf-8?B?SSt2ck90MXAvNmZnVGEvVE14VmFVdHlteHE3QktzdHNzY2E2VTlMSXRwMnhJ?=
 =?utf-8?B?N3NOU1YyRWtDckZYazEvcmRYdnhnWXVDUkMzdXNZVys0b1A2dFV2M29MVnZ2?=
 =?utf-8?B?UXlzU29sK3lNbmpUSUF1M2paME9WTWFYcVdHU2pVUXFIWHVPZWRscGpabC9V?=
 =?utf-8?B?YXdmb1B5V2NOUkk2ajdCTU1NLytLZXhkZlYzQnpGdkttdGRSbmd4d1ZFUU9F?=
 =?utf-8?B?amd5UDRLbjRzdGNBUExTcHBZaWRucUxrWFE2Q3pQN0pnblcrSFBYQmpEVW13?=
 =?utf-8?B?U1U1K25UYUJkWElnWkhrNG5sQzJvOWVRWU50SzcydXc5V1N0TEtuQ2QrVExW?=
 =?utf-8?B?T0pvNW15VWdRZmJ4S0h3K1k0NElWbm02R1N4VmxaMnU1WHdKNGlwa1hRRHJk?=
 =?utf-8?B?Q3ZTZWZreEhXOUFJMDFadFRnenJrWVN5bUs2YlBLR0VGSGU5am9FeG9jdy9L?=
 =?utf-8?B?SGlmb0R5cWpMWHoyWG5GTDVNOWRacFdTRGd6WlhrMjFyTkJSK2tiM1l4Z1o1?=
 =?utf-8?B?YU5Kc1IxU2NoODJXNEF3WDlvZGdKZmJROURPRTBXTUQyQVYyK0craU5MNWV3?=
 =?utf-8?B?bTEwRjkzemcrczhJTWtzMUVpMGRHVTRtYllOdVZaVkozcWJoR1Q3RkxaOUwx?=
 =?utf-8?B?KzgyVkE2ZGZpaXo4c0o3dkFzRnF5ME9Fd1d5NE50UGNDYnVFNGtxcXNPeEJI?=
 =?utf-8?Q?7jte2BgALMjPuYaieTLkfQ8SGP9Bj5FukQBOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjV2c0psa2ljaVo3dlZMRUZnbFQ3Y0pSbkN4RlRWRTdhYUwwMkV4MlV1Z0py?=
 =?utf-8?B?T1M1dmNzUDlrZ3J1MTNuQ0hEWFpJcjFLZGQ5RTg2aGwydTVlNXBCZUdhOG5n?=
 =?utf-8?B?WjhORU9vM2dlWVJGbTFJWUhKRG5uOENTSG1LSkJzM1JnaDE3Zmd4MW9iSXU3?=
 =?utf-8?B?bW92U2NUTWlvN0Z3VmZMOTFxQXExVXd2UEd3amFBcUtweG1ybFlydFA3Q1Nv?=
 =?utf-8?B?ZUNaR1o1NTFlbjNUWFlxSEtIdkE2MDI3UjZtWTV2MUQ0bnpPa041MEpQV2hq?=
 =?utf-8?B?Mmd1L0l1d2l0NUsvdXNrblgvZitHMWlYOVpuR1IyQ3RQOFNrR2t6b2FEL1Y0?=
 =?utf-8?B?V09nY3haMXplYXZKdnh3V2IxSTcwYUNCT1Y5b2tjYktpVGRHRlF6SStLNTc1?=
 =?utf-8?B?K3Jsd2g1RlA2YWZ6VStyejN3OGhNUUUrak1NKzhZSEYxalNwU3hrQXBOTUtq?=
 =?utf-8?B?SFdvUkxlOEdjeU1nK2JSd3JWM3ZjOXlPMC9McnJ4VndRbWI3RHpZOXhHcXp5?=
 =?utf-8?B?WEp4ZTNWUmNYM3FSVkdrQ24vbHBZV3FNdGlLb2lPZ3ZCRTFnWjRUYVFWeExy?=
 =?utf-8?B?OThQN0I3SkFUd0hnWnpjbEUyWDZld2R4SXVBeUhvcm5zNFNudlQ5VEZndXFV?=
 =?utf-8?B?WEd3LzNBQU1YZHB2OFY0N05zbXpNaEJBWWNvTEhXa1N5a2t0U3ltd2dabWV6?=
 =?utf-8?B?VlpwMFpaSEpiakRiSDdwTlJGMllpYmJ1SXNDalIzQTRHTjJCSHhWL2pDMDVx?=
 =?utf-8?B?aHd3b0F1SklubEl3b2dwd0VUN1MwdkJVMWlZeTJyRWZOVXV6a2xRRFY5Kys0?=
 =?utf-8?B?a0FDVXcxZWxVbWt2UklGMkVNRHhRTFBaRStqY2RtMng2S0R0ZTNybml5eU8v?=
 =?utf-8?B?RDEvV1AzYnMyeFFFeTN5ZWpiaFR6dU1XVWovYmpZZmF2U21UdnNqTEl5ZHlu?=
 =?utf-8?B?NHgvMTRXVmVNbVVKYm9XWXRaMkpHcXZRTmxmUGtHQU5KUmM0VjVFZGFLTmND?=
 =?utf-8?B?cjM3U2lrVFJHVGxtRTlYSmVLOFBzakpCNUxwcUo1TXptODhtVXUxaG5EQTg1?=
 =?utf-8?B?elB5NVBIenVLMXgvNzBsbmpDYVBYbTBRSU05SWZmeVJvdDNia1ZoZVRkV01x?=
 =?utf-8?B?NnFSVytEejhOV2NlVGZGamFja04xeEZGRVNSUHhsUXFUSkxxdzRXZE5jeVEv?=
 =?utf-8?B?bW80SmlNWThPMWs3alNFbWFCaGNmWkFrMG9Yb0RZY2JuZHRDNXRPVFh1blBP?=
 =?utf-8?B?TGZ5dEVHQm1zV0VwNWFsc0REbGJSZ0g2bTU0cXR5bmJucGxPNENBcWU3ZE14?=
 =?utf-8?B?OTFGY2c1UmxBcWZHMy9mZ2Q1ZzN1cmIxbmkyRGVHZnhRRkl2ZWk0NlFRUzNi?=
 =?utf-8?B?aTVuSEpaNVZkWGg3cm1YdTB2RmtrOFQ1M2U3UlFuMXNnenJvaU91ZXR2OHJK?=
 =?utf-8?B?Z1Q0SGlGbnFBQ2lueDVHemlJUVFiY2RUT0RyLzB3Q05BZGdQM0szOWtDUWdB?=
 =?utf-8?B?ZEgyZ0U4L2hYcWl2ait2eW1iVjBSMlIxb2pDdXB4dDJiT1hsUG5xY25RMkNN?=
 =?utf-8?B?TkRWQnVBV0FzQXltVUx0alZadGN5cE1lY1lqWHBTY213ZmdrejUvdEkzYWp3?=
 =?utf-8?B?aVROSXI1TVQrUm9VSXJGVzVabE13b1p3ZmJsMUZmSFAyc2NiL3FPelo0dWE3?=
 =?utf-8?B?SGF2Q21IbGFiTTFpZEsvNFZXejdVTU1XUllRZU5aWGRLK1d5L1pEV0xMWU5S?=
 =?utf-8?B?bkdKczN0WElHNlNLWm9iYW0rM0RLQVlQK1VpVDB3ZjlQZkFIUGhVV3BOV1Zs?=
 =?utf-8?B?VExsUlVtMDNGWEZyMGxpeGNoWVRuMFBiWEVhNGk4TFBLcTA2QU90cm9hRHpL?=
 =?utf-8?B?c2hVbEh5ZTRWbjF4aU8wNytjMTdPOERGSC9ZbEg3dVR5R3orVlpZRUp6b0Iv?=
 =?utf-8?B?bnJNOVQzbzBzamx1OU5BOC9YUmJDK1RSRnBUNGlaeXVSUFBTMUt6SUhiK2FB?=
 =?utf-8?B?eDdidzdkVmg0OE80TFk5K29CNEZZTy9tVnRlaWZ1UkxuNmlpQlMzSjBGeTBS?=
 =?utf-8?B?QWtQZnh6OFF1SHVEclJJN2lONkIwZVJzcHJEeFZmcjRmSjJYaytKTzNScjBl?=
 =?utf-8?Q?jupEZtp/tf8S5WuhKAPRg8uwu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42151af8-827b-401f-2085-08ddf6d28a15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:43:47.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbDQLvqUYfZhhS3zhiyJj/bF0ih3M57/V3ajwrLPjQzghjPFzUO6URpulRf3V9DlZXozhpwUy524XzLkfIUWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257



On 9/18/2025 11:37 AM, Matthew Schwartz wrote:
> On 9/11/25 10:55 AM, Mario Limonciello wrote:
>> On 9/11/25 12:48 PM, Matthew Schwartz wrote:
>>> On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
>>> brightness sliders can include a hardware controlled portion and a
>>> gamma-based portion. This is the case on the Steam Deck OLED when using
>>> gamescope with Steam as a client.
>>>
>>> When a user sets a brightness level while HDR is active, the gamma-based
>>> portion and/or hardware portion are adjusted to achieve the desired
>>> brightness. However, when a modeset takes place while the gamma-based
>>> portion is in-use, restoring the hardware brightness level overrides the
>>> user's overall brightness level and results in a mismatch between what
>>> the slider reports and the display's current brightness.
>>>
>>> To avoid overriding gamma-based brightness, only restore HW backlight
>>> level after boot or resume. This ensures that the backlight level is
>>> set correctly after the DC layer resets it while avoiding interference
>>> with subsequent modesets.
>>>
>>> Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Haven't picked it up, will wait a few days for more comments.
> 
> Was this applied somewhere or still waiting on more comments?

Hey Matt,

Thanks for the reminder!  I wanted to see if we got any comments from 
display team before picking it up.

I've added it to our internal tree, and as long as CI is happy we'll 
bring it forward in a future PR.  I'll come back to you if there are any 
problems.

> 
> Thanks
> 
>>
>>> ---
>>> v2: Drop set_backlight_level and use dm->restore_backlight in
>>> amdgpu_dm_commit_streams
>>> ---
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++----
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>>>    2 files changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 7808a647a306c..2a5fa85505e84 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>          dc_hardware_init(adev->dm.dc);
>>>    +    adev->dm.restore_backlight = true;
>>> +
>>>        adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
>>>        if (!adev->dm.hpd_rx_offload_wq) {
>>>            drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
>>> @@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>>>            dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>>>              dc_resume(dm->dc);
>>> +        adev->dm.restore_backlight = true;
>>>              amdgpu_dm_irq_resume_early(adev);
>>>    @@ -9802,7 +9805,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>>        bool mode_set_reset_required = false;
>>>        u32 i;
>>>        struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
>>> -    bool set_backlight_level = false;
>>>          /* Disable writeback */
>>>        for_each_old_connector_in_state(state, connector, old_con_state, i) {
>>> @@ -9922,7 +9924,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>>                acrtc->hw_mode = new_crtc_state->mode;
>>>                crtc->hwmode = new_crtc_state->mode;
>>>                mode_set_reset_required = true;
>>> -            set_backlight_level = true;
>>>            } else if (modereset_required(new_crtc_state)) {
>>>                drm_dbg_atomic(dev,
>>>                           "Atomic commit: RESET. crtc id %d:[%p]\n",
>>> @@ -9979,13 +9980,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>>         * to fix a flicker issue.
>>>         * It will cause the dm->actual_brightness is not the current panel brightness
>>>         * level. (the dm->brightness is the correct panel level)
>>> -     * So we set the backlight level with dm->brightness value after set mode
>>> +     * So we set the backlight level with dm->brightness value after initial
>>> +     * set mode. Use restore_backlight flag to avoid setting backlight level
>>> +     * for every subsequent mode set.
>>>         */
>>> -    if (set_backlight_level) {
>>> +    if (dm->restore_backlight) {
>>>            for (i = 0; i < dm->num_of_edps; i++) {
>>>                if (dm->backlight_dev[i])
>>>                    amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>>>            }
>>> +        dm->restore_backlight = false;
>>>        }
>>>    }
>>>    diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> index b937da0a4e4a0..6aae51c1beb36 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> @@ -610,6 +610,13 @@ struct amdgpu_display_manager {
>>>         */
>>>        u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>>>    +    /**
>>> +     * @restore_backlight:
>>> +     *
>>> +     * Flag to indicate whether to restore backlight after modeset.
>>> +     */
>>> +    bool restore_backlight;
>>> +
>>>        /**
>>>         * @aux_hpd_discon_quirk:
>>>         *
>>
> 


