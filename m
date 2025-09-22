Return-Path: <linux-kernel+bounces-826659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0EB8F0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E785B189D548
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359B21C163;
	Mon, 22 Sep 2025 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ik0gJIOq"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106626AEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520853; cv=none; b=LCVvIy4b7IjbObi2mBrE8VPvokVxZDRUQEneHH0PTtQFMiIu+z3lE/wOeMJL/Ycae1rI4Suc6ITR5GhWoIX1BKJDSCFtBAO4RkT5RvupUra3Kj7rQ+7BxVhs913sgYM8nAQDtKmV7wJjAi7rPoM2i1wKVaGAMz2hcuQELNPOhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520853; c=relaxed/simple;
	bh=3eyi3AxQ2bqNzfXRmrbb7G2rUznuiye7uSVonYQn/gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hCJMO7BMDh8bmctFv6Yg08qhxYTdVEEhfY6M+ls82kap3VN4blhUpHsK+pK0tYckVZ3onrkta64/vnZ8s95WmI2uNdiUbqlOPNwkUs1BLnfhjPOo9taeV29Fk6LnKCLW0VgluH0z18t/gcmp1JKa4mu6Jgx/6Fu0RoC/HHz1g+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ik0gJIOq; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M60FDs1170592;
	Mon, 22 Sep 2025 01:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758520815;
	bh=APx8eOuMTJTC4YkubB7eJd0QwNCQpx44ZVFa/uuHCDk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ik0gJIOqHz6uYuG102dHRi9EmvmFWYwusfI5DrIzyA8jxNY6aefYkDtI6AyeiKvRc
	 eISRZIfdqVrR/l6gw9X9Fo1g8u5pJqzx5KleHKTa1s+u3eHaMFMhucvvxFhQ3prinm
	 zWb4g/9jlgBPR3I8fhxJ43tyMhO274mDiR9EktUI=
Received: from DLEE209.ent.ti.com (dlee209.ent.ti.com [157.170.170.98])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M60Fi0079861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Sep 2025 01:00:15 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Sep
 2025 01:00:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 01:00:14 -0500
Received: from [172.24.17.2] (lt5cg1457vgj.dhcp.ti.com [172.24.17.2])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M609t72276522;
	Mon, 22 Sep 2025 01:00:10 -0500
Message-ID: <e79d5220-2824-4cd2-8e61-b1da8d22d2a1@ti.com>
Date: Mon, 22 Sep 2025 11:30:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] mtd: cfi: use struct_size() helper for cfiq allocation
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>, <david.hunter.linux@gmail.com>,
        <linux-kernel-mentees@lists.linux.dev>
References: <20250918184420.76047-1-krishnagopi487@gmail.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250918184420.76047-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 9/19/2025 12:14 AM, Gopi Krishna Menon wrote:
> Documentation/process/deprecated.rst recommends against performing
> dynamic size calculations in the arguments of memory allocator
> function due to the risk of overflow. Such calculations can
> wrap around and result in a smaller allocation than what the caller
> was expecting.
> 
> Replace the size calculation in cfiq allocation with struct_size()
> helper to make the code clearer and handle the overflows correctly.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  drivers/mtd/chips/cfi_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/chips/cfi_probe.c b/drivers/mtd/chips/cfi_probe.c
> index a04b6174181c..e254f9cd2796 100644
> --- a/drivers/mtd/chips/cfi_probe.c
> +++ b/drivers/mtd/chips/cfi_probe.c
> @@ -208,7 +208,7 @@ static int __xipram cfi_chip_setup(struct map_info *map,
>  	if (!num_erase_regions)
>  		return 0;
>  
> -	cfi->cfiq = kmalloc(sizeof(struct cfi_ident) + num_erase_regions * 4, GFP_KERNEL);
> +	cfi->cfiq = kmalloc(struct_size(cfi->cfiq, EraseRegionInfo, num_erase_regions), GFP_KERNEL);
>  	if (!cfi->cfiq)
>  		return 0;
> 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

There seems to be one more occurrence of this pattern in jedec_probe.c.
Would appreciate if you could fix that too. Thanks!

Regards
Vignesh

