Return-Path: <linux-kernel+bounces-779698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D8B2F76D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D0F5A1FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF0310647;
	Thu, 21 Aug 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfCSq8GP"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646925392D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777728; cv=none; b=pMUfFVis6D31SmBUWZdRqqtQ5GB+mcg02wT21bf5Ivl8fX8L9KoXntBLoTd6jJ5SRxzFtL8rWBl0lwMlLtQf/xa/77/m3macXPtU9ddunogbV+SvVDZw7DzXbO+gOZr2Pr6sQT6a18mO3C1V2MJkOLO8yeCbIeK61aDQyFn8aJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777728; c=relaxed/simple;
	bh=n/b9EUoMlh5XowaNmwA3AZVhOC8u/3Jv5z8/6XYzy2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbXu7Jn2/s/SjM89mGtvvSuArwQMqBP1GbUQQJA5E4oHJbCDZatow1dfJmzK2NGxrdjqG/yD81yjB2zLkTw5EwThRbepBOghhX3GQ3uFCZAF1sWhZx0NIHERgxX5JB9STXrBtXGSCURhQotfw6qyTTYwiIgBU4xkEjOPq4ww3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfCSq8GP; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f8af33918so312323137.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755777726; x=1756382526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1yM8dOC77qLUHZz3KU09N9w0QVN7Fqkv+h9RU3R0NU=;
        b=HfCSq8GPhZ014z9hEuW1iGDV0ysAbaeqymG4q1kpALR4urhW2On8GvFSuv0OSRSkfh
         y1CnDcp2u4YLS3f8BaK5N6a+25UC3l7qYKcgCym9qPegBR9/kNNzewJbTKN22Y/NODrW
         qFEMNDteponKwhakPyMpSjhOCwkVy01Q46UTfUkpW/00TWAiIpkDj0yuwSG/Kmm5At/V
         3jmNESf6QrMI54J9GGv8myHfy3n+9484smLJL/rsjT/i9Nb9Nar/2KM6yF8CPblhj90Z
         yE/SYNHnuhxw8RFAkmrNBYgctJCZCzCRlGXX4ROgFyAYkga9QA+soPOnSEFkefgWGGMJ
         yNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777726; x=1756382526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1yM8dOC77qLUHZz3KU09N9w0QVN7Fqkv+h9RU3R0NU=;
        b=HQFDWFjhJoO1d9HOiksblfmY8adZXdYBAY9J2oELFJgTpOU78Z54ttuiEGBm3pSIzr
         cwwlCR/rTjUtRvdLCF/qIeiY0U6BKrWo0X+3a4qNyCk/lzuR7+R2oH2a8CGnSRo9JRQV
         ss9xugHwtTteqXavam+yzsrQew7KqmNIwxPWiU99ZmUfs4LjCrhlI06qWyf4DoMb93i2
         LME+stFxxkTUs13OnTcCMECqtnBAgoPgH/4jyJJ5AcySZ47e7CtDeLBFr12glI+L+TsW
         bmRytIg4+exDjrKCDZNFZKcoHyo9dHkIjbZCYA89oxlRjiJjGgEfIS3YiKngraSGblWc
         JvUA==
X-Forwarded-Encrypted: i=1; AJvYcCVVroNsF8X6jAQsb8c5BLgdXa4KdyKf1E1qZ2pCrTc64qOnTCdDpuiVN1wQWuj2ococvGvENSj8lqCKxBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabJ4xUPXObZ+fZkiqzT+u8MFjlJn6bt5ZZU1bDTjajNPhIkQa
	xe6/dXR9SFhTNpeAN7JJb5V0Yd/DKWvl6Q59g+BrE6KPhNd76NOL5L5/JGgT4BeMf67XW7w7NjB
	7sYbOsUB13HEqylWOj2kssDolisGb57UVeQsM
X-Gm-Gg: ASbGnctvmrTib4s8KzNJKKnpMjw8jrcoYGijcBA17X5/jeXyAHOV0te+r07BXaQ60dM
	BmcgPi+53kI9hwGkwjQ+f5robmf1Hp4nthMicSLV8KXmT0zd0afhBaEW57W/0lk7RtKJfrjN0gz
	YgfiZjqWqNhboiI5hSigc51UnV126WBpQN1UDfBhoN4+kcpA2cu/RzqwxavaYQf7AvmeLPihROT
	wBtXaN6O18xZbxJwg==
X-Google-Smtp-Source: AGHT+IGT8JOKVJersb9ahJ2+7N339JQWlZizsvMvS91QuBeOG8DXRaSRq//h+LFFPAaPbOiUivwGE9RbpnaQTIeZKY4=
X-Received: by 2002:a05:6102:5813:b0:4e7:b728:e34b with SMTP id
 ada2fe7eead31-51bdea2c9cdmr553343137.3.1755777725233; Thu, 21 Aug 2025
 05:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
 <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
In-Reply-To: <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Aug 2025 20:01:54 +0800
X-Gm-Features: Ac12FXwWXbrur_ZyKDJu7GJ10IVxUDihTxhab_C9BDYqJHmx7_tmZV1--hTvA_k
Message-ID: <CAGsJ_4xccre0rz5zgRTA=NbFzF4FLS-ZUohgLFnfTGY9Jdequg@mail.gmail.com>
Subject: Re: [RFC] Unconditionally lock folios when calling rmap_walk()
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:29=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> Adding linux-mm mailing list. Mistakenly used the wrong email address.
>
> On Wed, Aug 20, 2025 at 9:23=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > Hi all,
> >
> > Currently, some callers of rmap_walk() conditionally avoid try-locking
> > non-ksm anon folios. This necessitates serialization through anon_vma
> > write-lock when folio->mapping and/or folio->index (fields involved in
> > rmap_walk()) are to be updated. This hurts scalability due to coarse
> > granularity of the lock. For instance, when multiple threads invoke
> > userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct pages =
from
> > the same src VMA, they all contend for the corresponding anon_vma=E2=80=
=99s
> > lock. Field traces for arm64 android devices reveal over 30ms of
> > uninterruptible sleep in the main UI thread, leading to janky user
> > interactions.
> >
> > Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> > folio_referenced() is the most critical (others are
> > page_idle_clear_pte_refs(), damon_folio_young(), and
> > damon_folio_mkold()). The relevant code in folio_referenced() is:
> >
> > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
> >         we_locked =3D folio_trylock(folio);
> >         if (!we_locked)
> >                 return 1;
> > }
> >
> > It=E2=80=99s unclear why locking anon_vma (when updating folio->mapping=
) is
> > beneficial over locking the folio here. It=E2=80=99s in the reclaim pat=
h, so
> > should not be a critical path that necessitates some special
> > treatment, unless I=E2=80=99m missing something.
> >
> > Therefore, I propose simplifying the locking mechanism by
> > unconditionally try-locking the folio in such cases. This helps avoid
> > locking anon_vma when updating folio->mapping, which, for instance,
> > will help eliminate the uninterruptible sleep observed in the field
> > traces mentioned earlier. Furthermore, it enables us to simplify the
> > code in folio_lock_anon_vma_read() by removing the re-check to ensure
> > that the field hasn=E2=80=99t changed under us.

Thanks, I=E2=80=99m personally quite interested in this topic and will take=
 a
closer look as well. Beyond this one userfaultfd move, we=E2=80=99ve observ=
ed
severe anon_vma lock contention between fork, unmap (process exit), and
memory reclamation. This has caused noticeable UI stutters, especially
when many VMAs share the same anon_vma root.

Thanks
Barry

