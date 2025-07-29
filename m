Return-Path: <linux-kernel+bounces-748802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1EB14621
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0AD4E3672
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67A20296A;
	Tue, 29 Jul 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEX0lC8H"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF520ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755885; cv=none; b=LYz5aZB606na+qTuQLPYomq5tI33S1brigKXyHQA9bI84Br7A08HAqJVptKEXrcn1H1NKzn7NiafltguvjfKf8tu+Nuu51qg3R82tNv4N7mhaVpUua9CXv7KmyxQ2aZqLZySDNCAnrxiQtjZ0WSwEA+x6MOpuSi7dn+EsByJmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755885; c=relaxed/simple;
	bh=v7ULlQ8oRhg3Waf/uGW7HVtQi6rLlsRbgmbQvhpL7ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLbv0HOW0l/NpD8yyfCAhgutzLAYk7pjxKBsGwggi6yxxgk/+zezj2DSZiRz9a9kyrqZCgCNEEe9QgJ2pLevF3MnhziyK+bpIcnDmDK66uaWn8UX3FEB89EyHbPz2DjstKFrAoKJ+riOl6mUcyJ9zkO2lWcF75ksN/g60KmkOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEX0lC8H; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so5267811fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753755881; x=1754360681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd+Dzg53O5t7UFkMgGNSFCBrYAjg0xRifizsUJq0KwI=;
        b=SEX0lC8H1oTWtHYPkNQVRQzLV4o+98gjpGLdrNJBVGhqEOufwUHXUkxHVf04JFR9pJ
         XbtjuZWySCkRYh2tfHr8TjykNEhlO0KpP1vCQDr5rBMPeO+MmIdpALFcJ2Jn5uG31xxU
         odz2whV3Z12V+nI1cD2mbVjJOB4vSJbZigJAEL6cAqYcvhedCJWh1fVZnC1eKZSM7sJe
         dX9ZGFIvN3wQezrpt3U2mI5vw7AQGx4m1fqGUV+lg4IFYAB0BsF9zy9gdVyCv4xwN/sQ
         I14S3j/9/7D21mehIUH/nEz+5JzG+qMw57mrlm/VKNaan9mIKT6uhvl4LkiTtk16E+xh
         sUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753755881; x=1754360681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd+Dzg53O5t7UFkMgGNSFCBrYAjg0xRifizsUJq0KwI=;
        b=MDzEi7r0YXHz7wXpg+t9Lw5X8YADWZRjofuE3oL3jbVkl5CwL1P7v3pbdELlgZDZtQ
         3ehGXIeOb3Gbdm7ZE9fP9r4EEbQuCGGrNTs2RoVByQKig6FSRDaktxvBYguE8AIpp7TO
         YyCPD3RcrbZZ2CZ0/0/ElzEVpl1CiNHycBTzq8XkZPluU4I1Ks6qiswSFpRquUk1qLUz
         JixcvR1c7AWQCdCSrKobnCzi+igQDUDgqblpbs4sTOiAxubQA9xtDOAySh4tz/8E/nbD
         2we74qjfOlHEC+7yWREUnddduo1O0tA/2hNobRw1v9Hvhuh9d2bNcUVVAhMYpa7EMQT8
         MO/w==
X-Forwarded-Encrypted: i=1; AJvYcCWVExVFOdb9TNU0Sz1tb8SnM2qbhE5a5VKdD9gZoIu7TaJpAB3rrcJ6gvajNy89pldBkA1iYEhccJlQFf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fXZx1SFS8soHYHkKX14FXQoseElka+liJOwd/A30csAAjbvy
	4t42Z2ibPKJmzIjP3dtODYQNfUsAhqeXrSFIHS4nm0x89ltFpvY55iW5sOGScc4a8tkHKHeLZJW
	T5jPXfCL4wh4DHpXsHjwXLaqJY8/YEFT250Kd+8A=
X-Gm-Gg: ASbGncsO/Zdvr5MyQwWeQElC8ZEvDPLfd+94JGJfhc5a0kncwKZmzyDSrO1neEFCbwG
	HSP6fUbhvMv1W26gtkY+j8aFSD10j7Ol+SFFfEnNfNCWelCfWdhduzZjEAUgI73TCk2SS8DKkYE
	JAzDlZyHKRFMGft0vyMsPmnfs0A6lxTamkvics8X4LbwJ045+kewNFvKqpfwwSy24S1VDr/6NaF
	pGUsB0=
X-Google-Smtp-Source: AGHT+IFeymq4prHfwBj6WHOb8b1QylWEfWW4wNVKbT5mwWgYqJjzq9+ZEAAXpfqxDyYwZRsmMcrUGtpdFQuh0I4FNmg=
X-Received: by 2002:a2e:a01c:0:b0:30b:b78e:c445 with SMTP id
 38308e7fff4ca-3321549ac3bmr2889191fa.17.1753755881077; Mon, 28 Jul 2025
 19:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728075306.12704-1-ryncsn@gmail.com> <20250728150258.4cba730ba36da5cce659d067@linux-foundation.org>
In-Reply-To: <20250728150258.4cba730ba36da5cce659d067@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 29 Jul 2025 10:24:03 +0800
X-Gm-Features: Ac12FXyo5LUE90u4fcIAuGEL1tV1TPGLzOEP6TPG2-CxFPH7YHSLceFX52EBwVc
Message-ID: <CAMgjq7BY4WG3pq4OhL3MRsCERXxSUuWNPA36uuYbDF7d5Sz_KQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] mm/shmem, swap: bugfix and improvement of mTHP
 swap in
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E 2025=E5=B9=B47=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=BA=8C 06:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 28 Jul 2025 15:52:58 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > The current THP swapin path have several problems. It may potentially
> > hang, may cause redundant faults due to false positive swap cache looku=
p,
> > and it issues redundant Xarray walks. !CONFIG_TRANSPARENT_HUGEPAGE
> > builds may also contain unnecessary THP checks.
> >
> > This series fixes all of the mentioned issues, the code should be more
> > robust and prepared for the swap table series. Now 4 walks is reduced
> > to 3 (get order & confirm, confirm, insert folio), !CONFIG_TRANSPARENT_=
HUGEPAGE
> > build overhead is also minimized, and comes with a sanity check now.
> >
>
> Below are the changes since v5 of this series.  It's a lot, and we're
> now in the merge window.
>
> So I'll merge this into mm.git's mm-new branch.  After -rc1 I'll move
> them into mm-unstable, targeting a 6.18-rc1 merge.  However at that
> time I'll move the [1/N] patch (which has cc:stable) into mm-hotfixes,
> planning to merge that into 6.17-rcX.
>
> Does this sound OK?

Sounds good to me, thanks!

