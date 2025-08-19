Return-Path: <linux-kernel+bounces-776658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D3B2CFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E557528777
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E826B742;
	Tue, 19 Aug 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0zVq2yM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473D26D4ED
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646211; cv=none; b=D+5nB41Ohb4RWCxD48amJlcOqOzmJtoG37O044M9jSAR5hg3V1pAeRxfMKv7Uy1qTRZSdsvpUENsfXTpJoVzZXtICnG5XcoeVkOqPanMYxADbRexyPftSHv9HsGPOJtFR/cB+ezv2FX/QNGd+2Jjxp8lkL6t9NuHR3LwIsQRYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646211; c=relaxed/simple;
	bh=T1LqzBlcLp9kptALUqFl2aawvfOQaU+3IZAVKCAImrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juI487dBL4weq6fVqNX5G8Mca0hiZ+oS3mcBEGNgA0qoHQv2PzB3I+nveAE2VFqDdirQM39Ke/Y4kxN6NQ/vsZlOnzyDl19OGMYAjg1ipLDWrSC9klXBkJX1Jjq2FFlYz9M7DDi2nyMNvJRyFo8C5G2C8IzV0qheNb2W/3LQNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0zVq2yM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755646207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6l7bsSQ0BliIQaMwP9pOHR40vDGVY0S/bR0OOrmxBGQ=;
	b=N0zVq2yM6+cA8cgbS4QqWR/g1nDiWQkJO1ZpWwbUG5w5WI/IgfrTL7gKBFlch0m8nHgz2f
	DZB3TjYN5xvXFYEYV8fjapJda9jKhP5KQR2bP2gjoupvJBPhhiKL1aQYU5zoyjLdOP41Pd
	ZXz8Nl5JIrVsLOQyt3eEN6ykUc9rzF8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SFdkwis9MP6ieShGc7-IrA-1; Tue, 19 Aug 2025 19:30:06 -0400
X-MC-Unique: SFdkwis9MP6ieShGc7-IrA-1
X-Mimecast-MFC-AGG-ID: SFdkwis9MP6ieShGc7-IrA_1755646206
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71fb2ff16f0so4577157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646206; x=1756251006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l7bsSQ0BliIQaMwP9pOHR40vDGVY0S/bR0OOrmxBGQ=;
        b=O73OaAsKHOq6lalh0yGjr4EbD/qQDRCS8eG3RBCEoXPhDV1YKRhJ8BQ104pm/AQkzv
         ksevo0HaK+TOX//yvOiFTzmIkUo+GSo1XT1PmksAiNbQEwkrdSiNkqcvbJZPVDXrBZ6E
         b6d/X04msymdlL8SxjrrBIH/uxC9mSMeKu8FBCxojn6i0mQQWp8nKYQf+zsDWLHuibOX
         hb8uh0RcNqwaL8sAU6wuaQK7dafYfqq9kKRX7wvsFi616DjowS7nMHxWFXVu73N+MS50
         bKgGpJKGgz2kF7JQQDuwK2wuxbxWRp1ypXvHVVo0fYJgnuTzUWLpmKUAYAoSIQlgdBPq
         Tgkg==
X-Gm-Message-State: AOJu0YxOiqeKfQPdbqTeyqY5AUsCH8myoC7jUigyjXvAAVV4Yc+i6WRh
	zo6IfboazwmBw/eZ9fCijiuxl/ZgEVSdLI6uWT0OF1EouW+zXsLNvOQG9BOSAh+HKwrsOsBVZxD
	py841R9wtBRbIAGyOwf2gnwI6XFpSA4GYX6P8EMD3J2pn7QdGeGe2+snShPpmsNeMew==
X-Gm-Gg: ASbGncue1fIXNqdTmZQruGWAvmcrXHvDXFuM0ctsjMsX8PxOFrr9OY17qG98mzwgs+/
	kDkyaukxtGvYB12swpyShT9NmLsFnPjwUONNrZj4HRqeiABdd6ir2PILq/AET+I0aIMs7m9rfUk
	f8hGvxyAkP402IJPMZKfrFWNoAzG1UUBtd84GOyYyXy1QWu6NW1yYRZOw7w/FJblhv3BmcuVq9u
	yW2hAYo/3Xyn5mOWkHSB6aeFR4s8N9N+VLzWrr2+9itZ2eXVOctWzQC+HXoEk2/1C/YYJlQrOag
	F2VtSXTtNO/O8SN9Xv+rJqKD4vqeOYDL
X-Received: by 2002:a05:690c:530b:20b0:71f:b6d2:f8f4 with SMTP id 00721157ae682-71fb6d3329amr2485627b3.14.1755646205887;
        Tue, 19 Aug 2025 16:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl9293d+FISc1yxakNti5mv3ASEASIx7qEYClFMjnZRgjukMGzSQBzWwKmNvCobMsxsSrvGQ==
X-Received: by 2002:a05:690c:530b:20b0:71f:b6d2:f8f4 with SMTP id 00721157ae682-71fb6d3329amr2485287b3.14.1755646205410;
        Tue, 19 Aug 2025 16:30:05 -0700 (PDT)
Received: from x1.local ([174.89.135.121])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e88c3867esm17654797b3.62.2025.08.19.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:30:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 19:29:52 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com,
	stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [PATCH v1] mm/mremap: fix WARN with uffd that has remap events
 disabled
Message-ID: <aKUI8H2g7SXBX1PR@x1.local>
References: <20250818175358.1184757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818175358.1184757-1-david@redhat.com>

On Mon, Aug 18, 2025 at 07:53:58PM +0200, David Hildenbrand wrote:
> Registering userfaultd on a VMA that spans at least one PMD and then
> mremap()'ing that VMA can trigger a WARN when recovering from a failed
> page table move due to a page table allocation error.
> 
> The code ends up doing the right thing (recurse, avoiding moving actual
> page tables), but triggering that WARN is unpleasant:
> 
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
> WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_page_tables+0x3832/0x44a0 mm/mremap.c:852
> Modules linked in:
> CPU: 2 UID: 0 PID: 6133 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
> RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
> RIP: 0010:move_page_tables+0x3832/0x44a0 mm/mremap.c:852
> Code: ...
> RSP: 0018:ffffc900037a76d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000032930007 RCX: ffffffff820c6645
> RDX: ffff88802e56a440 RSI: ffffffff820c7201 RDI: 0000000000000007
> RBP: ffff888037728fc0 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000032930007 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffc900037a79a8 R14: 0000000000000001 R15: dffffc0000000000
> FS:  000055556316a500(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30863fff CR3: 0000000050171000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
>  move_vma+0x548/0x1780 mm/mremap.c:1282
>  mremap_to+0x1b7/0x450 mm/mremap.c:1406
>  do_mremap+0xfad/0x1f80 mm/mremap.c:1921
>  __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f00d0b8ebe9
> Code: ...
> RSP: 002b:00007ffe5ea5ee98 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00007f00d0db5fa0 RCX: 00007f00d0b8ebe9
> RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
> RBP: 00007ffe5ea5eef0 R08: 0000200000c00000 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
>  </TASK>
> 
> The underlying issue is that we recurse during the original page table
> move, but not during the recovery move.
> 
> Fix it by checking for both VMAs and performing the check before the
> pmd_none() sanity check.
> 
> Add a new helper where we perform+document that check for the PMD and
> PUD level.
> 
> Thanks to Harry for bisecting.
> 
> Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/689bb893.050a0220.7f033.013a.GAE@google.com
> Fixes: 0cef0bb836e ("mm: clear uffd-wp PTE/PMD state on mremap()")
> Cc: <stable@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


