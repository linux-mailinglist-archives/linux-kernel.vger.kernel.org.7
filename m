Return-Path: <linux-kernel+bounces-815006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85358B55DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC1D1C81D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E31DE3DC;
	Sat, 13 Sep 2025 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="U/CNd+Gb"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013041.outbound.protection.outlook.com [52.103.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9E3D984;
	Sat, 13 Sep 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757732623; cv=fail; b=cQYiVb/+OIrM5pf5GPJ5Gnmm+tPILz8+T6NCOjaRjTqGSU/XSdZAHArTzeCltb8+usFIUOLFbXGIQsdte5HN1GTHASGXGY3UgSdcMCUHoLI4auPP/Et6WDmcm/PaV73SfIJevG8IeaIS4KhjOtC2L3kx7sJ6z9UJyAOF3Hs1VGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757732623; c=relaxed/simple;
	bh=HKEkGnbbjiqAF5DK6p0Mpw2sRRRti67U7Mho5Scafz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V2QQcY7nvjEtieJkQaTaE+wOOuB/XY8fhtTw2zsU2yWB4Aq6MPE0v2vLiMeKM0YH1cQ50xSJzAkG+Gc2pkedIgNK6f4PKD/2R+VSYlvx3rACEkpOQTrlSNbBbcxzMQUxi+8GUwi51aE125qzzOt0B/8rx69kqN80LmN4SjCub7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=U/CNd+Gb; arc=fail smtp.client-ip=52.103.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCVt7ZtaJWnJ6/EBFHOkcL2ASNWcnMod1vKvdFQynlvqcR7te642E6B/6L0BOocoQtJiLtWcpH9B9Wxu8WTc/8UElJow7tEjpYd6ebv2riqKsd2rhmCc+7IPoWQZ7NKHreD9EGnCFY74gWTRlMuBTg+B4OTdXq2guSi/grXD58cpClfMiketeF1SyjeKL5nJ8kazj6vierLFWWuMr3dmof381nHobzXbW+X0aqNLraGDZoxhOoBZZo6Kp/iHlMKlaraHusGDFK8BjdGnhnV/kcz1xd+atJMwVysdLr7yECBaDWVPzDtATvlWs7pRNeCgq0MZRZohUYVSFQJkn/3zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orPH1C2ybsZe4Ssnjba6yddLSSLT7/Fzy4A37nLn2tg=;
 b=v/MC+AMZtucspEG836LnM8wCOFitVM01sH+Qb3IOluYqDe2HaBh97ICreo14ssFgSIl2MDgMe5jMh3HJQQQihoFQZL0IJ29iqTHSEQwCcNRNf1SYc2uMicvp7Xj1QzB3nSEex188nA6C16FWPjhsnCU5uCT7COZ60yZIamvOBG5FFPd9xCnYVgS3thTfEH9HamE8umhgxEazLMY22neMe3LroTeIXeX4i1ZYsEreqzmrmwbVAI8EgAWbcMzkkswXibhoYHtLQ09OTvrQfmKS0ca4P3vvnpcvNqdfSPMYvr7Xz+trf6NtgTlvYtogJNiOxkYoTJf8xIwNgUZs0PWsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orPH1C2ybsZe4Ssnjba6yddLSSLT7/Fzy4A37nLn2tg=;
 b=U/CNd+GbkwJGsVIozAa++osTEIJAIaVkdlz7/xrCditi7ax3A4hf0rnyovABmYe70tz6Hr2Yy/Mtr/e5xT9C9Ncbe1H0FhM9sxom1/yK6sff/YG7SkWydnmFwQ8SOpXoAKX3P6wIPeuK3WQDUyEF0AjlHpu04d9WxTUwb7yLWBNWhoHg/WxvB6BHpvq0DeGsURwIntc7Sn3JJ55UdqxMcki9Z31rJ8bRgVPEQtwAqG73Iv+XOOK+485dAHlomniAJIGngLGnR4G7qDuBjOR1YCgWHMVY3/G6huFfuVzXopDYjoi2WiJyI3c1A3wAFQsjnYAuTM3Bc8yskivZZ7LqNA==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by DS7PR06MB6920.namprd06.prod.outlook.com (2603:10b6:5:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Sat, 13 Sep
 2025 03:03:40 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9115.017; Sat, 13 Sep 2025
 03:03:33 +0000
Message-ID:
 <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Fri, 12 Sep 2025 23:03:15 -0400
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>, platform-driver-x86@vger.kernel.org
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
Content-Language: en-US
From: Daniel <dany97@live.ca>
In-Reply-To: <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <72eacfd8-8458-448e-b1d7-1ac0610a46d0@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|DS7PR06MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: a37ab964-4c2e-4f5e-02d0-08ddf2721c2b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8022599003|8060799015|19110799012|6090799003|461199028|5072599009|23021999003|41001999006|3412199025|440099028|12091999003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3ZFU0ZCRkxRank4VS92VE5QUlQvUVQzZEszNTV6VDhFeWlUQkJGWEhTTXZy?=
 =?utf-8?B?U3krc29SbW5FbmRVdnhQNHYrZTZpMk5tRDV5dmRQOTkwcjhISERvWU1nN0Ew?=
 =?utf-8?B?MVVPVXdTNEFjM3V5b0RFMlFOTHMyYnNsQTlMVHk1bDdPMWE3SGpQcU42Ti81?=
 =?utf-8?B?MDV2V3ZjTU82dFhaODd3V2FXQ2Y1QUVwWlpMc1IrNzFOUngyVUdtYmtrWUtl?=
 =?utf-8?B?Ym05QnlINXkwN2lnRTRNRWwrbXV5cktaaTFxa0dKV2hJY0cyaFprZlBNMkZy?=
 =?utf-8?B?eXJ1cSt2aHl1aTBHU05kdjJzaUYvQW5BaTV5OUttSzdBRGVhbVlSdHUxNUZk?=
 =?utf-8?B?ZkVVeFMwOFo4UlpLSWZVUEUxU1R0b29NTWxCUVYwTTlrMDNDbE1hUFJWMENq?=
 =?utf-8?B?WkJmU0NrMDFxZ25MZWQ2NXZUUGFIMzBOUmRaM3RHbVg4OU1CZS9mNDYzTHpW?=
 =?utf-8?B?eXJTdHJ6dVZhWnNOVzBkU0NjRTJtb0JoR0FvZE51ZTBJeEVtQlZoL0REN002?=
 =?utf-8?B?R0VwK1U3VDlXRHJYQnFOdTB3Tm4xL01wSzU0ZHczOXVJS0cxTk5TMURsOVlM?=
 =?utf-8?B?N20raTRUSW9YRU5SWkRYOFdaYnVmTHFVNWxRME1vQVl2cmdCbm1xOHZGS2gv?=
 =?utf-8?B?ZTlnRlRXMzd1c1FZNnp5S1czakhoNDkrdWlIWlF5aVg0L1RYZ2F1dktPRGJy?=
 =?utf-8?B?dWp6UW40TjZmRDNNN1I1TFZqS3JvYnhNWUthU3pDTjcvUXV1a3lWejJYMm5N?=
 =?utf-8?B?ajZkSVZaMEVQaXRVc1lNOFVNVjhzWUtKd1JTUWJ4WGFwKythdzQ0T0kzclhv?=
 =?utf-8?B?Nit1ZlRJTFlrVm9uNkpnV0U2cTZqNGNqY3RLOUhTMFBDRmtvckVIeTR2Smw5?=
 =?utf-8?B?dzBYTkcybmJGbFVTSHFtVjRkVDdRYlF1MWVUemg1a1R1L2JKcjdaUk9mekQx?=
 =?utf-8?B?NE0wWTdFRmMydTNVdEJobVN6blpuNXcrZkVLa0piVXVtU3ZhV3JqTkZ5ektF?=
 =?utf-8?B?UVFGbmdZZVlvM2RNL09uSmd3cXBkSFBMTTkxN0s4T2t3VGpBbkdISnlNazR6?=
 =?utf-8?B?NmdjaHBkTVBjTGVqc0U2S3REZWVFb3dKcnZHbUtQNFhBOS90YmRGdmZ6VzZ5?=
 =?utf-8?B?VnRRYkNHTUVHNDFpUkJNSUlUeXUrR1p0bmZGd3hOcWtWRXIyK1BMS09vcXF1?=
 =?utf-8?B?ZkluRTZWQnYvY2NxR0xaSFRTbllIQUdhc0R3K25oR09JemltQlg1VEVYWEtL?=
 =?utf-8?B?akVkVXZ5VGpYekxQdzZTUEduS28yVGVINkM4dWc2RXphbXBNRkVvajdOZVAz?=
 =?utf-8?B?V09VWG11QllDUXlYdDRnL3M3Y0lTRzc3QnpHNHpsSkZKT2lvZVE4T1NPOFRr?=
 =?utf-8?B?UHREY2FNUjZva0lFa3lyU2JzWElYUUprUEc5NlpsbUNEWnUwVlBmeGVza1cx?=
 =?utf-8?B?c1lWM2Y2T1ZPQlA2VHkvK3IvYTZJQmhaQ1MvVlB1RURBSHZsUFBzVWpmZFAz?=
 =?utf-8?B?RC8rOTdSeUJLdjBLYkVpdjFCY2NDbEl6RTgwYjNoQ0NEUjVKWWZYWjA3Zjdl?=
 =?utf-8?B?V3ZrNzFjOHpMVmJ4dUR2Y3UxckpPNGhxVmFWaExPVFRBUFNvdFcwZG5pMTFK?=
 =?utf-8?B?SVVaaGFYVWY4TEY4eUYyNWI1Zndyek10Z2FjOFBOTTZQckNqMVFoNzNUZmcz?=
 =?utf-8?B?QmVKVjNjSk94VDJvSUJKZklDS3p4WHRjZmVGc1hUQ2xqQ2d5OW1JWUJ3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1VGY2s2RU15Ti9POVp0Zll4Rkh1VGhMKzM2ZDE3Q3VsanY3N1RKV2d6elJ6?=
 =?utf-8?B?OURIT3dqTFdCS21vQ1hrYmZyMWh4Q3dLMVYvUnJ1VS9UZythYnJMU2Z0ek90?=
 =?utf-8?B?UG1UYlFoNE9aOTRBQmR1bHVJaG5zMmJiVGthK3JIRUZHa1Z4b2VCRytVUmVx?=
 =?utf-8?B?NGpaK1FLdTZKeFo0cDA1WitVMXRsOHlEL1hrRXg1TC94b3MxUXNsWEVCT2RS?=
 =?utf-8?B?TFNsRDA2VGh3cnc4NDNOVk5RM21PdUd4Y2M3V3pFYTFMN2pBMHV0Qm1MQnJr?=
 =?utf-8?B?OUQzbm9KVVF1TzFQNWxFc3I1bWdtd2xyOGowM0RidldxUGpPMVZPRmE1UHF5?=
 =?utf-8?B?Y3lMVzl3SWZzelVUNW9IajQrT3F6OTJwTW5oMitGOXpUQnhiNDgzVWNneitw?=
 =?utf-8?B?a3g0NE9qakFqeUtpZmFyMWNFbW1tWFJma1BkNmZmSFdMbjJaclpiSnFuQkdE?=
 =?utf-8?B?d0p0N3lPWUhsSGV6dVlDQVAvWVR6SlFBaUV5bjJXdkdIcFB5MDI3U2VSOFkz?=
 =?utf-8?B?NkRmdDVnbHFFZEhGdVFmM1VhNUhvczJtOER1VTl6WE5jbmdUYXJWNnFUcHpL?=
 =?utf-8?B?TkdzRUtYcXZBaElJZTFqZHNCQ0JSbzAvM2tqbGlNVkVJNEU5QjQvZ1g4VGdz?=
 =?utf-8?B?MDNGdUxlZWh5Z1JLd0NYTXVUZGxGR0l2R1BXUCt3OVhzRVV4VXdVNVlQVjVx?=
 =?utf-8?B?cVc4Q0tQbHRSQ2dDVDh0dWJrL2JiSUcwQmcxcVZucWErRWVoNTdIMG42WFpq?=
 =?utf-8?B?S05yMHhQRWlpck02MFNPUmp6Q2JhU3RnSkhZQ04wT3YyK0RWN2lnbXpYWHRi?=
 =?utf-8?B?YVR6YVltS21BdUpsMlk0a2VaUmZ2WFR1TjIrWmczSWhlejkyUnM3ek96K0dh?=
 =?utf-8?B?WUxTMjhwK0JpTVZqVC9iY2NMMDhib203ZXFmMFYzZjAwZE94cHBKNytNNVZy?=
 =?utf-8?B?N0xUdUQxTXBUemR0ZXJ5d2dHR3EzT0NxbGFKMGpxUlFtNk9mSm1sa1dNYkMz?=
 =?utf-8?B?bWpINmpja3Q1RUw5Z2dHSVV4R253VmpoUEZ2SFlGVm9DNnNnamJyT2d4b1Vp?=
 =?utf-8?B?c2FTdjQyaEF6ZlFaMW1Sa2pnakNiK2swY0l3SzE3R3JYcEJ3d0VKejdQWDFX?=
 =?utf-8?B?L1lHMzFxbE1NMEJtR0NCbTBOTVJ1cUhPWFBWRTM0ZDJWTG50Tm96M1o4MEhi?=
 =?utf-8?B?azBBbW16bCttbnQ2ekFtTGlNNXZWcDBTWUxES1BZQlpPMVA1MlptUXdkKy9E?=
 =?utf-8?B?MnhXaWdCOFN1eHcwcEZ3MEI4cnRMbGVkdDBqeXE1dlZZYkQ0aFlTNCt5anVF?=
 =?utf-8?B?UjlYZXJXMWNaaTdtR1UrcDUxQzdxL244bjhtcDBYSktRallZeDlReWpsMGVK?=
 =?utf-8?B?M0xXSENMQm5acUtDcVlqRFZRazdTdGhncUZuaFFMZWxGV1NKRlZjTllXd1hI?=
 =?utf-8?B?Tks2RCtma3p4MitGV1VHaERyWisrVjlsTFNjTnNFNHRYUFR1L1llaW5BeEFh?=
 =?utf-8?B?RTFzQTRNcmZyUjIrYUVBYVZJenpsaTV4bXNjUWM4aVI5SFhvT1ZkWUxvVWpP?=
 =?utf-8?B?d1BXWDN1Wm5LMEw0RlYzR0FsY3JFL0d5cDczanBvZmZ5V0VSenA1WDVDaS9h?=
 =?utf-8?B?TmRvcllVSHpCQ01pUFJtK0RVMWxjWEE9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a37ab964-4c2e-4f5e-02d0-08ddf2721c2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 03:03:33.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR06MB6920

On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
/sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
report a status of 0.

Disassembling the relevant ACPI tables reveals that in the WMAB call to
set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
(depending on the value of some other EC register).  Thus when we call
WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
call undoes the effect of the first call.

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

I can confirm with this patch reading/writing the fan mode now works
as expected on my laptop, although I have not tested it on any other
LG laptop.

Also, correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel Lee <dany97@live.ca>
Tested-by: Daniel Lee <dany97@live.ca>
Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
---
 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 29 +++++++------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932c..c4dd534f9 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7..335afdc75 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -75,6 +75,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_FIELD_LOWER GENMASK(1, 0)
+#define FAN_MODE_FIELD_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +277,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_FIELD_LOWER, value) |
+		FIELD_PREP(FAN_MODE_FIELD_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -317,7 +310,7 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	status = FIELD_GET(FAN_MODE_FIELD_LOWER, r->integer.value);
 	kfree(r);
 
 	return sysfs_emit(buffer, "%d\n", status);
-- 
2.51.0


