Return-Path: <linux-kernel+bounces-822645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A52B8462F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F693BA715
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73B303A32;
	Thu, 18 Sep 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tjr8pLXw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4F302740
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195718; cv=none; b=HmOToB8bA6Lp1myqS8N3XDxpg36oUjHqiAnB6yKgMJQytlaYVXiO6MgJs3jb8ZdLbGxK2RMLC+0uYqkOEDHXFpJ92XuSiBd+qYcuU2ocX2AJcEp+OTVLFyT9vWy1VbXQjW2b1p6vKWCbMb8FrTWIJAqR6egxXAfjZyTe/ndC1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195718; c=relaxed/simple;
	bh=7N0UmSdKOHAaSXIPk6et3/EoSHnVMaI/hTlcSmus18k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3YKzdvmo7VhdyTS61cc2Et+DN+wrNgX/O4peRB8U6+06AJLYFEaxTSqWlyRDx5eT2q0c7kk/o6XYgRcjA31YL1ZP89AUspoVz90w7H+YJbJ8uVn7wqwwTUFWScunYR80tqpkky1SL/yqGJF1Im68AdYJVWK5Cqrg9wKDEdHDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tjr8pLXw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso54295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758195715; x=1758800515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8l84kyRuuCoNVc5N+ElWv18ENe/Xi0Yvo10Z8affNw=;
        b=Tjr8pLXwFxxt+R7IU8PjnzsdXEynfwP7+das/n4+Ucnm+sVkBhVJm8jzHi0Qkk7XtB
         3vaDUuiRaUpmBDyrMShphP/tnKX2nXv0hJ5Q+AKs4rL4d+KBoVN3DD6OnarJqYieI6Ti
         U5woaE8rAfPz15XH3iLyO5qWg5la5+zJgKySXHtlTLjlA/ZKmGz59cxqhougYRtqOmJY
         XvyBxXPC5oxEA3cliinBoYMNicvIzQD7NAb1hTyOnUpXFSZFA19p6PIRyGIfY2e5NvfN
         Mky+xRlwKeQJxbhC6+mgRAxrSYfAa7VHqhzoFGiTB+R0uSeB7KcuEBqXbR+StBR/sgjr
         Lp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195715; x=1758800515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8l84kyRuuCoNVc5N+ElWv18ENe/Xi0Yvo10Z8affNw=;
        b=YSXaWdxhnpFYYXxSDu53UOTgzkm7iaJ8XRDYFz/AZKPt2tY43SO7cpvTfA6Y6PqaN5
         i5bsAMXej59klqAQABbEsem1v0+1MTjsf7HfirFs38OVWLy+nNMItTraDpB5WtXw1INg
         M7U/xKrozD9/b3FAsP3k2DA3aFSrN1i7D3QOKP5pEeknLQH8QQQSqoZIHYWCxVHuFWAC
         dYI75ynkGkvPqma+e9LeXqwB1KY14bHirWv3oH982ZA6ZzNlN5CTtsjI+6Fz7L9R+J/X
         fkeu+HjmkTs3Ed7GNScY+/Ym9FCa2Tqquf3WZm/6/CGLkRKWQVg3jtkU6UkjF+tL2aA+
         GWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV37t+elK2lrPLAO0soEHxfkfr9tAfs0s1mEBdG4h/gflZ6GjvVXB1LmHwuJTcGfHvrHzFBOAxj7W5EzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3Rxqz32RpllLxvOPLPhGjg4C79vWwPe1x75oupucSkjmWGWT
	tGuSBbJpUbQx1UrITOf637LcQjjc9VtdQIboFfwBl1rcwbvUVXP0y7UJFwZTCtqn8A==
X-Gm-Gg: ASbGncvimSsv50k61WQDU32CNqghICRPLYZYmiIzraiVlZeDfLMu8Gai+OJV45wJUVU
	hLjlwH3uvehtnxhxN6aCrPQJNmHGINpUj/UbopwHI5BPvQBfmp9r9LPpETn92U5aSv4S9uu8sAm
	ZEQsEjk1GaSeeTqrNsABbChQ8PSbZ8fc2cmkKxouEPcHXD0/V/gNr4z2KKZXdmRHEKRBok4ltoz
	100uazt7qA3kPbAwQHOZyRSvv6lIZChWZN7Dkjq5TThgMj0BhODWq3+pvyciULZtpWMRKhLLULd
	0+XIGtHqxk5Fz0nF3XrCxMclJpFNaww+EOqr/yUe+B96nxDDCGa+k9yOqswbvOOYRXz29qnBBgi
	vIfiVnzEH3f3QNDyx2/8AImq3qhET2Ia4jX8Z6f59eFSNbZwXER+GJO9wmdt6LvRyDSvrLVJLlx
	tDBDD2Z9OrTstna09eM/XhhUg=
X-Google-Smtp-Source: AGHT+IFo++kIW70zN9Z7jaqR2wmSrLihbXgI8ryzk1jKjLYdejG3WXIUw1J2WnvE7qB1mOgjXOYq2A==
X-Received: by 2002:a05:600c:c4a5:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-461548788a0mr3774745e9.6.1758195714750;
        Thu, 18 Sep 2025 04:41:54 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm42958055e9.5.2025.09.18.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 04:41:54 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:41:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMvv_u8HXAV7tbYz@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
 <aMsX_HafW3rLs5dQ@google.com>
 <20250917214824.GN1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917214824.GN1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 06:48:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 08:20:12PM +0000, Mostafa Saleh wrote:
> > On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > > > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > > > +{
> > > > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > > > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > > 
> > > Can be:
> > > 
> > >        struct io_pgtable_cfg *cfg =
> > >                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;
> > 
> > There are a bunch of other formatting issues here also, but I wanted to
> > move the code as is, so with “--color-moved” you can see the exact
> > difference, otherwise, it’s harder to review.
> > 
> > I can add a patch before to fix those + the printing as you suggested
> > next.
> 
> Yeah, I brought it up because with the above you don't need
> arm_lpae_io_pgtable
> 
> > I don’t have a strong opinion about this, but I am more inclined to
> > keep the prints considering it’s a low-level test for the page table,
> > and such parameters would be useful to understand the failures.
> 
> My general view has been that there is alot of debug prints I've added
> to kunits to debug them but once they are debugged I tend to drop them
> off as they may not be useful to debug the next issue.
> 
> > I know this is not relevant to this series, but the KVM driver will
> > need to expose arm_lpae_io_pgtable anyway.
> 
> Really? That sounds like wrong layering, why does it need to break the
> iopgtable abstraction? :(

Oh, not any more actually, in my lastest version it's just exported
for the selftest, sorry for the confusion.

I will respin v3 with with this patch leaving the arm_lpae_dump_ops
behind, it's a bit ugly with the guards + the exports, if Robin and
Will are OK with removing it we can just drop it.

Thanks,
Mostafa

> 
> Jason

