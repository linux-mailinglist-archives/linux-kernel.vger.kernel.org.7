Return-Path: <linux-kernel+bounces-808921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F69B50691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F42164037
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB9303A3C;
	Tue,  9 Sep 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmcK3rFb"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807F19E7F7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447297; cv=none; b=pC6KTb5K73KG/vzJmBCYzg725uQ+pnvwfFiI6u7I60dD3c8w59ueI7/UVMABEKu9lP1eI3bbcUXBNIt1flWgVL47rGilQmsI9nGJ1b6jyA5Nf2qD3qwSG5y5IN4mWshKZelxNxCiFw60BrUITlj1Q+cXjhoaR33j3FzsO6TLJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447297; c=relaxed/simple;
	bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtdqB7I7eD+51zSJgH4kMB4kFnCuPF45j8N2YYzcFSHbZq5mterfotp0gJXhuGhHuYRS77k2VfBULlS+qwHKXuiQKXjKOvu9tVqMd2JII3xyLziJ/YyqRqtRio0Pwf1JeCrTbzyrKvt5p5UqSUR8d4c/YtJfkNelM4uftIHpLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmcK3rFb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso120061cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757447294; x=1758052094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
        b=EmcK3rFb1eYsPoWc+rnzqR8Upbp64gHyO1G3TDkoRkWIhKNtwRxl6TZhXiNESm4I9k
         Dch+FnmcOsK2gcXcr2UURbuCIJ4O0/1SjP2aN8fYlEVp7OCeTI8f14LefxwacXouX7o7
         xnP4Hw5OPL4xO4iiYHG+6P9ceI8ZnXHeJ1C8eU5CVF1tEUqGXFgBE6L4ePwp1qiM2A8T
         OzqGzPAQQGKnk0rS4HdyvQcBH7zNiolrc0tBeD3y46os+yKXYuVhbZ9L+6sKiOgi16GO
         xUHV6oZs2ks+Bua2Rvgk94r9F+KSQgweOgWYOiHgt5ObWWi6RoXliaWh2qBklasAYYVS
         9qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447294; x=1758052094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
        b=mvUe3c40KQFP5QRi/cq43LjZwYchUieEWckh5IOoc7tlFrK/QhB8IBl/HHuBG30Z4Y
         kSB4kbxWGwyjYCfvz47wXiuTLp29wQQnMmhoTKqWTrD+3gk4LR4OccT9hRdQsZNltVM1
         q4B4leKKdq2E6yTM+hSQqemBcwq3EccMhQF5gkHrqBJN+oBShF8pgbZ1Edyo7oFshqzH
         IySwtlmwJUdFk3CDHaq8G18Xghvz2CWuRIPtQKSJq4LEIDr3fwKltRmImbJzIRUeVzEl
         lLUU4J5P9F8cajzmf1ZRXidHZlbBU4nSsj6psLWqWZkk50RSLOU7OfKBh3aHhqgcUrTm
         CF6g==
X-Forwarded-Encrypted: i=1; AJvYcCUbE+Hmr4tq/nxwvBTfL+eRqhKTp1WUHqssSOhk/pq5Ru7t2q7JBYgUoOupQ3Z81aK1R7CZkljRZLVoYgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCqxCo1hlkvVLJxgDkaBDD/jQAVez5kxG1LVHGMji8gCnaSUd
	SS7bHpDvzYBEBAtIdNzdjR93ddsYXitptFvaWjt7WkAHhfGioLGU3aLnQIhAy7MdoN+8H+8dWog
	fxKfYPRLkPmArQIlY8xOsxmoi2a8w+cIn59iT7m2Y
X-Gm-Gg: ASbGncspaRjd2QfENsn/fFLw0ztmgGQnNwGNVEgIo4MTrSF3zSo9Rnw9Vz8eclOY7ov
	S8btZ2ZPX8Ii4BmcBgIevPaoHH/Tg/JP8wOhpEzRgaS/pAGm2pTY6vhZoHIQtblDue8r58Yc7qc
	N1ybOFDbi2xpblamCnoGCsWUVcZPubtqEB9xw6KpXP5mM2NG/QwyQpoFIZHKMl52eI9IyabhB9K
	Wp648BMqBOQpBzuXLHum9ZpfvDfawsSi4GIVjsk9zPq
X-Google-Smtp-Source: AGHT+IEpsuLg57KeWm89BZgtIm9RkiFt9/IvL1pt8dPdyEbMc9G1YFKO2IdV8XoDjVFZgzs9MuDgCYFK40OVoWDMZKk=
X-Received: by 2002:a05:622a:55:b0:4b1:22f0:8016 with SMTP id
 d75a77b69052e-4b625170bbbmr869751cf.2.1757447293887; Tue, 09 Sep 2025
 12:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
In-Reply-To: <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 12:48:02 -0700
X-Gm-Features: AS18NWCnZI1Tq2lGwilQ5dvnko06eauIx4vwc90RQw36tzlJKEe_P08UvcGzo3g
Message-ID: <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
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
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > 1. Problem Scenario
> > On systems with ZRAM and swap enabled, simultaneous process exits creat=
e
> > contention. The primary bottleneck occurs during swap entry release
> > operations, causing exiting processes to monopolize CPU resources. This
> > leads to scheduling delays for high-priority processes.
> >
> > 2. Android Use Case
> > During camera launch, LMKD terminates background processes to free memo=
ry.
>
> How does LMKD trigger the kills? SIGKILL or cgroup.kill?

SIGKILL

>
> > Exiting processes compete for CPU cycles, delaying the camera preview
> > thread and causing visible stuttering - directly impacting user
> > experience.
>
> Since the exit/kill is due to low memory situation, punting the memory
> freeing to a low priority async mechanism will help in improving user
> experience. Most probably the application (camera preview here) will get
> into global reclaim and will compete for CPU with the async memory
> freeing.
>
> What we really need is faster memory freeing and we should explore all
> possible ways. As others suggested fix/improve the bottleneck in the
> memory freeing path. In addition I think we should explore parallelizing
> this as well.
>
> On Android, I suppose most of the memory is associated with single or
> small set of processes and parallelizing memory freeing would be
> challenging. BTW is LMKD using process_mrelease() to release the killed
> process memory?

Yes, LMKD has a reaper thread which wakes up and calls
process_mrelease() after the main LMKD thread issued SIGKILL.

>

