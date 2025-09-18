Return-Path: <linux-kernel+bounces-821826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B8B82669
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7922462BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD901DF748;
	Thu, 18 Sep 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiQca68I"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70F4315A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156151; cv=fail; b=JpDhyY2e75ICqv8ZYK/zIPpm+OprXcZQn0h+Yj4Dce3YnU9e2gLeYTHD938FcNs+zUM/g/yeALCk2NtUC6J+WDsNWxTF8nPXnbmb2K9/whafoT69g+jbuPAX4Cp9Yypzfv7gL779KbCG8VgJZQFbnYE6xmmW1wEEiJMeXI/DLoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156151; c=relaxed/simple;
	bh=7nHiPDw0wRITbi4IGLJQxFkHh9D49W4gNytW2blYFVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHznCTUN+wfPGqzbkDO9W1epXpV33MRbqSSNZgaNwIrmHJIupx1GXOzZbu2pRoDkNQDsB21ZAs4Cc9DIJ80/mKQACol0IB22XQoi/3opfTyxf3RJDysawY333mbXDe77qdVukeK4phiKpU002veF0nQKJEHFR0e9tP4uyVAb9jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiQca68I; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isZa26roBJGNSeklkAOBv7hdZiAoe36m9spcDxfXGIjGkbcdc/0hPliHmIQrykOV9lPuwp1aC51qqpc8L9GceL0M6LcshK2sglYjOk3Syw0VxTQSzcDL/iOdbGeKmnkXF8CcFQIuFTXAEtJeLy3uWNiWkP8fozp6xF0IamPvgaVpy15sPvqLpEmOZbqQBdLTNjqhKDEhUpPvmviTjOJTdNsmeTW8FTexKtMQ3iTKJGVfLjGcC4WRbWFVdhbNJVLhQ5Lii3/1bagW3DpaLD7IRmY/0wspPi9L7lnkYRDO3lNp0VShW4BBMk8+4nSW8kTyvrL5P97M983WnviSbsEhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nHiPDw0wRITbi4IGLJQxFkHh9D49W4gNytW2blYFVE=;
 b=ndRoQBNYs7j3yWojvkFcj81uIU9L58TvGWARMmng/6fqR05Y21kaObo+ks55qCEIo6U+yt7M4BTkVxY4nzUVv6IlWeRlc4L6/G4DQ4a3ruy/oTZpTqTtYegjDbk5cu0cNkvJhAmkZXneHlM8vJgBUGhNKaiGf8uRFxXIVr9nPdbOCfy5hsSnxyZVIPdk1CaL32rI5SzOX3bnDczdO8hEFmZG4md4IEknPkPIbtYilK2tPWMYWS49V5jqc+j2ulgGG3RcObtDSM1Icg3djftSOR8fV1OY+v96G1rd85lMWxPoFq5mieL60jFfFo/qh9RmR/Ksrt4s2mTef2UQHNSf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nHiPDw0wRITbi4IGLJQxFkHh9D49W4gNytW2blYFVE=;
 b=BiQca68IJe0V6HcRZt/b9d4gBN9ioL5JiYYQnaJzw1vWO+EDyVDQ12Td2bwO78S8LiYLFoNPoXsMrNt/arvLjBy8//c2g7lejykE1kR91UUtJzs5QZpAgoOXVY3kKPvJo5heYL1V5lONfdjKa/uepUB2CnyKh4+GxqwM/H35KQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 00:42:25 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 00:42:24 +0000
Message-ID: <2cf25bb0-eae4-43ce-8282-be9a2d475413@amd.com>
Date: Wed, 17 Sep 2025 19:42:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Fix counter auto-assignment on mkdir with
 mbm_event enabled
To: Borislav Petkov <bp@alien8.de>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
 <437d6c22-f232-48a0-94db-a395aabe85d5@intel.com>
 <6d25c7a9-02f9-481f-9eb3-b1f6e3276e58@amd.com>
 <20250917092639.GAaMp-zzcfnpFkVUiG@fat_crate.local>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20250917092639.GAaMp-zzcfnpFkVUiG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:8:54::8)
 To IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 384fddd5-694e-437f-6085-08ddf64c3c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnhFOTJsSTlHSEl1VWVlajc1ZzIzenoxOHNBRlhlSVhNQzdIbXE5OGdCUGVL?=
 =?utf-8?B?MTI1aTArL2l2SVZjTlRzbThlaWhGRWZBMDNSUmhQaXpBR0RZcVh2WnVINzVD?=
 =?utf-8?B?Q25rNEpGS0s1bCtxTTZpWTIvNTdONmxvS3VLZzlkWFMrcTdXTyt3QlVaVTc2?=
 =?utf-8?B?TlRTV2J4cTh5bHpJYWgyQmZIRnQ4RmZUZVFaWmNjVGdlSHc2bVVLZ0Q5d2E4?=
 =?utf-8?B?UjBUa2ttS04xZFpPVW1ZT0lKUW4vM1kySTNjSkhjRVMvRC9GSlF2WGxrSm4z?=
 =?utf-8?B?bFZRYlNQa2ZnNnNubHBIckpqZDNQUDlKelpzZEZIZUxiTzhFSkxkQzFUMWJU?=
 =?utf-8?B?cjRtMWxobHc1bzlrOGZrbld1ZDRzV0gvaG9ibEZRcElhVmNYWk9rd29IYkQv?=
 =?utf-8?B?RDY1dzVHdnd6ZFNmb3J5Y3RjZ2xIdjNqNlRGY0JqL0FURS9nS1UwT1BoRmRE?=
 =?utf-8?B?cnhtamZ2Qi9hNkI1bHdsdVRSRnBDMUVzQjdRajJyWGdVa3g0aWNGalBSRXNW?=
 =?utf-8?B?b25NZ3cxSEhGSytWVEpwaGVScWhYOHM4YnpIRVNYU2VRWUtuL3VVR3IrOTFG?=
 =?utf-8?B?VTVlRldFWjE0dGJpTXlWeXY1dkpuUkNxUStmZ2diZzNNaUVhL2IxOXRPa2Vw?=
 =?utf-8?B?RW95NUVIeTdQYnJRZHY1Uy9ZYVg0RU1ub2EwU1RIZ3hDVE1TemcxRW9salFh?=
 =?utf-8?B?YUtLdDYrOVk4MDVsNjV0RXU1WlBiN3VpN05Qam12amxDZStFNWVCWkdKUHNj?=
 =?utf-8?B?eWNCTUgrekRCMFdVcnJQWFdPcUJGdml5VG9Wb2Y0NUV4Ky80YkE0V0tIUzJX?=
 =?utf-8?B?dGJQZCtlMnprV09zZG04L2dCUGxSd1RtbllPbElGTVpJbzMrSG4vWW5QSUpj?=
 =?utf-8?B?cER0UVhpLzdYWkxaaXJydnhuMVBPalpncFlRTENaOWxhbjBjZDQ5ZmhNSzV6?=
 =?utf-8?B?YkNmTUNlWFNCSC9LT0dMQWwwNDF0NnhubmNEL2huM1N2Z1pmVWlMMjRtV2s3?=
 =?utf-8?B?aSttYUdlYjU0MTFnRGhQTUJUdE1rVTk4T1FMaklSRlZiK2liTEx5VmdGcUdv?=
 =?utf-8?B?c3JHWHY2d25UOWVzS0c1RWpYSDhqenVOOXF4RHNpT2hZbk5Md2JNUTg3ZXg1?=
 =?utf-8?B?eEkwenRlcklDeTlSWm83UEI2ZlJEdHNXdjNUUjk0bWhsTVR5SW5HdEt0SE4x?=
 =?utf-8?B?VFd0UWMxbUVpazRCUWVpR3Z5Z2NUVGc1aDVaM1BxclI2YjhpMGx2bVBGdGNy?=
 =?utf-8?B?blBkTU5GWnVibk83R3QvUkxQZGpxdE1OZTVFc1cvUmhCRE9DTWRjSHhTbHhG?=
 =?utf-8?B?NDdCWkJTUDB5OFM0blp0RDRnNkFuT0xmdFNNeEk3NDR1ZGIxY0swVGFSSVZN?=
 =?utf-8?B?eXRFYW9sVzg4WGVrQmt5V0dLbXFLRm50V1c2bUFZa1BtZnNtNXJKcTZDNk0y?=
 =?utf-8?B?ZTRlM1JEQURJWi9mSXczalVpMUxyeVc0K0hTM3dMYStCbnNudjNTN3hDZWFs?=
 =?utf-8?B?WmM2UWJLSDk4UkVGb2UzM1lOMlZCSlNNZzF4VjM4SmNrVWdzejRLb3J4QmlO?=
 =?utf-8?B?dnRkTWJXaFdaWVJZelZzQmh2S1hMd0NNbnNZTmlCVFRxanJPejgzVXVCbnc4?=
 =?utf-8?B?eDNvd2tOWmJkN0trRE0xZ3llYWRoSVpOSHhuYjhtZWZPT24wcW5kdmUwRVlN?=
 =?utf-8?B?N3J1bVNGSG1rMWptSEdHaCszazZWWFB0MVJlQVNlTkl6TVpDOVhzM211bU1K?=
 =?utf-8?B?S2M0bDBWY0lrQlhjcWZvTm1NbCtmSDBYOGdiWktCdG5vQktJUkU5dko5SG1W?=
 =?utf-8?B?NFNYcjdlWkRlVjREVjZka2dJbVMzVGVnNVBiakpUL1N4Z1ZTbGp1am9iRjA0?=
 =?utf-8?B?M05BNUEvR1huQzdTSW9SSVVTZG92Q0tLUll3ckx3Uzk5NEwzSHJHaDB2b2xO?=
 =?utf-8?Q?8PkjNSZLQQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdqcHdMdGQxRUVFeFh3NUlGci9VSTBuUG93UWVicjlCNnVBQzBsc2EvWjJU?=
 =?utf-8?B?OUFybCtnN0FoaCtVWGlhcDBPb3ROMTJwKytJWEV2ZzN5eml5dUJWQ0RxMGFC?=
 =?utf-8?B?QjNmbXhSMG9IUG1tc1QzRFdwUjZZbWVwY3U3Q1Mya3NIb1F0TDNsNnV5NUdv?=
 =?utf-8?B?QlhOZ2tVYzYwTjA0dkdkQkg5YVRINzZpeFo3N2R3NERsSXVqQWp4U3J3MnFx?=
 =?utf-8?B?WEsrWEdvb045dFBqNm1NRFJYbzNVcWkzSHZtZlFvMk5ubk9sSG9NNXF1bVAx?=
 =?utf-8?B?anJOMVVJZXFScG1PSi9PaDZMem96cndBdFdQRTZZcHBlVFgvb0src2V2QjNV?=
 =?utf-8?B?S2U4bU1udXVES1lpcVpHLzY4VXlyek0ya0FHcXdPeGpsc1JzY1NUVHd6aUt4?=
 =?utf-8?B?QkgyUWpxNjZoaldibmlwYStoZFphOVkzOTRIeDQ4cklKeS9CZGxCcXNNWEkw?=
 =?utf-8?B?eTYzMXpZT0p0WkZxZTFlcll5MW16SWl4K0JVWmthbWwwSm5jRkJRV1Q3RGw4?=
 =?utf-8?B?aVA4bEtSdHRmTXk4YjNOV0ZuUFJJRjd6L09DWkZZaldvemRlU1dGQ2l5TEtO?=
 =?utf-8?B?eU9hdDhmRmhyazcyMGt4MEZoSWlxTkFvWlNxMDcrREZ2TWN4amhheEppdnMv?=
 =?utf-8?B?dUF6U2oxWURBQmNIMW1PZEM1MzErd2gzazNFbEU0RlE3N0g0eEFQdDVOby92?=
 =?utf-8?B?RThEdkR3TThaeFRydHZEb3UrTmRhZnRLUVlzRW9QR09taEZYV1Y1cURKQXZ0?=
 =?utf-8?B?ZkZMZTAwNmpUbllST1oybmdWSkp3NXQ4V2FESGpyMzNEL0xhRitYdEgrYU9v?=
 =?utf-8?B?U285SWhRUTlLcEpXQmZNOE10QWRqMVM5akdaUlBRcWl4bmZNR1gvWmlmMkRU?=
 =?utf-8?B?L05BOHhhYTZiNmpqdHpIL3N6T1RLcDF3TlozWXZYVjd5U1RqN29tUEROU3Fi?=
 =?utf-8?B?TmZHUDNjVkJWalhKNDYxTENwMU9OaHJBb3pzU2FGTTVyWit2TzBRSXFISURS?=
 =?utf-8?B?aTd5Z1lOZHhtQUJBZ1ZtenJsTURpRHdSbzUrb1Vyd3BKVldFUHlZeFh2LytQ?=
 =?utf-8?B?YW9mNVdyWnFsWTB6WDhiVTVYS0VQSGs1dnpmZ2tmVFVobjNvSmppckhEQjg3?=
 =?utf-8?B?UkM4eXBCTmpCT3JzTW5yU0luUlZnOGlsYnJPcEhEUXpVSGR6Y3lSSWtpMlBC?=
 =?utf-8?B?RXZEU3FWUzR5WGk3cDBPeDJ5bFhSUzI5TXQrUi9RU1pyUnZxZzhEd3plNFc0?=
 =?utf-8?B?NEliZU8zMVk5dzhRR2xmajA1Q1BxeHR6dnhETTVoQ29ydWwwVTRVVHVFNVhh?=
 =?utf-8?B?dUlRT21pMGlJdzVxM2JVTXAwbXBQcm95d2JYU1pNYkpZS3g4aEZ6L2V6YjFP?=
 =?utf-8?B?cCtjV1FoallkUUpoUVVYQndiblhOWXF2TnZWTkVhRUMvZzFxbCsrRFNLMWxG?=
 =?utf-8?B?MnM3VWpRanJDYzFIWSsyK1NpTms0ZVEzQUY5NDRyS3JrQlVjQ0ZhMGx6V2xw?=
 =?utf-8?B?Z2NXa1ZSMXo4Ny9tQ1ptRGtTelRSNTNuamxDUldJdVprUHBxR2pzc3N2VGdo?=
 =?utf-8?B?SklBdTZqenhiczVyVzY0emd0UlpYb1ZhcHBkZzVrZVpEUzYrWThvMzJNZHFa?=
 =?utf-8?B?VnJwYWE1aitXVjZJUld5c21qa1lrUGZzbE8zODA5aHhiMVVNWmdzWEVvUjh4?=
 =?utf-8?B?eWdvTy81Z0NEZG5UcjRpRXFkdnNhQ1dkY2pPVVRFcEh1YTQ0d2RYNjhIMFlx?=
 =?utf-8?B?L2h6VFlYaW5YbThxN0I2dGRPalFwN1NVVmJEZGJya1FreTFZUUc5dGFiNFh6?=
 =?utf-8?B?TXNzdXhXYTIyVlZITUlXVm5kejFUVWo2Q1BQUHRNbmhjWkZlaFQzRXNDYzJY?=
 =?utf-8?B?WWloNFdHYUtLUXlrQUVJcTJXYnp4RzJXQWN3c3NTdVZidVZIWVl3R3Q4S0l0?=
 =?utf-8?B?My9KNERTOVRzdzJnckc2T0ZCZnk1aUxIYTdaa0ZzWDBKU3Y0UDZzbmNpNUZt?=
 =?utf-8?B?Z2ZSTWRhVm9XWWNZdkJSSnRMS3N1Z0FySXM1NFNxZXdLdDB6bERUejFTbWVI?=
 =?utf-8?B?czVLVk5QaTd0b0Y5cUF1c2RwSkVoZ3VVQTlYZDZYNHkzVzBLb2JwV2hObFpM?=
 =?utf-8?Q?OU5HnlDfvQ1r69FXC3RUDs89Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fddd5-694e-437f-6085-08ddf64c3c4e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 00:42:24.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3Fm1qzxI4GgLQ3W2MEQUuQmPZaqWKgZCCS5VAcEDnLu4kYrAYqo18PSUeISRebz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748

Hi Boris,

On 9/17/2025 4:26 AM, Borislav Petkov wrote:
> On Tue, Sep 16, 2025 at 05:46:56PM -0500, Moger, Babu wrote:
>>> It is not clear to me if the changelog will be acceptable and I provided alternative
>>> text just in case. The fix looks good to me, for that:
>> Looks good to me.
>>
>> Boris, I will send v2 with updated changelog. Let me know otherwise.
> No need, lemme simply do that now.

Thank you

Babu


