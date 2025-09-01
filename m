Return-Path: <linux-kernel+bounces-794192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D281B3DE2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2565D189C89D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B230AAD3;
	Mon,  1 Sep 2025 09:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB730ACEA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718437; cv=none; b=ms2HFqLEwKRHPKbVOqsF1bVBkT2OU+75+oZKLzkgmv0+S5VCqGF8A5wZX5/l+nCHmken/ifG+XH3IofzHuV24I2QoBoZvID2+N9cHlTX8a1f4yuK3nUMr/8D+QENGpkPX2Y2IwR6IdaGoGtMlXShZX9HLZc7DqNaavgE9JEmu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718437; c=relaxed/simple;
	bh=XzqH1NICLb4/VMOykRFai7epHyrJvlLJ0+3DvxnlzmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuAlE4Ofzitdbfzcb6zKmYkWgzqfsDHTwYuqdqbeKMIpMIZouyjsgsyU15qcF9tz4BWu/ttv8O+jZSx2W8OZTXfrQ3C+HmjJriszekqb39k4BI2mfu0qAty0Y2aYIKTPNCLAcrzuYmm7H87vPUShfuiA9XwajOlEuvx8wFLfi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cFjlg27GYz9sSn;
	Mon,  1 Sep 2025 11:10:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3NZTwEC2xRh; Mon,  1 Sep 2025 11:10:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cFjlg1PMcz9sSm;
	Mon,  1 Sep 2025 11:10:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17A0B8B78C;
	Mon,  1 Sep 2025 11:10:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4ohyUc15GJ95; Mon,  1 Sep 2025 11:10:55 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DE2AF8B77B;
	Mon,  1 Sep 2025 11:10:54 +0200 (CEST)
Message-ID: <35c5cd6d-6929-42e5-9505-b38ed316da8b@csgroup.eu>
Date: Mon, 1 Sep 2025 11:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pasemi: Add a null pointer check to the
 pas_setup_mce_regs
To: Kunwu Chan <chentao@kylinos.cn>, mpe@ellerman.id.au, npiggin@gmail.com,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240117091706.153431-1-chentao@kylinos.cn>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20240117091706.153431-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/01/2024 à 10:17, Kunwu Chan a écrit :
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/platforms/pasemi/setup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index 0761d98e5be3..8f98f3b58888 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -165,6 +165,8 @@ static int __init pas_setup_mce_regs(void)
>   	while (dev && reg < MAX_MCE_REGS) {
>   		mce_regs[reg].name = kasprintf(GFP_KERNEL,
>   						"mc%d_mcdebug_errsta", reg);
> +		if (!mce_regs[reg].name)
> +			return -ENOMEM;

I think you will leak the reference taken with last call to 
pci_get_device() here. I think we need a call to pci_dev_put(dev) before 
bailing out.

By the way there will also be the same leak if the while loop ends when 
reg reaches MAX_MCE_REGS while dev is still not NULL.


>   		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x730);
>   		dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa00a, dev);
>   		reg++;


