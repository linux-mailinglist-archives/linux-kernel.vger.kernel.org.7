Return-Path: <linux-kernel+bounces-886766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEFC365F7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68D4734F1EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC74330319;
	Wed,  5 Nov 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A8TEWHZe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454D31577D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357074; cv=none; b=jzE3pBGlAdnm0kR1ZU6c/Wu4yNIamZhitQfNvUttvvXYp75O/kl5EmrwqQKfCZ/eYi5rE1TB0z7VsCqOXE7gRyQ5wghbUJAkVMV9CmOP7T88y9I1Qks4tB+M7PawMviRKLCH2daVqs0tcEFWrQpriR8ZthDAJDsr6NGMLeyg/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357074; c=relaxed/simple;
	bh=Hrtwr+OvIPoqONQSZPSg43U6tcdzazTxhomZ6ZCqZhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwmZykYves8WA4kSG79sUU5FX061XAnf9++9r7ikCusAPYow3sLL51qfzhAAJ+9+SkK8bAdsZPNlTrmm9PUR83HYObfFf9vbzbAZ4VzP+j0O1yt0Z9Cd5Tkc2/d/hLTp7DDlxKdVMwmU9MwN7vNQEGJKQCvX4H2/EUctAUpcDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A8TEWHZe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295291fdde4so6021855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762357072; x=1762961872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z98l80RASzMLq3W9xClOY4agvDKw8ZVI+GsRz5Frd3k=;
        b=A8TEWHZeincZ9dGvXfjDdFsV7Nj9DsGDk6PO6V6A7RNFs551J9s/F3GZs0/6IUjoDg
         0EMRvrLX5kkgplBWrT1bZFZc8RKgr+NjZKNJE94MIOM8PRBRNjSIA37sRQGpKfke4B2/
         +IleLuPAKpFE60ulE191Qhbww1rM1ORDrc0+59aZxxzY89qPE2VaayBrZiBCZ281K5Ql
         K/coGERtCXxTFIhBurg0HbVHSk5os3oknv1McRHfhbO8N/q1RiE30acg2ExJ69iV3cKp
         SdJKXF/JZ+vLb2JV6nLrnCSRnvyQlDGTiCcbwbbUEWw6qbxe9EzRubaIHkDg1aqP9jdv
         zwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357072; x=1762961872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z98l80RASzMLq3W9xClOY4agvDKw8ZVI+GsRz5Frd3k=;
        b=UU3GwFrZEje7ca6v5VdwrI26gddna+dWSdLkcGETeFbZCHpSb6tRgCsoA8aDdOkunv
         4256UxDGCnK5Jwm3U7kXpU686J6SSfe/UI7mFaSbW+bKT/cLxXTW3+b1aR0N/CLpw80C
         VK/hdAvXkjWV7k7fVnrV3tNXMSGUQhTLGxVY8/tiAjECHlFcMsJQc4/o6VbN3L14+OOp
         pSQ2K4C8tSo+5Qxa0VAqkfURW6/qqFvPkfOsrixeNnOVd9gziNY0RxVocEksl4v3JC7O
         BwPnzJ+iJMLxN/9Mn85bvD4SaAmjxpgkRQ3QtFg06G42I9jZIzJhJod3emnnL/8LMcVM
         UO/g==
X-Forwarded-Encrypted: i=1; AJvYcCW0fGGektrHntkTUWJTgc6iVRVZCcDSJ8BBUoSCLAI6HXN4hjkMR5rOllwakCOk0nIhsT30hQ3yi5JqIN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvM/vArZ4sxi5cOlbfLSCCavYxYHooeVNo5TYYDGR3XT4fma3x
	KqrhzKRf2QxMh+wslrK6S0P6GppZAoEu93396ODuLTVzGToqIO23o2jp/gZtTPZondNRz1X2Lmb
	9kVozD8apjQ3T1prgyf6ejbATr2klE5tQLASCRcZzjQig7E1Orj8eg6A=
X-Gm-Gg: ASbGncuDDWpkHS84tBuidEfLPIUviCT29Q12s97hLLjfjdPtNxOrq7oMzZk82E8zvBx
	6K+iTYSVF3AjxbQjiwUfggm+D8aBMj03loPfVWuE8zoVuRDbLvZdzZ7+N+u74eD5nmH7ynjR3L2
	wEDGoFiDs+srcVuNf+L2VvY1xyRESsZoVsXKfdP3rxeCjZGkYGaBMmjeVLoIbcmZ6mWRnk7bVYT
	HHmykhhe7HMaQ8iRmsiMKloPNz0uFsn1lyt/GSfUFohZiGrb1uD8l3R5FLp+9bYOsorG7aDb2+c
	G/XGo5s/rIFYqVT7qzMIXxi7ouuv2w==
X-Google-Smtp-Source: AGHT+IGKSPTPtsfyzUQ7CTT+3b9yrZZRx+i0pNBy0TWzb3nNrWkAuCXmFZaWGRT+4HWX3HpJwN9RBOKFdQsgiFcvGVU=
X-Received: by 2002:a17:902:ecce:b0:295:ac6f:c891 with SMTP id
 d9443c01a7336-2962adaf9e8mr32333525ad.2.1762357071851; Wed, 05 Nov 2025
 07:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora> <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <aQqs2TlXU0UYlsuy@fedora> <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
In-Reply-To: <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Nov 2025 07:37:40 -0800
X-Gm-Features: AWmQ_bmiZXqpzQreXjGPIYwlUfbRst6wBvAJte0heP6tR1fvcJrjKWQSSP9puu4
Message-ID: <CADUfDZrY7v93aDtZbD4-qKAaJHcGUbWTQinEVRG4Tiiy6m2BFA@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:26=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/4/25 6:48 PM, Ming Lei wrote:
> > On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
> >> On Fri, Oct 31, 2025 at 4:04?PM Ming Lei <ming.lei@redhat.com> wrote:
> >>>
> >>> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> >>>> On Thu, Oct 30, 2025 at 8:45?PM Ming Lei <ming.lei@redhat.com> wrote=
:
> >>>>>
> >>>>> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote=
:
> >>>>>> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> >>>>>> iov_iter_get_pages2() to extract the pages from the iov_iter and
> >>>>>> memcpy()s between the bvec_iter and the iov_iter's pages one at a =
time.
> >>>>>> Switch to using copy_to_iter()/copy_from_iter() instead. This avoi=
ds the
> >>>>>> user page reference count increments and decrements and needing to=
 split
> >>>>>> the memcpy() at user page boundaries. It also simplifies the code
> >>>>>> considerably.
> >>>>>>
> >>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>>>>> ---
> >>>>>>  drivers/block/ublk_drv.c | 62 +++++++++--------------------------=
-----
> >>>>>>  1 file changed, 14 insertions(+), 48 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>>>> index 0c74a41a6753..852350e639d6 100644
> >>>>>> --- a/drivers/block/ublk_drv.c
> >>>>>> +++ b/drivers/block/ublk_drv.c
> >>>>>> @@ -912,58 +912,47 @@ static const struct block_device_operations =
ub_fops =3D {
> >>>>>>       .open =3D         ublk_open,
> >>>>>>       .free_disk =3D    ublk_free_disk,
> >>>>>>       .report_zones =3D ublk_report_zones,
> >>>>>>  };
> >>>>>>
> >>>>>> -#define UBLK_MAX_PIN_PAGES   32
> >>>>>> -
> >>>>>>  struct ublk_io_iter {
> >>>>>> -     struct page *pages[UBLK_MAX_PIN_PAGES];
> >>>>>>       struct bio *bio;
> >>>>>>       struct bvec_iter iter;
> >>>>>>  };
> >>>>>
> >>>>> ->pages[] is actually for pinning user io pages in batch, so killin=
g it may cause
> >>>>> perf drop.
> >>>>
> >>>> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the pag=
e
> >>>> pinning entirely. It calls copy_to_user_iter() for each contiguous
> >>>> user address range:
> >>>>
> >>>> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter=
 *i)
> >>>> {
> >>>>         if (WARN_ON_ONCE(i->data_source))
> >>>>                 return 0;
> >>>>         if (user_backed_iter(i))
> >>>>                 might_fault();
> >>>>         return iterate_and_advance(i, bytes, (void *)addr,
> >>>>                                    copy_to_user_iter, memcpy_to_iter=
);
> >>>> }
> >>>>
> >>>> Which just checks that the address range doesn't include any kernel
> >>>> addresses and then memcpy()s directly via the userspace virtual
> >>>> addresses:
> >>>>
> >>>> static __always_inline
> >>>> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> >>>>                          size_t len, void *from, void *priv2)
> >>>> {
> >>>>         if (should_fail_usercopy())
> >>>>                 return len;
> >>>>         if (access_ok(iter_to, len)) {
> >>>>                 from +=3D progress;
> >>>>                 instrument_copy_to_user(iter_to, from, len);
> >>>>                 len =3D raw_copy_to_user(iter_to, from, len);
> >>>>         }
> >>>>         return len;
> >>>> }
> >>>>
> >>>> static __always_inline __must_check unsigned long
> >>>> raw_copy_to_user(void __user *dst, const void *src, unsigned long si=
ze)
> >>>> {
> >>>>         return copy_user_generic((__force void *)dst, src, size);
> >>>> }
> >>>>
> >>>> static __always_inline __must_check unsigned long
> >>>> copy_user_generic(void *to, const void *from, unsigned long len)
> >>>> {
> >>>>         stac();
> >>>>         /*
> >>>>          * If CPU has FSRM feature, use 'rep movs'.
> >>>>          * Otherwise, use rep_movs_alternative.
> >>>>          */
> >>>>         asm volatile(
> >>>>                 "1:\n\t"
> >>>>                 ALTERNATIVE("rep movsb",
> >>>>                             "call rep_movs_alternative",
> >>>> ALT_NOT(X86_FEATURE_FSRM))
> >>>>                 "2:\n"
> >>>>                 _ASM_EXTABLE_UA(1b, 2b)
> >>>>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTR=
AINT
> >>>>                 : : "memory", "rax");
> >>>>         clac();
> >>>>         return len;
> >>>> }
> >>>>
> >>>> Am I missing something?
> >>>
> >>> page is allocated & mapped in page fault handler.
> >>
> >> Right, physical pages certainly need to be allocated for the virtual
> >> address range being copied to/from. But that would have happened
> >> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> >> you point out, in the common case that the virtual pages are already
> >> mapped to physical pages, the copy won't cause any page faults.
> >>
> >>>
> >>> However, in typical cases, pages in io buffer shouldn't be swapped ou=
t
> >>> frequently, so this cleanup may be good, I will run some perf test.
> >>
> >> Thanks for testing.
> >
> > `fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with t=
his
> > patch in my test VM, so looks very nice improvement.
> >
> > Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd=
,
> > and this change is correct because the copy is guaranteed to be done in=
 ublk
> > daemon context.
>
> We good to queue this up then?

Let me write a v2 implementing Ming's suggestions to use
copy_page_{to,from}_iter() and get rid of the open-coded bvec
iteration.

Thanks,
Caleb

