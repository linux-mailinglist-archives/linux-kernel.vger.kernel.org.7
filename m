Return-Path: <linux-kernel+bounces-892343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 933BEC44E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B2346447
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F89120A5E5;
	Mon, 10 Nov 2025 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="UK+sfK3b"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023072.outbound.protection.outlook.com [52.101.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508464369A;
	Mon, 10 Nov 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747529; cv=fail; b=N8UIcEw6Vzh4zo09mWLeCZDK7ZNG/7hpzVYhBbfjj9HBg15pn9+Gg7si86Pcz8se4tmR+Zw7QPm3rx1sTyltk0a0oSJAYY/OhjZf2yCzzcX4I/ttdQa3X5SV8VzbUmIgFDGt6wdjO0AnMHiwzqPOY1dmNDbnz/4r0+MZDSofHyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747529; c=relaxed/simple;
	bh=CJtIA/kDivjR27PTSyynDhBdvQXaPKmbWJqFsKR25As=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=orQ+Gj88fmmCDkLNw0lilxAnF70AnXOpBKPZOcWoIoWg7f8fv1qi+Q1zWmQwcwmKjI3NJzfUN4xHGTUgJX+SXO9MtUI1XadXMYbsj/DfR3g5dfRK2cUuMGj/fJJ0WmkVn9VOha0qc1o+qv+bVqBwqx0JBbDZebUbAGVuwURAf/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=UK+sfK3b; arc=fail smtp.client-ip=52.101.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy66GcJBlyGFi1Yo5Kvj+ilNTM3Ab8r8EZbV1KrAtT8Y/krAWPOykrV6+dAqCoopZ5mqxFe1Y5e97HPqzsgJtdz0ZQJmjKYLOX9ASpqWAywiVGEJlZ6ACXRfxSBl06PZYNxspxQuFzZXK/yo2q/SPb6uMb1P4JNDh7VMxkmZPXVjY0iaJLabq5eASKhAwbEY2256+M0RwktAL8ed7WayguZVsM2u50UAJnHoFr0HJjpQTzPAG4UuUV08GRJPulQVEeWxKl6PT1A9kxrv+6Dl1dhI9VvTk3uXSlS8z8BTYX9r3fTFTPcVo94Y1Nk4/1AEfG1Cn5u0S1DHjyqM4vGgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsSCaaiJR1tn9nPg2L4vWhKa5HHmyrMz2mChlJgFSdo=;
 b=QrsuiHv3PG8W36ougWcFvc7uDIt90THUftu7invJDETu54mWP9bCyyCHHmkyU2o3IN/rn6F5NeMYg9Rmur+msynZZlMbDojvIYTukP/G9OQq1IpNuRYmANHottrbOFCLQ//Tx9yVB0eFSIJXvC0Y81EbAuQh/S6MYeFEh6tU9XtQ5dV0zCc/WpEe86pypg/inV24uAHBVb6fl/QJKBNStteNcZKQwcMCpH4vB8VT3fUcaNFHK6OzRaBiPCbutVsVvl+HBaP8udEGGLap2BxJOyfak3jFHYNi025L4dbHi0wUWynE7fX7rQEMh41tHPMg4x/+kasM1uDC7N6nCu1MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsSCaaiJR1tn9nPg2L4vWhKa5HHmyrMz2mChlJgFSdo=;
 b=UK+sfK3bvbOWMDh82VqvFYiTFY0i66BJ8x0suYhxSDDMxsZ3QyzCz0BIC02qMeoIQwpWeBr+aPNGYi+o+rgghyDi/U12yfILGAB90L5XmOKlhTpo/eSQEMNuoBTGkSPA+oHlhcO8QPTVd3IIHURgHmsYFcBYfwTt/K8rafpM8Cs5KXB+xbhsGZstBRfsnpS252jDhSviEYSCJsj3fCNMm9LUI9Ls1QB8NtQYrd++V4Q0iGk72V13YOzcCwcpgBVOn2SwcB+finaNfJUXyyWY6A98+wjzhzQCyRl3bd9mYUbpZ8OwUFxkZkoI65KpVuEWemZc023SVlC0L0xlYFiCCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com (2603:1096:820:51::12)
 by KU2PPFD33A87D41.apcprd03.prod.outlook.com (2603:1096:d18::427) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 04:05:24 +0000
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e]) by KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:05:24 +0000
Message-ID: <56b943f0-d6d4-4210-8fb5-453326f277ba@amlogic.com>
Date: Mon, 10 Nov 2025 12:05:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] decoder: Add V4L2 stateless H.264 decoder driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
 <20251027-b4-s4-vdec-upstream-v1-3-620401813b5d@amlogic.com>
 <CAFBinCBy7vPq0oX0PQ=yC5E3Mx3sv6qdVHsMh-NQQzAkbDuvRQ@mail.gmail.com>
From: Zhentao Guo <zhentao.guo@amlogic.com>
In-Reply-To: <CAFBinCBy7vPq0oX0PQ=yC5E3Mx3sv6qdVHsMh-NQQzAkbDuvRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To KL1PR03MB5521.apcprd03.prod.outlook.com
 (2603:1096:820:51::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5521:EE_|KU2PPFD33A87D41:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e5dfde-cc8b-42d5-ae42-08de200e5f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0p2UHZQSDBPdWVKVXdpL0ZqTUswd0piam1qcmduRmpsdDlleWFBOGNzOCtz?=
 =?utf-8?B?VTBWOEF6Yml1eGhQYzdLbkdSTkordEhzS2hPNEZtOHlaMzZrcHROcTRyVDZ4?=
 =?utf-8?B?c29IZUg4UStkcE1teWkrUzZRVS9ZZ3JqeHhXckFFckpNQzluTG9kbXBCY2R0?=
 =?utf-8?B?VHNGNkZPbFJVaGNHaVp2SG9wS0swbDRyaHMwZ2tBS0J5TlBwanNHeEVDVWRa?=
 =?utf-8?B?Y212UUl3ZG9qaFFFTG5zL29GWTNkc0Yyc0g5MVFCU0lRNFJpK1N0OW9CUjZY?=
 =?utf-8?B?NkhZMFhVcjk4cDRjaWtwTHF6ZnRjVU81bHNQNjN0SDRxVi9FN0xMTWt4TUxv?=
 =?utf-8?B?Rnp1RHc2ckV0R005Szg2VFl3T0FycnFSMGgzOStzUTBTY216MGc4MGpVTzNj?=
 =?utf-8?B?bnNwSjJsYS95OERsa0laQ0diVHN0Q0Izc0ZER1MvQ0IzRm9kNFN6Z25Mc01E?=
 =?utf-8?B?bzZadmxOMDllZENOTzVsUU1XQ3JYY0VPcGx5UGVmTWlpSGdvVjB4YUxEdkhw?=
 =?utf-8?B?SmdUSHRZQmZnN3JyUlBTVll3VHpxNC90SnZ0Y1RoUzdnNUFmNEtZN2I4Q0tB?=
 =?utf-8?B?NWhBdWl0eXlPNUxRdXBQREgzVzVlTjExRTlpeXU2cFh3VjFlYjVJS1hoYVo3?=
 =?utf-8?B?eUJTbUYwRzhUQTU4aEJrMVhvRWpxM3hub1U5TmpaUHBHU2hsZnNYK3U3Q3I2?=
 =?utf-8?B?QVMwb282WVl1L1drbml3RUVpbmVXbU1UWDQyaVFHUXF0b21udXBYbktpSWM5?=
 =?utf-8?B?MWJjQnBoUUNFRDVDZ0ZXMlRmeTVTY1RpWURCbFZVc0VUZ1QyRnBjTjhCa2hE?=
 =?utf-8?B?d1l2bFUyNTFlcVZhSW1BUjVmd2ZrZ0k3ZktqbnA0NkFFcCtvemxpL0FUVFVu?=
 =?utf-8?B?czQ3R0dnTTg1ekpQNUlBdlFGd0VjQ3JRd3llNHJGS0dlb2lwQy81T3hCc0lE?=
 =?utf-8?B?T0xTK1JSSGJwakJBVFRVd3ZQUW5yTlY3eGxtMHk1emxRdmVOUDdGN1FzUzYy?=
 =?utf-8?B?S0IwaDRmeTlVVUF2dnRqSHNCQ3B5WWlPZ0IwL1JSNDBNdFpPU2ZCV3NiRXhM?=
 =?utf-8?B?RW1Mc2ZWWi9YVnZ6ejZpQTdmYXl5RUQ3TlovZERIT1FUVFZScnRlaXVZSkxH?=
 =?utf-8?B?ZUdDVysxcmtOdlpKa0s1RDdxUVE1WnNCT3I0dEZVdCtDOWsvd2lJQnltc2F6?=
 =?utf-8?B?azhrb2Yva1dLNzJyV25KQkp1S2M1TFdFdnhWUlN2cFVXSTNwdzc5R0c4SVlB?=
 =?utf-8?B?UEp2SVNSdWlCVkFvcERzWEhMZ200QUxYdGpYSjlIdXBQbXZ2ZFNGQlE5TSsy?=
 =?utf-8?B?MnhYOWd3YUJMdTFMUXhUclkzUkZXK3hwbURZQVlwbC9Va05TSURuNEVrNk1k?=
 =?utf-8?B?My9UTmtySzhFM2R2MGFFc1FMdEQyR2Y5cUNOK2J5cWQyQ3dsRHZyQTlzY0Rz?=
 =?utf-8?B?UUVoZnhyUjhYWng1b05EaEErUkozQ2xtSUx1SWlOTS8wcXlCUm5BR0t6Qmh0?=
 =?utf-8?B?d3ZCSjZ3WEd5T2VqdlNpcnFjRk1ZZVdYOW0yM1FkaDUyZVV1UVg0QXJmNUho?=
 =?utf-8?B?R0V3R0daR1libVJMWGRIOFowWFRwRHg5d1FMVjEyVEtVdGsyNWZHQVVBNDdT?=
 =?utf-8?B?ZW9MZGtTUVd2SHRLU1BvVlpqaUFjdWNWc1NEcVByS0NrdDBZZktHdXVWTzhD?=
 =?utf-8?B?bjRqeitRQ210cUNSU1FnTmxZMWloNHYxcEYrcktxbGhDU2cveDBSZjVaL2p6?=
 =?utf-8?B?SUNLenB5MjNvTml5QlB5Sk1TQTY1T2RKODFhcjlaQnNpMUJhMlh3SXMxWFV1?=
 =?utf-8?B?bU4veG1vd01XS0tBNHFWSEdPVjg5Y3lMMGdFMWgydkxLeU12YWJwMC90TG9o?=
 =?utf-8?B?U0ZVY0MyV2hrZmdkUm90OWh2MUlacWVGcE92Y1RvWlJtRDNINThJOWU4K1ll?=
 =?utf-8?Q?Fay6/usCqYqoeYzd7+1bNXM2AgL6vLBe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5521.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2dYMEZlUHFDNWkyeGw5WVN0dE90SUpNeERkdHhUVEszNUpLM1l6NzBVRXBP?=
 =?utf-8?B?QkZTaXpKUTJxL2NSNFBlamdKRkhkUTB4VnJEVi9kTXZQcytBRHBjbTQ4K2VI?=
 =?utf-8?B?REVwZTJVSnJCZmJGUk0ydHpROXZVaFV6Z0hxeDBvR3pQbDFtTys5ZVB1Rnlh?=
 =?utf-8?B?YnZhU1pVRG04QlVtWXc5bnBDUGpWbFVMVHNhb29iVWxGckk4bHBLT3lXZzls?=
 =?utf-8?B?K0tCV2NIajN6SGdLbnliOHh6RkFTNGZ6Z1JMSlBuL3pZUkl5c2ZJTUtFTTds?=
 =?utf-8?B?WG9Pb1daM1ZWSjNXNWVDc1VocDU5TlBNUHR4VklFZ2pTZHVSMWNrTWl0MHpW?=
 =?utf-8?B?QjBwbFRuU2VScGNwK215MUh5Y1BERmNiTGJNeTg1VmF0SjNJakdNTzh4L2kv?=
 =?utf-8?B?MDZ0ZWpNejFOaE9pVjZyREF0RUszSzR0ekdUdWhPcGp6cXVvelRVb0YzazdI?=
 =?utf-8?B?RW95TjRuMGVVWGJ4bk55eDVXWStCYTJtNitpR2p0ZXBxSkc0OXJTenZGbllr?=
 =?utf-8?B?clhvVUZBVWo4YlN1SWFmcUhhcEh2T3g0Z1BjaUNubDM4S0lZSERpUjQ4SjFK?=
 =?utf-8?B?elkrV2VWRVdPUWtYK2czSVRxUXRUL3hZcXdVWkhNb2VvQ2NaQkIvMGxCZDYr?=
 =?utf-8?B?a2FuejhPSGEvRVhFUzV3Vm13Vlc5RGxhcGVOcEtLZHF4MXFKRW44KzdpNHpH?=
 =?utf-8?B?RnRUbklxWllYdGhWcWZUa2Z2ajlDd0R6YzZwWjBpcUlnRHRmcDc0NnpSRmhY?=
 =?utf-8?B?V2wvcmN0a3JOZFNLZXFpZ2ZVcWV3WUZualVwaUdiSnEvS2xpNERqa1B1UUZO?=
 =?utf-8?B?VlA3czkxS1BnTnQwdmNaSzMrN1pCeGdXMll1b1VERS9ubTRHTHJKbkkrdW5r?=
 =?utf-8?B?b0poZDIybGFwVkZ3cHlyV3U0aWpiS3dLdkNrYzNQRGxpRlhQNWtTTGozSUlJ?=
 =?utf-8?B?cDlIb0hFazBuUGp5MU9oeDdVY3V5SXRxaE4ydXVvMFNkbjBsM08ySXByQTla?=
 =?utf-8?B?MDlmTFM2OHR4TjVjL3F2cWYxWEE4UjhjWXhiM3p4TDE2WXAvcm1wQlpscUJw?=
 =?utf-8?B?c2RoUHdOV3BzbUJjU1J5VDJPMXBVR2wwRkxvNFlHYjd5blpjK0VCT0lwTlpw?=
 =?utf-8?B?NTJBOWl5TG5ja24yT2FtS3YvNkFLQ2p5MjFSUG83ZUhCOGNJelN4QWhlQldO?=
 =?utf-8?B?dG9OZFhuWlQrRU1zaURIUFZDVUFOblE2SGprSXlRaWVrTWM2Mk5kSTB3UFVQ?=
 =?utf-8?B?RFkwbEN6ZnRQR3AyM0RIc3JnWHJQUk83dUhQdHRxUW0rUmtpWjgrMUlLYzhN?=
 =?utf-8?B?ek8wZHhJQjYwSUhoRVNOdk1sVWFQNUxoWHV3aHdGTWk0bG1xdWpSZlc0TzNU?=
 =?utf-8?B?NkVzZHplNUlRTFdrb3hYRVZVNk9pTmdKQ3FRRXZMcGRJVGtoMDV5dW1mQnBC?=
 =?utf-8?B?UFpWZ2I1Q3BpdXJLdGIrT01NRXdrSDJVdzh0NnF5UU8yakVjZ3ZoU1R3UDd0?=
 =?utf-8?B?Q1dnZ0xBTm8yeWRoM0c5K2xKREtZZ2JtdzJlZXZJam9EREt2U3N2SktUM1JE?=
 =?utf-8?B?eVhpdFJreFhOSHp2SFJDZW1ZcFJYbGdHMllQR2s0NUZ0VWswZ0RuYzREVnQv?=
 =?utf-8?B?N0hoaHYwL0VTUmhNVjBwMlFlbWVSQllZQSsvNWxKdFZVbnZldUxzaVM4MElx?=
 =?utf-8?B?VDNkUDlrSHFueGcrbXlLczV2VUdHNzBDTWNtVWh6VGVKY3NEYVRLSkZWc2ZX?=
 =?utf-8?B?YXhrN2NRTllzY3FYaVA4dittYTlsNTZyaHcwc2RXdS9NcmdMcFVyU1BoTllF?=
 =?utf-8?B?dzd5YVcrZmFhZUg2M2EvYkY3Si82c1M2NldMdG9XeXNJR3pCRko1MWYrMnJU?=
 =?utf-8?B?aFcyMzRZek1JNTJNcGFDbGJCNmo1blFxa1FtRHZldzUvUERWL3VRUzJkQXY5?=
 =?utf-8?B?NUE4dVNLT0hFbGtXZEYyUWtpa2RFZ3JjbHhyUm1sdHN1cFFtOGM4UGZ5WWcy?=
 =?utf-8?B?MnBvNDNYTVRCRVA1WFBQanN4eENMQUoxbEtjTlRqQ3MwYWtaZ1cwamJ2OVkw?=
 =?utf-8?B?TGtYcUF2WTdYMjZNQmg3eHFKcFdEblBocnRXYURLK0QrTk9NWFpGaE9oZU9s?=
 =?utf-8?B?RFJXSGtDbkdFNEN6U2ZwRjBzZWNEVHAzZWZvQ0wwMW16ekVjMzhRVWtOLzhi?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e5dfde-cc8b-42d5-ae42-08de200e5f94
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5521.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:05:24.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +US+0ovlp/1sRDvjzg5bbLqwuUGgMju9q0S8A1AjRM8mIBZSwrqKrt9F9zV+cSr/cv6gXnEZaneYKScY4ppxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFD33A87D41

Hi

在 2025/11/9 6:53, Martin Blumenstingl 写道:
> [ EXTERNAL EMAIL ]
>
> Hello,
>
> thank you for your work on this!
>
> On Mon, Oct 27, 2025 at 6:42 AM Zhentao Guo via B4 Relay
> <devnull+zhentao.guo.amlogic.com@kernel.org> wrote:
> [...]
> +/**
> + * enum aml_power_type_e - Type of decoder power.
> + */
> +enum aml_power_type_e {
> +       AML_PM_PD = 0,
> +};
> Are there any other power types that you are already aware of - or is
> this added "just in case" an additional type is needed in future?
Currently, this is the only type on S4 platform. The additional type is 
needed ih the future.
>> +/**
>> + * struct gate_switch_node - clock node definition
>> + * @clk: Pointer to clk instance.
>> + * @name: Clock name used.
>> + * @mutex: Mutex lock for multi decoder instance.
>> + * @ref_count: Curr clk instance ref count.
>> + */
>> +struct gate_switch_node {
>> +       struct clk *clk;
>> +       const char *name;
>> +       struct mutex mutex;
>> +       int ref_count;
>> +};
> Generally I'm not sure if the whole struct is needed as I think the
> common clock framework has everything we need.
> There's struct clk_bulk_data which allows mapping clocks from
> device-tree to an array in the code.
>
> drivers/staging/media/starfive/camss/stf-camss.h for defines an enum
> (stf_clk) to access each of the clocks by it's index in the array.
> You even seem to have an enum (clk_type_e) which you could use to
> simplify the code.
>
> My understanding is that one can call clk_prepare_enable() and
> clk_disable_unprepare() as often as you'd like and these functions
> will do the ref-counting internally.
> So I think the ref_count is not explicitly needed, as that's managed
> by the common clock framework.

Thanks for reminding me of this, I'll check it. The field ref_count is 
desigend for multi-instance decoding. More than one driver instance 
reuse one decoder hardware. So we think this maybe still needed. Anyway, 
we will take this into consideration.

>
> Best regards,
> Martin

Thanks

Zhentao


