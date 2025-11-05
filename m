Return-Path: <linux-kernel+bounces-887024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6AEC37026
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6534F878
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9182DF3F2;
	Wed,  5 Nov 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SpNjhPbA"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23742C15B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363010; cv=none; b=d3VUUAlXSdO/9OxwLUiiFjobMbGJtSbzhRXtLiSJO1h2Y6c5OsqfdkV/oqNoUWFbtyws6MKHAMT3zMngCO42q0OUVf6sBNd8+cMmQdhvOlRMDVQOcjIAV0pT85qwY1iY5rIrzdbskFGtTZgTKq5PNvlOyV9M0WAfMWHKF62Nji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363010; c=relaxed/simple;
	bh=TAdxsoiSg/1ip9AhkKIDGGQ2ICLGdGqIQuZ5Ac2PKG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCxSdHdVx0MDpXL1N6Cll+/MXE4HHP2uLAM4c3KjS4ylEHbcCUpeTOBPbDN7WFKvY3qOXb8JK6ZF+rmYXSifaK4JEBd+Z6+cURDc8CRofaCykOXzVAkvmREtsp5xwCniNKQjh2FdBi8pPeazS4K0XOZiRCjhPQ8JdWE0w53uaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SpNjhPbA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso16153b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762363008; x=1762967808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoRVHxyponREQQqS87eXwXu2zNXSAn6dawcMeQSoUVw=;
        b=SpNjhPbAcK15qIAiB0+5P1B7OIa9WmmbNGuAYYv52xSTK+42f5BAIemETkT9hy+1T8
         mhMbfui/Ji3DTPOy31NO9Ek1+L8qZaM8dK9IUAuazQauz3L8upoEDSsExHmiYvXmEp5L
         detYxEma1YqI6T6dgbAcc2QtekHQP+IvObx05V/h9MUeb5fmEOxN8+FgvapWvflegxl1
         umFD1pZDXup4N+giYUY7zWqJVorV3TOH/kEQLK6efnvDfeYfxZVjiEudU/MfBxQzggoJ
         cPhLYNil5/kpb6CvleGITRlfpPfQIFfqnzxufh686G91YDL0UV8tIhTICUG6GJmJlC0T
         naZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363008; x=1762967808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoRVHxyponREQQqS87eXwXu2zNXSAn6dawcMeQSoUVw=;
        b=RVoQb2u1SZ1bDycMLds/S4eVjDKXNpV3qdhsMwrcOsF8p/wPs2sIdWbPFA9uxPZaq8
         qe8amWq5xLY12g8LcYu7ydZfuM4R76Xg7fn1emteoCXn2XRvixIekW7bvD1dHAy9ljX/
         ck6ZQJnHzGZtJllGfgfRUFQVbptXAXy0J9rG/0IejJjXXpMUHJpA3LMdI9sAhd2CQmoI
         6/iTr/5z6fDk0msegUyG3VTaA4VTMbX77fo0Rgy12ahu9z1TUsm13CPOTtUYJUn5nEYM
         6NDJkgDaih1ThkDtWZR2EC4cquZrlyR8V6p/nkB1ZBjC/u456TZOUmLvV+rV5ceE167x
         M3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTekZxAkWWYctBleLqkfoT6V2Xzjp0T0JmvCXJKgZIPIyCI3R8LMAcigGGK9kURsLzRmd8wFNX131cic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHqiEHS2VQS6uit7amZATgUIQkrjdP15kLqTGMY8lDBj1QadS
	HK+G3SonFngSlg8GfHIBXtLdHrEUQPnVpT+6XCRQjLGI8RRo1o1Umg1eZhmPgg0Aoru3a6EOTr2
	Axvh8ICKWv/R60fGR/pLIWBSEzgN2Mk3igeRPy5O0Tg==
X-Gm-Gg: ASbGnctXnRHhVaPjlesxKdWv0eYgrVL6bnq4ImL+6FAzKpmCvR+pF+lc7UFyYTHmABF
	Vo0jZVWmcfKi40bQuhxOlZamSy04nYuOU+ygOfuagTpqoYqhQQqXJPST4YtPYcs8INhezR6OQeE
	+hz0kUwcWAqPqtBHHPqKf7AihcdISknWUSiEYIie4Ci3jKeUkiSsXZtzMD76m/lADIwcxdNvAlw
	imPvxT+zNQOm0glTeEkwhRJb8L244Mg3l4h8KfD5QRHrPzHLR4vjohCXz10OkrB3xJ0gRAz8SKX
	vXlSakVTCLmtvc9yVAY=
X-Google-Smtp-Source: AGHT+IHbMzhjgIpT+ertSJKVlpsA74sY7d0dB6jhkDtOvTdZECVYuufMe4f8Xjg5SeCnNG2k91Ksb6906/v0ocTDDmw=
X-Received: by 2002:a05:6a21:618b:b0:341:fcbf:90b9 with SMTP id
 adf61e73a8af0-34f853f6569mr2679056637.4.1762363007804; Wed, 05 Nov 2025
 09:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora> <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <CADUfDZpb7QTTS6A6SV7zQVfG--Oke71Nqb5xBR2m65SoZczcTw@mail.gmail.com> <CADUfDZp+j+85zNiMvi0qDatzHqoDx2x8Ch48TLiF7umsCRSMuw@mail.gmail.com>
In-Reply-To: <CADUfDZp+j+85zNiMvi0qDatzHqoDx2x8Ch48TLiF7umsCRSMuw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Nov 2025 09:16:36 -0800
X-Gm-Features: AWmQ_bnbCWMYr2ivIETDgC5ygyHCFNveV0Zp3QWIv4TVkNqB_fMqgw2Xe2aTj-U
Message-ID: <CADUfDZrXyFXd5BKwaCqeQwgRO1ZjM+8JttXxMY_-WnkM1Xtx7w@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:10=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Nov 5, 2025 at 8:16=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Mon, Nov 3, 2025 at 8:40=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 4:04=E2=80=AFPM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote=
:
> > > > > On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat=
.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos w=
rote:
> > > > > > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > > > > > iov_iter_get_pages2() to extract the pages from the iov_iter =
and
> > > > > > > memcpy()s between the bvec_iter and the iov_iter's pages one =
at a time.
> > > > > > > Switch to using copy_to_iter()/copy_from_iter() instead. This=
 avoids the
> > > > > > > user page reference count increments and decrements and needi=
ng to split
> > > > > > > the memcpy() at user page boundaries. It also simplifies the =
code
> > > > > > > considerably.
> > > > > > >
> > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > > ---
> > > > > > >  drivers/block/ublk_drv.c | 62 +++++++++---------------------=
----------
> > > > > > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_dr=
v.c
> > > > > > > index 0c74a41a6753..852350e639d6 100644
> > > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > > @@ -912,58 +912,47 @@ static const struct block_device_operat=
ions ub_fops =3D {
> > > > > > >       .open =3D         ublk_open,
> > > > > > >       .free_disk =3D    ublk_free_disk,
> > > > > > >       .report_zones =3D ublk_report_zones,
> > > > > > >  };
> > > > > > >
> > > > > > > -#define UBLK_MAX_PIN_PAGES   32
> > > > > > > -
> > > > > > >  struct ublk_io_iter {
> > > > > > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > > > > > >       struct bio *bio;
> > > > > > >       struct bvec_iter iter;
> > > > > > >  };
> > > > > >
> > > > > > ->pages[] is actually for pinning user io pages in batch, so ki=
lling it may cause
> > > > > > perf drop.
> > > > >
> > > > > As far as I can tell, copy_to_iter()/copy_from_iter() avoids the =
page
> > > > > pinning entirely. It calls copy_to_user_iter() for each contiguou=
s
> > > > > user address range:
> > > > >
> > > > > size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_i=
ter *i)
> > > > > {
> > > > >         if (WARN_ON_ONCE(i->data_source))
> > > > >                 return 0;
> > > > >         if (user_backed_iter(i))
> > > > >                 might_fault();
> > > > >         return iterate_and_advance(i, bytes, (void *)addr,
> > > > >                                    copy_to_user_iter, memcpy_to_i=
ter);
> > > > > }
> > > > >
> > > > > Which just checks that the address range doesn't include any kern=
el
> > > > > addresses and then memcpy()s directly via the userspace virtual
> > > > > addresses:
> > > > >
> > > > > static __always_inline
> > > > > size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> > > > >                          size_t len, void *from, void *priv2)
> > > > > {
> > > > >         if (should_fail_usercopy())
> > > > >                 return len;
> > > > >         if (access_ok(iter_to, len)) {
> > > > >                 from +=3D progress;
> > > > >                 instrument_copy_to_user(iter_to, from, len);
> > > > >                 len =3D raw_copy_to_user(iter_to, from, len);
> > > > >         }
> > > > >         return len;
> > > > > }
> > > > >
> > > > > static __always_inline __must_check unsigned long
> > > > > raw_copy_to_user(void __user *dst, const void *src, unsigned long=
 size)
> > > > > {
> > > > >         return copy_user_generic((__force void *)dst, src, size);
> > > > > }
> > > > >
> > > > > static __always_inline __must_check unsigned long
> > > > > copy_user_generic(void *to, const void *from, unsigned long len)
> > > > > {
> > > > >         stac();
> > > > >         /*
> > > > >          * If CPU has FSRM feature, use 'rep movs'.
> > > > >          * Otherwise, use rep_movs_alternative.
> > > > >          */
> > > > >         asm volatile(
> > > > >                 "1:\n\t"
> > > > >                 ALTERNATIVE("rep movsb",
> > > > >                             "call rep_movs_alternative",
> > > > > ALT_NOT(X86_FEATURE_FSRM))
> > > > >                 "2:\n"
> > > > >                 _ASM_EXTABLE_UA(1b, 2b)
> > > > >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CON=
STRAINT
> > > > >                 : : "memory", "rax");
> > > > >         clac();
> > > > >         return len;
> > > > > }
> > > > >
> > > > > Am I missing something?
> > > >
> > > > page is allocated & mapped in page fault handler.
> > >
> > > Right, physical pages certainly need to be allocated for the virtual
> > > address range being copied to/from. But that would have happened
> > > previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> > > you point out, in the common case that the virtual pages are already
> > > mapped to physical pages, the copy won't cause any page faults.
> > >
> > > >
> > > > However, in typical cases, pages in io buffer shouldn't be swapped =
out
> > > > frequently, so this cleanup may be good, I will run some perf test.
> > >
> > > Thanks for testing.
> > >
> > > >
> > > > Also copy_page_from_iter()/copy_page_to_iter() can be used for avoi=
ding
> > > > bvec_kmap_local(), and the two helper can handle one whole bvec ins=
tead
> > > > of single page.
> > >
> > > Yes, that's a good idea. Thanks, I didn't know about that.
> >
> > Looking into this further, copy_page_{to,from}_iter() doesn't seem
> > like an improvement. It still uses kmap_local_page() +
> > copy_{to,from}_iter() + kunmap_local() internally, and it splits the
> > copy at page boundaries instead of copying the whole bvec at once. I
> > don't think it's worth switching just to hide the bvec_kmap_local() +
> > kunmap_local() calls.
>
> Maybe that's because bvec_kmap_local() only maps the first page of the
> bvec even if it spans multiple pages? Seems like it may be an existing
> bug that ublk_copy_io_pages() can copy past the end of the page
> returned from bvec_kmap_local(). But given that kmap_local_page() is a
> no-op when CONFIG_HIGHMEM is disabled, it's probably not visible in
> typical configurations.

I guess bio_iter_iovec() restricts the bvec to a single page, so
there's no existing issue. If we switch to rq_for_each_bvec(), we'll
need to use copy_page_{to,from}_iter(). Sorry for the thinking out
loud...

Best,
Caleb

