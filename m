Return-Path: <linux-kernel+bounces-848386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A6BCD9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824673AE63D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8812F6196;
	Fri, 10 Oct 2025 14:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D82F549C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107837; cv=none; b=Kpj5xnVMMi4tJlED/yzbfOcnez/qZmJnktAnvB5iUhkZACGK0UspxATtr4cHGR6lYDG9S/g6SI9Ub0HMNzv5Yn3LkATtLpdsERjcdxX7WN9W3ak6x2KqNbe4Symlh+vxLWxayljCNHhi978nt9fiADkrVVOH9e6OHLnCRTEfpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107837; c=relaxed/simple;
	bh=AgO5pJut8aaSpnOm0/973gm5/iIRjZby2wuHJQT1TqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eTZMXIsV4WMev8X+vZFrK8JcEs2KwJ5vLDBpJ47wNDAQgYVcbXsqnUGIy2gl6xhJJ+0+Y4qR9QV5sFn8csD0+rcd4Nq7mqLZiuS+eRFbpPPffryXQTJ2AtLZ8JPwTfO1y1eqUMHVEHb1dhiwBCK+9Sw7gVL8k0TefLjLdQWWbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjpzk4Kbmz9sS8;
	Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVVLb1asJWS3; Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjpzk3d5Tz9sRy;
	Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BC278B774;
	Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dGGoIumUbtKf; Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E9038B763;
	Fri, 10 Oct 2025 16:29:54 +0200 (CEST)
Message-ID: <fd1fbd79-734c-47c7-b229-a985e9761da3@csgroup.eu>
Date: Fri, 10 Oct 2025 16:29:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 85xx: Add several root nodes to probe
To: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <2025042122-shiny-vicugna-28507c@boujee-and-buff>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <2025042122-shiny-vicugna-28507c@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/04/2025 à 04:40, Ben Collins a écrit :
> T4240 fails to hafve ifc, rapidio, and localbus probed.
> 
> This matches other QorIQ platforms and ensures devices under these nodes
> get added as platform devices.

What do you mean by "this matches other platforms" ? I can't grep any 
other platform file with "fsl,ifc" or "rapidio"

Christophe

> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/platforms/85xx/corenet_generic.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index c44400e95f551..c81b8a47f3b0f 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -61,6 +61,9 @@ static const struct of_device_id of_device_ids[] = {
>   	{
>   		.compatible	= "simple-bus"
>   	},
> +	{
> +		.compatible	= "fsl,ifc"
> +	},
>   	{
>   		.compatible	= "mdio-mux-gpio"
>   	},
> @@ -91,6 +94,12 @@ static const struct of_device_id of_device_ids[] = {
>   	{
>   		.compatible	= "fsl,qe",
>   	},
> +	{
> +		.name           = "localbus",
> +	},
> +	{
> +		.name		= "rapidio",
> +	},
>   	/* The following two are for the Freescale hypervisor */
>   	{
>   		.name		= "hypervisor",


