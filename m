Return-Path: <linux-kernel+bounces-877886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5411C1F464
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32E9D4E9897
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DB340286;
	Thu, 30 Oct 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="i7uP37L/"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022121.outbound.protection.outlook.com [52.101.126.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62830E857;
	Thu, 30 Oct 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816249; cv=fail; b=Gu0JsUeY0EQ7TDWdwyDVufolRzHJFEkbsxm55o2V7Lr3taTjXEbBgKNRzL24m73oWa6MctVs2FlqaxURfD8485RU5i7vh35/Uf0O0cT80HDKzvOnFz1M9I7sUKLwWJaY9JJFxQ04YFDSfF13YnVm16WnICxBZ/XTi2NJy8mA3Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816249; c=relaxed/simple;
	bh=8ra2Zw4zTIatn22Fzo+dNuzou2PXM1hnfGq2Or6PJhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZvSg4T3Mm7kcHDb6pUcM/zYouc7Atqn9+4qIdi1ZCwChkDVxoeTxoEbht+02pXRR4I5uspVqK3d7QBBv40888fl9mtEUxAKkuwK6mQjNradbfVL2XArPB/F5nzKS8bJW2pTsia0ErYuQIRB61yVoB0f+c5vurfI/4NZda2PEEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=i7uP37L/; arc=fail smtp.client-ip=52.101.126.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2azSDBvOwMoiGR5T1fA4yY5Zd/dxpG/YPGvCKB3mDjP/7REP2QFnJTo3bbczRRgQH9uHnP9nvwYVaIg9X3u6AUW9HpHItSC3PYQeQKAPPT7zLrh352J1YJnz2b59lJ/5QC6C0KXgOr0/hWZFuFOE+ja6h1d6iMwW6NWg71g9keI7URYVesyKVbqje2hCL/wBrili4HOcpWwMgMCuINUXiq1LpqWuievuZkfzhm1W5TiKEtUbehjBUJHu10YhY8M4lcp1MANgViW7JqTluY2Gzr7XVuyrLfuI7y1gRBnKCAcTLe0P7WA3DDk/KoekKIzlirx+zsf/kgZBw4VvuLE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvReN9XqL5Edl2BqBRIdW4dYl7ViFSAS8aMXClKQJ+w=;
 b=kvAY+6briu9HxnThy+Cp0zcPBrZC2dEl91IFBrGCu26SS4plXnJt4uM43T11cwz9dK8IASIuhFXCgroDI7nTgp0BwuyrOYwk6DEsQk+GuX69o53a1mesb2J+GCS3162Z69VTMUuNaDMwAR23nvrSLNkxirriA4r0+m4gwlCZoP9FSy588coup618lKGf0gzP8T0AuBX2NNo0Di1Xxy834j/htKWMYYADq+9qLU4cvOmCYwbFT+jdqEabmH14YpczCAjKcNTxJy5es/jNlo+hALF3kdEOsiBOCUg1psKZjhm8QAsY3pcZfRDy8Q8lZ4ZhLUZNEJsisDraN/ZIAuZHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvReN9XqL5Edl2BqBRIdW4dYl7ViFSAS8aMXClKQJ+w=;
 b=i7uP37L/rnBhBjgVVSSPkekGoFBlTZalW6gFj76m6h1UrEoPoI7WutZPZZOGtmrRvcv6xZn3IGnkqkI9ZYW5Q9YMSAaiZC+KZallPbkogCasqb0T1yDheAQz+QMq2HJ+sirdzaHC5nK84QsyJ1ielY5XMtSP6rYnTdDUwJMT4KvW6x5aO/Bs8GFkljpkbu+5YREYEv0ZNUtZvCylrpsYAIcOi1B2nptTpWw12GNGSWTn6SkRtB3RqQZgFrdBeSSwAeV5EX+erxEfk8VGvHqjGqUg2t++u+NWYn/eWFTTykbv4P/Uy4vM8ivBd6K6OYFcHby9JI8TIq9Tq+zfokkU6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYPPR03MB9475.apcprd03.prod.outlook.com (2603:1096:405:315::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Thu, 30 Oct
 2025 09:24:03 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:24:03 +0000
Message-ID: <1c1b699a-6ebe-4c6c-b818-44da8e1bd79c@amlogic.com>
Date: Thu, 30 Oct 2025 17:23:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] clk: amlogic: Optimize PLL enable timing
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 da@libre.computer
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
 <20251030-optimize_pll_driver-v2-4-37273f5b25ab@amlogic.com>
 <1ja518zsvu.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1ja518zsvu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYPPR03MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf237b9-d5b0-409e-eb40-08de179610dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUpkai9KU3R5alB1Sk5OM3BINXQzTXFyN3dLQUV3bmNxN2dDZ1AxUnM4UGtD?=
 =?utf-8?B?SlRYQVJ4VzM0MlJOcFhlcGRmUFc5cldxVnRXcEtGVVlVZjhOKy84SUoxdHpz?=
 =?utf-8?B?QVYvN0NYbEhrRitqT25OcmMrYmZiTFY0WmNKbGJKS2VpdzVNQXVUSWVvSUNt?=
 =?utf-8?B?ZmtqNzlNdGFCdUtwbUVickFQbU9pa0dXK0VhaWpySDI3MmtsRWRLSWFBa0dK?=
 =?utf-8?B?Y20yb250NG90TmZuU2dCVE9sUW1PcmxqdEZFZ2JPNjVMa0tBcTdiVTV5WFQz?=
 =?utf-8?B?VXRkZm9EVVRRMUU5bGtVSWlRNHZDNkhVVFVuYVB1d1NMQ2l5MU5EUGtCcnJB?=
 =?utf-8?B?QjFFbTBWSnJqTFpqT0ZUNWFxMlZzZkxETEM4RFdMTnZOY0h3QlZ0VWIyOWRI?=
 =?utf-8?B?Qm13cjA4ZnloeS9QSzBYT3EwaTJNNXlmTUY5V3FRQStMemJjNTZ6QTVwNlRQ?=
 =?utf-8?B?bWJRUFVFa3V1N3lRLzFJZEIvbmFIaFhPWDRxb0pXbFpnaUV3SlFONWN6bVhO?=
 =?utf-8?B?bVpTZFZoZEUrVTdhYjVaMVJndUpTT08rRk81cmp1WjlSMVBOYU9idkpCNDZw?=
 =?utf-8?B?cEZrMDJYcVlrM2oxelZnb3NJR2RnUFpzU0JKQ2E1VXJFVnI2SVVueHo4MU94?=
 =?utf-8?B?Z0RCSC9ybUJTc1ZML2VaYXJoNjdTVkZ2c2ZidjJIZnBvaklLa2xxeWNsQXFZ?=
 =?utf-8?B?MFlmVEh0dStXYVduTzQzMVRwWU1UcGVxMWQwWW5uTE1sWCtUVUo5RlpKNC8y?=
 =?utf-8?B?Y2Q0WDliTTdLRmRpM2oySWVBM0U0YkJTWEQ5N0w4ZHlKZFlQeGtsVjRaNG85?=
 =?utf-8?B?cTQwSEhrYmxKTEM1WkhvbkdGS2ZtVzZBYS9TVGRncElHMHNuVVFiSCtZL1Ix?=
 =?utf-8?B?ckRRLzE3RUgwTTZZOWpZbDRaKzExNTE5NWJVbVk2NjZSbldadGZIbFVVSWFo?=
 =?utf-8?B?WUdscklJNExheWxFYWNTVmNmRnJJS2phTFJlOTVXL3VKbmFHOGdaQk1yR3pm?=
 =?utf-8?B?Q0ViRVptZFllRGM3MWduUXh0eXNDRHIrS2R0ZS9vOG4xeGo4anhwNWovb21J?=
 =?utf-8?B?R0VSQk1FcXRkQjZ6c0F5OWxZRzdvaGNBZ2U2dy83SG9EY2tkSUxFOHhqNW9l?=
 =?utf-8?B?NEVNWXE3aWhJQTlKZGZ6dEhTWWtJeXhMajMraThPWHRQWHR1Q1graDQwWUNZ?=
 =?utf-8?B?MTBGMWt5OGxnUkZpWitsb21wMHJrNXVTclVLK1RkZW5WaGNxQ2FkSlVtb0FS?=
 =?utf-8?B?VzZrSlYyTU5tRm55ZVdsZUVXVkhFNjBnK1pOZlZwdmQ5cXNzTHd5eWhxSmIz?=
 =?utf-8?B?Zm5nVW9QTlBySU9mT21OTlIzb0tNaGtCU2ZjSkduSFNRamRPV2ZFclpHK0Zh?=
 =?utf-8?B?OVN1bURPZWw1U0tNN1JFMlNBcXZiT0xmakdtVitKamhzVFN1NVcxeWlBbkQr?=
 =?utf-8?B?UzFvYnFva1JlelR1bFdGamNHRWlwWGRMQW5tZGpwc1IxVDE0MHkyKyt0dGR3?=
 =?utf-8?B?cVJNT3hjb3V0aUplbkxDMUVrR3RwWGN3b0g5VHIxRWlWL2dSc3ZWVk5iY215?=
 =?utf-8?B?M2VtODhGdEZiQU16N3RxamJoYkUzOHpKNlR2bVBpbFBXbU9xb0ZLdnVxemJR?=
 =?utf-8?B?Z3VHWlBNd1d0Z3JhbWNOYkJIc3RFVi9zUlRpMnFnb3JjekFvd2pnbEFGK3p4?=
 =?utf-8?B?ZjZTVmIxZzVrL2hSOHFZeTdvdGUwdjZnbFVNRENUblRvcmZrb1RpMmlBM096?=
 =?utf-8?B?UXlGbEsybU90MVg4dmYzRFBrbUloN3lKOERzdW0wZ25TZGVCMkpqMzdOeWRD?=
 =?utf-8?B?Q1poZmxDNzVubERzMmt4eGl5MmdGRE1EUEJBd2RJallwSThRWVJsODFMVXpp?=
 =?utf-8?B?WStabWswZkFkQzRFWUprcGtmeEJ5V3I1TUJrL014Z3RUMmZmVTdQM0ZkaWRr?=
 =?utf-8?Q?OL9TBxrXCNy/zyfFBKC/uzShZl5qk72E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJVSWJUQW9PQWxvZ1hoMEVLVTdXZnY5OVhONERkc0tnS0dabTdKS2VxSHNH?=
 =?utf-8?B?QXJsbUF0Y29zcG1yM1AvQ2YyWTYxaHk5dGJMYnhFcFZVdmFLamMzWWtGVFRa?=
 =?utf-8?B?eDlaQnJ1QUpOTlArenpxVWtRT3ArRFliL2RVaGhxNy9VV29mTExpRFR5eXEy?=
 =?utf-8?B?S1lyTWNpdEkxSzlBMXJNUzdQQTRqamk5dGZ1SHFDSGczRStiMXkwRmJjWnFI?=
 =?utf-8?B?WERLRktrTW1kakorQTlEcXNJTzllT09Hbmh3YTJBNHNWMiswMVlrVmFKOTY5?=
 =?utf-8?B?MUdqTnNTd1p6YVFhNGlhRE9xbStEbWxnbkt0bnBETmJ0ZElpOThweEp4ZDNo?=
 =?utf-8?B?eDV6WVpPUjJ3blplbzZYalV1Ym95bGY2aGdrOGVDTnBNTWk3SmgxRGI4RUtx?=
 =?utf-8?B?RjRrN1JNOXpEd0NuSmdRTVpHYVZGdTdOdSt2Sm43cTlaUVlGbEluRTUwM0J3?=
 =?utf-8?B?emNxVmQxSk0xN1J4ZVR5V1U3dTlZeDhGM2FtUlVSVkhBSnpXdDdKS1AyWWZE?=
 =?utf-8?B?am8rTTNIaDM2K0R3Mjl2NnpidVRaMHpLckVFcmlERXlsYVB5OXpXZHBMd20x?=
 =?utf-8?B?ZG4yeUNQazFlTm4yMUlxQ1hFUzdFT29LZDBvQzZJMWRoSjA3Vi9JS2EweFVI?=
 =?utf-8?B?enk2RjJ0c0JMYUFYRmhTV255a3ZXZUxsWFMzcGgxWGFWV3BKNi92S0pNL3Rj?=
 =?utf-8?B?bjZlYm1WNTFMRUxxdnY3Z3VhS2lZWXNNTlROOEM1dkVXUjhuRHpBb3JQYnFJ?=
 =?utf-8?B?VmF1ajAvdnBISHJVTFJjNlpNZzMwNHBLR2R4R0NXd212RGRqOFRDNG9lMkRH?=
 =?utf-8?B?b2lxQ3Nac2kxaFR4Ri9jQ0N1c29ZdGJDR0dEZFNSMjB1VnNmTThEcE5UeTkx?=
 =?utf-8?B?akVaNGNHMUQra2RvVGdSdzlXcnZ0UnlPUnQwVmJCTFErS1dvNTZLMXk1V3F4?=
 =?utf-8?B?Y2cxTEw5MjJjRmRYVXNLUmNXSCtuY1RKa2VDMGlzaGRZTHY1dnY1NURPdjZk?=
 =?utf-8?B?VXdaN0dKZVBaS0xzWHFKOThvbTVxdnBxSDFjMGhDMy9SY0x2bWdxZC9kcGZB?=
 =?utf-8?B?dHY3UzBNbkRvb3NNZVR6N3dld0xHdE02NE05aHdvSWZpL21xaXBrMzZtYi9S?=
 =?utf-8?B?VHF5a1p3eFBkR1UrdzBKYk93MUZvckYyS3BaMS9mSHpMK05JZC9jT2R0VVpW?=
 =?utf-8?B?M01oVHpac2p5ZG90N2ttNEZQU1FXUnZQWUlWTUY5eS9pQlJoaWdZMDNXL1Ja?=
 =?utf-8?B?NzErVS9VSWFkakNta2k5aGwxTkxidWZ3WDNwc2lOcHgyVTd3em9OaUxkUHZQ?=
 =?utf-8?B?NmorSXVVcktrd2o1a3BtcWtzN3hxTC82ZThEbGRmRmNkZERjVWVPVWgzVm9L?=
 =?utf-8?B?UlFUWk9hdFowZXdrUFB2UmVFVlZvMUVZWjhYYXlwd09jamZGYUVzSExkdTVi?=
 =?utf-8?B?bEljZUN5T3VVT0E3dFFqejZRNHNkcUtRZ1FhUVpKVURQSVltdWNaWW5RVmw5?=
 =?utf-8?B?M3BLR0lnR2x2Ui9McGc2MllOZVF0LzRDRGV3WlllTFcvMnpKU3c0MVo1RmlV?=
 =?utf-8?B?MExRY2FRZ21zbnllbDY4R2llQ3B0Z1hORjFtS29NL2ZMbGV3bC9FSVhZT1dQ?=
 =?utf-8?B?N1dHNWl1b0ZOWnE1NS8wblIvbk9RUUp4UDdwWFpDT1RVdXRVVDJPTmF0Tzl5?=
 =?utf-8?B?Y0tueS8yQ1R4UFlNZXZEcDYrY1lhUmw3QTJBM0k1VWREYUtKd25KQlVRNWU1?=
 =?utf-8?B?L08rUXZtR1EvSE41a0djazdSWmYzbVdPQzZhMUwzcURVOTlYdzRsd2lXQ2dk?=
 =?utf-8?B?alVYUXNMNmI4VzhJbHZDRkxwUy9GbEhFQlBpaHBaekZLNkdZNXZiOVpCanVt?=
 =?utf-8?B?SDkvNTlPYVpHOFdqTWRXb3FyWkxUQWNKS211bXlwdThsWGluWFAvNWxrcTR1?=
 =?utf-8?B?NlB1Z0VZcVRTdXJFWlJCUzRxVWlETXhEZEc3VlBwRUxaYlJmVGQxOTcvNHE4?=
 =?utf-8?B?eFluaGpGbnBRSVY2RVUxd0tWQzFGY2lHUGt5aUZ4eU0zQ2UrVVRmaEhjaHha?=
 =?utf-8?B?YVBzSmdsTEkrK1lGWnJuMjJyMDBOd1c5RWh4cFdKR2tMMEpjMmxCYklEZC84?=
 =?utf-8?Q?5LsxANRUhnoY+BvSK46PQ2kMg?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf237b9-d5b0-409e-eb40-08de179610dd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:24:03.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+95xtL3gALbwPbUxGVbTTyYVl5X6vzK/HmJmmEIYdj//RYEPaJwfCa4fwCMwZguZ5rDb1t2OSt6Y6IifulSuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR03MB9475

Hi Jerome,

On 10/30/2025 4:38 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> l_detect controls the enablement of the PLL lock detection module.
>> It should remain disabled while the internal PLL circuits are
>> reaching a steady state; otherwise, the lock signal may be falsely
>> triggered high.
>>
>> Before enabling the internal power supply of the PLL, l_detect should
>> be disabled. After the PLL’s internal circuits have stabilized,
>> l_detect should be enabled to prevent false lock signal triggers.
> 
> You to reformat this description. It feel that both paragraph are saying
> the same thing.
> 

Ok, drop it.

>>
>> Currently, only A1 supports both l_detect and current_en, so this
>> patch will only affect A1.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index 6c794adb8ccd..c6eebde1f516 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -383,36 +383,38 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>        if (MESON_PARM_APPLICABLE(&pll->rst))
>>                meson_parm_write(clk->map, &pll->rst, 1);
>>
>> +     /* Disable the PLL lock-detect module */
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>> +             meson_parm_write(clk->map, &pll->l_detect, 1);
>> +
>>        /* Enable the pll */
>>        meson_parm_write(clk->map, &pll->en, 1);
>>        /* Wait for Bandgap and LDO to power up and stabilize */
>>        udelay(20);
>>
>> -     /* Take the pll out reset */
>> -     if (MESON_PARM_APPLICABLE(&pll->rst))
>> -             meson_parm_write(clk->map, &pll->rst, 0);
> 
> Why is the reset moving around ? nothing is said in the description about
> that
> 

The function of current_en in the PLL is similar to en. It's more
reliable to assert the reset signal after current_en is set high.

I'll update the commit description accordingly in the next version.

>> -
>> -     /* Wait for PLL loop stabilization */
>> -     udelay(20);
>> -
>>        /*
>>         * Compared with the previous SoCs, self-adaption current module
>>         * is newly added for A1, keep the new power-on sequence to enable the
>>         * PLL. The sequence is:
>> -      * 1. enable the pll, delay for 10us
>> +      * 1. enable the pll, delay for 20us
>>         * 2. enable the pll self-adaption current module, delay for 40us
>>         * 3. enable the lock detect module
>>         */
>>        if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>> -             udelay(10);
>>                meson_parm_write(clk->map, &pll->current_en, 1);
>> -             udelay(40);
>> +             udelay(20);
>>        }
>>
>> -     if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>> -             meson_parm_write(clk->map, &pll->l_detect, 1);
>> +     /* Take the pll out reset */
>> +     if (MESON_PARM_APPLICABLE(&pll->rst))
>> +             meson_parm_write(clk->map, &pll->rst, 0);
>> +
>> +     /* Wait for PLL loop stabilization */
>> +     udelay(20);
>> +
>> +     /* Enable the lock-detect module */
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>>                meson_parm_write(clk->map, &pll->l_detect, 0);
>> -     }
>>
>>        if (meson_clk_pll_wait_lock(hw)) {
>>                /* disable PLL when PLL lock failed. */
> 
> --
> Jerome


