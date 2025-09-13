Return-Path: <linux-kernel+bounces-815086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52691B55F30
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0646FAC57BF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BB2BEFE5;
	Sat, 13 Sep 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJGRCbCu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE622D4E9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757750608; cv=none; b=WGxcMucuQ/rGf5H1yrTynadkhH8lHDw6jG+rs57eebLrM8gewYOaxwTBDlQKxX8nMJwmzMO6S/LeOwo3qHOVPF5vFdy5eUchlkxppzIA4hOwn03eIgcVTf4ZIKT5NlfTn11VT99vTGk0IT6/FwKX1IAKSYS7dwva4aUuMmnNlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757750608; c=relaxed/simple;
	bh=mH86EQWr6AGu2mollVX1DlBSZOBPxxseBdTdR5DelVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHukGUqA5xUAqP0C5vNHzhDie3BcoymUgOCNuO1iDckJS4onpDgnySze4GyFAQAgk0h05cQxUMbTShvPb8W9ltlHHIRT6e1ZmMtH3GfaqGTEn5LwIhXR9BOjVRgeOytSaG7ybS2qtq7WlyWKCxqWC1PJ93IrzvM+QZcPKv8w6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJGRCbCu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757750604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfGAXjEAE5IQc4g/CxBE4ZUWAqqWb1+3938rC7tk+70=;
	b=XJGRCbCuUd+moOeteru5MqTEQkfGt+6J50h5zSEnC8Xj/dp+jud2Ha+IEECbxGlEdHGBCq
	8YtIzU3xe0z3pC59pTX9UtKoh7XZQRKw4oWy9QZYHuQ5Kacw1IVu9Q4uFY1EIQD6L7rBQu
	sXmbpawswtGUDKjSqWaPl0/sLy6n2Kg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-fvmuZ6-bMl-Ky99wFSO1Jg-1; Sat, 13 Sep 2025 04:03:23 -0400
X-MC-Unique: fvmuZ6-bMl-Ky99wFSO1Jg-1
X-Mimecast-MFC-AGG-ID: fvmuZ6-bMl-Ky99wFSO1Jg_1757750603
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-423f8f599c2so682145ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757750602; x=1758355402;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfGAXjEAE5IQc4g/CxBE4ZUWAqqWb1+3938rC7tk+70=;
        b=F/9MLsfp9iB8eEiC31yoSLKvxSgKl20aogekLUCHGZx5LzBoXe+1VB5khkOHy0SzDg
         eGBeu88k6VzvECoJkQ6mThfMAWn84pZ0OSwW5fOMip/UNU7HkZY8iMOoUjGLLA5PIMQk
         0tG7BJW5HUPqE0gEMkh7cS4g+UWAkAnHImOcEjTpN4f1SB8hPT73QGAThfGXS8QpHI+M
         Eo0jiav67nvd84wqYhEqrOoBUUJAk4/ZAOAmXTFdZ/vOVgK+33JmPjmHUhWDiOKQ4o0Y
         KeLB2n3svPJ782JbiQuN6+hX//RIDbxD4znSeOxvNOLatjc7OqfO/lC2LZtpLuLU2XJA
         YhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqNgYz93L6bcwcDfvSB7OErcd8m3rOfiRo9PoWN/fCAQSsNYoBX2xwLU4WtWswHoxccWkrEWZwtIjP5fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXoFE0fFnh9Ey7hZOJVsUwNMvr8AuOEU4olBCRc+gW69q7ZWc
	v5HL+4tPDi3UBVSuhP2ZFvSuAdbuuZvGns19pVgkAFPaTIOEak8rWc/k2k55uBqHQ1QBTsBQ6Pv
	8LFCIDKfsPg61TqZnOpSKgtHvfIhBvg7smM0bAGlyGmAuL+Fi9ex+D0cXjNRyImhSBRPHtPyoC5
	+D
X-Gm-Gg: ASbGncswZZEdhZKEkDSUNuzWuxaeg8Dy7S7kj4WcLihoIEZ7fQN+w1NhLcH7GcU3AnA
	QZGozOThWcnho9frQUWg6sy6vTm2QcjLm3hugPCuiPpO9DOCwvGVNORpH3ZZBgwLUTTivcOkHVl
	MEFiO71/kiTFQwbHoOE6hZzEn0a0YiNwPk/Il7Arnesz7LRGW20Wodm1nJJg+EQSYhKA8bBI9sp
	BS3ZoU2AXxVT0RrUA20b9sjVm8VzHumhc9ui+13swUwe4Pr4JqDB2xSfNpNLBiqcvUTGOIqRET6
	X6oxv0yGMScWnFXla6PNyUHrOlqb9yvlJx5AxuDJcFs=
X-Received: by 2002:a05:6e02:378a:b0:40f:ee38:2cd3 with SMTP id e9e14a558f8ab-420a19141b8mr28592295ab.3.1757750601675;
        Sat, 13 Sep 2025 01:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz7FR/9dKwPH5GyCTb8sfr8vUaJV1IXeXvvo4h/D6sbaJfzB+7D9+kkJ07988McEFbi6fQYg==
X-Received: by 2002:a05:6e02:378a:b0:40f:ee38:2cd3 with SMTP id e9e14a558f8ab-420a19141b8mr28592245ab.3.1757750601280;
        Sat, 13 Sep 2025 01:03:21 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-512174ef2f0sm144562173.51.2025.09.13.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 01:03:20 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:02:50 +0100
From: Alex Williamson <alex.williamson@redhat.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: brett.creeley@amd.com, jgg@ziepe.ca, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] vfio/pds: replace bitmap_free with vfree
Message-ID: <20250913090250.0cde9ca3.alex.williamson@redhat.com>
In-Reply-To: <20250912150418.129306-1-zilin@seu.edu.cn>
References: <20250912150418.129306-1-zilin@seu.edu.cn>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 15:04:18 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> host_ack_bmp is allocated with vzalloc but is currently freed via
> bitmap_free (which ends up using kfree).  This is incorrect as
> allocation and deallocation functions should be paired.

This patch is fixing the freeing of host_seq_bmp, not host_ack_bmp.
Both are allocated with vzalloc().  The same logic applies but the
commit log is incorrect.
 
> Using mismatched alloc/free may lead to undefined behavior, memory leaks,
> or system instability.
> 
> This patch fixes the mismatch by freeing host_ack_bmp with vfree to
> match the vzalloc allocation.
> 

Fixes: f232836a9152 ("vfio/pds: Add support for dirty page tracking")

Thanks,
Alex

> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/vfio/pci/pds/dirty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/pds/dirty.c b/drivers/vfio/pci/pds/dirty.c
> index c51f5e4c3dd6..481992142f79 100644
> --- a/drivers/vfio/pci/pds/dirty.c
> +++ b/drivers/vfio/pci/pds/dirty.c
> @@ -82,7 +82,7 @@ static int pds_vfio_dirty_alloc_bitmaps(struct pds_vfio_region *region,
>  
>  	host_ack_bmp = vzalloc(bytes);
>  	if (!host_ack_bmp) {
> -		bitmap_free(host_seq_bmp);
> +		vfree(host_seq_bmp);
>  		return -ENOMEM;
>  	}
>  


