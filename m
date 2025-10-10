Return-Path: <linux-kernel+bounces-847700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25831BCB6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9181A64074
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB123AE9A;
	Fri, 10 Oct 2025 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="TpvDpJ4F"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022123.outbound.protection.outlook.com [40.107.75.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094921CC4B;
	Fri, 10 Oct 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063965; cv=fail; b=iphWAv8vfrtywV7o6jReF2ApQ0doy19YfkuV9TiiPddaDlTD8GYgxWqiJ3zV3Tb50e8J5uuLMoMogqQgBhtRDQgQPUGTFWZGrTxM9HgcBfvn2UMQI3gtWlpK9SbSfgthdgM9BAnioJJleQEJ9lfcm/rUIdzzR3gXx2MUi7teehg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063965; c=relaxed/simple;
	bh=vNpEzRu1FhNRNdEvHfw1VjMvjt2LjyocD9nLROGQk8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXSA1bhlrE2BWia/bJY6vwhH6IXkYYz5+BHwKtfy9rhHChkWx/hSIE6IxgNmXZEnuJa5EBxgd59fzyDS64MW0vg6U/ybPJ+JwzJJjUdXF5qr9BbMqKn1NAY6KpS7zwJ7mxVrspW4f8ypHbnDhtCKIfobTAVw9pmmTr58DmgGiJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=TpvDpJ4F; arc=fail smtp.client-ip=40.107.75.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAuPI9WOxhpfl++B5Wr9f2vCMtiCsNXbv+Q1ch+iE/RbpzyiVzb+UroXsqdIvtFA2DpxZWfJmUK8RcCol4Zf4bzUYydEYL1pozlTVwlpqlIrgkNyYm6udpeXHkv2zOBHGCtgOV/VAPVj1QIsSDQP93sNX2J4HutsnEsWHWKVAPejS6jZnKkDf+rsSWjzG4IdYOUGtcg0Y0v6VR1TaXqiVdTCx/4+GeKiORek5jbre2oyZx2jrqvc3z5cWb+DcrA5DCRA8cl/8wJ/rcqFWqqLByxDUH7BE/57lRUgLlBn57lzLU3RibKU9VRiO3yrmvoKaPD2SBmqEBeZsS/0YikdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P+Va6KDpowuP75a818coenC9VJlD1jPPqL3LJ6l2Eg=;
 b=QKtP9WilaZtDXHY3UQ2fS39E5qynyhhrGJGjWTX0Uln9KRrXfG+yHd/M/gHCzkGuL99Y9sRuzZDq0gY+SvHMdV13dmVYpbSY3g4Er5ZV3PbjGpAu0vxKHud57Yx3bTb8rSzzZams9fkOy4g99NiMr87EP2KGUfsZDNVVYiO6XTzyn/XqDGYTB2TiNj5G77cmc8/AoP8c51vq5vh7ser2P+YtTEVYhsOt5RhP5VqBxcs5AXVgSdRgSVsLUs89Xra8Jr8EWIReIUSn9PE88wy4g7bSZR7qEzgyGaGmxKQ4RlhE/9HRUiDEuiqM64l0zXd/rC3XVF3Kc7Xzbgrh9H7Lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P+Va6KDpowuP75a818coenC9VJlD1jPPqL3LJ6l2Eg=;
 b=TpvDpJ4FTouUYx4XzwkiP8GW94BPpgz9/RxXTUVoiZuqW30qIg56NIUOpAVc5ymfDzXp66hX/4Hnv9s9mzTz0oioBQOfsIilodtmdJHp26VRMZzeKRo1+WCTM6PpvgrLa+WX4SciDxULtd7CVWHf/ojmEtp09p5ueL3n+Kaay0XU76QDWKFiWe1pK7SMEY1aNTZZN/ckI2RbK6n8FHl+31KZJUEbtHtmZzEVzTy4CLPxA/NXClp22l3nSaZ0FHFi/Ap9y1Gvt+JvLjEXZUqjcEXelnJQR5YGOpaK6uxTfAdK4teAqq7zXXNwa8pXqZonwruQvWwyMCILPYJDhZJ2IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by PUZPR03MB7042.apcprd03.prod.outlook.com (2603:1096:301:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 02:39:16 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 02:39:16 +0000
Message-ID: <7a5d3f57-4c0e-483c-9d6f-9556583180a7@amlogic.com>
Date: Fri, 10 Oct 2025 10:38:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for A4
 and A5 SoCs
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
 <b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com>
 <1jh5w84iat.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jh5w84iat.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0202.jpnprd01.prod.outlook.com (2603:1096:403::32)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|PUZPR03MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ae8034-bfdc-4cd5-c617-08de07a6349d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z09CZHFXbGU1M2ZJSFB5ZjhzVEFCK2JyVXpxRWVUTjNURzhhamMyRVpJVFRa?=
 =?utf-8?B?OWZScXcyb0JuSEkvU2NNRVV6Uy90WFVkYjBnc3Z0d0JBRHhkdzBCTTJuR0Ev?=
 =?utf-8?B?ZjNZb2gvaWhlYStoTXY1cjRYTE10Y1F2UXNsTlREejUyVkM4ckVhalZlNjJP?=
 =?utf-8?B?TkFKZHRhUGRQUlBTSFdid1gwaUZNa0YxUllXc1c4NXl5ZmVWbUZzeFcyU2h6?=
 =?utf-8?B?UURpZzhvM0tobGFIcExvcCtxcFBXZ0s1ZldJV2I0QnY0QWpJWGxXTHU3SFRM?=
 =?utf-8?B?dWVKcngyQjFLaDVZRTZMZE40dnQvYm5EMnZqL3VjRWdUdndmSUpBWUg5VmRi?=
 =?utf-8?B?Vzk3aWVKQWpmZk8rbFdFNDRoOHJwdWR0UUp3eGx5NzRadjVTUmxnWFVReXp5?=
 =?utf-8?B?VHcxSVplaE9sR2V3T3UvQ0ZURFI1YmRTb2pHbkpTVmZmU1gwTnR1UzNNbU5F?=
 =?utf-8?B?OC92Nkx6NmdOSVNvQUx3R2pkdW9TUGNzcHlJemM4WGNMelRIQ1VqaERZRGpJ?=
 =?utf-8?B?VkRUc25MbzJZZnBDUnhrUW9ZeXFJdVJmdGI4azBPUG1mM25GUUVjMnNyZm9p?=
 =?utf-8?B?RDF0RXBZRU5EaWNoQXREdzNoek5Td3E3VFozZlRuZmdBbXZaTmZrL3htbWI0?=
 =?utf-8?B?RHR2bGxFNjU0eEhSM3h0RGdhUW43bHhiMXhNV01IY1NuaUE5a09vNnBOY2Jm?=
 =?utf-8?B?RlVjckxpWFRobmZwNXJjRFZxVWNteDY3U1FEaTJKMnVTeEJZK1dYai90YlEw?=
 =?utf-8?B?bGorSzZMMkVxWGtWVmxoT0lZZUwxZlhEUmVKOVNkbFBCdjNTNHFnRmhvOWwz?=
 =?utf-8?B?MFRENTJ5UnFTQnFybFROWjNTYklmM2FXdXp2Lzk3RDErK3pyT0ZxVDdtU1BH?=
 =?utf-8?B?R0ZrczQxOFFsbFJoS3RmWTUzOSs1VmJ2K0ZKdGRQVEhpNHZXdGR0R1FuVUZo?=
 =?utf-8?B?NFk3eXlkS1JGQytQT0tEdFJsMnI4bzhuS0gxNEdnSSt3WW00a3B2YjRsMFl1?=
 =?utf-8?B?Q0JnMC8vc3FFUWFtTVdMQjBZbzlNeWdoczdLUzRab3h3YkRJUWQ5bUtKckk5?=
 =?utf-8?B?RndJWjRMdHZtMjBjMlpUdk5oc2V4dzhnWjZZOWFYbWhCbmd2dy82TGl1Skp5?=
 =?utf-8?B?V2lWNEk3V2c5UnJyRjBmY0dLSWI2bjVoVElHbmRyVWRLQlpBSGVZZ0h2NVIx?=
 =?utf-8?B?V29EUnVGL3M5SUpSMGgyRi9FVUNnSklzYmhpc3pYOVBodGgzMktVWXpmT0ZD?=
 =?utf-8?B?NERYQyt5aUl5a3hQaTF2clU4TW1UMTlKZjh6T2VKQ1BpL0VFYUp4TXdENFlK?=
 =?utf-8?B?NU1vbTNlZFF4NFg5YjRtU1BmejhwWW80VjBLNXNXOXZwWWNGVlNmcThCWnh4?=
 =?utf-8?B?bFMrOVJKNTYrdDdkQlR5WVd1TldPSDgxOG0weG1iZmhuMkVQWXprMVNsbmVp?=
 =?utf-8?B?S3B3R1ROMCtSeXRFUUFHQ2NaZU1nNzd1SWxtWEJadG1jMWlwckN2NVhQZFJQ?=
 =?utf-8?B?aEpQaFVKNllVTzI1amxRcTU1YWtpQzB1aGdpa2lRWE42MEhIczhaSmRoVDJE?=
 =?utf-8?B?UVp5V3VnRVo3c1VMNXdGU0dKeGRtNzFEb0cyL2RHSExmUStzamxKZE1Yc1lu?=
 =?utf-8?B?dUVMQ0dMVDJCYUgvQU9La2hYK3ZUSUdIUHlOdGJmUHAxSnRsT0JycHUvU2NL?=
 =?utf-8?B?cU1zd3pmVUlHNWVTYytzOXFlQnViVzN4bW9pa01KNml4cWJsNy9iRDJGSWp5?=
 =?utf-8?B?SUpCTVpPTUkxTXg3VVBxWDgyTTV0VkY1ZlYraCtCTFYyVmJGeFBkeFRJb2ov?=
 =?utf-8?B?ZmYxNkhmOW5EWFR2aGdUWGhGalk3WmlaeE0xc2FMZHlueGNqdlJKeWg1R2Mz?=
 =?utf-8?B?RkVyVklUQjdySEl3NDMvZ3Nzb1E3Q0lBOE5Ua2xXZXlnS2lnaGdkVjZCaDNE?=
 =?utf-8?Q?xeAVyCmlOjjb7MPH0IHCARPiLBtinfIz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWswRzhQLzJsM3BUc3BlWnJJRk5kbG5JWEszdi9kSjRwdDBKNy95Q1Q1R3lP?=
 =?utf-8?B?M3N6OGhiQXFGSmJQOTNiR3lqL3gzOS83bXpTTFNoV3YrVnBscEhGbzBPOUxR?=
 =?utf-8?B?UHN3YzhEWXh1WlpNQkVGNHhyY0l1bEJKK1RvMXowNExOckZrbUI5U2xGaFlm?=
 =?utf-8?B?WlJtaHl2a1dWK0NIWjYxSjlBK2ZQVnNXZnNIMCt2U0xic0tRRU8rVWtRc2E1?=
 =?utf-8?B?QVpvMUk3akxTTTQ2RmFBSmZ3TTNKOUVjZkxIRlBac24rcXc5dytrL051dDFO?=
 =?utf-8?B?UnhKY3gwakxRY21kMGdqSUprQXNQZjBlem1IVEh3ZUtSdGlhZ1VoOFIyVlBW?=
 =?utf-8?B?ajBKd0FRUm43L3pWdEhnSFBMZnVsZ1ZXU1NtKzVmVkdWRDc1NFNTVmxFc3dY?=
 =?utf-8?B?RTNmdzVOcTdJSFdncDBDS2RhYS9lcGdvM2lFL3V2MytuNDJnQ20wMmFLYTYx?=
 =?utf-8?B?VDZpQ3BzSlVDMG5yeTQwUEI5Q1F6TEFjQkVkVm9zNCtpNmtFUitvSzBCZzRB?=
 =?utf-8?B?cXpxS1JoZ0NLUEkzOWVtbzlLalptUE5JcU1iTEI2eEo2eVFSVE8xSDNKS21p?=
 =?utf-8?B?cm5wRVZxTmhHWDhGbEZ4cE9BU0MvZjFoRWZSbEFBRVlvVFVnaFdFaEk3SEdZ?=
 =?utf-8?B?bkRBRkNRQmJlZjZjcWhjKzN1Tkt5aEE3Z1hPVEM2V3FNV0JWeG02QjV0TTNa?=
 =?utf-8?B?UDdzYUl3WnRUN0tFZzhxNmlZelQ5RW1HbDFtRjZOOVRwb2xUcWhVRDI2N1pk?=
 =?utf-8?B?bHBIeDc2ZjdkTVBHQmhDWUZid0N3cWlEazNWSzJqdDJMWldCYlNOUkQ3ZnR4?=
 =?utf-8?B?VjZQbUROMDgxejdsTEdBTlZvSTIrQXRTN2lSZmgwTGh2SmgxdUQvdE92bEZK?=
 =?utf-8?B?WWxmMXlvN3NyZ3Z3S01ySHY2S2djdlVZZy9BMU9NWVhQZ0VqelNaV3orc3Fo?=
 =?utf-8?B?Vjk3ck82SW1sYnpIUkhyaHR3THFXNDZhRWxFRU00ckw4bk1CUDQwb20zcDFo?=
 =?utf-8?B?b0hLTEtBenZEZWdWcm5iM3hrbE1iK3RaZk5MOVE5eTlTKzd2K2YrSDhTSlRH?=
 =?utf-8?B?YUZFbGZidERQTm5lQ0REWEVyQTkwOUV3VmpHd1JzZ25SUjBxb1NVSUJoS1ls?=
 =?utf-8?B?OVBFY0xBZ2k5R0JUbllWOVZDcFBCa1YySm1iMjdTNldjaC9rVytyWi9LR3l6?=
 =?utf-8?B?Sjh3YVNoRWpudm9YLzRObU01dnFSS3lNTFJOYkRISi8xNHVaRDBHSTNnVVVK?=
 =?utf-8?B?TlFhVTRiQWI0dStOZ0tlM0NIS2czenFEcmRLVHM0U2FRSmZ4dXl4S2lFN0t1?=
 =?utf-8?B?QVJJWWd2S00wMFNBVDdjdS9TRkh0T05zaTFlbEZtOEVYZFBGWHVZRDlEQkZX?=
 =?utf-8?B?aUhvSmg4SWVxcE9kWlVpQTlBZ3k2bW9hZlp5TURVc3I4dkErNHBlTk1XR1Vk?=
 =?utf-8?B?WTloTzNVSDBMNTZqVEMwVnlrYkNyQ211YkRQRkFJbHF0U05rOFIwUXVnRHhX?=
 =?utf-8?B?L0Noek5RUCtFVEFkZHNvMXorbkRLL25GNHlWNVFxaDFCZVQ2ZDBUOWpRRW05?=
 =?utf-8?B?YnNLdExnUjBiUGJGcno1ZTBnb2dHUEhPdW0za1NzU3p3ZWxGTHliaVpLSG9i?=
 =?utf-8?B?TlorQ2hiQ1B6ZGtpdEFKeWMzMjhib1c0SldydEJEVnpZYzJCeXd5d1FIblVQ?=
 =?utf-8?B?RkVMV20yOENFaXdwYXAxWnB2YWlKNkw0MzBZQk44b1Q4cGhCVW85TXBFU3Ra?=
 =?utf-8?B?d1dSVzlzeHdkT1pjb2dmakYydUY2UThsYVBNZkY5cW96NXhkUWVCREE4WHpU?=
 =?utf-8?B?eDBZRlhSOWRQaXZZQXJoRjkzNFh4a21kYmxMYk1nZVVoajhvdGlLOTJjaWhU?=
 =?utf-8?B?VTh5YlhxWU9TRldKTVVRcUJyR2VoL1NXVHNtN2hyT09EREN5Y2ljNFVrUUxu?=
 =?utf-8?B?VTkvdEhXbUJsWXREQXNWRDhoMFNDRW90bUJlemhKYmdjQjJGSFAvQzNNc0dh?=
 =?utf-8?B?SG96bXZqUklxcmdpNkY4WVNXTExBd2JxakZENlZJc2JEaGRGdVM4OGowamFo?=
 =?utf-8?B?ajhoTHMvVWc0cUs4SG9FNHF5K2FiQThjbW16bkhQNjF6aHMwS0NvTnhUUm1s?=
 =?utf-8?Q?cmc9U1LtQSuQ72qB0gNjhjtbq?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae8034-bfdc-4cd5-c617-08de07a6349d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 02:39:16.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ttbuckeRGM7QOliq4SUCY+JrhOHgSyOsz8qKmfXcjCE8ziN/8pdOkQ0YN4eCWR/+ptKNpdaGZh0Qn+AxytHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7042

Hi Jerome,


On 10/9/2025 3:59 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Thu 09 Oct 2025 at 11:09, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> Hi Jerome,
>>
>>      Thanks for your review, because the national day holidays did not
>> timely feedback.
>>
>>
>> On 10/1/2025 3:45 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Tue 30 Sep 2025 at 17:37, Chuan Liu via B4 Relay
>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>
>>>> This patch series includes changes related to the PLL and peripheral
>>>> clocks for both the A4 and A5 SoCs.
>>>>
>>>> The patches for A5 were previously submitted up to V3 by Xianwei.
>>>> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
>>>> After friendly coordination, I’ve taken over and continued the
>>>> submission as part of this series. The dt-bindings patch retains Rob's
>>>> original "Reviewed-by" tag, and I hope this hasn’t caused any
>>>> additional confusion.
>>> ... and yet you restart the versioning of the series making it harder
>>> for people to follow that
>>
>> Sorry for the inconvenience caused. The main changes compared to the
>> previous version by Xianwei are in the driver part.
>>
>> The dt-bindings part only has minor modifications in [PATCH 14/19].
>>
>> The driver part has relatively larger changes because it needs to be
>> based on the code base you previously submitted.
> I'm not seeing a justification for the mess introduced and I'm not
> looking for one to be honest


Previously, I provided a basic version of the A5 clock driver to
Xianwei, and he helped improve it before submitting it.

Xianwei has been responsible for upstreaming many of our modules.
Since clock drivers require significant effort, I’m sharing the
workload by submitting some of the clock-related patches.

The three versions previously submitted by Xianwei mainly focused on
improving the dt-bindings based on Rob’s feedback. The driver part
remained unchanged.

The driver part in my current patch series has undergone relatively
large modifications to adapt to the latest code base, so comparing it
to the previous versions may not be very meaningful.

If it's more appropriate for the A5 clock-related patches to continue
evolving based on Xianwei's earlier v3 series, please feel free to
point it out. I will continue to assist Xianwei in completing the
submission of the remaining A5 clock patches.


>>>> Both A4 and A5 belong to the Audio series. Judging by their names, one
>>>> might assume that A5 is an upgrade to A4, but in fact, A5 was released
>>>> a year earlier than A4.
>>>>
>>>> Since there are differences in the PLLs and peripheral clocks between
>>>> the A4 and A5 SoCs (especially the PLL), and taking into account factors
>>>> such as memory footprint and maintainability, this series does not
>>>> attempt to merge the two into a shared driver as was done for
>>>> G12A/G12B/SM1.
>>> ... and we end up with 19 patches series while it could be splitted into
>>> manageable series, for each controller of each SoC
>>
>> I'm not sure if I understood you correctly.
>>
>> Do you mean that I should split this series of 19 patches into multiple
>> patch series and send them separately? For example:
>> serie 1: A4 SCMI clock controller (dt-bindings)
>> serie 2: A4 PLL clock controller (dt-bindings, driver, dts)
>> serie 3: A4 peripherals clock controller (dt-bindings, driver, dts)
>> ... A5 similarly?
> Things that do not actually depends on each other or which are not
> merged through the same tree should not be sent together. There is
> nothing new here. Same basic reminders on each submission.


Sorry, but I'm still not quite sure if I understood you correctly.

This series of 19 patches mainly falls into three major categories:
* Optimize PLL driver
* PLLs and peripherals for A4
* PLLs and peripherals for A5

Are you suggesting that the PLL driver part should be sent as a
separate patch series, while the A4 and A5 parts should still follow
the previous A5/C3-style submission?


>>
>>>> This patch series includes all related dt-bindings, driver, and dts
>>>> changes for the PLLs and peripheral clocks. Following our past convention
>>>> for clock-related submissions, the dts changes are placed at the end
>>>> and submitted separately. If this ordering makes it harder for
>>>> maintainers to review or pick patches, please feel free to point it out.
>>>>
>>>> Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> ---
>>>> Chuan Liu (19):
>>>>         dt-bindings: clock: Add Amlogic A4 SCMI clock controller
>>>>         dt-bindings: clock: Add Amlogic A4 PLL clock controller
>>>>         dt-bindings: clock: Add Amlogic A4 peripherals clock controller
>>>>         clk: amlogic: Optimize PLL enable timing
>>>>         clk: amlogic: Correct l_detect bit control
>>>>         clk: amlogic: Fix out-of-range PLL frequency setting
>>>>         clk: amlogic: Add A4 PLL clock controller driver
>>>>         clk: amlogic: Add A4 clock peripherals controller driver
>>>>         arm64: dts: amlogic: A4: Add scmi-clk node
>>>>         arm64: dts: amlogic: A4: Add PLL controller node
>>>>         arm64: dts: amlogic: A4: Add peripherals clock controller node
>>>>         dt-bindings: clock: Add Amlogic A5 SCMI clock controller support
>>>>         dt-bindings: clock: Add Amlogic A5 PLL clock controller
>>>>         dt-bindings: clock: Add Amlogic A5 peripherals clock controller
>>>>         clk: amlogic: Add A5 PLL clock controller driver
>>>>         clk: amlogic: Add A5 clock peripherals controller driver
>>>>         arm64: dts: amlogic: A5: Add scmi-clk node
>>>>         arm64: dts: amlogic: A5: Add PLL controller node
>>>>         arm64: dts: amlogic: A5: Add peripheral clock controller node
>>>>
>>>>    .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++
>>>>    .../bindings/clock/amlogic,a4-pll-clkc.yaml        |  61 ++
>>>>    .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 ++++
>>>>    .../bindings/clock/amlogic,a5-pll-clkc.yaml        |  63 ++
>>>>    arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  80 ++
>>>>    arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  87 ++
>>>>    drivers/clk/meson/Kconfig                          |  53 ++
>>>>    drivers/clk/meson/Makefile                         |   4 +
>>>>    drivers/clk/meson/a1-pll.c                         |   1 +
>>>>    drivers/clk/meson/a4-peripherals.c                 | 764 ++++++++++++++++++
>>>>    drivers/clk/meson/a4-pll.c                         | 242 ++++++
>>>>    drivers/clk/meson/a5-peripherals.c                 | 883 +++++++++++++++++++++
>>>>    drivers/clk/meson/a5-pll.c                         | 476 +++++++++++
>>>>    drivers/clk/meson/clk-pll.c                        |  76 +-
>>>>    drivers/clk/meson/clk-pll.h                        |   2 +
>>>>    .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++
>>>>    include/dt-bindings/clock/amlogic,a4-pll-clkc.h    |  15 +
>>>>    include/dt-bindings/clock/amlogic,a4-scmi-clkc.h   |  42 +
>>>>    .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++
>>>>    include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |  24 +
>>>>    include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |  44 +
>>>>    21 files changed, 3406 insertions(+), 28 deletions(-)
>>>> ---
>>>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>>>> change-id: 20250928-a4_a5_add_clock_driver-2b7c9d695633
>>>>
>>>> Best regards,
>>> --
>>> Jerome
> --
> Jerome

