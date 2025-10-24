Return-Path: <linux-kernel+bounces-869053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7172C06CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47E8935428E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23625487A;
	Fri, 24 Oct 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KXbjyjvi"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F021323C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317713; cv=none; b=GHbj7eBbENsEGedwyTHfoh+AXNpLC9ehchAi7q5/DyNMY7WVAZ+tNlHF1j39h0uJtxVPPrR7Kip1WXvPloytY8QrnQJKxCCweIJRVdqVq/fVYxLfaR7J95J6SmCXC7wsEcNN6HfpLRuK+nHHcwbnM8NTpeFbPCSN1YqJLdm6B7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317713; c=relaxed/simple;
	bh=Sf64DSZxGyAJLjLTgjCXkLHz+iQIUb694K63qXKPMGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXYZeOWD5yrQKyngktAOAHlijClPtLRkzv8+lWu3c4rU716phvNLCzlbtJJTG+miKqGrtdSeU8OzEwZID2aVEEmtooqIHZKsf62wLfMVjhYlD9ehGGM479S6XyCbCGPUEkIjgiYv1AE1CQRkkiDlqigyybQCozDGMuNPf7vuuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KXbjyjvi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85a4ceb4c3dso210781085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761317710; x=1761922510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5NlIoDgDHeWW4rVQCBPgiE2A9f1o4SvVODOB8YPwiI=;
        b=KXbjyjvigc1flnAGcCaXqKXcQWQpNWuLqlvvar8YS7PzUcgW5riFode2BCLV46Fw+I
         4+K7somroT4OgK9Q+f0mgPmI7OYDhQc0sRMgMO6jkCaNmAufpZ5+pYSnU+RxvuDbOKy3
         F+DroUDXO+f9PYtj5kt+VHYmiXlDTtpMU0B0hYg/PV3iACdGVxOCUL54pj9nX04lz5nA
         4pH2yZZbycyDBxcyBOnlm7s9fHzeU3bUBCoWWUU+qBkUoI0AdShWFBjIK/qcIngxQBY8
         dJLF0vBg73gCvhAV9BSnXfxttSVk1QydWoxakH5IoaxfslKzzBGRvA56xYhfD02fwcLi
         TcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317710; x=1761922510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5NlIoDgDHeWW4rVQCBPgiE2A9f1o4SvVODOB8YPwiI=;
        b=O4+9kTXurgtO+nFluwo7t/g84ojlUTqYrbbimXHEcZoVNyUB0AM13UjuW3UWgJ9Cnm
         7gxO3hks43IhzYRwg3TDxNrKtfVAw9HpLictd+q4YcOx/tjFYLLTqx1eYbUDvGlIAHO3
         Km+AIIjO0THqXDecMhK+SdVtugnUQk/oBByURzedw+EBMpDYFI3LbJ9mJb8ObA4J+1PB
         YxVtgukqYwVBWV2xDxYz8+MzPOYpH813NGLeQfA8Ar+utdJoRN1caAfSl+BGtRTz+E3c
         jmXCncDbZYsUolPGlmeg8GNsW3kN8BIpWNbP061JijB6VBfHykBHcZ02qR5KbO7IBFwW
         xVag==
X-Forwarded-Encrypted: i=1; AJvYcCWhDTX+u7OlLH+r+QmE4XrbLMA6hKpND6PbOX9303amo/epCQlkHWiQQeMHLSds4LgJqG3rHR46sWlwQbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZ9NkKdqAP4kTVS4Zf8pneO3KQi8hcYQlnzw00t4bFA7VcP9P
	djzPRna9kYWdt4fjvlaQJPQykS/WlGBC0+nDiDwKCj8SZbR8cqsDJV7yd2LmI7BIDCY=
X-Gm-Gg: ASbGnctevh2Uv5p6fUgU/2YhkFZSHjtMtDCpw3fEUA2Y7QU50YhSTPVScvRQJGzDJch
	k59yhaHWR7vx68PU06nOvFVCDzNtpV3aVtWwHA1gTflyPck0KO+WENQk0ON/qe8GanXDRDFyfrV
	kUdRc7EI/ZARoM2O/GsJryhVl9Y1iN8yCBMDjUEO7xBQcr6NrEIUTC9bZvOCRfwEnMv1a+1/f9Y
	34WncXuSiaHdpIXK2YNBGTs7pCN79Uhc+GuArKjogUp0/gCM47HTKf5hAF69EZSfdtaa34wIaiv
	fQYHBc/9j99L5dCP52KEbjY4ieOq6jd1s1JxUWkeAlQc+h4x8X9Dzs8DHf3VPTL5h5ToWkAbEFG
	oN/tGy7XNNvkRCJXTPu0+Yt/9DgwCcQ2maA3T9uPAqs5HFsVsodybeoFvsfH9e9NBAE67BKYkeV
	VjHZAi9OkTUYhzVnqVaDhqPvN/xgolWNUMO6rtcURlQMFCC7sW74gWZekLJ7PflzqQTVw=
X-Google-Smtp-Source: AGHT+IE8bWbSj+1CYY4XBt2q7DKvHPV/vSXNeg3vYjWLWdmaOWjBRdAAspelX2MJNOVxeS8YnHa73Q==
X-Received: by 2002:a05:620a:2986:b0:891:993a:361e with SMTP id af79cd13be357-89dc25ba951mr300274485a.62.1761317709926;
        Fri, 24 Oct 2025 07:55:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89eadc0ab82sm32465685a.53.2025.10.24.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:55:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCJC8-00000003jd8-3fUq;
	Fri, 24 Oct 2025 11:55:08 -0300
Date: Fri, 24 Oct 2025 11:55:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com,
	glider@google.com, elver@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024145508.GD760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
 <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
 <20251024132509.GB760669@ziepe.ca>
 <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
 <20251024142014.GC760669@ziepe.ca>
 <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>

On Fri, Oct 24, 2025 at 10:36:45AM -0400, Pasha Tatashin wrote:

> We do not zero memory on kexec/KHO/LU; instead, the next kernel zeroes
> memory on demand during allocation. My point is that the KHO interface
> retrieves a full page in the next kernel, not an individual slab.
> Consequently, a caller might retrieve data that was preserved as a
> slab in the previous kernel, expose that data to the user, and
> unintentionally leak the remaining part of the page as well.

I don't think preventing that is part of the kho threat model..

> 
> > > There's also the inefficiency. The unpreserved parts of that page are
> > > unusable by the new kernel until the preserved object is freed.
> >
> > Thats not how I see slab preservation working. When the slab page
> > is unpreserved all the free space in that page should be immediately
> > available to the sucessor kernel.
> 
> This ties into the same problem. The scenario I'm worried about is:
> 1. A caller preserves one small slab object.
> 2. In the new kernel, the caller retrieves the entire page that
> contains this object.
> 3. The caller uses the data from that slab object without freeing it.

4. When slab restores the page it immediately makes all the free slots
  available on its free list.

> > other patches are small and allocating a whole page is pretty wasteful
> > too.
> 
> If we're going to support this, it would have to be specifically
> engineered as full slab support for KHO preservation, where the
> interface retrieves slab objects directly, not the pages they're on,

Yes

> and I think would require using a special GFP_PRESERVED flag.

Maybe so, I was hoping not..

Jason

