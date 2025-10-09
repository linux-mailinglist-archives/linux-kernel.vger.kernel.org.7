Return-Path: <linux-kernel+bounces-846943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD201BC97BE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5CB4219B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C52EBB9D;
	Thu,  9 Oct 2025 14:21:00 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CA2EA49F;
	Thu,  9 Oct 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019659; cv=none; b=am/bQQT4QMeB0l6QuXJzvR0BEvaUojg2zhGpz8Lz6YWPv2wX8dlT5EGrib2hs7M7LJ33NQv7eUanGXcJqABrHxuiYAz4yOGHjWgGXPKe9+1KoKw6XoNilZh+FjSp4AMudyiWPDy4rIhfxmljxLq7+FQ3dLKLnW4lDrLWyngrjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019659; c=relaxed/simple;
	bh=YNjQrz0QXX2a3O+39Q8xHX5SyRlvSmRFP5sE8zgg+N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJFfvnbyARvNwGytMZWP5wfRz3xXHZjkBvDlxoZUGC1gsNrrvK8iu/zBtXj3j7J7IBDWAf+5oRVQmwYAlXnifhV0avsOXqHUVH2OfEGkkXv+uQhxuylG8dqpUR4qowl+mtQhr0K3616z6mmeUTwWiMpwHPASBSSWIe+rdgstxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjBYt4pblz9sVS;
	Thu,  9 Oct 2025 16:08:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ADpqTBaSwlR; Thu,  9 Oct 2025 16:08:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjBYd4WL4z9sVW;
	Thu,  9 Oct 2025 16:08:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 880008B774;
	Thu,  9 Oct 2025 16:08:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NG8yT-cNEd_j; Thu,  9 Oct 2025 16:08:37 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF97B8B76D;
	Thu,  9 Oct 2025 16:08:36 +0200 (CEST)
Message-ID: <93737f68-4714-40ba-8920-48a996534126@csgroup.eu>
Date: Thu, 9 Oct 2025 16:08:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] powerpc: 83xx: Rename wdt@ nodes to watchdog@
To: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250418-watchdog-v1-0-987ff2046272@posteo.net>
 <20250418-watchdog-v1-2-987ff2046272@posteo.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250418-watchdog-v1-2-987ff2046272@posteo.net>
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
>   arch/powerpc/boot/dts/asp834x-redboot.dts | 2 +-
>   arch/powerpc/boot/dts/mpc8313erdb.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc8315erdb.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc832x_rdb.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc8349emitx.dts    | 2 +-
>   arch/powerpc/boot/dts/mpc8349emitxgp.dts  | 2 +-
>   arch/powerpc/boot/dts/mpc836x_rdk.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc8377_rdb.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc8377_wlan.dts    | 2 +-
>   arch/powerpc/boot/dts/mpc8378_rdb.dts     | 2 +-
>   arch/powerpc/boot/dts/mpc8379_rdb.dts     | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
> index 52a84561c4f076ac0c4fc7af3db12f2fda06521c..33ddb17d18760df24ac8f068dce38ac60c353f32 100644
> --- a/arch/powerpc/boot/dts/asp834x-redboot.dts
> +++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
> @@ -72,7 +72,7 @@ soc8349@ff000000 {
>   		reg = <0xff000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index a8315795b2c951c5914953be0b4a5162dd471505..09508b4c8c73095bf4699e383e7841100d6d7c8f 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -99,7 +99,7 @@ soc8313@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
> index e09b37d7489d01bfd16a26e9786868f630fa0262..56cf6d12c730de52d85623dc34c5987bee635f0f 100644
> --- a/arch/powerpc/boot/dts/mpc8315erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
> @@ -99,7 +99,7 @@ immr@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> index ecebc27a289871a896121fbaf6bc878422d25101..ba7caaf98fd58f9a2b56c0aa566673c70eff2013 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -52,7 +52,7 @@ soc8323@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index d4ebbb93de0b325a3bb0f5d17464f516a0e12133..13f17232ba83d50498f19e6758063cf905fbc326 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -53,7 +53,7 @@ soc8349@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;                    // from bootloader
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
> index bcf68a0a7b557e49b48563f586b1fe8441ab3c6d..eae0afd5abbc39852b8e34b2247223168ab863ca 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
> @@ -51,7 +51,7 @@ soc8349@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;                    // from bootloader
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> index a0cc1953484d70410f9592bdb84ffaf779ee08b4..4ff38e1a2185f85618b603e703e54c973cb97cc0 100644
> --- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
> +++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> @@ -62,7 +62,7 @@ soc@e0000000 {
>   		/* filled by u-boot */
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
>   		};
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 7df452efa9579a649195d2266d42bbc4b6b8de1c..f137ccb8cfdedfed98a3cf6899f5508f069834dc 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -99,7 +99,7 @@ immr@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
> index d8e7d40aeae449e33ea1640a53ee4dfec7d746a4..ce254dd74dd06b19bc8e15e13f2fa9e959dd25f2 100644
> --- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
> @@ -89,7 +89,7 @@ immr@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> index bdcfe83a561e121ed82972406e0302d84d8d0ef6..19e5473d4161b5d6be6ab84ae0ba78875fc377f8 100644
> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> @@ -99,7 +99,7 @@ immr@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> index a5f702304a353c61d6ab804765b817ec34a9582e..61519acca2280427d7237d8d9bbb8485f0c65369 100644
> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> @@ -97,7 +97,7 @@ immr@e0000000 {
>   		reg = <0xe0000000 0x00000200>;
>   		bus-frequency = <0>;
>   
> -		wdt@200 {
> +		watchdog@200 {
>   			device_type = "watchdog";
>   			compatible = "mpc83xx_wdt";
>   			reg = <0x200 0x100>;
> 


