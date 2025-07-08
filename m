Return-Path: <linux-kernel+bounces-720700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB383AFBF68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A71D1BC08CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB61F949;
	Tue,  8 Jul 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CtFpRaGs"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8601D90AD;
	Tue,  8 Jul 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935438; cv=fail; b=Xv1Xp3DHsXo8xpxi5zNAaeVodm5dB68xRs2NjGp9Dpwhzr4TWSX42L4o/Rd3mbUP9LaRm2eriK3cyFmk1UJFqXYypWDaWbObPX0Z2qmBfeaNrut8jeNqCvdAMezz6/tniSjg+KFboDtHc4fmXaitDggm4bwED3S9NuZAuV1qQsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935438; c=relaxed/simple;
	bh=v+n87wfh3MxozQdS0n8wOyxhRkuqYhsPgoqOp/ZLv8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtEnBVoG5g+q/R6wXCqUnCj4G0gws9KeK4sR6PmFTLnyWB0U+c8GVrvz6FaPihpIaMloMiutlZGhdY3RiEzyLK+UHWR/jQUQgBmVanrTlVApvbgHMANzORkQq49aa7UqKMGs3uO6C6YKNrx+czd3bU3Uvi2uDxPdNVyXSK/NO3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CtFpRaGs; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRoLGe2lh0Nwt8HG7EHC+Mf0L1TD8G6wdDW6SReXJWvnJiFomtEqA1p/Q9oGGbTnSkkbd1FPRq43L3C/X0Y3Jww+31vEGQ0el0aC9RzwEqncTX9AdyJwNS+B3yTGwRDStcpKQIRHLtaVofG9H7DzKAjmbQYLdeu2h3pgtXxsVy/PvYzMcVYxJdkKhNMtMM+oJqa5U37g3tiy+Da3dAFc6fkpAaz8WzypTH0TppEtc7C/i2bH8Mt7rUvHMuZyHoyTKXyGLIVePVlUgRIDCouWdAriMY0Z9XfHy3SE/Fa2AAE1WZBrIvGmSx6NrvyQdVMxImoQmDnXh+KWfakhxFNjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U55uPIOTnMw19qASaw+5pw2hyUMXN1QdXRf6HG0sUY=;
 b=Sh+ty7bHsIWdc+EHYBjAynOlS6lvCcs4hW8Qfz5Mq6fsOUDjFrZFQc5c3QjupTsnIKTPaKDeblgPujrmS2JYX+2mBCnd+TCQ16cfYZzXU7fC2PzzdStOqr7K4ca6Kmhz78cD1QInJJ98SjdA2NdcbigU30FxMgr6W9Kh0gX/yaT+dZ/0ivHwpLNJ/aNKDbwgQaq/n8czShObvQ4JRha64Jon/9RQTxg7U6/8zP5gw9cj1MPjtP3r9hZUaWE4sfBx/h73n3Su/YRlefBZHS4cZPDlbREwrhfW5u5PJil50yin5by6INQLCtj3CHF/D2H2jWAF62en7rbFyOiKOYdxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U55uPIOTnMw19qASaw+5pw2hyUMXN1QdXRf6HG0sUY=;
 b=CtFpRaGsviDpWYOelLynsg27nmKHp4IV3BEz2P5xrCDtKwUDGkd2geZ9WcIJJHWIPg3YG2kWE4J+zov9n6LittCQXLEJtFKZP6TBP/FU7BQYPPWyArl5ZXfeNLz4PbDX1UWzFVob/UXCVjhjSk77FGxvvntBFXh/Zki6uZHNbdxtFd7fsK/qZK1eLv1//sUw4XKpGCtq1BVSjzb5UAmiL3/fYli3JN8y8ekp+7cLm9HBfiQWewc7x5KmaLKKKzqlgjUfhTBJB48fFo0mJY0RPwySwojVkXXYBJhNAylGSiHx8b+pqOVKlTpBmDaPrw0wHPnGbpVwiOcs/TN2KaiCGw==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by PN3PR01MB6376.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 00:43:49 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:43:49 +0000
Message-ID:
 <PNYPR01MB1117121B49253C440F5E239DDFE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:43:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: dts: sophgo: add zfh for sg2042
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1751698574.git.rabenda.cn@gmail.com>
 <bcaf5684c614959f49a9770bf3cd41096cee5fe6.1751698574.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <bcaf5684c614959f49a9770bf3cd41096cee5fe6.1751698574.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <60df61a2-a366-45f8-962e-c07d0cbe49ca@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|PN3PR01MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2074ac83-08f5-452c-ef11-08ddbdb880e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|461199028|6090799003|3412199025|440099028|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlZWengwVXQvUndkQTZHVjNVRnFqNUw4bTBNekhEOGNCdktPaTNBZVRXU1U3?=
 =?utf-8?B?dHdKdmhZMUU5L003a054L1hiQlJRMEp6c1R2WVBweVJRY0l5OTQ3cHVqbFpo?=
 =?utf-8?B?LzgvQ1cvdzdqTkZPTGRFcUJTbDM4bjZmQklPNXFXdFNuRmx3K1VtS0tOdlVi?=
 =?utf-8?B?cWNMd3BLemJRZTBLTG1rZDZxcmRqb3d6WUxnMjFqUGFidU9nMnBkSTA4ZTV0?=
 =?utf-8?B?Z29Pa0lLZ05DS2R2dVJ3Y24xclFPc3ZEUG1XUjU4UzlxRFZjVkVWOFVTTGtC?=
 =?utf-8?B?UXh1R3dNcFFKMTR0SDc4VTN4ODNGc1BlekQzWDAxa1hTcXJ4T3VmYkVKQjNP?=
 =?utf-8?B?ZDVoMVp4VUkwRzBpTzZUbUtJaWNwZUh4OWp6ajVCYmliWk0rZDJxdnNJbDBM?=
 =?utf-8?B?QmNNVm5nWW5aUGg2QlVMNHhMMDNGSGN3aFYwa0pvRVpIOGlkdjZna0EzTTc1?=
 =?utf-8?B?R0ZJN2hNNThvS3RuUHhnMm1UZ1FTWndBQ0lXbTY0bHJwTTVoRGxKdEU2Tk1h?=
 =?utf-8?B?UElHbGowS2V0dUxERERWUzc3WGxMS2w5NEF2VHJ2dUt4bFU3T0pETlBOd3o4?=
 =?utf-8?B?T2RLZ1JzNDVrcEFvd2N4MGhhcGlJVnErZVZ0aUljRGNYQ29tb0hKbHc0dS9Z?=
 =?utf-8?B?N1RWV2tydVVEU2FGUVhKSU9oSFZweld0MW5sdDdWem9pWG1YOCtFcDRWV0M5?=
 =?utf-8?B?MjN5NmZYZ1BPUUdtQzhxRmpOTVBMQVQzdHZXT2ROSFBLL0hQRmU4R0thcStn?=
 =?utf-8?B?bDJ2bXd6T3Boa1VIa0tkYm05bStxOUVubDZBZEQyRkVTM3pOQWhlK1hKa3JY?=
 =?utf-8?B?RjBnQVlrR2ZIbktXbEZkZldZZytnY3gxbjE1WU95Mk8rY3YzRGdpRzdJc2Jp?=
 =?utf-8?B?VitaMEppQWJod21LR0MrcWNMTHZoVm55YkVLWGM1Z25UWXRRUWFtb0tmTlJF?=
 =?utf-8?B?QzYySlkyb2VJeU8xb0ZSdjlUaHZRNDBmN0YxSVZ6SDFzTGhHamMyN2xjWC91?=
 =?utf-8?B?a0UvYlMyeHNxVmJpY05zK2pEanMyaHhJQ3pWZDZYbE13UVNFQVA3cWJwSVV6?=
 =?utf-8?B?U1JRakpEaHg2N0owUnZSaG5adm03Ky9qVlpwa01NNmVQQkljR25NRkllR1pa?=
 =?utf-8?B?WVdRNjZvUmlvY2xVdEEyMWhlU1NMYTRGZkhwM3VlZThqbkdQUXNOUThCZ0pH?=
 =?utf-8?B?aHNadjV4VWxsYWdnODQ3WjYyanNmR0hqWExwWGxleGRydlE0ZVR5NE0vYktl?=
 =?utf-8?B?RnloNmhVdXZzUUlpcjI2cGozUWswZE1HL2hubkUxL0JSSUZ2cngzRUhvVEND?=
 =?utf-8?B?SHFPZGZ4SHJsenZMMGpWdG9aQkIzRVk3cmRQSnVJS2JYWUUrdjN4b3FmK1hF?=
 =?utf-8?B?VDRVLzg0SjUvdWI1em1XZDFWQ1QvNzI3eDRBY1B3Wm1rUmVjSzFPbXMwUTFC?=
 =?utf-8?B?T3pHMWZES0szR2djb0tHek0yRXUvVGJuelVhQ3NENGJITUlWNUhVWHZ0WWJ3?=
 =?utf-8?Q?95JGjc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJ1Q09nWWVYOVB3bWExajNVZ3BYRUUveE9SQlFLdXpmbUplUkJkeW1BZUlY?=
 =?utf-8?B?blJRVWJUNmo1c1RHZk8xN3dMWXZSYTMvSVpLL1ViM2JNaUpKVUFJUlJzYTNN?=
 =?utf-8?B?TDNZbDdJbHJGQnI5ZmtpR0VBLzMvUGxWaUw1WkJFNjhYZDRUL3RJNHJ3M3Q5?=
 =?utf-8?B?Smd2MHAyTlVpZ1lnVnVyWGoyNFVTUzdIRzVNNERxVDZCL2dQUEVDSWFZVTk2?=
 =?utf-8?B?dkhDOUM0NUZqUElhSzlsVk5Gc2hTVFlpbDZ6MEx2UWVlWmRHMndsYzI3dWcr?=
 =?utf-8?B?eXZZRXlYU3poaGt0K29TRUVYcmppak1CWWQ5SUQ1Uit0Nm1GdEFiMWRKRUt2?=
 =?utf-8?B?K041U1luL3RBeTVFakw1NGoxd2tkR3AvQUllVHdOeGUyNzRXVVpXQkkxNUF1?=
 =?utf-8?B?L1JpeFlnTktRMEU2UGdOMDVJMDQwTDJ6MzU0cHZpWDNmQ1ZKMExoL1RBQ2p6?=
 =?utf-8?B?dHNKN1Btd0dzbVpObHFvaDhBcHg1bjNEblhsUVFZNnJxZm1TcGxNcGRhMy9v?=
 =?utf-8?B?R1RCL3psUXc2SUhYamt0OEhVTFNlRExVMzhnYU1qKzJFUlAyWkwxSHIzOEVi?=
 =?utf-8?B?OE1KZk9ISHQ2RnJHeDBIWDhXMGw5cm92RXdvOThMRTVKQ0NiNlREYlJQbTRq?=
 =?utf-8?B?aVo0UmIxMUtQVDJuV1NKT0dXdVZ6SmEzYTVWZWV6WHIxNDZlRGFtZys5VmJK?=
 =?utf-8?B?VEhWci9PZ2dZZVowOGtnL0dqUldpZExuU3pFMW9pVHdzdkpSMzJTVk1TNTc4?=
 =?utf-8?B?cHNaZktRVStNRXo2d2J3UHFGcUVkTEh3Z1l1S3ZxNFdCbmJjR08wanhqa1p0?=
 =?utf-8?B?cERXKy9mdVFRM0lUdGRBdG5LNHZXbXkyZTYrdHJza292VU5UMW5zUkUzb09z?=
 =?utf-8?B?a1VIc0RHTllYSU1la3V3Mlp3MjdqbGg5WXNxNWwrMjdCeVA2elp5cTRsUWdW?=
 =?utf-8?B?ekd1SFJNOUVrTzQrT0RiVStCK0lZZ05oaHNPUEh0MFpsTENQYW10U3RFY21F?=
 =?utf-8?B?cGMxaHRHOVpuUVhrb1BMTFVaMjUzQXkrZm12clBmU0E0ZTV1bmFneWdRRmpa?=
 =?utf-8?B?VG9QWTVBVjZpRVJGTzRLTEw5MzJoQ3B5eklmbG9yMGo3TVlRSlo0QnhsZGFu?=
 =?utf-8?B?bktKVnArdmlUbENzNUQ2VDc1a2FRQklJY3IvMWFRUzdxOEQvMU4xVTJxaFNh?=
 =?utf-8?B?ckJ2b3VXL2xKN2pEYnNrTW80OFhhRmxOWEhMOU9jV3pGRHhMeEJLUkhOZWg5?=
 =?utf-8?B?QndMYTVkeVMyMlZFeklkQ2lPdnBvVWJFMFBZWVBRRzFocjlGUVJ4RHVLOVh5?=
 =?utf-8?B?VjNGNWFiN2NISklxNUxDNjZPNFVIR2RETjE5OUdYQVVia1Z0RlJOZHR0OEI2?=
 =?utf-8?B?enU3VzhQYU9YSUx6TVhOMmpsNERyRlI4cUduS2JIcGJMcHM1WEpnVXRiWE5E?=
 =?utf-8?B?QytaWWRZTHFtK1dISW82cjN4RVZCUy91N0pabVhTTFF3Z2pYeEtGUWFqeUE1?=
 =?utf-8?B?MCtGQ2ZnK3dKRWhUREVoMUYyUTNkR3A3azNPaUlzUGFiU20wOHRFN2NRcDNw?=
 =?utf-8?B?S0EreU14aUMxeUlGdnRXcUdHU0t3OFRpdjI1Zlh0YzR4RG1hN0tJUjFmbnFZ?=
 =?utf-8?B?SzVWQkhJallKM2gzS0s4MDZod3VSZTRvR2wzaS8zeU40VFpzSUxYUE8xajVI?=
 =?utf-8?B?bTVjWE5YNXlXZGpTMGVOa3hOTlQ1NHBCWTNLMHFnUXIxREppSUhXSi9MN2hY?=
 =?utf-8?Q?o6WQC3mvE9b9kj2i3mbm1UoDpZ+DkGK0qe4tLTU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2074ac83-08f5-452c-ef11-08ddbdb880e0
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:43:49.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6376


On 2025/7/5 15:00, Han Gao wrote:
> sg2042 support Zfh ISA extension [1].
>
> Link: https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1737721869472/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%28xrvm%29_20250124.pdf [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 128 ++++++++++----------
>   1 file changed, 64 insertions(+), 64 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index f483f62ab0c4..77ded5304272 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -260,7 +260,7 @@ cpu0: cpu@0 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <0>;
> @@ -287,7 +287,7 @@ cpu1: cpu@1 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <1>;
> @@ -314,7 +314,7 @@ cpu2: cpu@2 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <2>;
> @@ -341,7 +341,7 @@ cpu3: cpu@3 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <3>;
> @@ -368,7 +368,7 @@ cpu4: cpu@4 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <4>;
> @@ -395,7 +395,7 @@ cpu5: cpu@5 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <5>;
> @@ -422,7 +422,7 @@ cpu6: cpu@6 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <6>;
> @@ -449,7 +449,7 @@ cpu7: cpu@7 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <7>;
> @@ -476,7 +476,7 @@ cpu8: cpu@8 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <8>;
> @@ -503,7 +503,7 @@ cpu9: cpu@9 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <9>;
> @@ -530,7 +530,7 @@ cpu10: cpu@10 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <10>;
> @@ -557,7 +557,7 @@ cpu11: cpu@11 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <11>;
> @@ -584,7 +584,7 @@ cpu12: cpu@12 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <12>;
> @@ -611,7 +611,7 @@ cpu13: cpu@13 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <13>;
> @@ -638,7 +638,7 @@ cpu14: cpu@14 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <14>;
> @@ -665,7 +665,7 @@ cpu15: cpu@15 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <15>;
> @@ -692,7 +692,7 @@ cpu16: cpu@16 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <16>;
> @@ -719,7 +719,7 @@ cpu17: cpu@17 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <17>;
> @@ -746,7 +746,7 @@ cpu18: cpu@18 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <18>;
> @@ -773,7 +773,7 @@ cpu19: cpu@19 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <19>;
> @@ -800,7 +800,7 @@ cpu20: cpu@20 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <20>;
> @@ -827,7 +827,7 @@ cpu21: cpu@21 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <21>;
> @@ -854,7 +854,7 @@ cpu22: cpu@22 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <22>;
> @@ -881,7 +881,7 @@ cpu23: cpu@23 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <23>;
> @@ -908,7 +908,7 @@ cpu24: cpu@24 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <24>;
> @@ -935,7 +935,7 @@ cpu25: cpu@25 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <25>;
> @@ -962,7 +962,7 @@ cpu26: cpu@26 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <26>;
> @@ -989,7 +989,7 @@ cpu27: cpu@27 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <27>;
> @@ -1016,7 +1016,7 @@ cpu28: cpu@28 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <28>;
> @@ -1043,7 +1043,7 @@ cpu29: cpu@29 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <29>;
> @@ -1070,7 +1070,7 @@ cpu30: cpu@30 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <30>;
> @@ -1097,7 +1097,7 @@ cpu31: cpu@31 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <31>;
> @@ -1124,7 +1124,7 @@ cpu32: cpu@32 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <32>;
> @@ -1151,7 +1151,7 @@ cpu33: cpu@33 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <33>;
> @@ -1178,7 +1178,7 @@ cpu34: cpu@34 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <34>;
> @@ -1205,7 +1205,7 @@ cpu35: cpu@35 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <35>;
> @@ -1232,7 +1232,7 @@ cpu36: cpu@36 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <36>;
> @@ -1259,7 +1259,7 @@ cpu37: cpu@37 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <37>;
> @@ -1286,7 +1286,7 @@ cpu38: cpu@38 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <38>;
> @@ -1313,7 +1313,7 @@ cpu39: cpu@39 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <39>;
> @@ -1340,7 +1340,7 @@ cpu40: cpu@40 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <40>;
> @@ -1367,7 +1367,7 @@ cpu41: cpu@41 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <41>;
> @@ -1394,7 +1394,7 @@ cpu42: cpu@42 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <42>;
> @@ -1421,7 +1421,7 @@ cpu43: cpu@43 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <43>;
> @@ -1448,7 +1448,7 @@ cpu44: cpu@44 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <44>;
> @@ -1475,7 +1475,7 @@ cpu45: cpu@45 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <45>;
> @@ -1502,7 +1502,7 @@ cpu46: cpu@46 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <46>;
> @@ -1529,7 +1529,7 @@ cpu47: cpu@47 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <47>;
> @@ -1556,7 +1556,7 @@ cpu48: cpu@48 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <48>;
> @@ -1583,7 +1583,7 @@ cpu49: cpu@49 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <49>;
> @@ -1610,7 +1610,7 @@ cpu50: cpu@50 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <50>;
> @@ -1637,7 +1637,7 @@ cpu51: cpu@51 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <51>;
> @@ -1664,7 +1664,7 @@ cpu52: cpu@52 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <52>;
> @@ -1691,7 +1691,7 @@ cpu53: cpu@53 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <53>;
> @@ -1718,7 +1718,7 @@ cpu54: cpu@54 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <54>;
> @@ -1745,7 +1745,7 @@ cpu55: cpu@55 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <55>;
> @@ -1772,7 +1772,7 @@ cpu56: cpu@56 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <56>;
> @@ -1799,7 +1799,7 @@ cpu57: cpu@57 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <57>;
> @@ -1826,7 +1826,7 @@ cpu58: cpu@58 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <58>;
> @@ -1853,7 +1853,7 @@ cpu59: cpu@59 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <59>;
> @@ -1880,7 +1880,7 @@ cpu60: cpu@60 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <60>;
> @@ -1907,7 +1907,7 @@ cpu61: cpu@61 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <61>;
> @@ -1934,7 +1934,7 @@ cpu62: cpu@62 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <62>;
> @@ -1961,7 +1961,7 @@ cpu63: cpu@63 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <63>;

