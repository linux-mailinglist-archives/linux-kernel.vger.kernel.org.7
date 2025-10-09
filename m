Return-Path: <linux-kernel+bounces-846942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F1BC97BB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C918422154
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960B2EB84B;
	Thu,  9 Oct 2025 14:20:55 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84762EACF1;
	Thu,  9 Oct 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019655; cv=none; b=UZmllbOpMdcuSdRAXcGocoMe1E4V2D8co+SIbUwIQ/5o+hc4DSWHn/qwLAjCoXJDZFdRglKhcrPiims4kjqvA/LPWVgr415GGLQr++qO/SL377feKgnG/N25Td8FyrbbxXKwAoCq7WNN0APiP2cEnnM5W/AjQ6NCbWF2RWCbaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019655; c=relaxed/simple;
	bh=70+NHiSaJmOTa1oXYCtaUbisoZk2R8CxDJA2Sk9i3wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzrXK8iBcQWYeE8nJP+Q9NKkBIMQ5wyrx6PAEC4sxA1e1roo2Np4BuWEUgwL7mcTFzwoIEK6PzeCaBtwB1aL1PhImp7aM2FxrBYyv5nkGbtVVUHuIhhJOxnYM3pwT+cIk8nHwKspt9K0XFZiHV3Wa4fO0dYRcoPUu8fiEDhxohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjBZD4l7Wz9sVK;
	Thu,  9 Oct 2025 16:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyOlSRyxGg0t; Thu,  9 Oct 2025 16:09:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjBZD3dh4z9sVm;
	Thu,  9 Oct 2025 16:09:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D9E78B774;
	Thu,  9 Oct 2025 16:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id h6jEI0H14JLp; Thu,  9 Oct 2025 16:09:08 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBB218B76D;
	Thu,  9 Oct 2025 16:09:07 +0200 (CEST)
Message-ID: <376f509b-c088-4387-965d-071faace6409@csgroup.eu>
Date: Thu, 9 Oct 2025 16:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] powerpc: 86xx: Rename wdt@ nodes to watchdog@
To: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250418-watchdog-v1-0-987ff2046272@posteo.net>
 <20250418-watchdog-v1-3-987ff2046272@posteo.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250418-watchdog-v1-3-987ff2046272@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/04/2025 à 21:28, J. Neuschäfer via B4 Relay a écrit :
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The watchdog.yaml schema prescribes a node name of "timer" or "watchdog"
> rather than the abbreviation "wdt".
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/boot/dts/fsl/gef_ppc9a.dts  | 4 ++--
>   arch/powerpc/boot/dts/fsl/gef_sbc310.dts | 4 ++--
>   arch/powerpc/boot/dts/fsl/gef_sbc610.dts | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
> index fc92bb032c517a543d6e1e498ab903f1937414f8..48a81430a8a31fc29b53fba03986b2fb984b66c1 100644
> --- a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
> +++ b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
> @@ -82,7 +82,7 @@ fpga@4,0 {
>   			reg = <0x4 0x0 0x40>;
>   		};
>   
> -		wdt@4,2000 {
> +		watchdog@4,2000 {
>   			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x2000 0x8>;
> @@ -90,7 +90,7 @@ wdt@4,2000 {
>   			interrupt-parent = <&gef_pic>;
>   		};
>   		/* Second watchdog available, driver currently supports one.
> -		wdt@4,2010 {
> +		watchdog@4,2010 {
>   			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x2010 0x8>;
> diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
> index 47ae85c34635bb0165004e52d15df92542406b15..8eb254b1738dde7327d5e3fc07b4bbba137b4d9c 100644
> --- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
> +++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
> @@ -79,7 +79,7 @@ fpga@4,0 {
>   			reg = <0x4 0x0 0x40>;
>   		};
>   
> -		wdt@4,2000 {
> +		watchdog@4,2000 {
>   			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x2000 0x8>;
> @@ -87,7 +87,7 @@ wdt@4,2000 {
>   			interrupt-parent = <&gef_pic>;
>   		};
>   /*
> -		wdt@4,2010 {
> +		watchdog@4,2010 {
>   			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x2010 0x8>;
> diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
> index 5322be44b62e78bebac0fa92c0de05094b186dde..02edbb262b8f00279dea024700eebf874501f6d5 100644
> --- a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
> +++ b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
> @@ -82,14 +82,14 @@ fpga@4,0 {
>   			reg = <0x4 0x0 0x40>;
>   		};
>   
> -		wdt@4,2000 {
> +		watchdog@4,2000 {
>   			compatible = "gef,fpga-wdt";
>   			reg = <0x4 0x2000 0x8>;
>   			interrupts = <0x1a 0x4>;
>   			interrupt-parent = <&gef_pic>;
>   		};
>   		/* Second watchdog available, driver currently supports one.
> -		wdt@4,2010 {
> +		watchdog@4,2010 {
>   			compatible = "gef,fpga-wdt";
>   			reg = <0x4 0x2010 0x8>;
>   			interrupts = <0x1b 0x4>;
> 


