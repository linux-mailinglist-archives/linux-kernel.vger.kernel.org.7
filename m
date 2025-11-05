Return-Path: <linux-kernel+bounces-886894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFEC36B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A18682292
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351B338F26;
	Wed,  5 Nov 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B4qVqqLO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EA337689
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359405; cv=none; b=ulU81AJ4eTT4wEG+arYeTDbojU/QU+Ve3fDlc2TVHinJv5liywe6Jy3wPKGFiYs6ze4t7ZL4MHxjAtE1uCb6wR/WYQ1Ho2qfL13jV8k4Lw5wqYUDcvxQEhuDy+fwS7vIupoCQ0UhAdoXYMzCb4STpqaS8Fj961gBgFte+Znh9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359405; c=relaxed/simple;
	bh=tF7pNe5ZqQzFvxaMFpFXzzuhaVa9lMIRRb459uM0yCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs3I15kcNsn/EWr9uHirHo5YL+VAqciQC/VVapKUlrzQiIh3Ya3UlHpwMoINM2MUr5ZCctP1reQqJC2LJ09erPCkuIUO2VudtSIluKVnVerHva6VgCz62sWENJAbPr2mtxiB6nO20i0AxjzU/Emcdfqp2JXtEXtOSxvd3UCuVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B4qVqqLO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a432101882so4975b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762359402; x=1762964202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqnhBHBoeiF8973Fe0GLdn/BJlrvu1s/JBCsPuFza5M=;
        b=B4qVqqLOAfKIHGJJdX0EqMfezK5oXwhWQg3v3SlymhcCnOSwOIrhDXjcp1c1fMaaG5
         LmEHLJ2PlbRckTWxxpEErapevgpA9So8te8cct3yLfE2NyyGQaFmbJalkUckoCA80gX3
         hF6k8VIGW9G00Oz2IA7ccQ7i1d8bted5pBb2ZeyLppX01G+ENWX6lpIPGtgGZeS+a3n3
         UwIZnLhnu7n/tOnuXRLY0qeQVU/64PLpRhUMQ5fuKBqhtqZ0vaUKHPWjMcRNfHDLdira
         pdUiaZojPRuG730zLr20iZYxh5OtrBNR9i4wiZNJ/9aygAfsS7nX0prN4Z10FOx1qVAd
         MOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359402; x=1762964202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqnhBHBoeiF8973Fe0GLdn/BJlrvu1s/JBCsPuFza5M=;
        b=BHvqMuHkRS488bsGWJ87QvIgn8UVomr2ZCVFOkFQkPG69rUFYFMhTIupD3jDsxa2Dm
         AYFWfjecn/1CNbyx3WhSuZseN3t0e1tgxlNOridRF0S7o0O86vnTdSFOPvcCu9e/09ih
         Lnd3thPMKgxMx+PeiVlH7WULHgcKmJj8aJzZeV6A9ZVRG2GR+R0z4+rC8+/LgPKzy1n1
         rMlBRMctpndXyjhzUkAjTmpHlqJVggKWlDGOtGt4fHirjKAkCBFVHVZ5gkBLg/B9D3WJ
         1PDKvYW1wtPJDnNfF9ui9OXnqsoMZ/8irsqjM2ZmV7w1mD8MLpDQ59Ubex40sGxdbs1Z
         1bGg==
X-Forwarded-Encrypted: i=1; AJvYcCXUb7UJ4odk/8nvgNDzm4pEgUgWiGQZwhnsrjXqevAiverHyOdI+Bk+T0AHdwY/pS1ixL5HVvJVquWGOnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zEnZLZYi6neRSr9pHlGJCB+gjql/oVRg9Q4BMW/jGVERTd3l
	+WaRHH307IssyZFXoHFqeP2e/ID5pw+nwV8O/oAahmWW/KSW4SN8tFEfgdSSh87DZHhrZt0ZU3r
	w85YFK9YTVM1y3wilpibA44JIc2F/CachrugEPPVLhA==
X-Gm-Gg: ASbGncuOP8rgizqcVvP+5APeZ/lzCez2nAfafZg7U4mgwtlfQ19nKvmkz/EeMeDYizU
	GdrBiYx2DDqnCkUso3oZNAmgTlWn2IobWZcaBqZYRnhDpwrNLpUgLf3AGsMr9umSavGKW2apsgF
	Y83X4BUkH3TzqafTAy1XqiVgHoY6hJGS03ZEtCZPOWill9TE2sAZXM/D/AtgDJhPZOVzcKHuGqA
	woT+VB0TpRkICO6+M1SDd6cpkPloEXyxetujFWgakem3IsgPlghy+FVpSSlERAOZZxeJa8WFSsp
	7OaWB3MJ2s+J9vqNVbY=
X-Google-Smtp-Source: AGHT+IEhkvmbUe8LOWmH9FWG9U70dCOjhixKreSZJhoVB0US9hZ6RSJfTy7SBnulDYWN6qVkJBRbXWbR9IjEtegDhZA=
X-Received: by 2002:a05:6a20:7f83:b0:343:3000:ff13 with SMTP id
 adf61e73a8af0-34f86115c1bmr2589627637.3.1762359401527; Wed, 05 Nov 2025
 08:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora> <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
In-Reply-To: <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Nov 2025 08:16:30 -0800
X-Gm-Features: AWmQ_bnYpx01tN9HAbznmh4S7u1UxBfPOGBPDJ9X4Cnh0mN_xG0z9JIzSMM6bic
Message-ID: <CADUfDZpb7QTTS6A6SV7zQVfG--Oke71Nqb5xBR2m65SoZczcTw@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:40=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Fri, Oct 31, 2025 at 4:04=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> > > On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote=
:
> > > > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > > > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > > > > memcpy()s between the bvec_iter and the iov_iter's pages one at a=
 time.
> > > > > Switch to using copy_to_iter()/copy_from_iter() instead. This avo=
ids the
> > > > > user page reference count increments and decrements and needing t=
o split
> > > > > the memcpy() at user page boundaries. It also simplifies the code
> > > > > considerably.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c | 62 +++++++++-------------------------=
------
> > > > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 0c74a41a6753..852350e639d6 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -912,58 +912,47 @@ static const struct block_device_operations=
 ub_fops =3D {
> > > > >       .open =3D         ublk_open,
> > > > >       .free_disk =3D    ublk_free_disk,
> > > > >       .report_zones =3D ublk_report_zones,
> > > > >  };
> > > > >
> > > > > -#define UBLK_MAX_PIN_PAGES   32
> > > > > -
> > > > >  struct ublk_io_iter {
> > > > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > > > >       struct bio *bio;
> > > > >       struct bvec_iter iter;
> > > > >  };
> > > >
> > > > ->pages[] is actually for pinning user io pages in batch, so killin=
g it may cause
> > > > perf drop.
> > >
> > > As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
> > > pinning entirely. It calls copy_to_user_iter() for each contiguous
> > > user address range:
> > >
> > > size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter =
*i)
> > > {
> > >         if (WARN_ON_ONCE(i->data_source))
> > >                 return 0;
> > >         if (user_backed_iter(i))
> > >                 might_fault();
> > >         return iterate_and_advance(i, bytes, (void *)addr,
> > >                                    copy_to_user_iter, memcpy_to_iter)=
;
> > > }
> > >
> > > Which just checks that the address range doesn't include any kernel
> > > addresses and then memcpy()s directly via the userspace virtual
> > > addresses:
> > >
> > > static __always_inline
> > > size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> > >                          size_t len, void *from, void *priv2)
> > > {
> > >         if (should_fail_usercopy())
> > >                 return len;
> > >         if (access_ok(iter_to, len)) {
> > >                 from +=3D progress;
> > >                 instrument_copy_to_user(iter_to, from, len);
> > >                 len =3D raw_copy_to_user(iter_to, from, len);
> > >         }
> > >         return len;
> > > }
> > >
> > > static __always_inline __must_check unsigned long
> > > raw_copy_to_user(void __user *dst, const void *src, unsigned long siz=
e)
> > > {
> > >         return copy_user_generic((__force void *)dst, src, size);
> > > }
> > >
> > > static __always_inline __must_check unsigned long
> > > copy_user_generic(void *to, const void *from, unsigned long len)
> > > {
> > >         stac();
> > >         /*
> > >          * If CPU has FSRM feature, use 'rep movs'.
> > >          * Otherwise, use rep_movs_alternative.
> > >          */
> > >         asm volatile(
> > >                 "1:\n\t"
> > >                 ALTERNATIVE("rep movsb",
> > >                             "call rep_movs_alternative",
> > > ALT_NOT(X86_FEATURE_FSRM))
> > >                 "2:\n"
> > >                 _ASM_EXTABLE_UA(1b, 2b)
> > >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRA=
INT
> > >                 : : "memory", "rax");
> > >         clac();
> > >         return len;
> > > }
> > >
> > > Am I missing something?
> >
> > page is allocated & mapped in page fault handler.
>
> Right, physical pages certainly need to be allocated for the virtual
> address range being copied to/from. But that would have happened
> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> you point out, in the common case that the virtual pages are already
> mapped to physical pages, the copy won't cause any page faults.
>
> >
> > However, in typical cases, pages in io buffer shouldn't be swapped out
> > frequently, so this cleanup may be good, I will run some perf test.
>
> Thanks for testing.
>
> >
> > Also copy_page_from_iter()/copy_page_to_iter() can be used for avoiding
> > bvec_kmap_local(), and the two helper can handle one whole bvec instead
> > of single page.
>
> Yes, that's a good idea. Thanks, I didn't know about that.

Looking into this further, copy_page_{to,from}_iter() doesn't seem
like an improvement. It still uses kmap_local_page() +
copy_{to,from}_iter() + kunmap_local() internally, and it splits the
copy at page boundaries instead of copying the whole bvec at once. I
don't think it's worth switching just to hide the bvec_kmap_local() +
kunmap_local() calls.

Best,
Caleb

