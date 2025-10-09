Return-Path: <linux-kernel+bounces-847361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BECBCA9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF55C350505
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59C248867;
	Thu,  9 Oct 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IinhdPH8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E121A95D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036178; cv=none; b=BNVsXftxPLkFfT4nxIXk+D1TB2IXus2b5g8ExfPgr+m3N/asSmeL8GYd6betbaIq+gVGpfWFk8ZPJ99Sydb8rJoxXq2MMsgKsxrl1k5Vv7eh+tHDo2nSz2obXwHT7vif5wBK5p9UkIzDbzYOW58sPHsn7tqUwKGQiMF8zX1tGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036178; c=relaxed/simple;
	bh=4iB88tQw2WXsZzzM6xK3yQGqAvESZ/GXQ3GjoVzeMlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlJtHMyKwZmGF4WNINPPfrhizdhCdVRYBa+xc0hcPAol3EsBTXT7wOiJg3rIEASdvuNQHK4vxqRYrzvYWpJK6NTrRMGzjUWsz55fsTku/QUnn2p3npRD/6oKvM3ln/amTB8YEIWftCXB+KfG9wVUx93xYnCgeyLZoo7M49aX358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IinhdPH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760036175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73VHJPHIbh12PnyxfeCzN+eZOdvnFxFQRvkYUUFjG6M=;
	b=IinhdPH8Tazv+mxUKMAWYZmuw/aFfoO4o6MVU/4HB3XAiOfQnenv46Iy3qdcV48jKnW3tP
	lVYjp2CkqSXS2iG8zJzseuyHFZFG/p96BihQHTNhgL6RORU63Tkhf2c7K+CNilbwUooutq
	n2TuEGeKYZAUFT1UG3iOdvrttfNYm+Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-jhVYExrWOD2Wl5I8TiN2Pw-1; Thu, 09 Oct 2025 14:56:14 -0400
X-MC-Unique: jhVYExrWOD2Wl5I8TiN2Pw-1
X-Mimecast-MFC-AGG-ID: jhVYExrWOD2Wl5I8TiN2Pw_1760036173
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e6e4f29c05so61997311cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036173; x=1760640973;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73VHJPHIbh12PnyxfeCzN+eZOdvnFxFQRvkYUUFjG6M=;
        b=BMUOL7HY6IkG5mIF4IMyfP/7Wkr1imA3SlYQtVa8cZETOt40wt0YqulcOb84G/zdwZ
         3Q6ERek/3sQKWaGXreH6gXX8iRMHywjOYpCKRvehbYTJXFAj1T1uiRAFSW4HZ3qfET70
         WwQqQucHuRYE+qP4taVmbPY8PslDMkU6Kie5cgmmLpD9GR4i8e60u3bXZUcQUfU8iMtD
         7r4bLKjsF85SFf/R5w0XtjBZyIGlzwWkC7dLWGXUddhyJqtjsYkanE8Jyr/IY6MfYC/Y
         sYBtjM5Ge3ZTYdjm7GFIiBW7jiYiAinwo9YjkHzsxFJrOGKwUSxh0YjpG/ZBYVrKeIw7
         LK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWntAv5u8UzG/bjouui6Ad81bkdWFJHzQh8B+wEUDfYdLzva9pI2PwbEaJv4NvhP+4UldbJksVPhHG8CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeEMW2h4r8fuLfiIs3QOR4CRj0n84Gw2ADYPrNgdVhyNu5bbi
	dKyEj3eEnFa8oE4oGQiXxZVm7rWK0jIT3rpLV3KIT9boFuKgSN8sbiZVZDEnnsyy34G0ssGGytX
	RzUCcYRBYDce2tWihEAH+fGsNGrlZ8g9YQdPtJO0Ejd3UIOmJhuiJ0Z7e2kHEG8ONQg==
X-Gm-Gg: ASbGncsz4DibBTBuswwJvYSwMYk/+KPlFUdS+vEPm32PSDhmQi9b8lvMppyX1NsV2xT
	RwFPF5E2D/ZtCabJpPmRcbZlgUx1pxRAaxqmT/85rwRZfY0cn2Sfy8HiIH9+qMNxRK/td3edI+y
	T3jugsFGZZxNYzYsaVwcASpy4iqe43IBlvUXcGJfayCrXf01dVzrr3DNzyOX0amZ2bDhuyY6wXP
	LmhzKOgyz60YObAZYh3ol7bko2cLATq4T6pafm44PSz3aE1+95jmmZXRIkYu5h1NzZpmOl+hrgf
	h4b7uAHxkmP/Sms/krsR2JRI7Fv/Vvkrf1s6JMGfPK4nf+DPKtmUtjlfj84UgF9sWi51oegZGNf
	mHa8K67TY44HwPRmZLZMuxGy2YoLx4kBw5SWi
X-Received: by 2002:ac8:584c:0:b0:4e5:7bd4:1beb with SMTP id d75a77b69052e-4e6ead65549mr104456761cf.68.1760036173459;
        Thu, 09 Oct 2025 11:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2AD5ZZcXckeSU9b450Mt8BqD9SOhoclS7nRF67Cec3FIHzgTkgVAjC1MmE6pVFS6HrvZ8kA==
X-Received: by 2002:ac8:584c:0:b0:4e5:7bd4:1beb with SMTP id d75a77b69052e-4e6ead65549mr104456441cf.68.1760036172855;
        Thu, 09 Oct 2025 11:56:12 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706dd1ceesm3026011cf.41.2025.10.09.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:56:12 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:56:10 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tests: Add tests for clk lookup by name
Message-ID: <aOgFSi_h95tfD8x2@redhat.com>
References: <20251002092036.2504858-1-wenst@chromium.org>
 <aOb6iNR9T4R9Hp3R@redhat.com>
 <CAGXv+5HPjEnYh+zUi67+Y=nmFfdRFw0xd=rT7L_-GNxouga4Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HPjEnYh+zUi67+Y=nmFfdRFw0xd=rT7L_-GNxouga4Ow@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Oct 09, 2025 at 11:24:22AM +0800, Chen-Yu Tsai wrote:
> On Thu, Oct 9, 2025 at 7:58 AM Brian Masney <bmasney@redhat.com> wrote:
> >
> > On Thu, Oct 02, 2025 at 05:20:35PM +0800, Chen-Yu Tsai wrote:
> > > Clk lookup (by name) recently gained some performance improvements at
> > > the expense of more complexity within the lookup code.
> > >
> > > To make sure that this works as intended and doesn't break, add some
> > > basic tests for this part of the CCF.
> > >
> > > A new "clk_hw_lookup()" function is added purely for running kunit
> > > tests.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  drivers/clk/clk.c      | 11 +++++++
> > >  drivers/clk/clk.h      |  4 +++
> > >  drivers/clk/clk_test.c | 66 +++++++++++++++++++++++++++++++++++++++++-
> > >  3 files changed, 80 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 85d2f2481acf..a17d0070d11f 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -778,6 +778,17 @@ struct clk *__clk_lookup(const char *name)
> > >       return !core ? NULL : core->hw->clk;
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_CLK_KUNIT_TEST)
> > > +/* This is only provided for kunit tests to test the core lookup functions. */
> > > +struct clk_hw *clk_hw_lookup(const char *name)
> > > +{
> > > +     struct clk_core *core = clk_core_lookup(name);
> > > +
> > > +     return !core ? NULL : core->hw;
> > > +}
> > > +EXPORT_SYMBOL_GPL(clk_hw_lookup);
> > > +#endif
> >
> > Use EXPORT_SYMBOL_IF_KUNIT instead for consistency with the rest of the
> > kernel. In clk_test.c, you'll also need to add:
> >
> > MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> 
> Didn't know about this one. Thanks!
> 
> > Since clk_hw_lookup() is only used by kunit, why not just put this new
> > function in clk-test.c, and use EXPORT_SYMBOL_IF_KUNIT on
> > clk_core_lookup?
> 
> Then we end up sort of exposing clk_core_lookup as well?
> 
> I believe Stephen wants to keep things contained as much as possible.

I agree about keeping things contained as much as possible as well.
clk_core_lookup() would only be exposed to the kunit tests if you used
EXPORT_SYMBOL_IF_KUNIT. Definitely go with whatever approach you think
Stephen will prefer.

Brian


