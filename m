Return-Path: <linux-kernel+bounces-810967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E3BB52279
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95DA1C859EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6293009C2;
	Wed, 10 Sep 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+/QzR1i"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8112FABF8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536904; cv=none; b=cuNaxPuH0lJloJYBjlp5rYCPIVqA/c6lfs0p9Eh8ICm81oeJwZHX3BewoMxp0hQahyddnevSSI9aLdgrvq8kr+6ndbN28/vt2Dp7cywYp4bGAfXhGYMWGPTdkVYDJGUd41uIO7C7Ibzv25alo9tbHX810B9+9FtPoHzNytmVt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536904; c=relaxed/simple;
	bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNfrbo4FVIzpPEPQWCy5ydi8+NMb70NOeHUV22HkmKJy6dNX3p4LmNogFTy3c23mxSBig4U6wbVMP0AEMXA3Ur2fSVOzTKBFiKO0e70olzD82567rmZSq3vxaf1YvWVFMs82Za+/wCF/0iEAyEMvjgE6H4fCmkkQZvI839449k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+/QzR1i; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b4bcb9638aso164201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757536901; x=1758141701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
        b=1+/QzR1iaWF1dZpLSinswu8+5BlDV1Mz44JFxDO18vHd0RaIQhC3n+SdmvEVh4JsSG
         7WqhZHQc44AMTp8fTjoyumK3MFSM09ryotKdXCFjaxOm9DCjczMn2Rg2MLZ4S+TLkefO
         1laskm4ZO/uK9bn7GcAN6MzXGfr810Lg6U6B4LIEbsKV7GRXdhlUF8Uu3HZS+TWpfXiW
         99IvmkujIZvj3LQTlfNrh1WQq0Qp1Mz+jmnGO4J7lhHj0a7/Hr0Cx+Jbzt/b67aAlZlM
         rakEYBlP0b7WJwgq8gfQwrjpTzQ293HDsPskTqz1pkgpoi8rWSUVaG1KfC0BogKSisl5
         nm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536901; x=1758141701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
        b=gGPFykpaNmod3IxbHD0vclWRMMdlMPijF/QJ7eCzv61qOKnVJGr1GzhzKTxn6+Fqpn
         Jr1tmo/4TpvecRKXcjHXJ04YOzr1HKAZsUs6l1KMxvA5bhi32RZTcouYs7H/1VTdH6mI
         M03x+3/a2Sb+CJ1mekNg+5GVyltLWkaj+aEw3gyimn8zPrIWTwn39EPX3SvDEiWydhxM
         3W2Hy/UATiLmbrlehFxki2EGWVPHISHH7ApkU/tEQgnr07KNOakq7LxY7z/z/+2j3ddV
         3DyEQ+DW02qX4zvZeq6k8KOG8UK2/u3PpphJTJsSSjdCTRDI+ah4iHWhtMo7NvAGkZKZ
         6zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCLcMAL7QmFv0bflNWpypqkEU4HHUEq2X4vRuDA4GQHhS/qd2WVTgm3MaJ6FnWVoyZrs4oEQMRkZ/Yts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZ6lAZf9IY8cd5CoAa1PgczA1T8R078E73tgOKdx/AEATAi/z
	cdaL3hT1Ka5dg1vCxzSgrOQtZ41Nvx/L9E9MWBI3iRYy7cDEUoBLnlXu1EPTm4oEaw3YpMX2MnP
	AnXMFYiAyB7HG+8cSTQleXE7Ho7yl7JGFAusSYvHl
X-Gm-Gg: ASbGncuaG9wTHPX4MistoStqkX1jGn7RhibTnmKkQtm1l87rqD/TEJXcJwOs4PBXl+k
	FjDGlpATZUOGifEJGIrACms0TbTXmBuwEGWY7+0lTXciqbRahW9iVOeKNlDVUWUVXNKCj/UtDZi
	NEygs2syjkNtRkB1d97ev80OAlVVw9R9TI8+z+X9L8Oxu0wi3nz9qHi5Tb6gvUwgVZlWIzygRXa
	6ndFI5bZm/jgufD08KA9p94Uxal9sb2o8xB/1kdrGvbBZWW5SDkfw==
X-Google-Smtp-Source: AGHT+IHbQlhskzm2umaiSCVK7F4asqf8KLiAUVgJOpxaNfiXFJRF7QoxeR9wlR3GvPVF+MNtKa/jSV5VrLPSsQR7N2s=
X-Received: by 2002:a05:622a:311:b0:4b0:85b7:ea77 with SMTP id
 d75a77b69052e-4b626dac8a6mr7249681cf.3.1757536900773; Wed, 10 Sep 2025
 13:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com> <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
In-Reply-To: <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Sep 2025 13:41:29 -0700
X-Gm-Features: AS18NWANf9zf8-wwlTuHfifwdfaJCLJSeFkghtgQl5BDc45w4ZtnmTyIc9pxfNM
Message-ID: <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > 1. Problem Scenario
> > > > On systems with ZRAM and swap enabled, simultaneous process exits c=
reate
> > > > contention. The primary bottleneck occurs during swap entry release
> > > > operations, causing exiting processes to monopolize CPU resources. =
This
> > > > leads to scheduling delays for high-priority processes.
> > > >
> > > > 2. Android Use Case
> > > > During camera launch, LMKD terminates background processes to free =
memory.
> > >
> > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> >
> > SIGKILL
> >
> > >
> > > > Exiting processes compete for CPU cycles, delaying the camera previ=
ew
> > > > thread and causing visible stuttering - directly impacting user
> > > > experience.
> > >
> > > Since the exit/kill is due to low memory situation, punting the memor=
y
> > > freeing to a low priority async mechanism will help in improving user
> > > experience. Most probably the application (camera preview here) will =
get
> > > into global reclaim and will compete for CPU with the async memory
> > > freeing.
> > >
> > > What we really need is faster memory freeing and we should explore al=
l
> > > possible ways. As others suggested fix/improve the bottleneck in the
> > > memory freeing path. In addition I think we should explore paralleliz=
ing
> > > this as well.
> > >
> > > On Android, I suppose most of the memory is associated with single or
> > > small set of processes and parallelizing memory freeing would be
> > > challenging. BTW is LMKD using process_mrelease() to release the kill=
ed
> > > process memory?
> >
> > Yes, LMKD has a reaper thread which wakes up and calls
> > process_mrelease() after the main LMKD thread issued SIGKILL.
> >
>
> Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
> that still the plan? I am actually looking into cgroup.kill, beside
> sending SIGKILL, putting the processes of the target cgroup in the oom
> reaper list. In addition, making oom reaper able to reap processes in
> parallel. I am hoping that functionality to be useful to Android as
> well.

Yes, cgroups v2 with per-app hierarchy is already enabled on Android
as of about a year or so ago. The first usecase was the freezer. TJ
(CC'ing him here) also changed how ActivityManager Service (AMS) kills
process groups to use cgroup.kill (think when you force-stop an app
that's what will happen). LMKD has not been changed to use cgroup.kill
but that might be worth doing now. TJ, WDYT?


> > >

