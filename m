Return-Path: <linux-kernel+bounces-883371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474F6C2D412
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD090425F04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60ED3191A7;
	Mon,  3 Nov 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bt2a5WOS"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D53191A9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188045; cv=none; b=I54vzqr3OIYjsbW5CALlb7RIEb7biIXAYn+bo1Zulf/nDrwfCPhBc4s476WBhKDJ0owzP6OMBJP78JVK0Mided6r3+lUhfun7oY/W1Z5fAKv1jIvDYJvNQyEISJzNWdj2gkuhAbl6i7ezUMU0d/6WQiA/a4Updhy0qM/5CiOz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188045; c=relaxed/simple;
	bh=9bCMUjvOkdWjkWwP9YhzP1wqQaFr8Cg3GBMQaJPv+CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS938oMmWs46UtarNnVpNB5j9Bk1l9qPBlLvI8wlNIXb7UeT4sgNvb/OyzWLfOOGI4J2SezO0AuWsA6QCADOXN9ytbEbolYFHKjM02G8841s+H7zfFTpxANDRSU4xm6hAfPZzivEYNBHC9vYGlenj6ovkl1R0cg93k0SyPXVvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bt2a5WOS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa3d98838aso105099b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762188042; x=1762792842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXhErkfSN5Ykf80aBiq91H79ZOq9j/O+qJHwFazhsc4=;
        b=bt2a5WOS/PVQrXEyn7QSOxFWGZBIIqBImkDX1sYlR/ZrziMZXtbsK4u/HU3QuQA1Zw
         PlEdWBC9PiRS/w6oq/VhQtG14rjDNejHuDD67+TvLfUe3Hl+bO8aiAyhhh9NVGsCju3W
         4wPe6imnTauW7VKkOa39JX7MP0+mecZ+ega6mNV39j1mFKdUD0rGP2d2WwAA4xMTCfct
         rIJMR7hBwbtiUdZmxENspMnSdg8l69cKsd8Kbo2PkAOgXvYRkqv5h6ollFRAJrNys++X
         lMDiJWbPYtA7k+JaYOXDjF1Pi1kbb11eQKI9TkhO9fSNYIgZG9i5y6DAyCQjfEliBoHv
         RqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188042; x=1762792842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXhErkfSN5Ykf80aBiq91H79ZOq9j/O+qJHwFazhsc4=;
        b=XZiQOuSNi6z/JLFqf+5I5OVwMw4wwKcFDj+Bx3/EbGGmAUcUsqfRzDiucF+Lg30t77
         snX3EH94V0SWJ0/ZEZdM0SCTW30365Nuq21zU6PQBnaAB4L+W0A/ftlf0vXByo0yyBYi
         BKzMXDaOW13V841urZ0CLlIKz6M+BrgTF4LgnbXPa1KuoE/TQf6vydwHidv/aIlHClGl
         JXxXPlofWwVlfKBemanAL2WxVt2lQjE/b8qhCiuGXs3srboxdBh1K96oowjPH9x/6su7
         D4MLV4iWrFGI6GFwUT0OTyKS8tDivrB2yEHng+Gx9izDRtIlrUADnMj78hds3T4AOfKp
         bURA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvpjQLhtLm/sMVG5T6AZDFj7qrFNOv16MTU9X/mnlKjSjcU68XImcSQT57odz83MoA5pxv+O3L3pChHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1E1uPQYUUrNzIpfpNKcHbhdC+KNWJwXBU+iuNxIisMb0WNjWc
	uDJhghd+86l4gn1yE+1NMWNz90jh73JVEGkQWY/ZomM5T4UbBSFLG5oneGY065jSgOG1qTq1IWL
	A9cfMxbwYEcHXsEOBCG5/dyBRPXOqUlLKw4306/lyRA==
X-Gm-Gg: ASbGncvUypBENxIr1cusw9ZRsCSy2H0GynVgL+OVw0etY0s3ZTnQ4aYETekuEArzl/Z
	DqHuIG7EiyAQh7qivnFXrpe4ZLMgqZ5+x1MGfDWJgeEdSSMtcXIg4ZGbbdsqbrnKeOlaJ27kksC
	PY2RcAUXjN+2B+ApTInrJbD7qnHgT66v68h7fRiPKDbAOm/yKGOYZE3TV5y0ZE7dvowGgFOcocO
	0bhkSRAZfWcmKtsiumyPXo+EsGT7XjGBJzVoEUi6svr5M0gGLZQNKtCbHyE2sh+H8awTY4vDD7B
	A8wMGTZ7i8LeCnafRg==
X-Google-Smtp-Source: AGHT+IEANIfli1OYRBzfljhsttKi0mtbnVf8gFIB+CS7FDh7B3hC0f4DdVPuCRSUYga/2/x9Z4yzlbFVhaCixxOAQo0=
X-Received: by 2002:a17:902:c94b:b0:295:5898:ff51 with SMTP id
 d9443c01a7336-29558990087mr61529345ad.2.1762188042395; Mon, 03 Nov 2025
 08:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora>
In-Reply-To: <aQVAVBGM7inQUa7z@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 3 Nov 2025 08:40:30 -0800
X-Gm-Features: AWmQ_bkMi13oqA24NzddAoB8f-MQVQlG6JBIsNQWJjvtp-y0q9zTBduTe8H-sp0
Message-ID: <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:04=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> > On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> > > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > > > memcpy()s between the bvec_iter and the iov_iter's pages one at a t=
ime.
> > > > Switch to using copy_to_iter()/copy_from_iter() instead. This avoid=
s the
> > > > user page reference count increments and decrements and needing to =
split
> > > > the memcpy() at user page boundaries. It also simplifies the code
> > > > considerably.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 62 +++++++++---------------------------=
----
> > > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 0c74a41a6753..852350e639d6 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -912,58 +912,47 @@ static const struct block_device_operations u=
b_fops =3D {
> > > >       .open =3D         ublk_open,
> > > >       .free_disk =3D    ublk_free_disk,
> > > >       .report_zones =3D ublk_report_zones,
> > > >  };
> > > >
> > > > -#define UBLK_MAX_PIN_PAGES   32
> > > > -
> > > >  struct ublk_io_iter {
> > > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > > >       struct bio *bio;
> > > >       struct bvec_iter iter;
> > > >  };
> > >
> > > ->pages[] is actually for pinning user io pages in batch, so killing =
it may cause
> > > perf drop.
> >
> > As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
> > pinning entirely. It calls copy_to_user_iter() for each contiguous
> > user address range:
> >
> > size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i=
)
> > {
> >         if (WARN_ON_ONCE(i->data_source))
> >                 return 0;
> >         if (user_backed_iter(i))
> >                 might_fault();
> >         return iterate_and_advance(i, bytes, (void *)addr,
> >                                    copy_to_user_iter, memcpy_to_iter);
> > }
> >
> > Which just checks that the address range doesn't include any kernel
> > addresses and then memcpy()s directly via the userspace virtual
> > addresses:
> >
> > static __always_inline
> > size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> >                          size_t len, void *from, void *priv2)
> > {
> >         if (should_fail_usercopy())
> >                 return len;
> >         if (access_ok(iter_to, len)) {
> >                 from +=3D progress;
> >                 instrument_copy_to_user(iter_to, from, len);
> >                 len =3D raw_copy_to_user(iter_to, from, len);
> >         }
> >         return len;
> > }
> >
> > static __always_inline __must_check unsigned long
> > raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
> > {
> >         return copy_user_generic((__force void *)dst, src, size);
> > }
> >
> > static __always_inline __must_check unsigned long
> > copy_user_generic(void *to, const void *from, unsigned long len)
> > {
> >         stac();
> >         /*
> >          * If CPU has FSRM feature, use 'rep movs'.
> >          * Otherwise, use rep_movs_alternative.
> >          */
> >         asm volatile(
> >                 "1:\n\t"
> >                 ALTERNATIVE("rep movsb",
> >                             "call rep_movs_alternative",
> > ALT_NOT(X86_FEATURE_FSRM))
> >                 "2:\n"
> >                 _ASM_EXTABLE_UA(1b, 2b)
> >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAIN=
T
> >                 : : "memory", "rax");
> >         clac();
> >         return len;
> > }
> >
> > Am I missing something?
>
> page is allocated & mapped in page fault handler.

Right, physical pages certainly need to be allocated for the virtual
address range being copied to/from. But that would have happened
previously in iov_iter_get_pages2(), so this isn't a new cost. And as
you point out, in the common case that the virtual pages are already
mapped to physical pages, the copy won't cause any page faults.

>
> However, in typical cases, pages in io buffer shouldn't be swapped out
> frequently, so this cleanup may be good, I will run some perf test.

Thanks for testing.

>
> Also copy_page_from_iter()/copy_page_to_iter() can be used for avoiding
> bvec_kmap_local(), and the two helper can handle one whole bvec instead
> of single page.

Yes, that's a good idea. Thanks, I didn't know about that.

>
> Then rq_for_each_bvec() can be used directly, and `ublk_io_iter` may be
> killed.

Hmm, we still need a way to offset into the request (i.e. what
ublk_advance_io_iter() does currently). Are you thinking of a single
rq_for_each_bvec() loop that would skip bvecs until the offset is
reached and then copy until reaching the end of the user iterator?

Best,
Caleb

