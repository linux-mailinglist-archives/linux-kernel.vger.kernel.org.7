Return-Path: <linux-kernel+bounces-821623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F3BB81C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CE71C8040E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0227E049;
	Wed, 17 Sep 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQgoqrOt"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AE7E0E8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141089; cv=none; b=Y95Rs1ySrQ5XIPGrMqEMrLOR615AGFHltP8OL4H2uPbFyQkBgz5At3caDmeSpWit/pf51UKUdAnMAEAOBPeZ13AGVLH3Y6JUa23UQ5RQJjFULS8ThLsUdr/uKLyarYk7Hq1zp0075hq6ot2FA7u+GZcVf3VgUMFdZn1PeAWZqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141089; c=relaxed/simple;
	bh=99YDcs9G/bJDwiYgqOzQYb9T04j0s9/yOXbqTbIoNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7sGznCZth/PFz4Q9z7+Cx7ij3PBq10qp4hfBismS0ingfl0WWUFvrktUuRatxoLzGRnH7JW6sHjilpzjR5KuodwnvDaHePvidW4GBYjcM59JRpKUX32+oH2sx4jO5XaN/kbufHpDnwfFS7+q6LYjtA8H7q861DMBlOKVJZlPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQgoqrOt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2f894632so20305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758141086; x=1758745886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0Aw/ikfdZAzmeCUnWbRRZpCbzRiV+TMr1DdjVhlkr8=;
        b=IQgoqrOtALdkw9M6/nsxCJfThjMuMaqJT/EnrF7p3nCPR7nMqfb2DmZdGXYfu+tCJX
         99JhooNe83NQpmlkPux4fVcjflPDriweF3FTYCnOs8fmWyJAgT3NGoBIF4F2nfb/UnZI
         wVzYZ54+JxZ6Kl3VfNurQHzEpgpz9u3eN9ClfK8PA7WItM4ff1K/xXfE5nx2kRKIrK1x
         qqq6HoD42qq/C81X13HQz0Q+Zk1iVfJyC07T7hZwSiGYcG+iem9mhDtO4VHom9on7hEZ
         ZLwXsz04kcf/JrhuTebX4/igybktnJrESiK2MrkmHS1Wb/CnRSkAfMmmtLg2tDfryQQ7
         mClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141086; x=1758745886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0Aw/ikfdZAzmeCUnWbRRZpCbzRiV+TMr1DdjVhlkr8=;
        b=FmE4qI2tNNdvRYV7XJKTrjuXpAsoOcLIRXSwPb9Oq5VoIL+MyRT32TuNKID1LAQWJQ
         nKvVGDWmdmLOC1aCCL84v4rKTP07zV4lC9DdpWLraQObrPf3KgnFLysdfuPk7dESsJuw
         5ai+rE4HlIrYpg4Akv8HS67Cr0raC4seUMbBdvUsZHyzDwMnVhNWx63vuy1VMGWEj89n
         Lysham9zKCZ9onCKQ+6+taZQyc/OBVjcMVJNmzP4bmpU76xkDzlU/bPYGRfAYZJRQQjt
         6LnO5NrZCg2NvHG3092EDVkmxLkVl6+wsFH7OMoqokKEzdo5PDMQhYALGIQFkbe818nK
         sWHg==
X-Forwarded-Encrypted: i=1; AJvYcCUufTaqCjAO1gxywjK1M9d0+FQ8c+xfiHMZaPHWTxVchebuzPlWPSrJQigcsswBJKGe2C9khfQNaRxGZ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MtX/wz3hIo9xhHUxoWmEP/Kl1GDp8OQ8ClpQg9DtLgDDDo0H
	lO2Jvs+4ZOUmxlstIhd1oW0ZEe+JIzMCLMBn7Dll4Bcx1bJermdBPSZSDERf8Qtaww==
X-Gm-Gg: ASbGnct1t1rTnkb+BoT7/aIHW9fstTUYoY3TMt8rlkjBksn1E8ItTj5E/rMvAKxxVrE
	LBd0xcDvD1ytODHCSeZ32Mb9qGRi8MLrKbAEweHqU1XRwMH++N4WvXPQPq3604b5XILB2a4lbqg
	XDB1LBP55uRFjhnrjEFBa8CwFFJ92IuPBbV8QeEIW5o0z43BEmCVL4QQi3CDNY24eKY35v6hpIV
	YVnAYzwqOz7/MzytDMoHXl0WGS9vDyJglwDXMS5z7+lPcJdwMK+062ny0wxY9Lx5Jyu4YroXMJ4
	0X8gVs5qjlijKqh9vYYC+Vt/2xgpq2FnozmoqAO0T54kytf1vkMu4WyzfC4daWJRWK1r1IhTHnD
	grfK8MqiCmisj4/Yy7uvR9H2IFOzmKzDqGMekuxQu5NpFYiApWgARHBH1lphp9YKsawpJgKeF2l
	cX0kSfIK7x3lDM+/4tLFVo9Rw=
X-Google-Smtp-Source: AGHT+IGI+TRRIpc57be67hlvyGZzYort82ADBT/ieq1RpFHGCywCE3qx2LHW/vGr/9Ap+vWBFfN2VQ==
X-Received: by 2002:a05:600c:8b55:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-462de4d0edamr1272285e9.4.1758141086300;
        Wed, 17 Sep 2025 13:31:26 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm9969975e9.3.2025.09.17.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:31:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 20:31:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aMsamiTEssyR1wsd@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-4-smostafa@google.com>
 <20250917194454.GM1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917194454.GM1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 04:44:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 07:11:40PM +0000, Mostafa Saleh wrote:
> > Integrate the selftests as part of kunit, this makes the test
> > available through debugfs.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/Kconfig                    |  2 +-
> >  drivers/iommu/io-pgtable-arm-selftests.c | 93 +++++++++++++-----------
> >  2 files changed, 51 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 553522ef3ca9..f7e6d1db6ce6 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
> >  
> >  config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> 
> This should probably be renamed to xxx_KUNIT_TEST

Will do.

> 
> >  	tristate "LPAE selftests"
> > -	depends on IOMMU_IO_PGTABLE_LPAE
> > +	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
> 
> I wonder if it should be:
> 
>   	select IOMMU_IO_PGTABLE_LPAE
>   	depends on KUNIT
>         default KUNIT_ALL_TESTS
> 
> ?
> 
> At least the default should be there

Makes sense, will do.

> 
> >  	help
> >  	  Enable self-tests for LPAE page table allocator. This performs
> >  	  a series of page-table consistency checks during boot.
> 
> "kunit tests" here as well

Will do.

> 
> > -subsys_initcall(arm_lpae_do_selftests);
> 
> Oh so it does drop the initcall, the coverletter is a bit confusing then.

Yes, I will reword the cover letter.

Thanks,
Mostafa

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

