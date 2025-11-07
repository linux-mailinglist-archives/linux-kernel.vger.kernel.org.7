Return-Path: <linux-kernel+bounces-890283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFCC3FB3E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CA1891A21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9D320A30;
	Fri,  7 Nov 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="JJitGvot"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51F31E10C;
	Fri,  7 Nov 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514378; cv=none; b=CW8CEs/S2A9dyQZc5gbD7acvueZaRmfQVtzYohzX+WoAs5r0hLMvAP5PZ9DErak5WM750iZQmd+ubUmhN8034WWkUywApzVBuizJVH3WZ2dAk+laVZrw5XpMxHCK3WWx87Gr6ew2mWcpP7HNRMcoYNk/2zfnvcYaSw3vd+RxeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514378; c=relaxed/simple;
	bh=YF9z8cl/wXR6O1s7vIRCo3qMDvIvk0wpzaCNDVWcqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJMJtPAPV2Q6ouqVv40mG4F+E0D/XQkGP4InNwsRKWiYL97ke4OHMN+uElfL7GmZHLFa2RHMWLlZc4fnvBwZWQi6aP9WQPCfylnHHQ6X8NcG7k4u/5YHAftL7aK/tkWwANM3HwC1jvl35Nb1Ol9eFgnAXkXyaahFLfeSRSWBP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=JJitGvot; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1762514342;
	bh=lhFcy5Ig/Qga8G7LRC6PM1MhO7lb4A5TShXc2mRUdDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJitGvotvmm2lBkF0RwI16nnmDt+iJgwWH9S+fG0JcI0qrFPOxgNL08pwL5JhUdHJ
	 X+KeMlZ0eFU0Sj5rPuPwpKiMBRUjz05NY2nbv5Dwpq5+qpIY1Ux00hwE6hYlgGOjO5
	 I5Afy5iOdVim8lZ9s72EJ/7HKXi1fcWM+m33SYr6EZBrpajnU3z/G3R0fi3h3l0p7L
	 QCf3AwiH+I822e8jhbnpdRtpSrKx8Fp4cdCSm6CaYwIWaGR0hVEWyhetCenJ+R7/DZ
	 nl6yIeOmJVvcD24wDL892tXV8d3/1bYxJbtQkcI6CpWLDQ9JdFUvqRIRdi2hw9Q/Uu
	 XxQ8myplwdK4w==
Received: from [192.168.2.54] (unknown [143.105.119.212])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 5D427B22046F;
	Fri,  7 Nov 2025 12:18:59 +0100 (CET)
Message-ID: <4642392c-f44a-453f-992c-e28da67159aa@freeshell.de>
Date: Fri, 7 Nov 2025 03:18:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] riscv: dts: starfive: Rename jh7110.dtsi to
 jh711x.dtsi
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <20251107095530.114775-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251107095530.114775-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 01:55, Hal Feng wrote:
> JH7110S uses the same devices as JH7110. Rename jh7110.dtsi to jh711x.dtsi
> for preparing to add JH7110S based board device trees.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi           | 2 +-
>  arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} (100%)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 083ec80b4e44..809274625615 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -5,7 +5,7 @@
>   */
>  
>  /dts-v1/;
> -#include "jh7110.dtsi"
> +#include "jh711x.dtsi"
>  #include "jh7110-pinfunc.h"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh711x.dtsi
> similarity index 100%
> rename from arch/riscv/boot/dts/starfive/jh7110.dtsi
> rename to arch/riscv/boot/dts/starfive/jh711x.dtsi

Reviewed-by: E Shattow <e@freeshell.de>

