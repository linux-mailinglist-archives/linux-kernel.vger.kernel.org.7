Return-Path: <linux-kernel+bounces-726981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A2B01394
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E0B1CA21B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEC1DDC00;
	Fri, 11 Jul 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A56O21wa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD61C5F2C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215364; cv=none; b=I9QRdA3oP4LFzhA/kZgZM0MpG0mOYUsB2Da+JOuRNglEVZGrbVCw1UY/C75JNeVpdvPz+qudQ2Oidk3P5pSTJ7S+YScHlKAE5ll9MCWx2Urjh2vHl+4/0kMirN2m3YOKI2wSeb22vK6E6r1mX7qhVQIibO/sCSmYQfPv4XYf4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215364; c=relaxed/simple;
	bh=YxijRS09fAKGhYWr6bhNmx3FtmC98o+dJoUr1wDbkWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/KIEGWbHMND5p/hYfg9WS47qDGAjuUb7TCRzL9T9gJYnfshamS8gn3zFybhEwyY47RbsYlv9ZLAr6n1zU7isZvLiRiYphLH2nYHQEzbF1kyDZqdw7SubKlt5tO2N06OyRc596TFH3dr4z+404IP08z6top7bbGc8O2v4kppWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A56O21wa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so15399501fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215360; x=1752820160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu5E02Tz8sonF88pjrRAtZKJjnl5WUYj9ngSree7y1I=;
        b=A56O21waoYyC78S6gK0IiXaFqJP4uGte0vTJYWE+DFRHT8hq0kxOGzmhFHxlNQHKyT
         AD+CMSqmHsII/NNS2lmjQQSjZv5O+HS6ThHOPqTnJQUDmD9LocX6k/7NHg2KMYRwLmOg
         l17uCLU7O48+hhsrcc3BYPOFk+/R080oHFCifvcT/VEWnlTgAIXGSHIzB6joySEwUbmj
         zDxd0iBw/Gc6oa7wxE2MplXX8OLFh5EZxRrvhqa2FYErfD0rGcU6oR2RbGLsTr9U1/WK
         9z+sLfX9f/YaLe9kcE//jCDxhKouFTf7S7HIO2qeCgy4jW+4hhJMZbu1B7Czc0qM/qGw
         lhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215360; x=1752820160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu5E02Tz8sonF88pjrRAtZKJjnl5WUYj9ngSree7y1I=;
        b=ZPU1fOsOZmPt5k2SlFEGnbav5MnDZ9QzDq2onq5MbdIjZF7Fua4I20bAWbt0ylLn0H
         NI00WYObwzLdH9ytVLK8g8CDU0KUhDoV5A1bspgs9nh3IS5cdrlUISYjyVYcszb4sG5c
         nHfgear98pGTr3zgo9NJzUCWWGjow+K9aUiou7DiPhugIRFKh+tZqpKqdouNr+XFyIb+
         xKxXCWxuf5JNN6qGnm65/miljziLVBcayyuwiepAHC5H32n/q1e2Yjx8KaWPgANQvOR2
         yRJBVK1O9/TyMAo382sytLPnHCS0BLJN7QAA3mj6nAUM6L86NeRfYSO6DC0eLAYKQ9on
         VYOw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+OZKTYfgFDIXzDlCEFuKLU+FZJhEQHNSd5rR0IsPkl2j+r69yIO6vtMK4Eb6EIPZd3YTZV8BOnRTx9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiCzQd++0Hwrg1XhQjRl2AhCMpxE/640BbDF5/bpStoCyvt4c
	EmK6Q/1G39orwUtBAyYv8zzWlmOw019QuwgVIcGkGR4gs3CAlvHP3xSWFKW43Qh1irwyOd7Rq8z
	Ks+hUmqsB6MwroDaNkHNK1ssUwM5kTpE=
X-Gm-Gg: ASbGncuK/kAb0a/kcaR4HGtASNxn+YOUHnQA16QlQfZmTuKYPJZ/oUxfkqeUdQcgywP
	kNl4iSh4pAJBfSg9pmLWN0FV6oxpzJhsWmz125WhB/NgFc9qJDkfrOA3+7DWwrAE/V4em9tvTVX
	WjbrUfowm+p1EVayK34nJOxq/BZqMG+3RbjvqIHwsM7T7uYl1bUylVS4x7Rrg1lXYjZ4l7vJL95
	C/THFk=
X-Google-Smtp-Source: AGHT+IFsXmgG4Hxg+cg6+SLo/mkUjzPz/39yLkz1m+RzQzzlRzB3h4hzCVNT4GDiQfyR1stChxE+BtGaSN/5L4KgAB8=
X-Received: by 2002:a05:651c:40e:b0:32b:3cf5:2ff3 with SMTP id
 38308e7fff4ca-330533d821fmr4409051fa.22.1752215360179; Thu, 10 Jul 2025
 23:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-7-ryncsn@gmail.com>
 <57e82add-b8d5-49cb-8a3e-58c7c65768d0@linux.alibaba.com>
In-Reply-To: <57e82add-b8d5-49cb-8a3e-58c7c65768d0@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 11 Jul 2025 14:28:39 +0800
X-Gm-Features: Ac12FXzCdCLDdRPa9y8HBDq1sE9Ojdw-RlpACb6MtZLbEwVrg9v_lKiQbE6FUwI
Message-ID: <CAMgjq7CoFf52Wa9-6GoowFnaU0+VC6Lb+mzgjipB0nrhLeA8yQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] mm/shmem, swap: simplify swapin path and result handling
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 2:23=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/10 11:37, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Slightly tidy up the different handling of swap in and error handling
> > for SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices. Now swapin
> > will always use either shmem_swap_alloc_folio or shmem_swapin_cluster,
> > then check the result.
> >
> > Simplify the control flow and avoid a redundant goto label.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> LGTM, with a nit as follows.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> > ---
> >   mm/shmem.c | 45 +++++++++++++++++++--------------------------
> >   1 file changed, 19 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 847e6f128485..80f5b8c73eb8 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2320,40 +2320,33 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >                       count_memcg_event_mm(fault_mm, PGMAJFAULT);
> >               }
> >
> > -             /* Skip swapcache for synchronous device. */
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> > +                     /* Direct mTHP swapin skipping swap cache & readh=
aed */
> >                       folio =3D shmem_swap_alloc_folio(inode, vma, inde=
x, swap, order, gfp);
>
> Nit: the 'mTHP' word can be confusing, since we will skip swapcache for
> order 0 too. Please drop it.
>

Yes, thanks for the review.

