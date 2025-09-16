Return-Path: <linux-kernel+bounces-818972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B82B59913
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CF74638C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE332A822;
	Tue, 16 Sep 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5WGHg2k"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B322D8DCF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031754; cv=none; b=Endmz0tjZMO01GcYZ38/c1PB24KXdli5dLW4lMSM83QowFSizWma+1opbUOmcx94XNy+BQ+IHV0cbf/tqaJPonqh02cEPW7MUuBa9Q5Ccc7LPU+XjambmSEdoMvqgd4M/VwCuJj9EwumzWMGRM0ZGjpXYI92YY2UgI7oz4ZDg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031754; c=relaxed/simple;
	bh=OivZHE65qXE5B/vTKRFEaDN3nIm3K+Gd2wwZUmavPgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIAAOz1+/4y6ZMsBDCEUEu9QpOcefmPiaM2acCiBkaeku8bfCBWJ52hzM7Dg+zNGo8tI2tHiZWNJeYbHroDmiA6Dx9Zr8U1lJ0mBkD5nCu6PZYGfzRYYvnvhkOl91Jf5Y4LDpBT/hDqCRIKfOHzuC3I2g2q3SplWu6VX1BXpggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5WGHg2k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2f894632so55245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031751; x=1758636551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naxnlF8RW3uPyYwaOywJDf3OceUlrkorGyjKAmqFqDQ=;
        b=l5WGHg2kh93ISZTBU8PE2pdVza+IWCPGDvHrgi/NsBDJSCuF9M7B/sc6PpA8NzQSqk
         HCzxkfyrGx0Niqc+aibKkWyq1Gu+UcGlRiLh3hVKBXmQ5spEoZdSanSZLWBCjdEjvwu6
         Z2Tol+v7zF4zA0TK08f3YrqZ2zQkqwGNZfhGLbLTG1aMA9ZurZvbQJNxCI9UBYgi+X3z
         /uwwqoWey02+33l3imalvqzkH7csWVvbA9ygBwOkwhKxeilxDnGCthJwhoX8dbGEQtYR
         SauTPlmerFfqJIpIrdDb+uBAU5w87k7lwHsNdIyBEbDBdJwRNPcCXuYwOmfkm+DP/mbA
         nAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031751; x=1758636551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naxnlF8RW3uPyYwaOywJDf3OceUlrkorGyjKAmqFqDQ=;
        b=rg7brcwp+5DI+AUNeNVRe6En2dJGIaNxtlZ8z5hrtR+5H1ETkOmVBUp9J0Zma9k+GW
         XfPRR8OXZknMI8z1LqlkYl3OP3+0sb8Iek+sEHrmAC5lEGBDV1jmkDypIT9OBtw2xE3y
         1tmRZyrT00N7cxByEFHfVWFjGIXY/d2FjUbq93lNCOIVQPPgmVW7NzXIx1nfGcm0VOBY
         pAobObIVNLzCIBAKhX36xLXKykDgUYkSHXp8E3hrJvmjQqjZMoar1cNw+uX5jSJKJjRs
         wLicLnMbKZjPANOgToQUePflCvUzAZ7PDogwxpBBXpWm0liG73vo0uumhvfU0JqcJvDa
         IyfQ==
X-Gm-Message-State: AOJu0Yxr7+5xc0qFa15d42MbDRw4mT7nAcouhDWKboBUzhYp+i0sufef
	SRJmqUSfZkln2aqd9Gbk9p+KbLiO5G12nBLGst4daE1CNsB3zUPIx2bVerm12suKaA==
X-Gm-Gg: ASbGncuM9v3YYr/6/tAYhQWvY8RwLOGMDAUYQp4SEosjq9dj6FqecKX+FGl7CxYrJ7O
	kvQnKCiV8tkr/52Qurp/YNeaqblfQUcMWJOKOHIhayOVkhaXCYrHrt8noufD+knpy/P8vMmIcXz
	czvi2jcXIX1FB5VxouJP5wcUVJD06/iLFP8GQtkA4BlC49xXIU7401UoaPA25/GIBPw1mqfR6DY
	QIawgWtL3AlZhUZ/U5IJRKja4R25JtKBRPdE7WCWu836xxZOq4vHhYrJeyAZvBo12h8S7/gMeV5
	iJVr+Ao8Mon1ASIaU26UWAZIUihr9XnlPqfDeTK4zq4TNVWUd2vE2hs5csP7sH2jWhoymTESsym
	fNg1zVON6R+CJVE4ZKZ+hg18mzwo3wKnZckYs8swI2KZhGlC7FmsCmVr6fzzCgx4STEM2qA==
X-Google-Smtp-Source: AGHT+IHiAMHPDFkAjiAxoWmA+0eW1WUNEbjO+yxVuqDckIGe39OhDb7FDlwQGK8b0ego1xO8BRYMfQ==
X-Received: by 2002:a05:600c:4689:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45f320079e2mr1928645e9.0.1758031750409;
        Tue, 16 Sep 2025 07:09:10 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm19395835e9.0.2025.09.16.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:09:09 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:09:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 04/28] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMlvglecB0ZA2fmd@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-5-smostafa@google.com>
 <20250915164517.GL882933@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915164517.GL882933@ziepe.ca>

On Mon, Sep 15, 2025 at 01:45:17PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 09:51:32PM +0000, Mostafa Saleh wrote:
> > Soon, io-pgtable-arm.c will be compiled as part of the KVM/arm64
> > in the hypervisor object, which doesn't have many of the kernel APIs,
> > as faux devices, printk...
> > 
> > We would need to factor this things outside of this file, this patch
> > moves the selftests outside, which remove many of the kernel
> > dependencies, which also is not needed by the hypervisor.
> > Create io-pgtable-arm-kernel.c for that, and in the next patch
> > the rest of the code is factored out.
> 
> Please send this as a stand alone patch, it looks like a good idea.
> 
> Also please add the boiler plate to wrap the selftest into a kunit and
> use the usual kunit machinery. We alredy have an kunit for
> smmuv3, it can just add another file to that.

Makes sense, I will do that (hopefully before the weekend)

Thanks,
Mostafa

> 
> Jason

