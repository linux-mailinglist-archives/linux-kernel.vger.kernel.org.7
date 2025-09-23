Return-Path: <linux-kernel+bounces-829339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1350B96D76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDE16DAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A50328565;
	Tue, 23 Sep 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ctDbD0tP"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11929327A35
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645227; cv=none; b=LQu0BUSMArN1ZfMbfIT97cqxGoD15tp4kuSr1d82U/aNeNkf4wn5cSvVYWMvcT6sRzd945SCS3szgBYHngf3HJXs+qmGofjImEmNcSFHCoEYmboxtm+yUTzgkFdl+KaUY955yxUUYfRUVQvnE/u3R7w/4G7QJEyr3e6XHVUvRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645227; c=relaxed/simple;
	bh=c9lJuD7XPdx2TT3KIsiYo2tcOfkrfaX22l4ExJCJ1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZh8/4HGvvzKBBvQYrXpCyAKDoYHdIGvyRRVocmFFwYAHlbRjKaKnR31F0D65yrXdH/LnXtXsPEM6loJGYQqsTI2UPbpIzhKeaaD+OM2jlZYQr48sb8dZ75k5jWjDOV9gr8wnTarOiGx5xJHR21n4cEEjLsKKP18v3UKBi7EiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ctDbD0tP; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso5898471276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758645225; x=1759250025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuFofpSTnN4OjG4be97xyIzqOCkiDml5pbTJvbN5Wpk=;
        b=ctDbD0tPOkRmBYBYQ4BY34SFMJTjq0t6Qazyp6CUnk3FsjwvypmFUVsjynQbtOCXNB
         d8Sjbj2IVlr43KWUZR4SLm9WAakqwjAchZMitR88zVhkzxxbM9p8TSEuOJJEuVJROXJ7
         YpwbGdbl2uroopoXiPbs/y+yNcajU1xVjRcWG+WifFYmhhZSxMxodufAgKhv2AGWenb2
         eyQxOrizhHxGz9y7zZGacCXgxFenboqT8m1iUkxK3ptoUwS/MJuRECJNlldbP/w3oKEs
         DMNmMnM0RceFxV3vlTVOOu0EM0pIrOPLeqgX1PCuKRtByt9vD4EK6VC86xpyrVZbsm5N
         bVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645225; x=1759250025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuFofpSTnN4OjG4be97xyIzqOCkiDml5pbTJvbN5Wpk=;
        b=oh0BkfIVrgafHRn8ldA6X1GSj0dsYqzifIf/VB/4ClCCnNhfjyaH4SCayKXWUq2iIM
         vpEc5xFtMuFLVkckuFka5A2l9rpeo2uPHTr8ifFlI//xi4AKAETRl67g1tEBnAHB9//s
         8t+nybt2E6Rl4bxUwFYIJzSRfpMrp8MUYg2w4TbdfyvvTDkoqtPM99LS9h+mqw9cWECG
         BF9zPbQWMN+UBzDhs5GryJMvHvcRzvW/Z3cMFxkcg0LWSIpot/wHyCB6y2tWIYhae4Ih
         3N0bWwO9e8n4W7Kn+VLkpG2jWUw2pU4Vef6kMNqnizoZEO/+EuMZetTqOhOAUw7Ja/8Q
         LBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWNw614S9bwh+BqasbZWQhrVJpWSktQpEbnETew5LxbGrFW8RqCMYQa8fNNNYFIJroEFXtFHd2FkcpP8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGeJ0AILVpPocRTUNJ3TmabfOkY95kIDm/KhmqUT1wuXZu1Pv
	eqD58GtVzmNK5g0E/mDhBGfE+dH8c9vVxzZmnXVtwIuhhNJzEM92YNsqIfSZnWFQA+0=
X-Gm-Gg: ASbGncscn+q0zLIejXtTnBZ7uJs1xPTbQ/Iqe07nqNrw/bQUWEM5hfybFkUyfCN6bbM
	XZRfg7eMoeLSdZpYvVpTKdpuNtnTXlg//qogaENMbNMhYrhjVxUZ31/kSilvx4cOI8O3TUeUh3+
	CbEV/l1zPgNllD/TNYl1yTiFneNMaoOwaPAWSK2wJrqxZhnpm93N4MiIPLsJpu1eG/lbsM0DjYE
	X0SU2afdxb8KNQiZBh9HJhk3WHU9K4gbyys1hxcHbOKdWQ/5VoQkE1emgqATIdNMKS2DigrJtjs
	mUspMeyyFADrg/HOsGkdQ1JP7FsBGupfvOKIMY0eBfnVvwhdvK4DcwdQ0yd1jEJG/vqmqKMyJcQ
	G2Ng+4w1ZtXzeCvc8F6Zmz2ax
X-Google-Smtp-Source: AGHT+IGyFJgN6kHMNR99pNNeUGyYQV7NjbzXwXp+jyWzlg7CQqiV9MLuyd92oRaiCpm+ej3PcaWTng==
X-Received: by 2002:a05:690e:42d7:b0:633:b25a:f02f with SMTP id 956f58d0204a3-636045dd18cmr2177609d50.20.1758645224864;
        Tue, 23 Sep 2025 09:33:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb366bbfb29sm501295276.25.2025.09.23.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:33:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:33:43 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-b2caf55f4f87f05aaa619e0b@orel>
References: <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com>
 <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com>
 <20250923-e459316700c55d661c060b08@orel>
 <20250923162302.GC2608121@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923162302.GC2608121@nvidia.com>

On Tue, Sep 23, 2025 at 01:23:02PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 10:50:56AM -0500, Andrew Jones wrote:
> > Yes, this is the part that I'd like to lean on you for, since I understand
> > we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I was
> > thinking that if I bit the bullet and implemented nested support than when
> > nesting was selected it would be apparent we're in virt context. However,
> > I was hoping to pull together a solution that works with current QEMU and
> > VFIO too.
> 
> You probably do have to make nested part of this, but I don't have a
> clear picture how you'd tie all the parts together through the nested
> API..
> 
> Somehow you have to load a msiptp that is effectively linked to the
> KVM reliably into the DC for the iommufd controlled devices that are
> linked to that KVM. Then synchronize with VFIO that this is done and
> it can setup KVM only interrupts somehow. This kvm entanglement is the
> "virt" you have mentioned many times.

Yes, the VFIO+KVM irqbypass framework currently provides much of this
support (which patches 10-17 of this series leverage). But, if using
nested is necessary in order to "signal" to the relevant subsystems that
the device's irqs will truly be isolated, then I'll need to start figuring
out how iommufd can fit into the mix (or if we'll need an iommufd-specific
implementation for a new mix).

> 
> The direct injection interrupt path is already quite a confusing
> thing..

No argument there :-)

Thanks,
drew

