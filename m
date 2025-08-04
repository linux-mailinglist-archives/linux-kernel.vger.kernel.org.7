Return-Path: <linux-kernel+bounces-754978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3161B19F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640DD3AE599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F87253B47;
	Mon,  4 Aug 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIxIkd76"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD26246335
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301865; cv=none; b=sAm7jUOGjSnruJif6/WhQkMgoroQYHp9sXSQo7keOpR7vtkpn+3T60FoE80l2tJpmIZCUEHwLE2Uiq+gAfYj2CuBnVnutqo8iU05WxBeW1roiqkvPL8SscXKIqggD0bbFLxh4VhxGXgR4kQNZHTU2rtyoxkLNOvQmWfvndQUfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301865; c=relaxed/simple;
	bh=dsRRmKuthzAb3bMwGKmf5dKyrP0OU1MEbC1aHSekab0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeK9Qtke2T/3gvM+3gdvCyxdzMjyM3ZiMo/HdY4r0MovP3sU+nNojoQH2SL6GNBpSSC38I31flf6MLuE5ou03CaL82w6zXLxC1bPvDOVW0mnHqP45//aJoy+fac15u4kVJGDA5EuIo9IkKmSnoEmwLMMjTmWjiA+fRyavkp7hJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIxIkd76; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4fc05b4a25eso2799977137.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754301862; x=1754906662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRWJTy+mLBKBSxbyP1TehFPLIqhhGVs/w1u/dbI4iZQ=;
        b=UIxIkd76+4EFMq/czKBLzI1deTcpzxOwMJnoYCeRaypGNWWxcsnIvtHlVWzzz81H2a
         Rl2lZcBYeWxM4XBX0up94mDc+vNHorJdebBcp/jsrHoswPHQGO8qZPqz+jPmJ7pw6/DK
         xu2j3qstgwj8jgxQ0ZN4kx0cSbY1la4p+0Y3HQQXVws65ZO7nqFSroc7/zVnMpZoZoqO
         4kF5f2lEy3A0u2ghDakhceMfRbip/zN8kDw2iE5/JKMghJHeHpAc07RAQVvOrMgWBsKY
         VayZdlprEBPmTl0qfhUIPDXubsBmN1FNJaNEGdXQbtCKNFWpAPM+xiVZ6bQ3HWft0vSB
         gPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754301862; x=1754906662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRWJTy+mLBKBSxbyP1TehFPLIqhhGVs/w1u/dbI4iZQ=;
        b=S3FmYZmSDBejb01pN/XgtV84WYuh/5LlDvTFDJDb4KXODA93C8vGHtEH5QIyumceLL
         RrALBX3FE5z+/DQuMrp0DGXd7YDWsE7VkA+7ZqNsPeOHPEePifQVOHM7s/ZkLtX9qcv/
         BGO91alDF/D9HdYBs3g1Z//f4iToNUg6z1QT1r7SDBcp1gWOeSSw42dntrVMW3HF7sEd
         7zYGnenVWB+y1XLCNzu6CS75O00jScy2Y4gDQwXf5Gpch57CHu2rHjsfls3QtZ5s3bJF
         kBHH4ThoRgeJsQ7zWcGMR/Yapqgq+Ne1ADBv+hMaVB78BXKGOqwDADa8m02YWXp1KmZg
         0gAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI/qT/mto9cVIaCSNf8QS0bYW29JyKWbKzMUMvczwQ1xcLcfKMUhroYFQewZ9aJhTPZP84kyX57GIysys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAAdnJC2sof4zpd124SivdddRstHLjvPtGTPicv7xuU7s0FLI
	CUvA8xA42kDgoFs0pUe1zJGvywkvb9uJEYS2Dtmde9oSUwP7vHjQR6TsUEex4X65McNI4DDLcxC
	NGFLlcqEmw6aJV8jduNVgfBIuMlVJ/IY=
X-Gm-Gg: ASbGncsanmbxojvKJRYI7UYVa7wdYxUjASYFle/gzUI34bQBSB3qF2sbg08vzr8bGZ6
	2/HN13mbM3yW2R8HPwKsXwiE8w65d8aSFy/+dTqvafeJhuboKTEtKuAOw57vVBHH8TIweXNTZ1P
	wdQRXPS4hNupwWZ5vLUQmBA4Jy74NjdBX7KYqe7XBKjyQ7bs95rwHx77xS5MAL5ZMIHdDzCvZIw
	CyzkCfu9CfFs8t5yg==
X-Google-Smtp-Source: AGHT+IGlyAM97ITpXb+I4johYOiMqVNP/L/7mRsJVUyDhylX/Qc4TcOFu2s16cKEM7TqfM8PRN+irC2YyyNEyde29l8=
X-Received: by 2002:a05:6102:6894:b0:4e9:8f71:bd4f with SMTP id
 ada2fe7eead31-4fdc1b4fc32mr3381516137.3.1754301862193; Mon, 04 Aug 2025
 03:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607220150.2980-1-21cnbao@gmail.com> <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com> <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
 <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com> <aJB0Kdc6cx1lGkdb@ly-workstation>
 <CAGsJ_4yw4Qn7OWmUJeJZYuOHLjJ7L8kov3Th3vFPa3h4y0ur_A@mail.gmail.com>
 <7d92ec18-ff8e-4929-8b9a-f0bf5c6d249f@bytedance.com> <ca86203d-89b5-4282-b318-2ac82fd2121f@bytedance.com>
In-Reply-To: <ca86203d-89b5-4282-b318-2ac82fd2121f@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 22:04:11 +1200
X-Gm-Features: Ac12FXwcnY8-s17fkhP2BhhtZchoFsWJziPluE5wP1XYtcDSgD7prKLao16EDn0
Message-ID: <CAGsJ_4wWUcLf79NqkQ9C+2mO684AP6HvmgispSZ0Lh3wt330Eg@mail.gmail.com>
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, yi1.lai@intel.com, 
	"Lai, Yi" <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:54=E2=80=AFPM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
[...]
> >>>>
> >>> My kernel compiling steps:
> >>> 1. copy kconfig_origin to kernel_source_folder/.config
> >>> 2. make olddefconfig
> >>> 3. make bzImage -jx
> >>>
> >>> I have also uploaded the actual .config during compiling.
> >>> [2] https://github.com/laifryiee/syzkaller_logs/blob/
> >>> main/250803_193026___pte_offset_map_lock/.config
> >>> CONFIG_ARCH_SUPPORTS_PT_RECLAIM=3Dy
> >>> CONFIG_PT_RECLAIM=3Dy
> >>
> >> Thanks! I can reproduce the issue within one second.
> >
> > I also reproduced it locally.
>
> Hi Barry, can you reproduce this problem stably? I can't reproduce it
> again after reproducing it once. :(
>

Yes, the issue reliably reproduces within a short time after every reboot.

[root@test ~]# ./repro
[   18.189594] loop0: detected capacity change from 0 to 65536
[   18.339652] loop0: detected capacity change from 0 to 65536
[   18.488875] loop0: detected capacity change from 0 to 65536
[   18.658206] loop0: detected capacity change from 0 to 65536
[   18.793696] loop0: detected capacity change from 0 to 65536
[   18.796660] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
[   18.797417] KASAN: null-ptr-deref in range
[0x0000000000000018-0x000000000000001f]
[   18.797926] CPU: 0 UID: 0 PID: 635 Comm: repro Not tainted
6.16.0-next-20250801-kvm+ #3 PREEMPT(voluntary)
[   18.798568] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   18.799324] RIP: 0010:kasan_byte_accessible+0x15/0x30
[   18.799685] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03
48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 0
[   18.800906] RSP: 0018:ffff8880136df678 EFLAGS: 00010286
[   18.801265] RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 1ffffffff0d=
de60c
[   18.801742] RDX: 0000000000000000 RSI: ffffffff85da2e18 RDI: dffffc00000=
00003
[   18.802224] RBP: ffff8880136df698 R08: 0000000000000001 R09: 00000000000=
00000
[   18.802702] R10: 0000000000000000 R11: ffff8880123558d8 R12: 00000000000=
00018
[   18.803181] R13: 0000000000000018 R14: ffffffff85da2e18 R15: 00000000000=
00000
[   18.803659] FS:  0000000000000000(0000) GS:ffff8880e3b40000(0000)
knlGS:0000000000000000
[   18.804199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.804588] CR2: 00007f52bf71ffc0 CR3: 00000000119eb000 CR4: 00000000007=
50ef0
[   18.805066] PKRU: 55555554
[   18.805260] Call Trace:

Thanks
Barry

