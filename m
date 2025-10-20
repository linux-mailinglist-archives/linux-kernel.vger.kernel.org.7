Return-Path: <linux-kernel+bounces-860319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBDBEFD86
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C9E4EE359
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542D2D249B;
	Mon, 20 Oct 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcSmMvb9"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC732AE70
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948009; cv=none; b=Jd1jj6cXmbO72E4lfdbYfd2SXBhBRoSBup385bSckj+IAs0heGSK+FlYzvH+gehBRMJcZJ77vQlgLXxOZpx+9Glds1KnfbkGvI3uS+hG6jWzYBwX5vNkAU8zr87xnMpvidJgkvRQZ/txEKRWWljgmyWWqhS87l8wF1p3NJ4kXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948009; c=relaxed/simple;
	bh=afK/Qx+z9RGas0HRzNSA5jN0ZqduIDpcSTfT6I/gQ7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Av2rDYuh3jk7mTy0t2r78SoAuvg/H4X0L7kPvde712G4dhZZFi0i4DcqyRYdAdSdgwvhsu0/whIdGUTdurjLNKwbp//x1wenlPHJ4tcfm01mrhkHFpdXYzfcAiwTWP2GIxTjlQwwnoSdCYQwKqQ7dZf/nkQLP06BDo3b6CPf2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcSmMvb9; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-634cdb5d528so5907926a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760948006; x=1761552806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JomsFufr5VxruBAzGqqKWxKs5V3NjgNfh0Psh5CFJ6U=;
        b=IcSmMvb92koeiNwE60G7rQY9Rk/HLBlbi+MC2+XVQX8NDX50dM4bh5D0aaffREy6iK
         zy7hvBbRe/rG3fyMer7q/Jz4b5rMWFbq95zTDY4VLcLv6Oh10Mbz3V6ew2odtKA+eGtU
         dj7XzoKrmSD87dQ9h8kXfwgF9FrCKwx6x/BO5npVuld7Sz0C1T90VUQI+BjOtuo9JQws
         YajyNC2TLotKtheL4XGfP/GL5q4YTAiZ2xxaRXbXKXjLTllF56+Q+6fkHNh76jd7JFWn
         ngGr7qyawbMxg8x+rDoX4aw3p4R0pVdzlBmIu7aaz7RA+DEo3/Tjg3CGZBX9wJkH0mUl
         e4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948006; x=1761552806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JomsFufr5VxruBAzGqqKWxKs5V3NjgNfh0Psh5CFJ6U=;
        b=pexgdQpzOcUdnDiUbbSD0YOVWdN7JSPuMva276bFfGnghbDXoZ9kfVcTYV+WaKY91Q
         OnfCRpSZe26osH0Ivnkh07rd5VFlZecPP3EXJJKb8F1jdwVm6TtiSvl9reSatBiP6wbE
         AioyLeRZWjH+eA8cj/ZgQqg8sbG3lTcEyNknTm6PT47UsHxyRlpArN8ODs/Rpu4VDOuj
         ALIj69Lp1krL95+gB4dqymqIGL5bO7l41JjgvN/d0dVIIjtG5C2c1IKsuqoBIennrwsp
         w61n/N/AiVfpA22MqUogTEZLmqfFyvQqUEsBvy3josM3IdQ/M0mt1PmVx8XaEenlcUwQ
         d7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWKRsfqnuq/om2f2BGwoDaFihTEMHil301EQ1LGS+2KjHsmSxkRyFGHRhA6GC7l9KyQHWB0euaOWnGbrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ai4vA/ANoJkU46tzo1axjaS8T1pcMpi2DrbuN7aWwtOZNXY5
	fK4RxIkT26WWpz0K2cMnisG/4cufUVNAmuKYTcIdVz7M0YHUMwIrIV/qZk+7AnFO2UGgh07rAo6
	EIOkJkzYd1QnoDR8OiA==
X-Google-Smtp-Source: AGHT+IGFoqM8MMHqDFI1tOFZ3cdMbIGCKb5OPolPUgoN9eefeCogzXHPUsYXOsFsFsY4hvT2U3wlDipVU4GnZTE=
X-Received: from edbet13.prod.google.com ([2002:a05:6402:378d:b0:63c:493e:3803])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d698:0:b0:631:6acd:fa3a with SMTP id 4fb4d7f45d1cf-63bfcdd5015mr12313526a12.4.1760948005837;
 Mon, 20 Oct 2025 01:13:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:13:24 +0000
In-Reply-To: <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-4-dakr@kernel.org>
 <aPI9tNoh0I3KGDjl@google.com> <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <aPS0aTUUwDsXmHFN@google.com> <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org>
Message-ID: <aPXvJPcSgZdNlGtB@google.com>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 19, 2025 at 01:24:05PM +0200, Danilo Krummrich wrote:
> On Sun Oct 19, 2025 at 11:50 AM CEST, Alice Ryhl wrote:
> > On Fri, Oct 17, 2025 at 04:37:48PM +0200, Danilo Krummrich wrote:
> >> On Fri Oct 17, 2025 at 2:59 PM CEST, Alice Ryhl wrote:
> >> > On Sat, Oct 04, 2025 at 12:26:40AM +0200, Danilo Krummrich wrote:
> >> >> Introduce support for read-only, write-only, and read-write binary files
> >> >> in Rust debugfs. This adds:
> >> >> 
> >> >> - BinaryWriter and BinaryReader traits for writing to and reading from
> >> >>   user slices in binary form.
> >> >> - New Dir methods: read_binary_file(), write_binary_file(),
> >> >>   `read_write_binary_file`.
> >> >> - Corresponding FileOps implementations: BinaryReadFile,
> >> >>   BinaryWriteFile, BinaryReadWriteFile.
> >> >> 
> >> >> This allows kernel modules to expose arbitrary binary data through
> >> >> debugfs, with proper support for offsets and partial reads/writes.
> >> >> 
> >> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> >
> >> >> +extern "C" fn blob_write<T: BinaryReader>(
> >> >> +    file: *mut bindings::file,
> >> >> +    buf: *const c_char,
> >> >> +    count: usize,
> >> >> +    ppos: *mut bindings::loff_t,
> >> >> +) -> isize {
> >> >> +    // SAFETY:
> >> >> +    // - `file` is a valid pointer to a `struct file`.
> >> >> +    // - The type invariant of `FileOps` guarantees that `private_data` points to a valid `T`.
> >> >> +    let this = unsafe { &*((*file).private_data.cast::<T>()) };
> >> >> +
> >> >> +    // SAFETY: `ppos` is a valid `loff_t` pointer.
> >> >> +    let pos = unsafe { &mut *ppos };
> >> >> +
> >> >> +    let mut reader = UserSlice::new(UserPtr::from_ptr(buf.cast_mut().cast()), count).reader();
> >> >> +
> >> >> +    let ret = || -> Result<isize> {
> >> >> +        let offset = (*pos).try_into()?;
> >> >
> >> > So offsets larger than the buffer result in Ok(0) unless the offset
> >> > doesn't fit in an usize, in which case it's an error instead? I think we
> >> > should treat offsets that are too large in the same manner no matter
> >> > how large they are.
> >> 
> >> The offset being larger than thhe buffer is fine, userspace has to try to read
> >> until the kernel indicates that there are no more bytes left to read by
> >> returning zero.
> >> 
> >> But if the offset is larger than a usize there isn't a chance this can ever be
> >> successful in the first place, hence I'd consider this an error.
> >
> > I don't really agree with this. Obviously we have to return Ok(0) if the
> > position is equal to the buffer size. But for positions strictly larger
> > than the buffer size I think it's reasonable to choose between Ok(0) or
> > an error. But please, let's be consistent about whether we return Ok(0)
> > or errors for positions larger than the buffer size.
> 
> There's not really a choice, it has to be Ok(0), otherwise we break userspace.
> 
> However, you do have a point with how the offset conversion to usize should be
> handled. We shouldn't try to convert it to usize in the first place, but rather
> pass it through as it is and make it a common offset-larger-buffer case.

SGTM.

> We probably also want a type alias for bindings::loff_t.

I ended up using i64 for simple_read_from_buffer in iov.rs instead of
loff_t. But if they can differ, then yeah let's introduce a loff_t type
alias.

Alice

