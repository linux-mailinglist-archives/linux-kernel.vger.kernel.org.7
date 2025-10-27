Return-Path: <linux-kernel+bounces-872318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E44C0FE93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA893BE597
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B42D9786;
	Mon, 27 Oct 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNdsIKCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2E2D8DD1;
	Mon, 27 Oct 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589356; cv=none; b=PyMVTVegrH2s+bH652rm75MWtfSw/TlLF2IDXpp1qOKrIxI5/GJFzm7hFYorSkxdmJtckhvt9ZZgAE8Z/UbUFUNbu1GAKwELuoTLS2E/ST92da06OBz30FS5NTw01Gs0AZm1uWPqGLA4xnhyurT2U3MTz1VRpDX1q0eIQcMPTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589356; c=relaxed/simple;
	bh=fXCVp106DkN9rGalfhDUXdv6WsG1hGhTuPCwIdmmJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTfNt9E+JWTy8NZKNUr3pl2TGZN+A/zpqbt9zTm3LaJ+YCJYU+pYwVu2fvt95kLepx8oegzUHO94ya+bPfL35j1Yf2E+4bID5R2EyLPd8rkRH6uOfl2Q5lENof8f6e5H7yfzgFzbNU5zCMw6U1FlpcVym+CKZvUeQ5WQKs9VlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNdsIKCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F1C116B1;
	Mon, 27 Oct 2025 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589356;
	bh=fXCVp106DkN9rGalfhDUXdv6WsG1hGhTuPCwIdmmJ+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNdsIKCLGZ4cdIWaCc5S/irpnb3DmG6FkZl1o3o+J8IBb0k5CR20Pg6+wDetOhEDt
	 r/q5XGcQB1rIQ/kGMit9veAw3I813BRYv+UDWMGCOMkVflJLUCW59jsG+47Mc2gYgm
	 I3I32ouDMmE1vt0SQqN9bwYB8eq/8faEpjquTpKDp2WONmqYu3S/kJgEPvt20SR64P
	 UU4XVnBCg7WR0Pl1ZoghGCQWkwVf6PxHUuq3Xkp/G/4+vp2zKOBKsNwyjrk68tCSWY
	 44LzZjSK14iWF40dRlav/vRzFvX+JdUzQyNS2ZYOJWc0bJxa6lXXCxw/HSpfD4Daw+
	 gkXWG3sH9XiDw==
Date: Mon, 27 Oct 2025 19:22:31 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 21/21] Docs: add Functions parameters order section
Message-ID: <xpo7v5l4nw5b3ijjgk4o63xukkeyv4bqp65gu47g4beszetczy@2xvdgy4u46tt>
References: <20251025162858.305236-1-yury.norov@gmail.com>
 <20251025163305.306787-14-yury.norov@gmail.com>
 <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>

Hi,

On Mon, Oct 27, 2025 at 11:02:48AM +0200, Jani Nikula wrote:
> On Sat, 25 Oct 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > Standardize parameters ordering in some typical cases to minimize
> > confusion.
> >
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  Documentation/process/coding-style.rst | 48 ++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index d1a8e5465ed9..dde24148305c 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -523,6 +523,54 @@ below, compared to the **declaration** example above)::
> >  	...
> >   }
> >  
> > +6.2) Function parameters order
> > +------------------------------
> > +
> > +The order of parameters is important both for code generation and readability.
> > +Passing parameters in an unusual order is a common source of bugs. Listing
> > +them in standard widely adopted order helps to avoid confusion.
> > +
> > +Many ABIs put first function parameter and return value in R0. If your
> > +function returns one of its parameters, passing it at the very beginning
> > +would lead to a better code generation. For example::
> > +
> > +        void *memset64(uint64_t *s, uint64_t v, size_t count);
> > +        void *memcpy(void *dest, const void *src, size_t count);
> > +
> > +If your function doesn't propagate a parameter, but has a meaning of copying
> > +and/or processing data, the best practice is following the traditional order:
> > +destination, source, options, flags.
> > +
> > +for_each()-like iterators should take an enumerator the first. For example::
> > +
> > +        for_each_set_bit(bit, mask, nbits);
> > +                do_something(bit);
> > +
> > +        list_for_each_entry(pos, head, member);
> > +                do_something(pos);
> > +
> > +If function operates on a range or ranges of data, corresponding parameters
> > +may be described as ``start - end`` or ``start - size`` pairs. In both cases,
> > +the parameters should follow each other. For example::
> > +
> > +        int
> > +        check_range(unsigned long vstart, unsigned long vend,
> > +                    unsigned long kstart, unsigned long kend);
> > +
> > +        static inline void flush_icache_range(unsigned long start, unsigned long end);
> > +
> > +        static inline void flush_icache_user_page(struct vm_area_struct *vma,
> > +                                            struct page *page,
> > +                                            unsigned long addr, int len);
> > +
> > +Both ``start`` and ``end`` of the interval are inclusive.
> > +
> > +Describing intervals in order ``end - start`` is unfavorable. One notable
> > +example is the ``GENMASK(high, low)`` macro. While such a notation is popular
> > +in hardware context, particularly to describe registers structure, in context
> > +of software development it looks counter intuitive and confusing. Please switch
> > +to an equivalent ``BITS(low, high)`` version.
> > +
> 
> GENMASK when used for defining hardware registers is completely fine,
> and *much* easier to deal with when you cross check against the specs
> that almost invariably define high:low.

I fully agree with Jani here! When coming into describing
registers my brain is hardwired to read values from left to
right, high-low.

Linus suggested also BITS(start_bit, n_bits) which, in my
opinion, complements what we already have.

We leave GENMASK to register mask descriptions and BITS to the
rest.

Andi

