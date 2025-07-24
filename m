Return-Path: <linux-kernel+bounces-744686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB34B10FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212E0AE4EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDC1F4701;
	Thu, 24 Jul 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DneqawH0"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA21F0E47
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374979; cv=none; b=RMs0lNEVja1nc6DapkJfeDJVafiVQGtFKssS+Rkb+TNVRZAfjzYiak1cAOTPmahcwCK9Vr2pXw6dwKkfzhobHb/PdC/IB0rx1/QO2Gy+vnGMX65DgVFaLzlVA1Q5jd3YGcJI8wK9ENL6atZok/iIrs4Rlz37miltoTletDtqf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374979; c=relaxed/simple;
	bh=nqGt3VkJa5c1wNzNWCy8jgXUeRDGPVbUUg4zAoFy1j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNBlcvkzn94F3u3ToEjkwfoVtM59AFQWWsMywLHa12Cnfma24WwcdGmsilKsE4hYRVh8KAnmiudhOSIupqN+tJBkYenREPHQYybssvU/oEs0M2qkaQ7NcG+XeaYSExLwGBno6Q+Ohda26U2UG1zg3amsMhfTHOeC8PzwebyCtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DneqawH0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab3855fca3so260021cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374977; x=1753979777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqGt3VkJa5c1wNzNWCy8jgXUeRDGPVbUUg4zAoFy1j8=;
        b=DneqawH0VGgvDZq1KGtVqQ72m7ZOi4+EiFPvhhckK9y8aujNjcAlPnIFz3FU4cu0sb
         t9Oc5FwYhMYJlhdUwR1uEEOKRO526qaqAzk/ZAqzMKwfri25NvUU67/eYVB9ymYb0tTl
         oqRPcNM9ufKn4+M99x7JDeq/mZG8JswCKbYlkaatlcigxmMSv+fLjy00AacwtfrvPBKZ
         EslbSBAYPGlSl1ckZn1A8tHNnwxtIgee9PA7f668qTVTwgx3/PQ+4MGfHZ+86emrYTmH
         S2bqRRhcvlrU+qZBHkL8D8nwCI+Ex1SvcPfo2qbY4sdIzY24JksJzknXL30HcPlVHQlc
         YBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374977; x=1753979777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqGt3VkJa5c1wNzNWCy8jgXUeRDGPVbUUg4zAoFy1j8=;
        b=qR4jaUMbnX6fjzEuGo1GirJCWDvS9+9sKWKlb7ZTKK1YIWu4NsOzcAoNTh3eVlzW7H
         KPk9k4OJqkZzeuMJTpfi8yk23ouNHFzMH9jelJLa0Bik6BRlj7SFJdTwDvuaSVfq/P+s
         GkB+m+sKoPVwnLHM94Xz2PtidQ/QO1iOqKbk3dDE4h4qyqAVv2TWZ2M3Bd+AzMcNcOe4
         Ml+TaHwYJJl9FgSpVcGWZ2dhS1AkQQ9g2u5SVR+B3197Xie2Kxs92UhZyWpKUBzxMP58
         dtuzXKipLiI8XUhYhsod6hdWAozqvgw4JTXFhNuQpTo+zefLYmLL5tvRmwAzH7T0u8Te
         6iDw==
X-Forwarded-Encrypted: i=1; AJvYcCXGJSY+yS8yKj65ZSYFN4b5/iIKrVRcoGpv1i37DobSkdoRLpMnNdwHnJDh7i9u3W2KJR1DvHERtGOY+C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpsioe/Fe7pCOfPzzVEXK/pncEVMZOH/lrohrrwYLU94QtkOMA
	kEazOa4xSkUL+G39F5D+9tKosQ3qlwxFZh0ym0TrUpvNGVvmXyXi4Y4ubPDi7jjvzp/O1FwPnTO
	idAJJDeoFzXFCSUDBKniyMF6ZVc1Dq2J4KN31hD7q
X-Gm-Gg: ASbGncttd+JZBKJjj3lBIGbzbC7LemF4Puf1pLS9WoLlxoSVBRfrmpYw6gyFpZOM+Yc
	Pvk01Yp1N+53n+dx8DrAkU24EizWif9K0i1u5p+bCRo7JKSN24nhp+gejNfM01VQHOsX4OpGA5E
	6BDm1fy0DwqJtFrn/kGXJElCeP4QpEgCzSCFwJiE+JTp9R4L2p9puppAQ+SwP9/YT4WgWWU77/Y
	G31zzyUY/KjHIh3jLkf2wkY7HhwExhhTn7azKQOsNJm1w==
X-Google-Smtp-Source: AGHT+IGEkTaoqK4mqjSdCBRA2FdSwj9nvwSmcEFhgbAaeoVMoTA5UJNh79eP58SzZx6jSiPuqEf+ILthQYauPIfrCEs=
X-Received: by 2002:a05:622a:1815:b0:4a7:e3b:50be with SMTP id
 d75a77b69052e-4ae7cb8dbddmr4286931cf.16.1753374976711; Thu, 24 Jul 2025
 09:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
 <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz> <CAG48ez0RrGX-UDhUF+1x5-euJN9z448dsrXMgv4+7-_s=zan_A@mail.gmail.com>
In-Reply-To: <CAG48ez0RrGX-UDhUF+1x5-euJN9z448dsrXMgv4+7-_s=zan_A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Jul 2025 16:36:05 +0000
X-Gm-Features: Ac12FXymU6JzZGcIsdtyJQehBIbGmtgDvjj-rJwsSEAjONoiPQWeKLqkYmWBeNg
Message-ID: <CAJuCfpGPjMSMqL1p=dMK3NJ_Cytk037Gm63TU5OuY6QK7Vi+4g@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:45=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jul 24, 2025 at 10:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> > On 7/24/25 04:30, Suren Baghdasaryan wrote:
> > > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> > > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> > > after it calls rcuwait_wake_up(). What do you think about this
> > > approach, folks?
> >
> > Yeah except it would be wasteful to do for all vma_refcount_put(). Shou=
ld be
> > enough to have this version (as Jann suggested) for inval_end_read: par=
t of
> > lock_vma_under_rcu. I think we need it also for the vma_refcount_put() =
done
> > in vma_start_read() when we fail the seqcount check? I think in that ca=
se
> > the same thing can be happening too, just with different race windows?
> >
> > Also as Jann suggested, maybe it's not great (or even safe) to perform
> > __mmdrop() under rcu? And maybe some vma_start_read() users are even mo=
re
> > restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-only=
, and
> > use that.
>
> FWIW, I think I have been mixing things up in my head - mmdrop_async()
> exists, but this comment in free_signal_struct() explains that it's
> because __mmdrop() is not softirq-safe because x86's pgd_lock spinlock
> does not disable IRQs.
>
> /*
> * __mmdrop is not safe to call from softirq context on x86 due to
> * pgd_dtor so postpone it to the async context
> */
>
> So I guess using mmdrop() here might actually be fine, since we're
> just in atomic context, not in softirq.

Thanks for looking more into this. Even if it's safe, I would still
prefer to make mmdrop() outside of RCU read section. The code might
actually end-up cleaner that way too.

