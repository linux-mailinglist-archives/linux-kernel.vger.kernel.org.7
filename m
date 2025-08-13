Return-Path: <linux-kernel+bounces-766642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB2B24963
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279CE880B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692F187332;
	Wed, 13 Aug 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n397/TBE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4A14386D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087422; cv=none; b=Veu01KpcVv2moPxGua+9SkZPCqdgWkCunlSKZsO5P0nORUCBXS+j3yR6IsYJ4ntlayl+D1wnRf6EwdPVof+FTa5H9ceXPuh19hZLIetLPwZiJg7U1xn+wJ5YD4YHI+Ht9W8t9I5j7+FSct6+oab4Ax6rKXKsEuY824lY6WkFzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087422; c=relaxed/simple;
	bh=wAo2VqlFlJopjFFfSucdmHCi26JHGsyjifftNs9pg7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oe2WlvEO8/JabhhPDDlYC9gUbXvkgrmYStNPJtHgYmAyTiYXpzBzprwmnvX02nRxIueK9kpzgfH17fZlbkgMggsa8c9ipQgtNB2mtaNPmEbHFvJGXrtUH4KnMiLXqi7bTk9o8HzcDbP8XEpG7T1g3gIJsE6z0LQJl1hEhF2MA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n397/TBE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so4732435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755087419; x=1755692219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azHdJtvoWCo9lbLQNxh8/rKwr+/it+wez+K7ot8lNP4=;
        b=n397/TBE/pnXSwPiFHN9t/xhSh7/Lvz7NMnIz6zfLi1LQeHpDbtZt0I8CH+lVnJ8lD
         WbGXP4pX2Dcw+rY4WuDdEHxKb8W4NyBfZb4hWU6pZY1u3VBt8wxJ7J9lmKvpuLUuSChE
         Tx2pl5l3p54vv/24eV2pl2jnSViDvQ4DrbDvJjULgup2i/2rT5EmxHAdvdsfiPIyuSjT
         PphuWYiApIiZtgpnvS+6oLiY2L4J9PwgEqeTlJo3yPnBvXmC4BtFLMbJZhLRn4VzhgRo
         lMroT2WCJeW/tXovdOXuu3ABvWAtwL7IuVgWshcMUP9wi1tTdmylHLFnHG25lQmRxkfG
         JJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087419; x=1755692219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azHdJtvoWCo9lbLQNxh8/rKwr+/it+wez+K7ot8lNP4=;
        b=v5l0MsEiXnjAGrJPu5w8XjeSTLBACoApiDQ1VPoiAVlFr+oKKl/pCtcka+X/J2R9QG
         jcEsPHSkgQmKizPEsk2mlW2gNQH54cLXRb2hPmelXwYPx4Cql7nPr/lHWNPxL5LhLtyJ
         mCr58QEPf1s/he8aCg2TeMKMCViAxWEWYa2xZYAak4xgXqFyUs3Jfdiz5Q2i+VgMGahL
         WzKS4LwYIBdWqFMDShB7f8clFGUa3TUmohaHUy+dSOk7iPNIz+PKP7+1yIc7xttoTquH
         CLcfGKZXKv8CpCYZMlBuxOPNXPo3EBtYhYPqzWmjza1eqUFbxXyUZclF7yDKi7mHEL9z
         +7pg==
X-Forwarded-Encrypted: i=1; AJvYcCWO1Tbz/DtYeiBNk8VizM71tu2O9cU6r0LzF29o6u/o3sy3pSFmMy6pjsSguaTB8+qbUMK2iYGBnpK5EFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFy4aX9MrAltmtLWBOgp6nprhMFwqqkf6y1LAXx9xa2d7vQcwY
	3Op2EaSlQYR64yTYSJL7hTGHQGaMwZtglvetYXb901Mt7M4ZQPKSFE85jEOQG3hiF2LgmQjBKaf
	jFL5c1VQdmvf40h2HCw==
X-Google-Smtp-Source: AGHT+IHjmy+UviZ4eW9rsL27U2fQ6FLiqNhcpr1Ge5BkDRbzHCvmzxNi9aapvYSs1nGodQf/yqh86ceebrZUDl8=
X-Received: from wmbdv5.prod.google.com ([2002:a05:600c:6205:b0:459:dc8a:ec9f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40cd:b0:3b9:13a4:729 with SMTP id ffacd0b85a97d-3b918c15ae8mr1790773f8f.7.1755087419665;
 Wed, 13 Aug 2025 05:16:59 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:16:58 +0000
In-Reply-To: <DC19RGJ4EPSK.1QRTOMYUKY34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-3-c4f1932b05ef@google.com> <DC19RGJ4EPSK.1QRTOMYUKY34@kernel.org>
Message-ID: <aJyCOstIjMuvzLwH@google.com>
Subject: Re: [PATCH v4 3/4] rust: miscdevice: Provide additional abstractions
 for iov_iter and kiocb structures
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 01:39:12PM +0200, Danilo Krummrich wrote:
> On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> > +pub struct Kiocb<'a, T> {
> > +    inner: NonNull<bindings::kiocb>,
> > +    _phantom: PhantomData<&'a T>,
> > +}
> > +
> > +impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
> > +    /// Create a `Kiocb` from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The pointer must reference a valid `struct kiocb` for the duration of `'a`. The private
> > +    /// data of the file must be `T`.
> > +    pub unsafe fn from_raw(kiocb: *mut bindings::kiocb) -> Self {
> > +        Self {
> > +            // SAFETY: If a pointer is valid it is not null.
> > +            inner: unsafe { NonNull::new_unchecked(kiocb) },
> > +            _phantom: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Access the underlying `struct kiocb` directly.
> > +    pub fn as_raw(&self) -> *mut bindings::kiocb {
> > +        self.inner.as_ptr()
> > +    }
> > +
> > +    /// Get the filesystem or driver specific data associated with the file.
> > +    pub fn file(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
> > +        // SAFETY: We have shared access to this kiocb and hence the underlying file, so we can
> > +        // read the file's private data.
> > +        let private = unsafe { (*(*self.as_raw()).ki_filp).private_data };
> > +        // SAFETY: The kiocb has shared access to the private data.
> > +        unsafe { <T as ForeignOwnable>::borrow(private) }
> > +    }
> > +
> > +    /// Gets the current value of `ki_pos`.
> > +    pub fn ki_pos(&self) -> i64 {
> > +        // SAFETY: We have shared access to the kiocb, so we can read its `ki_pos` field.
> > +        unsafe { (*self.as_raw()).ki_pos }
> > +    }
> > +
> > +    /// Gets a mutable reference to the `ki_pos` field.
> > +    pub fn ki_pos_mut(&mut self) -> &mut i64 {
> > +        // SAFETY: We have exclusive access to the kiocb, so we can write to `ki_pos`.
> > +        unsafe { &mut (*self.as_raw()).ki_pos }
> > +    }
> > +}
> 
> I think this should be a separate commit.

I can split it.

Alice

