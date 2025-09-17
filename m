Return-Path: <linux-kernel+bounces-821388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A844FB81210
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724051BC4CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2882FCC04;
	Wed, 17 Sep 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujduGSxP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323312FC03B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129038; cv=none; b=iaKc9RchkGo9hM+2Y9iBPe/qSAGdy84j8LCN2HDUpu4p0uKii9oDuQmIb9bibVM1VFQxvCt+qo89mDd5VHd0ZrpLgPMg8ZHB7eo/7qGptdFhZ/feOFmkTtOovyAdbAc4bTJuUgOkvhlk7yzhLrq87tDTNUlYDWlZulz5WbY07Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129038; c=relaxed/simple;
	bh=G2z78z3yauMJqPaeDTmkhMVkVrKmoIUwOjIXhNMkTQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClvAWL1pMjyovxBfNaVLxOPFFX7fRff1MK5EtMJjQ6DarLQuioAyotEGuw52BaBUuD6p984YBJz4CnCoKqb6yR7syzrz2JQmsVoIbvq17Q+trBLULPkuhHzY6k7R6080jbycX6i6jT2Nek0btBvx7rDvXqeFBx6IWNFoJjFX2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujduGSxP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2681645b7b6so5245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129036; x=1758733836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=ujduGSxPFIlAG+QnsapeuoRpdNPIxfZ9pixacot+GaT7TVfx3VFarvazf80LYhjHG7
         z3AWLjVXCbpIZAhrXU5l6l2FrByts4/SFUrXCvBesRk9boBIAsxXtqF+m5h1fE7oO2TT
         MdjRRq17ZUUHniuJW/UJ7HcmMspXTl8eAg2MAAnZ4ZdODotG5zo/iWesO/eXsN/YFk5w
         1/1p4vWEtIVE1ESkjapUMg/Txi+SkFjkTPJbaKZ+jEOgENsjiiKsei8ierZjiLzp5mEh
         YjPBcpoAyQhfPb1ls6gHI45hiAi2lQ3zDjjG+QoRxrA2m6IDUYUGf2j1/c7AfoRTY2p0
         ZVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129036; x=1758733836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=QBWrObTWo2hO5+CdlymcnxexZuqJGjRoLikcUtwFhU86fhAfMYLwn70wtclgVKZHc0
         n/863QC5XzeAxMR9liUCDexa0IXmSR8ObX0A5qIK2SBQmSCEAM7qVmUBiP/tjAAFsTTy
         Wa0Dm8sQR8X4HqLPNEBWd+2m5xOxVEVpjbDm/E9Fj5twI+Hqig4jHgMC1+1nxOZ9CE1I
         A/92LqEsKG7ci9lIbG+mtx5nd1csUDLH99Fra4F+hOWxRFfjNa+2solSeY91JjgvKz/R
         sqTVf/6YWJvca9ESL5d3OC1v0YrhZtTxb+7eWd4aT/QpyMBOeE3v4+6nugMnO0tmhDrT
         YUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHBJK5QiTXnOkmC1hKCIBWTqHE8oyki1LFke6rO4GyMZ+txC5uqyhvZq8F4QtS1xt15Mvp4FEBWbPPpok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVqH1cIq62Row3CBUyrVjeZBHm7lvRXuIi94WL1e0zUILcnJF
	ptuGFpnMQft+iDbCbo4Z4gMq+LGJBIdhQKa04Uv09lK7h9idMIWqrgVxSdxEcNCzZ7JRaqxLMmE
	kiDH0w5sopC2YtxVGjP8RFpLMvhgftMSqS6BWaGhh
X-Gm-Gg: ASbGnctx36dx3G5qWzZa52oVg4yFE3Bq6Ge3Sutal5tv8S3DX6SeS/4PRRz3JMXVBVN
	rhwpBTo4Eoa3fUp+8u/+oqFKAdvali5RRAtPEbck2MHscABQEKPiM9sZ+1/WQd9upCR9IavFEwb
	EObLRsonpDo9J1evIqTOD0ctzIIoVvbB6xQ/8WnG7SDrmSJdzr9LDOMoJC6Du8UljF8hbCieXqm
	YResAVCchx+TS2ORetgtOb1562I/Ghy8QmWBH1u7GfR
X-Google-Smtp-Source: AGHT+IFd4BAxZT/ufICRk+rEAu4Df/3LlVy7dl8wb8UYvf1Vkm7Wii7RkWbyYEbSSxpnLkv8kfjaHMhL5z1X210qqcg=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr4248005ad.3.1758129035969; Wed, 17 Sep 2025
 10:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com> <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
In-Reply-To: <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 10:10:24 -0700
X-Gm-Features: AS18NWB7v1zd5wRtV4XjcNUI2Kl7h_0nJ3bBXH5VRcSHiB0MqTNwu-jJe9fGDsw
Message-ID: <CAC_TJvcXzrxhWFWyE7QEgPVmEJbnfT1W=s4TdgPGGAgCpn=8Og@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:38=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.09.25 18:36, Kalesh Singh wrote:
> > The checks against sysctl_max_map_count are open-coded in multiple
> > places. While simple checks are manageable, the logic in places like
> > mremap.c involves arithmetic with magic numbers that can be difficult
> > to reason about. e.g. ... >=3D sysctl_max_map_count - 3
> >
> > To improve readability and centralize the logic, introduce a new helper=
,
> > vma_count_remaining(). This function returns the VMA count headroom
> > available for a givine process.
>
> s/givine/given/
>
> s/process/mm/
>
> >
> > The most common case of checking for a single new VMA can be done with
> > the convenience helper has_vma_count_remaining():
> >
> >      if (!vma_count_remaining(mm))
> >
> > And the complex checks in mremap.c become clearer by expressing the
> > required capacity directly:
> >
> >      if (vma_count_remaining(mm) <  4)
> >
> > While a capacity-based function could be misused (e.g., with an
> > incorrect '<' vs '<=3D' comparison), the improved readability at the ca=
ll
> > sites makes such errors less likely than with the previous open-coded
> > arithmetic.
> >
> > As part of this change, sysctl_max_map_count is made static to
> > mm/mmap.c to improve encapsulation.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
>
> [...]
>
> >       /*
> > @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
> >   int sysctl_legacy_va_layout;
> >   #endif
> >
> > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUN=
T;
> > +
> > +/**
> > + * vma_count_remaining - Determine available VMA slots
> > + * @mm: The memory descriptor for the process.
> > + *
> > + * Check how many more VMAs can be created for the given @mm
> > + * before hitting the sysctl_max_map_count limit.
> > + *
> > + * Return: The number of new VMAs the process can accommodate.
> > + */
> > +int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +     const int map_count =3D mm->map_count;
> > +     const int max_count =3D sysctl_max_map_count;
>
> If we worry about rare races (sysctl_max_map_count changing?) we should
> probably force a single read through READ_ONCE()?
>
> Otherwise one might trick vma_count_remaining() into returning a
> negative number I assume.

Agreed, I'll add the READ_ONCE when resending.

Thanks,
Kalesh

>
> > +
> > +     return (max_count > map_count) ? (max_count - map_count) : 0;
> > +}
>
> Nothing else jumped at me.
>
> Not sure what the buildbot complains about but I'm sure you'll figure it
> out :)
>
> --
> Cheers
>
> David / dhildenb
>

