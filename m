Return-Path: <linux-kernel+bounces-864466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B2BFADA2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91E66350F41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B446309DD2;
	Wed, 22 Oct 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/YiIvEV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70533081B5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121183; cv=none; b=PGvGRlAfXSxq56CS7UJDgBGzVt/SXz+cuCaOATMNoMM9NdMase5pr9qwWtsRLKoH99zXybOaf9BRdxpg4XNRLCL+xQhEE2XSfmLbExZNpBUGgHqbE0X0rdXKSsKrejhAK73XwMOPnshwLFlUSnzL7jXUTQleXTh1irR3e/1VHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121183; c=relaxed/simple;
	bh=RHEi92BrqYPevwcCSHph3ISxaBSTH5yv2OoBTfvdyOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRmjFtPUnL0TvaCgWGVCEhfgC+YUngHSguI6D+Hr+dFlbZCew6YF58SRnN3hrHXihLGLwYh+SNQ7f6UEAasgpGWVPReWM7Xw/pI1AGA75rTi+/nqpsqeYIGpq6Q/qQbH+emIHkyHSgfJ+Euy7iTEYDVWNA/uD0/8/b+df5FXiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/YiIvEV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471193dacffso43552495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761121180; x=1761725980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEK/i+XAkLQEgOG+ywHekwqAFjmlaiDFBYJQ7FDBQr0=;
        b=V/YiIvEVvbIymPXqtJLPYRTu4QnlxPwJaj7UzB5jcs2VXVsyvnrPtwGNn2IBXwVoKc
         q8lPuDNLUgUfYBNKFpMjtFJZC9Tx3bnnNylsXcyA1d/O+AXh/ADvunks/o/Gz/nsAUU0
         QIhHnad9Vjz6T3BzhAPjVvuew70SHMNu/0BbKJhXqLny4Bwiedcphq6vkJBweYDcmQKg
         YZEBYDP0N7pzX+xAAFeBN+l5AYSmFUgp45C/bUi7IG5V2YqFLISitjmDuRtD/seEeiOV
         0MXlG7A+VGZPYYJ/6fowVvSW4JWe1N1YpDsqRsnTJY+DYvOCS0fhqeuMiujA+tQymzRV
         BSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121180; x=1761725980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEK/i+XAkLQEgOG+ywHekwqAFjmlaiDFBYJQ7FDBQr0=;
        b=uS7u6RC/DfSSWyPvkO0qaeA0rexwb9EKQd7eJ/2DcMhfqpQj+62fEXEqUCwCrUAL1H
         lfrJiA2O2fuzFUhW7g80SiBTNiJ1u9Na8OOerwRDMdw+W7J6Cz60+l8ucasvKSjmVOQv
         GLYDrL1/UxFV9LEQNEAdiO7coEjsifb1oII0jnJbU+pI/nLg+Zyoy8p6V7hzUktzQGNc
         N9Er6AivWhSD0wibBBSwf4SEF2+H/egwjURjoY0DzNymZP7XCfdbB2/DN6KdlgyS00A5
         Q4UJSq2MRKdWoM6oXqwqwCjfZssRXQ/puzS00QAVKgEfqrc270QAN4U1pgOuj7ZTibY1
         Exlw==
X-Forwarded-Encrypted: i=1; AJvYcCUoF0xGq6VthznTPJm4T35qkgr2CHquzw7peYlJ/hyotQTHYoMgY0VWbk+MMWnYTULPKmGNDIndeF08B2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjyHgj/ta8lDIjKvYHoyLY9rthoaj0m9II+R9tOp/rbmYbJn5
	oJoSm2sVOerM5AIpIU9AlLc7byhqsthHt0yMdBxRg4QhbzQrP2QRk7IczH1tI89sG6sFofTSRyt
	LeKF+m9pXzcmuHQxJLQ==
X-Google-Smtp-Source: AGHT+IETajWDiqpRqa12EaVRu6fAxwYa+sMKITK3BOKL9H9yAMyU5Oa/ffCwAo+MISi9sybobSyD7GdOvUHfNzo=
X-Received: from wmpv36.prod.google.com ([2002:a05:600c:4da4:b0:46e:2eb4:38d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8509:b0:471:16e5:6d7a with SMTP id 5b1f17b1804b1-4711787dca0mr106715285e9.13.1761121180045;
 Wed, 22 Oct 2025 01:19:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:19:39 +0000
In-Reply-To: <ghaqgzgnk6mkv6tm4inm2e24jyidsk7qhbff6zwc46kefojw5p@3jvwnn3q4bxw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
 <20251020-clk-send-sync-v2-1-44ab533ae084@google.com> <ghaqgzgnk6mkv6tm4inm2e24jyidsk7qhbff6zwc46kefojw5p@3jvwnn3q4bxw>
Message-ID: <aPiTm7Pb9WguOd9j@google.com>
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Alice Ryhl <aliceryhl@google.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 09:21:38AM +0530, Viresh Kumar wrote:
> On 20-10-25, 09:35, Alice Ryhl wrote:
> > These traits are required for drivers to embed the Clk type in their own
> > data structures because driver data structures are usually required to
> > be Send. Since the Clk type is thread-safe, implement the relevant
> > traits.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/clk.rs | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> > index 1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d5f1d912e 100644
> > --- a/rust/kernel/clk.rs
> > +++ b/rust/kernel/clk.rs
> > @@ -129,6 +129,13 @@ mod common_clk {
> >      #[repr(transparent)]
> >      pub struct Clk(*mut bindings::clk);
> >  
> > +    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
> > +    unsafe impl Send for Clk {}
> > +
> > +    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
> > +    // methods are synchronized internally.
> > +    unsafe impl Sync for Clk {}
> > +
> >      impl Clk {
> >          /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
> >          ///
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm guessing this means you want me to take it through drm-rust? See
what I put in the cover letter about choice of tree.

Alice

