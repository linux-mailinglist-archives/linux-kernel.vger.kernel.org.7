Return-Path: <linux-kernel+bounces-747736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E0B13778
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6163B3DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2F22E406;
	Mon, 28 Jul 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QUfQy+iK"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C7186284;
	Mon, 28 Jul 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694833; cv=none; b=G9DZUR/JD+J2at8DOPWbolt0VmzLN9+d6TUEZc95wvhJr7a0QIP3gElZwSirP68yrJxESkICH01IRBWurhIaUoNnjLooHbVbFTnztjAE/H/g9IJPq3qIYeLVnn74Crap2Cpc7uZ9UAQhs9NbfW4u8yTR3iQx1BEEF16/ux+8NBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694833; c=relaxed/simple;
	bh=Lxa32UhQ49zviZsqFL3FyKhxWZW+TL17jgUthqY2NhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSaonaAxaBYveoOLShRIc+hTgShiRA3umYO35+Qc9Y8ag3uC84nhZax+tOA4rUlqlwCyAxs56CT8ew50fA5E9bCzsW1t9l4n/DXDcVAIua52bYhGmfqVsw/tPwEqhfRmHiLsXqIJSQAL4vxmj9lj/dVHxtKcszGLZ3AYr4VVoQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QUfQy+iK; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S8WWDg024545;
	Mon, 28 Jul 2025 11:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4z6Nl9GcJkkbHLxUlXdSoq7VtdD7a2NviYmzBmJ8IBE=; b=QUfQy+iKDnQEYJPx
	9ckO2BuTyIyvKwxap7G9/Nsb1P7Ts/oYR/c+nINsDXGEH2iuQ386yXtPxVVfOmfQ
	XAs8GDXPO2XSiktM/3/GihMDkCzA6fs8i75Cmjs5rECnMsMJGkGxWPLgfi/sVT44
	Gub8InmnlN+mebMqfc4BKC9dYHNJ/PTsd4H4w1eJ0t/QZMRxWLEbV0Q7A3RLnRB5
	8qIXm2WTOw2w4PKdI9JeFdpu/4ZW1USKFmH655qhzPRROq81kMvW+tmiymRsJjIu
	u/Lc3PD8SvHBpK/oA5WOI+xck4FfrqUkge9K9DmnVwwZlCokLNZ1mUh5vbNRba3f
	UQvLbA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484nwgeykj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 11:26:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 399404004B;
	Mon, 28 Jul 2025 11:25:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AC7F75E80B;
	Mon, 28 Jul 2025 11:25:15 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 11:25:14 +0200
Message-ID: <b80cc04f-aa80-4124-97de-846bebc271a2@foss.st.com>
Date: Mon, 28 Jul 2025 11:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: sti: removal of stih415/stih416 related
 entries
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Alain Volmat <avolmat@me.com>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-2-f4274920858b@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250714-sti-rework-v2-2-f4274920858b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01



On 7/14/25 15:49, Raphael Gallais-Pou wrote:
> From: Alain Volmat <avolmat@me.com>
> 
> ST's STiH415 and STiH416 platforms have already been removed since
> a while.  Remove some remaining bits within the mach-sti.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/mach-sti/Kconfig    | 20 +-------------------
>  arch/arm/mach-sti/board-dt.c |  2 --
>  2 files changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> index b3842c971d31b80edaf88ab907f4377bea0a2af5..e58699e13e1a55ce46e68908c7ef51e18b040dc9 100644
> --- a/arch/arm/mach-sti/Kconfig
> +++ b/arch/arm/mach-sti/Kconfig
> @@ -19,31 +19,13 @@ menuconfig ARCH_STI
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  	select RESET_CONTROLLER
>  	help
> -	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
> +	  Include support for STMicroelectronics' STiH407/10 and
>  	  STiH418 family SoCs using the Device Tree for discovery.  More
>  	  information can be found in Documentation/arch/arm/sti/ and
>  	  Documentation/devicetree.
>  
>  if ARCH_STI
>  
> -config SOC_STIH415
> -	bool "STiH415 STMicroelectronics Consumer Electronics family"
> -	default y
> -	help
> -	  This enables support for STMicroelectronics Digital Consumer
> -	  Electronics family StiH415 parts, primarily targeted at set-top-box
> -	  and other digital audio/video applications using Flattned Device
> -	  Trees.
> -
> -config SOC_STIH416
> -	bool "STiH416 STMicroelectronics Consumer Electronics family"
> -	default y
> -	help
> -	  This enables support for STMicroelectronics Digital Consumer
> -	  Electronics family StiH416 parts, primarily targeted at set-top-box
> -	  and other digital audio/video applications using Flattened Device
> -	  Trees.
> -
>  config SOC_STIH407
>  	bool "STiH407 STMicroelectronics Consumer Electronics family"
>  	default y
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index 488084b61b4acafb569ee9c51f5769393d55a9ce..1aaf61184685d754de57b487aef9a6b45a759b23 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -10,8 +10,6 @@
>  #include "smp.h"
>  
>  static const char *const stih41x_dt_match[] __initconst = {
> -	"st,stih415",
> -	"st,stih416",
>  	"st,stih407",
>  	"st,stih410",
>  	"st,stih418",
> 


Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

