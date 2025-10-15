Return-Path: <linux-kernel+bounces-854743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED494BDF48E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F3B500D81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5412D8780;
	Wed, 15 Oct 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gmNFwwwa"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8823D7FD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541008; cv=none; b=PmkC8KPplTQJQGLLYVStwohF4re4lbFqbOEa54hekQgUUKPat6oCa7aGMwmyRpKQqMN5+IAlVPzOwTm6e9NaxDWrH21isntXD9lVEqfK5d3M2xzngt4KLy85CMVhuKaODnbiK/SacVO2d/RiI2utPPDpcx/yBBgqPFIIsMedl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541008; c=relaxed/simple;
	bh=H0JR/dA7pq3APucJyEmbtctldjfu0GEcZAibz+CTRWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDdJzl+UOiwk3WZpyTHiI2BjaY3g80KJ5G3qab/umb/CuwNGIk3VQhN/KdnyrMxW2VcVk+jYznyBzcPpyV54UpRsJin11dfGdCwd7nZc8f4tgDqCIF0evu9ViPyHoToH1vbt1DnIHkIHl/fxN1nR4BpaaqVZehjdLSKAqDFOQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gmNFwwwa; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8608f72582eso484229085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760541004; x=1761145804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILwpaE+T5XpzmGXk5vDJm+k5n9Pb/8cfvXWouFnzCso=;
        b=gmNFwwwaQK8g4wjZjuDbqhUXwtWcio1gQdd+gtKDbvfOC2Yk6N1SYEapPgF0cma9S+
         GU1Qvo+tWdT12zFOWD0eaHFaWuq1e1Gml11xOpnhrJPQRXlxo/I62ZIixCWxDGqpKgHC
         YGiPSuLNUEMLMaoxqeOFNq6YCfSo+qQhG3mUiHan+VlauVbfGzMrODbpvfZrwP55G1hw
         bPY69Qo/TJAxjwunvo0y89zQxWAUi/3EviR5LO96sExX6WapspMvjfYxip5o7Qu2tyDr
         5D1Obr8gXxKxzcpAWGIrhlVuEwDW9cCY+1dEvicyCsKxb7oc0r827vH/AC5EfWYqv6F1
         Kz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541004; x=1761145804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILwpaE+T5XpzmGXk5vDJm+k5n9Pb/8cfvXWouFnzCso=;
        b=dynuwi6FgD72nz9ECCjhsMTKzXtV871LDeZRMxlCdqh+51DsSIWEei6o/7+SZteHn8
         IqX5Z+3rmTd6Ns/CNseR2b2nk+gSCu9h/ahW+MYpCx3rGbM/dfukC2OlpST1pS/0VYR2
         AYCgFL+tjfyzkNRbCJrijRr78Z+uPhcoIEzLg330pxfesaSjX9YE8IS/opJ3MLApzGW7
         f7v584BuppugY0h4BEsSiqcbYJvo4oPRtwPYWtm9+NY8KLCDLnCITGWtiqrBZvyynWfC
         YxSPB7zIYxKzvPNxplrxG4yBmBeVmpr8Qd8/Qr8ylazihqaWaQzF1U9lc5+pa9MOoaxO
         EGzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJaIQotYu9uCyuqDdOvv8eEOG0RPfHIO/doOa5JTbL4RoBW2Y5lxlDFNIvBCgOzm2thHxCW6hgWVgAjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLR7Bh2ZVdBjhzoNhy0S4o7PRPj0hwTom5n7I2VOe9Kph+IxK
	WEUABWs3raM/EMXrlEB/l9oToDZu1RpxOL24/m7ZM9XnKO82HRBxtiITy/9yT+0sss0=
X-Gm-Gg: ASbGncvpwV5wVBA79yspZM7xMi9JjAc8zpAuRZzjwG0eorW/hqTdhUe02bi7WYfNRH1
	b7T5jmaeD7gSuEdvq2+L/nlkg0XQF3WZz5ELwMqR9UsBz7GX76zAlG/nkdSjy69Zr3+4rZQfS+E
	6SgaWqJXfSZtUtO0+FvGo3xw6Djho5ZerAJ83cYaG0XCzhIyu6bSF5ota3DNbVl29/a6qz/TZ+X
	vTDjg6g3q2BToKvKO0Sznim8Kpme4f7RK6KqYG1GO/DycHdBEX226w+sC3f7CeAjCgVaRgfqwBC
	MtOn89K36rlMun1IPWYBQYPh/COph9S1gKtY6KhqVXjg56EcAbcW65OBG7ohhf3+3SSR12Wu4El
	AHrvxcKYUNfiHGYY=
X-Google-Smtp-Source: AGHT+IGT/kELmEXYXPGlJfuB2PbHSRRnqIl4KI4SjW2i78+LYVAn+gH5X+YwxfAWjMG/wVMJe0rtQQ==
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr385756551cf.24.1760541003496;
        Wed, 15 Oct 2025 08:10:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c577e6sm20528841cf.7.2025.10.15.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:10:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v938c-0000000HRP6-0a8o;
	Wed, 15 Oct 2025 12:10:02 -0300
Date: Wed, 15 Oct 2025 12:10:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251015151002.GH3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>

On Wed, Oct 15, 2025 at 02:51:15PM +0100, Robin Murphy wrote:
> On 2025-10-15 10:53 am, Mostafa Saleh wrote:
> > > Conversely, this is infrastructure, not an actual test of expected
> > > io-pgtable behaviour, so I think just:
> > > 
> > > 	cfg.iommu_dev = kunit_device_register(test, "io-pgtable-test");
> > > 	if (IS_ERR(cfg.iommu_dev))
> > > 		return;
> > > 
> > > (it doesn't return NULLs either)
> > > 
> > 
> > Yes, I was not sure about this one, when checking the code base, every test
> > handles kunit_device_register() failure differently, this seemed the
> > most strict one so I used it, I will update that in the next version.
> 
> Yeah, my impression is that those have likely been copied from the
> lib/kunit/ code where it is actually testing its own API. I've now sent a
> patch for the example in the docs...

I think any failure to run the test should be reported, either with an
err or a skip. Tests that didn't do anything and silently report
success are not a good design.

Looking at the existing users I see alot are in init functions, so
they propogate an error code and fail the init.

And the rest inside tests do something like this:

	dev = kunit_device_register(test, dev_name);			
	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev);
			       "Cannot register test device\n");

Jason

