Return-Path: <linux-kernel+bounces-720703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B9AFBF70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9A116FC54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A238FB9;
	Tue,  8 Jul 2025 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jex6paaF"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68C81ACA;
	Tue,  8 Jul 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935562; cv=fail; b=n/f0JmMJuOlVKar06S1eq2bBUETjOtXnNLJorbP0nwFMOeyqlmL7hjPmG9Lvr65kk/6+2/XqNyUQeCm5ZTIdABPl/0DZ70cb5q4XJMQx6y3//ZETOSLWdEyn0EMkyLXIgV5asTBla45qQBU0kfcYVc8jk5iSUOMfNWUSEymgA6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935562; c=relaxed/simple;
	bh=4H1sjjZAVG+wWXiOXsunC1WTG+F23efW8jj+MFp0Z8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GVY5NzCciitXhErbhZY/G1LzOO8e6RGa1jO+LfaCAH4hj5k97MY8vJkW7qQ360gbfW2N0qILswXga84rl853TClFYH42gBkxGtQdSgN84MkKnrVCcHC367Md6nASxSLw0RpivDv9T4NWtAymrAaBxqGKJPeZbhcG8GmrppaUpmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jex6paaF; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGZjZgJTd0nqD/rFnIl1DJsFK4/k1LKRyGSl1brxi2mIYNnC+G8cCQVzRLzvmvV5dERjAnsIKTAy9gyISo9CKpWER4Hhf78o+H4VoNPlrABikon1On7/NxASTzmmX4BIePtQZCGCYejhAeCz8Z4Poy3dMKAQ6gDlpdvW8m+5Gyf2ZNXHPguEsK3CCpxRMCdhA5am08K019UysZeFr9K17lJZ1p7FafoKHxFFnH4MRmWoOuda6N8eItAMU8PaL5OSHYFHJ6/dOwvoSzg2QbnQ2oVL1czJQb90pnttBIuAHXHzd8nMTJC1H/6MhSQH5Goa+cuj2GzKEnZOPijfLnY/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkfO74JEiDo4o35UAZK1o2tBAOBqcGbkV/snkJw/0ms=;
 b=rC+k6KuPUGBT8LqzijYm7SDWyhTebFTG8LNTrB/TCUdfipU7n4x8E0lKr9aZiJST2oTlvBXBuD+/Qdn3cHKbtScSBBD6ULjYU7qmocrYMK6AQTXa1QN743GMM6/dawulOVFcrWh70vz3U4txb5QzItsC5qhXhgZVUadhcq6rfkxzhooWt6YvkxeVE1etpi06tv4438rlLuz0I8j6FzTek+fTHMPGDkbAbdE4A2K6FGjGy72b6Vo8EDEDOx5I7ukEKhFPIFyP3XE4wxMGI0KmuHr5/AVl0QVFpR85GB2oCE5q7WCijN3Wekg+abElEaZ53H2zasFR5J6xvNlvbsnRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkfO74JEiDo4o35UAZK1o2tBAOBqcGbkV/snkJw/0ms=;
 b=Jex6paaFmwyaSQea9BWP/M38rM9gKXB2VoQpuImWKJC9zOtLINbePjMjYD6b71L4fIXi2N51qYbl93t32VB2AsHkMSwIFXDumE4Uq/BYTUnrcGBzZ/1q0ela9RsJBauRxkP8YjL8IKA49auM59FUmVJmrQ/CSCq088TwVOF6kU8mh1IkIK9ncBQnwx7b+laJacM51K/Y3PC73FvqWA/uMN4VvbkmI5wfTcetbGm+DiAnnaMJ0TfxSO4qr6MSkNleKUoVOoWNE29CqGAQIHbPACWkT00ed8v7jt/CSejr6U+13MEsfTMHVha/XrqWZSaPf6opSrQ9vvsKiJ3dtoJ6rQ==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by PN3PR01MB6376.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 00:45:54 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:45:54 +0000
Message-ID:
 <PNYPR01MB111711E425806004678041757FE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:45:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: sg2044: add pmu configuration
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20250703003844.84617-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250703003844.84617-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <326968da-e396-404f-9842-a97b365113d3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|PN3PR01MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b49784-c995-4ef5-32ec-08ddbdb8cb99
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|461199028|6090799003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBQWGdXUVUvbEt2ckk5VnhaRGhUazZUM09oU0wrRTRCbjlrN09qUG91VVMy?=
 =?utf-8?B?L3pJZDBBbmZSK2E3dUtaRkhTdS9aTW15RUx3Z0JETDJXWGtsY2YxUENxemVL?=
 =?utf-8?B?ZTF5bzlRNjJwVUZhL05rdngvQ0RXUEI0VklkbHllZVRZbllHa2JzY3pEMjBO?=
 =?utf-8?B?emplS0poek9OZFZyMkNnTTFCS29oaldSZmR5bGtzR284Vkp0V2llZzBDYlRV?=
 =?utf-8?B?TFZkNUtCTnJiY3liVE0rMTlmNGJaVFFIdUVNblZXOVdNWkZFRHV3b1U1WVFw?=
 =?utf-8?B?NlhWeHF3ODdPNllhWGlkZ0VjNklSU2M2Ky9oSHFIeXVWSU4ySXplTllHL2VX?=
 =?utf-8?B?WTZkZGRCQjF4dFNHcG1UVlUrNjRjM24vdGNFSjYxMkxUdnlISUVyY0IyUGdX?=
 =?utf-8?B?ZXFIOFNkZVA3RzQ2dzlGU2Jjem9DUEdEWUlxVFJVR2gxenhlYmtJUENmTm53?=
 =?utf-8?B?RnRnNVZUV2JXZHNCV0pFdVJ6K25BREREZTNWOHJTR2MvSnZVaDVMYzFHMHlE?=
 =?utf-8?B?ZTZLdE5mVytLUWNQUWtUdUZlTnVxa0ZJYTJFRGt1RFcwMUo0NUZ4Ukt2bXlC?=
 =?utf-8?B?MGJSSTNHaDBaTjFmSUE0NEdPa0tDMUJ3TXFHTEw2c3ExMDhkNk5DeE40emtI?=
 =?utf-8?B?aGpsMTBHSGNxUFMwQW8xLzRMaUIwWDBmd2FOQkF4ZnRsR0VhUXYwbC8xVXpJ?=
 =?utf-8?B?ZTRORXIwdERoK01KL1d3R2RWdnpoYnplL1RnZFBOZmVXdUxtKzBEREFvcUEr?=
 =?utf-8?B?eHNiTElWZ2k2aHdSTFhtNDFoMWQydkZDZFFGZ1ZYRGlOR0RiTUVxbFhDOEdy?=
 =?utf-8?B?bkY2eGtHWldRZWU1bjkzc3JwR1ZPQ21zVUlqUWs1VnZZc25BNy8rb2VTRWQ1?=
 =?utf-8?B?b0lqcDRRNzBpdUhLa3JxSlVqbGRGdGkxTk92ZkUwWEtYcm1sYzIvbjJWL2hr?=
 =?utf-8?B?YS9XUEhDVEs0djUvVGh6WWhUV1NpSFB5MWJneXlFRW1wK3JEVU1teUo3UnBF?=
 =?utf-8?B?OUlKaU5idDhrQjd4dVcyUTJVVks0aDJkK250TkJ3bFlkTUliNisrVU00RWcr?=
 =?utf-8?B?L01vakhvczI3cWNmUk9GL3EzcEZDSmNxdHdmVjNaRFF6RVF1QUdLV1ZPcWdO?=
 =?utf-8?B?U0M5MFcwN25wYWdZOWE2R1N6RTVPcXB2TzB5eTJrQldsQlRnM0RHYysremdZ?=
 =?utf-8?B?QzRvdWxTbWJxTXk3Wnh6RmFBUEpEV3U2Ukl0TERQMjMwQWJrUWR2U1k2eVJn?=
 =?utf-8?B?NXNiWFNFWnR0Y0ZJWmdqTUxCWW1wTEp3MDFsbjBheWxzNFJXS0hiOW9CTkto?=
 =?utf-8?B?VlJjZkdqU1FOb1V1VktLYVhWOXdqU0JzbXdUOTA1SzV2endvbmhVbVJMRjN3?=
 =?utf-8?B?dkZrQWR2bkwzcUZuTTR6VWpobmZyU0NNUWNHS01FUnNKU0FLYUw4V2ozN3c5?=
 =?utf-8?B?cVVTU0NrQkpLVEVLNmlFR2NUaFlGelZ5VzM5cmdRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JPZUxZRVloYkRLbVlWZHRObkRaZGt2cCtYR1VaMEE3bkJJZHBLSFJvVmU4?=
 =?utf-8?B?RzZaNUYxYlFYamxzVHVXSjBuS281bzR2cjZ0enprYy9kZ3ZsbGVoREFzeDho?=
 =?utf-8?B?aFZGYjB0dmtkQjRDUDIyaDJpRXVWVjdha0FydTdtdjhWZmxZb3ROTnprc0pp?=
 =?utf-8?B?YWkvNWRiRUpRaFl5bGx4anVLN0djL1dmUDlVaG5XYk9WYi9jenFGWWw4cHM4?=
 =?utf-8?B?cm1qdVdTOWx4bU5ZU2J5REZreEoxZGthQ2lnNVBPc1AyZjdQZUgwODd6V215?=
 =?utf-8?B?NFBnaUtXZTdOWUp6cUhZK2o1QmpNUG9QOFpzV21qb2xIQnl0V2l6SFNVM0NS?=
 =?utf-8?B?UHc4RllpcUdDa05za0NOVDNia1V4K2lKNFdKWnE4VGMxRCs3R0xYN3FaR3RY?=
 =?utf-8?B?MUxaeXhJRE9mTDRVZ1M0d3NNL2F5eUVoLytUVnZCZ284Mnh2c0t3ZjlzREN2?=
 =?utf-8?B?V3hKS25HeWFhS0tTK1NQQWc1Zy95VEtMaWROM3NLMlNlVTdVaktCMzFQaDlp?=
 =?utf-8?B?a0Z3VjllcXU2WVdCUHNIWWY0T01YSVpFbEgxbWFwb0xLY2YxTTRhZUJWeDlh?=
 =?utf-8?B?aDh6UzFNZUlvZHhnL2EvSXpsT3MvY0NmbEhCdmpKRnlXOFNrQ0RmSmgrakRW?=
 =?utf-8?B?a0piWG1sWDZLcDFJVVpKSlVsbFBIUUtOY2ExYlR3aXFURjZ1TGtSejFVYU56?=
 =?utf-8?B?cFA3eHZGeW1jVlA0RTZKSnpIYU5mQ2pEeWxSS0lLMGUrRHpBU1krS2YyaTJD?=
 =?utf-8?B?eE5NdEYvWklkMzloRFNoMmFqRi9qb2pqZ2pvZkV3aE9FZDdUZFBsQVVUWmRD?=
 =?utf-8?B?MWxzMU83bVhPUUNwNFBkMlNoc245Z3ZQa0dhaDlWMGxPNURDZndvaEc1UDlF?=
 =?utf-8?B?RHJkTGN3SmJ2UXdZZnI4S1RwV0xSVytlZ1pIU1V5VXpqVFBOcnFRUlpZWGNp?=
 =?utf-8?B?Q3M1WlZhS1MzOVJVSGtSck9OZzJrZGUvaDF0SFJzS1lvSWkzNldNdTN2cnVT?=
 =?utf-8?B?Um5URVpkVmtZZGRWOUI4YmNsN29mbFgvaUZLMnFQcEsvWGx4akt4Uk5SRkFz?=
 =?utf-8?B?OUMyejk2QXRaeSsvWkE5WTBUdHhrVXd0N1o5OUFDQ3Bham00cCtWbnFLKzRi?=
 =?utf-8?B?M1hOMDRGYmVCcEp0MFpPeXhrRjlOQ3d4RWRMenVJYlkzZEEvVEU2NS9jditS?=
 =?utf-8?B?NUswS2FYMlFDMVA2S1k4Ym5Pb2twd2MrV2xreDhsNldKZWxPNElPbnpEQmZr?=
 =?utf-8?B?Ri9RdzVSS3cxMU5Kc254L3RHaVNOQ0x1K2pHb2VKeWNCOG1LOFhYUk9vc1dD?=
 =?utf-8?B?RXY3czdXNWFWV29ueEh5MVZ1dGsycXh3SGo5VVkyQUxxY09wODV4clhwZG9P?=
 =?utf-8?B?K0Y4d3lRNkI2a3R4RFpEL0E4a0YxR3BudHg2YVpGeXFwZmJoYXcwRXFTc1R5?=
 =?utf-8?B?TzNIUHMwa3I5ekNad0FXQjJsM0dyWFpBYkZrMmgrVkxYNjE4OUdnemJ4aHp5?=
 =?utf-8?B?M2RGdlV5YW53MzYvWTUxdFBoSzRHVHBtaDlOVEIwcGRabGx3K29zVDJ3Sk1H?=
 =?utf-8?B?ZHExTGd5aS8zNU5aczRpNmkrS1BHTU00WW5kYUJWNERkdU5RQjJtTnI0VzJx?=
 =?utf-8?B?R1lHSDFENmxtdGhjaERITm5mSVFVQ0VLUzNhTmlHdGI3QXN4a1ViOXZqenl1?=
 =?utf-8?B?UjRUc3JnejZiQ3o5WkhnLzlybU53OVlSUUdDZVhPbk1NZTlKd2cwRGp0bTRz?=
 =?utf-8?Q?J5mch9AtPmispz6RYJdNnXNWEegHZ7NdInY4njX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b49784-c995-4ef5-32ec-08ddbdb8cb99
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:45:54.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6376


On 2025/7/3 8:38, Inochi Amaoto wrote:
> Add PMU configuration for the cpu of sg2044, which is the V2
> version of C920.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi | 91 +++++++++++++++++++++
>   1 file changed, 91 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> index 6a35ed8f253c..2d21b2881ab8 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> @@ -2778,6 +2778,97 @@ l3_cache: cache-controller-16 {
>   		};
>   	};
>   
> +	pmu {
> +		compatible = "riscv,pmu";
> +		riscv,event-to-mhpmevent =
> +			<0x00003 0x00000000 0x00000010>,
> +			<0x00004 0x00000000 0x00000011>,
> +			<0x00005 0x00000000 0x00000007>,
> +			<0x00006 0x00000000 0x00000006>,
> +			<0x00008 0x00000000 0x00000027>,
> +			<0x00009 0x00000000 0x00000028>,
> +			<0x10000 0x00000000 0x0000000c>,
> +			<0x10001 0x00000000 0x0000000d>,
> +			<0x10002 0x00000000 0x0000000e>,
> +			<0x10003 0x00000000 0x0000000f>,
> +			<0x10008 0x00000000 0x00000001>,
> +			<0x10009 0x00000000 0x00000002>,
> +			<0x10010 0x00000000 0x00000010>,
> +			<0x10011 0x00000000 0x00000011>,
> +			<0x10012 0x00000000 0x00000012>,
> +			<0x10013 0x00000000 0x00000013>,
> +			<0x10019 0x00000000 0x00000004>,
> +			<0x10021 0x00000000 0x00000003>,
> +			<0x10030 0x00000000 0x0000001c>,
> +			<0x10031 0x00000000 0x0000001b>;
> +		riscv,event-to-mhpmcounters =
> +			<0x00003 0x00003 0xfffffff8>,
> +			<0x00004 0x00004 0xfffffff8>,
> +			<0x00005 0x00005 0xfffffff8>,
> +			<0x00006 0x00006 0xfffffff8>,
> +			<0x00007 0x00007 0xfffffff8>,
> +			<0x00008 0x00008 0xfffffff8>,
> +			<0x00009 0x00009 0xfffffff8>,
> +			<0x0000a 0x0000a 0xfffffff8>,
> +			<0x10000 0x10000 0xfffffff8>,
> +			<0x10001 0x10001 0xfffffff8>,
> +			<0x10002 0x10002 0xfffffff8>,
> +			<0x10003 0x10003 0xfffffff8>,
> +			<0x10008 0x10008 0xfffffff8>,
> +			<0x10009 0x10009 0xfffffff8>,
> +			<0x10010 0x10010 0xfffffff8>,
> +			<0x10011 0x10011 0xfffffff8>,
> +			<0x10012 0x10012 0xfffffff8>,
> +			<0x10013 0x10013 0xfffffff8>,
> +			<0x10019 0x10019 0xfffffff8>,
> +			<0x10021 0x10021 0xfffffff8>,
> +			<0x10030 0x10030 0xfffffff8>,
> +			<0x10031 0x10031 0xfffffff8>;
> +		riscv,raw-event-to-mhpmcounters =
> +			<0x00000000 0x00000001 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000002 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000003 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000004 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000005 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000006 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000007 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000008 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000009 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000a 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000010 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000011 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000012 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000013 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000014 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000015 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000016 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000017 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000018 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000019 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001a 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001b 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001c 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001d 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001e 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000001f 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000020 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000021 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000022 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000023 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000024 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000025 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000026 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000027 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000028 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x00000029 0xffffffff 0xffffffff 0xfffffff8>,
> +			<0x00000000 0x0000002a 0xffffffff 0xffffffff 0xfffffff8>;
> +	};
> +
>   	soc {
>   		intc: interrupt-controller@6d40000000 {
>   			compatible = "sophgo,sg2044-plic", "thead,c900-plic";

