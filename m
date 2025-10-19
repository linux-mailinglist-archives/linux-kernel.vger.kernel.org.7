Return-Path: <linux-kernel+bounces-859630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD9BEE276
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A448B189B0C7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA332E2DF3;
	Sun, 19 Oct 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEIr5yOq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786247E792
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760867438; cv=none; b=tiKw+eLdgGYbrRwym9M5w7HpDw1lZUamEbsLD8FE4Dvm6cUbeDpVlIWJa+BHCOi/LHUcSL4ZEELIXXzPOmOAXy3++cRgFZLK+gnGhQ4vaFo4pVr6wRWfAAl4I4Hr5lkbCFCuksP7O2AKsTJq4h9dvq0QT9EHzEvRMi8iyhf5rrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760867438; c=relaxed/simple;
	bh=8aRJjiQLhGbLC50pm5KajbR1m2hrM+YMLQFp/ap3xkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E344E9y9XgBMOEX/wf3F8jgwiBfZQ78Z/2bG4ZimQvfKb2fcGtqVTbubSP4RCezIx//48rZflDWvr7zKd3pXPbBwl8/GgMO7KYaNMBkDfrOAzHh3E1JdLZu/cR61QoSZ3qp0TbyRCQ0U0LWXvMa8aZxOweBN8qWa8cjzYAw0tJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEIr5yOq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46eee58d405so16682265e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760867435; x=1761472235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI6otLfK6cLmxy6fSKQ+1KG5bG7+ofGCa+ggSu+fxIM=;
        b=TEIr5yOq3PIrFeCmQqCRqE9SsmhIcbARpFvPts8+cJ0CNfG/IzJsjCwTfSUqsKdJ1J
         r1h0s9v3C6CLB6+obz409ah1i3HwhTOKdIknNupqIFT1pjftYp0IofnPLtCQkfqT9DBi
         oW+fka0bjDczDGodtCfN2DrwutD2IwkNU+hr6M9Z9/bieqIxHFMub7NDZ8sqbcNirW7N
         l9n3I0hk9IoBAdD6ywqYQKAyMPbbkhvvoI48SfAOOeirFFPnG29Y/CYyMJimEA7h2VuM
         Wf8tFXdzFMGrWayvdzN4f52gYANJaMnvrNsYUW8wEmmO0bRY1VJAJ9nNp91LG3sWNibf
         aNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760867435; x=1761472235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI6otLfK6cLmxy6fSKQ+1KG5bG7+ofGCa+ggSu+fxIM=;
        b=N17NBlwT97hfCh36IrlbrrFm1bwALaqNF5eM8T9UhOYWW4BpHeGLaoi4SjFldVxwrf
         Mw+BcleXTAOfr4lf9qQ8TCi6chGxEg1XLy4NCmLpp5L0e3KsaiVwazCJo/4vzghaML5y
         l7BcQ1zLuX9iJfSAllh7jE26YgaVT+0kQ+x00+28FTZQ0oq0r1tzK3WzIXJ8VFXoLmei
         Pq8kmF4BLPUI8/0bGcLfnV0x7JNVXu+RmDS3NXAYBlYDgNMWSOPVz805PAVXOUxNwPId
         8hhqb0fn6qexdv2nYu36/jFXacNm9IdcoQc/yDP3SyPMY9dvbDRJ3Lbj1HT/sAVcEy9E
         8wSA==
X-Forwarded-Encrypted: i=1; AJvYcCW5609rxpS7WjTQttL6nHaFXZv/erBPOLnA7vpxtt/Zz+Zpt6uZINwo583us+SypLPWaRA3OhjmiCdPjmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYkDv+nIfYXs1OJEb3WE7R5wvSsVoqRNOG6dsOceq5gtPtVHU
	FoVhl4qXtNBFjbdo9j2E8qStvBwe/X//1tRz5fdeTPPGYjXviUrFE46s+lZhHaD25cXH7YDEXA6
	Fkn3qpcZ1QLzZ26ID5A==
X-Google-Smtp-Source: AGHT+IHUJNFc3T6yztRJeuGBZg6ZWeT0I0my/BHUAH+0IdXziPJhASVcIQSl7ZjISrNQzq72/gOPfEqdZer0Llk=
X-Received: from wmfv11.prod.google.com ([2002:a05:600c:15cb:b0:45d:e45e:96aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d9b:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-471178a7d96mr66852975e9.15.1760867434824;
 Sun, 19 Oct 2025 02:50:34 -0700 (PDT)
Date: Sun, 19 Oct 2025 09:50:33 +0000
In-Reply-To: <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-4-dakr@kernel.org>
 <aPI9tNoh0I3KGDjl@google.com> <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
Message-ID: <aPS0aTUUwDsXmHFN@google.com>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Oct 17, 2025 at 04:37:48PM +0200, Danilo Krummrich wrote:
> On Fri Oct 17, 2025 at 2:59 PM CEST, Alice Ryhl wrote:
> > On Sat, Oct 04, 2025 at 12:26:40AM +0200, Danilo Krummrich wrote:
> >> Introduce support for read-only, write-only, and read-write binary files
> >> in Rust debugfs. This adds:
> >> 
> >> - BinaryWriter and BinaryReader traits for writing to and reading from
> >>   user slices in binary form.
> >> - New Dir methods: read_binary_file(), write_binary_file(),
> >>   `read_write_binary_file`.
> >> - Corresponding FileOps implementations: BinaryReadFile,
> >>   BinaryWriteFile, BinaryReadWriteFile.
> >> 
> >> This allows kernel modules to expose arbitrary binary data through
> >> debugfs, with proper support for offsets and partial reads/writes.
> >> 
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> >> +extern "C" fn blob_write<T: BinaryReader>(
> >> +    file: *mut bindings::file,
> >> +    buf: *const c_char,
> >> +    count: usize,
> >> +    ppos: *mut bindings::loff_t,
> >> +) -> isize {
> >> +    // SAFETY:
> >> +    // - `file` is a valid pointer to a `struct file`.
> >> +    // - The type invariant of `FileOps` guarantees that `private_data` points to a valid `T`.
> >> +    let this = unsafe { &*((*file).private_data.cast::<T>()) };
> >> +
> >> +    // SAFETY: `ppos` is a valid `loff_t` pointer.
> >> +    let pos = unsafe { &mut *ppos };
> >> +
> >> +    let mut reader = UserSlice::new(UserPtr::from_ptr(buf.cast_mut().cast()), count).reader();
> >> +
> >> +    let ret = || -> Result<isize> {
> >> +        let offset = (*pos).try_into()?;
> >
> > So offsets larger than the buffer result in Ok(0) unless the offset
> > doesn't fit in an usize, in which case it's an error instead? I think we
> > should treat offsets that are too large in the same manner no matter
> > how large they are.
> 
> The offset being larger than thhe buffer is fine, userspace has to try to read
> until the kernel indicates that there are no more bytes left to read by
> returning zero.
> 
> But if the offset is larger than a usize there isn't a chance this can ever be
> successful in the first place, hence I'd consider this an error.

I don't really agree with this. Obviously we have to return Ok(0) if the
position is equal to the buffer size. But for positions strictly larger
than the buffer size I think it's reasonable to choose between Ok(0) or
an error. But please, let's be consistent about whether we return Ok(0)
or errors for positions larger than the buffer size.

Besides, it could succeed. Imagine a debugfs file whose contents aren't
stored in memory as a big byte array, but can be fetched / computed on
the fly based on any offset. Such a file could be larger than 4GB on a
32-bit machine no problem.

Alice

