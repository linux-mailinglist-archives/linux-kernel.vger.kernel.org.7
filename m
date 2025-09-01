Return-Path: <linux-kernel+bounces-795397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F175B3F165
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21802206B62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E4286D56;
	Mon,  1 Sep 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hsbBiA/l"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281E267729;
	Mon,  1 Sep 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756771186; cv=fail; b=gywZG8FyyvDrKZ3HH4RAl0KwzlAtdl/ENAXeCmzMebbEy255VhZaAr11MYfQvjmBvMaBOF1HE9fq8obfkMnQ+7mHtyYPfvi0RVpemOscqQO+PbOsH8w6PsSsXRiWcROn06cpg/ZjZM6TFTJF6fBzjffvcH4WcT0qGQBlqe8Wh4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756771186; c=relaxed/simple;
	bh=M6nLP4EBq+ckCPIm3YQgWQwfK69EIaqRWiyBl95xk+w=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRYGDpDUjA3QU+xmzoCtbNeAOxgXEAYiTb1QkrfPlxuaarrS0kz8cU3QZ9/MtjyfpIV6/dNIjZuL2/nRSwjGhb7NRXlBnxsfIlO51cQ8Jg1oBaPCOB5D/6RI0X4dZXyc9QEV9xf3iH40aTzKHOnaC30nmWq2Vjy1OqYmSl1AV2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hsbBiA/l; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B35iR6W2b82kGevlM0S3dbXQ3AHcHlFq7rTqFuYRuW/n/x4lPMRACKqeljVvy0Pa2wTqwZGnTH0dcsuJIGZ9i3GXpH1nLe+dOJgjUaEPSTrJnlOPsXwLeLZ/yhiRRH+jGiXNaVpO6Apaa8cDixOH9Szyr3U/GvMUwvFRtQEK/9EuQu20X5UU6QRlNv2G5/jpeMr4MTeaS6UAhA4iDZMqmHImXoZMNieXUG2JmF/lrmFZZJf7e8NxwYeUhqfMKMuiUSpf9Ga7+XKM2QhHWnODz/2hcyMPpvC2LrEpVTK4jFc80AgykK/aGTNWWeLibfESCrMcNb7LQt7VWMK7Ygz8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV5P0v+koYY14+gbJFCjsAVIaqc36jiFomexXCVzlNc=;
 b=wBFgURjk/AjAm4IkdVAL6cdYh8k4EZM8QS39EIoaf1imgR9Ke8fW7D7mG9Ll8cVEc83TERImnPD4hQPx8f7h0RcCSB3lS3g2pbQtoH1z5GAelkHXxl7Re6dk2xB8jl2RC79KYlYNJEXbA0SkU4j3Hm3sDioDzJpe/Id3xDfA73kP8nDb5RIMMqxvAviIVec5CPvetOzojAJcSa/RkhOMGoRwSF2gZcOd4CdDY2FoK+lb9KTRlDZwGaW5XkH2N1Sua82698gXOT8AiqJ7WLfi6nMR75Bbdmps7AMMpCbpUM1ZmpayBejeO2EbU2Ds5MY9GDDkYVavtc09gk2vH9/YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV5P0v+koYY14+gbJFCjsAVIaqc36jiFomexXCVzlNc=;
 b=hsbBiA/l8Ul39sW5lgSanW/uhzFN3PZmjDVfvvi55Rc90fBJ38x8Ndxi/26mvnpW1vGdUhDgiOrNE2704Cl1OweAdEYnYaaGXMCUq4opptgM98rw6fAlre3l7wot+uUaunqyyVvSpVC2Ac2otKVgRqJS+O7qEx6WwWYP7T8whnIhVkbVy0Pwh3gnVVriDZhj5QKQwa9CwpMzud+FTJG/f8zUbrQrrw04S6uQYc8ShzbIARHI1Z2V0aLjicnn+dUfsxpG9vyT9wbWClNQXp+/gyz4w4Rf+lP0J0jJL+/GXTeXyd6Vp8Hjx3iJqX0koXM4hN776+4Rg3MM2up8XvDaXQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN0PR01MB9804.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 23:59:37 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 23:59:36 +0000
Message-ID:
 <MAUPR01MB110729FEE220A79D00B52121CFE07A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 2 Sep 2025 07:59:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] irqchip/sg2042-msi: Set irq type according to DT
 configuration
To: tglx@linutronix.de
References: <cover.1756169460.git.unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, inochiama@gmail.com,
 krzk+dt@kernel.org, looong.bin@gmail.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1756169460.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <8f6399cb-1f88-431c-b561-5c925ecdddff@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN0PR01MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e5e294-4f23-41ba-b6a2-08dde9b39aeb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|6090799003|5072599009|461199028|19110799012|23021999003|15080799012|440099028|4302099013|40105399003|3412199025|41105399003|53005399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3R2Mlo4aTkwZmFEeTRTOWkrM1UwN3UrT2ZvUzcrSHdKUFRaTFJ0U3d2RmlF?=
 =?utf-8?B?ZjlnemJUVnR4eTZXN2FySVRxOWd1MFpSVS9hM2VybmpJeHBHR2FaalZLM2FB?=
 =?utf-8?B?cFd6Nm5xK1VWVDFCcUlBZ3hvMlVIZGVQWG44dVVTVFJXUmZGZk84RnBMQ3kz?=
 =?utf-8?B?QnkwVUxtb0ZrRTVkdWtyUkdabElrYnlNaHl1ZDlabWNDTTFnYi9EdXFQbWR6?=
 =?utf-8?B?bUR5eDhIL1Q4RmhGYzF0OVREcXZEN2ZPRGhueWtkN2RQWG96YzlXYWlkcWdq?=
 =?utf-8?B?MWI2YXZjVE9zMFlDU292aW9jS1o2c0hHbGo1UVZXT1ZLdG8ySzVtV0VaWENl?=
 =?utf-8?B?K0ZUVVdsWm9CR2Y0SnQ5UXVRS0JaSzdxV3ZHMUdPUjdaZXdyRDNYdWVCRE5Q?=
 =?utf-8?B?WnBWdFVHaHl0b1FvdmdtVDZNTjRadCtTVVRYYllJWk9kUlBQODloYlVsRzNN?=
 =?utf-8?B?SUhmN3A1Yy84Uk9ONUNzLy9XdWtoYXFlWEF5RURxdFBhUFJ3STE5MXZnQ215?=
 =?utf-8?B?TWkydFRGS3JzYnkwR1NYZjNnMDZlemFQdS9JRm5JbHFuTXh3amFOamI3TnRN?=
 =?utf-8?B?Z1lFNjdtWFo0bDNDY3JQTDlrcjg1Z1hQdVZieFNIQ2ZFOFpPeWVLYS9xRXZC?=
 =?utf-8?B?UHBmUkRXSWg3UytLcy9DbmxISnZSVmgxSTlXNGhnT1lyOTNtU0cvUDl5dWxk?=
 =?utf-8?B?TmpNR2hudkMwVnJoOHNndjB5Y2lCSmwydjF3dlRMTGZFTk42ME9UUUdGc21u?=
 =?utf-8?B?ZTZLRTZjT2trN0p6TUN2L0xsZCtDd2tKYndBSU1vOHErWlpxL0h2L1NyRVhm?=
 =?utf-8?B?M2RKSXRGQlhXL1lrOTI3em5oUVNxUHArWXdXTnFnVEtnSDRTTUIzbFY5YlI4?=
 =?utf-8?B?M3c5QjRRTWd0Uko3WFM0Wm5tNTBReCtWekhHSEU2MnA3elF2NCtPWGNQdFcr?=
 =?utf-8?B?eC9FeER6MWYwdDFMa2VZemhtaXZmWnNBeUxWMVpvZlF5ZWJqVG9IM2RJaGJu?=
 =?utf-8?B?aEcwVk5IZ1BsVm9NSURvTUo0cTlLbzNOTktQcHNYa0xQTzNWaWwxdXk5RHdV?=
 =?utf-8?B?MThXeURsVFR2VU54aGRBcGNHTzh3Q1krSC9DR0krVmRjUFVhWjN5WXd4YjNZ?=
 =?utf-8?B?TFNyQlo2b3NGVWRybUNXTkZrMXdMZW9TR3hFNFYzZmwrRzVjcnNVOXBqQ2to?=
 =?utf-8?B?L3c5Z3JvekN6Z0N1a1dsMTVILzFxRzNLYVBDcVBYQVFveExqN3k1elFEODhP?=
 =?utf-8?B?dlFaOEpudStWMVUxc1FIWlRrZ2pOTEppc200RisvNWN0VjdaRVcxM09vWkwz?=
 =?utf-8?B?Y2s5eTRudXlRTlVIMnRSMVA2dWgyN092S1hZUDVaQ2FtcEd0WXppSVhnMTZp?=
 =?utf-8?B?RWY4NVZmM1hjVXFjUmI3RThLd1A3TUNmMXBTdjJsR1J2RjdRVFlTeUdJd0Nz?=
 =?utf-8?B?bFFDNU9oak5vZmltOTJrQVV2ZlpNRGJHbW85Qk9rZnU0M2pIVlZUempuNU91?=
 =?utf-8?B?QXNYaWY1ZFpCcGV4T3MvSjkyd1J0N1Fqc3JVVmI5VDllaFphNmsxS3JPNUQz?=
 =?utf-8?B?QUZiT1FxS3FSSzIyNng3V1J1SFhJWlR1aE5ZT3BGV0tLd1M3dUF2amJzRDVn?=
 =?utf-8?B?Z3dqVlUwcGRIcjRYNmdPQ002SGZxdUdNb09xOXNkUjZxOWpLY1dxWVhQWVZC?=
 =?utf-8?B?UXVSbWpHMXpTWElNcHF2MFFMaEUwL1ByVXhmT1RsT2piTFIvMzR4dmJieGJv?=
 =?utf-8?B?c1RPN1prdHlqdjlmRTNPQWg4SjlKU1Era3ZIQmc4eVdNVkVVelg2Z25GWVQw?=
 =?utf-8?B?TW5IWEh4SmFmK1h1aG9QeVFxL2NOTWZybllpTVhNVkhhdzBsamZ3eUx2cjYw?=
 =?utf-8?Q?RPPs1phv/kQDs?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NoNlVpL0ZqUlZybDBZQ0ROODZ4SnBhT3NNUWZRSGJyYSsyRlNmbSsrZlQz?=
 =?utf-8?B?RFFISnZsZ2lOOEJZNzk0WUE0clV5cmtPcXhqUWlySlQwcDR5U3NPcGNWV0Nq?=
 =?utf-8?B?bEVqWjZzdXpmK05GM1EyQzFmTVZVR3RBT1BXd3UwWnNWZXQwbndTbWExblJF?=
 =?utf-8?B?aGRTamp4SHBSdmxBZzJScU5DUmNocUdBam1oV2YyUk5leGYwVkFGb0FMeUt2?=
 =?utf-8?B?WVE3TDhSRk9CbDlMMHl3RE9LQjlwT3dXSTE2d2I5Uk05VVhUakUxWnU3MnJ2?=
 =?utf-8?B?SmplU3NGejltSmhXemtUREdmTmg5RGdicXJJWlJWL1BrVXBPaVpyenRtVml3?=
 =?utf-8?B?ek1xbDh5bzhOazZ4VVJWVkwyeElxb0ZVb004QW5UQ0VEQ3B1YkovVG55TVY5?=
 =?utf-8?B?eVZMRVF2UkFHVE0xN0ROYTNpQWZlM01qa0FYcldQRHhxYXRtUEw5REI3amlN?=
 =?utf-8?B?cC9TZFJTVFZlMVRNcmg0QmxXdFFsUVJLak14aVZEQ0QrcDNYV0RmaW51Y3ht?=
 =?utf-8?B?Y3k4OXhvY1BHOEVzUkRYRnVHdTU1VU8zb2FXc3pKMURkUHVsdTV4bGtRWk5n?=
 =?utf-8?B?bWFDWTBoTHg4SWRiTGtXbjE5MUJxaXZaVGVPRi96NGw0WmtWaGVJaFlpQWtt?=
 =?utf-8?B?LzZETEpZaHd5c01KUitBRURwR0ttVm1kTHpER0hCamFYbjQ4U0J2QTdPV3Uw?=
 =?utf-8?B?Q2VLZ1FsSHhWTSsrS2QwbExqNWg3YjFNY2RaYjhWQkVTcy85b1AvbE8rU2J6?=
 =?utf-8?B?WHh6MlRuOG9GMGFRRUUxbGtlS3QyMUZSSlY1VVRhQisvVDBlaHZCZ2VqYTln?=
 =?utf-8?B?MXBYSnJNSmFtRWpwVjd6ZmVpWVpHbWRvZ0tTQ2NTU0h1cktKNG5HQlVOWEpm?=
 =?utf-8?B?RGJtcEdmdWRCQUdpNTlEaEFOaEhoWXJYOHdXS3lpOEo5OUdneVRJWjQzblUy?=
 =?utf-8?B?b0ZXK0tjTkY5OEJyOWQ3RGFkS2dUaHRiR01wMVBseG5ISGhubU55aXpaWWU3?=
 =?utf-8?B?OEF1OHFydm5idm9GUm5jRnJlQ01yWXpmRTd6a0FLckU1ZExyL28yNk9qYVp4?=
 =?utf-8?B?U3RLVWJuaHdqZnUxdGxub3I0UUdtRGl1M3ZuMzVWTEZZbmRYZGdoam05LzJo?=
 =?utf-8?B?QnpQTWpQUUZBQ3hxZmJKS1ZmMGpwQzBDcXUxQnpwN3drVDZZWFQ3TDJLMGZt?=
 =?utf-8?B?WjB2OG00WHFzb3NGVlJtZXR2R3FscDdGeHdmVG5Yc29RZmFaQWpQbXFUbnFH?=
 =?utf-8?B?YXMwVWRZdHl2dlF4ZGtaU2hGNFVwNkllTDBSZWpSb1BtU3B5MHJCTXo3cnBi?=
 =?utf-8?B?emhqaC9yTjBZYlpub3FTeVpBZFdhcW04dm15Z3l6SXBLSS8rZ3RsblQ5YW1x?=
 =?utf-8?B?bWw4aFlaZktncGcvNytZbEZlY2dDRVFwdnhYSlg3Nno2MXViUlhmMnZEVDE5?=
 =?utf-8?B?d3lpZE00SFpmL2dGZ09rUG1TSUVUTU5jNkhEQ08xS1h2c0RaTkFidklTazdP?=
 =?utf-8?B?bG5VT0hFOFZWWlA5Wm1COW1Pb3dwK2Z3cE9uUFNkeGhEMFNkQlU3bkNGNlBx?=
 =?utf-8?B?Yi9tTUpzZXlaUVY2UDNrM2Z4MWVaOGNuVTY1SmU3c1FmdHpSOEhkRVF0WUc2?=
 =?utf-8?B?TlNVUzNnKzhSMmhFbXVsOUhrdUkrYmEvendYZW9ha0R5aWRlOElIWVd6T2Zt?=
 =?utf-8?B?UEdtS0xCUUhhdlB0eFpmMVpZZUZTRmV2RVM1bzVDek1xM1E0cmlqRlhYWjc4?=
 =?utf-8?Q?WHBurOrrFfQr6ynWF0l+qTG7CracF/sUPNZCyvR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e5e294-4f23-41ba-b6a2-08dde9b39aeb
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 23:59:36.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9804

Hi, Thomas,

Would you please pick this patchset?

P.S. Since the modification of the DTS part is closely dependent on the 
modification of the driver part, I am not sure whether you are willing 
to pick these three patches together, or just pick the driver part and 
leave the DTS part to me?

Thanks,

Chen

On 8/26/2025 9:09 AM, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> The original MSI interrupt type was hard-coded, which was not a good idea.
> Now it is changed to read the device tree configuration and then set the
> interrupt type.
>
> This patchset is based on irq/drivers branch of tip.
>
> ---
>
> Changes in v2:
>    The patch series is based on irq/drivers branch of tip.
>
>    Reverted the change to obtain params of "msi-ranges"; it's better not to
>    assume the value of "#interrupt-cells" is 2, even though it's known to be
>    the case. Thanks to Inochi for the comments.
>
> Changes in v1:
>    The patch series is based on irq/drivers branch of tip. You can simply review
>    or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1756103516.git.unicorn_wang@outlook.com/ [1]
> ---
>
> Chen Wang (3):
>    irqchip/sg2042-msi: Set irq type according to DT configuration
>    riscv: sophgo: dts: sg2042: change msi irq type to
>      IRQ_TYPE_EDGE_RISING
>    riscv: sophgo: dts: sg2044: change msi irq type to
>      IRQ_TYPE_EDGE_RISING
>
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
>   arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
>   drivers/irqchip/irq-sg2042-msi.c       | 7 +++++--
>   3 files changed, 7 insertions(+), 4 deletions(-)
>
>
> base-commit: 8ff1c16c753e293c3ba20583cb64f81ea7b9a451

