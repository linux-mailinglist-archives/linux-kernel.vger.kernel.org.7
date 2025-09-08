Return-Path: <linux-kernel+bounces-806486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F962B497AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6377B7A96DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8B3128AB;
	Mon,  8 Sep 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M7maAJR2"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212919A288
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354146; cv=none; b=GZEzNFX/UNDlYRNNUcGtrgor8WOsVvUDD36xy8lLpqb52KZPOf7tD+iwBC9xggETGc+6ErZJ844eWxpbrJj6xpR+V6DQa15IPC60kvHOlW1oHDsraQLSjol3/jLs0WH1eTYfLeIi63/RRekoBIVn21QYxyjNLdK35TS07dYe3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354146; c=relaxed/simple;
	bh=luD0W/bhW3JJu9+vgqpwc7IpxwiGIuat3uX0AMFM0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh6XwKSXHnY1xhF4VWcrVIYGBBkKd6lgkhpLUPFoYpV1mkv5O9OeWUcIozsq+AibgL6rV96rUa6KsuHQtcZpTpw3UFcKK4N4v95wfPezAh5gJS2tlUWPRKpsh6/culnRI3Q4qyBdTO8gCV134ccJ3y0WvP3/2UGvBzBTTYNz27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M7maAJR2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-73f29c5a4abso22011026d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757354143; x=1757958943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngnzmJDONOgUG1rwcnXYUKxxVO5TVbhQcQIkSu6YQMY=;
        b=M7maAJR2sne4PX3GHo1wiYCT8P/iShBnAh3rop2WTPG3yasONOX9wQY0tjbFhQ69+c
         s1x/l90MD3yzVz+av5UB/86HKABH5ebk4gfj0lYP67cGuH9/4OiWZ5WX1zKjOdHNdr/C
         K9f8EbDoLZ4y0zIc3n+KzhOvOQZ8MHn4gkHLUDIXWjuk5lP/PAy7p3RX9e8YGhAVPlCA
         jrCQqFy47feY7oEr5gd8s7s/cMMHk3mpEX9VczXpR8Dm2lkUDsqR1BkNfSnsY0NSDs2e
         dCNk3ogZ9STfDB0L+VS98URLfMPMSOP/8yWadxFcZDhmf23hO5uguL+i9HLIhHtaXtO1
         afCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354143; x=1757958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngnzmJDONOgUG1rwcnXYUKxxVO5TVbhQcQIkSu6YQMY=;
        b=U/THTpWCx1gYHBEKmwRAIf++v5iUomfbVFQ1IY6jRizTggGWZ2Mpn+ZMPK172svRrY
         +3lUPsaVA/0IE9KWmjorvB9gE5i+8DQkb4sZmlNN5fsgR4rYtH1/VuS2dFZI9xY8DCKq
         wOinAt3qGbPdJJGTrPNghMmkdWHwaNtVLTWuzLWOH1khK8M/q72pT6HnXKSucJnQHl6a
         mbLFKK+ms/H0g1IjefRdEBOpZqZStzPdxK5t/dxR/41OoG1rD8OZt/2nGeM3PeXlBEpO
         TnbWYMpwNDPQH7GUwUVG1HgpkPIGyMbbIE/Kjpyp3cbz12EHKlmtaR0BmtNYibp4PHmE
         Z/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiJphL0vTMYVjXDiKXAWsWTLaVrp+/AHprpQxFdJX7ivSiWb6Y0+sKXZY8Yv6DS16IvPS3+uAyCB4kyxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcS3ZgbW1908686MOnBV+kFbU3m5zPSZHAuuHkcST15F7h7dn
	hUWnluQMYL2NNb4i6lPzp4/nWPQ68JEeAhZnx1BhqHsqIO0g677kKetgPj7c1M/2TEM=
X-Gm-Gg: ASbGncsysrzY4k1w9y3NyR7ZPfYCGUHMYmog7kfA67zlCaNiL20QjGM2L4eRLPZLjWS
	tHd3vR/wSPXEFxRL3xQwQXQjfnNjDJNRBv31EZJIx5wWRO4Vf8NTswmDq1vVamnzcRLJEJRefMp
	5010T6takQXVavEFWVVqpdR9HEX5TXrjeLvb+41JmD+lA1eMIju4XSTfqsFBFitn4BAUX6jUPaF
	XkW6HwxjXEvYIrLpNtsy4xJ+nFOTzWt1xm2gYStQwRDPn1vhDmlCMB83MyfzzxavfpKsuK457hH
	iWYVf/c2Z6Mmx9Calxqjb/kBRVGGLNh0jSxCcgGP9lhAmONI9J7v+d47maMfXOnX7dTzzN5kjT9
	UHYhnMBXNs+Z6GSOr4AtBhbC2xz5oDeeVhoNHBsWj50bpV+PMnDXVEQCqGFM1g1/GpGOy
X-Google-Smtp-Source: AGHT+IE00kJwyXYY2ZwvWXqThymzS6C5sZyc2P+J2HPIEW9i7tRHc/Ygwlxj4g6UeWvVOGWXsJ+oNg==
X-Received: by 2002:a05:6214:f06:b0:728:69f2:dbc8 with SMTP id 6a1803df08f44-7393f9861e1mr86467006d6.46.1757354143607;
        Mon, 08 Sep 2025 10:55:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm119699136d6.54.2025.09.08.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:55:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uvg5e-00000003M4i-2UqZ;
	Mon, 08 Sep 2025 14:55:42 -0300
Date: Mon, 8 Sep 2025 14:55:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <20250908175542.GB699673@ziepe.ca>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
 <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>

On Mon, Sep 08, 2025 at 04:39:13PM +0100, Steven Price wrote:

> guest_memfd provided a nice way around this - a dedicated allocator
> which doesn't allow mmap(). This meant we don't need to worry about user
> space handing protected memory into the kernel. It's now getting
> extended to support mmap() but only when shared, and there was a lot of
> discussion about how to ensure that there are no mmap regions when
> converting memory back to private.

Yes, you probably have to loose mmap() support in this scenario unless
the kernel has lot more work to make things like O_DIRECT aware of
this sub-page safety requirement.

But, IMHO, this is an optimization argument. Unaligned smaller buffers
can memory copy in the VMM using read/write on the memfd. That is safe
on ARM.

I think the need should be made clear in the commit message what the
issue is. As I see it:

1) The RMM may have a 64K S2 or something else and just cannot do
   shared/private at all using 4k

2) The hypervisor wants mmap() of 64K pages to support O_DIRECT.
   Kernel cannot safely support O_DIRECT on partially GPT protected
   64k pages. If userspace tricks the kernel into accessing something
   GPT protected we cannot handle the kernel fault.

Therefor, the VM has to align shared/private pools to some size
specified by the hypervisor that accommodates 1 and 2 above.

Jason

