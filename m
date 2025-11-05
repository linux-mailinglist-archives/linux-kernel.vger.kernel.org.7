Return-Path: <linux-kernel+bounces-886537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD3BC35DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F7B4E8436
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8D322C7F;
	Wed,  5 Nov 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS2ZSsli"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76640314A90
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349898; cv=none; b=ITKbz9soCMsiBrX2r9zK2RyfDBRQQpaADco9bOsVC+u2c48RRuUhi+y9NZYygaF1HKEnDsOhH1KcUsU1Ps87qKSXoUOl1WzEaeGm4hEv/kdeuHYoaUAUMKZAznUJpcCERRozC/afe2sKCDnIlBFqc0Hj7bN6Mb6cBtNxQyzVqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349898; c=relaxed/simple;
	bh=fPyRN5C2LXdEknbgQiipHq/aLIT5GpJ1C6M6XDpNB7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YyH+PZuTWUYdPWesWLOXratMgNet9breDyh3SLwVc+AYtajOyYtk+IFhYw7Sa57kWn45sMwFeQyFeysCZAUqTU1nZSFLh++a5hKfV8ZoMEro6DcTdeWGhqEe3KesUcHLmfHvCm/bfs75ca4YfEq3Wg6umkOJ09hvzig1km3q5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS2ZSsli; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b70b0025af2so342779266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762349895; x=1762954695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXPfS5P+i9wz2n3+/G3PDvGDksrBlOY+wEqrkoKiF2o=;
        b=aS2ZSslii6bI9lO0TeK5lz0KGYVNK13McfR+U/+6nYmLxE/WWCExbMti9KsK0we2ly
         gKtxdBr7knPhsyVnbCJUD5E7Fo/s19zBSuwwBi1u5jtMW7F0tb566LMVmn6jOyE8WOHA
         OIlKVn9yGtkAxDq2iVaPxg8wiUntRLoe0QKv1BvoZC/SyZ5eof+h37+IYCtUh+2mXUTw
         ttLEp8n2c+zaPt0t5SEv18SVh4W0gZlizSAv4d0LhcDA5h6+OyVQ89W05fF+cnbx2b+z
         CWC9Til6TI9p4gY+fgJ+9b2yIywglQhsT0ET3vdNlDoMv0Y0hA3tPo5gVUUZnYe1hfPL
         PYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349895; x=1762954695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXPfS5P+i9wz2n3+/G3PDvGDksrBlOY+wEqrkoKiF2o=;
        b=fiukG6N465J561/7LZX/ccQRUCDRgRoAUHIBfuu6CL9d3hlNCq+9gDvYICjwQSvKl2
         zyunW2yp6fBBS+KROpRD32pZVxywgADM+My+u0C2FgvWGysOiQ0jQAeTkyjRDfQWmvEP
         xAE17+E2pW3SVXmgkPdJR6VweAOBx9ANSUh72yB4/rectHVq2cog+SfTR2GkMjHXfcNJ
         NFtMoPWne05kFEzqu4/nqVSyUD+dgHteGbjcmfE6mtTz6bKCRG/g+gSmvxJwnNEEMYmu
         eyiI+cFPWsB48yiCj2myFNOLlxcU4egZ95YCFFcktnOFsq+HGCZO4Ak40dJgM0CT3k85
         2OUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPbeSJKdhQXB+eGBjv1DoCnMtlTVB+lSfkUuATNIIs7kFvVbpDvtCz5mHWXvoSmo4Cb/2LK3+I5aKOxF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSqW08atodoWxATsDg4fEEGx9xwO4WAQZPRsWO6lHT5qvWIFtp
	cHdUvMplzaarFNK7JNk0tWhIkFGE3jDTeKAdGXhLOOj1tK3UBXaiJct66ewEDYuvn04U3xfWVUf
	Vo4sP9Pzk0GWfPqX9Wg==
X-Google-Smtp-Source: AGHT+IFQ7VWy9R3tnMU7Z7r1BFutuiMgS7RDcATHKFeq/XKdiw0+E0YiW6CR8TImH9kk6u+zM32/YouAgDPJtgM=
X-Received: from ejcwe11.prod.google.com ([2002:a17:907:d64b:b0:b70:4324:e1d8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3da4:b0:b70:7196:c8b3 with SMTP id a640c23a62f3a-b7265607958mr284971766b.61.1762349894947;
 Wed, 05 Nov 2025 05:38:14 -0800 (PST)
Date: Wed, 5 Nov 2025 13:38:13 +0000
In-Reply-To: <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
 <aQoIliAbrn0Re7E3@google.com> <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club>
Message-ID: <aQtTRUMUaaUmTAWZ@google.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
From: Alice Ryhl <aliceryhl@google.com>
To: Chen Miao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 05, 2025 at 09:28:39PM +0800, Chen Miao wrote:
> On 11/4/2025 10:07 PM, Alice Ryhl wrote:
> > On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
> >> The initial implementation of arch_static_branch was achieved by accessing
> >> the offset from the original type. However, this approach extended the
> >> path and introduced redundant calculations when dealing with types like
> >> `static_key_true/false`, as shown below:
> >>
> >> ```
> >> static_brach_unlikely(tp, tracepoint, key)
> >>    => tracepoint->key->key
> >>    => &tracepoint->key(static_key_false) == &tracepoint->key.key(static_key)
> >>    => off: tracepoint->key - tracepoint
> >> ```
> >>
> >> In practice, the implementation of `arch_static_branch` overlooked many
> >> detailed descriptions. To improve clarity, additional comments have been
> >> added to the original logic. The approach has been modified to directly
> >> locate the corresponding `static_key` instead of using offsets, thereby
> >> reducing  computational overhead.
> >>
> >> If finding the offset from the primitive type is necessary for this
> >> implementation, I will abandon this change.
> >>
> >> Additionally, support for the `static_branch_enable/disable` APIs has been
> >> introduced.
> >>
> >> Signed-off-by: chenmiao <chenmiao@openatom.club>
> >> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident) => {{
> >>           let _key: *const $keytyp = ::core::ptr::addr_of!($key);
> >> -        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
> >> +        let _key: *const $basety = ::core::ptr::addr_of!((*_key).$field);
> >>           let _key: *const $crate::bindings::static_key = _key.cast();
> >>   
> >>           #[cfg(not(CONFIG_JUMP_LABEL))]
> >> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
> >>           }
> >>   
> >>           #[cfg(CONFIG_JUMP_LABEL)]
> >> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
> >> +        {
> >> +            $crate::jump_label::arch_static_branch! { _key, $branch }
> >> +        }
> > So ... this is changing from $key to _key. That's replacing the global
> > variable with a local variable holding a pointer to the global variable.
> > However, the arch_static_branch! macro uses the `sym` operand which
> > requires you to pass it the global directly.
> >
> > Did you try this code? I don't believe it will work.
> >
> > Alice
> 
> I'm very sorry for making a fatal mistake. My misunderstanding of sym led to 
> this issue, so I shouldn't make any changes to that part. However, regarding 
> the other modifications, I believe it is necessary to support the direct 
> passing of structures similar to `static_key_false`, just as in C language.

It sounds like you are adding a new use-case for this macro. Can you
provide more information for this new feature? It is currently unclear
to me exactly how this will be used.

Alice

