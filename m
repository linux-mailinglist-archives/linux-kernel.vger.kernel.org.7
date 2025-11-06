Return-Path: <linux-kernel+bounces-889356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBCAC3D5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A95E1882207
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B44303C94;
	Thu,  6 Nov 2025 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2xx3fpC"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E32E9EAA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461194; cv=none; b=f4fi73e8nbXI+JfFmIB8j8aPzH58bcrEa7GQ86XLH7GPZjnd0Iq7pQaRFi2/HoZKEN3/XVnb+KU+9osETu1etwRNkOIjrPA6Qko87pPYdjzxk0Xf/JUAI4Vv9a8OAtb31dQ0ELQKG4gVDCcyN6+hMqh6299s+g2dsEWdI28nKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461194; c=relaxed/simple;
	bh=cMSQrjZkGQSnP5w1MESAvPDLAzb50CLulWqD9TFCtXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmAign8tp83M0DTNyDX4LglcDIbmfd5gwiBuyJE2lrSIGjQFuNmMw1ALV3dFWmpgV7odfYwSJ0nZ4a5dYDozV3NOnjyV0JieSSB/DpL/rVOKFKlOLmvztZNnJAbEYXpsX9ku07MPZPKU3Ywqe0uv0KjQvrHbd5H3TZ6bNgDnfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2xx3fpC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso65655a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762461191; x=1763065991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL+ExJHey77vkVnS/nFKD2Q80J+5rEXtAD2VwaDjjF0=;
        b=m2xx3fpCijJSYdG+NbzRGq8gyBpeAAMj5JF2vJeSQ9ZcK0J552SpYRTqsleHB1HWRc
         IOiGD0FZFSl1GN1c+SyqykIQ31iR7QXgRSdWOR7ixCjJS/kSJjWkpq7D27Z5GLeNX0Ca
         D+sG/sBxd2R16EEBYmPcmlznuNsmJDqvo8I7uaKvo0tYkTGkQtpGWV18nsRE2CEGR6Wl
         9HA8LbauFgERQezvq1A3AgRXLyAdKkc2nReZy6QH3cc8v1+e6MCJ/GoJYRicYHFXQN56
         +rhRqdSvK/whlLQ4J1JVF837no9DR1IvWmpTB6QLuNZTpZ+qFtvWggsIZpX10jeGdtkL
         EhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762461191; x=1763065991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xL+ExJHey77vkVnS/nFKD2Q80J+5rEXtAD2VwaDjjF0=;
        b=inydT4Yn4zfMgEJ4mFimbqIyUMjcxgF0+BdMFszeJ5z4pzQDvunuL5wjXOzItAu/s9
         c4s6W/anI81aTzsyaeyUtg05ouJx1s0BVfnHhVbzbW2C4Sjs+XVYkaWVEfkrv6BAf4X+
         xyBE+vs5m3khBIzJdMKaF5+N54zBuBWWNBuBJIkMJ+I0RbVM7fXwi465cX4zmKJTRN7k
         C0+ZMW8SHE77ghOmK79T1BFRnfRCCYoIPYGU3Ou6HVWrl1ujNYMNtOMiUz1VjYfB9S2K
         9OLb5VgVjsuYvBlZWi/ZPJgZJ5RaMMQSuxW3Aq3Wkx1z0EQ512gR3UbqsQhD3l82zW/V
         koNg==
X-Forwarded-Encrypted: i=1; AJvYcCXdcAsLBkYpcP9M9j+7CS8QPAlbJlepEORut6CCctTSAD3/ZvoGZpjTqHUMlly+Y0XEaEeP/tz/lsQTsf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScQLi5q8IT5k9ORcP02Dq2tIaAkpX0dah0tlBqHoo79sWoDVm
	71vNpLmR4mYw51GBB3luz/p0GyoNTGDxKyycAFReZ0jUFKR/s0cgx+iNrnzPY3dsCUVlU6ZOI2m
	2wE7LFOsm9ECNTY9gFFrCPbBQ5DEg1MY=
X-Gm-Gg: ASbGncsuHs3ga4royBU0auz3ap2hTJ3CyzQfopElrrQ2h4n+139GlDz0CsgqiN+IFtu
	3TatZxPvUTcB+f666Bg7yuoC2dJJFn2r/NgtCT0ZWGyyx+08NMPp8YrPCLs0pgjTtkTICjjnqIs
	uR6H0yQlWpm9+OEOgsQptP08Uflit0CPagjAWidI8IgrGBs8cO5p00CVfNZpcP20nCww2qJS/ON
	9+uZSv3QZ6NSflz6++L5JlzEFmHpsfkg13HUyveKZI5EaORft1HND26chK7Tnlp1YPEbnE=
X-Google-Smtp-Source: AGHT+IETH7TgDjX9EmzND1gh9/bOqYrGX4023/EKkF9DvOk4qobTQ/4/v6JxHRNK5zF87+RCoQSIQaroXmmA31SkP4I=
X-Received: by 2002:a05:6402:1446:b0:640:947e:70b7 with SMTP id
 4fb4d7f45d1cf-6413f059a21mr880436a12.3.1762461190669; Thu, 06 Nov 2025
 12:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
In-Reply-To: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 6 Nov 2025 12:32:58 -0800
X-Gm-Features: AWmQ_bnPi8eKWYWNRrzziK5Z4e3l9q9ff39Nc1Vl19617h5U67D-CZcDH7VdLSo
Message-ID: <CAHbLzkqvXsFfziYU6A_LXfF2UQHkmNHqyT05P+dTav3mi4b0hA@mail.gmail.com>
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: "Garg, Shivank" <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, zokeefe@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 7:16=E2=80=AFAM Garg, Shivank <shivankg@amd.com> wro=
te:
>
> Hi All,
>
> I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT pag=
es
> when CONFIG_READ_ONLY_THP_FOR_FS=3Dy is enabled, and would like to discus=
s the
> current behavior and improvements.
>
> Problem:
> When attempting to collapse read-only file-backed TEXT sections into THPs
> using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the page=
s
> are marked dirty.
> madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and err=
no =3D -22
>
> Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first madv=
ise
> attempt triggers filemap_flush() which initiates async writeback of the d=
irty folios.
>
> Root Cause:
> The failure occurs in mm/khugepaged.c:collapse_file():
> } else if (folio_test_dirty(folio)) {
>     /*
>      * khugepaged only works on read-only fd,
>      * so this page is dirty because it hasn't
>      * been flushed since first write. There
>      * won't be new dirty pages.
>      *
>      * Trigger async flush here and hope the
>      * writeback is done when khugepaged
>      * revisits this page.
>      */
>     xas_unlock_irq(&xas);
>     filemap_flush(mapping);
>     result =3D SCAN_FAIL;
>     goto xa_unlocked;
> }
>
> Why the text pages are dirty?

I'm not sure how you did the test, but if you ran the program right
after it was built, it may be possible the background writeback has
not kicked in yet, then MAD_COLLAPSE saw some dirty folios. This is
how your reproducer works at least. This is why filemap_flush() was
added in the first place. Please see commit
75f360696ce9d8ec8b253452b23b3e24c0689b4b.

> It initially seemed unusual for a read-only text section to be marked as =
dirty, but
> this was actually confirmed by /proc/pid/smaps.
>
> 55bc90200000-55bc91200000 r-xp 00400000 07:00 133                        =
/mnt/xfs-mnt/large_binary_thp
> Size:              16384 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                 256 kB
> Pss:                 256 kB
> Pss_Dirty:           256 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:       256 kB
>
> /proc/pid/smaps (before calling MADV_COLLAPSE) showing Private_Dirty page=
s in r-xp mappings.

smaps shows private dirty if either the PTE is dirty or the folio is
dirty. For this case, I don't expect the PTE is dirty.

> This may be due to dynamic linker and relocations that occurred during pr=
ogram loading.
>
> Reproduction using XFS/EXT4:
>
> 1. Compile a test binary with madvise(MADV_COLLAPSE), ensuring the load T=
EXT segment is
>    2MB-aligned and sized to a multiple of 2MB.
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  =
MemSiz   Flg Align
> LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000 0=
x1000000 R E 0x200000
>
> 2. Create and mount the XFS/EXT4 fs:
>    dd if=3D/dev/zero of=3D/tmp/xfs-test.img bs=3D1M count=3D1024
>    losetup -f --show /tmp/xfs-test.img  # output: /dev/loop0
>    mkfs.xfs -f /dev/loop0
>    mkdir -p /mnt/xfs-mnt
>    mount /dev/loop0 /mnt/xfs-mnt
> 3. Copy the binaries to /mnt/xfs-mnt and execute.
> 4. Returns -EINVAL on first run, then run successfully on subsequent run.=
 (100% reproducible)
> 5. To reproduce again; reboot/kexec and repeat from step 2.
>
> Workaround:
> 1. Manually flush dirty pages before calling madvise(MADV_COLLAPSE):
>         int fd =3D open("/proc/self/exe", O_RDONLY);
>         if (fd >=3D 0) {
>                 fsync(fd);
>                 close(fd);
>         }
>         // Now madvise(MADV_COLLAPSE) succeeds
> 2. Alternatively, retrying madvise_collapse on EINVAL failure also work.
>
> Problems with Current Behavior:
> 1. Confusing Error Code: The syscall returns EINVAL which typically indic=
ates invalid arguments
>    rather than a transient condition that could succeed on retry.

Yeah, I agree the return value is confusing. -EAGAIN may be better as
suggested by others.

>
> 2. Non-Transparent Handling: Users are unaware they need to flush dirty p=
ages manually. Current
>    madvise_collapse assumes the caller is khugepaged (as per code snippet=
 comment) which will revisit
>    the page. However, when called via madvise(MADV_COLLAPSE), the userspa=
ce program typically don't
>    retry, making the async flush ineffective. Should we differentiate bet=
ween madvise and khugepaged
>    behavior for MADV_COLLAPSE?

Maybe MADV_COLLAPSE can have some retry logic?

Thanks,
Yang

>
> Would appreciate thoughts on the best approach to address this issue.
>
> Thanks,
> Shivank
>

