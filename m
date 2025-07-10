Return-Path: <linux-kernel+bounces-725726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B05B002F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13DC1C412E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEB291C0E;
	Thu, 10 Jul 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MJFc7WO"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730ED273818
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153065; cv=none; b=B8zO6HEz7TPHbbriruWA0V+nYJgAuUnH1ZdUuyAgehl8Y+J+HsKcuSropBPDb3dgQ05auekK7C/x/mllIGtJHiKfjmItF9f6pbzK8aVKZbnLSyT3be8SOzGhDwTkkt1pqwg+Z0wu3/l+i/McW4+u1xUeLgluzhvOruDA3uU0m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153065; c=relaxed/simple;
	bh=ukrHN5oVTbO3Gzw8zvlKpOme09hGxMxpn1ZsIOQ/5pc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sutwEuoUc9jdiGqb8mpsnJTbczuo6zGpc7OUUXiM+iUpySkKxgaqVIDWnCl+zWwZj22KIzE7puoFcqzG9HWbtGFfJQIvMf9b4UyyzLOr6S5Wk05mFyAV9Fe7HbbOFEEm0slgrx+/lrfkoeVN7lK0Oq2SVKg2DozvHZvMeTvia9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MJFc7WO; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6077833ae13so805811a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752153061; x=1752757861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqVCS8TY8vj+FVtnSXDaeL5+XpjAZOm45v+d1K9DEFs=;
        b=0MJFc7WOTGuKt+yvExTjl/nml9GAOUOLBS66TIn1l7ujGFQGzcyzNUJqit4dPKPUPM
         3DosBP+LFzbOIS+nHrtV7xjwxyOmqxnqEVeEPGe//J8CZ2K+adpTmcPrcVyqwJRmpIil
         ppJxd29DWc0SDAPaumJ3S1Ffkb8vVq4bz3meeLi26XHy5na+q5xpICcaJjogpsqBLUic
         eYR74dm8y/ZfJQJVIvWu3aBabmbZ+m/NEKN4a36ppKMAlcnp3RQLztiwuS9taCuJX5yu
         4mF6f2Yk8LUSENdV/otk7mrT3VzgMx2KcsEtBQIPoByzQiwciJ/UheL7/hlX7d59itrW
         RLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153061; x=1752757861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqVCS8TY8vj+FVtnSXDaeL5+XpjAZOm45v+d1K9DEFs=;
        b=vFH7lKdLI2dRhNMbBVTpvJmmN0LenKkdnnFmJAAYdE5b8SSOhZLQPbhBAK0OifZVZF
         u0ygt3XFytcYLkQGOKYl7rz/vFMcqC9XPBkcaVVnc6NixX8hWCvJpp+YowBp5WKuCajw
         rNarD4m72+lZmhSb+YuA97pv/TreGYd3Zh7Om/HsGntT0Sk69OwXghv7Gf7qvQ67+ZCw
         iCv9uMkfXW+V9OVQPta5IuIxGO8OA7txSH8gAAvKhKJ4yjO/4+ZyE96NN7o958lZeP+K
         zq1GOBFl065DtRY1fYveKOkO8osaDSJkJMCDsROfRAr9JVTfiOF7Ew5l8xMHxXWGNW3e
         Pbug==
X-Forwarded-Encrypted: i=1; AJvYcCW50cpw+nI69onoo75pbJ0DuwBIrlKvyT23tXIPsDgF0UtwafzjHcRucvUaaV7/AYcRC1iobxj9amg7DI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIYtHS/sSlN78cD75k8p7w4gwqxhKM1j6DZ2r8lLdP5fGNB+9
	poEtUJKAf/3whlh6sNX2BFYZ9vYLD+OXzMeo4dNpNOkiN2aVOsuvB8Ws929xQ1ezWzu5b+MdW2R
	ICuAd9WlJi+E++PWRaA==
X-Google-Smtp-Source: AGHT+IHuNA7vEKwVx7/1GodImnvcG0kjW66yBsiqdQmW7BPO6iJF0Z1c31UMA8nBNbbTYWcXSeNyJSd4/epYty8=
X-Received: from edtt13.prod.google.com ([2002:a50:8d4d:0:b0:60e:1b95:f4d5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1eca:b0:609:7e19:f12c with SMTP id 4fb4d7f45d1cf-611a7353c37mr5475950a12.24.1752153060633;
 Thu, 10 Jul 2025 06:11:00 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:10:59 +0000
In-Reply-To: <aF7YWE4bz98Gqh1y@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627-workqueue-delay-v2-1-84b046fdb4fc@google.com> <aF7YWE4bz98Gqh1y@tardis.local>
Message-ID: <aG-7402hh4CCN7vh@google.com>
Subject: Re: [PATCH v2] workqueue: rust: add delayed work items
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, Jun 27, 2025 at 10:43:52AM -0700, Boqun Feng wrote:
> On Fri, Jun 27, 2025 at 09:38:42AM +0000, Alice Ryhl wrote:
> [...]
> > +    /// Get a pointer to the inner `delayed_work`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The provided pointer must not be dangling and must be properly aligned. (But the memory
> > +    /// need not be initialized.)
> > +    #[inline]
> > +    pub unsafe fn raw_as_work(ptr: *const Self) -> *mut Work<T, ID> {
> > +        // SAFETY: The caller promises that the pointer is aligned and not dangling.
> > +        let dw: *mut bindings::delayed_work =
> > +            unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).dwork)) };
> 
> This would conflict with your Opaque::cast_into() series ;-) So I
> suggest that we rebase this one onto:
> 
> 	https://lore.kernel.org/rust-for-linux/20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com/
> 
> and send them together. But it's up to you and maintainers, and even we
> do that let's wait for some reviews on this patch to save extra
> versions.

Will rebase.

> I'm going to review it, just figure this better be pointed out.
> 
> Btw, as a review comment, I believe we are in favor of `&raw mut` now,
> so this should be:
> 
> 
>     unsafe { Opaque::cast_from(&raw const (*ptr).dwork) };
> 
> > +        // SAFETY: The caller promises that the pointer is aligned and not dangling.
> > +        let wrk: *mut bindings::work_struct = unsafe { core::ptr::addr_of_mut!((*dw).work) };
> 
> Ditto.

The rest of the file still uses addr_of!. I think we should stay
consistent. We can update the entire file in one go.

Alice

