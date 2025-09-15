Return-Path: <linux-kernel+bounces-816533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA0B5750D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8EE18883B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF652F998C;
	Mon, 15 Sep 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T6zBu94X"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3122223DF0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929343; cv=fail; b=vGHKvT1/e/060tKsk/oa2AbHCxyDY3xBPa+NYhpGaFAb8B9Seo55EyEoaRl4HPS+Gas0wymc5adQ/nqp9b4/uUQa67mBxzgNsc3na9zohUF2l7HyUO2j3+R0TfJ8PLsyTEoJVMNqu2aWPSxv14XIzdjUafBs+BJyPHWRBZu5zOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929343; c=relaxed/simple;
	bh=1wwFuKu6Gk9JxSrU7CoDwmR7jYSv7Z360zVzs8rJpA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpiNxITnZ040B/zYr04D77R9BucMw+lC+fqvmvlrcOJD88d8VYWpDXhbyjom52S1cIsq4qqvrbXd1u3Y2KwulVmYxIm/mlbx9iG7237m2vba+rOyF1UtbYpn3bCEUnyUxgrenuPbpzBeJSHmV/ejfDZxahdkPGP4+VFc2/lNC6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T6zBu94X; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfF0Dvr7sv2fSlXOEub0PrUrdJKAUcxynVQHGare8KqL3U1lcoHM8rTIC/uKQ2vMSlFCOxb04Z0VCsU1eopya9tl4D4RbhiKQdLXH1ZJy0nhQcmOVBOJROLT/kGqdkEomxpVtRRkaqG4LP++2CfijiP/RZZdiZYzXyZCSx88xoeRnVz86jigWTMqXLYLSAiTNBgEjHUcs9dgq3/20rV7C5L7fXl3LFf18n//mxBq5bR+2UzV7pwGhQMDi3QQdredwWruC0gpnRxMeWLzukLeMxahAfyVEaAqxTQ7/SEm16QrQ5wBrsmnFXCBAJOmd5SXhSNm1qze/VlMM1KZLKAK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abQcIUBTvsJpAAJ5y5Q13vDRUujsMi5CVbNalxoLMeE=;
 b=LK9kdHluOdDnX1uOS0gsWXBBPFRbTrFpTbIT/Zws5Eca/zdV7xdM5i6gzPV5UN0lIz56U/bi0zTKF0MUpLvTykaGt3xLe1+eVve3w1YrGvQljb6GnAJwVzQE4HbxXASJP3gL1cNkOD6hQBDOLcTZ0Ueg/aJn1kBdK77iDPzLTKCiW+L0hiM9uGq19UHtELGdufcnWJ3jXJ+d30Tn2xVXz0qNiZ8yvHvr3uxkUuMAnazE70r/kmq4EtoodWBmIwDNj3M/mVWvPqjB86yn0v8LFfh1sQKL6Uc0px8I/CnPUPDlUb5zWMQjORSn9wsDgz0lg1s7F06r6tSjsX4gtHvLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abQcIUBTvsJpAAJ5y5Q13vDRUujsMi5CVbNalxoLMeE=;
 b=T6zBu94X8YTZeN1Lqz/rfDCrgErj7d7tjlsC8TIJa3FdSpWma1Zb7kj9t/edpF1rC7CUHqeae/gqelIO9rGbjpUDo1kwKR8gE9GjK38z4srzyrkjKbDPc7wKB9Tj/MP0iehOa3cvozm13bASLBi3cNHX4SGEYGFPpaHsUEczpIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 09:42:19 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 09:42:18 +0000
Message-ID: <83031b07-14c1-c4a3-0416-ea60c3f703f5@amd.com>
Date: Mon, 15 Sep 2025 15:12:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] cdx: make cdx_bus_type constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
References: <2025091439-sustained-acorn-4af4@gregkh>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2025091439-sustained-acorn-4af4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e4ea77-7194-4e2a-e1bf-08ddf43c291e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2UwYWpGU1ZEaFZ5SVh4WU5sZmNQYkMxWTdTaDh1a3VGdFFxNWpLWWUyY0xR?=
 =?utf-8?B?WVp5M09IVkxqcjVvaVM3TkZ4Z2w5WGlMRE5ZZmkrdzlZUEpqMjRuQ2EwbVhk?=
 =?utf-8?B?WWFIQ214NzZ5cDI1c2xETS9kYk9hd3RwWkx1RGNJQk43Z0tTT3NqUndGM3ZS?=
 =?utf-8?B?ckRRcnY0TDFYbmNjaDhJS0R6OFVnVDZvZmhsOC9tWmRsSGNSTnFqelFzNVhW?=
 =?utf-8?B?YmxGVzdrSTZlbE5YcWxCUWNnUEFEN1BKN2Z2YTROTXkxbjNmSG5QNEt2UXh3?=
 =?utf-8?B?WHI3L1lJdUpTODkxNk03ajFTYytITzNic1dRckUyUXVjRXRXSXR5Y3lFS3dG?=
 =?utf-8?B?NEFhK0g2a0c2UVRMQm1DUlRuNE5FdURPSC9GajhaYi9LdXBOS2tzMXNPdHZp?=
 =?utf-8?B?STZYUjFFSlRxcmdIbFJuYjB5TUEzVEI2M0Jhanp3SU4vSHdCaWtzQzhUK1hy?=
 =?utf-8?B?RXo0YjJLRkVxN3plZ1ZUMlNZTk9idWpFWWN6K3NnQ1pSMDM5UkJiRVFvczVI?=
 =?utf-8?B?dWhXd0dNYVdkVjZ0WGd6UFRhQmd0N0VYaWxLOWx3SzVkKzBTMTFnbkllTHdU?=
 =?utf-8?B?bThxeHo2K0NhQjBmbDFHckhyMU1lcU40V0E5R29TdEx2VHplTmZPa1RFd1pv?=
 =?utf-8?B?NUNUTWU3eWxMWDErR0YreThQREg3NjZHdXphTlpWaDZoNFBWVERtZFVDUUZa?=
 =?utf-8?B?Y3pqdDdCUnZXSStVT3ZZdnlxbllxUkU3c3RtR0VHNDQzVTc2d0hPa0xnTFRF?=
 =?utf-8?B?Ri9Jdk1hQ3ZQVTRQTDIvN09CdlJZc3lnMUVmNVZEZGE3M2QyMUZTVUJ5QmYr?=
 =?utf-8?B?VjNUYzJPOHB2TE16OHdvbm5MdTMzV1UxekcxWnFTVmgwRWpDcDkvZTB4MXFY?=
 =?utf-8?B?dkJic282eWtDNklMbHlBVFRaU0twNitYYVRYdjdDcGpFS1NySUNUVDVHL2Qx?=
 =?utf-8?B?MVdwOUMrZ0RVODlWZkg2SjVjam1rU29wWUpTcE5INlRreWIwZ0xyZ2FvRjZP?=
 =?utf-8?B?cVRxb0lNWWcyajZWYi91eDVsT3dPNnBBa1h6c3dsbUNIT1U0a2UrWDU4Z2xv?=
 =?utf-8?B?NkxLcXVob2p4VVZhQ3FHU2FucHFnbzUzQk9BazJ3YW1iR3BRNm9hYXcrdEls?=
 =?utf-8?B?V1FhYm5qak1Xb2JtdDVZMmlTakkxVEdIZS9UQzlDeUxHYzdVQ0ZsNkdEZE54?=
 =?utf-8?B?ZkpEaVNFbWJRZEhzYTh1UWpEeEpsZy9mc2p6OXVROVFUT0RpOGVLb09yOVlu?=
 =?utf-8?B?d2sxbnJPS0FFOG5OM21kbno1cG9mSWV0UCtQUysxVTVMWDEzL09SQUU2RzdR?=
 =?utf-8?B?MEg3N2VqNnlFU1NJR0hKNDF6cDYrc2lzbzMzVEJLZGJ5M2VuYkJCeTFRdUU1?=
 =?utf-8?B?b3c5VW9LQmJvRFlKcjFFZDk0Nk9sUzg1N3Yra251b2J2SmRFL01wWTNqWURu?=
 =?utf-8?B?UkdtT2d3Zko3cWswUGRVeEg3WjR0OXlZR1cwcStnSUJEODQ4OHRtNnpzTkIz?=
 =?utf-8?B?QU52TlM3QnlMU1JPdHp1d2JINGdIVDF2QlBpRC9td1lMYjkvU053MmxZMEtJ?=
 =?utf-8?B?K3ZWUSs5RmxwTEM4V3BMRWh6aDUvVVZsWk4xTmVaRTdZeGcrZDJ3MGI0SDAy?=
 =?utf-8?B?TDZQOHo0Wno4bGZVc24xREJjSnpZOWRZL1IxN3NEVVdNdzA3UDYzTjhhaDhR?=
 =?utf-8?B?eW92NUhsb2J6dUo3WW1NUCsvMnV5T3l5OW1aK1pjUzlNRFRaN3pZWEoyYVBu?=
 =?utf-8?B?Q2xieWtRZnNsc083RTZRYnlIME5Hdi9QQ1Vjdis4cVI0djVEcDRXWXJneDFI?=
 =?utf-8?B?SFpvaW1NZ2VsZkY1ekoycTl3Nnp6VEhjT1hYTU80MHh2NGRVU0s0WkxBRzNq?=
 =?utf-8?B?cUZGM3ZheFZOQjRuSjUxTkduNmNqL2VQN0VGdjlQUFIvVE5sNEFHdG9BQjVr?=
 =?utf-8?Q?8LaqhEpFEm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJjN2VrWE4zME9rc0dwbHhDa1pvdUpOUy85d1A1S2ZkU0NSRG43Y0RONVBI?=
 =?utf-8?B?cDB2RysyZW92Q1Z4U254bno2c3B2eE1uclhHa0YwUVZsekk5ODhZVEIyRTZv?=
 =?utf-8?B?U0hFbmp0ME1DV1phSUppdlpKVHZhd04wZnZZNE4wNG5reEk5ZzdNQ3B6b1VT?=
 =?utf-8?B?K1poZDBMUjNETHhXZWVGNGpTSUhDVjBNRW11Y2J2YXNEU0VZVXlFSXRzVEl3?=
 =?utf-8?B?T0NaQ1pLSVpVVGFJeE1CVllJZzE3ZCtUZGJnSUcyYlkyUm5wMXNEVjZBRU9t?=
 =?utf-8?B?T2ZHRitIWUFsbS9zamlrM1NXc0o4RHNHdTc3c2FhSDJTRDludEV6Mm80L1VU?=
 =?utf-8?B?TnRjMkpoUEp6d1IyS2F0TVpwYnk3SUZJY1dnOGt1cGNlZ09YS0xMc3JHTElR?=
 =?utf-8?B?UTJFSHFZMXZ5Qlh6QjFxalEzMnRScVRhQmQ1VmdqSHZ1c0VuV1pGcHV5b0V6?=
 =?utf-8?B?eWNURGhCMUdlL28xbi9ad3hqMnI4eTRWK1MycDdqZ1c1SXh3UXUvbEdwWlV5?=
 =?utf-8?B?V28vSkt4d0ZsYkd5bXowVVRTMXhvYmszSDl0UExURDlCSDZVSUNpcHpUK2Zr?=
 =?utf-8?B?bVdqSVRRU1BoWmxYek82MnFzUFd6UldzNkVIc0Fpb1VwNFdzQVl4bjMyTHd5?=
 =?utf-8?B?a0t3NjR2cktRNnJjVGNLOEdFUVR1NXFHaTJNSS9KaGpLRGZjbVpDMi9NUENV?=
 =?utf-8?B?TmFlMW1JRVZvbXhReThnRTFpS0tadGwxd0w5akYrTlE0ZzFuZm5XRGhXZ1ZE?=
 =?utf-8?B?ekNoejBMWGdkZ09NOHNHdnVTNTdscGJwL2tXOGVPMVZmdkdEeUw2RFNaWnA3?=
 =?utf-8?B?MXoxR2MrbkMvZzNrR3A2cjN5WWJQaUpaNkRaL2lva2VTRVMvRGlTaksxVUJ0?=
 =?utf-8?B?Y0hYeWJKWlo4aU94RUdwaHllelRsLy9XZk5BaEVpQjBFNlpMWlFteGt5S3RH?=
 =?utf-8?B?Y2ZIaXBpZ2oxS0hvZTRPU2s3enZUTGRFQVNLT0pGSzFmMzRNSlhjc0plYWcy?=
 =?utf-8?B?UUUrMDNSSzJzQjRURll5c0FaN25vd0hBNFd2OFU4bE1XY00xdlRDOVpnMUtH?=
 =?utf-8?B?SndrK3UxZ3l0MnRHWnhkc0tJbmIwV0tzM0tvSFBiTUlZSSt5VVZjYVF0N2tF?=
 =?utf-8?B?SndPK0UyME0vYTBSdVptZ2VFcHlwS1IvQ2pPcUlOdEt1amN2RlFERUhqY1ZT?=
 =?utf-8?B?QlJjaFNVSDBwZXU5K1pwZHhoZHJGOFdSMzhTbUZZZEsvazVscWU0c3pyV2p3?=
 =?utf-8?B?eGtsb3pGQytSR3hGamtFSE11SzRhTjRQWVAzWmhuT0dIalhwZDUvbmM2WnJJ?=
 =?utf-8?B?c2pPY3JYY1dhUndvYnZzTkxDZGZtOHE2ZDN0UzlIamh0RG1IeVN6VzdNM0tj?=
 =?utf-8?B?RDVrWGZxNkI0Q2VhL0ExRG9MdFI3NGttMHEyNnNTRGg3RzJiZW8zd2YvbWJh?=
 =?utf-8?B?SlFYZjlibEIzdHA3aGlqY0x4dnhFcStBRmQzTTBPSkY2MGVZTDNlTmdaV2VO?=
 =?utf-8?B?WWtkQWwzYWVjWGxuQ0daVXYxSklOWFMxWGtMSDliSE1Ka3ZUejJTWWh0Y08y?=
 =?utf-8?B?aXVIbTlrVWRzQzBEM29qcTR3L3RjS1lNSFowZnhFZG04aDNlbWJRSUpmMW1L?=
 =?utf-8?B?b1JnR3NQbkdyY0lZdndNUlZxN1NGRVFIWlk1UndIMkhoMHpJeVpaeEdHNnlq?=
 =?utf-8?B?ZktWYlMxb1F2T0U0bWZVaVNFNFN0bmFac2tTVW9HK1YvNVVyamZrYXZIbE53?=
 =?utf-8?B?OEwyVGxIb3AzZFFiTXhqTTdyZ1lHM2JCaWNVaEhRSzBSQnpqN2xMSWNxczBv?=
 =?utf-8?B?K1JEcWtUbGprNnZhMGNtcFZNZmQ1NmxBWFZqdnN2YklDZnU4ZGRNUHgzU3NJ?=
 =?utf-8?B?c1hmdURGdzBUM2N0TytFMWNSSEFMRFZKbWxkK20wVGlhM2Jnc1ZIaWIvc210?=
 =?utf-8?B?WHNCNzFldDd4NVFNcFdEcCtZSy8vTHhEM1F6MFRUZ3hGSlNQQUVzeU0zQjhm?=
 =?utf-8?B?azkrR0IzUlR6RWxzZmNOOWtTdEFaSVpvL2dLSDdlT0RmTWM0bVBwS0ZOUHdO?=
 =?utf-8?B?T205N0s5b3k1SFJ0QllkdzNseURsTUphNjZTbnFhZ2JmZ1UxenI2clFFNWU4?=
 =?utf-8?Q?lKVgbUU462XwEVPT3rmUNy+KL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e4ea77-7194-4e2a-e1bf-08ddf43c291e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:42:18.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SRbgKKmzCra8BEYBCnYJEJSXylUIw4Fzj/VqeHcE9VnO53mKLAeLQkboAcXLB8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970



On 14-09-2025 19:12, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cdx_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>

