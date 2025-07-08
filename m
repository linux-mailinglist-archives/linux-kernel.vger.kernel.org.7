Return-Path: <linux-kernel+bounces-720688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DBAFBF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B341AA767F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEEC12CD8B;
	Tue,  8 Jul 2025 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pIgS/dKv"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD491801;
	Tue,  8 Jul 2025 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934972; cv=fail; b=iHv0m4rH9S8e2sbhUpa/+BckHcinCtD1cVSvk55yVg7L7ozgSGqhh72irBirfQcWMJ7GvnJJ0mazQUg5BRHBtWNJMA8UACFm/QOrjCYw8wC9UHJTRCDVFlHEbMI0KnDOYE9TMmbkltpE1v/WdYN46OeRBqfGtNgBFYwhaO5c2jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934972; c=relaxed/simple;
	bh=b0J9j/tNQA3PxjFuCDkzXKM+1pSNEqgvet0+J4mfrRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SV0usxP7adlm6mi/WpUQq+00FpqHr7+ovLSWbzrDcITOHVMlEiIbg5ZzwhRii35TsFr7dGrrk7IKfoz1kEzW9jtGwS7OG/VBXB8VxsU4M80fYTvasRF/DyGb582uMJHZlApvFTYuVaLh17i2Z+U32wlywoQfuN5nPb4D2tfmLns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pIgS/dKv; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBbzHcG/ParpGqOhxmd/h/rFLhTEX+Lw553fHpb6KLp3lcnakW6VlDU1DwhAZlwsgrqVTlE9OZPyWchHooSQgEsD2cpoEnlNk+KUL0gHP3R1f5v6r7aes68BBxpMFoyHYXIBmnk77nEZe2KgL0qgbe+u+XK5KiilDfzMzs+Nvn5PWPdzpPaDVbd7FkzD8yyILIJSgNg+dpVZzN4pBpetbFLokx/aaHeECdqjRFCbwG1zayTNOCp77jMLsiS77RMBA/ZURO0ufYzR//CVPyiG48cRcvM4wkRx8VDOhmDjzIRiKZbsTP5zUGUFSSE3pp3bAXLMHl0a9IYxNyjA8cd19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK6nAFF/8B9yENtZMqOSRpADCYCkqd8NNVoWEL3jrmw=;
 b=KJQgyLY/EcoxbQ9rwxqNsNsczZhC8s5UCXnnkmaFGsrrXLf9xgrDJMRh2JFIqYvSncbFymY8NJTx/al2jKU2YPL/gfyTAtiAxebHQQ91poaEirMR9sHWcV8KWA9w0rxkdejY0mURkQ105Te9Lc/6buC2CI0Wf2QBYSUX9pu98jTd5ZVJiMkF/pHr/lu1WLhR/QZJv5lMvGYj47w2KFB8ZCDnFK1oC2JnpE+NbvS1o0OZ7gaDCRcCFMiP903kgHtun74Gmuon/PXYXwfSdDbBCW9KPs1IRWAWc8wZh6UvrgwOtBefU87v4o8DeP36CN+pGMyC1xB5DNtzxreKcYvypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK6nAFF/8B9yENtZMqOSRpADCYCkqd8NNVoWEL3jrmw=;
 b=pIgS/dKvV6hnJKjJW7YC1G/uemFA5DTMbad9cGl7joif1PqbJRTGagybL72JZIQS42LpVugYK63M2d+Wks5VdzmaGSDjE3vGq/4ICV/Pw5yWmrGfC3xUN3gAKMNgRKq5HrldV0VSJqhYGpECyQNgh33YtLvGRYSNnUNZcGw8JRuqe/BrKuuupBiLrhCP28NEPCxNyBGDGaLJVPEhe9wcEkQ+Qg+5DBsM57m9G4VHNTFuAD9rLN87mLoW3cjo+RjtO8n1z/m2H9PenC/qq/9mmQgT5PsVLyer0TYFgOTX1RSc9hhL6DAz8dr8uAGOegfhhAn1vxqq+aPi0rIeNkDsdg==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by MAUPR01MB11168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 00:36:03 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:36:03 +0000
Message-ID:
 <PNYPR01MB1117120334FE846BF4828FCEDFE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:35:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] riscv: dts: sophgo: add Sophgo SG2042_EVB_V1.X
 board device tree
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1751700954.git.rabenda.cn@gmail.com>
 <27091134ce1f8a6541a349afc324d6f7402ea606.1751700954.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <27091134ce1f8a6541a349afc324d6f7402ea606.1751700954.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <2bf81edd-c831-40a2-bf45-c25bac9e251e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|MAUPR01MB11168:EE_
X-MS-Office365-Filtering-Correlation-Id: c80bc981-4f9c-45d5-9099-08ddbdb76afc
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT9t7DujJ6AQN4qQStI03N4JOpo8PY/ryCCkKX183uisv9JyrTlhD4d3KXlqsX0wpdjJrzDpQfKHT4nPQwuSaGf95e44NppHjrleyyVRDANKAzOF1afxBR2RcRECPO5nKWxnLqIaTWhCRIIqL8b9C80+TfNF3Uc23wIzpMzjXPGBPb0sUTAcUGGuP+VOVOx6Zi3/Vp4oiwXKzqdxjfhv0FV+ChIPuynw9xGg7WrCYLaahcxOxh2dlXM+98PWoqxaLJUZuL7lp95DsugA180qntg2gfd6+zhobhHck1SlRlzzQCuFzT/AbDtSPdf1zr8W2i0XvqOG3OgyayU057SN9U/HhuqoYsm12EZ+2tFxJLQYuB/K02n5ImobhjZsd15eMQrzRtjNk8cRGk32fx7gjYZI9YrSZdNNbzuMkMC4RSWnSF6IrBWK+n+ouBtVCETN+OwpWi9Xew1LGP3WDxb1gx7t5WzSf4BZvBxy7sIvESp+68fAYvwIXMFtPBl/tE31BYCg6m/YMjzd53uRjT0u8N4/wmHgGnnafIpuq4GOAs+L1slag6E875RTsGf2x81jZMt3n2jWu+pFA7ZKy4ZpE8U4OCL+j1NMk/diWyuzHwDwJzvSdaA6ibT4gc7ZLNWoP9sxlxFWnIodOx/0VAuRN6vzofcyT1yZkrdPCzTOCb8GwdSqPN/esHYzRQuWY/V2TxQkaO7dRDpXDxxM3R8ZCrxHQ563uuKRCfUEz/Liq1pgy7ZEgktVAsMNUpuJupmE9/IpT90zEx+RKBbKONFlUOg8CSu8kXH2pfIXH3gG0g7cF1hDFATss7ka
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|13031999003|15080799012|41001999006|6090799003|40105399003|3412199025|440099028|10035399007|18061999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG0zd0RHem9QaVd3eVlrRGhMVGZlR2FJc3d2Rml5a0N4dklXaWFHbTU0YSs2?=
 =?utf-8?B?ZXlLK014alhvTU9UQ1IzbGZlQXkxUS9ZeDBPUzJ1TnczR3ZYMWJ1MG1UVVRU?=
 =?utf-8?B?b3gxMkFHTGsyRjNadUx2a0poYkZWMWZiZHFCdGRhY1VhRDExNEVvM0pnMlBD?=
 =?utf-8?B?ci9vVFBQUTQ5c0VzV1RyQXRQckhIWGc5L0pHdHcwcGRVem4raFJMWTY3MlJt?=
 =?utf-8?B?MlRaaElYcHhTOHl4SU5KMm5vREhRamF6NlJ3Tnp6N2lPZ203aUpCWmlSaWJZ?=
 =?utf-8?B?QUEvQmF0c2lhNDNSSHd2VVphVFlFM25GdS82RXFxc3hSNVpGc0g4aUZvdkkv?=
 =?utf-8?B?ZjV4ZmZzOXlPalJ2WGxjMWRudmNQM3NVY1Rwd3dncHRwMTR1MkdnQkJ4UFAr?=
 =?utf-8?B?U1hxWXVOeHhaL0x2dmJnTUx1VFVSVlZRYmZzcFpKWmF1alhwaXNMM3FkZzg4?=
 =?utf-8?B?bTNQZ0xSYmFxdVFEZnFiZDJMMW1qeVVpYXV1a3QzQjBLa3NubXhZaUxSYjZB?=
 =?utf-8?B?L0dmT29JK3ZqYXZvOGFBamNnWDA3ZVhFTW53VnFnNU9IeDFnYWxqSnlyOHdP?=
 =?utf-8?B?OFV3SjNxM1RpekJqV1hodWlRQWFXSW1NbDIva2tzNG5kTXJjOUl0b1YwOUtO?=
 =?utf-8?B?ZVVwS2IzcmIvaW9jWGpiWkFxdGlteXVqUWFVWHl0VzFkdFU1UFVSZVEwcU5W?=
 =?utf-8?B?UkJZeDBEcDJvM29MTGZYK1RNOHA3K3RVOFdlR09KZklLanZ3eG94VDA0SkVB?=
 =?utf-8?B?dTdJeGVnWlhJNlFKVkpXcXllUG9RdHRoOFJxdmJwYXRYRVVhL2JzZG8xbXZU?=
 =?utf-8?B?UFZtTW9QNCtadDJoOE1ETU0vMk1NeGV2a0NIOXFDZ3Z1NHVra2VtWXozWmVP?=
 =?utf-8?B?Ny9BR3FMeHVPRlpKbFUwc0hDbENKN1NtR2Z2TGRNd1VCYzZWS2lndjl4R0Yr?=
 =?utf-8?B?dnc5NFU4REllSngvTFN2bTBuVm4zNC9LekxvZWh5WHM1ZDRwc3NkVnJNQzFx?=
 =?utf-8?B?MC81VmgxemhGamQ0NVUzMU1OOVA3Y3NBdW1IdU5JbzRNNkdIRjk3Wnk2ZjYw?=
 =?utf-8?B?NEVhUWl2Z2gweTNuTm5WaHlQc2wrWUM1Q2MvaW56NU1BMzJML2NBVzhla2p5?=
 =?utf-8?B?MDJhME10NnRDQnJ1V0N5TEZWUnBSNDF0UVY1U3RZOUllZ1hXRDkyZXJrcjd0?=
 =?utf-8?B?R0JwQ0dlNndseXoyV2ZEaFR1NExDZklsblgrR252S01ndzJacjNpSlk3QjBW?=
 =?utf-8?B?Y1RoVmtXc29iMUdEbndSQTRjOE40MHduY3FuWlZpOUNaQnJrZjZJbzViM0Nu?=
 =?utf-8?B?eEtVaDV4RGF1ak11cUc5RWlvZzBadmw5dmROQmZGRnNIWmhjMXNsM1Q3YWVY?=
 =?utf-8?B?L3hhM2xVN01IU1ZGWTViT0NpM25mZEYrL3Q2bitZZTdMV01VZXhTTFI2Zi9l?=
 =?utf-8?B?L3FIQmF5YWJ0NGpQSkFQMGhEbG81WVlBNVNQVlduYWR5emwxTmswNk4xVEhw?=
 =?utf-8?B?aVFQNU9wVzV3OWtvZTNXOUFRL2RwSjNBakZzSkh1b0ZIaHRVajBTb3VJK0RQ?=
 =?utf-8?Q?0A0QwRJrHgH3ZnDGd1MxiFakD7BVykWdnCPhO5hibwVI/J?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjBmUlQ4eS9RcldNRGRZVzcxbGIwN2xBdDZiZkloaHRCM05FVkRMNXFGY2pW?=
 =?utf-8?B?ODJLOXFOay9NZTVYSmUwcXlXSyt3NURnTEVZSklzMGxBYXBNZTl5OVhXcGQx?=
 =?utf-8?B?aUExQnR4WXRmbWJPNFVYWXRrSnROd0JxMXZCVjZrdmlKWXdYTXZZdUVPcHBq?=
 =?utf-8?B?NXNPbmkrQWtBRkVESXlyM3RiU3h3SGl0MDArQ0RJdndPMnZJd2tnVUt5Wndr?=
 =?utf-8?B?ZkNOamY2ck1TaGNzZnVmSndORDh5OENWUEROTHlTNHYwUTlQMjRrckNVRWpz?=
 =?utf-8?B?cGRnQlc2OGhkWWo4dk1vYmpzL04rVmo0cnkySEdnbk9uNVJubElTR3hBWGhJ?=
 =?utf-8?B?VWtTeXVidzNGY3ZOaUsraUkxSmJVdjNOY2hRNXBETG1scG9aelA0enRONXgv?=
 =?utf-8?B?OVRXbUc0ZHVxZ2g1UFYvVjJsSjBJTU9uN2E4MVpvNmo5dEh6ZkxiWnRmcE1v?=
 =?utf-8?B?cHlrV0JzWEcvSHNreDRTUk1iU0JxbXRwZkhWekV4bXNxai9BdUZDWTBEbXJO?=
 =?utf-8?B?a0VWNi90aEtKWmF3cVh1QWxyTWF5cUF1MUk3Nm00K2JKU1lQQ21YQVBCcVdP?=
 =?utf-8?B?SmJNb0tjS3JjbG5mcmZHcnRzNWtiWnVYbWlWS3V5VS8zYmdjT2VnWnRaM05R?=
 =?utf-8?B?RVlFYWZUMFJPa2c1YzBXTmNjOHBINzQ3R0NZM1doeTloYTJPQ2pTckliQnU2?=
 =?utf-8?B?MHE0dUt2aXpBd1VrWHFKeXZpU3RGQVlYQUxkSHRVeVF5SzJwd0VpRjhiZXk3?=
 =?utf-8?B?RE55aGhyOElYeTg5cHN0ZUZnNUphaGpzYzZxdkhLTGJaUGRNVDdBdGJIbHVj?=
 =?utf-8?B?UHRQeTcxMnNKbGRpSFRVNUd1TjkzWXJaOGdvRDVEQVVuRVZ2M0NSc2NpbDhC?=
 =?utf-8?B?SlZ5bGgzUHNtSlFtYnNHbDVDWnJSMHBJbGF2K01LK0I1N2V3MlEwSXlmZkpE?=
 =?utf-8?B?MmJWWG1aRktIT3RhWDFQc051YmFxd2VUOHVzWm56RGpNY0p2ZG8vd0szVUxl?=
 =?utf-8?B?by9GdDk1anVzQVFFc1BMRjByL0M5ZGRMNk1VbFRSbUtxRkJLVFNUOTZqbm4z?=
 =?utf-8?B?cTk4YS9WTnNPQmcxRkVCRDBFdW5tWFRCZitBd2kwUC9lUU9HUmtaOGkrSC9U?=
 =?utf-8?B?bnJjczYvblFNSndrM05wVFBVQTJXTUxDdnBwK2hDM2JVaEdtUWVUUjhJQVhu?=
 =?utf-8?B?bHNHUmxpdWRDNS9JeFNiSWpSaEZNRExSNVFZSFpvTm51VzdDV3JjRFE4M3Vn?=
 =?utf-8?B?eGJHUUF2ZWVzdlRxRkR4OHUrampCUzkvTFNlZnNxZ3lCby8xNWYrTGRkSWMv?=
 =?utf-8?B?Q1UvVldsNjFFSldTTXZ0RjFnQnJicHZIV2VkaWdhYjFvaE44Mlo2dFZFV2JL?=
 =?utf-8?B?ZGlVQ3kzL25IMlM2d0VJaVFlQUZ1Qy9ybmxack9VTTBZZkFaNGxpTWJFUjBL?=
 =?utf-8?B?Rm44WjJNNERvRjYyajhLN1NzOU5hQjgxQ1JVa3FYcWRWODdYSmt6L0xweTBh?=
 =?utf-8?B?OFdNckkwbjNVUVdOVTE2Q25LZ0xKU0V0UnBZV25xSDAyOWxqOEloa0k1VXhz?=
 =?utf-8?B?dUFzMXdZNmJJWWNIVHYrUE5vSmNEN21xM1RyeEkxZ1JVNzlHYXNRVEJJTDJJ?=
 =?utf-8?B?U1oyMVNCaCtPaFVvcGM5Y0ZrRHdOQWpFdnR4Tm00MmtYMDdlQ21rMGdJcUQr?=
 =?utf-8?B?c0QrMEhoNDJEL05FcTA5YnpPcFNFQW9pZ2pnSlRZNm9Jc0lHVzQrVU1ReXM4?=
 =?utf-8?Q?xgZW6UZT7XmxS6OIIofoNIuxbg7WU2VXYNBVIWI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80bc981-4f9c-45d5-9099-08ddbdb76afc
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:36:02.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11168


On 2025/7/5 15:39, Han Gao wrote:
> Sophgo SG2042_EVB_V1.X [1] is a prototype development board based on SG2042
>
> Currently supports serial port, sdcard/emmc, pwm, fan speed control.
>
> Link: https://github.com/sophgo/sophgo-hardware/tree/master/SG2042/SG2042-x8-EVB [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Just note that the patch for ethernet support has not yet been upstreamed.

> ---
>   arch/riscv/boot/dts/sophgo/Makefile          |   1 +
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 245 +++++++++++++++++++
>   2 files changed, 246 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 85966306801e..6c9b29681cad 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-evb-v1.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2044-sophgo-srd3-10.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> new file mode 100644
> index 000000000000..3320bc1dd2c6
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Sophgo SG2042 EVB V1.X";
> +	compatible = "sophgo,sg2042-evb-v1", "sophgo,sg2042";
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	gpio-power {
> +		compatible = "gpio-keys";
> +
> +		key-power {
> +			label = "Power Key";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&port0a 22 GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <EV_KEY>;
> +			debounce-interval = <100>;
> +		};
> +	};
> +
> +	pwmfan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <103 128 179 230 255>;
> +		pwms = <&pwm 0 40000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	thermal-zones {
> +		soc-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 0>;
> +
> +			trips {
> +				soc_active1: soc-active1 {
> +					temperature = <30000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +
> +				soc_active2: soc-active2 {
> +					temperature = <58000>;
> +					hysteresis = <12000>;
> +					type = "active";
> +				};
> +
> +				soc_active3: soc-active3 {
> +					temperature = <70000>;
> +					hysteresis = <10000>;
> +					type = "active";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature = <80000>;
> +					hysteresis = <5000>;
> +					type = "hot";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&soc_active1>;
> +					cooling-device = <&pwmfan 0 1>;
> +				};
> +
> +				map1 {
> +					trip = <&soc_active2>;
> +					cooling-device = <&pwmfan 1 2>;
> +				};
> +
> +				map2 {
> +					trip = <&soc_active3>;
> +					cooling-device = <&pwmfan 2 3>;
> +				};
> +
> +				map3 {
> +					trip = <&soc_hot>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +
> +		board-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 1>;
> +
> +			trips {
> +				board_active: board-active {
> +					temperature = <75000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map4 {
> +					trip = <&board_active>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&cgi_main {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll0 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll1 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&emmc {
> +	pinctrl-0 = <&emmc_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&i2c1_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mcu: syscon@17 {
> +		compatible = "sophgo,sg2042-hwmon-mcu";
> +		reg = <0x17>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	mdio {
> +		phy0: phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			reset-gpios = <&port0a 27 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <100000>;
> +			reset-deassert-us = <100000>;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	emmc_cfg: sdhci-emmc-cfg {
> +		sdhci-emmc-wp-pins {
> +			pinmux = <PINMUX(PIN_EMMC_WP, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +
> +		sdhci-emmc-cd-pins {
> +			pinmux = <PINMUX(PIN_EMMC_CD, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-emmc-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_EMMC_RST, 0)>,
> +				 <PINMUX(PIN_EMMC_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	i2c1_cfg: i2c1-cfg {
> +		i2c1-pins {
> +			pinmux = <PINMUX(PIN_IIC1_SDA, 0)>,
> +				 <PINMUX(PIN_IIC1_SCL, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	sd_cfg: sdhci-sd-cfg {
> +		sdhci-sd-cd-wp-pins {
> +			pinmux = <PINMUX(PIN_SDIO_CD, 0)>,
> +				 <PINMUX(PIN_SDIO_WP, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-sd-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_SDIO_RST, 0)>,
> +				 <PINMUX(PIN_SDIO_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	uart0_cfg: uart0-cfg {
> +		uart0-rx-pins {
> +			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
> +				 <PINMUX(PIN_UART0_RX, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +};
> +
> +&sd {
> +	pinctrl-0 = <&sd_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};

