Return-Path: <linux-kernel+bounces-788756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800FBB389E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180237C486A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0662E7BDC;
	Wed, 27 Aug 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvawDeVo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9042E283B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320930; cv=none; b=b+x91fr/dio9j29bXEYAE7bQvi/JmfQcdlzC3HmLwq//VtAWAhZxoenOU6xXRjq/hgL6aNPLY+kEiwh5kF7tG1RPN7NO6lkDQB0QeuhHuOtaI7jhGu4icSs42NI3Qa3Jlauc68oLFw/7//+jKuBWoboXoIupN6nM52PK79XPPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320930; c=relaxed/simple;
	bh=fG2lAgkNwX5fAWKDfLrJ3TcVo72HVbsVBL+3zr4ipWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgweMat8FGrUicSLo51nhqy4VdHAAWS+MbxkZ2YJ+V8UIfH7H+54f/HkM3Z2322t7eFqHVUIoInwdYV+EJdi34vz7yUQovzjumyLb2jI/p1hKSdYHd7cJMAW/795LpE1nRtdOebM0amSchO22SQOvxSHQ0gLP20yF1q0MROfdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvawDeVo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gvdhbCmBfEcFFZYSrlsrqioBPJc+RVSg8MeTRDQPEM=;
	b=AvawDeVoG8aGQBX55S7ZGFEHcU+TfxnsK2FypviIcj/J5wZFBCHeM2QAoxDF/uNjA09/ZX
	elpn4UaWclxy35SSb0j8Y/JV3B3eQsDqY5E6JU0M8FnQMQ/G0ctEhdnDrWYGC4kwJ6+UfL
	JEKoVsx/t4umC67ExiUTgk7hfFG8QTY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-zMqBDeODMzS8yG47Q2elqg-1; Wed, 27 Aug 2025 14:55:17 -0400
X-MC-Unique: zMqBDeODMzS8yG47Q2elqg-1
X-Mimecast-MFC-AGG-ID: zMqBDeODMzS8yG47Q2elqg_1756320917
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ea4d2f503cso394245ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320917; x=1756925717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gvdhbCmBfEcFFZYSrlsrqioBPJc+RVSg8MeTRDQPEM=;
        b=lbi+qeADQ/gMZdd5R8jFteS5nboRkaErQquu+0goHMs4hvYd/2bVbIvbgik4dsWhYf
         /x7uZ2OT82mzsKPobV0sAkKBNKT7vG6NLZ7SlmC9kPr2bO6PXHfzq8aCF6Jf3rZbLZvO
         nXARU/jyEcnyQTxHYLFRKG2iOY0StrkTPk1H6l5A39aNxnlqr+WAWs57icKZjrKaK5tJ
         C7LDnqbIMzEqC+g6lN21r/OUrB8yBx2+iNM7xomJVDHH92vkHC86rkbTQmN9m4HXP0yQ
         Q34u6RoJjr41O7T+8bUh6wG4iIw1Ohm1Y+KOw/snnmkLQNvVQ3yptGNV8MlMBHc+QLuU
         HyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNaO/s+L2VpP41lDk4vRVATfEkp2wrfk+RRj4dhz3RZaeXJptOYbEMxdvZ+f6M9ozmMSOKxYiJs5Btkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FCFz2d7UkzScjFl11ANuqrJOjDseyOkTr10EpsorDvnO7DBu
	TeBI2Lj/QEsYCKAdiU5r7KhUTIq6D0ag1TuSjB2hdQ6ZpXxD3TADy2ysgCrn+b/LN7wATeM1uuj
	FfnPjwvxTp0FYDqQIqEuuCtW9qAVMpaYRGtyowyKGF61Rbqlxjsipp6hpBZ9RMaNQJw==
X-Gm-Gg: ASbGnctl7l1ZGaQJqoVB4Xf8irUERGUN/omOj/yTi0hLLKnFGp8LUeHEm1lg/d3nIZ5
	/QDlUQraZmdbwGeh0CI7SbF/MYW3EPFWjmqF0TblhFEJ+3kFeollz3/1K+D6iBNbkVv/7JUv/Lw
	KqBYjYsgQSFRBalMXjVJkzkYTvs+6hzFOz/CVnfjDpPUYUlF2wP7fkxI8AK8yeCW3ZAbcMMBRe4
	gNHWHXlzfvWLbji49lsw3vPG3IpukPZC9bRivgtCbCi+mp5lm7yt4eUg7ppYVOOydV99Hm57PIf
	bgkOEcQE3p5q0RM9vT6a6bZPiHPiUuO95+Pnt3+C9gs=
X-Received: by 2002:a05:6e02:19ca:b0:3e5:2df0:4b88 with SMTP id e9e14a558f8ab-3e91fc2327emr105608015ab.2.1756320916827;
        Wed, 27 Aug 2025 11:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETOWYFV13Jgn0+Ln161aamHU5qaP1seKxDyxTdLgbmk74WU/ef1o5BKDWfSPh4Aa6LOXeB4A==
X-Received: by 2002:a05:6e02:19ca:b0:3e5:2df0:4b88 with SMTP id e9e14a558f8ab-3e91fc2327emr105607875ab.2.1756320916375;
        Wed, 27 Aug 2025 11:55:16 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c759f6fsm90258575ab.20.2025.08.27.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:15 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: ankita@nvidia.com, jgg@ziepe.ca, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 wangyuli@uniontech.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/nvgrace-gpu: fix grammatical error
Message-ID: <20250827125513.715e7c81.alex.williamson@redhat.com>
In-Reply-To: <54E1ED6C5A2682C8+20250814110358.285412-1-zhangdandan@uniontech.com>
References: <54E1ED6C5A2682C8+20250814110358.285412-1-zhangdandan@uniontech.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 19:03:58 +0800
Morduan Zang <zhangdandan@uniontech.com> wrote:

> The word "as" in the comment should be replaced with "is",
> and there is an extra space in the comment.
> 
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index d95761dcdd58..0adaa6150252 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -260,7 +260,7 @@ nvgrace_gpu_ioctl_get_region_info(struct vfio_device *core_vdev,
>  	info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
>  	/*
>  	 * The region memory size may not be power-of-2 aligned.
> -	 * Given that the memory  as a BAR and may not be
> +	 * Given that the memory is a BAR and may not be
>  	 * aligned, roundup to the next power-of-2.
>  	 */
>  	info.size = memregion->bar_size;

Applied to vfio next branch for v6.18.  Thanks,

Alex


