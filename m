Return-Path: <linux-kernel+bounces-895083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416EC4CF22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025964A1DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07233711D;
	Tue, 11 Nov 2025 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLFe0gzD"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA333735;
	Tue, 11 Nov 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855106; cv=fail; b=SrH9PDo3gsY/CVW9nGQlJFWC7X3GSmCpApauuyEPvkRon5k5bZq3T9dWjCtjugZjCGSn/yJkhWMKtGqw4C3rbFu9Ot3OWV1VrAwu8p2Ud/r2jvePCWLY4JFE7C/qrPms7xFSx27XvOPe94OOYlKwR/cPsP3eILnwg8whSyDzNDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855106; c=relaxed/simple;
	bh=KlMYHECqweEdo7jjl2qFycRmDzQKOKkDJ0JCh9RkIpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oo0kOS3PNNFS1f3PgXeKTCK3fXEBM0PVu3hBHqLTgn0C7bDUjtoqJGbwF4ObQuRophkO+C2R2QLtNvRc/EG7jPrpqennOgG7wkLRg4RHLNNF1Pq0+4EYWlIazBYsk4mjpYEV9YqQBnGyoSYv48HGHT18/RanyCoq85MPPRkmQVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLFe0gzD; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTQOdNKxO2U8LTbgdvHx7VVsCTsB3feeedJdT+qNaPmRAUoCYmKwPbH1SbOyvi31u1/sDOlr8fELO96u1pKU3WFWZoPnPiOc3zxJp5m46n22kc2FMZgzP0M3Xfef8THNIIDxzsZVKBXsuAZddLYTicRAKjgl2aNn1/MOor14/L1Jhp8pkQC/42vURi5e73S/kb6G8kFxDhNYnJj9LRcauVDmH9lO6ZY80JCqTQsRnf4BlnMOUIQBCzH5VQWfIG9CMhSIbBPC0EMQewYDXY9POZ+dT4jqAjoyhDaMr2vYd/yCKrukjP5rw2HvrIszn07csUU1EjKsCf3UURHPf+EZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dly4zKMNk1TyAIA4i1RWXK4P3BqkCw6XTHoaKE0qXBQ=;
 b=KcHArth5I0v8GGwv9nsJ2uvQmcpODNPvjG3pSr3QSdDEqRBq/f6QsrcoTcHpuj7W4lknwXxO1mZwGDEdhFXumh5karqCmfZEWWaZkFcyGADkpanPpBJikk1tOuGWkWnqR+bZfR8TDzacRc6U7XUTVD+W6llUttxpeuDtatTstKSU+OcgjkpwjAoIkEstOnUaIxEVBcTDK47sZXeIQBagGPUXyPIGKkG1FedgUXZiLNqX6smMzv4KcDVUzTAggtVd1lHMS6gcGzHxCIbKKWe24myoiqdAfZB0Wth7SymMbF2q9j459PqfaosMiPNxQQqVo1nxQ5azpCdBUGbQG5xbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dly4zKMNk1TyAIA4i1RWXK4P3BqkCw6XTHoaKE0qXBQ=;
 b=eLFe0gzDA2zyZOu5y1W8hx5DrEIoPUB2uYi3gR9OwO7KCsqOIV6khcw3Y8YPMPv5dIX/XesKVnyaQtSCw+n+nr7PqMywGVR/8HjiTL8a60OMPKFe9AMqC2yi5S4BwXanmwszGf94V6TNfwKoEGYJ+emhxz98Ywlss1ErnsyL6os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:58:20 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:58:20 +0000
Message-ID: <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
Date: Tue, 11 Nov 2025 17:58:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
 laurent.pinchart+renesas@ideasonboard.com, bryan.odonoghue@linaro.org,
 sakari.ailus@linux.intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com, Dominic.Antony@amd.com,
 mario.limonciello@amd.com, richard.gong@amd.com, anson.tsao@amd.com
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box> <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com> <aRL8ZPwXSeKD4Qmn@sultan-box>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <aRL8ZPwXSeKD4Qmn@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:d10:31::6) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e4306-f09c-4db9-fd78-08de2108d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWdvVjNYbzZzR3g5cFlGM2FQWFQrZDVZMDJGQzRnMTJRTStFRFN6V2JpMEw3?=
 =?utf-8?B?aVRXamdWaHQydGMwVTJJVVRIcC93TkdFNE51WnR0OHhib01QNWEzbW9ZUldF?=
 =?utf-8?B?Wk5WbFdVQzAwMThTa3VJZFBJTnB1UTlhOUlBR1ZWcEJqS3AwMWtRbFVxc0hx?=
 =?utf-8?B?dCtzZTdUVkJHOUtaaGZBcmo4b3V1OUhNTUprVDFqU2xPSEExUUVOdEZLN2ly?=
 =?utf-8?B?ZTNYcjNiN2FxamdLZ0gvOHJPQms0bGhqTFNLaXdqODZHNE5VbzBlTDQwcVd5?=
 =?utf-8?B?SElQM2VEdWgxTkZFNzc4ZmpDdmxyUjBTck9vOWtKc0hPUHpuSzRSS1BDVXlF?=
 =?utf-8?B?MTdZam45QWZURi9jOGh3ZjRqcFlFdmRNYWJGd0tIckJ3WjQ0OUUxMWVzbWFE?=
 =?utf-8?B?Y1ljRlhjaU55M1dxdy96OVp4ZFhMWkkxNkxINVBDa2F6b1QzNVlFc0E5OGJ6?=
 =?utf-8?B?VHlrQngvMXIwaTc5R0Z0aWdxa21UbjhZMGFiemdoUVNPT1hEaDh5bzJBOW9W?=
 =?utf-8?B?UHZDQVE1VW9JeXV0bUNLbFJ3bW5GclVpb3ZleEFFWEtjZzAzV1ZnUXBtNVp2?=
 =?utf-8?B?UjB3eHJhbGh5NGNMMlVJQzdNeng5dGRpRm1Cb1lhTTNLUFUwa3BSL3lLcTB0?=
 =?utf-8?B?WFVLMEVMMXBsOERKaUtqVW9zamh0QWRtNVNvTFR5K1ZvOVFDdnhOVlhVeklU?=
 =?utf-8?B?OWFJVTJTeVlxRk13MEovRm52Y3U0U2FqZkFxLy9JMXV1bzR2K0pETGNYeGhw?=
 =?utf-8?B?bzU0TnFkT3g0UzEvZldOMlE0TWFlWHZWS1VwbjloS2RKejlDcHFUcmdiWXNl?=
 =?utf-8?B?MytQUDgrQXo1bE8zdHF3WnNJbE9Jb0hTdUlIVk5TTUx0aXJZa1dYT3p2U2Za?=
 =?utf-8?B?WVA1SS9LbkxGaDNQMVk3enUwM1l4NjJNeWhEQ0pTRVdETloyV2E2cUFXVEJ2?=
 =?utf-8?B?Y2JNTUtGNUdZWms3ejNRUks3UElxSllnc2FzMUY1VTVkdXlKMmdkR2dWL2py?=
 =?utf-8?B?YnIyWU9EeE9XVzNzaTdJL01TQ2Rad0xwWFM3QXlSM0dKRVYzalJpZzNVemZE?=
 =?utf-8?B?cGpseEVWR3cydW5ma01YR3hXZmxvc1BsQVhLVUQwVE5qUllCMHp4QmJDbmx4?=
 =?utf-8?B?VG56OElZVXJlL3BnN3p0dGdSRWdxQU9TRDZ0eGJjWEhEVExJc2R2MzNZQXdq?=
 =?utf-8?B?bVAyNnNNYzhueXZkM3Z2VVRlK2JaOVByZUpoZG1ESE9vSWtXTEZSeDhkYmww?=
 =?utf-8?B?YkpkS2plb29WSUs0Z3Q2d0tsL2UvNmU5MXhZRTJiV3pZN0k0K0dyTjVQeUxj?=
 =?utf-8?B?R2MzRTBUZTFtL0NNa3RNaGo2ckNMVGZXZldpelEzaGNsWlpMVysyenR3MVBs?=
 =?utf-8?B?Wm1ib3RtYmtEd2FKSys4R2trd0VkOUUyWHhucTg3enloczM5RXdXc1lZMWQ3?=
 =?utf-8?B?ZnNVSFNJS0JJdGFSdG9xRUNRMXd6amZHOCswdU9ObjI1cnl0VDljUnk1U0dp?=
 =?utf-8?B?c3ZoMXlYbGpTcnVsUTN6anEwaXpJaEROTjFIR3NmbExPVTVGdHVvSDlPWndm?=
 =?utf-8?B?K3hTRklPMWRVWGdKOXZhWDhvODJ1L1hPZEozeGEvTkJxS2hJSGVzRndKcm4r?=
 =?utf-8?B?Y2JRdUJQUVVOOG44Ymc0MWpYVExNRXRQZkxudE56NURRTmlHZ3FmTlYrUi9W?=
 =?utf-8?B?YlpSU3c2dHBLVUJGRThQdytYcU9HVCswTHFIRElPNkIxakZKeVFuUFEwQlpk?=
 =?utf-8?B?a0hTQld6dDVwaWVtZGRYVEwyU2Z1a3AxU2IvTzIydkU3V3FoM2hDWnVwejR4?=
 =?utf-8?B?b0pvTXVzRjI5M3BMRVVwWFkvMy9NWFJxRVArVjF5UkprT29sYkljSkd0TTV3?=
 =?utf-8?B?eGIvdGVyQnpleGtHY3lzRXo1dWl4S2xEdHIyU0NTRlVJcXhXSXFrU3VwZitI?=
 =?utf-8?Q?oniQI3S8fynJizzYOlSxH9r8NyeU4uln?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJlOGJ4L0FLelk1UHhLZndWblF6UTFoTWRCMVVVNEZQeVYrOVAxc1FISFVR?=
 =?utf-8?B?TklQTU1TMGRNU081WXRxTzQ0ZS9ianUwT3ZXMFJLMUFhdWJReVZwWngxWEYv?=
 =?utf-8?B?Z3d6bmRlU01TQjYzQ0JRZ3JYQnpVRW13WWY1WDVHekkwQ3IyN2hDOXFwazVv?=
 =?utf-8?B?ZmdjMHRiN05qV3k0cVlCdnZlS3VOSkQxcnNKQWtxUCt0eTBaZDFjWm9Fa3hM?=
 =?utf-8?B?bjQ2dDQ1ZWVoRmI3RkdlTmhiMjZZN0hwTndxSHRnMWxrV3IxWURZL3VYV1Nn?=
 =?utf-8?B?andhSnJScGR5aTFFU0VjUkJVVnV3clMzOGVlNi9JV3Nxa1E0dGl6SmVIaVFt?=
 =?utf-8?B?TXEycDVrNnpURDJubDlOOUJIRFJDVzhwM1R6YWVpdGVQdDRudGV3OSsvOEwr?=
 =?utf-8?B?eUhkVitqTHZLZkZyc1BUUjUvRit1YXNhbTNFUG5JRDJXMklmTmVPTXNlTWtZ?=
 =?utf-8?B?aXk2YmhnVUdaY0dzRGtjSVBUNzFBMjlLVVJYSXhsRkxNTDYvMUJkVlErSVFW?=
 =?utf-8?B?YTNYTDFXVEJTbTdQR29oZGEraUJQS3pydG9sMXFXL1BGVGVibzkvYk56eGVz?=
 =?utf-8?B?dW1rZERNL1ZoK2syeEl0bGFnTXN3cmFNZDB0Y3NYc2dPK2MwMUc4cWZOaWI2?=
 =?utf-8?B?RTE3Y2JqYi83bjNTT3F0ZjVBTVZHR053UVJ2aFFWbFpMTXQrTFc5TE93QTkw?=
 =?utf-8?B?WWFYRmxsajRMcWQ0L0gxeTN2Mk90NE5TNTRUNUFDT085Vm55Z2RTUkFPQ3hP?=
 =?utf-8?B?dFFyb2o4NEJuY2pQTUhKWVAyRGNKRVRrakV2NDZHUEJoQit6alp1SVVURk9z?=
 =?utf-8?B?Vks2TjQzSFc0ZXBjaGt1RW5WcVBhMzBPM2tNZis5RWU0eHRJTEpZYnNHaDJM?=
 =?utf-8?B?TTBBSUU1TGUrd01wMzhHeG1OcEpuUU5Tai9paFg5dEROdkRXVmVSaFhhWnFM?=
 =?utf-8?B?L0FrNDNISkI5Q0dIYmVORlllb29yUkk3T3BJZTVEcEljQ09lWVJ6VTB5ZERI?=
 =?utf-8?B?dURGTUJEM2p1N3JEdk1KTCtHNDBDb0VmYXh2aHoySEJkekNteVhId2NSZEcw?=
 =?utf-8?B?YjQrMG83amxjTUtSQVAvTEF0L3htMDI0RVE5Y1ZISXMveFZEdFI0OWtqVWN1?=
 =?utf-8?B?b05uQnBLNjVXeXFHdE5GQXJYSjd4VEkwM21MRHd4WTI0OXJZL0Y2U2JxQ2Qw?=
 =?utf-8?B?empFZmMrWHJ0U0Z0bVlwUG9lZVg5Y1I0UEtsRW5IT1ZYMHRvSVRLM2ZNZEts?=
 =?utf-8?B?Qmd5ZUVSVTU4Mk5NZGs0VmhRMGdGT29Lc1dsUnB5YXM5cTJaSjI2U2E4cUsw?=
 =?utf-8?B?Z2d0SERUZlFvL2FOa0phN3NHRzcvT1JYOHd5YjY0WXNFOUJScnkyVk1uV1NE?=
 =?utf-8?B?Y3hhd0JoWlJlT1ViR2d3eFZ0NXQyMXZ5WTkrUmRrdW1Fa3kvcEhBZk9razlr?=
 =?utf-8?B?cHJOQ3pPSWxhWm5RbTZFYzNmdTZiVlVMcklRY2QzaFhVeG1Obit4YWptMVgx?=
 =?utf-8?B?SzZrOGNQYnVCZW90cTVRZUdLTFA4QTVqT1ZWekxzT0JmQm9HbHgvWks3MWls?=
 =?utf-8?B?bFJaSzhySHBVaEhvN1lYNkdCWWVLTjVnejFpVHRxQ0srcitMNlFTWTB0Zklp?=
 =?utf-8?B?S0QwMng2RHZnQUF2RktYN2t4c09wNU9OSU44NzlGdVVZL0xTUkZwelYrQkNT?=
 =?utf-8?B?YU4vbFM3U0dacm4rRlRtM2FLajloMmJvNXkwWnI0NGsreHgrZ2RyMENoYUZO?=
 =?utf-8?B?RDlzMjRpenpXdW1ZODd5ZGdKempUVFdSbDlGQzVtZ2VpeGZGMXdrc0oyTjdZ?=
 =?utf-8?B?YVBXMHJndUFGV0l0dDQ3L0x5NlF6amVjQ2F2L09UdlUzL2RlSGRRd3RlNUFX?=
 =?utf-8?B?TGJSWEZXUEw1bHpkSG9LZEhxZG9GeGJVOTJ2MFdLN3pTNHNjaVA0S25pWU1J?=
 =?utf-8?B?WTU4NU1oR29LaFRSTy9jVHBEYUVtRnl4bVJKeG02dGhmd1EyVERnOU9BK1E2?=
 =?utf-8?B?OXRNNnhMUEJWSkZ4L3Zmb2tJbW00RjVRY0dUV3UwUkFQWm5iUjJ6MVZrSUhi?=
 =?utf-8?B?S051VS92Ly9XQ3ZrcEVIZVA3WVJSaEluclhxbUc2NzhlaklFUzBESHhGSTBB?=
 =?utf-8?Q?uMxQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e4306-f09c-4db9-fd78-08de2108d81d
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:58:20.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvsaVtE9mZig8pafPKr72Hi2f3kIN9nSV8u4+zmFipz6B0C8WRFUDs5v1zBLMPER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992


On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:

> On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
>> Thank you, Sultan, for your time, big effort, and constant support.
>> Apologies for my delayed reply for being occupied a little with other
>> matters.
>>
>> On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
>>> Hi Bin,
>>>
>>> On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
>>>> Hi Bin,
>>>>
>>>> To expedite review, I've attached a patch containing a bunch of fixes I've made
>>>> on top of v5. Most of my changes should be self-explanatory; feel free to ask
>>>> further about specific changes if you have any questions.
>>>>
>>>> I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
>>>> I should send what I've got so far.
>>>>
>>>> FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
>>>> protecting the list_del() anymore. I also checked the compiler output when using
>>>> guard() versus scoped_guard() in that function and there is no difference:
>>>>
>>>>     sha1sum:
>>>>     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
>>>>     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
>>>>
>>>> So guard() should be used there again, which I've done in my patch.
>>>>
>>>> I also have a few questions:
>>>>
>>>> 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
>>>>      faster to use that than using disable_irq_nosync() to disable the IRQ from
>>>>      the CPU's side.
>>>>
>>>> 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
>>>>      beforehand to mask all pending interrupts from the ISP so that there isn't a
>>>>      bunch of stale interrupts firing as soon the IRQ is re-enabled?
>>>>
>>>> 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
>>>>      when the ISP posts a new response _after_ the kthread determines there are no
>>>>      more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
>>>>
>>>> 4. Why are some lines much longer than before? It seems inconsistent that now
>>>>      there is a mix of several lines wrapped to 80 cols and many lines going
>>>>      beyond 80 cols. And there are multiple places where code is wrapped before
>>>>      reaching 80 cols even with lots of room left, specifically for cases where it
>>>>      wouldn't hurt readability to put more characters onto each line.
>>>
>>> I've attached a new, complete patch of changes to apply on top of v5. You may
>>> ignore the incomplete patch from my previous email and use the new one instead.
>>>
>>> I made many changes and also answered questions 1-3 myself.
>>>
>>> Please apply this on top of v5 and let me know if you have any questions.
>>>
>>
>> Sure, will review, apply and test your patch accordingly. Your contribution
>> is greatly appreciated, will let you know if there is any question or
>> problem.
>>
>>> BTW, I noticed a strange regression in v5 even without any of my changes: every
>>> time you use cheese after using it one time, the video will freeze after 30-60
>>> seconds with this message printed to dmesg:
>>>     [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
>>>
>>> And the video never unfreezes. I haven't found the cause for the regression yet;
>>> can you try to reproduce it?
>>>
>>
>> Really weird, we don't see this issue either in dev or QA test. Is it 100%
>> reproducible and any other fail or err in the log?
> 
> Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> 
> Sometimes there is a stop stream error when I close cheese after it froze:
> 
>    [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
>    [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
>    [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> 
> When I revert to v4 I cannot reproduce it at all. It seems to be something in
> v4 -> v5 that is not fixed by any of my changes.
> 

Hi Sultan, could you please try following modifications on top of v5 to 
see if it helps?

diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h 
b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
index 39c2265121f9..d571b3873edb 100644
--- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
+++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
@@ -97,7 +97,7 @@

#define ADDR_SPACE_TYPE_GPU_VA          4

-#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
+#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)

/*
   * standard ISP mipicsi=>isp
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c 
b/drivers/media/platform/amd/isp4/isp4_subdev.c
index 248d10076ae8..acbc80aa709e 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct 
isp4_subdev *isp_subdev)
         return 0;
}

-static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
+static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, 
bool irq_enabled)
{
         struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
         unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
@@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct 
isp4_subdev *isp_subdev)
                 return 0;
         }

-       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
-               disable_irq(isp_subdev->irq[i]);
+       if (irq_enabled)
+               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
+                       disable_irq(isp_subdev->irq[i]);

         isp4sd_stop_resp_proc_threads(isp_subdev);
         dev_dbg(dev, "isp_subdev stop resp proc streads suc");
@@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev 
*isp_subdev)

         return 0;
err_unlock_and_close:
-       isp4sd_pwroff_and_deinit(isp_subdev);
+       isp4sd_pwroff_and_deinit(isp_subdev, false);
         return -EINVAL;
}

@@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, 
int on)
         if (on)
                 return isp4sd_pwron_and_init(isp_subdev);
         else
-               return isp4sd_pwroff_and_deinit(isp_subdev);
+               return isp4sd_pwroff_and_deinit(isp_subdev, true);
}

static const struct v4l2_subdev_core_ops isp4sd_core_ops = {


On the other hand, please also add the patch in amdgpu which sets *bo to 
NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.

> I will try to identify the cause this week.
> 
> Sultan

-- 
Regards,
Bin


