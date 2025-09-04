Return-Path: <linux-kernel+bounces-800388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBDB4371E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889AC7C5091
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A42F658E;
	Thu,  4 Sep 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b="MuRyPSuD"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023095.outbound.protection.outlook.com [52.101.127.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE952F6198;
	Thu,  4 Sep 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978173; cv=fail; b=opS1nzXy/OiDKgbeXK1gH2kBYoApF+UDIamOhrI8Ay9/f/bNKguz9/EagpbXDF64RJ0TJtP2MAeZTezi2j4K49vSd7gi3xksL02mT9ar/Mk51KeVskjIcOEP9Wl58ZrX3yHDgjNByhe4RkVgQtCW7AWcXvKSrjJI3LXFfwVgNig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978173; c=relaxed/simple;
	bh=ee6YUNatPBWLjxrY31TfiBlQaH9XIqRh5qMbBlMggDE=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=a3Xo6+DN1Ul/owPutPPDpXNdXNIpC95+6f2wNvj85XlSnc4ve/jl5WiLQ8+xo5qoHz2gljHRN/GpWTB7nQWfrSaooc90sX1H+pJDrDTkg8b9SJmkFjHo2CjDaQmepJPoiMtCG+XUOGVsMMjJMKvwvgSEOF77BfbEcy58h+2pa1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw; spf=pass smtp.mailfrom=portwell.com.tw; dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b=MuRyPSuD; arc=fail smtp.client-ip=52.101.127.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=portwell.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URLHDnUHxaT7/JCVHp3w46SJp7gq5MUbnvYcTCx3+Pq40QWqnQPuwz13rXf7Li2ZTyXKELZJbk6VH3MfRrbLBWktJITOl6xVqSv5KsoVran/B360+6KTURV4OnJvl71RHhrhsUCrumhyMhiXofaYfgPmhPqY+LjBfJxUmVzfwG7ssEei5UyPTZMSOLRVzPR9JOH9TQi3GXjXeiTM6080Wzbz7bPhsXYMmo0PUXSbrvhN3P6XZrb7KySg+8GuKKxjdWrO4tZzBKtwjQtKaN4N1PipwNRSN2ZbM1B0rGej/0r9QPfi+59VrD1tnN3x5gxqbDwSFW1Xf4BqN4xkBSpGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQLBXr5ap3DoNysqg+xt5mGarqFQIraLpvkkzwowFpo=;
 b=rlA1jUEKjja4v26R7NwDUJKuB79+2BTYTnzXcxSjsV18p3vSHyUtrW/mqsKwQLImMLzAUrwR3mesySzhbHiKbhWRdOl86idzRfGkY725TbTvzaBAeUHoDdPPCQpBaJa6CJIgDJsfoOMRyiKD4AGFHVwEl3RE6Yd1QIEQCtSZ0kR/uLtpcoLnCoN55jZLPTfGPx5V/uehCwvCED3dG6TOHQ9CxJdiJv4+BnznOxs/YBzUbzVo6C0RLYbYckN4CCXSycO2UgCjm4quaBagULhpjGy3DWd1qEtPC6rkiSoXBJk0DIy0P97A1gLnU8ObJV5XnNxLahVTFG4Q8HG5EOpbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=portwell.com.tw; dmarc=pass action=none
 header.from=portwell.com.tw; dkim=pass header.d=portwell.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fetCA905017.onmicrosoft.com; s=selector1-fetCA905017-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQLBXr5ap3DoNysqg+xt5mGarqFQIraLpvkkzwowFpo=;
 b=MuRyPSuD9KJXXrYrGZt2GnAUDBct5mswiAOImkfmRia/fWEYsxbXWkfws8EH0XFrgBTUZYMTwQrD24HjqoX5gpG0Ix2eaw861rk23pQeD75fxWKbA4gGRnMco3Xn1cl5vvO9FQNDd+NTmgXEsh65zjy4O5SFxU4se5RpDQxiUkNQ1X8rKNxzNzTfDtlpPvnZIsq1QTUy40CCd4Wo9zMRJwNVk3rKwlwc+qxPTkyTjITKaDFkvLd36e/iUQr8bM7v8ZijI5DmyfWufd6aZzFTnKskfchxIFXhxRt3zPJrsYQywJ+gFYZlfrL3svEVFlSrWrpGlYaSk0arSM8X3HVURA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=portwell.com.tw;
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10)
 by SI6PR06MB7103.apcprd06.prod.outlook.com (2603:1096:4:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 09:29:27 +0000
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3]) by KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 09:29:27 +0000
Message-ID: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
Date: Thu, 4 Sep 2025 17:29:23 +0800
User-Agent: Mozilla Thunderbird
From: Yen-Chi Huang <jesse.huang@portwell.com.tw>
Subject: [PATCH v4] platform/x86: portwell-ec: Add hwmon support for voltage
 and temperature
To: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux@roeck-us.net
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.chen@canonical.com,
 jesse.huang@portwell.com.tw
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6395:EE_|SI6PR06MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 225c3ce3-15f3-496b-473e-08ddeb958adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStWTjh2Wlg1a3NEOGk1OUxuV3k5aXhJczdrZTN0Nm4yajVWNzZJSnJ5VUkx?=
 =?utf-8?B?Vy9NcDZBalJQSVhrT3VDUXk5OUFFV2wyNnVEdzFXbzRQczJpVGt0ZkRoVmdj?=
 =?utf-8?B?UThQM0NnWlA4ek1XbjJEVU5pbjViRnFqS0xnWmk1elJTSzJFU21nc2padXZK?=
 =?utf-8?B?Yi9mS2JXb0dpQ3ZKTlYrc2FVNWlTUTRZNUdHcVJnTFpxYVV4ZzEvOWN1NXR6?=
 =?utf-8?B?R1dNbGloWHhKWlIwcFphdXR1RVZkT29DOFZzVHhYc2loZy9wNEhYSzRxb1Bx?=
 =?utf-8?B?R3p2WWM2WDBqeVZEQjF2VURSMTM3SEdCNEc4ejduRlN4M0NXak1MOWtzcWV4?=
 =?utf-8?B?MDY4THkrRER0YlUwSXFFM3VtcHhORTArZmlSWC9tdEd5VnYwSXBUZXg4TDdI?=
 =?utf-8?B?dURCdXRERjJFSWpmU0I0WTUxZ3Y5c0lYb25DclFpazNYcDc2NGMrbllIMGJQ?=
 =?utf-8?B?MEhNTytPOWxtTGo1Sm9KVjQxTER2N2kxMnU4UXVBbEg4UExyT3dkcm9GcGlI?=
 =?utf-8?B?VGpZcGZjY1FsNEY3Y2QxejdpbHNTN3hMN0Y0bFlEL3duZG1QN2V6aGozSHor?=
 =?utf-8?B?VXNDS0VYOWFWU2xCZDBzUTFrNk9VcFkxL0FGL1dNSlZrL1NIaytVYjZrZWxp?=
 =?utf-8?B?YUpWazJDVFpsYTcyWlVOVENVeGF4d3h2SmpQZUowTFBLcGRwODd0dHpNSnRQ?=
 =?utf-8?B?R3V0aXozbzZNeWI4R0YzdWU1SzNTOGorNzdBVEFMQzg5REhlcWNxeVJFWXRE?=
 =?utf-8?B?akxqWmxMWU5tWUpKYnpzbGROMmlHbk1raUpMS1h4WldDdThBWXdpU0l0UFY3?=
 =?utf-8?B?NGREZlNtMTd6bzhCWUNHL0VNeVhVT1R4Z1g5eW9oeUdsbXRGQTgvR3N5SUxt?=
 =?utf-8?B?RXUvUjIwUG5Tc2RHQ0xvZThoVnJuaFEwa3hKZkQvb0NlQTdqUVhWeXNXTjFi?=
 =?utf-8?B?b21ISFRQb3hneDNhbWxla2J2ZXQwN3RnRWtKdVJrdFFzQmpzOXNDaUc4c2p4?=
 =?utf-8?B?YWF6TG1zdk9DZ0xlUlFFS0VVVTQ1U3pwaEg5QVJpRm9xamxLUFVCUm4zaklI?=
 =?utf-8?B?UTJHUHA5L3FURGZaanhmUjVoaVVJalBneVpEbThzUHFtUGhOa3lHdTg1aW1a?=
 =?utf-8?B?YkRrN3pDVm1BcG9BWVhFRituaE5oeDJ3RTJpeEF3ejBFL1ByUFFjd210VTlE?=
 =?utf-8?B?Tmd4Z0hGWjZUVGJKQmNnaSs2TC9iWm1TMmN5d04zOXpSZTFhcERjYnBQbXpI?=
 =?utf-8?B?M2lGNkQwMGx6SU9jSzN5cWZtb0RmbkM1dENSVldYTktIZFJ0aHF3dVNhd3Fp?=
 =?utf-8?B?cHNKWk1xclZYS3MvWmFLclBkakVYNUdUeThDVTI1Ylp3VmdqN2t6bEoyazBU?=
 =?utf-8?B?a3EreEdWRUVPVWFhV2JrMCtuaFdWNmJQU0xlUVBBRVg1UG8zbVdncUZpeTlE?=
 =?utf-8?B?VE9QSVdoeE1nTUJLSTJvU054b3pYa3RHdG0vd2E5MGVkeEJDOVdmU0tSdkpP?=
 =?utf-8?B?WklLK0d6WjBqZjJqa3BPdk5Hc0VBRUFtUDJMQnlJL3RsUUl3UElSaDl2OXlv?=
 =?utf-8?B?dG9aejJseHNRbXhlWFB4b01GM0dzQ3YzcnV5bjhjQXFLZVlzT091QzZOVXg3?=
 =?utf-8?B?VXVTd0RLNi82RndQUlpQMW13TW5aUDVla1pWVnJZMGdyaE5oSUZ3K2JVcVVS?=
 =?utf-8?B?OGMwNHN1dVBYaE1sSEtzc2pSTCtjVHBGMFFteS95MXN0ekpLa2tNYnRXcFBU?=
 =?utf-8?B?Zlo3V1FjK09oSTQxcFJDWTlNTW85RTJ6RTdwbWVBaWw1ZFhObTdxaEMyN3VT?=
 =?utf-8?Q?30AsLmElloa/n8yhJpVckozckH2Kc1SJ3IAz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6395.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNqLzRNclNRVXd1L042aTROcHVQYmRQT3hyQ0pEZ1hDTFc2d0xpWWtlTXFy?=
 =?utf-8?B?OHlkQ21jQU1RUXZVZjc4endLU1M0dVF1UkN4SVJHRVIvMkVnUW9Ka2dheWZ2?=
 =?utf-8?B?QkV2ckRET2NzQndGUEJscnJjQ3ZVN09OMExHZksxbThqbkVvQklrV3g2dGNU?=
 =?utf-8?B?dG92RnlrbkhHM09ock9GS2tWbjlZS1Q5V3hSOVhpUitXWFNSUGxUZWJwMmdE?=
 =?utf-8?B?a1VZSXBwd1NIejNpa2xJemJHWnZsNUczSUQxMlRqUi9iVEtnZTM0eU5YUHlK?=
 =?utf-8?B?ejIvSHR1RFh0V2t2ekt6RmF2blRITENnSWNKY0FnNW1oSTJ0R2I5b3VmYTFP?=
 =?utf-8?B?dHJCalptYkY4MnJWZklCKzdGNVo1OGhLL1gyU05uQkhtQ2RTbDJkWHByWmpa?=
 =?utf-8?B?U3dxamxpcU91MmphNU01QWFDLzlQbFZlUFlmSWlBb3ZVZkd1dlZXMEMwNlVC?=
 =?utf-8?B?ZlZhS1hLRytRTHV0Z0JWaGcxRjVGOGFTTUJGOGdOWXFPK1ZVaUo5RkVhZmpN?=
 =?utf-8?B?U3hVc1BIZXJma1E3Vy83cUlmVU5oUDRWOUZDTW5JS09FTWdNeC9pU01uMGo4?=
 =?utf-8?B?NXVMOE13WVIxTHZwMlFsNyt6RzB5RmJONDVhR2Q5UE95cDZSTWtLRDlyRVdF?=
 =?utf-8?B?Wkk1VjBiQ2JjeFNsaWY5SVV6Qyt2TGw3K25SSk9MRHprZjhpUUlZaXg4V29J?=
 =?utf-8?B?cmdHeUxEM1lDcWhVN0VEZ3lic2dZVGo2K0pwc3NnQ2QyeElDTXZRck9GdzJ5?=
 =?utf-8?B?ZEZsMjdpN2FTTG1YekdQSFl3UXZETVNDSXRpM29SZURrVFhHbVViVUdxMlFO?=
 =?utf-8?B?SWdFTDQxcG5halBnb0NKVHM4dm5qTFlGN09iOG5lMUx2UDRlYUpFVzJGbkEv?=
 =?utf-8?B?Z2xRNlR4eVdYanM3M1lvVTBPcDZ2MDBMWWpXV3lUZWpHblJ6RE94aWorMm12?=
 =?utf-8?B?VDNqb25vVStEeURpMFFQOGgyY0xvQ3pmb0s4bHpTVGdIUC9aNEtLMTEzZW52?=
 =?utf-8?B?aUVYdmhJdUVvSUFDYzdYQ0VnNkhmcit1T2tuZ0hPQm04QldYM29BemluYWM2?=
 =?utf-8?B?RlVXWVpETnRKOFZXRVM4dFpGTUZobVFEUHYwY0xkT2hRUUtkM3psaDNRVXp6?=
 =?utf-8?B?UkJ1c2tPcmNhMi84RDQxZ29DaGtGcmkrRC9KWS8vUEVOZUtpZHlHdzkxOXBh?=
 =?utf-8?B?Q0FEQUh0VlY0ZGM1NjVJNzRQR1dVV0hpNGpKdkdFVm9OeDN0Q2RKNWFESE1i?=
 =?utf-8?B?L2FJUWhEaCtxOEdKbkx4eDNKbTJZeXgrZHcwejN1L1N5SnFEMG9QOFlGcUtB?=
 =?utf-8?B?V3hyOFRRU29zeDVOb3pEclhrM25mZUUxUVB3NmZ5SW13bHc2Z251V3RwR2JJ?=
 =?utf-8?B?Yys2QzN2ZFpaM1RrWHkrblNRZUcyNExHTXpsWVVtVnlKSkhSblZQN3NiRlhi?=
 =?utf-8?B?VVl4bDdhenlVMjlpbWVQRUZoYTloSEFBZStlWVZHNXUza2lxb25WQkt0OHdm?=
 =?utf-8?B?Ym04dXl5U3FUempiTDZ6QXMyL0xReUlDOHNoL0FSWDQxQU9xSTI5NjN1ZlJp?=
 =?utf-8?B?c1h0b1U0MDlKeEE0d3AwMzhjeStqdWEvWnZHTjFmaE1GcnNvbzNvOUN5K1VX?=
 =?utf-8?B?Lzlkbm4xcnpWWnU0YzV6SDY4NEQ2dWVIWkZ4QnlzZzI4bmhwSEw2Z1R2Wi9n?=
 =?utf-8?B?cjhTU21aTy9VV2xZa0RTclpHV2Y4enVFY215NmdYbGViU1Q1TjMydUUwYmtz?=
 =?utf-8?B?NlIvVGJmcStrQThFd016TlZMcjgrU3JNOUs5YjJocytKbUpGbWRtclE1VXpN?=
 =?utf-8?B?ZUhEaElpbVgwdXdrVEVhSXY5emhnVzd1Q09uVkhxMk5pTXNFQm9NN1N2bGJO?=
 =?utf-8?B?cU0rVVYzdnYwejl5SThhWldaOW91dGpwVmZpSjhDSFkxbE1GUHM0SXlWbkNV?=
 =?utf-8?B?TERhalNCcml2VjJ4bmZ2dm9tM2hDYVVhdUJGWFJiMTRWaXJiOWdJZmtGL0x1?=
 =?utf-8?B?MFl0WlRqMHYreGJZZ05jZDhWdUwyQzkvOXFuNVdBdWE4NXlFeVR5aHhNRG5H?=
 =?utf-8?B?OWsweEJLN3U0U0FUc0N2YlEvUEp5YTBHbzVUMXQrUWthdXRKL2dpdHY2T25U?=
 =?utf-8?B?Njc4ZUZmaWZyOTNZYllZVTJOMEhJS2dhWCtGYS8vRW1MaFNkTXpqeVhXMWFN?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: portwell.com.tw
X-MS-Exchange-CrossTenant-Network-Message-Id: 225c3ce3-15f3-496b-473e-08ddeb958adb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6395.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:29:27.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e309f7e-c3ee-443b-8668-97701d998b2c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG5Sp75RDKHeYupK3Tnx4ilwL4CmgyNt2ARrtn0TPRfLXpUDfzAnyUFIJnU3k4IUyeGKY2/EeTme2iK6peGZuasTXtrNalN4ESlj+yLAFtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7103

Integrates voltage and temperature monitoring into the driver via the hwmon
subsystem, enabling standardized reporting via tools like lm-sensors.

Signed-off-by: Yen-Chi Huang <jesse.huang@portwell.com.tw>
---

This version removes board-specific details such as labels and voltage
scaling factors. The driver now follows a generic approach, delegating
customization to userspace (e.g. via sensors.conf in lm-sensors), which
is the standard and more flexible practice.

v3->v4:
  - Remove .driver_data and related per-board hwmon data structures.
  - Remove unused pwec_hwmon_is_visible() and pwec_hwmon_init().
  - Clarify driver header comments.

V2->V3:
  - Replace hardcoded `1000` with `MILLIDEGREE_PER_DEGREE` and double check
  - Fix comma placement and spacing coding style issues
  - Simplify pwec_hwmon_is_visible() with ternary operator

V1->V2:
  - Removed `msb_reg` from `struct pwec_hwmon_data`
  - Updated `pwec_read16_stable()` to assume MSB follows LSB
  - Moved `hwmon_channel_info` to per-board data and assigned it to `.info` at runtime
  - Replaced the `pwec_board_data[]` array with a standalone struct
  - Replaced literal `1000` with `MILLIDEGREE_PER_DEGREE`
  - Removed unused include and sorted header includes

Previous versions (for reference):
  v3 patch: https://lore.kernel.org/platform-driver-x86/d6429164-46dc-4c0d-8d6f-4650e0b92f22@portwell.com.tw/

---
 drivers/platform/x86/portwell-ec.c | 84 ++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/portwell-ec.c b/drivers/platform/x86/portwell-ec.c
index 322f296e9315..0e748bfe4a23 100644
--- a/drivers/platform/x86/portwell-ec.c
+++ b/drivers/platform/x86/portwell-ec.c
@@ -5,15 +5,13 @@
  * Tested on:
  *  - Portwell NANO-6064
  *
- * This driver provides support for GPIO and Watchdog Timer
- * functionalities of the Portwell boards with ITE embedded controller (EC).
+ * This driver supports Portwell boards with an ITE embedded controller (EC).
  * The EC is accessed through I/O ports and provides:
+ *  - Temperature and voltage readings (hwmon)
  *  - 8 GPIO pins for control and monitoring
  *  - Hardware watchdog with 1-15300 second timeout range
  *
- * It integrates with the Linux GPIO and Watchdog subsystems, allowing
- * userspace interaction with EC GPIO pins and watchdog control,
- * ensuring system stability and configurability.
+ * It integrates with the Linux hwmon, GPIO and Watchdog subsystems.
  *
  * (C) Copyright 2025 Portwell, Inc.
  * Author: Yen-Chi Huang (jesse.huang@portwell.com.tw)
@@ -25,6 +23,7 @@
 #include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/gpio/driver.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -32,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/units.h>
 #include <linux/watchdog.h>
 
 #define PORTWELL_EC_IOSPACE              0xe300
@@ -52,6 +52,9 @@
 #define PORTWELL_EC_FW_VENDOR_LENGTH     3
 #define PORTWELL_EC_FW_VENDOR_NAME       "PWG"
 
+#define PORTWELL_EC_ADC_VREF             3000
+#define PORTWELL_EC_ADC_MAX              1023
+
 static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading EC driver without checking DMI boardname");
@@ -79,6 +82,20 @@ static u8 pwec_read(u8 address)
 	return inb(PORTWELL_EC_IOSPACE + address);
 }
 
+/* Ensure consistent 16-bit read across potential MSB rollover. */
+static u16 pwec_read16_stable(u8 lsb_reg)
+{
+	u8 lsb, msb, old_msb;
+
+	do {
+		old_msb = pwec_read(lsb_reg + 1);
+		lsb = pwec_read(lsb_reg);
+		msb = pwec_read(lsb_reg + 1);
+	} while (msb != old_msb);
+
+	return (msb << 8) | lsb;
+}
+
 /* GPIO functions */
 
 static int pwec_gpio_get(struct gpio_chip *chip, unsigned int offset)
@@ -204,6 +221,54 @@ static struct watchdog_device ec_wdt_dev = {
 	.max_timeout = PORTWELL_WDT_EC_MAX_COUNT_SECOND,
 };
 
+/* HWMON functions */
+
+static const u8 pwec_hwmon_temp_regs[] = { 0x0, 0x2, 0x4 };
+static const u8 pwec_hwmon_in_regs[] = { 0x20, 0x22, 0x24, 0x30, 0x32 };
+
+static int pwec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	u8 tmp8;
+	u16 tmp16;
+
+	switch (type) {
+	case hwmon_temp:
+		tmp8 = pwec_read(pwec_hwmon_temp_regs[channel]);
+		*val = tmp8 * MILLIDEGREE_PER_DEGREE;
+		return 0;
+	case hwmon_in:
+		tmp16 = pwec_read16_stable(pwec_hwmon_in_regs[channel]);
+		*val = (tmp16 * PORTWELL_EC_ADC_VREF) / PORTWELL_EC_ADC_MAX;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *pwec_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+		HWMON_T_INPUT,
+		HWMON_T_INPUT,
+		HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(in,
+		HWMON_I_INPUT,
+		HWMON_I_INPUT,
+		HWMON_I_INPUT,
+		HWMON_I_INPUT,
+		HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops pwec_hwmon_ops = {
+	.read = pwec_hwmon_read,
+};
+
+static struct hwmon_chip_info pwec_hwmon_chip_info = {
+	.ops = &pwec_hwmon_ops,
+	.info = pwec_hwmon_info,
+};
+
 static int pwec_firmware_vendor_check(void)
 {
 	u8 buf[PORTWELL_EC_FW_VENDOR_LENGTH + 1];
@@ -218,6 +283,7 @@ static int pwec_firmware_vendor_check(void)
 
 static int pwec_probe(struct platform_device *pdev)
 {
+	struct device *hwmon_dev;
 	int ret;
 
 	if (!devm_request_region(&pdev->dev, PORTWELL_EC_IOSPACE,
@@ -236,6 +302,14 @@ static int pwec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+				"portwell-ec", NULL, &pwec_hwmon_chip_info, NULL);
+		ret = PTR_ERR_OR_ZERO(hwmon_dev);
+		if (ret)
+			return ret;
+	}
+
 	ec_wdt_dev.parent = &pdev->dev;
 	ret = devm_watchdog_register_device(&pdev->dev, &ec_wdt_dev);
 	if (ret < 0) {
-- 
2.34.1


