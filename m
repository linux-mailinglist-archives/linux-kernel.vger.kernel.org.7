Return-Path: <linux-kernel+bounces-811212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D0B525F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B371462C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D722256B;
	Thu, 11 Sep 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN87ZHSn"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322D221F15
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555229; cv=none; b=AIQJpbeLuNiJTAMd1VkuMw2P8M+iVyXUn2F0TzpxyLtZh+F5Hg3xMcJr/9DS91jeULq42RVa9oH5ObCFT9qzd8lShKEoRyb37QSXjFBBSb/V9D3/yizAfwBCk7soE6lG48zmBpKQPstVHu8RbtvzS3poE7KdpK3Jd6JwpfOa1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555229; c=relaxed/simple;
	bh=nfLtywKhuAo/LWXI6HFnAq9pRJcy7IF1ijtpe8+JT+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoSNFxVQDcM0eL9351v49pT1/Yr92Z/jjUkVKhvo/jFy0xSP0jgKm82IvDKZw3LZG3bTQffxocUlxRa0YVzEvjbMcAnVu1O3Rhqqu96kfsBJV/rd0PcE3jO/MglMYGSmX4P1IqzYBJXejHsPt3BOf9cySmYohDgnW7G6gC5O0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN87ZHSn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso217487b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555227; x=1758160027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEZsk5IgIJE2olJ8uhS0ciJ6RlLJjXOKHsdYkiwECsw=;
        b=LN87ZHSn6M6h8Y25ZI0R8X2JG5ZAOUpdbAz+XIrdw56H0aqJ6aZFpR9juatJVJqb+T
         bK/ZlD75pwxUQaK5j39QhOt36BdW2ySgBGSio8KVhGKc5qBBiZ/XfztXei/m4DYOYnnC
         iwuP5hKWc+SGVDflgtOB2J7+gxOKC/A+eJk0DBv/xH06l0Geq748NUUFXSAfDKnktRRH
         0/qsDMdIWKQTRotW7dqQU82MbJCGLGQ96NI1jDQqSuyGZQmQfuw8baQytDy5VuKMvqvT
         hnHrjXOr7+EFDSv+ByTsza+CgjVaK5KarePZQJoydy1150wMO17Uz6KqRE+ZKhl1RelU
         DCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555227; x=1758160027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEZsk5IgIJE2olJ8uhS0ciJ6RlLJjXOKHsdYkiwECsw=;
        b=rzvej+1Fkx0DCIcCorAZEgGmWbbOP4wnAokPqjpLFsnMhRQcWeRqKRT4iOcjJ/zguZ
         2S2Rfq0bWPrjNGyg84vdkgR/h7jA3O2IwvZ2Z3Kua5Fp/k/BENmV/CEG3VT02iek79sM
         SEMnWijq+vgAFyh767paqZZ8Cgp3F7AUY4BppBAky7ku8nNWZH0J05yv1W6L+nhnKhM9
         9Fx/COVRWFR21m61W8e35DfjJ0TCC13L9+H45HujrEM7so4I420hEV86CrsfCfXDsR6z
         fzSYun3pQBYp62OcOwSmLRqf46ixH4pVQBtD6yH9DvHS5RhZgNyiF90vGN5Ta/rLQ2NY
         84oQ==
X-Gm-Message-State: AOJu0Yx3L8AqMgTjn2SmpSDzJtpxe83S0HQb75/6dFBZY2NKWKf7JmR1
	JXm2GeXH5t458D5KjIP03JDamjNy0oGXb39BGZ858XxG1zGp22vxHQca
X-Gm-Gg: ASbGncuU84Zf+h7NY8F/V+M27ra/H3yc1ZVEZW+QrG0mU0NyrUt/HCR+xBdzBn++qvm
	6C36t4yxrgb9wmg+wefanhIR6/7i9GctmrOEm/P4UG0P97k89ZbTLRxg60l+Z2BRGf2WhM9VlZn
	QGeHtsU/5vOj+2leewNfuPWPbT1UprglAOcg2xyZbv/A6zBt+o/yL0GJ33iQs3L6ajKAUaVecSN
	HZEkaH2TxwlSlS/ffTBYdX8v76rkiitOGqNiGN6qUtR8qhNa2JiQ3msjZT0VCn0tDFEB9SRvYv2
	DJG/ZcFqjNsdbNERrx3kNKWTVWvi4dPtKw+ZiMiV1uPWeUP6IZvESXlZDH94gILiI47HHbzE++K
	FPWbxdEftVfduWLBywZGBhA7zghGRgHDn
X-Google-Smtp-Source: AGHT+IHaIDh8YEvy5MNx/DrTxCXuyUt/GErzLvTsLnkRsoq21VQQ58b6byrmg3bf51ljPUzBvmtNag==
X-Received: by 2002:a05:6a20:914c:b0:24a:d857:fcab with SMTP id adf61e73a8af0-2533fab75e9mr23158841637.23.1757555227324;
        Wed, 10 Sep 2025 18:47:07 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a32ea462sm189220a12.0.2025.09.10.18.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 21:47:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
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
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3 5/5] rust: Add KUNIT tests for bitfield
Message-ID: <aMIqGBoNaJ7rUrYQ@yury>
References: <20250909212039.227221-1-joelagnelf@nvidia.com>
 <20250909212039.227221-6-joelagnelf@nvidia.com>
 <aMDq2ln1ivFol_Db@yury>
 <bbd6c5f8-8ad2-4dac-a3a4-b08de52f187b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd6c5f8-8ad2-4dac-a3a4-b08de52f187b@nvidia.com>

On Wed, Sep 10, 2025 at 07:08:43PM -0400, Joel Fernandes wrote:
> > You've got only one negative test that covers the .from() method.
> > Can you add more?
> 
> Sure, but note that we can only add negative tests if there is a chance of
> failure, which at runtime can mainly happen with the fallible usage (?=>
> pattern). Also just to note, we already at ~300 lines of test code now :)
> 
> > 
> > What if I create a bitfield from a runtime value that exceeds
> > the capacity?
> > 
> >     bitfield! {
> >         struct bf: u8 {
> >             0:0       ready       as bool;
> >             1:1       error       as bool;
> >             3:2       state       as u32;
> Here you mean 'as u8', otherwise it wont compile.

No, I meant u32. Can you explain this limitation in docs please? From
a user perspective, the 'state' is a 2-bit variable, so any type wider
than that should be OK to hold the data. If it's just an implementation
limitation, maybe it's worth to relax it?
 
> >        }
> >     }
> > 
> >     let raw_value: u8 = 0xff;
> >     let bf = bf::from(raw_value);
> > 
> > I guess you'd return None or similar.
> 
> No, we would ignore the extra bits sent. There is a .raw() method and 'bf' is
> 8-bits, bf.raw() will return 0xff. So it is perfectly valid to do so.

So I'm lost. Do you ignore or keep untouched?

Imagine a code relying on the behavior you've just described. So, I
create a 5-bit bitfield residing in a u8 storage, and my user one
day starts using that 3-bit tail for his own purposes.

Is that OK? Can you guarantee that any possible combination of methods
that you've implemented or will implement in future will keep the tail
untouched?

In bitmaps, even for a single-bit bitmap the API reserves the whole word,
thus we have a similar problem. And we state clearly that any bit beyond
the requested area is 'don't care'. It's OK for C. Is it OK for rust?

(And even that, we have a couple of functions that take care of tails
for some good reasons.)

So the question is: do you
 - provide the same minimal guarantees as C does (undefined behavior); or
 - preserve tails untouched, so user can play with them; or
 - clean the tails for user; or
 - reject such requests?

Or something else? Whichever option you choose, please describe
it explicitly.

> I don't
> think we should return None here, this is also valid in C.

This doesn't sound like an argument in the rust world, isn't? :) I've
been told many times that the main purpose of rust is the bullet-proof
way of coding. Particularly: "rust is free of undefined behavior gray
zone".  

> > Can you add such a test?
> 
> Sure, I added such a test.
> 
> > The same question for the setters. What would happen for this:
> > 
> >     let bf = bf::default()
> >              .set_state(0xf)
> >              .set_ready(true);
> > 
> > I think that after the first out-of-boundary in set_state(), you
> > should abort the call chain, make sure you're not touching memory
> > in set_ready() and returning some type of error.
> 
> Here, on out of boundary, we just ignore the extra bits passed to set_state. I
> think it would be odd if we errored out honestly. We are using 'as u8' in the
> struct so we would accept any u8 as input, but then if we complained that extra
> bits were sent, that would be odd.

That really depends on your purpose. If your end goal is the safest API
in the world, and you're ready to sacrifice some performance (which is
exactly opposite to the C case), then you'd return to your user with a
simple question: are you sure you can fit this 8-bit number into a 3-bit
storage?   

> In C also this is valid. If you passed a
> higher value than what the bitfield can hold, the compiler will still just use
> the bits that it needs and ignore the rest.

In C we've got FIELD_{PREP,GET,MODIFY}, implementing the checks.
So those who want to stay on safe side have a choice.

> Now, I am not opposed to error'ing out on that, but that's not what we currently
> do and it is also not easy to do. The setters in the patch return Self, not
> Result<Self>, so they are infallible, which is what allows them to be chained as
> well (builder pattern).

That 'chainability' looks optional to me, not saying weird, anyways. 

> I added another test here as well, to ensure the behavior is as I describe.
> 
> > 
> > And for this:
> > 
> >     let ret: u32 = -EINVAL;
> >     bf = bf::default();
> >     bf = bf.set_state(ret);
> > 
> > For compile-time initializes, it should be a compile-time error, right?
> 
> Yes, since the struct in this example is u8, this wont compile. Yes, I will add
> a comment.

So, the following would work?

     bitfield! {
         struct bf: u32 {
             0:0       ready       as bool;
             1:1       error       as bool;
             3:2       state       as u32;
             ...
         }
     }

     let state: u32 = some_C_wrapper(); // returns 0..3 or -EINVAL
     bf = bf::default();
     bf = bf.set_state(state);

That doesn't look right...

> > Can you drop a comment on that?
> 
> Yes, I will do so.
> 
> > 
> > I tried to apply your series on top of master, but it failed. So
> > my apologies for not finding the answers to some questions above
> > by myself.
> 
> Oh ok, I applied it on top of drm-rust-next. I will rebase on -next for the next
> revision, thanks.
> 
> > For the next version, can you make sure your series is applicable
> > on top of master or -next?
> Sure, thanks.
>  - Joel

