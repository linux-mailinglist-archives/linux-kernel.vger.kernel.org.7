Return-Path: <linux-kernel+bounces-833838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D52BA32FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643E06275AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68129B764;
	Fri, 26 Sep 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJC8G4Ls"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9B2343BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879393; cv=none; b=kWAXXk3xjgz/sgw6umjSxAYOuKcD4WQy/9JwOgndRDMPMWYY+flZAyc6DjO8bL5/amu0jY35AxUri+q+dPKCS5dz0kJg5CZoIsXJjSS34PrPixA8oQMaRcYL6uiCmqIFprAr+vLo3jHOGsIyx1APZufhNI2ULq1Hq3zPDvQwGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879393; c=relaxed/simple;
	bh=bbDy86KYY3ZYBkBmITYxy6ZCZosNtuwR4dwZHtdPzVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L//EnnQ0ojgCYUS70UCEeLaOTqE3GipTd2YCE9RYCKoD1fruoWDgoqi/kSt4JTggyZw3ZouLOrgob6Pa4FvTAFqfgYnRUeKjCUcm/XSEflikI2jWTPvQm9S2yGIpCJYYDa+QaMtzTAPpalRylIAGbbjS1K1qrtwtjB7/AYBA4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJC8G4Ls; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW72uU/5GW7Ti0YBGI5qxBMM7v79bgMmeZzRdDM98s08Y652ENB7ojPSbbWBjzkWNpGCIGOugOkypF+f4k=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758879387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sF3mMFlEeo6+29CxldPU4wUsiArQVg+D2rLhiy93Ds=;
	b=oJC8G4LsmcpmbIhTFcy61QJ53LJPcfBtV8jcnETGA/Fs0aofTPXkowo07u6AU9j9gmYC/H
	ASRkdeNF4F49LarBVsCZwIRfp2EjjNzY8Cx+us/aoGRJBQ7w6rCpHMgoim3m2QVimc6ge8
	H2B0DiEUFeYavPMYEyDWdBC1QKGvieo=
X-Gm-Message-State: AOJu0YwvqxPGdOycaEh+KVnqD6eW6zFtzKUxxCtf5qolx8W/wYUCFBsX
	x4MVLHdFawkZoBlzp2skr5pHC460ZOumTKrHLIz5pWeaBWWcmdZGl8lz807MKEHfIt8G74reYfn
	s+ARQhHXitdCenxZUh7yujlRnjmATn8c=
X-Google-Smtp-Source: AGHT+IE0VoZpyXKMjv4jutuRolFREokOBBoRz0y1gxD6T4hKQcttqKKtNLh4/LwyPCc1DwqCjc/jIZgZwHPfVl/mBX8=
X-Received: by 2002:ac8:7d15:0:b0:4b5:e63f:d5d8 with SMTP id
 d75a77b69052e-4da4c77c756mr81466571cf.59.1758879385173; Fri, 26 Sep 2025
 02:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d6364e.050a0220.3390a8.000d.GAE@google.com> <CANpmjNMA4sOXAUdCpDDYz-4D9F_BaTFF8DL3Vkhx=q7vPfYG+A@mail.gmail.com>
In-Reply-To: <CANpmjNMA4sOXAUdCpDDYz-4D9F_BaTFF8DL3Vkhx=q7vPfYG+A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Fri, 26 Sep 2025 17:35:48 +0800
X-Gmail-Original-Message-ID: <CABzRoyZuU6WT_eN_gimpFNrA9cVpmTsKCG1f6Mi_KCmYy03C0A@mail.gmail.com>
X-Gm-Features: AS18NWBk7yoZQ6JxZ96p9n__yfVmWuL-V3XgGu7UllO4xRF8xd7eIwb3A-ueoC8
Message-ID: <CABzRoyZuU6WT_eN_gimpFNrA9cVpmTsKCG1f6Mi_KCmYy03C0A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one / zap_page_range_single_batched
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 26, 2025 at 2:55=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Fri, 26 Sept 2025 at 08:44, syzbot
> <syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' o=
f g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D145d4f12580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6e0c213d073=
5f5dd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D60192c8877d0b=
c92a92b
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/10b7c8fdfdec/d=
isk-cec1e6e5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/cbecc36962db/vmli=
nux-cec1e6e5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/214f107d0a3e=
/bzImage-cec1e6e5.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in try_to_migrate_one / zap_page_range_single_bat=
ched
> >
> > write to 0xffff88810adfd798 of 8 bytes by task 13594 on cpu 1:
> >  update_hiwater_rss include/linux/mm.h:2657 [inline]
> >  try_to_migrate_one+0x918/0x16e0 mm/rmap.c:2455
> >  __rmap_walk_file+0x1ec/0x2b0 mm/rmap.c:2905
> >  try_to_migrate+0x1db/0x210 mm/rmap.c:-1
> >  migrate_folio_unmap mm/migrate.c:1324 [inline]
> >  migrate_pages_batch+0x6e1/0x1ae0 mm/migrate.c:1873
> >  migrate_pages_sync mm/migrate.c:1996 [inline]
> >  migrate_pages+0xf5f/0x1770 mm/migrate.c:2105
> >  do_mbind mm/mempolicy.c:1539 [inline]
> >  kernel_mbind mm/mempolicy.c:1682 [inline]
> >  __do_sys_mbind mm/mempolicy.c:1756 [inline]
> >  __se_sys_mbind+0x975/0xac0 mm/mempolicy.c:1752
> >  __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1752
> >  x64_sys_call+0x2932/0x2ff0 arch/x86/include/generated/asm/syscalls_64.=
h:238
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > write to 0xffff88810adfd798 of 8 bytes by task 13595 on cpu 0:
> >  update_hiwater_rss include/linux/mm.h:2657 [inline]
> >  zap_page_range_single_batched+0x182/0x450 mm/memory.c:2007
> >  zap_page_range_single mm/memory.c:2041 [inline]
> >  unmap_mapping_range_vma mm/memory.c:4020 [inline]
> >  unmap_mapping_range_tree+0xfd/0x160 mm/memory.c:4037
> >  unmap_mapping_pages mm/memory.c:4103 [inline]
> >  unmap_mapping_range+0xe4/0xf0 mm/memory.c:4140
> >  shmem_fallocate+0x262/0x840 mm/shmem.c:3746
> >  vfs_fallocate+0x3b6/0x400 fs/open.c:342
> >  madvise_remove mm/madvise.c:1049 [inline]
> >  madvise_vma_behavior+0x192d/0x1cf0 mm/madvise.c:1346
> >  madvise_walk_vmas mm/madvise.c:1669 [inline]
> >  madvise_do_behavior+0x5b7/0x970 mm/madvise.c:1885
> >  do_madvise+0x10e/0x190 mm/madvise.c:1978
> >  __do_sys_madvise mm/madvise.c:1987 [inline]
> >  __se_sys_madvise mm/madvise.c:1985 [inline]
> >  __x64_sys_madvise+0x64/0x80 mm/madvise.c:1985
> >  x64_sys_call+0x1f1a/0x2ff0 arch/x86/include/generated/asm/syscalls_64.=
h:29
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x0000000000001645 -> 0x0000000000002165
>
> One of these writes is getting lost. Which means highwater_rss is
> lossy/approximate - does it matter?

Yes. IMO, hiwater_rss being lossy is an acceptable trade-off for a
non-critical accounting value. The patch[1] simply silences the KCSAN warni=
ng.

[1] https://lore.kernel.org/linux-mm/20250926092426.43312-1-lance.yang@linu=
x.dev/

