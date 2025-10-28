Return-Path: <linux-kernel+bounces-872862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B1C12707
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACB39560983
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53E21CC79;
	Tue, 28 Oct 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KW6XEruL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25021A95D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612560; cv=none; b=PYQLcODBPmwc6JmXlqH75QaJejMEG8O/YfJMLGfjV7c0zkyg2m/hh/SdeUfJLkAxDtvRoF4TQZGvQ0+sc7EpIAlbsUElW1l/CWPMdQcESBpzBs4+S+/XqAyLwzwj4X8RnhpKAnIgQzrB3BtmZQrtalBRDOzA0UsTpr0k3d03NzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612560; c=relaxed/simple;
	bh=O8VymtBjWaCJA2EfX0QcuNTGoReZi4HICUsymcGhH4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp65/MlsH5M1+9XmZlQHJkwlkJY3+OJOEGKXSF98YHBIkZma8TyAv/Vl9oaxz4pz02DMYuJCxxRnSina6xnN+qdmWZHy20iMCpYXt36vx3rwi2B4RRT3vnUzKv467PtJq9GvUjZ4vy1mXMSWbClY5FaE6HPNl7nqqh00L7OGm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KW6XEruL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecfd66059eso161121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761612558; x=1762217358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCvXsZaHI1SIHLVxQNQkHzVv1jTQnPjDd1JLHsOJetk=;
        b=KW6XEruLKyJmiddiSdjpY4wma817IEeFdfCSTWUilRGaFZYUyDVlbjfML7hrXR1SYf
         PNidECLvaq45AMG4sV/JetP6zjSTz7uBp4IpEASGtn48jPprQbSQrbLp//A2EO2QIAer
         W/ZsmMDeVK6FWW/eAesXhT1i47smktpY/BuSLkUR6YqeMIPIWeeJoa2c+IfwpiTGT/HJ
         Z9xBX0FHw9obHobX0I9GuHHDCttfpuEBTgY4ft26KA/YLmV2scoGaQsBUpagEiXnEBjl
         ymFJyBn744TgyQSubRUKo0SnVVR8ZYFsgiamnE8T42qyJaYyKy9X3wygRF14mF3sg2V6
         Oy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761612558; x=1762217358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCvXsZaHI1SIHLVxQNQkHzVv1jTQnPjDd1JLHsOJetk=;
        b=RnW8zU20WGv25T9GhfwEuNy42cs593Hz7h0ZsbQkOAowtSufEK1ljkMN0pM9q1GrSM
         5S9NX6DwpUZMckGokHoXBo9ytIrlK65VSYSyKLR+o1FwRFRU66p6L2hC7GcSu/H3lnw4
         pW+4RyanY8NdXmP/slneXIaroqf16EYKpXKE5+7zsldPxhEXY1gojqk7PpsEbDOBgBtk
         QSqDRAHYqVm2NXsio/WQpzj12cjh3q2RBvVpgMPMR5p0SQHLjZYEBxAkovIrFl+ys8Og
         LsYjEhieh8DTc0HAOafqK3HLuM6ln/Tr4Uk/LKQcxAZsPF8BsImot1UGHeXxWnDj9917
         P50w==
X-Forwarded-Encrypted: i=1; AJvYcCU58JSety1GMvSgAt2E3u3jlWBEiZsqwG5njKbWYWBtqYUvlanbQamQljDQucd0QyyOF3fkRaLvEl057kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/oPimtmWmQHGW1DgbTc7tjmD+G+9vt0X2/Zfx86zRwnPeEHO
	Acdylkn/Uxw6mCNHFUdBDNnMygKNHZNYjg7/B+bmxS6pnhsbqC4lhb58TpQljYiTw4lOwGzDdgR
	qDbZ40DUOLE/wgkNSDOw/1+Gb3AuuZ/NwY18omphL
X-Gm-Gg: ASbGnctUTFsKUdjdU2LPjX96H+NoIT+ZZ7jvpPXCMQ5aGoqU0kmc/pCe33qgv8804u8
	194JTMtBcEFIC7NA9dX2X+HM7s0ZbMC0lrhIpzry75aORVZLfNLSAAifVh5MvR9ecNJFO3nvaXl
	yATaPbuPWti90pbEfc4RvCzUkMQHLsCW1hv65RY9V2cXwwEwg2wJbil71KgmxDG16GvJzsSF/DC
	cfCwIqqUD6EaoEQx8ulDQWqv3YC5P2Addn5CfG3zn9xCO9tSSRgjF3cTnI=
X-Google-Smtp-Source: AGHT+IEorvkOTXjQ2KD2Ost4McwQpoPr3o5PCGxowyBvDtZaGkaLLqZcQVCC+mQgIYrmlP9rxCJ4mPNNjDyS4LIvTSo=
X-Received: by 2002:ac8:7d02:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ed09f3da7bmr2104801cf.7.1761612557521; Mon, 27 Oct 2025
 17:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024090902.1118174-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20251024090902.1118174-1-lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 17:49:06 -0700
X-Gm-Features: AWmQ_bltDXnsUE1AyN7X4o_jxjknljjL692Itljid0i8j3vBpWBt3HxocYIVeB0
Message-ID: <CAJuCfpG2f40hosmWVcgTs7O5jSgLNp8w4Mt50N2+t1k9CLLMtQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: small VMA lock cleanups
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:09=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> We declare vma_start_read() as a static function in mm/mmap_lock.c, so
> there is no need to provide a stub for !CONFIG_PER_VMA_LOCK.
>
> __is_vma_write_locked() is declared in a header and should therefore be s=
tatic
> inline.
>
> Put parens around (refcnt & VMA_LOCK_OFFSET) in is_vma_writer_only() to m=
ake
> precedence clear.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for cleaning this up!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mmap_lock.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 2c9fffa58714..e05da70dc0cb 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -130,7 +130,7 @@ static inline bool is_vma_writer_only(int refcnt)
>          * a detached vma happens only in vma_mark_detached() and is a ra=
re
>          * case, therefore most of the time there will be no unnecessary =
wakeup.
>          */
> -       return refcnt & VMA_LOCK_OFFSET && refcnt <=3D VMA_LOCK_OFFSET + =
1;
> +       return (refcnt & VMA_LOCK_OFFSET) && refcnt <=3D VMA_LOCK_OFFSET =
+ 1;
>  }
>
>  static inline void vma_refcount_put(struct vm_area_struct *vma)
> @@ -183,7 +183,7 @@ static inline void vma_end_read(struct vm_area_struct=
 *vma)
>  }
>
>  /* WARNING! Can only be used if mmap_lock is expected to be write-locked=
 */
> -static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned i=
nt *mm_lock_seq)
> +static inline bool __is_vma_write_locked(struct vm_area_struct *vma, uns=
igned int *mm_lock_seq)
>  {
>         mmap_assert_write_locked(vma->vm_mm);
>
> @@ -281,9 +281,6 @@ static inline bool mmap_lock_speculate_retry(struct m=
m_struct *mm, unsigned int
>         return true;
>  }
>  static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_=
refcnt) {}
> -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm=
,
> -                                                   struct vm_area_struct=
 *vma)
> -               { return NULL; }
>  static inline void vma_end_read(struct vm_area_struct *vma) {}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> --
> 2.51.0
>

