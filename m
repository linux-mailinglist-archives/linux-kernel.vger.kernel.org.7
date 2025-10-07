Return-Path: <linux-kernel+bounces-844456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B6BC1F59
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C383BF927
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233E2E0B6A;
	Tue,  7 Oct 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4eCpGq"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C021CDFD5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851667; cv=none; b=P7JstmAz/dTMD1uHhhs9UpbP3Nkm0SOXvgmEkHbxyho5EVrShrwd0E3mVsYNfb1ERtNNFyZBuaQMn0chgs7iVCELWPmD2oV9bFa9HDREUcmMAw+uxiovhre1fFKkwiZw73h5HbfiNWVz7GjVAfbS2bisy6NZM0vlyuUT2/JisHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851667; c=relaxed/simple;
	bh=iNu98HKK2L57s9hGTaSY466cuEN56nDRJlrrqiSnXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF194dM3VvHc1CPOp1/fHpsvisNg3WNySfMQ0gUSS9MDmhkXHVeRuIBFg3HMCsYjcLbjq5vOHFWsq3x+IJOy++r65C3eIgntqNnv69/NhL0T0hGhfOQGj03D+hQua+WrLd0Xns8jwydFBFrAs7jEDfEnFTtjrgWQCWPI7cNGxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf4eCpGq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603acc23so70820977b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851664; x=1760456464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaFNh20XxOdj2oQlwRRyR9v75gYMq+FkiOKklphUgxg=;
        b=bf4eCpGqlXhXjqnf9I7CktxuU+cC5APkWLK6ByMYmnuaN8PINFGVDr1vj8zEpgv6ET
         888M6vr4rROiBd208290slnu1cjkvLeF8P2K6cBTC52Jmm/OHUhepk3GLnzAtcBhH6c6
         lZnWtbg2TgPXr/pEZUsdDygsap3h+KHBkgqebsOe84EP1VcBHTc9PH7oR1ivCUUwhlgX
         6gsI+spiBJe6BihwUA96l1rBAy+IXkqNX9tQAaKCIldyLzB41w3t76yXiOimRk2vxPZH
         H5AzsP1XdR/HLiPgTPBeRWO7tC2F6bLYyBU1bzpfs9nYKIrQM4t+ZFKp8ihdxr5uoMV9
         YZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851664; x=1760456464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaFNh20XxOdj2oQlwRRyR9v75gYMq+FkiOKklphUgxg=;
        b=vPr+l9hGOfb4Pmuw/NDA4EDbOM7n4TCPwCnWz//HEHk8IZn3jpP+fY1Y6CO2pExijt
         A4oEMPnCRRlm2BZK7GoDPfuszMV5sM6GbsImtGFrR8DY1x/wxLHyMKSDzk2M9w2pN0Op
         u++8n4j6qXOBj8fzKjdof/j5c3OcF1am77m58jUO2aMDkopnQlGe+6t677FASMu95WR0
         er4NbWa7Q0H4gVxYo1Tc29y8yCOyRQ8JacFVKOdkfTysaZMcy75B4gmreAXrZy3dZReU
         y0QUDwRxHh4ukeYAczemiH5sTCCqcWd87WgB4zWdxqJVuo44rwprN6pi2voQnLKL6iEJ
         3eOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdTqFfLVa7VtyxG2aIoK/gMHRL6q9sxlNm4waTaVsy9JF6SyabENaTUcsrbzh0dyE3wULcYSTXz4Xd0IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3foGC1VL8c/yvLhsKW8QtYw/kGrUqt+aKpER/Trix1kd+MA+
	/sHdtD28IaK9tPmkNR5fo5UY4VgGR6S/QY+d9u96BcZdsZSU8lXiYsyF
X-Gm-Gg: ASbGncscmQGTSW8gVBrxfty9BLVansYPSVVOt8Gxf8no3wH0Zo6xY45W03cFnky0CGR
	EA6Zb0yo3wK49oZ/y8mUCGRteXD6gxCqNklK5IW6cHU1znndMzUqr/ls2vdSl4lpIbsniusSHzT
	ir1HowwvIV0fAKqdS83I+JdJHKt9qURNos75KKLAHSBHyFV7O/iaFgnvMX13OmgwbwhBLSwCTtV
	1d+uQF/GQAJsYwHYpx8k+vU7KXLBcjitRiZP36knJUi/eK0WXDWiWVq4ZOyY26DLRyZ7pQCWCZ9
	S8BHC25chLRKK7fNP07Q8xHgSPux2FvkmrpeAb2s6hYEpl92YmRkfcPXnLDPn/lrYMl3RnN3Hrm
	ktIo15LGwSbpQ4QHW+PWNoOUv0VPY/tpTAmWclrvP4KT5FUY+BFSOhziofphjf6f+kuwwBMo0TP
	dU4Ng=
X-Google-Smtp-Source: AGHT+IEkcHgYm3I1MFNRw2OsYxWZ79jw7Dqd1n6B3m6dIb5JmohqIcLJaaJ9AQ+WvnlX2m3w3mdRiA==
X-Received: by 2002:a05:690c:688d:b0:768:70a1:46c2 with SMTP id 00721157ae682-780e15f2ee7mr2747787b3.48.1759851664152;
        Tue, 07 Oct 2025 08:41:04 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81d342basm54065697b3.48.2025.10.07.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:41:03 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:41:02 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <aOU0joJQZiU61GBB@yury>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury>
 <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>

On Tue, Oct 07, 2025 at 07:36:21PM +0900, Alexandre Courbot wrote:
> Hi Yuri,
> 
> On Tue Oct 7, 2025 at 7:29 AM JST, Yury Norov wrote:
> <snip>
> > Regardless, I don't think that this is the right path to move the
> > bitfields into the core. The natural path for a feature that has
> > been originally developed on driver side is to mature in there and
> > get merged to core libraries after a while. Resctrl from Intel is one
> > recent example.
> >
> > With that said, I'm OK if you move the bitfields as a whole, like you
> > do in v5, and I'm also OK if you split out the part essential for nova
> > and take it into the driver. In that case the bitfields will stay in 
> > drivers and you'll be able to focus on the features that _you_ need,
> > not on generic considerations.
> >
> > I'm not OK to move bitfields in their current (v6) incomplete form in
> > rust/kernel. We still have no solid understanding on the API and
> > implementation that we've been all agreed on.
> 
> Initially the plan was indeed to give this code some more time to mature
> in nova-core before moving it out.
> 
> The reason for the early move is that we have another driver (Tyr) who
> wants to start using the register macro. Without it, they would be left
> with the option of either reinventing the wheel, or poking at registers
> the old-fashioned way, which I think we can agree is not going to be any
> safer than the current macro. :)
> 
> IIUC your remaining concern is with the possible loss of data when
> setting a field that is smaller than its primitive type? That should be
> addressed by [0], but as it introduces a new core feature I expect some
> discussion to take place before it can be merged. In the meantime, it
> would be great if we can make the register macro available.
> 
> Because letting it fully mature within nova-core also has the drawback
> that we might miss the perspective of other potential users, which may
> make us draw ourselves into a corner that will make the macro less
> useful generally speaking. We are at a stage where we can still make
> design changes if needed, but we need to hear from other users, and
> these won't come as long as the macro is in nova-core.

Hi Alexandre,

Thanks for the broader perspective.

So if there's another user for register!(), then yeah - it's worth to
move it out of the nova earlier. It doesn't mean that we need to split
bitfields out of it immediately.
 
> [0] https://lore.kernel.org/rust-for-linux/20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com/

This resembles the _BitInt from C23 standard, and it looks quite
reasonable to me. I'll get back to your RFC shortly.

https://en.cppreference.com/w/c/language/arithmetic_types.html

--

I'm glad that we started this discussion. From my point, what happens now
is inventing the whole new language, and basic bit operations is the heart
of it.

I would really like to avoid adopting an API that will frustrate people
for decades after invention. Please read the following rant to taste
exactly what I mean:

https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/

Thanks,
Yury

