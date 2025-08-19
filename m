Return-Path: <linux-kernel+bounces-775727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1013B2C41B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B28168329D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2D32BF52;
	Tue, 19 Aug 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBSYfcSa"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F847322A22
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607544; cv=none; b=c0XrnU7OkV1AXbm9tyDvszRYFfF4hNKFRZ78nAVqMJWONkafAYSZ6ZMGk9x9jsFDvv2wca1fBv23qw0MOI/8Y7JnWw7vse7ftw223zgbsIy1I0Fn+/JntRNWqmtFmgpXOCvLqetkaLsFmYJ67due57RQRH0u8UpCzrM909CXFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607544; c=relaxed/simple;
	bh=1PSmqi0rc3+NQtMGE8Lf2Qw9wvGtgU/zo00sDq30BSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGENwYkifSdUQtfRLySEa+CGo61tuV2bCgry2r5TZ1Jpc+HwQmfGWe9k+fb+tqNeiUQYpiNQk9Skkm7QkI8sVq3TSvYCzhIfsCJA7itKxftZPKTCgyhx6Q0tjOagMxbZNu6kyarqa0zEeFcqDHjjcxN1gIKhxvxrwfxfbqk4qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBSYfcSa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so32052405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755607541; x=1756212341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=skXDTS7YtkP3PtgVwdRJaBi3aX6SDOh3FcH34RHXW94=;
        b=fBSYfcSaH/fos9IlXR++sSlDtLl+J69cUi79tB+HoaFPro3CeY6v/0doSQejfHq9E1
         cUlGxSAOQ9TrhWoGOKtHwUVSyi286f2RCacyqwiZa2hDMru9SYkd2phqc+IQ+3bmjWOk
         1FccEfafUWo6vqbAtUS1j1muxo/qWjlsQTb+tWypjz08XfXA+YPRovj/QD7257/RrUDk
         PDnepDgMHEt3J+nF3TT4TkqGp6gE8BSyCbZ6i67aOSJKYH08snqQoP9qVfGMq2KEhkW0
         Vy+IblvxR6xLw1q8AaHOOGlATFPMqll+uijRZBJjuD4/QlSPaEJvCHo5swZIVLnxvFct
         0VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607541; x=1756212341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skXDTS7YtkP3PtgVwdRJaBi3aX6SDOh3FcH34RHXW94=;
        b=WKuoUaS5i1KNGK5qvK+uoJoNa2oBBtq71lS3APfLvBVYitXYhQu/NICe1OfHDC2FBn
         uqB4G7oXBcoNgq3NOEXs3YCl4frppdB37V9SI+lLzq6SxBAjEPZ4jR9xitgcFFSBE437
         jdcmrEx3F+LIqs7jqLJF3GvBT+7uVliloQzgtzxVAngayEUNFw+sGVBR1XaqrLSKR3g7
         6Ohl5O19NOx/YC/sFueYCLy+0PqevvkJ2eSIkKoaiSx0xHKPT5jMGuVeTb5XoBD4RJz3
         +K3BCbkUO4MSL2ehS7Ykz5EYKgUoAURp0SoKW0gFLqpAl8qLcaF2Gw2iGlF8p7ta41qA
         Jk+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxmRm725Jkz6FAA0Je4yG412t3aHQ5rKIj9tuw0xavVAZKyA8dhrcBb3Gb/rqXIOtLCpPUS3bbO+1c2ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx70UXo4Vn09DV4+rycgahQ7N+9+sCklLRNiLXQS+++DdKQpGd
	RrKjCpxOZJH/UXZlk00Xx+Oe0V8ao3qTJYle/HDEUFrSV2Rx8qm6nt5mKFYxix6zLS6JH3b/4db
	SVOcRv4W3W2QWAQZftA==
X-Google-Smtp-Source: AGHT+IGIDBx+bC32aprn8tj9w03RjuRfJ6vo2Z3jPtuwKYnkQLN4JvNoi90LWbeGxOCwVfKIUq28TPReZBsoQd0=
X-Received: from wrob15.prod.google.com ([2002:adf:ee8f:0:b0:3b7:838b:2a7d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a8:b0:3b9:55a:9d0c with SMTP id ffacd0b85a97d-3c0e00a1623mr1805506f8f.3.1755607540947;
 Tue, 19 Aug 2025 05:45:40 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:45:39 +0000
In-Reply-To: <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com> <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
Message-ID: <aKRx8xsY8CpzbeEm@google.com>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 19, 2025 at 01:30:30PM +0200, Danilo Krummrich wrote:
> On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe168477caa45799dfe07de2f54de6d6a1ce0615..26053163fe5aed2fc4b4e39d47062c93b873ac13 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16250,7 +16250,9 @@ L:	rust-for-linux@vger.kernel.org
> >  S:	Maintained
> >  W:	http://www.linux-mm.org
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	rust/helpers/maple_tree.c
> >  F:	rust/helpers/mm.c
> > +F:	rust/kernel/maple_tree.rs
> >  F:	rust/kernel/mm.rs
> >  F:	rust/kernel/mm/
> 
> A later patch adds a separate entry; is this intended?

Ah, no, this isn't intended.

> > +impl<T: ForeignOwnable> MapleTree<T> {
> > +    /// Create a new maple tree.
> > +    ///
> > +    /// The tree will use the regular implementation with a higher branching factor.
> 
> What do you mean with "regular implementation" and what is "a higher branching
> factor" in this context?
> 
> Do you mean that the maple tree has a higher branching factor than a regular RB
> tree, or something else?

This is compared to the alloc variant of the maple tree from the last
patch in this series.

> > +    #[inline]
> > +    pub fn new() -> impl PinInit<Self> {
> > +        pin_init!(MapleTree {
> > +            // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
> > +            // destroyed in Drop before the memory location becomes invalid.
> > +            tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_init_flags(slot, 0) }),
> > +            _p: PhantomData,
> > +        })
> > +    }
> > +
> > +    /// Insert the value at the given index.
> > +    ///
> > +    /// If the maple tree already contains a range using the given index, then this call will fail.
> 
> Maybe add an error section for this?
> 
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> > +    ///
> > +    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
> > +    ///
> > +    /// let ten = KBox::new(10, GFP_KERNEL)?;
> > +    /// let twenty = KBox::new(20, GFP_KERNEL)?;
> > +    /// let the_answer = KBox::new(42, GFP_KERNEL)?;
> > +    ///
> > +    /// // These calls will succeed.
> > +    /// tree.insert(100, ten, GFP_KERNEL)?;
> > +    /// tree.insert(101, twenty, GFP_KERNEL)?;
> > +    ///
> > +    /// // This will fail because the index is already in use.
> > +    /// assert_eq!(
> > +    ///     tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cause,
> 
> A lot of the examples, including the ones in subsequent patches contain variants
> of unwrap().
> 
> I think we should avoid this and instead handle errors gracefully -- even if it
> bloats the examples a bit.
> 
> My concern is that it otherwise creates the impression that using unwrap() is a
> reasonable thing to do.
> 
> Especially for people new to the kernel or Rust (or both) it might not be
> obvious that unwrap() is equivalent to
> 
> 	if (!ret)
> 		do_something();
> 	else
> 		panic();
> 
> or the fact that this is something we should only do as absolute last resort.

How would you write it? The way you write it in normal code is an
if/else where you handle both cases, but that doesn't map nicely.

Alice

