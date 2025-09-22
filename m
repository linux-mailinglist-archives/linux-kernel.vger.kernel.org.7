Return-Path: <linux-kernel+bounces-827485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E6B91E21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA23B388D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399292E03FB;
	Mon, 22 Sep 2025 15:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49E2DEA6A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554436; cv=none; b=IZO6szUXttqS5a2DHF1Z+B224LuR253ycRncjNbB7bQFo7KuTiKxqsgwDbUi9smbX+CUueS8xhWpCiAPygEon/dyiw6zyeNB0M0/wY/zV66nH/ZD4LJuWBGs6+qlqvUdBr4qWTJ0rvZVY+z8oxWW1Tsg0xVcC0ThCsUqPNAVEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554436; c=relaxed/simple;
	bh=77SnYXV3O521DzMrLnKsRhYBUAUg2bf6J6kO6gu1+VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jv0ySl8E8BX5XbLjcA++8CkPxXOAqK0WeY7EwYMiSWMLC6x7ybfJMgPvI7inaWnkVFtuOk7EmoT0OiCACOguRx1Wu+5oe6ACP/PtwODWrMXE6jpKkBa7mqWZ8YS/IWkYUAgFk1JGZ8ycVmWFsugDmqhNK15cuoSfNHNHqvm/5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cVmSt6JfJz9sSs;
	Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnfmKuq3WAna; Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cVmSt5ZMnz9sSr;
	Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ACC408B768;
	Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id AJ0qCR0yksLS; Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A2CC8B763;
	Mon, 22 Sep 2025 16:58:22 +0200 (CEST)
Message-ID: <617e83e9-c9ad-45d1-bc5a-eba2ecd7965f@csgroup.eu>
Date: Mon, 22 Sep 2025 16:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: fsl-mc: Replace snprintf and sprintf with
 sysfs_emit in sysfs show functions
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250822124339.1739290-1-chelsyratnawat2001@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250822124339.1739290-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/08/2025 à 14:43, Chelsy Ratnawat a écrit :
> [Vous ne recevez pas souvent de courriers de chelsyratnawat2001@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Use sysfs_emit() instead of snprintf()/sprintf()  when writing
> to sysfs buffers, as recommended by the kernel documentation.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
> Changes in v2:
>   - replace sprintf() with sysfs_emit() in modalias_show()
>   - change commit msg to include the change for sprintf
> 
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index c1c0a4759c7e..88fea34a55b9 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -176,8 +176,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>   {
>          struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> 
> -       return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
> -                      mc_dev->obj_desc.type);
> +       return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
> +                       mc_dev->obj_desc.type);
>   }
>   static DEVICE_ATTR_RO(modalias);
> 
> @@ -203,7 +203,7 @@ static ssize_t driver_override_show(struct device *dev,
>   {
>          struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> 
> -       return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
> +       return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
>   }
>   static DEVICE_ATTR_RW(driver_override);
> 
> --
> 2.47.3
> 
> 

Applied, thanks!

Christophe

