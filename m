Return-Path: <linux-kernel+bounces-854211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF65BDDD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D22C9502262
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0D308F2E;
	Wed, 15 Oct 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvNzTtSd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CB239E7D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521304; cv=none; b=DhZiwzjkGYGBZ0Y+dC9Bx5Smrr/aBI6Es6y14b08lxQ9UONtioMYgXC+fSifj4+8K+UsJO/dZVAjD9n0qZjpQumJ8JtdPnVjUfUMCphgzp4UBgnwXdiicxbHE3qCSVJstQLLRNAxpCdIqfSBDyTaufIIBinTv7+h/5Q0B1Db4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521304; c=relaxed/simple;
	bh=xCvkHIm7qec+IuTZyhD3i3j8fJiu+BYGzrZ6a014T/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mht/wJ1TtHHcnMpUkh2vnqH+0/uazjPP5FyKBXEk9urWGgy0cMOjgVoyyqF52EO7r3HHXI9cJ1YtiTSJ88PPderQEm3C11JmQTbt82y6QcHaKuCExSOecA8zkDqR1+vRe33TPzGxvRoDy/E1A62Bm9onetbKHkQR9TBrykjos2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvNzTtSd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so18715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760521300; x=1761126100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7gNIafNOAAdT8vVW1v+tnHUrlaQMtRV3mgcHVHcyVA=;
        b=ZvNzTtSd7juU7pESOZd8aV7zewRPdNV2xpoc5v2BH2KBZk/NCGc/ZswjYX5qg+0S4w
         jo4PJDXSOhe/ouxP6u5PqJBX1h4Ylqu/Qi/mxPrXljqj44n5pvKrIe6t9RVMNpJQkk7C
         b9NUFFHG5xp8IX2js+bvtxd6Gf0PX6MuK24GbRcxKaJZ4mnv2B6t4BY/lrmKAZ6ipMOl
         YMtBzvdP3Jg5CE9LrryYnudfu/Qi/Gg4aKx+LXCgiUtU4+JTWpkVl5s4kWY9rmxUjwQD
         N6kRfHSEZU2XPYG4RVdhr0p8kXFpcYaqAbBdcNHwl66zD2JRzDFeHsHc4bkB3OeBsMTQ
         QoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521300; x=1761126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7gNIafNOAAdT8vVW1v+tnHUrlaQMtRV3mgcHVHcyVA=;
        b=GHhoDW8UWyT2QJpe6q0YGUE3PGJOCtQRIyA5e+tQryXOYggpFqcmsaGPedv2vhIlP4
         0YvS1P3Fi2/ODWzfWuZSBEiMTJXd/LjhenlC8NKuDQDRPw0/16mlEY7fqtpb+TooEmdb
         TjTvi6NKtGFXWB32IJGMFgqn8lTY9WOtw50uRjWIQeqbWdopiAmyWh1tKgR0Vy5YyD7e
         XtfiCbDV/IgLW/xJjyQTY1fgGbdM+A3IBfzGLlt+7R4cj9RRyk5/XIgkdrndqZwFBaJr
         ou/Im/8rMiQTl+xBjtysEauGDlbF3pTMo+5fzZ+KcEWTUlN2PsZZHYZV2KTtd8y6drnq
         9/3w==
X-Forwarded-Encrypted: i=1; AJvYcCVEeixKKHMFL8Q0FXQ+JYFQvvDGSFHCXQPJRoTgnVWyAQpvLlswE+ViALoSnkQRd91fmfFEBD/Tr7KZSYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SYJ29s/aAwQD5o7xY6DZBm4+Xy19NGEN6kLT1/6B/etGP/Eh
	Lj7pN4gEsmwFexj+6evuzpXro6/BQviE/tQHd+28CnlkfBTpnNlAOVNLnaMlqSpBMw==
X-Gm-Gg: ASbGncvZWxsjgWPTRwOtE+sKipMjFeylp3xTwkwvB2bBEMd8c3FHIoQx9lXFha0T9kW
	h7JE0ayTL9QVnCCEJaG/kDM1WNNXOKaEmmCID6fPtZtt/Xz2EI/1e7MJhqwu3nB/K5k6y63NG+Y
	8RO223vASW4ktSUZMOPOJb9gDyEHn3R8QyuFp+BdB1YCf91XUL4Cus2sAPHqgaJsS194BkWatbR
	bSXOJC4AWhqqoY/26N3DXhHFEDIfIIBv6vzBClZ8FlfXnEmsEJZZGSwKQCYluaCVYMtquHCrxEE
	TK2VcLU1kGfneAW2FjkLc0+sNN4fkIlpP4+lsijxZFYUWgNPQrggkb1uX0E/6CUDysbBoofK/7O
	kRcTL5yTzR6Mbo+Sd96SR+OK5yekMfN7uyGxCj+MQ5WKeRaNDLQ5vAeK6OFKAcLV+re0rP5e+vU
	7AIewMUnPzAw==
X-Google-Smtp-Source: AGHT+IHR5pyr1xnwIimpgjpOhjIZXkvm+AJq3ntKDNIiM5QNlOCKNqqBRMSb2N3JBImOJuWcOi7CEA==
X-Received: by 2002:a05:600c:a316:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-470fd76ca76mr1181095e9.4.1760521300016;
        Wed, 15 Oct 2025 02:41:40 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm28388114f8f.34.2025.10.15.02.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:41:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:41:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
	jgg@ziepe.ca, praan@google.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <aO9sUNYmOg9W2Vru@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-2-smostafa@google.com>
 <526186fa-d17a-4b79-b51d-83492b19c941@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526186fa-d17a-4b79-b51d-83492b19c941@arm.com>

On Tue, Oct 14, 2025 at 12:09:56PM +0100, Robin Murphy wrote:
> On 2025-09-29 4:49 pm, Mostafa Saleh wrote:
> > At the moment, if the self test fails it prints a lot of information
> > about the page table (size, levels...) this requires access to many
> > internals, which has to be exposed in the next patch moving the
> > tests out.
> > 
> > Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> > and fmt is enough to identify the failed case, and the rest can
> > be deduced from the code.
> 
> That is the same cfg information already logged at the start of the test, so
> if it's not useful to dump the actual internal details of the ops then just
> remove the whole function and make life even simpler. (Otherwise export it
> or turn it into a callback.)

I see, I think it's better to just remove the whole function.

Thanks,
Mostafa

> 
> Thanks,
> Robin.
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 7e8e2216c294..00218af5d5f7 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -1299,14 +1299,10 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
> >   static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> >   {
> > -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
> > -	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > -		cfg->pgsize_bitmap, cfg->ias);
> > -	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > -		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > -		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> > +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
> > +		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
> >   }
> >   #define __FAIL(ops, i)	({						\
> 

