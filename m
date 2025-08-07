Return-Path: <linux-kernel+bounces-759390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03FB1DCE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711D01AA22B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B351226CFF;
	Thu,  7 Aug 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeMxJ5q4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337820299E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590213; cv=none; b=J9hSCxwmer2Gzr+7cDglyxQPAu5+iY2x8mzeANNoDgEz8Dw5oJiXXFcFPxdgK7msxVy2RFHuKHTMhoBVUH3Aakk8ubrUkeclP2x2hK4dEPukgCgUuDmVrhOxR/CmNFB2OV76FXryX9/HP7ZrgVcMqVyf4gYKvX0N7cLSUEQzVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590213; c=relaxed/simple;
	bh=undqdjb7Cj5qXyTPAeQEDrcBeJD8DH+zyfxYBBjDJpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9Z00DAySvkTcDPDuL5SBmIQcHhkj6tAjRkZnCqXoZmm5aw5N5k1VqVAykl2emz0EH0s+VS0iPbHpzxsCz0WCclAKwrAIchQhjiPiEd7opMZHBtaUMeV+LKJsIkh2wSlwubnSkzaeOlwui5HHNetZKaxmhTQ5QcI0glbeJ1SE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeMxJ5q4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b9a23d633so1403158e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754590208; x=1755195008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=undqdjb7Cj5qXyTPAeQEDrcBeJD8DH+zyfxYBBjDJpk=;
        b=BeMxJ5q47WNi4yWmNCGjTKT3V9RNVRQYczayiQBwpejp8zFAIMSchowYJg5WXupiUh
         a5eu5AmT+uiYa/5EmAkdb7VkYngAAAG7taDczJFK6BwzapOecYa6EIZjw3g7vSr4flc1
         Q1t2FVUZUWls6C4DjqZG0nwO0DDyyDghA+QJNapo6nAJs/9/vE2jyJ1tlXQY5bZBCUFM
         PCNy7Ee1bPrnKT5veYHPN/LN3qn6PpZ6kiKLmWwGNotwGd2Vt3/OCL/RYfc2KWqlEGB9
         2++rWvudVU4FQ4ERHeHgTmWakafukfLJMBWjy8IpCF9ArlLOS8NPNzZV8AWjKZFrj+Qe
         zhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754590208; x=1755195008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=undqdjb7Cj5qXyTPAeQEDrcBeJD8DH+zyfxYBBjDJpk=;
        b=RFAoroOGW7pJzF26GRwh1zQbQ+S3OT/2ueF0VjhMN537JevMeSJqxoMC+t/ETqAZMI
         M+2hFaWFJIB6uSG0YKxcwViCjsL0IlrVpvHosCl5PL6u21w8BXMb0a6MzmhTaYzqahQA
         z3o+cRLOQ1ajI0djaQUXCKuovzT8OlAp21Ewm3na0b6xO92JbAucM87wYI29IdW/4zOk
         8/6Wch52wBUQkIEWGbTyUeUbVqWKWBnspALy7NFstgthcbtASrWcEB220fA+ct4xBV3W
         xkHH2Z0PZc83soN94m6EJ34tHL+OkD15Z6n4PAWKQJ9abuSYegCw7wYdeF/VQNoDZWTV
         x2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUrvjbeYN+tymfXuT0a4Px4y04UsRSUx2g1H068Tcumj+ztzOWVWqf0sd38BvSAg/TzIlIAlkIeOvJPAXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6sskeRItE0UUDN1a/byIXB7QD7Lb/8qYnFKtkJ4EZxCb3Pbw
	GiDb7ar8iZI2Zc5MDmoI+r50Nj0bDzAkt1LpbpiSvpL15Omdb8CKU3KJZlwfA/U30uqMPgr04Dm
	15tskVTlpBylas9Z6dcRaFMAm7AtahYLTJhdseC0=
X-Gm-Gg: ASbGncsrzfPsivsq0Niu3OI3HbBEs+4ogfXY2YAFrHLJJx6FgSc9u8hx8Si6+RlAj7X
	WNICLxl6KLViyqGA6bnI34e+Ot3Ad2dM7hp+2pw0h/o0ZFRFw1eUSdkX4hgFjHSXJxCHubkF7VD
	0N9axgje5Y/oX9/BXjXOxJMWKM/O9g5lAxjEjD6pkJw7VtwSNf9Jp8uCmxENx5oNFXT4M8RowAn
	6+9TEs=
X-Google-Smtp-Source: AGHT+IFj26gAarF9lEJMiYhzLFQXeXYoZ/3YXgwEb2CQdUVeYAJ3voVdP6ox7aC7qY1raCNksDYU8dJse4iGH7bKs0o=
X-Received: by 2002:a05:6512:239c:b0:556:fb24:6f85 with SMTP id
 2adb3069b0e04-55cb61e220cmr1442281e87.22.1754590207592; Thu, 07 Aug 2025
 11:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-4-ryncsn@gmail.com>
 <CAG48ez114_bmuca2UL-g0ZY76-VqhL-4rQtJM_k0N2NJXE4vdg@mail.gmail.com>
 <CAMgjq7BhfGC7jVHQ62wAJBfTKCDG2+VdgpjiZ7hjxXeC5fHg-w@mail.gmail.com> <CAG48ez0O-Ro9-x1LZ8QdijMk57j1D2jWf3MR7F6AiDP7Wq1p_w@mail.gmail.com>
In-Reply-To: <CAG48ez0O-Ro9-x1LZ8QdijMk57j1D2jWf3MR7F6AiDP7Wq1p_w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 8 Aug 2025 02:09:31 +0800
X-Gm-Features: Ac12FXzZmSlM9Lu3wRnHAzlk8tqAltT0Tp_y8BAOl3P0HBRgteVJt8NuwhYJOpU
Message-ID: <CAMgjq7Aosd20rpFa8thPaGQ9dL-qLeq6Ki7S0H0VirQy5rh=Kw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mm/mincore: avoid touching the PTL
To: Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 1:45=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 7, 2025 at 7:28=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> > On Fri, Aug 8, 2025 at 12:06=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Thu, Aug 7, 2025 at 5:27=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > > > mincore only interested in the existence of a page, which is a
> > > > changing state by nature, locking and making it stable is not neede=
d.
> > > > And now neither mincore_page or mincore_swap requires PTL, this PTL
> > > > locking can be dropped.
> > >
> > > This means you can race such that you end up looking at an unrelated
> > > page of another process, right?
> >
> > I was thinking If the PTE is gone, it will make mincore go check the
> > page cache, but even if we hold the PTL here, the next mincore call
> > (if called soon enough) could check the page cache using the same
> > address. And it never checks any actual page if the PTE is not none.
> >
> > Perhaps you mean that it's now doing the page / swap cache lookup
> > without holding PTL so if the PTE changed, then the lookup could be
> > using an invalidated index, and may find an unrelated page.
>
> Yes, that's what I meant.
>
> > A changing PTE also means the mincore return value is changing, and if
> > called earlier or later by a little bit, the result of that address
> > could be opposite, and mincore only checks if the page existed,
> > it's hard to say the returned value is a false positive / negative?
> >
> > Or could this introduce a new security issue?
>
> I don't have specific security concerns here; but this is a change
> that trades accuracy and simplicity for performance.
>
> > > And your patch intentionally allows that to happen in order to make m=
incore() faster?
> >
> > When doing a clean up (patch 1) I noticed and didn't understand why we
> > need a PTL here. It will no longer block others and go faster as we
> > remove one lock, I can drop this one if we are not comfortable with
> > it.
>
> If you had a specific performance concern here, I think we could
> consider changing this, but in my view it would sort of be breaking
> the locking rules (by using a swap index that is not guaranteed to be
> kept alive) and would need an explanatory comment explaining the
> tradeoff.

Thanks for the explanation.

From the swap side, get_swap_device also ensures the offset is still
in the valid lookup range so the worst thing is a very rare inaccurate
value.
PTE change will mean the page is being swapped in/out or zapped, so if
the mincore is called by like a jitter earlier / later, the result
changes. So I thought it hard to define the accuracy in such a case
considering the timing.

>
> Since you only wrote the patch because you thought the lock was
> unnecessary, I'd prefer it if you drop this patch.

Understandable, I can update and keep patch 1 and 2, which improves
the performance and clean it up without causing any potential accuracy
issues.

