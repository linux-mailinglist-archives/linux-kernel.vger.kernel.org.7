Return-Path: <linux-kernel+bounces-844123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F8BC10F0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3813B3C7117
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA02D877A;
	Tue,  7 Oct 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmkZWYZr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440772D7DF8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834716; cv=none; b=ptfve7rHkOwHok0EfVuBCOYPRkHx3VjORS+HQU812nCmKpiy400u0pRTXuQ9kVfFF0WR/fs7YTDkqNM6q1Jr8UVQ8viISHl3VgTvwBo9Omj8RZuTXW06RUn5mYV70hsCZq9/g6gXn5QevLxghoTulsON/I9dn4Shwg5FiOm67fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834716; c=relaxed/simple;
	bh=ADQ2g7A1FmJg1TalhRqk/61bbfq3GLUvmfE9OfTd9FM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mV8J8tbdROJGCsmDUW1DC1Hdohi0Ko2CWbyARrQnK77GDwVY5NLiJfRXxIY3CHLHTHNC7o/9ZwpiknWhtSRBjXl7fq6co7+Kbxo3C0MPOjV53qq4/8uqPXHMrSoQsz83/hEOLk/Ynn/U4qNWbUtqewfEmY/HVfTpXbhlPG7Vvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmkZWYZr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4335fa87so30208465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759834712; x=1760439512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez7zkvFd6EZph4Lh4v4D6ZBVT/e6RhvR/3oi6eaNFu8=;
        b=BmkZWYZrOYGu65s7RLonidYeZAwXz3EyAdT1WAoYGc6CAHiBmC+/enYtWrBJr4N6wl
         hWFXwAgbclfzli3BC10mEy5r3Au5QMa1/8LtbLKok4RaYqtII0xPzXv0g7AXo1O2moQI
         p7MmqAK31z6KyzDTDLWhmLvhlHfuwGKpqz92Y+8RtkoMsfJT6ZsFfQNpfcssIbBk6xpE
         oePHSrbrEIcluK++fszuZo8S2QihJ8iIUv00E3pr+5ydogjU/Z982uFkk1z0cc1EwzXv
         a8qw3YhXt4W3AOMoJKhrmopFeSyKDeGWZ+6QIjcfIHTP9Gq7R2yDi4QJeD1kB86xhCWD
         +9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759834712; x=1760439512;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ez7zkvFd6EZph4Lh4v4D6ZBVT/e6RhvR/3oi6eaNFu8=;
        b=HsvutuFWojAA7zR7CD4K+4k6m2rHMC32jmp1QOORUIbIQ4b9rOkKMpTJeEJ6cxvj61
         JsunCMilyKM82P4da6++7SG6B1q1Cv3mqUf2kPW5t2vsrZWgjbpHmcH0RXtgeGhkiZuN
         /TPkgxw7FdCB20C3Vch+OnmZH1xgEVQJVw6Hr6YrTZtPMi6C+5aqZEZQph6XxyolhtB6
         skRdQ3EnDsl5p1GVpjDgDuk5dfJkuETkaUMMJqA0on+dIMUySDCSaSIypXya5gKkRNqa
         ejo2wGoKx+HVDsddTDQMA5RtP4lpdJ0qoYQzHaqcWeAaOMkCA8a8uYYpr8eUqF4+PS1v
         5zzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVclpQ7HB0EfoJMoXZYXUBocgnFZuCBJLYwoOfNO3Z4ksRlMZyoFGLRh8OzeOo3w99TSrUivVJUK5z0L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnjQ09xoU98crhKSWMOZd+fsNIhFZrj3xUvWja5byDWseTqZr
	TPv8KH7ArkY7yL4TSCKqJ9FzKsjDfSNY1Y5aRYmbiSeOVBYDNsX0Mk90oijc39ivWQaiWV0onL3
	lAwEjQy+5mnTKEb7JmQ==
X-Google-Smtp-Source: AGHT+IFqKwAo2EYLBq+cRFcEVnOhRTHw+qglS6Qg6dT+G1D4EBNFANP/XJisgujV8twdwJlToAnGTBqiMrLL94Y=
X-Received: from wmfo19.prod.google.com ([2002:a05:600c:2e13:b0:45d:e45e:96aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450e:b0:46e:35eb:43a with SMTP id 5b1f17b1804b1-46e7110c336mr116269245e9.15.1759834712664;
 Tue, 07 Oct 2025 03:58:32 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:58:31 +0000
In-Reply-To: <DDBHMNEIU9HJ.68MGF28IF58I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006163024.18473-1-work@onurozkan.dev> <20251006163024.18473-2-work@onurozkan.dev>
 <DDBHMNEIU9HJ.68MGF28IF58I@kernel.org>
Message-ID: <aOTyVzpJNDOaxxs6@google.com>
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 09:31:43PM +0200, Benno Lossin wrote:
> On Mon Oct 6, 2025 at 6:30 PM CEST, Onur =C3=96zkan wrote:
> > Implements `alloc` function to `XArray<T>` that wraps
> > `xa_alloc` safely.
> >
> > Resolves a task from the nova/core task list under the "XArray
> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> > file.
> >
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index a49d6db28845..1b882cd2f58b 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -266,6 +266,45 @@ pub fn store(
> >              Ok(unsafe { T::try_from_foreign(old) })
> >          }
> >      }
> > +
> > +    /// Allocates an empty slot within the given limit range and store=
s `value` there.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then reacq=
uire it afterwards.
> > +    ///
> > +    /// On success, returns the allocated id.
> > +    ///
> > +    /// On failure, returns the element which was attempted to be stor=
ed.
> > +    pub fn alloc(
> > +        &mut self,
> > +        limit: bindings::xa_limit,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<u32, StoreError<T>> {
>=20
> I think it would be a good idea to make the id a newtype wrapper around
> u32. Maybe not even allow users to manually construct it or even inspect
> it if possible.

What? People need to know what the assigned index is.

Alice

