Return-Path: <linux-kernel+bounces-802429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF27B4524F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ED6566E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869B27602D;
	Fri,  5 Sep 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ftenetsi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EA28369D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062813; cv=none; b=DOnyH8tJwTo/ynGqx3Pg7Wt/AeBV6EoyzYI57C9C6OUpsDiT+wGR9NP2WvOPSJdh/LeAm5BUQQ4BQL01oGAVX6uSYbs0jcHtpW14K8XV9QsdvcVIlYWoja0Y9l5Skg4Q/b2PKXiBEn/J7Ahf4cuH/4MoAlKecw94NjESFfXexBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062813; c=relaxed/simple;
	bh=hzIPcb3X9GhIqYYtsJtuh5Vdog5+cau3zXlup5lenBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehkJg0SJZSPbDZHYeJmFo2ZcLTftpbhcHXFf77RbueaQIAd63P5X44Vb2ZHfklx5CjROblaBRSrZ2byMu8iNvURNtgFdpOKsbvZjWmtQTUl+Sen/uw+19lpGHJsGVFAzniFQXE8J9drZ3ol8VqoyIrLNq6T+jn2fV7IVRt98Ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ftenetsi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b9c1b74d0so9393965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757062809; x=1757667609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA7E7SWyY2rywATmTma5dtVVfW7ez0VkGcAkYBGMn2k=;
        b=FtenetsipxzKPa7d/9t0+ZM/zvrX5WrF0sCU2f9/4HkQLXIc4nF2o22TuGu3YAnuPE
         zvPLz5DTS7lhyzFZAOgnj+qO/GBxcbenVwVGCZzNpZCyPGXofR7EQ1kyylBB2SoNhdsk
         2KlTeD596/6RVgKxzFcRPuh7dq9fk4iZY63e+y1B24Ba+smzFHsXc/mR0Rsq/nUVdfmy
         7bJiztc5ug5reett3eylch3iBIqdBr9S6oW+tUmcrZXQYqsiYCNaJGGMvLpRaQgRIUFL
         30EWnA4m4A/srbDrbwkdcoKcPoj2z7MU71xBi6adcCrIVSYurwAc0Ri/W5va3tFBG6UA
         tQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062809; x=1757667609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA7E7SWyY2rywATmTma5dtVVfW7ez0VkGcAkYBGMn2k=;
        b=S95lKhKpWS0jYtQEtGqGfiUrP6ZJhnt3AJVSh+eH6zIJxT7q19qbxYifdQs2TRAVr+
         x8pssSkRDD0CbctAJZ476ersU+YqxqJVc99RKbGfBddEzoTDbZlCPrvW/q9b+pw2wX6k
         iXbgp8vXKN7ToIzxFB0YVWoGUQNrDxCb8aLMKXUh8EkdCoaiO4bmJXuDDPgaXCRayWmh
         v9QGIUXRSgqYZWW4vt97eT0ghuM4HaQE1yCb/TEL63kgqlUzlDHQzXVl4hwUCNxONoS0
         GXNuQ39vNEvOReTIFuZ8skQAvcRBJ6KEMa5FQLqfPx/02+reQfZ7OBbeSesuU37CEAcA
         L4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWmnvf+l+KOQW5NTSdNqTCzzBOU9998Imw1OeXL7MMKsJhLonwKp2iwaQlJwgp7jjAn4hTH9y5zi2HVu2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzqIofptBAR7YaeSv1B331SOJ0qqnS8RAVNJV0+QGpLGriWkk
	gDajmEios1LtaF0qOipHPoXZmTp9LWHmKQGZl19JM2eUL9nPxr4aFAN1L1Vt7rd/9NqP0mQoMfp
	NNWaz/FzbI1Qy9OD3jw==
X-Google-Smtp-Source: AGHT+IEskge5MKMlJoG74FiZmY/yaFnVbV5RRxEYcD5LjhMZRlcH9qa85hp5Z70Yy5y8DJH9slw/4+GneaXkFUA=
X-Received: from wmth17.prod.google.com ([2002:a05:600c:8b71:b0:45c:d828:e348])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2088:b0:3d6:7ae1:af00 with SMTP id ffacd0b85a97d-3d67ae1bdf0mr13547126f8f.20.1757062809326;
 Fri, 05 Sep 2025 02:00:09 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:00:08 +0000
In-Reply-To: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
Message-ID: <aLqmmKZMDAAFCBsX@google.com>
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
From: Alice Ryhl <aliceryhl@google.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 04, 2025 at 04:25:52PM +0200, Vitaly Wool wrote:
> Sometimes we may need to iterate over, or find an element in a read
> only (or read mostly) red-black tree, and in that case we don't need a
> mutable reference to the tree, which we'll however have to take to be
> able to use the current (mutable) cursor implementation.
> 
> This patch adds a simple immutable cursor implementation to RBTree,
> which enables us to use an immutable tree reference. The existing
> (fully featured) cursor implementation is renamed to CursorMut,
> while retaining its functionality.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Overall looks good to me!

A few comments below:

> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, so it is sufficient to require them to be `Send`.
> -// The cursor only gives out immutable references to the keys, but since it has excusive access to those same
> -// keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the user.
> -unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and `V`, so it is sufficient to
> +// require them to be `Send`.
> +// The cursor only gives out immutable references to the keys, but since it has excusive access to
> +// those same keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the
> +// user.
> +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
>  
> -// SAFETY: The [`Cursor`] gives out immutable references to K and mutable references to V,
> +// SAFETY: The [`CursorMut`] gives out immutable references to K and mutable references to V,
>  // so it has the same thread safety requirements as mutable references.
> -unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
> +unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}

We should also have Send/Sync impls for the new immutable Cursor type.
They need to look like this since the immutable cursor only has shared
access and not exclusive access.

unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}

> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration of `'b`.
> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b V) {
> +        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
> +        let (k, v) = unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees immutable access to `node`.
> +        (k, unsafe { &*v })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to the key for the duration of `'b`.
> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut V) {

The mutable cursor has `to_key_value_raw` because it needs both a &V and
`&mut V` version, but the immutable Cursor doesn't have that so it
doesn't need a raw version either.

That said, perhaps we could share this logic between the two cursor
types? We can make these methods standalone instead of being part of the
cursor so that both cursors can use the same helper methods instead of
duplicating them.

Alice

