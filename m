Return-Path: <linux-kernel+bounces-771835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6AB28C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75A51CE4CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC323BD1F;
	Sat, 16 Aug 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm13s9ge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AB23C397
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334060; cv=none; b=Ai+hKcaqWnuKARjZ8dQtmEDXYkcizLujAnDq7mQmCrxgiKablLVmQbcrL01124lmJBBCPP20MBDsQHWTPg3UCWDVZnvIvkrXsnwzlLcqY/sNWSAfhPhIACXOZcJq3oMLMTqImy8B4YPGlpmfuph2cLht4uB6/iSc8Ju3JNMrxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334060; c=relaxed/simple;
	bh=HkZlzOA9ZrYvvcD0PeswYGZw66p+bwhTbRZ8Q8hstkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skyvOytB9bjwbDWOUWWdnLRxFAl66KdX8eh8XaUox2M9JXcZUP4KIvJFLz80wZm1wAQYIHc7+fNSSgKvEqtBCel/OUkv5xFxAlsQ5UPUpATE6Y9JEp1vOxTmLgH+oa3MxQ28uoRjNxVJ2Sc4A8KabAxpsaT2BRI7W6vLVsvczZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm13s9ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD7FC4CEF0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755334059;
	bh=HkZlzOA9ZrYvvcD0PeswYGZw66p+bwhTbRZ8Q8hstkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bm13s9geUm2bfzSIYEjfG9gtzpkynoYlOiCgHRpkWKhP1Ty+6/P+euavvugmHQJMa
	 ou54bABqCUUEGBdtfzMmoh2Vn1uI3s9GnsViLYUfeSkPB9kUgxHxFP7fZKgIh7lDM3
	 9IdNId715qPg3EoCVnDiT185nNI8acM1lP+4tykUFChZa2FR1px8n3d9yj+VE/T/9y
	 d1yJCozG9kAVHdjmeiCZtYAGIjrhOJkxO6DhjVuilWeEX3OcH5zKuvNxlqeE4utaCp
	 N8iOxgd3NQHcDWJCdoxTk21gCF6dGCHxyU93D/zEj4Ul6XdfbIUFlQnzUwMutqZztv
	 44aWx4ZvhL7xw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb79f659aso403629966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 01:47:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNpMBhuwZKGatYwOnn3IDV3nqKdrU77Wa/++Xhj5pN1i09wNAYHqfLVJNwGjfbrWVq0fMN66N4EzNZaVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMyc8XZ6po2TfaMJ9jhawE0IxdAlkGK1TeKGTdGmPS/35rViW
	6ME1VORzpKhOLNBk5BUpyny+WK0tBkQTkRKTJa7Q7+2kwlNfhc9IIAjppI0aK9EQZjEhXwIlDNo
	NFNt7W6HokMB0itjY7j1/sHpSG11gll4=
X-Google-Smtp-Source: AGHT+IG2/ge+J54lL98agjdmhjJpHeai2wzug4zI7jxa0J4QZRgmZytm10MNWrq4ZzgJrJXkyOPbDR++P4wZcWmTFeY=
X-Received: by 2002:a17:907:1c0d:b0:af2:bb2d:9b1e with SMTP id
 a640c23a62f3a-afcdc1c1295mr429526466b.5.1755334057980; Sat, 16 Aug 2025
 01:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816072149.1952348-1-chenhuacai@loongson.cn> <c324c1fe-7a64-4da1-9641-fb1b9756ba2f@redhat.com>
In-Reply-To: <c324c1fe-7a64-4da1-9641-fb1b9756ba2f@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 16 Aug 2025 16:47:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Q=6vgWnC1wNHKR11H6ziRagAktXm0Rth2rcwmeTtHDw@mail.gmail.com>
X-Gm-Features: Ac12FXx3M7wFfM1KCeH9c04Ro5iit2qB-qKmwhBwhUsutOoU3OZqPoaF1OAXn0I
Message-ID: <CAAhV-H6Q=6vgWnC1wNHKR11H6ziRagAktXm0Rth2rcwmeTtHDw@mail.gmail.com>
Subject: Re: [PATCH V2] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: David Hildenbrand <david@redhat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David,

On Sat, Aug 16, 2025 at 3:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.08.25 09:21, Huacai Chen wrote:
> > After commit 84caf98838a3e5f4bdb34 ("mm: stop storing migration_ops in
> > page->mapping") we get such an error message if CONFIG_ZSMALLOC=3Dm:
> >
> >   WARNING: CPU: 3 PID: 42 at mm/migrate.c:142 isolate_movable_ops_page+=
0xa8/0x1c0
> >   CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 =
PREEMPT
> >   pc 9000000000540bd8 ra 9000000000540b84 tp 9000000100420000 sp 900000=
0100423a60
> >   a0 9000000100193a80 a1 000000000000000c a2 000000000000001b a3 ffffff=
ffffffffff
> >   a4 ffffffffffffffff a5 0000000000000267 a6 0000000000000000 a7 900000=
0100423ae0
> >   t0 00000000000000f1 t1 00000000000000f6 t2 0000000000000000 t3 000000=
0000000001
> >   t4 ffffff00010eb834 t5 0000000000000040 t6 900000010c89d380 t7 900000=
00023fcc70
> >   t8 0000000000000018 u0 0000000000000000 s9 ffffff00010eb800 s0 ffffff=
00010eb800
> >   s1 000000000000000c s2 0000000000043ae0 s3 0000800000000000 s4 900000=
000219cc40
> >   s5 0000000000000000 s6 ffffff00010eb800 s7 0000000000000001 s8 900000=
00025b4000
> >      ra: 9000000000540b84 isolate_movable_ops_page+0x54/0x1c0
> >     ERA: 9000000000540bd8 isolate_movable_ops_page+0xa8/0x1c0
> >    CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> >    PRMD: 00000004 (PPLV0 +PIE -PWE)
> >    EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> >    ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> >   ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> >    PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> >   CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 =
PREEMPT
> >   Stack : 90000000021fd000 0000000000000000 9000000000247720 9000000100=
420000
> >           90000001004236a0 90000001004236a8 0000000000000000 9000000100=
4237e8
> >           90000001004237e0 90000001004237e0 9000000100423550 0000000000=
000001
> >           0000000000000001 90000001004236a8 725a84864a19e2d9 9000000002=
3fcc58
> >           9000000100420000 90000000024c6848 9000000002416848 0000000000=
000001
> >           0000000000000000 000000000000000a 0000000007fe0000 ffffff0001=
0eb800
> >           0000000000000000 90000000021fd000 0000000000000000 9000000002=
05cf30
> >           000000000000008e 0000000000000009 ffffff00010eb800 0000000000=
000001
> >           90000000025b4000 0000000000000000 900000000024773c 00007ffff1=
03d748
> >           00000000000000b0 0000000000000004 0000000000000000 0000000000=
071c1d
> >           ...
> >   Call Trace:
> >   [<900000000024773c>] show_stack+0x5c/0x190
> >   [<90000000002415e0>] dump_stack_lvl+0x70/0x9c
> >   [<90000000004abe6c>] isolate_migratepages_block+0x3bc/0x16e0
> >   [<90000000004af408>] compact_zone+0x558/0x1000
> >   [<90000000004b0068>] compact_node+0xa8/0x1e0
> >   [<90000000004b0aa4>] kcompactd+0x394/0x410
> >   [<90000000002b3c98>] kthread+0x128/0x140
> >   [<9000000001779148>] ret_from_kernel_thread+0x28/0xc0
> >   [<9000000000245528>] ret_from_kernel_thread_asm+0x10/0x88
> >
> > The reason is that defined(CONFIG_ZSMALLOC) evaluates to 1 only when
> > CONFIG_ZSMALLOC=3Dy, we should use IS_ENABLED(CONFIG_ZSMALLOC) instead.
> > But when I use IS_ENABLED(CONFIG_ZSMALLOC), page_movable_ops() cannot
> > access zsmalloc_mops because zsmalloc_mops is in a module.
> >
> > To solve this problem, we define a movable_ops[] array in mm/migrate.c,
> > initialise its elements at mm/balloon_compaction.c & mm/zsmalloc.c, and
> > let the page_movable_ops() function return elements from movable_ops[].
> >
> > Fixes: 84caf98838a3e5f ("mm: stop storing migration_ops in page->mappin=
g")
> > Acked-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Use EXPORT_SYMBOL_GPL_FOR_MODULES instead of EXPORT_SYMBOL and fix =
build.
>
> See my review.
>
> Please wait longer for a resend, so we don't have to do this weird
> review dance.
I'm sorry, when I receive Zi Yan's Ack I think there is no big
problems, so I sent V2.

Huacai

>
> --
> Cheers
>
> David / dhildenb
>

