Return-Path: <linux-kernel+bounces-639160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26330AAF396
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D72C3AB2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1709F20FAAB;
	Thu,  8 May 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHRfue4m"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817951D8A0A
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685134; cv=none; b=bekgnQtSbtLM90wdBe6nNjpvxXOBOM4/KNDmIMSaBCHmKJGl4/HWhOAxt4zmkm4h6+bGWpkdwGIeZx8g4myMpDzJzUDI1xgyQTK5qaJmxHYaM+PzCQzS+Kzh6zFVuvpWX65pN4QEE1HWpJRMacB+cyZCOkw0tmZ9WLiItDQ8P74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685134; c=relaxed/simple;
	bh=1B0Wwx2yMJUJzETEu6+qGlTj5ZhKYretOxfEIg10rc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSBOs2ZFhTaNkxgZd6FzPXnxRzuSx9125U1xNbudK2/4OJqySYNbFSuzdT0hjQx0r2GQooLxa6Jz1rEBmkxlEMsq7YogkALSqXFZRMlHaEt7iGyAI21G5r6QWv9P5PlTD4ehqBfGQaE4ovARiIGpxpxUCjbAM+mwksJiua9c9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHRfue4m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30abb2d5663so648366a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746685131; x=1747289931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnXX9/gWqGflBTi47okDnJ7YfQszH1NtWXK/5xCPxaw=;
        b=EHRfue4m7Nrm7PCASpQho8csJccKKNcE0j/JbuIskff45G+qORMrqc+Sjpdfr73COr
         JjXJxD9tcsTooEfvyh0fWdG+w7zS4byAPRBuNjKP4GgQW1k04qQIDfix+SPINgopqxgP
         bI0hNVXK2hbEYFoIVY8bsPa8jsKPnIYp20uBTMv+7CgyxAuFNem8htvznWozzcWBZSQy
         SHJEQQBhzoTYWcKgt0EV8WftwC6jugmwfVL8PsyMccKS4KejwJ/SlPARxyN3GqZDxn14
         KKUdW8VhpUf0uvmeg2gIobFjs1nniyoQt44xi3C8RK2MP54L9LhOg9DFMQ/3lRRWKqEh
         qF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685131; x=1747289931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnXX9/gWqGflBTi47okDnJ7YfQszH1NtWXK/5xCPxaw=;
        b=A8UW5Na4wlsId6wFdyva5Z7IoBmsZAZJh1mjM561G/lzyYtRGgDk8YPeN9x9CO10L5
         VIGeV/7k17f8ubPLMMf6JKllJfQ10O5rrh+T7fJbeVFRDRuyej6EOUbOBiI1xPN2GTig
         UikZRl7Enirckr2dXuO0dcsfjs7VddVEU0gmXPkDnYueM9X4mrNjjjwdnSmcqPSR/Tzv
         sKgPH4Cz1JVwB7EDOaPRSvVITInyWgoaYxWhsDTfZCSD5wuchvOGyBUH5UxzW3hkCC9j
         UifaXQJdsaOmjH+8Y0pwsddXsKYuJ9fvAC4ZLAzvptd3FrllqK+mEUyTFsUqiq5HaO8A
         PnTw==
X-Forwarded-Encrypted: i=1; AJvYcCVfArb/jENVgpvI624lWBeGyvQrQLGlUcYr09YLHEtbaqHH0G4440o/O/tnepLLOWUmoXcpo0fQEO0fhH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBExWNacatMz533/qbXWQXH8Pb6U2bj1Tn55EiG0ayU2Jo/LXV
	yFqEeba2lchDL8QFCmDu64Gj52l7hLx4IUzO4T2tsN01sq3gPqFahRMXfRxTGjZKNEy8b7g+D5V
	X7s3tsUeb3Oa6cJJvMk9qvZboMuU=
X-Gm-Gg: ASbGncu/I9USJ6ALwTdTQv8N34MJuZM+M797UP/5Kw2flK+/PornjASYDclEQYsO7Nr
	z8QSkZ+aayEoIC+V49xMBjZCdvvyFtgbuM3E+Ahw5gu6JTm5q4jLs9tdGVD8uqFkd81Ma/pkxVI
	3/lDhk/4U598dvvXVuMlC+Tg==
X-Google-Smtp-Source: AGHT+IERyV23+ZJV3y67CEcKtPEA6LouYSlmL2EklZcF0P5oY7V8rBAWnMiCp0MB9owXZb2Tgh6z6yWtuAcUX3v8KSM=
X-Received: by 2002:a17:90b:3b85:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-30aac2b3d1amr10049219a91.33.1746685131531; Wed, 07 May 2025
 23:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507142552.9446-1-aha310510@gmail.com> <01100196acf1ede5-ae116361-04f2-4e8f-b7a4-7079d6158ffb-000000@eu-north-1.amazonses.com>
 <CAO9qdTFupkXAzR0=AabByZPZZJbQzpKMbt5pzv5o8b5r6Ha2tg@mail.gmail.com>
In-Reply-To: <CAO9qdTFupkXAzR0=AabByZPZZJbQzpKMbt5pzv5o8b5r6Ha2tg@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 8 May 2025 15:18:39 +0900
X-Gm-Features: ATxdqUHvSlkXI4Pq_-2LiiwIfvxZUNRefF1nJdTqgZxULCl5pafx55pOUZ5retQ
Message-ID: <CAO9qdTHB+kaPX7u3hDQUz1q805nmhtfRUWguZEWX=hcfcU1Uow@mail.gmail.com>
Subject: Re: [PATCH v3] mm/vmalloc: fix data race in show_numa_info()
To: Ozgur Kara <ozgur@goosey.org>
Cc: akpm@linux-foundation.org, urezki@gmail.com, edumazet@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeongjun Park <aha310510@gmail.com> wrote:
>
> Ozgur Kara <ozgur@goosey.org> wrote:
> >
> > Jeongjun Park <aha310510@gmail.com>, 7 May 2025 =C3=87ar, 17:32 tarihin=
de =C5=9Funu yazd=C4=B1:
> > >
> > > The following data-race was found in show_numa_info():
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KCSAN: data-race in vmalloc_info_show / vmalloc_info_show
> > >
> > > read to 0xffff88800971fe30 of 4 bytes by task 8289 on cpu 0:
> > >  show_numa_info mm/vmalloc.c:4936 [inline]
> > >  vmalloc_info_show+0x5a8/0x7e0 mm/vmalloc.c:5016
> > >  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
> > >  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> > >  new_sync_read fs/read_write.c:489 [inline]
> > >  vfs_read+0x5b4/0x740 fs/read_write.c:570
> > >  ksys_read+0xbe/0x190 fs/read_write.c:713
> > >  __do_sys_read fs/read_write.c:722 [inline]
> > >  __se_sys_read fs/read_write.c:720 [inline]
> > >  __x64_sys_read+0x41/0x50 fs/read_write.c:720
> > >  x64_sys_call+0x1729/0x1fd0 arch/x86/include/generated/asm/syscalls_6=
4.h:1
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xa6/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > write to 0xffff88800971fe30 of 4 bytes by task 8287 on cpu 1:
> > >  show_numa_info mm/vmalloc.c:4934 [inline]
> > >  vmalloc_info_show+0x38f/0x7e0 mm/vmalloc.c:5016
> > >  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
> > >  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> > >  new_sync_read fs/read_write.c:489 [inline]
> > >  vfs_read+0x5b4/0x740 fs/read_write.c:570
> > >  ksys_read+0xbe/0x190 fs/read_write.c:713
> > >  __do_sys_read fs/read_write.c:722 [inline]
> > >  __se_sys_read fs/read_write.c:720 [inline]
> > >  __x64_sys_read+0x41/0x50 fs/read_write.c:720
> > >  x64_sys_call+0x1729/0x1fd0 arch/x86/include/generated/asm/syscalls_6=
4.h:1
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xa6/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > value changed: 0x0000008f -> 0x00000000
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > According to this report, there is a read/write data-race because m->=
private
> > > is accessible to multiple CPUs. To fix this, instead of allocating th=
e heap
> > > in proc_vmalloc_init() and passing the heap address to m->private,
> > > show_numa_info() should allocate the heap.
> > >
> > > One thing to note is that show_numa_info() is called in a critical se=
ction
> > > of a spinlock, so it must be allocated on the heap with GFP_ATOMIC fl=
ag.
> > >
> > > Fixes: a47a126ad5ea ("vmallocinfo: add NUMA information")
> > > Suggested-by: Eric Dumazet <edumazet@google.com>
> > > Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > > v3: Following Uladzislau Rezki's suggestion, we check v->flags before=
hand
> > >         to avoid printing uninitialized members of vm_struct.
> > > - Link to v2: https://lore.kernel.org/all/20250506082520.84153-1-aha3=
10510@gmail.com/
> > > v2: Refactoring some functions and fix patch as per Eric Dumazet sugg=
estion
> > > - Link to v1: https://lore.kernel.org/all/20250505171948.24410-1-aha3=
10510@gmail.com/
> > > ---
> > >  mm/vmalloc.c | 51 ++++++++++++++++++++++++++------------------------=
-
> > >  1 file changed, 26 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 3ed720a787ec..9139025e20e5 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -4914,28 +4914,32 @@ bool vmalloc_dump_obj(void *object)
> > >  #endif
> > >
> > >  #ifdef CONFIG_PROC_FS
> > > +
> > > +/*
> > > + * Print number of pages allocated on each memory node.
> > > + *
> > > + * This function can only be called if CONFIG_NUMA is enabled
> > > + * and VM_UNINITIALIZED bit in v->flags is disabled.
> > > + */
> > >  static void show_numa_info(struct seq_file *m, struct vm_struct *v)
> > >  {
> > > -       if (IS_ENABLED(CONFIG_NUMA)) {
> > > -               unsigned int nr, *counters =3D m->private;
> > > -               unsigned int step =3D 1U << vm_area_page_order(v);
> > > +       unsigned int nr, *counters;
> > > +       unsigned int step =3D 1U << vm_area_page_order(v);
> > >
> > > -               if (!counters)
> > > -                       return;
> > > +       counters =3D kcalloc(nr_node_ids, sizeof(unsigned int), GFP_A=
TOMIC);
> > > +       if (!counters)
> > > +               return;
> > >
> > > -               if (v->flags & VM_UNINITIALIZED)
> >
> > Hello,
> >
> > although skipping memory blocks with VM_UNINITIALIZED flag seems like
> > a good idea maybe it might be a good idea to check correctness of
> > memory areas.
> >
> > if (v && (v->flags & VM_UNINITIALIZED)) {
> >     continue;
> > }
> >
>
> Thanks for the suggestion! Not related to data-race, but it seems like
> a good idea to add some check code in case null-deref occurs. I'll reflec=
t
> this in the v4 patch.
>
> Regards,
>
> Jeongjun Park
>

Oh, I misread the code. This function already checks if the va->vm
value is null, so there's no need to do this duplicate check.

Regards,

Jeongjun Park

> > > -                       return;
> > > -               /* Pair with smp_wmb() in clear_vm_uninitialized_flag=
() */
> > > -               smp_rmb();
> > > +       /* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
> > > +       smp_rmb();
> > >
> > > -               memset(counters, 0, nr_node_ids * sizeof(unsigned int=
));
> > > +       for (nr =3D 0; nr < v->nr_pages; nr +=3D step)
> > > +               counters[page_to_nid(v->pages[nr])] +=3D step;
> > > +       for_each_node_state(nr, N_HIGH_MEMORY)
> > > +               if (counters[nr])
> > > +                       seq_printf(m, " N%u=3D%u", nr, counters[nr]);
> > >
> > > -               for (nr =3D 0; nr < v->nr_pages; nr +=3D step)
> > > -                       counters[page_to_nid(v->pages[nr])] +=3D step=
;
> > > -               for_each_node_state(nr, N_HIGH_MEMORY)
> > > -                       if (counters[nr])
> > > -                               seq_printf(m, " N%u=3D%u", nr, counte=
rs[nr]);
> > > -       }
> > > +       kfree(counters);
> > >  }
> > >
> > >  static void show_purge_info(struct seq_file *m)
> > > @@ -4979,6 +4983,8 @@ static int vmalloc_info_show(struct seq_file *m=
, void *p)
> > >                         }
> > >
> > >                         v =3D va->vm;
> > > +                       if (v->flags & VM_UNINITIALIZED)
> > > +                               continue;
> > >
> > >                         seq_printf(m, "0x%pK-0x%pK %7ld",
> > >                                 v->addr, v->addr + v->size, v->size);
> > > @@ -5013,7 +5019,9 @@ static int vmalloc_info_show(struct seq_file *m=
, void *p)
> > >                         if (is_vmalloc_addr(v->pages))
> > >                                 seq_puts(m, " vpages");
> > >
> > > -                       show_numa_info(m, v);
> > > +                       if (IS_ENABLED(CONFIG_NUMA))
> > > +                               show_numa_info(m, v);
> > > +
> > >                         seq_putc(m, '\n');
> > >                 }
> > >                 spin_unlock(&vn->busy.lock);
> > > @@ -5028,14 +5036,7 @@ static int vmalloc_info_show(struct seq_file *=
m, void *p)
> > >
> > >  static int __init proc_vmalloc_init(void)
> > >  {
> > > -       void *priv_data =3D NULL;
> > > -
> > > -       if (IS_ENABLED(CONFIG_NUMA))
> > > -               priv_data =3D kmalloc(nr_node_ids * sizeof(unsigned i=
nt), GFP_KERNEL);
> > > -
> > > -       proc_create_single_data("vmallocinfo",
> > > -               0400, NULL, vmalloc_info_show, priv_data);
> > > -
> > > +       proc_create_single("vmallocinfo", 0400, NULL, vmalloc_info_sh=
ow);
> >
> > proc_create_single function clean but it no longer receives data like
> > priv_data right? so if priv_data is needed again code will not work.
> > if use priv_data becomes necessary, a suitable memory allocation and
> > release mechanism should be added for this.
> > otherwise a memory leak could occur and perhaps the use of kfree
> > instead of kmalloc could also be added.
> >
> > proc_create_single_data("vmallocinfo", 0400, NULL, vmalloc_info_show,
> > priv_data);
> >
> > // use kfree and free priv_data
> > kfree(priv_data);
> >
> > Regards
> >
> > Ozgur
> >
> > >         return 0;
> > >  }
> > >  module_init(proc_vmalloc_init);
> > > --
> > >
> > >
> > >

