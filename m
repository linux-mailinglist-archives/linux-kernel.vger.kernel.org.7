Return-Path: <linux-kernel+bounces-819037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC17B59A77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BD1887341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845331B808;
	Tue, 16 Sep 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/9iY5WZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA70313E01
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033307; cv=none; b=lOZInwRUPWVkZ9gW4jWw0AnRgV4EopynpIYtHigmyXSHFB1DGVOr+OUNI3JEisRkO/6o9tMK9R+Ch/JbI8ce8RssazQ3KehX5JEtNiCupmA0LPlfGPYIYBWzNOVXmLgfLHX0Qeo3pSZiacKR+6jfc5TpMdxUYW94s+iMlUY9W8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033307; c=relaxed/simple;
	bh=Nu11bmOVRte2aokBqHmrTHWTKZU8JcQy9nmoUexKGS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IznFGAACAIiSuITbuXzwVaXsufLnOcaVp/u8kewgZHSYe+9Ed6w3TmX1KgRKUM4GtBtIroWaepy87D6DI1AEz8/4E9wjqAIoovYiY1S6X5tMNFsqdq1ZqAuT9I+Hxk6mcYA665QhjBKUelTnQ9UQp59RW8xN5rz72B9d4Vv4pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/9iY5WZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f30011eceso58935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033304; x=1758638104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CT4KnFMC9K253+uFB3sGHZvOxPtog/sC9euCmcEFSfI=;
        b=k/9iY5WZ7OxXAvw7ZvYPqxlW6P8oO7OYCvGxvPWZrH3Br+2RWdfX3Q+uLvEotPhH97
         0cW3l0fwDTkhwdew8ax8D5GZm4sxhzTn7GgJZBCoLbb5dL3+2EMv78TEmwNHrI7IvnIO
         xIAKLBoMDch4gqI7lOs2iZaGiY6b9JiUNgJDIhYEhmUtsX+uuulnI7ZxFIkPFXHfDqih
         tJ/f6bCOtNR7xDKR55x7V2NDp4n674ze616FKWh+XHUXL0j30c0dLN+LQb+72+SdxmWk
         gPg3P9uAF68XgisyPi9Y89tOVjraA02g8uKH0LRUzzTUrw+pgmkXmSSyDkyhozn2kWGQ
         f0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033304; x=1758638104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CT4KnFMC9K253+uFB3sGHZvOxPtog/sC9euCmcEFSfI=;
        b=K0IVZZQsfkkpbiZgJbGSjbUoRlhl1CpcoDvDg+X9P7FCOU66SRRR8mpl5VDAbo+RKi
         koF4R6wtsKExzlZjU/IucAnXp65meYOYJQTbDU2glV7NtPVKzWfTpCv78bQSl3FdzLTy
         3yWgv6ImcWAaMP8FMYtjXjYerC6UGC0BCDjGNmImQF/jn+LB4dabjb6FcEUy/AmktH/u
         P+hzK5q8+w4uQ1ZyUk2O0YLDdxq7nNUc3Ff1vgFaJ5Detwa7x9abpZlYDO8tKoVppfvn
         WeIEoBIaeN9nPaY5QMTFg8hxa6paDxSd8sPMfj425mZvQEl5DuAk52ylY7soysJBuB/g
         j1mg==
X-Gm-Message-State: AOJu0YwxTqbY5zE+Oq3xNtKJ8AtCnO4ztsLhvtpX0jlssq5UkryPDNrh
	uGaCPZLl385e7l8kKY44WTxjzFcrG/LbHKMKfmuX08pLw0S/cOhzQE2cUbpQLiiG5WNnmm5//Uf
	AP2AkYA==
X-Gm-Gg: ASbGncu96tVEpm8EKK4hKtNgHCKYbNFltYarUMm9ohcl5crmHJZBi3NoDOdeAbCFaYh
	Dp3cMmpcrpe5en9VBEYyLKJB/5u5y4hTMkMCgEyLfOfEHqg2lzYv/Ecv6aL4DOp+Ys2wIQYSggn
	uB329OrPcDEt1PvMRIW9KsBSjy6FR5IsI5ydq61G7ajNGDlv2IoX1Jkxl80vZEYvdj0vBROE43B
	qacTrV6YoZD9iuAZsVsFzxQTJEV1iAz2QO/M+pnnKDfpS01+vIfFOnUhSzLu6wl751m/XRmwSJ8
	XwzJlCAyPz9cQ8A8eNTbYP5u/oQWoP8uK2BW129fgeuCUPkqU7K2U66sBRl5+pKSAaD5MjsiMnA
	PrjzFFlOsFPV2F9SQALm1Kw8ZIqoxI0itFId8Drd/ZMwaTTOH1zwA5DyjWPReucXdHUB3CQ==
X-Google-Smtp-Source: AGHT+IECpwDExsg0Dr7B4qD1+CeVxxyJjTc2PPzhq2qhSmxiB4I92vX7At74X9XKcTLJsKMwvH5o1A==
X-Received: by 2002:a05:600c:8b35:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-45f320ea2dfmr1951735e9.4.1758033304305;
        Tue, 16 Sep 2025 07:35:04 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9cf04db65sm10884027f8f.3.2025.09.16.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:35:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:35:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 16/28] iommu/arm-smmu-v3-kvm: Create array for hyp
 SMMUv3
Message-ID: <aMl1lCvuKQFfOhNb@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-17-smostafa@google.com>
 <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>

On Tue, Sep 09, 2025 at 11:30:48AM -0700, Daniel Mentz wrote:
> On Tue, Aug 19, 2025 at 2:55 PM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > +               if (kvm_arm_smmu_array[i].mmio_size < SZ_128K) {
> > +                       pr_err("SMMUv3(%s) has unsupported size(0x%lx)\n", np->name,
> > +                              kvm_arm_smmu_array[i].mmio_size);
> 
> Use format specifier %pOF to print device tree node.
> If mmio_size is a size_t type, use format specifier %zx.
> Align language of error message with kernel driver which prints "MMIO
> region too small (%pr)\n".

Thanks for catching that, I will fix it in v5.

> I'm wondering if we should use kvm_err instead of pr_err.

I am not sure, kvm_err seems to be used from core arch code only, but
I don't see why not.

Thanks,
Mostafa


