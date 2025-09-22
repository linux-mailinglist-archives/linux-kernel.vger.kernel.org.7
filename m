Return-Path: <linux-kernel+bounces-827486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA954B91E27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785C72A5AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE22DFF3F;
	Mon, 22 Sep 2025 15:20:41 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A62820D1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554441; cv=none; b=hOOpyvkY/1qH39QyLqdcVTdioztQpE4eObZiaIjOU1aAkqQGUWL9aQveWRehW2byaSqYHX51l04nYmlR0u7tIUGIyqU1gNJRkW4XmKZHNFE4wr+bjygQ8lJ8I+4Bk2Ot9i8eLpwTTFBvvR1C3U+kibOb3pmvHmHKn0uLq7r+80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554441; c=relaxed/simple;
	bh=WBNjS7MVm9rb03fHzQROVUxMABlH4RS2nk8p6+0bI/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=as50c8JvcmrcELApHbI4aOE2KKlI8kvjO/rL+Vq8Z04euExsny6jXk2GNC2N5D2C0GxB7UzYn+9Pw/b3Qdq04NEBMF4AxHiyY2HND4m50/QcNd3B20laFQjl+T9b5bddkYrqNUIsOle/WsZLn4hQ+DDuqbfnxCHGNAVM3n+SS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cVmRV5tQlz9sSq;
	Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AKFTWFAHC2Q; Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cVmRV5Bmkz9sSn;
	Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A2D7D8B768;
	Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Gby56WHi2ndH; Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C65B8B763;
	Mon, 22 Sep 2025 16:57:10 +0200 (CEST)
Message-ID: <31c6a5ad-08ac-46b2-9362-84484482bd06@csgroup.eu>
Date: Mon, 22 Sep 2025 16:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: fsl-mc: Check return value of
 platform_get_resource()
To: Salah Triki <salah.triki@gmail.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Markus Elfring <Markus.Elfring@web.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <aKwuK6TRr5XNYQ8u@pc>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aKwuK6TRr5XNYQ8u@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/08/2025 à 11:34, Salah Triki a écrit :
> [Vous ne recevez pas souvent de courriers de salah.triki@gmail.com. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> platform_get_resource() returns NULL in case of failure, so check its
> return value and propagate the error in order to prevent NULL pointer
> dereference.
> 
> Fixes: 6305166c8771 ("bus: fsl-mc: Add ACPI support for fsl-mc")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
>     - Add Fixes and Cc tags, as suggested by Markus Elfring and Christophe
>       Leroy.
>     - Remove blank line before the if statement, as suggested by Markus
>       Elfring.
>     - Replace ENODEV with EINVAL, as suggestd by Christophe Leroy.
> 
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 7671bd158545..cd83cd564736 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -1105,6 +1105,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>           * Get physical address of MC portal for the root DPRC:
>           */
>          plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!plat_res)
> +               return -EINVAL;
> +
>          mc_portal_phys_addr = plat_res->start;
>          mc_portal_size = resource_size(plat_res);
>          mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
> --
> 2.43.0
> 

Applied, thanks!

Christophe

