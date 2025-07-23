Return-Path: <linux-kernel+bounces-743079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71386B0FA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E223B1AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7C20D4E9;
	Wed, 23 Jul 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLuCmQB1"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54D2E36FD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295422; cv=none; b=EyaQo98bagb7Agcd+r7w3BF6IYzVvCqXXOjMZeSk2J6uy/HhM5+hkVNxzqD9YNylvF8DlSoeh3Sqg++fiwgOzHTH4Hu2dTxpFPFqeNdkss4Du2l/HLiJOQ3HvN4MX0VImpCk/PPlNJhBGUcNa5Fhn4wFBLUo0hewCBysKOXcCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295422; c=relaxed/simple;
	bh=DNGv1NUhHSqeqTYnjdCtu5IurHWEnfDWC1lRxQO/t+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9nkC012/HuIszPoN98xoKhOHSut+N2dYCE4Yyj6NGQ/YPtmeilVZVH9UGi3SS9zlyS3Hi+MajelvJgn1swhNnOB4tC1E88poYlds/wMHxkfI9gNYv7nPbA/Kd+l/FnYM5GZ8oihsV0YdwF4ro6WaZG2AGnlTOSdh0TjGv4n+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLuCmQB1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-702cbfe860cso1657596d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753295420; x=1753900220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNGv1NUhHSqeqTYnjdCtu5IurHWEnfDWC1lRxQO/t+o=;
        b=ZLuCmQB19hGj4JJZ2UwXLInfB0NVyLE+agEvDlpylshKIDYybSQrpcgHopkLzxjNsH
         qqomlg9ZtCw1MZ6S8xkuoxWu2l3xsor0jhtIDUetQVfu0T7YWuPU1JcCVmg+8RCQfyZT
         l74iPsz3I2O0Y1yYq0bHjpq3Yfza1TRL0JrH9Q0cuW5Ez6DkZkoChj8EOGSIKLghaHqm
         hPmRYHlA2GNSWVytpqlQt/z/YkZ2YqG315Hv5SlEdWMZmExeL54ddqDw0g+4ydbOZbtg
         e3uBe+2JpekKjMkjU1t2mxoHw02XofIWXHET5uWwi2lVwoywMUbi16/CSfoca0SENDu1
         L7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295420; x=1753900220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNGv1NUhHSqeqTYnjdCtu5IurHWEnfDWC1lRxQO/t+o=;
        b=IRzkz+RwfjkDfDDmy8dhHjPL1tZYgI0dK7hpEWgB9zR5AawmL6/0UPMdJmGq0P+0er
         9a8yd2PWjEc9oMxfU/i5YZy1gVWK8cEl1XVYL4QOTeIsVs2L5pErPbGvr5SLI0ZtTfmz
         Yp6f9Y/m4yjPVDnlbd/87oMxBZM6lBemfk0zMMbOfu1C/V95ZXGiTyoCyyN8KHij50m7
         EcnvwxZiDTGRZtSEku+abIZPK0cAB/gZSZAxjqHnYwUriicezqBJ/haXGP7TFm5Z4MBR
         I4u9SBXLyTtvPy8FkX3vWVo/LDnz3PYF98LxhY3X1iQletURUCLNQruJFo5Ez8MAk5Uc
         jl1g==
X-Forwarded-Encrypted: i=1; AJvYcCXjhPOeeJqOGoycKxwhR2ezOcOp6uuw2Qn+ZKg88lJYaP4dGeJlHQeBSMt8u3cVK0Pivj3Szdp634WqW48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFEN5oDjn1WNT0zGfDnxGbO2KJzalnmYgQDip1hTjxktDBsFV
	ALm46EOTv/t+ml3BJMVE1hg0fQfWXo3TFG14VxhG/63phu7R8DAJBhxjn1xGdT0M0GGdpL2fRuq
	1bJXXYcCRUxXLFAAuHVwiCfrTXRkSjwOXh0J4tXWdn+IcRG/DaB3papIQ
X-Gm-Gg: ASbGncsaPJhVZ1qz/bm2mKef5dLbZKZaQ5PK1c2pFzKGjNmye5x3YTiuIQ9hHSenmAE
	EQI5Esq6KMYVNgYTLnRAvoJKmQMl7V/fKPLBLOxuZKaQz3wIqMLN/+IA1Nxm2noXWrVp8mT0Pct
	l3krbch6+J9cFc/SmL4wuz55zCROchOugN7dBf0IqAsxdnitJ9qHXPL+aw/mRIgaL7mwOYW7+Ad
	BCeDwBd5/jO5JLOMhldACJIGAClhfkGkQd8PFsenWSXvFEZ
X-Google-Smtp-Source: AGHT+IGkRdRkpdEunsYJ7/IdP5ziZrypUcmnd05U9PTEKhQXN0MFm1DsgkwZNIJPtXhyaRiAX9kIMkeY2zzfAfckpQ0=
X-Received: by 2002:a05:6214:cc8:b0:6f4:c824:9d4a with SMTP id
 6a1803df08f44-7070055b8d5mr66184986d6.13.1753295419272; Wed, 23 Jul 2025
 11:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
 <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
 <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
 <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com> <CAOQ4uxgqS0cK6ovwjMjSFndiFBUP1Z9ZXdAoCJayeo4W00nGLg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgqS0cK6ovwjMjSFndiFBUP1Z9ZXdAoCJayeo4W00nGLg@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Wed, 23 Jul 2025 11:30:07 -0700
X-Gm-Features: Ac12FXx2uENxO25mA23t3MuAVfRUU_3mFVzO2DUQHlXIG1eTKA8C4Sx712SRLaI
Message-ID: <CAL=UVf7zTcmd32jgQStXFWKGpUGXLPqX19uPx_Xzqm_k7QGj0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> FUSE_CREATE already returns two out args.
> How were you planning to extend it?

Excellent point. However, FUSE_CREATE (and FUSE_TMPFILE) already has
fuse_open_out as the second argument, so the backing_id can be passed
in there. Does that sound acceptable? I'll admit that at first this
seemed clunky to me, but the more I think about it, the more natural
it seems - create is really an open, so it follows that paradigm, and
the new paradigm is used only for FUSE_LOOKUP.

FUSE_READDIRPLUS is harder, it seems to me. We would need to break ABI
compatibility - I can't see any sane alternative. A clean way would be
to have a FUSE_READDIR_PASSTHROUGH opcode. This implies that there's a
flag FUSE_PASSTHROUGH_MASK covering all of this new functionality
which would also enable this new opcode. (It could, alternatively,
change the behavior of FUSE_READDIRPLUS but I suspect no one is going
to like that idea.)

Does this seem reasonable?

Thanks,
Paul




On Wed, Jul 23, 2025 at 9:53=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jul 22, 2025 at 11:13=E2=80=AFPM Paul Lawrence <paullawrence@goog=
le.com> wrote:
> >
> > I spent a little time with these patches. I wrote my own to set the
> > backing file at lookup time by adding an optional second out struct.
>
> FUSE_CREATE already returns two out args.
> How were you planning to extend it?
>
> > Is there a reason we should not do this? It seems the most natural
> > solution.
> >
> > After a while, I began to wonder if what I was planning was actually
> > the same as your vision. I decided to jot down my thoughts to see if
> > you agree with them. Also I was confused as to why you were adding the
> > ability to set backing files to GETATTR.
>
> It is a demo. It demonstrates that passthrough can be set up sooner than
> open time. It was not my intention to keep it this way.
>
> > So here are my notes.
> >
> > Design of fuse passthrough for all operations
> >
> > Goal:
> >
> > When a fuse filesystem implements a stacking filesystem over an
> > underlying file system, and a significant fraction of the calls will
> > simply be passed to the underlying file system, provide a mechanism to
> > pass those calls through without going to user space. This is
> > primarily to enhance performance, though it might simplify the daemon
> > somewhat too.
> >
> > Current state:
> >
> > Currently passthrough allows a backing file to be set at file open
> > time. If a backing file is set, all read/write operations will be
> > forwarded to the backing file.
> >
> > Design:
> >
> > Add ability to set backing file on the found inode in response to a
> > positive lookup. This file might be opened with O_PATH for performance
> > reasons. The lookup api would be modified to have an optional second
> > out struct that contains the backing file id. Note that we will use
> > the backing file ioctl to create this id to remove any security
> > concerns.
> >
> > The ioctl will also take a 64-bit integer to define which operations
> > will be passed through, the operations mask. This will have one bit
> > for each of the existing FUSE_OPERATIONS, at least the ones that act
> > on inodes/files.
> >
> > Then when fuse fs is considering calling out to the daemon with an
> > opcode, fuse fs will check if the inode has a backing file and mask.
> > If it does, and the specific opcode bit is set, fuse fs will instead
> > call out to a kernel function in backing.c that can perform that
> > operation on the backing file correctly.
> >
> > Details:
> >
> > Question: Will it be possible to change the mask/backing file after
> > the initial setting? My feeling is that it might well be useful to be
> > able to set the mask, the file not so much. Situations would be (for
> > example) a caching file system that turns off read forwarding once the
> > whole file is downloaded.
> >
>
> Generally, enabling passthrough from a point in time until the end of
> inode lifetime is easier than turning it off, but also there are many
> dependencies between passthrough ops and inode state so it will
> require a lot of care to enable *some* operations mid inode lifetime.
>
> > FUSE_OPEN will, if the backing file has been set, reopen it as a file
> > (not a path) if needed. This is whether or not FUSE_OPEN is passed
> > through.
> >
> > If FUSE_OPEN is passed through, user space will not get the chance to
> > assign a file handle ID to the opened file. It will still be possible
> > to pass FUSE_READ etc to the daemon - the daemon will still have the
> > node id and be able to read data based on that.
> >
>
> Not sure I understand what you mean, but we do support per file opt-out o=
f
> passthrough with FOPEN_DIRECT_IO even when the inode is already
> set up for passthrough.
>
> > FUSE_LOOKUP can return a 0 node id, but only if *all* operations on
> > that node as marked as passthrough.
>
> Not sure why this is but I will be open to understanding.
> Will need an elaborate design of the inode lifetime in this case.
>
> >
> > Suggestion: During FUSE_LOOKUP, if FUSE_GETATTR is set in the mask,
> > ignore the passed in attributes and read them from the backing file.
>
> My patches already implement that when GETATTR is in the mask.
>
> >
> > Random, non-exhastive list of considerations:
> >
> > FUSE_FORGET can only be marked passthrough if the node id is 0.
> >
> > FUSE_CREATE returns a new node id and file handle. It would need the
> > ability to set backing files.
> >
> > If FUSE_LOOKUP is marked for passthrough, then looked up inodes will
> > be prepopulated with a backing O_PATH file and a mask will all bits
> > set.
> >
> > FUSE_RENAME takes two nodes and names, and moves one to the other. If
> > one is passthrough and one is not, there is no obvious way of
> > performing a rename. Either fall back to copy/delete or return EXDEV
>
> Good question.
>
> My patches were meant to provide you the basic infrastructure to enter
> this playground and show that you do not need backing dentry/inode
> beyond what is already available.
>
> I hope this is enough for you to start experimenting and sending RFC patc=
hes
> with design doc!
>
> Thanks,
> Amir.

