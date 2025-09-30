Return-Path: <linux-kernel+bounces-838042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8733BAE4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E843AC066
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E3226D17;
	Tue, 30 Sep 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VCkeRnb8"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3434BA42
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256523; cv=none; b=Vym9Gpr2MC0lfMjzZXW6zW70/Y+VZyrkV+0s5VSM36CzU9hOhdi1NyO5yjatuFmoSKRAga+6TaZL2wIXDwZDu4H+gucpB4sFCPxXcfkSfc6VTglaueAT/vOMEXZsz816cQk1o+URzawws9rdcJSjyhB1r+TADKQ3RRSIGeWSVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256523; c=relaxed/simple;
	bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bryHVwm2wVuiUr9D5OTdvmW5vF7Mm37zymFVC8E78BP/Ny0aKHZucZ7AUW+lij1f25jRqYweJkmAY193sxya5F9tuSAc/C2CjE6+o987AUhI1LMOin1Cg6puOdXzdNQw+O1Y9W7Xk7OcL0+sjfwykKsd/H/HyNVlmw1VJ+fBr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VCkeRnb8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-856222505eeso678371785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759256520; x=1759861320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
        b=VCkeRnb8SaiwOaKAc/qE5CJ/rt3kivBgyviAWrz+sFgPeHRPrfqAPoFuXplbB+FDz0
         Ruldc12GwwS7FB4WcmiEPUAQmZtXGp7B1REDRe5bpObg9HUJBW3LF+g9xlyNJQ+QKtpN
         DMkIFwMUcuzdJzxShvsDbQ53V1872I/cXLNUiTm2SzGF+CEfRsh8C6HNMy4lRlcnCgSW
         wLpLBwKAMhHtUFNRyx6J7HzTnk/5KcLQVVpvAQu+7Ee/TF/TveUA9PAGUq5RiLoS2ivW
         zRXc+lBjaTfwquYV/9bd6OgDOuygADEk8qwQayP0jxdE+XW6kO9y6xduoZ1BLsGpzeY5
         WUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256520; x=1759861320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
        b=DiZDNu0fTF0HVSEF8IWe3Ejd/mB0pj9XYhZGsO985WoCRsWQZgpkRYNwpto6RYqzN3
         7JPnqro/zA/jOpFI6/x62GORRWJZbv+Yg9wZ3IhPODC7j70+6y/aL42BktZxPfsn07YP
         H7VbcU8alg/mz4IT2nEv8MJH8SHud80zSzCHhIeGH8tudK4MG7TTYFofwEIY/J+GOkdG
         znXKzYnx9GJAKaSypXAcFKWlGu+QywqHnWe2BZXgjx1AhDAQW6R6aCUSSQEqG0WWPN7j
         ErVoD8bmU3a0fCl/rQ3DuxpV9SDg06P7h+/pl7/WNrTasOwCgFeVIhRukg95em/QxJKO
         9ZSw==
X-Forwarded-Encrypted: i=1; AJvYcCWBHQzWey997MXmQIs95ReUxC29dUNtaPAC6UvA5ltZozyTbUY8kiHAnhWF5XQKTUfbiBJMHgYX7no67TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVY4hhtchEzCZ51cQ4BoG/dSHHY/jpFKP3tUjHXNCTzwZ+7bP
	MZ2jz1lVsYwFbwMtgkxjNSW5DfGxcCk4V9YOEeOE1Nqj7QY+XQwN24vnOfcDOfw7NSSMDfpT/Eu
	wbNPwOyE=
X-Gm-Gg: ASbGncsPKohx47Rz4HDyacS33SgNITcErjZ58w6ioUxcKx9ePXyLYKXDX1NriKCUpbH
	9ptvu8boNVN+aEXVZtsjHCAcHl4RoZjZmN4zkkK4k2YifVfYvcyG+10WIcwUp2G22UnxXleIkK0
	r4R4fsBwkj3T2BuV+kO/V32AlDAwrNvj7VVSZcG9W0GKISPv41t3428Nz0ReN0QdlNNXCXwHYIZ
	nRQLTz1f0Pn2EvKzrGszICL25z52Y53JycPgBVvs5MuHyaJRSpQY3BIR3j3nHbJFN9Es+6h83bp
	A9ziCZ6xO42Y97gm4fkU3Ao2Xx1yKxC2MaVrtblGxar9n/tXKcXlECrVfLtaBizqn6akQQxKlzg
	K4qFD+BfRJLA48jm5Xxsoc6897wocQIw=
X-Google-Smtp-Source: AGHT+IFsIfsirssruboI26MlaM0NZggtj52mIktm8BzOMFTKBqd4QU6pWwedeMRBbz+8NtekD4Df5Q==
X-Received: by 2002:a05:620a:1a0d:b0:85a:1caf:d07a with SMTP id af79cd13be357-873721b7327mr111082085a.34.1759256520220;
        Tue, 30 Sep 2025 11:22:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c288a0f7dsm1081472585a.17.2025.09.30.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:21:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ez8-0000000CgR4-1wgY;
	Tue, 30 Sep 2025 15:21:58 -0300
Date: Tue, 30 Sep 2025 15:21:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20250930182158.GS2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
> This series fixes device leaks in the iommu drivers, which pretty
> consistently failed to drop the reference taken by
> of_find_device_by_node() when looking up iommu platform devices.

Yes, they are mis-designed in many ways :\

IDK if it is worth fixing like this, or if more effort should be put
to make the drivers use of_xlate properly - the arm smmu drivers show
the only way to use it..

But if staying like this then maybe add a little helper?

void *iommu_xlate_to_iommu_drvdata(const struct of_phandle_args *args);

Put the whole racy of_find_device_by_node / put_device /
platform_get_drvdata sequence is in one tidy function.. With
documentation it is not safe don't use it in new code?

Jason

