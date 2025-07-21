Return-Path: <linux-kernel+bounces-738694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5587B0BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D183B5735
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE2219E93;
	Mon, 21 Jul 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="XlmQwrgA"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A2F32
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753075394; cv=none; b=S2Iux8wpcOl+F+suJ2SCKPe8hA3ZUcO19hFIIrjSRplKDXGKd5S9RvjumlQY66rd1i4DfIXeNmMW9pb77xyDPA/ZcXOy6qLK5/EZBmouHsH5ffMiz7LwlkJr8OuvNjm0bQNDwcS+NZdCaGPFh004cNQPqqEoSzbbYJPDMpdSEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753075394; c=relaxed/simple;
	bh=W4QbuNm3eHXcSH0Ex2QdyPj6OuSlzQfZcAHEkhea0pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiXvv1ARbqKo3bAyqZLrkWIrKwyGclJA9+s5zEzjqLDLmTRYEJyeLWMDqgGqKaDSMpynsYlhFryqYrXAeDyBMLvPuxtpxl3fqvrvMEdkUNucB+4+ii+Nm83STyqQSWNypK3P2v+BrFZ/fOYLJRRquoGDzi9qe7rXzaJKxFaa26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=XlmQwrgA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so3902364a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753075392; x=1753680192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0SHACbHK9K6txcaxkzR12JtCEcLywtnifQd4zOB/+rQ=;
        b=XlmQwrgAiSNiklZDmhykzdoaEuOYqoytA8dsY+u2rmdbNDX4Ez5R5oy+eMZToNB4bU
         SO7hx8xfUbuhd0hjv4hFvZpUBxapcM4P+IuYaCyQ02q0czKnX333neGBv93odtapggkD
         smGUZwiVdvt1zrUu/zArwLmuVHMGT+UMrf+js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753075392; x=1753680192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SHACbHK9K6txcaxkzR12JtCEcLywtnifQd4zOB/+rQ=;
        b=tHiWbvR64T+IgFPbqoZwE8ZlBNzS4LUwGiyqG+EXOA4+g8Yw6s/phvf5myGIOI7N0+
         Fi/U5JieD1NO4IQa1gNuUpZk70lFDwKJRoZB100sZWyr7Hxn/1jKOfjkQO2kmS920hvd
         Jq6dzKH35L/OGAbm1+HAYB2iGuCkvJRexBR/o9JhDy4N/RkQ0eNuZkm4IzLVeZfL6F9t
         Qe9A+ts/KJpfHhzBfZfPkGqJVIHMox92qpQWxgkzFeyy1mY8vu3cjAPgPbl8fxSkfBt2
         y1kIxtGG+g1wJIiXfU44sSGb6IGJ+1b29xUjgkkWl9la8yxmbQF8rjPJyZpgcdbIR0ew
         PY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpaf99JJqkwUduBcNbcIJNXg7Jh6ptQ9fGXqmvbsolloS5lpSkG454w6FgqJukbYTXXsQnGD1DN4xS39U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvrv7syYcbPgMjzw7tIx0wdeAPCfdE6OLx8DYweykwjYT9w2wC
	18em+cdtmQg5K31lyl7lchuWPUlkAvI5GCcQgKkJ57nlcRcdvfddTp1F7fcITvj+aYw=
X-Gm-Gg: ASbGnctRGAZio6/dA8DV8hpOe2IrsYCv6ymenSYm+ob6rVOoFyi7ujoS589gJQ3n4On
	vFGj2bP7YDE/M5vxflnUJxRd636QPmIpjHEkvFbI0Qr0PwlIPnSVe/Hyc6vr2j1PQH6hgybIzmE
	3oP5oyKbEQkddHGPnAvqfhsLginLAm1Sm7GkJVQ0gDZCiqAUFgwiKci+5SGcItspLnpJ6+Wfx55
	h1MYpJ1I/yjhiAH0Wlqj3ZWkqbxpGVmsnVQQijdUr01q6yt/DnpWRKux5dGywvhEjgUFfo8X222
	BlvJU/T/Os0fKipScTnP+eCoNFOcAVxohoVYAiZT1EQR0GjoyNqPbYZW5TEVea95w8kRzzhtrlo
	3O3YT3L/txo8y7qoDbfo7B1IyTZ4oJjzeeyDly/R2VyVx+naTmix6/w==
X-Google-Smtp-Source: AGHT+IHrxllh4+pFRTAoM/w2vfKqHEkM0kNphKoafaqRUKxLzGi1JLa2ju8qrT+3ee2/EMRl3RAndA==
X-Received: by 2002:a17:902:e790:b0:235:f70:fd39 with SMTP id d9443c01a7336-23e2566aec9mr280364645ad.10.1753075392332;
        Sun, 20 Jul 2025 22:23:12 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ed72sm49769655ad.77.2025.07.20.22.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 22:23:11 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:22:56 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: io_uring: introduce rust abstraction for
 io-uring cmd
Message-ID: <aH3OsKD6l18pLG92@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <20250719143358.22363-3-sidong.yang@furiosa.ai>
 <CADUfDZoBrnDpnTOxiDq6pBkctJ3NDJq7Wcqm2pUu_ooqMy8yyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoBrnDpnTOxiDq6pBkctJ3NDJq7Wcqm2pUu_ooqMy8yyw@mail.gmail.com>

On Sun, Jul 20, 2025 at 03:10:28PM -0400, Caleb Sander Mateos wrote:
> On Sat, Jul 19, 2025 at 10:34 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > This patch introduces rust abstraction for io-uring sqe, cmd. IoUringSqe
> > abstracts io_uring_sqe and it has cmd_data(). and IoUringCmd is
> > abstraction for io_uring_cmd. From this, user can get cmd_op, flags,
> > pdu and also sqe.
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  rust/kernel/io_uring.rs | 114 ++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs      |   1 +
> >  2 files changed, 115 insertions(+)
> >  create mode 100644 rust/kernel/io_uring.rs
> >
> > diff --git a/rust/kernel/io_uring.rs b/rust/kernel/io_uring.rs
> > new file mode 100644
> > index 000000000000..7843effbedb4
> > --- /dev/null
> > +++ b/rust/kernel/io_uring.rs
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Furiosa AI.
> > +
> > +//! Files and file descriptors.
> > +//!
> > +//! C headers: [`include/linux/io_uring/cmd.h`](srctree/include/linux/io_uring/cmd.h) and
> > +//! [`include/linux/file.h`](srctree/include/linux/file.h)
> > +
> > +use core::mem::MaybeUninit;
> > +
> > +use crate::{fs::File, types::Opaque};
> > +
> > +pub mod flags {
> > +    pub const COMPLETE_DEFER: i32 = bindings::io_uring_cmd_flags_IO_URING_F_COMPLETE_DEFER;
> > +    pub const UNLOCKED: i32 = bindings::io_uring_cmd_flags_IO_URING_F_UNLOCKED;
> > +
> > +    pub const MULTISHOT: i32 = bindings::io_uring_cmd_flags_IO_URING_F_MULTISHOT;
> > +    pub const IOWQ: i32 = bindings::io_uring_cmd_flags_IO_URING_F_IOWQ;
> > +    pub const NONBLOCK: i32 = bindings::io_uring_cmd_flags_IO_URING_F_NONBLOCK;
> > +
> > +    pub const SQE128: i32 = bindings::io_uring_cmd_flags_IO_URING_F_SQE128;
> > +    pub const CQE32: i32 = bindings::io_uring_cmd_flags_IO_URING_F_CQE32;
> > +    pub const IOPOLL: i32 = bindings::io_uring_cmd_flags_IO_URING_F_IOPOLL;
> > +
> > +    pub const CANCEL: i32 = bindings::io_uring_cmd_flags_IO_URING_F_CANCEL;
> > +    pub const COMPAT: i32 = bindings::io_uring_cmd_flags_IO_URING_F_COMPAT;
> > +    pub const TASK_DEAD: i32 = bindings::io_uring_cmd_flags_IO_URING_F_TASK_DEAD;
> > +}
> > +
> > +#[repr(transparent)]
> > +pub struct IoUringCmd {
> > +    inner: Opaque<bindings::io_uring_cmd>,
> > +}
> > +
> > +impl IoUringCmd {
> > +    /// Returns the cmd_op with associated with the io_uring_cmd.
> > +    #[inline]
> > +    pub fn cmd_op(&self) -> u32 {
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        unsafe { (*self.inner.get()).cmd_op }
> > +    }
> > +
> > +    /// Returns the flags with associated with the io_uring_cmd.
> > +    #[inline]
> > +    pub fn flags(&self) -> u32 {
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        unsafe { (*self.inner.get()).flags }
> > +    }
> > +
> > +    /// Returns the ref pdu for free use.
> > +    #[inline]
> > +    pub fn pdu(&mut self) -> MaybeUninit<&mut [u8; 32]> {
> 
> Should be &mut MaybeUninit, right? It's the bytes that may be
> uninitialized, not the reference.

Yes, it should be &mut MaybeUninit.
> 
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        unsafe { MaybeUninit::new(&mut (*self.inner.get()).pdu) }
> > +    }
> > +
> > +    /// Constructs a new `struct io_uring_cmd` wrapper from a file descriptor.
> 
> Why "from a file descriptor"?
> 
> Also, missing a comment documenting the safety preconditions?

Yes, it's a mistake in comment and also ptr should be NonNull.
> 
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::io_uring_cmd) -> &'a IoUringCmd {
> 
> Could take NonNull instead of a raw pointer.
> 
> > +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> > +        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
> 
> "File" -> "IoUringCmd"?
> 
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    // Returns the file that referenced by uring cmd self.
> 
> I had a hard time parsing this comment. How about "Returns a reference
> to the uring cmd's file object"?

Agreed. thanks.
> 
> > +    #[inline]
> > +    pub fn file<'a>(&'a self) -> &'a File {
> 
> Could elide the lifetime.

Thanks, I didn't know about this.
> 
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        let file = unsafe { (*self.inner.get()).file };
> > +        unsafe { File::from_raw_file(file) }
> 
> Missing a SAFETY comment for File::from_raw_file()? I would expect
> something about io_uring_cmd's file field storing a non-null pointer
> to a struct file on which a reference is held for the duration of the
> uring cmd.

Yes, I missed. thanks.
> 
> > +    }
> > +
> > +    // Returns the sqe  that referenced by uring cmd self.
> 
> "Returns a reference to the uring cmd's SQE"?

Agreed, thanks.
> 
> > +    #[inline]
> > +    pub fn sqe(&self) -> &IoUringSqe {
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        let ptr = unsafe { (*self.inner.get()).sqe };
> 
> "ptr" isn't very descriptive. How about "sqe"?

Sounds good.
> 
> > +        unsafe { IoUringSqe::from_raw(ptr) }
> 
> Similar, missing SAFETY comment for IoUringSqe::from_raw()?

Thanks. I missed.
> 
> > +    }
> > +
> > +    // Called by consumers of io_uring_cmd, if they originally returned -EIOCBQUEUED upon receiving the command
> > +    #[inline]
> > +    pub fn done(self, ret: isize, res2: u64, issue_flags: u32) {
> 
> I don't think it's safe to move io_uring_cmd. io_uring_cmd_done(), for
> example, calls cmd_to_io_kiocb() to turn struct io_uring_cmd *ioucmd
> into struct io_kiocb *req via a pointer cast. And struct io_kiocb's
> definitely need to be pinned in memory. For example,
> io_req_normal_work_add() inserts the struct io_kiocb into a linked
> list. Probably some sort of pinning is necessary for IoUringCmd.

Understood, Normally the users wouldn't create IoUringCmd than use borrowed cmd
in uring_cmd() callback. How about change to &mut self and also uring_cmd provides
&mut IoUringCmd for arg.

> 
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        unsafe {
> > +            bindings::io_uring_cmd_done(self.inner.get(), ret, res2, issue_flags);
> > +        }
> > +    }
> > +}
> > +
> > +#[repr(transparent)]
> > +pub struct IoUringSqe {
> > +    inner: Opaque<bindings::io_uring_sqe>,
> > +}
> > +
> > +impl<'a> IoUringSqe {
> > +    pub fn cmd_data(&'a self) -> &'a [Opaque<u8>] {
> > +        // SAFETY: The call guarantees that the pointer is not dangling and stays valid
> > +        unsafe {
> > +            let cmd = (*self.inner.get()).__bindgen_anon_6.cmd.as_ref();
> > +            core::slice::from_raw_parts(cmd.as_ptr() as *const Opaque<u8>, 8)
> 
> Why 8? Should be 16 bytes for a 64-byte SQE and 80 bytes for a
> 128-byte SQE, right?

Yes, it should be 16 bytes or 80 bytes. I'll fix this.

> 
> > +        }
> > +    }
> > +
> > +    #[inline]
> > +    pub unsafe fn from_raw(ptr: *const bindings::io_uring_sqe) -> &'a IoUringSqe {
> 
> Take NonNull here too?

Yes, Thanks.
> 
> > +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> > +        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
> > +        //
> > +        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
> 
> Why "File" and "fdget_pos"?

It's a bad mistake. thanks!

Thank you so much for deatiled review!

Thanks,
Sidong
> 
> Best,
> Caleb
> 
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 6b4774b2b1c3..fb310e78d51d 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -80,6 +80,7 @@
> >  pub mod fs;
> >  pub mod init;
> >  pub mod io;
> > +pub mod io_uring;
> >  pub mod ioctl;
> >  pub mod jump_label;
> >  #[cfg(CONFIG_KUNIT)]
> > --
> > 2.43.0
> >
> >

