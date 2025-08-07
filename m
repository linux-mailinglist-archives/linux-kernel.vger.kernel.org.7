Return-Path: <linux-kernel+bounces-759349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F10B1DC72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29991583A01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1C2737EF;
	Thu,  7 Aug 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWWHEYqq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502526FA5A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587683; cv=none; b=laLiO7hCQmbRb3X0EybT0L3EfZPIOO6ThsYi5k51JWsmvycp4qMJP5H/v4q8NI3787OrCNCRHQdMqXJ7r7dzB+l9Go3MFYd9jTW8CaAn40tWHpJAYHbQGLPubkwHo2Tp+3y6/++lklkMMxaU6umm1QZMSutKfRxIFbAITD6Qko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587683; c=relaxed/simple;
	bh=LvjzDrIKgQsl2erKo7Ihb16VcGyaazDWcGJoJP+5K/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL1t/iUJuczP86DknExKWcuyx05Gmte5ZHJSxK4C9oql/i8opEVW6I6OSDIpM+bMbdFwEjz/eWYZaccm8PHMc9JMBnOY+e+IZL5GLZYvc4Zngf+0Czgn+lHZECMEtNzp1/jQae7LzVP16t7+OrR+24SGIpbS7wG8sxz/7Pl8WkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWWHEYqq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-332559ace6eso11550331fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587680; x=1755192480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvjzDrIKgQsl2erKo7Ihb16VcGyaazDWcGJoJP+5K/o=;
        b=lWWHEYqqUirSbkjSIVSsh8UWvHEYDKWuoZRIjYxA5fel8I4d7z3KvfEc9lI968DPv2
         NZTjwgWQDrkf1td+ubvktMdArov0Z9y31DnRjINd9p0XpQqlp4ilFVmi6ORAA/hbi6QO
         QvNvAdV9kk6hqHLwKkfSMo8a7vDYDkHXBIxMXAPkzI1FChvicrl2bvgsfiHE0KKHBkCr
         NWjRbdpNOwXkt3Lb8Oqkby1Da6yitLwXPcAeJyHEPJVBvwVUAeh0oIu5cslntp5LIfjU
         EHv7ZQmSf9Zq+IJBMpypc5XAmsHebl1Vlu318dUXK5vLi/i4Wx7uy/CQUMchh9t90AAZ
         R2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587680; x=1755192480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvjzDrIKgQsl2erKo7Ihb16VcGyaazDWcGJoJP+5K/o=;
        b=pKp3NWzXaxgKRhux4JmARwCrmb9MRrjdZFAfgc2wYhmv2IJ0BZICZVKrRtWQp5Wr25
         3Vv0BExx/Fezft6yXUt+vDRpT8usgYHhY35QPxA2PmrysGgk9FZlE+HJLVBZUEr2ltwd
         hWhJoqE9hQwQLgAXRXzGCsNV+MqV7gJ+BvFlerGa6MPayrxly4elzCE7bmyV64QZyVzs
         uuz02KZzFk/WSjgg++QHBx/ZwzAOyL2PJXyCEyiK79SYUO5G5nRSt1GoDnpJr6NoC4qx
         EkZ2wI6iJj2IHGUCE4sk5cLASUsjlniH3oejDk2hFv/2nLSTJh+eZLV/tRal9DrVhGg4
         rKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYsdi0xYebD6UjJAh/wXkF7FH+VY7SBKbAUAqt+hf7tdyssP8JLj+I7Ju5oNuGD2doQEUZ0qjJUkp4FqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU+Cf8p3SlmXs0lUj98fkoREpKg1McM8Lb92ZKbNHRuxntBUg
	mzmmpQDq5oRzY08TUIvcSZZIUTC2scXMErqPnENuv6PWFl/bMaYsZGhszXRL7WT5F2nu2O4jzI7
	J1mVwKc6Al5PCszILScNbWRd5BHNu4zc=
X-Gm-Gg: ASbGncv11i7UsjbVxMFKe3Ik9+17MIkabEGO4Xr+PMaUSy8y4ue87VLL6MWReKx65h1
	WqxtkGA+bQmaZ9efPXDoN2YV/g37rF35Ve3mEgirU5jNmEwyMpFwcv7RNi90njvIZO8GWfG3cob
	Lw0NthJ16m+No+SjlDnQV0VodQXvhQRNFP8UKgppoZEM3DjkB9pB8wvk+bjggwSQch5QOxDagO2
	OnkM7VXQ8vRe1FEDA==
X-Google-Smtp-Source: AGHT+IEsofgEMhOWhxj+6CrqZxW8VohN4VKvhX5Y/sB1Q6lk09l9sgHuPrSa5zu+rayoeA04o5iPmoqGWRidyTDUFt0=
X-Received: by 2002:a05:651c:220f:b0:332:5ffa:762f with SMTP id
 38308e7fff4ca-333813c31e7mr20434821fa.20.1754587679313; Thu, 07 Aug 2025
 10:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-4-ryncsn@gmail.com>
 <CAG48ez114_bmuca2UL-g0ZY76-VqhL-4rQtJM_k0N2NJXE4vdg@mail.gmail.com>
In-Reply-To: <CAG48ez114_bmuca2UL-g0ZY76-VqhL-4rQtJM_k0N2NJXE4vdg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 8 Aug 2025 01:27:22 +0800
X-Gm-Features: Ac12FXz2l6lNInPFGDit_HyoORi-NE2WSIgBtNtHvx6HzsR_ww-M4jCga4R7IBQ
Message-ID: <CAMgjq7BhfGC7jVHQ62wAJBfTKCDG2+VdgpjiZ7hjxXeC5fHg-w@mail.gmail.com>
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

On Fri, Aug 8, 2025 at 12:06=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Aug 7, 2025 at 5:27=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> > mincore only interested in the existence of a page, which is a
> > changing state by nature, locking and making it stable is not needed.
> > And now neither mincore_page or mincore_swap requires PTL, this PTL
> > locking can be dropped.
>
> This means you can race such that you end up looking at an unrelated
> page of another process, right?

I was thinking If the PTE is gone, it will make mincore go check the
page cache, but even if we hold the PTL here, the next mincore call
(if called soon enough) could check the page cache using the same
address. And it never checks any actual page if the PTE is not none.

Perhaps you mean that it's now doing the page / swap cache lookup
without holding PTL so if the PTE changed, then the lookup could be
using an invalidated index, and may find an unrelated page.

A changing PTE also means the mincore return value is changing, and if
called earlier or later by a little bit, the result of that address
could be opposite, and mincore only checks if the page existed,
it's hard to say the returned value is a false positive / negative?

Or could this introduce a new security issue?

> And your patch intentionally allows that to happen in order to make minco=
re() faster?

When doing a clean up (patch 1) I noticed and didn't understand why we
need a PTL here. It will no longer block others and go faster as we
remove one lock, I can drop this one if we are not comfortable with
it.

