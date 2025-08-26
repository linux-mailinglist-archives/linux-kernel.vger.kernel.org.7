Return-Path: <linux-kernel+bounces-786184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39594B35641
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19395188DD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A326C3A4;
	Tue, 26 Aug 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="AiSolYw+"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022097.outbound.protection.outlook.com [40.107.75.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF71DFF0;
	Tue, 26 Aug 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195221; cv=fail; b=PYN2oV2Zkl7MA4JCuqT4T7MibbXtNc+dsp2vDGsJzcyieCHPXQGAfe4MWV01Nq2EHcKpjPV7Uk9ik88Jt7GAHbk0MjuvaG8NpVTqr0NcV61JwUTDZK/5jwufbzeq6Fe/Cbq1hHdfq2U8GhT/QRvLB5jPBOdJYxEJpYCgdLd1tbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195221; c=relaxed/simple;
	bh=HTE7411wECb7nopxaGpMADJMADMGXf/wuRj3TubgQC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=krU27a2JXJHKBHky7CxMEeeI8lPqm4BwHvf14EbNJnx6pNeRauecqjZNrjoL8bA79xzgdsR1FiS1zEXaRxCVkrWsjc4IeVkh4QY2sGwKjeC56HHKwTBLEFPGEy4ojF0igG9yCi4aNt7KPFoIy2KR7odtVFZIv/ChSo3k8N+MisA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=AiSolYw+; arc=fail smtp.client-ip=40.107.75.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keReTJ1LtuPqUZOOB85hAyq1pgkFNFLOJjd8D03H944I9e6Bsrc5VwU/I5Xhnt6vR/xUwQ3kJ4C6C9BW63vbFSdZOGfaSGSl0Nif78O0e9tXO4ZNDTLZXQWxHyBhlNKwKO8qlr+CIM/C9BjbJQS+S5JZVVir1zWpbCsElf/rlBcDOzEu5+pc/Y5Mi7tf1aPsshtyvl9/+JEjVFI5FIpNN/zqKWjouSGcXqTO9gNdo7+0X5DTZwDFD5dML5AXJztn8xfgQ3xNTYrvtaMFheKX5O1BnqIuTqMTkWZzoMGWmMCWk0Ti5JTIrOVwQMGpxxyWaogxzseTgC04LBiYEtiLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIp607oodqMekMqfHryfRM8HbCVOOcE+cw/TuEpL+I0=;
 b=B8iXC34on4qO/U45BZBr7GRS/5cVz4F56bDx3AbXhJR1oo29iNOkheaqp+RL8SmIlPwBv+55X6Q4nZxFDML1Nik9gpupgVu06dGr20XnrVzkDi7reCe/plc012dsa2lfTsxMELGK6Po1D1OiAgw0lQpx7U17sBH4T5idUHxPrEhK+t7QzmNCFLCGeQ1LI815Yl6s5UeWzD1biZVYNq48DEV7xiNfpO6FKEbLa2poShoOz4GzMJmmAEijm28vEruzdV2rTTEBSDTC8OsEuGNalXsNcEis/G5wlzzmlcbN3Oh/Kzaj0lYZUWAMDrVE0Vx0vHeRidk7HvI2sMGeaH+uMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIp607oodqMekMqfHryfRM8HbCVOOcE+cw/TuEpL+I0=;
 b=AiSolYw+yLSAmpT2yjYumBupa1oOy7M7n/5EPLrM8MK4L9Rx97i6BLjZ9cY3McXu7+IKaK6gzAIA4QdeDkkX3oiPZGOA3DQXXj8Bz/rfVRb4NmVrAxS6TbbyW+qtBLozs7uvGxnoTzc3HTlzXqwv6wuBqbrJCBA48FhfTdtEOwHs9lspyfO5Uwk6a9v77IePlDuIarfvIqKlnacl470TWetpmRR1BnR2jtgyN+e2MzVYnz7AX5iVWZzV6zOkBXFkhxPzUQQ+VqblwNPoUdE3Q8a87MmysyddtF6CVAhkRKpr6Ja6mDMPHOJWc021oDMfZZv2DXTUhb+2gn/xgxRLfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TY0PR03MB8300.apcprd03.prod.outlook.com (2603:1096:405:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:00:15 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 08:00:15 +0000
Message-ID: <c0e8cf9a-b5c7-4369-8b6a-c4f80a6bc398@amlogic.com>
Date: Tue, 26 Aug 2025 15:59:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: meson-g12a: fix bit range for fixed sys and hifi
 pll
To: Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250822002203.1979235-1-da@libre.computer>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250822002203.1979235-1-da@libre.computer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TY0PR03MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9825ce01-1f7d-410c-de32-08dde4769755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJ6cFBRN25rRkdxdmZ6aEY1N2hSSlhzMmQyRDhVaTkvRU1VeU5XVjFMS3hw?=
 =?utf-8?B?TFFOdGJ0L3FFczlHRktZMUFIbE9ZbDdPdFhiNGVwTGlHdnJCVXIwTXhyN3dY?=
 =?utf-8?B?SmE3bHR0S1poWmdkMG1KT3dGL0hIaDVEbW0xL1pUQVNpcVhlMXFvMUpmSTdK?=
 =?utf-8?B?YUwvcGNYdE9WWmVzNjBiM2hlWmNtTXRBMFRrNSs2WkVldG1FL2Q3bGRyN0JI?=
 =?utf-8?B?RnFjVXNaRThSU2tFVVk4SEhaajVOT2RRalJFb05sZ3UwdWtRWVVacXhmK1I2?=
 =?utf-8?B?dmNZU2VrTHg0QmdqbVZqalZoNnBMUDNUSFNUWGZRKzV1S2Nvc0liSVlENUxt?=
 =?utf-8?B?Z3ZSMzFtaWhObmo5UUlISktMQWpwTGNlYVV5UmZtcjhLcFJ3VmEyU2hsbHlV?=
 =?utf-8?B?d1dySlRqNDNNelMvcVRnRHJEblEwMEpIZHNLN1QwNGltc0Y4ZXR5cDQ5U1da?=
 =?utf-8?B?bXV4aG5vNjNjL21sbEdQbmZveGJtWEFqVHhaTU9BQllNT29QNUJmSmo4bDVj?=
 =?utf-8?B?NERSRGVkVFhYNXdBdTFscW82RnFWb3lxTHZKOXFVUnR3eWMzSHJSMkNSc3JK?=
 =?utf-8?B?R2U0Vi9MTDdPQytCTVNXMXM0bEtuN1FIVDVzOUJRd3BJb3NpKzg2T05oNUF2?=
 =?utf-8?B?dW01eVE0ek8vUmNSZTRHSFJicVRiVTMwYVV0TTcyb3FwbGNKSVlHbnhzVENj?=
 =?utf-8?B?RXFxR05hQUQrTnBuZjZSMXh6UERZaUwveHVpdDljVDF3K3dGK1FuOFBWSEJh?=
 =?utf-8?B?Z284ODdacW0zMSsyWjdzL3hWRFRsQU93Y3dIVk14VkVLYVlpNm1IYWE5N1Zu?=
 =?utf-8?B?eW1aMHMxQXJQdlVLSHFHMDBVcExJWGhBWG1sb1FUK3ZlRm56TGJTNksyTXlK?=
 =?utf-8?B?QUVKTmxCbUsyNm9ZYXlVL041RXNSbjdLdXlpclhHWk4vNjh0Z1l2Y2FMWUhT?=
 =?utf-8?B?ME9SMXJWeC8yWUozZENKN0xKUFZPVXJaQ2FWK0duVHBlcmc5dmRRT2hXZGpB?=
 =?utf-8?B?d3laN1hZLzlpVmFUNVRHZUVTcTZrbEJUbjBnZkRPQW13RUhlNW4rOVFYYnRX?=
 =?utf-8?B?VklibHRUNHpLd2xMYm5xVTZyU3NnRVhzM1kyeE5rczFPUnRFMVJCZnF1c2pB?=
 =?utf-8?B?c0FaenJLVUR4SGRzTkdvNEtEQUF5OU5xM3hVZFJIMFVkRkZ1TWhIOVMwcUxV?=
 =?utf-8?B?cDFtanZpQjk2OGZLemJ1bCttd2JvdEYxUEhVSFN5Zllyb29pRjZiWUZoUlUr?=
 =?utf-8?B?Ymg2TjVrSU1pS2RxcmEyQkI1MUF6K011OC9yWDJaM3VQYnFoTXJuaCs2L1Rl?=
 =?utf-8?B?QXpNK3VHZnhXclJlcmkyMjAva2lXM0J1Qjkyam05R1UxeWRTdGNUcXRobUh1?=
 =?utf-8?B?Y3RoTUhHdmQrNFFlRFFyRi81eE4xaTB5dXBDWTFuSmprVlVjTHdxZFpPSnZy?=
 =?utf-8?B?V3BLYTZHWXFsc0o5MGRVZVRudkt1RXZnQmxvTnlIRmh4a29LdDJNQW5jNEhV?=
 =?utf-8?B?OE94bjZUUElYZ0tJOUUwbU9hbGhxV1hwU0Fya3lLcW1QSkJDcTBPMEVDUElQ?=
 =?utf-8?B?azBMTlFLSE5kQXE4TVlFR0pzVGh6Vm83Rk9sbllaNGY3RTZaUHF3RWRTQUdX?=
 =?utf-8?B?M0VYRG5YWmI3UjNmcFNZcWIzT0N4dXdJK3NhUVFLdjBQSFl1cGl6QXVmRExY?=
 =?utf-8?B?V1BidVAyZDlOVmRpTVkzT3kyVjFHbG5HVlNSVDduTHlOR3BBdFppaVhnREFB?=
 =?utf-8?B?TzQ1QXF6RUQ4NnpJS2VxbVZqTU5ZSjlYTVhiWGswTHFRSXRZc291ZEh0WW9t?=
 =?utf-8?B?TUR3cjYwNDhsVzcwVlNHRk00cldwd2NqYkduZTBHOWg1eWVlRWl4VkFHTjhx?=
 =?utf-8?B?WDBtaEtLSS94Vlpwc2MzK0g0YU9iQ3BHdko3cHBRb0xaR2lGUVgrSkZPSVNZ?=
 =?utf-8?Q?i9T/3MJWbVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXV2dk5uOUdDVEZlc2J0RzFWejhLOXY1SWJpUmx3UURxYlBleFpaWFZTV2Zh?=
 =?utf-8?B?NXJoSlNsZ29ZT2ZqQm1PdjE5SUdYN0ZoRzRLTEZZVWRvUHMramt2QzUrWStq?=
 =?utf-8?B?SWkyZTNIWVJONWtjVVVQeUIyNnlzOW9wU3dLME0zdWhaK2VmbzMwL2R1NlNi?=
 =?utf-8?B?MENmWmV2bTNnbjVHUllreDZrb0pPb2prbUhDMkd4OFV3ZDZZNDI0a2UvdkZa?=
 =?utf-8?B?YTNZa01OYjBmM2FGU3B5dlZJbk1JaUhGU2NkUFpKSDd2SXFVZVhDNVJvZENr?=
 =?utf-8?B?Y2tQV0p4VHpueXZLYzNDSnR5eWVIVGFKWkFDcUhSaVdrd201c1pGL0swTG5F?=
 =?utf-8?B?RHhuM0pVTFdXNCszMzhQZEpxdGNTd0tiekdrUk50RWVNTjc5ZUxKdXVHaHBt?=
 =?utf-8?B?amNmeG56aVAyTTlxM1crcWVLM3I2ekNzZTZ4UzU1R0FBay9OU1hEWUFXQm5R?=
 =?utf-8?B?MVRMblB6ak5HRzd4YUtRVG1JMU9JZ01vVlNTRm12ekVrVGZDMTdDNERpbkR1?=
 =?utf-8?B?WGxjTHMzdDdpemdHQWI1T2UwWTcrdno0RFRad2NYQkNHNjRFZ2Ywd0l4cWQw?=
 =?utf-8?B?YUROUndMMC9XdTdGdzBPN3NvbFB1dUd2eEx6YlJvMlRLNEV1c3hrVk4vSVRx?=
 =?utf-8?B?TFlFejFSVTd1Z1k1ZDIvcVpyMHJ0cTJzaGZvU1RYNjdTWGNCVko2UWhPWVls?=
 =?utf-8?B?WWtJcFVRbjNBSElZTkRMYjFUeGdZME1yeGMvc2tSMm40bnBlRXNOL0VFQ2JJ?=
 =?utf-8?B?dGhraEN1MDFqTlBzRHdUakF0QVpSZ3NJVFFUMXBmcFpqRkpISG5zbjNGNUV1?=
 =?utf-8?B?bWVnQXBQVEdLZWZGK0NJc1djMHNDQnV1L3lIV2JtRmVTVWRkUnd0VUNZeU9h?=
 =?utf-8?B?cndxMUxYMHJpc2hZdk5BVnY4dDJFT2xuQXRlNHBjblRJVlloOFY2MjNpR3k2?=
 =?utf-8?B?dWVYUzgvdVlvWk9TWTd6Z3JObXhoUFpjYktRcnJ3ZXkwSEw5dHZYRVNSWWxr?=
 =?utf-8?B?VUpIdWxrbkJnUXRJNnl5WHRhd2Q3c08vRFY2RExwUkdvSGxrTDRhdVJGeU1R?=
 =?utf-8?B?alZXQVJkN3RudzI4cjhCZm9LL1orRStHNVZKdldDekR5QXg3eGVGR0lpOHhk?=
 =?utf-8?B?a0h6c3ZqdnlwRnBjVE80MWJIS2Zoc1hveTlpbUJkU1FxTHFuZEhHS0Z0ZEZN?=
 =?utf-8?B?TzJYa0JUVGdCMG1sUmljeEoxeEl4amN5OGJOc2pweUFPc3N6cFdZbnhKbGU1?=
 =?utf-8?B?L096T2RGSk0wMWlJNXNXWjF5TUR4NFZxbEtEMUF2TnZIeC9FSjNWeE1Jb2JR?=
 =?utf-8?B?OHhjNUZQcGhUV1l4WlY2SVdRZzUyRlN2M3JkYU5HMjVMeVJaQkpudGhRckU1?=
 =?utf-8?B?SXA0eXZkaWpPQTM5Sk15ekV5aUUxQWthR2Rla1lQa1NFMzZpeU83Y3lVRXIx?=
 =?utf-8?B?QytZK21MZEFYZ1dQZC9JbFZ0dUZnbW9qNHhjN0RLckpaRXZJVkNHVmNPOXA3?=
 =?utf-8?B?V2dEbjAzQWU0cjg3eEt1a2tUVVArUDRaSDNrbDJyYkZNc05SSEU1c0RNZ3I3?=
 =?utf-8?B?UzNuUGIzZ1NwelNQSUVLUThYMlgwN0dNcDZTS3NhbXIyWGxkZWtwTG85U2R4?=
 =?utf-8?B?M2IraDJ0RHRWVGNzL1hpZUdtak9BZHB0MExTMmxpNnp4dWI1MXViaUlOdjBj?=
 =?utf-8?B?d2J0L2ZGMkNPMEVRV0hxcURPSDRsTGh1ZmU4Z2xKbFNhYllISHJyemFwcmNC?=
 =?utf-8?B?aVVCL0JxUHJvSTdoT1ByNEprVDViQlMxWVVsK3FLYmp5L21yQTRXQlhlRXBz?=
 =?utf-8?B?MWh1VHNpREF4ZmJHZ3hSVmluaEU1Vi9rTVFYV1owajQxNFRiQjZpaHgvcDhL?=
 =?utf-8?B?VCtmTkh2d0lPcGtkUW1GK2JWd2t3dDhuUjhmZFZIYWp3Ykt0eFBkc29RTk9T?=
 =?utf-8?B?bDNPTTI0bVdzOWJvcW1zOG5TbU96UENwZ1FiNHZ3Z2o5WWhlZ1VHYUpJK0la?=
 =?utf-8?B?bGFUTlM0TlhyVkZYb0hibmVOUFcxZVMrQVBYZHdoWlo0dGhBeGhPajNJU0Ez?=
 =?utf-8?B?YlBZM1hZekV1bXN0MGhFMWxNaFh5cW5yaGdIelRsN2NkM2hHWm5tUFJPS0Fh?=
 =?utf-8?Q?7bEsRV9eeUa27lJrWecLFQRF3?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9825ce01-1f7d-410c-de32-08dde4769755
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:00:15.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr2+lHlaTsRLnTjucUkcbteNuC6fFEPvlyNN1WZfIjx/E7MgIcivbJxnZh2Xnyp2exR+XVW1ldh4POl/bEL/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8300

Hi Da:

     Thanks for your feedback. but this patch is wrong.


On 8/22/2025 8:22 AM, Da Xue wrote:
> [ EXTERNAL EMAIL ]
>
> The bit range 17:0 does not match the datasheet for A311D / S905D3.
> Change the bit range to 18:0 for FIX and HIFI PLLs to match datasheet.


The upper 2 bits (bit18, bit17) of the frac were deprecated long ago.
The actual effective bit field for frac is bit[16:0]. However, the
corresponding datasheet has not been updated. I will provide feedback
and update the datasheet accordingly.


>
> The frac field is missing for sys pll so add that as well.


PLLs with frac support are used in scenarios requiring a wide range
of output frequencies (e.g., audio/video applications).

Since sys_pll is dedicated to clocking the CPU and does not require
such frequency versatility, it does not support fractional frequency
multiplication.


>
> Patched:
>
> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
> 996999
> 500000
> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>   hifi_pll                      0    +/-1562Hz
>   sys_pll_div16                 0    +/-1562Hz
>   sys_pll_cpub_div16            0    +/-1562Hz
> + sudo cat /sys/kernel/debug/clk/clk_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>      hifi_pll_dco                     0       0        0        0
>         hifi_pll                      0       0        0        0
>      sys_pll_dco                      1       1        0        3999999985
>         sys_pll                       0       0        0        499999999
>            sys_pll_div16_en           0       0        0        499999999
>               sys_pll_div16           0       0        0        31249999
>      fixed_pll_dco                    1       1        1        3987999985
>         fixed_pll                     3       3        1        1993999993
>
> Unpatch:
>
> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
> 1000000
> 500000
> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>   hifi_pll                      0    +/-1562Hz
>   sys_pll_div16                 0    +/-1562Hz
>   sys_pll_cpub_div16            0    +/-1562Hz
> + sudo cat /sys/kernel/debug/clk/clk_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>      hifi_pll_dco                     0       0        0        0
>         hifi_pll                      0       0        0        0
>      sys_pll_dco                      1       1        0        4800000000
>         sys_pll                       0       0        0        1200000000
>            sys_pll_div16_en           0       0        0        1200000000
>               sys_pll_div16           0       0        0        75000000
>      fixed_pll_dco                    1       1        1        3999999939
>         fixed_pll                     3       3        1        1999999970
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Da Xue <da@libre.computer>
> ---
>   drivers/clk/meson/g12a.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 66f0e817e416..f78cca619ca5 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco = {
>                  .frac = {
>                          .reg_off = HHI_FIX_PLL_CNTL1,
>                          .shift   = 0,
> -                       .width   = 17,
> +                       .width   = 19,
>                  },
>                  .l = {
>                          .reg_off = HHI_FIX_PLL_CNTL0,
> @@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco = {
>                          .shift   = 10,
>                          .width   = 5,
>                  },
> +               .frac = {
> +                       .reg_off = HHI_SYS_PLL_CNTL1,
> +                       .shift   = 0,
> +                       .width   = 19,
> +               },
>                  .l = {
>                          .reg_off = HHI_SYS_PLL_CNTL0,
>                          .shift   = 31,
> @@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco = {
>                  .frac = {
>                          .reg_off = HHI_HIFI_PLL_CNTL1,
>                          .shift   = 0,
> -                       .width   = 17,
> +                       .width   = 19,
>                  },
>                  .l = {
>                          .reg_off = HHI_HIFI_PLL_CNTL0,
> --
> 2.47.2
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

