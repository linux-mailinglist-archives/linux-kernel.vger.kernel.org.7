Return-Path: <linux-kernel+bounces-720694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CCEAFBF58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E772317D207
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1AD1C6FE8;
	Tue,  8 Jul 2025 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b6woKeqs"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379061C5D53;
	Tue,  8 Jul 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935395; cv=fail; b=Ar23MxmajXxphWabHxHaFl4MhpsDLOs3t44cZm0vGCGj3guFrLkH/gUGHgb7MWvPJnwYTMGAuQe1JoxZn0t8uXR7gcH+eDTxoNJr3n8AvXg54+SdgugYLD+w7iOzQjGUu8VqJtQRRgNcnGVINlNXmIutVc7s/Ew7XLZyGOqXVjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935395; c=relaxed/simple;
	bh=dLnytPCH0pqX+1/Pr+537gWpIvaz31q50HdnHwgUcrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDx0N9dUF9rU6SOllEzaFxNLvQZF/yQCFHAW++erTo6kcFq0RAQ0O8w5eF6LcDBTTxOv4tuRbp29lTNG2lKYggigk8nXRMsFIFUpWoMPR0sU1pIGXSZWht2QObW8RticpEAo8o4GaPrhkS67q1fpbYXxZGFjUc+IIswZzAmkKzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b6woKeqs; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEzoVjRhnFqmHrU77I/n4XwzDPBFg4puycKP2lailYjLAtSJN0jh5pF54yPx8tJV5alyb0UnzwWt6PjvRz5bFNwt1EF92k2Ve3phT03PR85YJgW6n/WZzcMqIF/DeYGLlkhuKLE2hTFb9mb7d8SiSBWlfgjxAcSsFPkkZZNd8I0AiXZS50+mBdeAJ02y9b0qAui6xBniEK0vEF4mhh2Znqcb/JU0La+McVPA0CjLda1TG1zduzjrGMdKLr7pAnprTcg6KFmnA3zA37UGJpCubqgBkrE1ZEsd4/6l+wr5DE0a4oAmoX7ncgbS77P6zgxe9H6SogKJtGybzU9JD5r36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IPWUi8ZHTc9SxDRZg+IoMRuZ3SKu+eE26rIxGJpYp8=;
 b=aL+JtmmhGXrg4Oo7dLkJt/oZLFqhrauNW5QAX+Fc+rGnLAXpEgnwTadsHH0FVFT4PH2rDRebrc5nt3YVfd+U0nRmh19MhbKRRZyQ3Y1bEmPwsMtuQGdEO1nWtadglt1t17e7fyJ9i53sBEIooUZ3Pkc/aW9sVODb74I9urh7MRHw90pkq1xfg449K+vJukFpWIDdVnHIWNNb8uOwgg46eoLvc9UqGoixe56j7ywpJSFSLzMY16kiCoJhxpPUIHpfR8ADatozIJspLINx6xZ9LPowcyxTSe7ROmokjkDsOWJ9Qlct+Lb9c6V5aHXZrXGqxEz3Ol0FjG5PwXmKReUsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IPWUi8ZHTc9SxDRZg+IoMRuZ3SKu+eE26rIxGJpYp8=;
 b=b6woKeqs6pssm4ckUWA1Bdg18y2ova5MU6z4iWFS93XDG+POFdLS+qR3p0HUSq6xpT6rylSPrbztBQ+abbHnKuhPcnoAVj9f1WgPXvQIgohiPUjeM5Bz2yCEVsktrvGd9EpgIF6ly4HfIZfMQkreu2ceZIdZHz6CSEVmFNJ4Kr8VhhcTwaIuPSg1oSt5DaKy+PIZnO+M/y5BUrS4h2kyTkcrRXwf65rEBFPuFBQn2exDiLfTFv0t0JpAGJuPNl1NjSD/NBtXVLMs9NRo7ZYrRMV7rzgaNdFr2DGUtSdT7AgcgDW2UjhzhUfRsJZ+sMspsWEMgifN68EUYYllLDXnbQ==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by PN3PR01MB6376.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 00:43:06 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:43:06 +0000
Message-ID:
 <PNYPR01MB11171089467590C57736F415EFE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] riscv: dts: sophgo: Add xtheadvector to the sg2042
 devicetree
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1751698574.git.rabenda.cn@gmail.com>
 <915bef0530dee6c8bc0ae473837a4bd6786fa4fb.1751698574.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <915bef0530dee6c8bc0ae473837a4bd6786fa4fb.1751698574.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <c3e92306-f912-4491-b3bc-d595a6fcba50@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|PN3PR01MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: d869cd3d-9546-4daa-6bb9-08ddbdb8675a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|461199028|6090799003|1602099012|3412199025|4302099013|440099028|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHRtL3NXaVBGM0hEWk50MEo1QkxnZHZ3U3A3cjg1QkxEN1lVc0VML2c2RTZq?=
 =?utf-8?B?bDNaZXlnRDFTNVdVL1lIQk0xMmpJb0t1TDVCK01oWnBzYzlMRmduUTlET3Bt?=
 =?utf-8?B?c1A5NE1vRjNMTEhtbzNWNzdGaFN1TXVRaTVNQlZtYzgyaWkrMkhMWnhQNXBr?=
 =?utf-8?B?QTc0UU9haXA2b0JnblRDT1FvK0twSHQ2akt4ZGRlNms3QWhqYUJFU2Yyd3VU?=
 =?utf-8?B?VTByMXNpRCtHTkpPTVZROGhaQ2U1MmJNT1dSelBGZU9FVFBXNG5Qb2ZSaEtj?=
 =?utf-8?B?dmtlcVJ1eWZFdEVtWHA0N1VmL0R2cVpxUnVNTEltdTVoVWhnb1FRVDRqa3A5?=
 =?utf-8?B?Nk53VlFKNFQ2anN6M04walIyTGNyQ1MrQnBZdG9DUndSTUFTYUV1UFV2L2RL?=
 =?utf-8?B?SzhscDJOcWFTUTFHUW9tQU9sMHhZcDA2SW9OMHZtUC9BUktNZWl1NUdESGw2?=
 =?utf-8?B?MXZXS1lpb0pkUDkzVUtHN1EyeWJiRlFHTHJUTVJzeDRZc2w2QTFhSG41ZEM3?=
 =?utf-8?B?VE96YUZhUDZiMkxpL1VyREpVd2I3SGg5ZGx4anB6cmFYS3NOdmpiUUFtM0Fj?=
 =?utf-8?B?aHpvUy9LNGJUbEt3Y28xUlB2SUVmT3Z2Rmt3Q054VnFTUVhvOTg1NWtNYVFG?=
 =?utf-8?B?RUtJLyt2Y0hJejZVNHlwTXlPOVRjdDdjRjlXVFVBUHVObzFTMFBiK2pwL0FK?=
 =?utf-8?B?MUxXRUVnelFTR24zVGJpdVJNcVRhcXZFdmg2OTUvVmQzdWVLc1Z3ekFLNUdD?=
 =?utf-8?B?eG9PdFE0N2ZUdlJMVCtOam0vL0pFVUYvdjdEa0hyeHhSSm8vNTJMKzd3cUhF?=
 =?utf-8?B?WDdCTUQ2QXJoODd6bnYveTN1YktyUUdVTjFzZmZTUENXVWFlOThld0VyaFpV?=
 =?utf-8?B?elRVdUs4V2taQ2g3Y2k2cmE0bkRuaklZUUZTblpmdlJFUlZXcDhOKzV0NVY5?=
 =?utf-8?B?RkFXK3lDd0pGbzdOcWd4M1BqZzFmR1RCUVVEMnpZRWVJVU1ZZ1k0cUtTUWNa?=
 =?utf-8?B?bktTYTFCbWhDYVRjU091Q3QxTXBiQmdQWWYyZVdvWjJxUkpNL3BFSHF2azhv?=
 =?utf-8?B?RWd1VVU4RUZjZmlUWU43VGZDQ1pjMWQvcSs2TlNpVE1KczIwR2xKemxGQ2Vj?=
 =?utf-8?B?d215bXFDR3AyQXdNeS83d2ZNSlA3MmRyVFF1WmE3d3RHZDduc1ZMeWdpcTFR?=
 =?utf-8?B?aExoZ1JoTk9tL2FDOEFhREl1aEkrR1JQakFsM2NuZit1ZGRsYmxPa2Fsc01R?=
 =?utf-8?B?aytnSXhiMldqQjJneW54Sno0blVwWTkvVXZZcmNVVkRLZlU4ay9tU1p2d3p5?=
 =?utf-8?B?M0taQW4wYkg1TVpJSGJVSi9HdjRZMFBSbDdpcHZhYmluaTc3QWxCSmlXdHFC?=
 =?utf-8?B?a1F0N0JOSVZsbzE0eFlmMWpMQWt3ZGlZcFROdEhQcGwwY1I5R25va1FSbDl3?=
 =?utf-8?B?czBQZXJwdUJZaVNSbUFOKzJubGVyVytIcytqZmJwWVBDVXJGbWtxSEhWeWMr?=
 =?utf-8?B?NWlQTmdSemV4dDNTQ2s0eXBpOU9wZGpUdVBOOHhHYmRyeHNKbEdSbExhZjRG?=
 =?utf-8?B?WUszbnlhSVpkVytLVFFNUkNlVnIwZFpEOTJ3b2FkeWltbzFSUG1GcTk2M0FJ?=
 =?utf-8?B?OU5xK2RnTWxZRE5NVTdySEtPbWswV2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxiTGx6Vi9NSlRNZk5menZ3SjVXdEd0QUFzdmFKOEt2QlBLT1Qzak9BMGtX?=
 =?utf-8?B?WFRTa1JTZlYyNlRPQnU5VHRYU0dab3VJenBoTXNLSnFuOWhBNm9hM2N6RkZG?=
 =?utf-8?B?UEk2bkxrNFQ2bUd2NXhMVWNPWHRBaCtYckxQREpJVEwybElOTXliUXJRbnZY?=
 =?utf-8?B?VXNDbkFBZUdQNXhndW9hQ3UySE9nOXVraDViS2F0WjB5cStObGpKTDZwYTA2?=
 =?utf-8?B?L3gwbEs2TXNvTnZVQVJjMURPSmVtVWJSNDBDNFlVT0NFMlZwUVIxMHFZTURv?=
 =?utf-8?B?UWNuTTVOTVRJUmVvc0N2d2FrakwwT3pVSWxyMjBITjJtdW9nWnJoWldqUDJ4?=
 =?utf-8?B?WHN1QUR2R0hpYkhnRjZUWTlsTS84ek92amVHZi8yUDBYUWdrYStDYmFGU2pk?=
 =?utf-8?B?cFhZa1VBUWZIVXVQeDVuOTVaMHkyMGhkN253RU52VURlMFo2Nk80UzRjZU0v?=
 =?utf-8?B?M3g1NGxZdEN4T0U4Tkw2OVR6ZVR3a20yM29EYzJlSUFpclM1ZW1DWW5xQncy?=
 =?utf-8?B?MGpIVmRZLzRDOGllTkkwa2t5RW1Xd1BuT3g5MnlraXBNQVYxVUgxM0ZxanRJ?=
 =?utf-8?B?MWZuN0k4U3gxTGJ2cTNtMzgrcXFNc3BiRjE5WHFqbE5UWlR5Qmo0ZVV0cy90?=
 =?utf-8?B?VWNWR0VhZUpuTjNPNGZGOS9ybmpwQnlzd1gwZ3A1MDk4OCt3d3B2VUJ0MGE3?=
 =?utf-8?B?QU14S0t4MGdDQ2wxZFRRTnNVTnpJRWIvcXJoWnhDUjFxQzE5YUtRTDQ4K2hT?=
 =?utf-8?B?RW5DN1JSaFBxRlhXN0JjV1BjWHJIbmRVYzVmaFprOFlWaXhzQkU2UUwxVGlH?=
 =?utf-8?B?MEs3WFBtN01VdytWejAyYnlweFFHdDR5TEQzV0RSWW8xenJQeUhJdDRWanJL?=
 =?utf-8?B?L2Vab3FTRHJrTmVIaDNZd1pqVVpDZHRpVzFWMVZ1OUVwN3NBVGhENlhyTElT?=
 =?utf-8?B?UjE1NUwyQVkrSzFJcVNrSWdxc2NpQnRZcFVtMmZ1RnpJSHR5OVF0NmhESFNU?=
 =?utf-8?B?NzRMeGJZMkdiNXYrZUg4UnhTZGdqcVVwWGdZZk9kS2pkS3IrM04zYWRlTDV1?=
 =?utf-8?B?bWtyRXJLZFdqN21wZHVxMG0vaXB2ZC85VU5lRmVHc1VOeDRZdTBVb1JyMnU5?=
 =?utf-8?B?M3ZKQ3l1Ym1xeEI0eFhad3lXTjd5YTVnQ0cwcmJlMkpGWXU0ZFJQZXVhcVRL?=
 =?utf-8?B?bWJBVlBjR2JVUFdPY29aZXdPNFBqSGZ6YWVOYkx3VURTS3lwNzJqZ1VhYS9Y?=
 =?utf-8?B?ZnE3WHF0N3JwY0lrQkZqY0Q0UXBtaTFxMXlIZWhpb0FWYjVxOVNjQkt6SnIy?=
 =?utf-8?B?TEE0Z01Eczd3WjlJWjBieHhMeHJITnZOTGI1WmlweVBTZTZXb1FyajBkNUc2?=
 =?utf-8?B?L2NaS2laT29zSytnYkt4b1VvYWRIcVRrUEN5KzlPZTdubVplRTFmZjlqa1pH?=
 =?utf-8?B?T3JLbmNTR1dCRFhBY0tuMjdrbmF1bWoxbnh5NkVyVUFBZVJtNWZBN0hDeCsr?=
 =?utf-8?B?aWJtYmV4dEpIWFlBK1Z6ZDBEYWorV2l0OW5TMW91dzk2ckw3NG90YkI1S3k0?=
 =?utf-8?B?VmlKR2NtNU5WMitFZmQ2SlRYUEpXUVZIeVkrMEovcTh5WDAwVmFXZWt1SmYw?=
 =?utf-8?B?OE9LWndRaEI3TmNNT1IyRXFOMjBBbnRPcHYvbnMxSEVkaWFHL2JSVWhabzJR?=
 =?utf-8?B?SkVnRjg2T0czVHZOTmo0MFFLeVdRQks2blk5UUh5THozNDJRRE5oeTRvYXQy?=
 =?utf-8?Q?aLD1plUo5IGPGZz9zwSk85oAfvxSsYohFz2TG4J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d869cd3d-9546-4daa-6bb9-08ddbdb8675a
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:43:06.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6376


On 2025/7/5 15:00, Han Gao wrote:
> The sg2042 SoCs support xtheadvector [1] so it can be included in the
> devicetree. Also include vlenb for the cpu. And set vlenb=16 [2].
>
> This can be tested by passing the "mitigations=off" kernel parameter.
>
> Link: https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-4-236c22791ef9@rivosinc.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/aCO44SAoS2kIP61r@ghost/ [2]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 192 +++++++++++++-------
>   1 file changed, 128 insertions(+), 64 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index b136b6c4128c..dcc984965b6b 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -260,7 +260,8 @@ cpu0: cpu@0 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <0>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -285,7 +286,8 @@ cpu1: cpu@1 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <1>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -310,7 +312,8 @@ cpu2: cpu@2 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <2>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -335,7 +338,8 @@ cpu3: cpu@3 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <3>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -360,7 +364,8 @@ cpu4: cpu@4 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <4>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -385,7 +390,8 @@ cpu5: cpu@5 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <5>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -410,7 +416,8 @@ cpu6: cpu@6 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <6>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -435,7 +442,8 @@ cpu7: cpu@7 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <7>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -460,7 +468,8 @@ cpu8: cpu@8 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <8>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -485,7 +494,8 @@ cpu9: cpu@9 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <9>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -510,7 +520,8 @@ cpu10: cpu@10 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <10>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -535,7 +546,8 @@ cpu11: cpu@11 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <11>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -560,7 +572,8 @@ cpu12: cpu@12 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <12>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -585,7 +598,8 @@ cpu13: cpu@13 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <13>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -610,7 +624,8 @@ cpu14: cpu@14 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <14>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -635,7 +650,8 @@ cpu15: cpu@15 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <15>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -660,7 +676,8 @@ cpu16: cpu@16 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <16>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -685,7 +702,8 @@ cpu17: cpu@17 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <17>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -710,7 +728,8 @@ cpu18: cpu@18 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <18>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -735,7 +754,8 @@ cpu19: cpu@19 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <19>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -760,7 +780,8 @@ cpu20: cpu@20 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <20>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -785,7 +806,8 @@ cpu21: cpu@21 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <21>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -810,7 +832,8 @@ cpu22: cpu@22 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <22>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -835,7 +858,8 @@ cpu23: cpu@23 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <23>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -860,7 +884,8 @@ cpu24: cpu@24 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <24>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -885,7 +910,8 @@ cpu25: cpu@25 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <25>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -910,7 +936,8 @@ cpu26: cpu@26 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <26>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -935,7 +962,8 @@ cpu27: cpu@27 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <27>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -960,7 +988,8 @@ cpu28: cpu@28 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <28>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -985,7 +1014,8 @@ cpu29: cpu@29 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <29>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1010,7 +1040,8 @@ cpu30: cpu@30 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <30>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1035,7 +1066,8 @@ cpu31: cpu@31 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <31>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1060,7 +1092,8 @@ cpu32: cpu@32 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <32>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1085,7 +1118,8 @@ cpu33: cpu@33 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <33>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1110,7 +1144,8 @@ cpu34: cpu@34 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <34>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1135,7 +1170,8 @@ cpu35: cpu@35 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <35>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1160,7 +1196,8 @@ cpu36: cpu@36 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <36>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1185,7 +1222,8 @@ cpu37: cpu@37 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <37>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1210,7 +1248,8 @@ cpu38: cpu@38 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <38>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1235,7 +1274,8 @@ cpu39: cpu@39 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <39>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1260,7 +1300,8 @@ cpu40: cpu@40 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <40>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1285,7 +1326,8 @@ cpu41: cpu@41 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <41>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1310,7 +1352,8 @@ cpu42: cpu@42 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <42>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1335,7 +1378,8 @@ cpu43: cpu@43 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <43>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1360,7 +1404,8 @@ cpu44: cpu@44 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <44>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1385,7 +1430,8 @@ cpu45: cpu@45 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <45>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1410,7 +1456,8 @@ cpu46: cpu@46 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <46>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1435,7 +1482,8 @@ cpu47: cpu@47 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <47>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1460,7 +1508,8 @@ cpu48: cpu@48 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <48>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1485,7 +1534,8 @@ cpu49: cpu@49 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <49>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1510,7 +1560,8 @@ cpu50: cpu@50 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <50>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1535,7 +1586,8 @@ cpu51: cpu@51 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <51>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1560,7 +1612,8 @@ cpu52: cpu@52 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <52>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1585,7 +1638,8 @@ cpu53: cpu@53 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <53>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1610,7 +1664,8 @@ cpu54: cpu@54 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <54>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1635,7 +1690,8 @@ cpu55: cpu@55 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <55>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1660,7 +1716,8 @@ cpu56: cpu@56 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <56>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1685,7 +1742,8 @@ cpu57: cpu@57 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <57>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1710,7 +1768,8 @@ cpu58: cpu@58 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <58>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1735,7 +1794,8 @@ cpu59: cpu@59 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <59>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1760,7 +1820,8 @@ cpu60: cpu@60 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <60>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1785,7 +1846,8 @@ cpu61: cpu@61 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <61>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1810,7 +1872,8 @@ cpu62: cpu@62 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <62>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1835,7 +1898,8 @@ cpu63: cpu@63 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <63>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;

