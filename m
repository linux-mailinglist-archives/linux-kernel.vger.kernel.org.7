Return-Path: <linux-kernel+bounces-773525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7718AB2A128
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6587C7AC136
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43393310640;
	Mon, 18 Aug 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hMAgsbxB"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012017.outbound.protection.outlook.com [40.107.75.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F730DEA8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519087; cv=fail; b=FqmB4+FoBVyz30vCar14dXDOL5xJaOMYAvD4xCTt7Mteiau+bNX28yRYD7wmMM36h3TIjkTjL4aLgFLeHXRHJA0rWdnm9XuFcl/V24bK6wVfFcVTXX+8JDwIm3bbfk9SSeFeHibN2rkCLGMQVUwL++Iz1GwLfosRdYRDQVCjyL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519087; c=relaxed/simple;
	bh=dB7U6ryjB0CtqqILepMKhdfh/oix3kB5dQY6zntD+aE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DmjFotsCUDEn/aXErUwms2oklK1kjOKwprpShmDto7uUr+umBG39ifCf3MidHZicGMSGgHfDWngRpZuQTklXVOSD6WQdJG/GxkgfSD6UTrG5pmYeYAqpePE45naZHFwfdRjJjos12nebpaAkmPxp0QYfc08BNuLmEZokzpSrzTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hMAgsbxB; arc=fail smtp.client-ip=40.107.75.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmSZQjQBDFZNqkdH5sh6wJhRc4IYl23uL9W7liOznY5gLZxnzAL6dEttaeBiHa7Fi4zPpwq5XYZrztbZZA+LaTVd9so+bn1QdZTqYGEycKFmhCQeDtTzZ3W3iR6rqttqRB5YuaYmtPUjaIV0hku1CCc+7zksca7hAEzCyafP8Ea4cbUKPxKolQWSQsAgFbHbyTDeBQbJ/zRJpdByTYdkV3fgeJ1Nkc/WmFK24OdlXv9JY1e+OrtcmmNtgJtlHVDnRVm/TCmMXc3Lab3xa34j4Tn9r8CUDgYKypTriGHWYMGaABsrDtGlsAH3Hl9kvQj6oybj22T3V/8jv0mAkI9JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VNrwW7DT2SP1zJGCVEYGEXEjWRcN6HoVY9pwUZ/oBI=;
 b=da05pBe4SwAOofVk11WmMvX099gRh7B+RrYkr5RTuI2uK2Adk0/77Ue3hgu7GTwRvMUm1Wmc0yIBvUyojU0+Pad+ImEw4UhJTn7GuYBbmqRm1cPPwc3r3uyk2AxIXMh7lz4gp/yJbTxpDvZvbXRweN/Wu2kGPAJxOl9WkKBdrOgnslOGy8nTPP8k7uvfY42NoPZKpw8GFvH9AOzxRXqDccGBxwwYcjuIDRRilZTZyVnb2PzFv2St4whWZvPxX/5qhwt48XkKCO+DDADxxLroq8Wd7q3A+3nIZXb7cN0sccqwiO26rILYKZQToxHj+aPpoChE6Fg8rEN/qQvgXZJ+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VNrwW7DT2SP1zJGCVEYGEXEjWRcN6HoVY9pwUZ/oBI=;
 b=hMAgsbxBJ0FVs1mWObY52J8gdDILSO2ERoxG2WWx5G31lpQ9HRu6laINFOUHy7IME8QfMD3CJ6pog5rvXyuiUuj5JIJBacHSmQEWZJbaqo9TrDIlLWAcHi8De61tvKwiFbjCbupq6mi/12RGa10koD8hiPKRip0ATAI/1to6pK4TAq5l6s+9W1cZOVFFMn4l2RONHdfRwzC2L1xYYw9gJODbvME2iCTFV8bEAYm5SXSY6c9/T+gfdnMH6POx5bXHxDZcMebzPPyH1P98TJvpAlKbmUqWFJn0aM49J9jpiessT7JJ/tRQ5eW+vvCvYbcff/ST++Gx/JNiEAb/GrzOrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6677.apcprd06.prod.outlook.com (2603:1096:990:31::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 12:11:21 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 12:11:21 +0000
Message-ID: <5d877bc4-f275-412f-a97f-47847dcad715@vivo.com>
Date: Mon, 18 Aug 2025 20:11:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: bd718x7: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250817142327.174531-1-rongqianfeng@vivo.com>
 <eb3555e9-afc1-4f0f-969c-fdb66231d0b8@gmail.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <eb3555e9-afc1-4f0f-969c-fdb66231d0b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dd23cb-d4c5-4ed0-aed1-08ddde5057db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWFwbWMzR3pmMFF5b1czRG9BcysvaTM4eUs0aTU1ZWNHS2hxTUsyVXZXVTh4?=
 =?utf-8?B?d29DOVFOMjAwR1pWMGNjKzJwV01vQTZvSXgyd2ZlbmdyZjdOMlRxNTdNbkFt?=
 =?utf-8?B?OTk3QzFOSDJERUp4RG1CTDhtSHFWRy8xSVk1VTFDUUd1VGs3N2FiVzA2Mnhm?=
 =?utf-8?B?Q3EydW1obDhFVmt6bHVEdkpPYkRlNURQdzNOcHFoc3k4ZUh3NkFFZW1qZlJu?=
 =?utf-8?B?UFJYVDRXcy9EbFJoQUdoK3pCMGdSdmFiakxWaC9FVHNzTW85ZHdvUzZoem9G?=
 =?utf-8?B?a1NLaWxPRG5razA2amhadkRlRHFaY005d3lLOVJubk81b2lYMTk4R0t4cCtl?=
 =?utf-8?B?VVRZNU9rWXB2cWhhT1JPQSttbmpYbEJSSDNxYjFQT3Nrcjd5Q0ZaNU03SHhL?=
 =?utf-8?B?ZzN2OUVEdGVNRHJsVXRmc2J1VnJ6UzRqTk5aK3Y0Vng4QW95UXdvN2NZbUJY?=
 =?utf-8?B?TU0waU5lcnlmdzByTi9BQ0hZVWtqcGQ0SlRRaU5pMnA2aDNURnJhMllkTGwr?=
 =?utf-8?B?SEFhSXlOWTFvZDh2TGNEWStkUDN0VkJrdUN2ZVRnZGZDbHhXcXVYZGEvSVNO?=
 =?utf-8?B?Tmk3YkN5cWlYUXhxK0IrbjdTcGFYUDBwcHZ4TVpqVmNqbkVvR2NRSzFRYmZM?=
 =?utf-8?B?NHB5TmxCdVlXT1NlbEQyNjlVVWVPM2NsM2ZDRzhVQ0RqWkZrdWFQRHlweTZs?=
 =?utf-8?B?ZVBjZWlKakpLandROXh3blV2RzNqUjZndFJiMzNJQTE1S0RKRlY3Z2M0RUs0?=
 =?utf-8?B?NVJBT1FhY1p2cTNSMDE0SndHcUNTQ2hLYVpjWWc4SjRtVzdYRVpWdXlLV0VZ?=
 =?utf-8?B?ZDVwM3JTMGZXSXVlOWg1Z2t2YldGaGp5d2k5YjFOMTh4VEhSMWRCUzFLYzFq?=
 =?utf-8?B?UmtCM29uRC96cEljUEZoTjZ4UWFRMFVpemlhZmRwWDVDY1R6dmlsVzVpUmlq?=
 =?utf-8?B?OGRkS09jall3bm1SQitHS1NZT1loSVF2YmRwZVVLZGlMUzVmM3ZSaVhUQnds?=
 =?utf-8?B?Sk51aUkrUWtac3BZQ0hvbkozWVhiRjd4aGsyZ0xXaHlXY3FuYkhkWnE5TTBj?=
 =?utf-8?B?YnA3ci9EekozTlBZd0Z5cDQrS2xyb080V0NwcUhHUjBlT2UwbXgxbSs4eXRT?=
 =?utf-8?B?QkdrNVYrYy91dHJSVmc5dTVHRitGNnYzbm9XQzBCME9CTStpWHBSOWNLWUJ0?=
 =?utf-8?B?RXhqNDBuaWJ2SXR0S29mdFUyOVBWNGdhQXRJWndQSG9jZ2x0WkhTN3dJZThP?=
 =?utf-8?B?QVVoL2VneUtrWXUxMmNhMUZmZU81SytGYmorbEhNUmNPM2gyU0ZLNXh1V2Yx?=
 =?utf-8?B?T3pFNWJYTXhhTGVyREFiSmg0TjZnYVJYRWFjK1cxZkQvbi9UZGlyejJCZStS?=
 =?utf-8?B?N0pIWjY3a0xFcjJEMG9hNWtpVWpMQkllT2Q5Mys3Qm1hUU9tVEdTemtuUUJR?=
 =?utf-8?B?U0svRFU1V3lzVloraU45THdGMDJQUzlmNk5qTzZYeldwZnZjRHZLUGVUZ291?=
 =?utf-8?B?ZXZPekhuMUxkSUdWeGRRZ2plaG5PYmYyUzdoQU9vanhsQlJyQ051Mzl5TE1w?=
 =?utf-8?B?d2tVb2Vabncva3pXeGVpcnR1VDNWYU9OdUU1YlVYWkJOc2RKM3BLcUw5a3pn?=
 =?utf-8?B?SitRajN1ZHh1NDVpaHYzczlJUmZZaW1TMS80UDRmYzRWaEdOYzdpZWxKcm9t?=
 =?utf-8?B?cTJuWHA2NGwrb0JQR2UvRnpmZlM2WDlIZ0RrR1lHYWRMdU5iQkFXRVpoRytx?=
 =?utf-8?B?N051QXQvcEVDQ01DOHNzOXNndXFiWGFyNWh1YVl3RVlSQWhSTm5MbnZtSzAy?=
 =?utf-8?B?KzVtMlN0bndSRzBYUnJCWXliOHdDeDU1M2VUdlg0RkpBOWcrektJQlpnWXFO?=
 =?utf-8?B?UFhSbTBacktzdjdEZ2ZoZk9FUjJhelJLOHFEVVFSb2pTeVpMRXBPcHROSXZl?=
 =?utf-8?Q?hgIREmwOzHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azcwN3YyTjN6eUt5bUo0emdOY0RkTVloclhyOUt6eGhVRXJXUDVYWFlSWUJ1?=
 =?utf-8?B?c2hQbVNFb2NyK3laMjIwaEFQNHMyWFVJdE82ZmNPOUxtTXBPdGIyNmo0Rlor?=
 =?utf-8?B?RWoxOThSQ1NpbHRCQXlCdHl6eEFRVEI1M0RpSWp6T1I3SjZIUzcrR3BYbHZD?=
 =?utf-8?B?UFFJblRvRU1RQnl6eGRmYmNsb0QrbkFvZk5LVkIxUjNDcEhDRTFjdmU0SDBs?=
 =?utf-8?B?MUpkb0Jac0t3VDgyWlZtZENhcVBNL1J4Mi9aOUJ0d3dKTFFqenBySlZQanhW?=
 =?utf-8?B?Z3k4cStsSFo2V0E5YmRBVGtFRnFNeDlPWkJoQVpmOUM3WVVWcG5XN1VLQnlV?=
 =?utf-8?B?dml5bGpGMS9WT0NiRjBseXdQRFJaKytDb1BsQWpxTFVLRHRzR1FkcDVudVpN?=
 =?utf-8?B?RWJ3Vy9WdHVyS0R4bGVydXdnRlZCM0l2TS8xeVBCSVNlT25qWmlqd0ZQMVZZ?=
 =?utf-8?B?SXA0VUlMYkRoYjdLYlhSV0FnY1F0alZqT2lHejdPQkhRT013L2hkVkhrMVh5?=
 =?utf-8?B?RjVaZ3Vic0o1bktqYzJwc1RRYUZmMkZNSGVrS0poNlJSbGF2ai9vSWJ0RVJ2?=
 =?utf-8?B?M0dTQStKY0VESnlHTkgyb1V5dTI0UG5rMURHalVOZkRPNVI5djZCWXJ2aFlE?=
 =?utf-8?B?ZlI4ZUlzTjFBMUYwZktod0hCdjJ3WUoyT0VMd1JoSkhDVXV3Y2Y4N0E1SEhY?=
 =?utf-8?B?MFVTT0Y1WDhuTmJMRU9QWTFGQUt4OEVlSUVrNWRxQkJESmFEN1ZUT3gzbFFR?=
 =?utf-8?B?aG1oUlh0eUsyeG9DeERSQWliRkxRYWZ1NzEvU2Q0L2Q4RWc0UzZSdXkzNlY0?=
 =?utf-8?B?d0JEdWdaSkJYMnNEaFV4UzBPdUltNkdURXArM0VyOHRLM3Z5U2l5bXBvbTRz?=
 =?utf-8?B?UVRtVzZvUEp3Ly9aZ0taQzI1Ym5yLzFkVXMzM05waTZTYTRFS3NTVHBPQUVN?=
 =?utf-8?B?V2V6c0hGdmZQcUNTVXNTTWo1Z2ZJUk5Wa3VNSjB5Q05kMmcrMUQ4SzRmQzUr?=
 =?utf-8?B?TXhTRW5rZDhaUGwwcGdKVk51S2xJcUFneDB6QXlFYzNWT2s4WTg1dStzRWxh?=
 =?utf-8?B?aloxTXZwd1ROd3c0SVRoY09ZTDVNcHkvK2w5a2Jkalh1eUYvQmZIeld2aGpF?=
 =?utf-8?B?bDhOc3k0VjBQd3hNY1UxNGhBTGNrVi9nR2dnQnhyelRZbWNpb3RnSlVqeld2?=
 =?utf-8?B?YnVjT1J0Q1NHM2Z2UHIwTmxqVE9GNVlrSm1aOU0vbVJlck56aG1vaDdoTVRa?=
 =?utf-8?B?TzQwRUI3S0txNVdpMGlZUDdCNktQWG5VNHNWcnlUZFdUM2RRYlp3UnRjc21E?=
 =?utf-8?B?OTVETTQ2ZGtJdERkVUFZOEozNnlLTXBiaGo4VzUwWTVRN3Bta0VGb1Y0cUM0?=
 =?utf-8?B?Y0NZWElBa3F2ZVBSczJsMlA4UFNkaUhwaWowM2ppNytmQWFqMUtPQW50RkpZ?=
 =?utf-8?B?MmZEM3JDM3JNQ3lZcjkyRmNDV2F0WEJFK3ZLK0dTb1FXMkdhRjFpbndUWnR4?=
 =?utf-8?B?T1FKL1lKaGhpRnY0YzNUZHhxUVlhZHFzalJJNmIxUno1MFRZdXZYNGtNUkE3?=
 =?utf-8?B?V2EvaGVRSFl2a3cvdlF3SkkrV1Vya1FUeEZiQlZpaitKYTR2NE9xM2hjdmFH?=
 =?utf-8?B?NURPZ0tPYzhmQ3JBZmgxMWl6bitxQUpraUdNd2dPRVd1aWNaRGppQ0M5UzhJ?=
 =?utf-8?B?SVpObEV4MFkxc0Z0RS8yMTk5M3JVOWJIaksrRVlQMVBPWXA1TS91VWx2WkFI?=
 =?utf-8?B?WHQ2OFRDb2pGUXNQZFQ1QStVeUtGQ2JLT0owL1VHOHdiWGpMSnlnNlI4QUdH?=
 =?utf-8?B?OThmcDMvUnlNUXRSSDdSYnR0U3lUU0ZObk9BK0ZoSWhpUmR1MWIvcnhVcG9w?=
 =?utf-8?B?aHBmcnNwVjdMVGJscXhaTURwMVJvZWpvdS9ldlIwNXFYQy9wSFBxcVFyeWFt?=
 =?utf-8?B?NFNWUkozUzlhbVc0dzJwd3hkMXNFMFpyeGpmVHF6SjEzT3pVcHZzM2ordjVl?=
 =?utf-8?B?SkcyelovS1QzVmVVaHc3OWFWQmhob21TUkM1SmV5ZXhyQjMyQVovNHp0N1Bk?=
 =?utf-8?B?ZmZPNWplMkVrRGZ2OTduWis1SUoxc0NpZGFUcEtKWG1jTnkzTnNxeTZ4N2tr?=
 =?utf-8?Q?b3chu9GIc9Va1RoSIUaWPKvaj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dd23cb-d4c5-4ed0-aed1-08ddde5057db
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:11:21.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa0pxxi1maLk2AJA9NGySeunv+/Z8HXf2x1YOsSSDlA7iGfv8UX5+3XyAvXgZhdbRO/TZxDT75WRQUiK4XToNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6677


在 2025/8/18 13:30, Matti Vaittinen 写道:
> On 17/08/2025 17:23, Qianfeng Rong wrote:
>> Replace calls of 'devm_kzalloc(dev, count * sizeof([type]), flags)'
>> with 'devm_kcalloc(dev, count, sizeof([type]), flags)' in
>> setup_feedback_loop() for safer memory allocation with built-in
>> overflow protection.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/regulator/bd718x7-regulator.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/bd718x7-regulator.c 
>> b/drivers/regulator/bd718x7-regulator.c
>> index e803cc59d68a..022d98f3c32a 100644
>> --- a/drivers/regulator/bd718x7-regulator.c
>> +++ b/drivers/regulator/bd718x7-regulator.c
>> @@ -1598,7 +1598,7 @@ static int setup_feedback_loop(struct device 
>> *dev, struct device_node *np,
>>           if (desc->n_linear_ranges && desc->linear_ranges) {
>>               struct linear_range *new;
>>   -            new = devm_kzalloc(dev, desc->n_linear_ranges *
>> +            new = devm_kcalloc(dev, desc->n_linear_ranges,
>>                          sizeof(struct linear_range),
>>                          GFP_KERNEL);
>>               if (!new)
>
> Thanks Qianfeng.
>
> I don't think this is particularly hazardous, because the 
> n_linear_ranges is known to be small. (It's populated in this same 
> file, with a size of pre-defined array). Still, this seems like a 
> valid change to me. I know some would say we should use sizeof(*new), 
> but I kind of like the sizeof(struct linear_range).


Thanks for taking the time to explain!

I also prefer sizeof(struct linear_range) to sizeof(*new) because it is 
more readable.  :)

>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> Yours,
>     -- Matti
Best regards,
Qianfeng

