Return-Path: <linux-kernel+bounces-846937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF37DBC9791
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F623B7EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FFA2EA480;
	Thu,  9 Oct 2025 14:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90E3595C;
	Thu,  9 Oct 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019636; cv=none; b=ZVQMlua+xuASM6Fcsk018fLRcutHtnv4uqsazUrnYiFREXmPNwn7M+jRA77j5A/sVmVJisHwYJXaMdP2fIEVAmVpgGacVxZTWUDbyog5wr8On7WatVBSqyPBVJjniBJt9I1+nGBwQ4K0G2J2Hc0jM2GsmgpUNjJ8P8JDxiBX7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019636; c=relaxed/simple;
	bh=xbPON+0N/Se3Usn4/MaFwqhgI0t5azbgrfThIj69hiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmQcMyUfcrfRS3BemgF07KulA04kkLrqjH9rKPrC6zNUZbwBBHsThoTRDWYO6gRbqqkSkcMZ+5FQJXV2Y0lsxMEvPZaI1d3TmLpQ67YCpin2369sBVimAGp1dvpvSFOhxc9LKdHne39D7NiA36ck4aAogjkV2KMuSqrhpZR3svo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjBZr0N1Cz9sVP;
	Thu,  9 Oct 2025 16:09:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PxhQ5bNCSMfs; Thu,  9 Oct 2025 16:09:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjBZY3J3Rz9sVc;
	Thu,  9 Oct 2025 16:09:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D9C78B774;
	Thu,  9 Oct 2025 16:09:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dbdXZBCVk2oF; Thu,  9 Oct 2025 16:09:25 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D24D08B76D;
	Thu,  9 Oct 2025 16:09:24 +0200 (CEST)
Message-ID: <149c6b9a-5fdb-4783-b4a3-4afc368a05dd@csgroup.eu>
Date: Thu, 9 Oct 2025 16:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] powerpc: p2020: Rename wdt@ nodes to watchdog@
To: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250418-watchdog-v1-0-987ff2046272@posteo.net>
 <20250418-watchdog-v1-4-987ff2046272@posteo.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250418-watchdog-v1-4-987ff2046272@posteo.net>
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
>   arch/powerpc/boot/dts/fsl/ge_imp3a.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/ge_imp3a.dts b/arch/powerpc/boot/dts/fsl/ge_imp3a.dts
> index da3de8e2b7d2c55cf735f3cfdef8729655979a06..9e5c01cfac2f8ad93dfa3b33d05b3ad3331b2c76 100644
> --- a/arch/powerpc/boot/dts/fsl/ge_imp3a.dts
> +++ b/arch/powerpc/boot/dts/fsl/ge_imp3a.dts
> @@ -94,7 +94,7 @@ gef_gpio: gpio@4,400 {
>   			gpio-controller;
>   		};
>   
> -		wdt@4,800 {
> +		watchdog@4,800 {
>   			compatible = "ge,imp3a-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x800 0x8>;
> @@ -103,7 +103,7 @@ wdt@4,800 {
>   		};
>   
>   		/* Second watchdog available, driver currently supports one.
> -		wdt@4,808 {
> +		watchdog@4,808 {
>   			compatible = "gef,imp3a-fpga-wdt", "gef,fpga-wdt-1.00",
>   				"gef,fpga-wdt";
>   			reg = <0x4 0x808 0x8>;
> 


