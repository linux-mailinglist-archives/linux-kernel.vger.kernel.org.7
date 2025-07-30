Return-Path: <linux-kernel+bounces-750252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C75B1591B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231BC7A841F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4261F4E4F;
	Wed, 30 Jul 2025 06:50:36 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1F199BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858236; cv=none; b=k4JxvxZReSpcqtaeU2Lr22ho9VP6mSPG/JuOGxXuRf7JFT/fggNzYD4CiYGC+cucPA5Vwnp2hi3fG57lP5+P1TSwkEemhCB4BfmBRA5FAhy3FSpnzLDPR3aHyRegxKa4k+kCcUllWuw+4j5UqfM6+U69ZvgEu36M7XrTiMugQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858236; c=relaxed/simple;
	bh=kljaidE45ljPfDh8GwqjLtrUcH1gx/WuiEByl4PJArI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwDsVTkgPyC/7vFO4KsexJN44TEhH6v9XxgBW+yO0FYB3BfbKitcFZKBu9tngdL+D6NPFMTgTby6n7wtaDFX8X9KKdkUGR0qKoSGQ/EI+29vsO2FXE43mgXYk3w5sOo6YFhwboxXxZCjHZo1eeax+L0BPeCJVSHL6/YAi14MLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bsMbV6VcSz9sN6;
	Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHtOx1Nfecmn; Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bsMbV5SVQz9s92;
	Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B588A8B76C;
	Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id S5cPZej56LTI; Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8502C8B763;
	Wed, 30 Jul 2025 08:23:18 +0200 (CEST)
Message-ID: <31b4169e-8c46-4d00-8cd7-708bcfe24777@csgroup.eu>
Date: Wed, 30 Jul 2025 08:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNE] [PATCH -resend] powerpc: Use dev_fwnode()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <20250723062842.1831271-1-jirislaby@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250723062842.1831271-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/07/2025 à 08:28, Jiri Slaby (SUSE) a écrit :
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
> ---
>   arch/powerpc/platforms/8xx/cpm1-ic.c | 3 +--

For the 8xx:

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

>   arch/powerpc/sysdev/fsl_msi.c        | 5 ++---
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
> index a49d4a9ab3bc..3292071e4da3 100644
> --- a/arch/powerpc/platforms/8xx/cpm1-ic.c
> +++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
> @@ -110,8 +110,7 @@ static int cpm_pic_probe(struct platform_device *pdev)
>   
>   	out_be32(&data->reg->cpic_cimr, 0);
>   
> -	data->host = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
> -					      64, &cpm_pic_host_ops, data);
> +	data->host = irq_domain_create_linear(dev_fwnode(dev), 64, &cpm_pic_host_ops, data);
>   	if (!data->host)
>   		return -ENODEV;
>   
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index 4fe8a7b1b288..2a007bfb038d 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -412,9 +412,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
>   	}
>   	platform_set_drvdata(dev, msi);
>   
> -	msi->irqhost = irq_domain_create_linear(of_fwnode_handle(dev->dev.of_node),
> -				      NR_MSI_IRQS_MAX, &fsl_msi_host_ops, msi);
> -
> +	msi->irqhost = irq_domain_create_linear(dev_fwnode(&dev->dev), NR_MSI_IRQS_MAX,
> +						&fsl_msi_host_ops, msi);
>   	if (msi->irqhost == NULL) {
>   		dev_err(&dev->dev, "No memory for MSI irqhost\n");
>   		err = -ENOMEM;


