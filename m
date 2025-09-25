Return-Path: <linux-kernel+bounces-833089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA6BA12FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5068819C1C14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397A21CC47;
	Thu, 25 Sep 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv7UQ9+x"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D229B16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828616; cv=none; b=Yc2/m0qdKp0Nqp+nOo0BdB/8ENQVSkxnhux7oUXcEpisDqwa6J0WrETzZXycFkbpqYY+lA4BCfRMm7zlwxfSJAvEQTQ7/+0Bj7tVMcBo1XOTb/1IvqenDbcG3VWiec9ENK6Ow3hO26v/K6Y47hKPCVuBl5Tub9ugSrwcOuydMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828616; c=relaxed/simple;
	bh=gy+R3VGobtBUpYgceZYiKCPbWMGXanmmt1+K1Hdh5BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXgVR75YuIGRgLIqlOfCBiAq8LiJO7yz0aoDuW3dQc0RUVnBz22QaMG2E+dAaWQgjr+GeIqOfhPy0tAvVV9EpAnUdabktQD8WK5nhIPHLbJfN51DlCXAUtLV+Kgje31xbDnS4lYS1dJmlDGywZpkLvMqkd/S1IeGITzSSFk4xyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv7UQ9+x; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso1029859a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758828615; x=1759433415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgNapCwESdbGMpCrQrLezJYMMJNvAweSJEvqsFtNxmM=;
        b=dv7UQ9+xmZf3Xk8WFayfX5RDWzlvmy6p7+ZHgVj3owxneo3+F3z6KI1SBiXJQGy5yZ
         xB2FA6m0R5si8fOjqJJmzH0T+tQz0FdOMQHQmub+5hI9aKg9Ut6yLi9hj5tblGlrHiqC
         ZffVGOrxzxamCpr69Vxp7HxBfCCeTv08f4LKPAeuK6FXRT13IlDSUdcIB8ycHYGT8S8E
         /g4eWYq1dJzHIXS1TyDw4RnVKhdE3qPn01o2Wg/mbxgTOVIwLrQVdLKWFy3MMI1EGdxa
         t6+BSNOtYuo+bsS79sbL0StildEWHPGTmHl8gRyFYL8u0RYrWTvcwWiv8dgHx/uGLB2v
         cCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828615; x=1759433415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgNapCwESdbGMpCrQrLezJYMMJNvAweSJEvqsFtNxmM=;
        b=r3iZq3gB/IzQhM6ZT5+5WuDJMpQVnz0TS8hFISvVyxEET2P+56+Lxqvturxg4KJ5BH
         qMK2DvBxFr+5jQrSTcmjPdSn24DCrnLuCNB5DRSbJzFGdLg8Swt4RNbIxJd/jMjXdN3M
         E4TwsiDDNafpCoM8Dy4Uqws1BSlTjgClVQXVdJsd5RFOC/+0UD7EIwsfakNzDIG0iQ2i
         N7hjajO03Z54M8cMrx/kmSu570+qb/jjJcmgIHdbs70Lse1x601iyOQnMbYxV7B8RX7u
         CmeBlARxp76O4fUfIqMeYVSaeURB6YaTms0Z2fPCHOPlh2ajajbNVtogQhFW0cpqu4Ju
         nNng==
X-Forwarded-Encrypted: i=1; AJvYcCXUKTsXA21WLbCS7lwVq8l7xzFo7l4avjMpSNLq8iCPZ+1gRDDRdSwzRb7eboZyqXsfQGh+EBx1hM4fYbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUI7aG/5CS6CqdODlhUYkUwayzGBJZse3BvYkcqK6GlMyWu4lw
	4Ds1vKAAE4hqpjO99yStcHQp/zJt554w9EXB8pueAVZbWii5oYtb8iEZ2OYmra7E9KszDWtFN5O
	mbvak8x50ZEiDcgkv3qwSop3g7fZ8VL0=
X-Gm-Gg: ASbGncsxV6SAnzIKIpGoWLWYiV+vZX4RNmENlXD5VIrMvC+NS/ZcXLpLO3sIhJxmuw8
	C/ZZQ0QApOPEphV6d95GL68Zy7ygmWnt72OJkCUXNebaiAqwnnneARbl5+Aw/VMv3jR6ANkvlew
	3yL70wiW+Y1F410oFR+bx2Ljc6kk7XMzONYGiiCK4lz/nErbjgVpmrE2dHI1A6DBmKAEZX+p3/W
	r2EE1l02z575pcuDwgTjmlyuLc=
X-Google-Smtp-Source: AGHT+IEOB8JUBgCgxrz82f7DOcWpk1nC+2WRXM7VFt1j7bzQ5Sn5G1rlOU1WlSd3nK7yZxs2Cr+AvzG7NLss8Qj8Mno=
X-Received: by 2002:a17:90b:554d:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-3342a235abamr4279736a91.2.1758828614548; Thu, 25 Sep 2025
 12:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922081713.77303-1-acsjakub@amazon.de>
In-Reply-To: <20250922081713.77303-1-acsjakub@amazon.de>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 25 Sep 2025 12:29:59 -0700
X-Gm-Features: AS18NWAghUc-aM26PayRwLjxAlxiiFTKxSudGsiJZK0JszhZdY3fAuWO57_CdTY
Message-ID: <CANaxB-woLUz0w0wg2fOoJQxq5iF=qU0p=S8rQMPFD9Fr50sV3A@mail.gmail.com>
Subject: Re: [PATCH v2] fs/proc: check p->vec_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jinjiang Tu <tujinjiang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:17=E2=80=AFAM Jakub Acs <acsjakub@amazon.de> wrot=
e:
>
> When PAGEMAP_SCAN ioctl invoked with vec_len =3D 0 reaches
> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
>
> [   44.936808] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x00000=
00000000007]
> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.=
0-rc6 #22 PREEMPT(none)
> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
>
> <snip registers, unreliable trace>
>
> [   44.946828] Call Trace:
> [   44.947030]  <TASK>
> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
> [   44.954427]  walk_p4d_range+0x41e/0x620
> [   44.954743]  walk_pgd_range+0x31e/0x630
> [   44.955057]  __walk_page_range+0x160/0x670
> [   44.956883]  walk_page_range_mm+0x408/0x980
> [   44.958677]  walk_page_range+0x66/0x90
> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
> [   44.961833]  do_pagemap_cmd+0x59/0x80
> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
> [   44.962804]  do_syscall_64+0x5b/0x290
> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> vec_len =3D 0 in pagemap_scan_init_bounce_buffer() means no buffers are
> allocated and p->vec_buf remains set to NULL.
>
> This breaks an assumption made later in pagemap_scan_backout_range(),
> that page_region is always allocated for p->vec_buf_index.
>
> Fix it by explicitly checking p->vec_buf for NULL before dereferencing.
>
> Other sites that might run into same deref-issue are already (directly
> or transitively) protected by checking p->vec_buf.
>
> Note:
> From PAGEMAP_SCAN man page, it seems vec_len =3D 0 is valid when no outpu=
t
> is requested and it's only the side effects caller is interested in,
> hence it passes check in pagemap_scan_get_args().
>
> This issue was found by syzkaller.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Penglei Jiang <superman.xpt@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrei Vagin <avagin@gmail.com>

Acked-by:  Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei

