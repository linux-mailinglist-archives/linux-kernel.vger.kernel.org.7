Return-Path: <linux-kernel+bounces-791054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02FFB3B18B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE6C1C85D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC621B9FD;
	Fri, 29 Aug 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSE/rUF1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C4184524
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437491; cv=none; b=d4dUIXUNhPjFPBWB2tq6Ts0An/rbVeaHR50s8QZGRyqAEsW3xtt4PkkV7AKpvITqJGAcM6g1zxpOGQToIYMz+0VtiYPJLWhD7dcwIXi2YBgolrbjVnFFRfPSWvuFFCXIc73mUPaAI69Z/kp8VEzDO+gA118UMU+NJPJCCc1az6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437491; c=relaxed/simple;
	bh=h4RSp9eYISPp3ul5CQrLdXinmL5Bsh3QxnfVtRH1dpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxgDHP7IXGpaSrElypcuD/WHRMry+BVvJXfq5ouNaXdfUn5BoBXMs43r1PeRDcxx7WX83uKAHhILbHMkaSjsRjidSmXE7jjKY9KoP/TB7NiR80Y6/+9Jo1wq6iZ7J/WFsiWkYsK0y+/oiTkdG/td6qDgoWpOdlZXvpU8jhDSARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSE/rUF1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f3f68d4bcso2637e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756437488; x=1757042288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4RSp9eYISPp3ul5CQrLdXinmL5Bsh3QxnfVtRH1dpQ=;
        b=GSE/rUF1fbxx5aRdR+Jb+ygllsU9eAduNPtdfsoDLsnM/acaZ67mvnMTsaJNunmVXD
         rQBHXKerNiNLiASKOawRhjqJRZENgUWTwABO4PyPpZfo2mtP0IYuYoxREucECtc4kIP8
         FLf6aqWUE9+KS38M/8YsQsXUCqaLmd0pI+Ta2kk8CWbaTQA30ezRCD5r2wMlkGBIVE4t
         cxdpHPj69N/RBcGTT1sXX5bKUTacXhjHtTnmRQfb9eOsuOtZUQC/jv514DIv8ALwL9UR
         q260NHeUolKa7fsPnhAVkL0Jf5q3IHC0Bq/wS1FYNdPD1bqoPZpwjaWqPZFVODB0ucGD
         8crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756437488; x=1757042288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4RSp9eYISPp3ul5CQrLdXinmL5Bsh3QxnfVtRH1dpQ=;
        b=WY6yoSVFh9rMnP673SoTTGgY30TvsyQcMF/BYp4nU7KhBcO/O0+p+fHddjI62ANt05
         nauCG72mIZmJdF3tsDGnZ7WlqVw7FkFGUd0fuvzPDeFTuDxIA+gB/8weBi5a2G/5CbMH
         mpRSkXxG3Qrb1V3MaWt88stMwXmANp+YCbdCLMOsuDL9azARKhPj80FN5ZP0Ny+i9KjA
         ckLIJaloim0LmFj3KqAOQ1wOxhfcPzuv8i3jEDeZAV32kT0wWzRpPrDIx64pSM0lCp2R
         CW6kbk/AMLp28k5TVy6c4PqFVoSOT9LNEpTZXnGWDd4nLbYtAWb75FK6JmQGBZeLT4EG
         xaog==
X-Forwarded-Encrypted: i=1; AJvYcCWwGCCN8T+djKTRXgYMPIMGhsoUSj/kb0hkhpeU53+QkojtxDmgmjyJyw+4+LJuYVh1hXG85v7+ioESq/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAW4ySvwpbApAZqfMf6l7IRzidEdls/BOQjSfZc/iSRSv5YUNw
	OSQ/CFqBkaogpdR9buVMrYPy7asrJQlnu3hILrdkuN6cylHTuC8QNtft3okjb8TJr67T9y51kOJ
	2l1mNkiW/1RdnBTb9beomBQktQKqEla5dgTjPNatm
X-Gm-Gg: ASbGnctjPFm4ZWmNu6X6n1yexmP/o/xRlqSzE8L7qkeZcY/s1hmcJYLMRBuqT/W4iuP
	y19S9UOt6N/jkbp2fIA27kz4eOIOt5kEPYXXDFQj7EB0ZdojR3gXxrL6fb3aEmX2WLRPIIqtTwb
	UWzdRISg9wfGMEuaC+6myE76PC6mgfVyfMCe7OvEVhjPIn8pFzSz3XYt4yto7WHknlCxBY4VPxt
	Iwh6K9WlGgG6cWYX8AUnd2JaChQGiBCX6BvTKpdjkuCyh/smoIrETt8kbJodqw=
X-Google-Smtp-Source: AGHT+IFI50gmtXeeaXXxJIVAnDAGK1/ITIbRhwTJOQBFj8x+oy0c1K4cSlqQEeGfc9SE/eP+mLPN+XG+5Gr3gbEHnq8=
X-Received: by 2002:a05:6512:6081:b0:55b:9f89:928b with SMTP id
 2adb3069b0e04-55f4dec0603mr835582e87.1.1756437487364; Thu, 28 Aug 2025
 20:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
 <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 29 Aug 2025 13:17:50 +1000
X-Gm-Features: Ac12FXycBYGD4I4aX2hDf4xZlIcdu2KtzzqfNLXCw0JqAv8OIzGQjgujUyOsrpM
Message-ID: <CA+zpnLeFwyCSRrQW_6hb5r3QZ3LMb1dNTKqGZ3b7gNqZQ3+OYw@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:30=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 9:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@=
google.com> wrote:
> > >
> > > Prior to this change, no security hooks were called at the creation o=
f a
> > > memfd file. It means that, for SELinux as an example, it will receive
> > > the default type of the filesystem that backs the in-memory inode. In
> > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it wil=
l
> > > be hugetlbfs. Both can be considered implementation details of memfd.
> > >
> > > It also means that it is not possible to differentiate between a file
> > > coming from memfd_create and a file coming from a standard tmpfs moun=
t
> > > point.
> > >
> > > Additionally, no permission is validated at creation, which differs f=
rom
> > > the similar memfd_secret syscall.
> > >
> > > Call security_inode_init_security_anon during creation. This ensures
> > > that the file is setup similarly to other anonymous inodes. On SELinu=
x,
> > > it means that the file will receive the security context of its task.
> > >
> > > The ability to limit fexecve on memfd has been of interest to avoid
> > > potential pitfalls where /proc/self/exe or similar would be executed
> > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > > similarly to the file class. These access vectors may not make sense =
for
> > > the existing "anon_inode" class. Therefore, define and assign a new
> > > class "memfd_file" to support such access vectors.
> > >
> > > Guard these changes behind a new policy capability named "memfd_class=
".
> > >
> > > [1] https://crbug.com/1305267
> > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google=
.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > This looks good to me, but do you have a test for it, preferably via
> > patch for the selinux-testsuite?
> > See https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8=
319e5fe222fb5af892c579593e1cbc50
> > for an example.

Not yet, I only tested internally on Android. Let me get a change
ready for selinux-testsuite.

> >
> > Otherwise, you can add my:
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks for the review!

>
> Also, we'll need a corresponding patch to define the new policy
> capability in libsepol, and will need to de-conflict with the other
> pending patches that are also trying to claim the next available
> policy capability bit (so you may end up with a different one
> upstream).

Ack. Thanks for the heads-up. Happy to rebase the commit if that helps.

