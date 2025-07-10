Return-Path: <linux-kernel+bounces-724926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83715AFF89E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7101769F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C22868BE;
	Thu, 10 Jul 2025 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yRJQ8mq"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1134286416
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126595; cv=none; b=jSd5Q6SAOM2oTbbyZxNBC5W/5ZSLyuOPhXBS8MmwFXcEkUL5ulzFUiMko8pznqP/KctBcIyBXbSg1ZT0ST1M9ly8+6NHIrxY4cSHdMRszusWMGWYYQONRyvkP8y2kfxyu6ddtGpwGkuhZOZZeo01r2DT1z7CkKy/yIRrMj9r/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126595; c=relaxed/simple;
	bh=h0KjSpeWdigZAZsRt1k8nf58qKzquiGW74F6JUkVpXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzEYl3dZVaYbiLoNs96bqW9ttFGKMGzjlRzM0caGhgMiWqLFwBngJgoQD436a7W0rpOR7bpvXOWR4LbXwKO8chF969fdul65I7xTZWFauWSG1WICq8K3qhvcBnGn87Jbt/JaIAT12bMhEtdzXk/lHs01ZhrOkaPZj4RDfFSWLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yRJQ8mq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso150251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752126592; x=1752731392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2DkamPXkqG5QCK86AOwRmXVbMEqNBmAF1PKjGfsOCw=;
        b=4yRJQ8mqpUDSOh2uiqNou9iyLo1sNhsqpDvPZCNQqfz4RssJl7EfiOhP+l3yAr9ULT
         ltQV+NQLXLiEXCMZJ+Rj4o8dt3Ee9Jha7R5LRcCbfaOFYlQdKL0QdevEjauyuhWfLWUD
         9RB56VVVtQv53V6pPNZp6+bQXS/PNVOVaeFa+IM9Ul87A8VzNtZyYQUHO2hgmj78iJdC
         tHhnU8+xmaoZrtPLeyZVrZVnvcfFG7zbxJo0DcuUNfGJRNwpIChzOFYdaYUv6KjDzfWI
         SrlMFv8b2kHQ6odQykd1dWGT/iPY/aZo/H7DECb0owkHa5ENJSk5rGhwozqwNf5XANub
         lOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752126592; x=1752731392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2DkamPXkqG5QCK86AOwRmXVbMEqNBmAF1PKjGfsOCw=;
        b=or0lgXLNnx7gfjQ9RDjSgz82zFhOo0T5WY0XAs2ajg3U/lmGm0M8hLC2l8uPHcpugs
         RQgAD0i6A3M7xAqpQ+cmm83+zsdoUsgTiiMJZK33xR2nBuEGLgUd4vGYDveua205xkqj
         Y6u+KSiIVAkojbsKCQHy1X0oi1UctB5+JGh7ZWzJMU3VYfVznbOjyMhoA9F5xONSo97o
         L0jDIjguTxxkPc35Znth0wGEFfZk3yKf0pCphI9SFQAgGsMYvSanN42VXkvM8xDN+mha
         lzcDB71Aptu6qtLmZCUBze2Pd4hQv05K6CjQf/rXPe8II9jZ4nSsCdnUDzSpjDyrQhAY
         bLcw==
X-Forwarded-Encrypted: i=1; AJvYcCXHWbgalS+AtZ36MCupGe3Un6zktQ8hjtmEEpSchSMxeViJ8cIrpt0FYPLhZVu8cuxAXByl/9kmksZ4HU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6sdjLXX97B94FjM20GaakMsNoW/Kg4H+FEwkJrWZxJqmb4hc
	N3kgAgcIUd2/3+DHGDqGsIS69mnUmgj0HH5SejSLYxFuS8gwN/KtI+X65DRux06UBYClzjV7iRp
	gO7ZYQlo4lqt4rHIBArY9Daljdj/i/I/whNownYR1
X-Gm-Gg: ASbGnctWmLIPq0y/IE9thvExYQI+5IrnU9GRh9xJBFGSqzuoDDoAGZps8rSXbRvNYEX
	znSYqAyD/8btUn9t1LdEJ7n+eqyBRbSfMjXQ1QDQ+SZRPDeTE3uJ0wX9zJzqrnOC7qwWHQdt2sv
	GnoPlKfDcTb9K4GWh4XJ3HwFqbDsqJVy7qsETbNPLL6UNWfW3PRhBBpPiIW64mgJvTFPROU44Wt
	g==
X-Google-Smtp-Source: AGHT+IHd9bYNDNAN5ENOSYbR3QqescLdRwV2rs10KxjR/R0bjr3EaIwYCIh2/P1wreAPm2DA7zZ9VtunAr5OldSmhpc=
X-Received: by 2002:a05:622a:8e0a:b0:4a7:ff6d:e956 with SMTP id
 d75a77b69052e-4a9ec7d20b7mr1710771cf.3.1752126592089; Wed, 09 Jul 2025
 22:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-7-surenb@google.com>
 <0e0312c9-9a89-4a1b-a135-4425ea95d6f6@suse.cz>
In-Reply-To: <0e0312c9-9a89-4a1b-a135-4425ea95d6f6@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 22:49:40 -0700
X-Gm-Features: Ac12FXxTrq12WEb497yNoTrLUG113kauaA6N6gifPoRES-xwIKd4uwt6gAWXY3I
Message-ID: <CAJuCfpG+rzpEqDYAOr+CH-4remxJzuGKEH-=zpf_bWcah-1atw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 10:37=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/4/25 08:07, Suren Baghdasaryan wrote:
> > Back in 2.6 era, last_addr used to be stored in seq_file->version
> > variable, which was unsigned long. As a result, sentinels to represent
> > gate vma and end of all vmas used unsigned values. In more recent
> > kernels we don't used seq_file->version anymore and therefore conversio=
n
> > from loff_t into unsigned type is not needed. Similarly, sentinel value=
s
> > don't need to be unsigned. Remove type conversion for set_file position
> > and change sentinel values to signed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some stuff in the code gave me a pause but it's out of scope here so just=
 in
> case someone wants to do some extra churn...
>
> > ---
> >  fs/proc/task_mmu.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 751479eb128f..b8bc06d05a72 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct p=
roc_maps_private *priv,
> >       if (vma) {
> >               *ppos =3D vma->vm_start;
> >       } else {
> > -             *ppos =3D -2UL;
> > +             *ppos =3D -2;
> >               vma =3D get_gate_vma(priv->mm);
> >       }
> >
> > @@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct=
 proc_maps_private *priv,
> >  static void *m_start(struct seq_file *m, loff_t *ppos)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > -     unsigned long last_addr =3D *ppos;
> > +     loff_t last_addr =3D *ppos;
> >       struct mm_struct *mm;
> >
> >       /* See m_next(). Zero at the start or after lseek. */
> > -     if (last_addr =3D=3D -1UL)
> > +     if (last_addr =3D=3D -1)
> >               return NULL;
> >
> >       priv->task =3D get_proc_task(priv->inode);
> > @@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >               return ERR_PTR(-EINTR);
> >       }
> >
> > -     vma_iter_init(&priv->iter, mm, last_addr);
> > +     vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
>
> I wonder if this should rather be done only after dealing with the -2 cas=
e
> below. It seems wrong to init the iterator with a bogus address. What if =
it
> acquires some sanity checks?
>
> >       hold_task_mempolicy(priv);
>
> It seems suboptimal to do that mempolicy refcount dance for numa_maps sak=
e
> even if we're reading a different /proc file... maybe priv could have a f=
lag
> to determine?
>
> > -     if (last_addr =3D=3D -2UL)
> > +     if (last_addr =3D=3D -2)
> >               return get_gate_vma(mm);
>
> I think only after the above it makes sense to init the iterator?

Yes makes sense but let me do that outside of this patchset as it's
rather unrelated.

>
> >       return proc_get_vma(priv, ppos);
> > @@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> > -     if (*ppos =3D=3D -2UL) {
> > -             *ppos =3D -1UL;
> > +     if (*ppos =3D=3D -2) {
> > +             *ppos =3D -1;
> >               return NULL;
> >       }
> >       return proc_get_vma(m->private, ppos);
>

