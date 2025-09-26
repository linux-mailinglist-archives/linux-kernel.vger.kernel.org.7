Return-Path: <linux-kernel+bounces-833750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1CBA2F45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663B189AC74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277192900A8;
	Fri, 26 Sep 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5oDE31o"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009F7404E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875453; cv=none; b=jPO1y1jRY1uZH46XTE8brn8wp1ujafLeT9fZ+o/aYpbEZWuEWta1Ko8anwSEsLs28djTUE1PiG3fi149jJjHZrBNKJx4HbO2ZghQi+J043mnFgEp1OSIKtVAm9OubQRxp1gpjUD2qsS3s9m3htpKoAW6QsJrM/7Ar3OtkqPNPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875453; c=relaxed/simple;
	bh=bmYnlnjUXppvAW9s+/+M50jRLXusEMuB/votyd89wYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlQdwmqBYLFxCILhydfCzyFW1NphjPnNVz6YC4epSgi6PGMrHYhb/pTMdzLZhAWUa7VSGcx7kvX0cZ3CMf+/0g/BZCtD4SFa/xDJpFCV6zKG4LKJVZAk4skpswmP67kabhmx2jQEmEQ4utqabzhJns2/UpItGrUSvUcyI8Q007A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5oDE31o; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-791875a9071so17014216d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758875451; x=1759480251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thNEWAej1SgNRB1VQB78OWVsXGLh5leQSnto1fDdVSk=;
        b=A5oDE31oJRRIS4p+TvPV9FcFZgSiPkrchGkAtNbeK7F4Ec6b26KJg4+Cx2fj8SYaIu
         0t3nYXS9TgyZaeP0TJl65OO/iU3Q2av6g2og8XBOOkZ4zYodW/NGNheqR2b1Czf0+a4b
         YoNIJ1nugb3UcNy+AcS35SnTRct6bdhd5mvdv8oZLf/NTgIWIkAKzCRFmo/tzkxCf61j
         G4hgx7nWgnemmGDNBREZPHSUqYATd8OYZZK2ScS7PuL5upyCF/QS2QZeZ4q0kpo2hDWu
         GMkw7PrqaTuvbtBHRvt3ZmVJJYHxKnLGvruZcU4peUyPFzXBW3PFEzo7rliKP5w9D3pj
         i0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875451; x=1759480251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thNEWAej1SgNRB1VQB78OWVsXGLh5leQSnto1fDdVSk=;
        b=YPtIk8O4ky11W+vWYLV6Y9s/PaEbQVIROCr7UKJIFG7ntdUvojiPFu1t7ZhUIWFrir
         k4VO8BHzsf3yNJcQny2fzQC4/1tAy3poNNBhW/JPR5jOV++0aNT7HZhIDCzXrNpA+WbS
         g9bU3j17+TLCgvwQlOUC/UncBEv0yCgp/Vv7UhxogHyIf3Ck9KRT14DkkIVpfhzIb0Ra
         5zBnj1qSvS63MSYBeykrW2UEBBeFPkGrphEVAED/SwZ5ViaBgjIp9Cb9O16tfQPCQDmr
         ZJc3QRU/Lx3o0r4NDTzaSM3OrpymWpaJ5IuZMlOyfDMmMti4ajK0KuleF/LMgU7ROUij
         SNwA==
X-Forwarded-Encrypted: i=1; AJvYcCX7TTRj28H1FslLCW64o8qmINbaxEZPWwIFKyAfOUJc7U4C0hkc/8ExN2lKCwBb6uv+F0zIWi970dJrCd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfmMaGA5YIH2zb+X2A2KkTD6xebvImj8CljjKaKTxiKFZB+KJ
	YRu5l6ALsmX/OyhB90DEPlgjr3cMb2mPf7wAMZAvnNjo368BoIhylFrL0ITocH3OYMrvV2kj4bp
	FDsWrE7wgmtAW+p4kbaNebXtbXcfZNeo=
X-Gm-Gg: ASbGncuD3EogGC4YlcBOwDxQaHdIxblXvMGl2s/snys0VM/9anRXEFTlioPcz3jZb8m
	cVMNMRbg6vqMYsvFm6LR4KI662Ubq2gdSMZ0M9Rbg5ZNThdE2yye+lvs7jVCN/pMth1SVClwHjD
	GWK1CDSvVdoSJCB2Gi3vt0Kfd8jPPjlrjQZjwQZD7RuN8WAr7lvisR/fRj5m8/R369QXufOw28y
	JH9qCXLS23dQescpkxbgPJS+oUYGJPkS4gRXgqSNS3lZdP3Ti9d
X-Google-Smtp-Source: AGHT+IEQn2g7GaenVfYIpg8793sRNRvoNraVY1RS2Agp6V7rHhz6AY0mis3Yq6EL3hWLSblCY/erSkrYcA7XajSRSvo=
X-Received: by 2002:a05:6214:500e:b0:780:6d61:bfad with SMTP id
 6a1803df08f44-7fc3b6e52c0mr95155536d6.45.1758875450618; Fri, 26 Sep 2025
 01:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com> <CACePvbW=-KZhU_qi4UUw7Pjbz4o=SQwHmQyEOkxhpMvdetbPCg@mail.gmail.com>
In-Reply-To: <CACePvbW=-KZhU_qi4UUw7Pjbz4o=SQwHmQyEOkxhpMvdetbPCg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Sep 2025 16:30:38 +0800
X-Gm-Features: AS18NWBUnKefLjkuLJYGaF1esLUxyHaCmdfHq0pDaW4STq_tBlLvrGMPK_6-4c8
Message-ID: <CAGsJ_4zhL=4qJDmGA5E-z7=VixkUXOi+qBnN3S-WWH2UbYj=ZA@mail.gmail.com>
Subject: Re: [PATCH V2] mm: swap: check for stable address space before
 operating on the VMA
To: Chris Li <chrisl@kernel.org>
Cc: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, david@redhat.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	akpm@linux-foundation.org, shikemeng@huaweicloud.com, kasong@tencent.com, 
	nphamcs@gmail.com, bhe@redhat.com, zhangpeng.00@bytedance.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
[...]
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2389,6 +2389,8 @@ static int unuse_mm(struct mm_struct *mm, unsigne=
d int type)
> >         VMA_ITERATOR(vmi, mm, 0);
> >
> >         mmap_read_lock(mm);
> > +       if (check_stable_address_space(mm))
> > +               goto unlock;
>
> This is checking the MMF_UNSTABLE bit in the mm flags.
> What is the locking requirement for accessing the mm flags MMF_UNSTABLE b=
it?
> Here we hold the mm mmap read lock.
>
> As far as I can tell, there are two paths that can set that bit.
>
> 1) dup_mm()
> It holds the mm mmap write lock. This path is fine due to the write lock.
> So far the above race against dup_mm(), adding this  check is fine.
>
> 2)  __oom_reap_task_mm()
> It holds the mmap read lock when setting the MMF_UNSTABLE as far as I can=
 tell.
> So checking the MMF_UNSTABLE with another __oom_reap_task_mm() does
> not exclude each other.
> This is more of a question for oom reaping.
> Does MMF_UNSTABLE have the test vs set racing here? It seems this
> check does not protect against  __oom_reap_task_mm(). I have no idea
> if this race is triggerable. Just want someone else to double check if
> my understanding is correct or not.

I haven=E2=80=99t actually run the code.
My guess is there=E2=80=99s a race when checking MMF_UNSTABLE against the
OOM reaper. I think it=E2=80=99s fine either way=E2=80=94whether we skip an=
 OOM-reaped
mm upfront or take a middle path=E2=80=94since the OOM reaper will handle t=
hose
PTEs with the PTL just like unuse_pte() does and eventually free the mm
of the reaped process. It=E2=80=99s probably better to skip it early and av=
oid
unnecessary unuse_pte() calls.

>
> I can see this patch does protect the intended race in dup_mm() vs
> unuse_mm(), it adds value.

This also seems to add values for OOM-reaped processes to avoid a
useless unuse(), in case we aren=E2=80=99t skipping this mm right now. I=E2=
=80=99m
not sure if we=E2=80=99ve been skipping OOM-reaped processes elsewhere.

Hi Charan, do you have any observations on this? If an additional value is
added, could we record it in the changelog? Otherwise, can we add some
description in the changelog to address Chris=E2=80=99 concern?

Thanks
Barry

