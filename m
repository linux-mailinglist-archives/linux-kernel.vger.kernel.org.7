Return-Path: <linux-kernel+bounces-888552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51CC3B213
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7460218990FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED73321BD;
	Thu,  6 Nov 2025 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTD75gVW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD5SJenl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0231D759
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434235; cv=none; b=nyNK2+aFLppac4M/m10e/esv4wmV1eL47c9qCIHZ/4zfNg7wZQ2gjpjIbzSErUgZGyXgPULyftVcM3m0eXLn1tfIIPbMgNqa8CAu/424EB4+tN1N/GVDlfxknXVIZvIjKFUBeR2Ke8SL9mBKyKfasjtgyeKD9RP4lR5hcmX99hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434235; c=relaxed/simple;
	bh=3bdUR68T/fa0uvkiJsWQ34WuE6GX3roAK3RgFXKzJo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCQjv19VzHczRNWGs8i6NHz8idSv7r+JOo5HKFmiRQBCbc92/209xy13zLL4LaBL1dvH+q6K4Xd8Tm507czDukwwCcZYMnLctNzzZ2bHGIvkgt5MIzxd8fI6I2bsqpWJmRcD3Z4g37yFU95LksfdcY2Dmc/WzeZEJet0UyFhM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTD75gVW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD5SJenl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762434232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bizzw1eY/sYaE2qZFBkce0cFEHI+eAygGrJfW35YF8M=;
	b=iTD75gVWvayK6V7Uqdbf8BNYTrAHjm5Uxf78Pro7Vyk3uHF2zQS7k06UCbsQzBCvrU3uzz
	K6M2HfiB8NGM9qxC43YeVclV+ARdW77QSAUVJnraFFecEUG3J81SMhasTxcyxWVy/HkEdA
	mGqL/axupe56m8udv9iWgRwwRrJYuyw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-okUPfCr_OQ-_R2YiywCE4g-1; Thu, 06 Nov 2025 08:03:51 -0500
X-MC-Unique: okUPfCr_OQ-_R2YiywCE4g-1
X-Mimecast-MFC-AGG-ID: okUPfCr_OQ-_R2YiywCE4g_1762434231
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78659774402so4260257b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762434231; x=1763039031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bizzw1eY/sYaE2qZFBkce0cFEHI+eAygGrJfW35YF8M=;
        b=YD5SJenld7pL/gGUIrLPmkmiblzszKzewN5ZF47HynNjXwqdGA/5oYJjFBLfCb+b49
         rVtt8QZGZvY9mC+ME87hizRT0s5YdbSrykjqmDeiVPb+j9dRXHmbvq4tuz5CZJ4rTdxL
         cPbdUJ1UfF6P/5aYZCd3rI70bOwmmtzsXZJmF3MSffJxl1v/cv2v9aUeYql9hDyftnIf
         V0eY08VKI0MBGEWUT9swXPT1wfP3+MvTAnDOz32k77I6dFVHmwe0I7dh5ybWVqh1A6EY
         kwJWGh7/TCfBHvw6nzD+1rZYMkRv4K2g1ju7kPq767C3cYi0/zNU7E31XyVPVgwEGthj
         JLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434231; x=1763039031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bizzw1eY/sYaE2qZFBkce0cFEHI+eAygGrJfW35YF8M=;
        b=P5A5GKae2IYPOvBmETfS5q9HLIJHcx4yVOMAsMb/NzbHPtXgx8U8TP9SBhzXxY7vBB
         +8PCvZdKhs9cr0OG0CNhPKFqxH56UF061xAV+SAWOAelAEuaDACxsPvPouE7CrMwB7Ce
         ZB+YkSiy3meP0dBZWspxToE/CE0hhEZaAZK7J28POTfg+s8VIaRR7bWb2SfnSaeVfWya
         hj6uCWqD6dAAssscv6CYPwKkVKr8uP+RHIf3U3AezslLEpZsyteIes1kdPP/QD+vAzVG
         nSOJEcqANg4DUypnRqkvukmLtAhOPbBT82cRdFyevQ7o9EuT9goV+I1mi7dnekVT3Znm
         TmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVartVDrYJu37hySRqBQanveVAav1VdLsRE0g2kSyWwurwpKA9yKUilLQ4ot8XtTFlSxA8LXD/p5h6Haxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhwcgjI/I6KC+qj4vqDGYQRTdovUrnaXiNnIlqTLPI/l8nYRd
	pe45l2ohDJa3qjGfE6tK3qHtNsoo8Sra5mwR+S02EXBqvOjczqcYXkw0li15BfU+nT9pzcuawOJ
	eum+PE12aF7y5L4WRLuuPq2tmDPrrg+fYS0GqzAZjVcBHfbiR45O7xSh26QtPHoDX3npVerGP05
	gsYoUHJO55b0gpZQDD+ev0cRjxzN7hMfTuwDeptUAg
X-Gm-Gg: ASbGnctDxOZLZZETkgzsgYNUBUPN+ErF+wfW/yRyqL/YFHJ39odGzYEaQ6qlQON4DKq
	zx5jY5PyiClbwU7zqMYnKDMcxUQgzaLGoxS3veJMQljHEkEsC6h9WBhfE/YtZWzsOXsag5ZeQZC
	RXIBqt1aHigbARMrB9aEUEcr4rtkObMi340NGEPaSxmldVGwupVd1B+iM5fxRhUN5jA2Qkog==
X-Received: by 2002:a53:acdc:0:20b0:63f:abf6:1cc with SMTP id 956f58d0204a3-63fd34a9b9fmr5235611d50.13.1762434230921;
        Thu, 06 Nov 2025 05:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpM27qMKWP5kpbGDiF2b/f4sLGs5D3inRXd3HbmlPqqsA/ZAGOkpTYQR3sOmWapf3I6dH4KtY5KHTahLsbspU=
X-Received: by 2002:a53:acdc:0:20b0:63f:abf6:1cc with SMTP id
 956f58d0204a3-63fd34a9b9fmr5235565d50.13.1762434230418; Thu, 06 Nov 2025
 05:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com> <1783f8fc-6b9b-422e-999e-2a6f58d90807@linux.dev>
In-Reply-To: <1783f8fc-6b9b-422e-999e-2a6f58d90807@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Thu, 6 Nov 2025 06:03:24 -0700
X-Gm-Features: AWmQ_blkN6_bT3f71yyauBn3GKS8W7N_lgYx52d35GSxs7M-3nPJr-0AzuRSBm0
Message-ID: <CAA1CXcBktafjRFyD8JD-akVutzS-jQEFFC=kJtO3ewLg0Kk0zw@mail.gmail.com>
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: Lance Yang <lance.yang@linux.dev>
Cc: "Garg, Shivank" <shivankg@amd.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, zokeefe@google.com, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:55=E2=80=AFAM Lance Yang <lance.yang@linux.dev> wr=
ote:
>
>
>
> On 2025/11/6 20:16, Garg, Shivank wrote:
> > Hi All,
>
> Hi Shivank,
>
> Good catch and a really clear analysis - thanks!
+1!
> >
> > I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT p=
ages
> > when CONFIG_READ_ONLY_THP_FOR_FS=3Dy is enabled, and would like to disc=
uss the
> > current behavior and improvements.
> >
> > Problem:
> > When attempting to collapse read-only file-backed TEXT sections into TH=
Ps
> > using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the pa=
ges
> > are marked dirty.
> > madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and e=
rrno =3D -22
> >
> > Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first ma=
dvise
> > attempt triggers filemap_flush() which initiates async writeback of the=
 dirty folios.
> >
> > Root Cause:
> > The failure occurs in mm/khugepaged.c:collapse_file():
> > } else if (folio_test_dirty(folio)) {
> >      /*
> >       * khugepaged only works on read-only fd,
> >       * so this page is dirty because it hasn't
> >       * been flushed since first write. There
> >       * won't be new dirty pages.
> >       *
> >       * Trigger async flush here and hope the
> >       * writeback is done when khugepaged
> >       * revisits this page.
> >       */
> >      xas_unlock_irq(&xas);
> >      filemap_flush(mapping);
> >      result =3D SCAN_FAIL;
> >      goto xa_unlocked;
> > }
> >
> > Why the text pages are dirty?
> > It initially seemed unusual for a read-only text section to be marked a=
s dirty, but
> > this was actually confirmed by /proc/pid/smaps.
> >
> > 55bc90200000-55bc91200000 r-xp 00400000 07:00 133                      =
  /mnt/xfs-mnt/large_binary_thp
> > Size:              16384 kB
> > KernelPageSize:        4 kB
> > MMUPageSize:           4 kB
> > Rss:                 256 kB
> > Pss:                 256 kB
> > Pss_Dirty:           256 kB
> > Shared_Clean:          0 kB
> > Shared_Dirty:          0 kB
> > Private_Clean:         0 kB
> > Private_Dirty:       256 kB
> >
> > /proc/pid/smaps (before calling MADV_COLLAPSE) showing Private_Dirty pa=
ges in r-xp mappings.
> > This may be due to dynamic linker and relocations that occurred during =
program loading.
> >
> > Reproduction using XFS/EXT4:
> >
> > 1. Compile a test binary with madvise(MADV_COLLAPSE), ensuring the load=
 TEXT segment is
> >     2MB-aligned and sized to a multiple of 2MB.
> >    Type           Offset   VirtAddr           PhysAddr           FileSi=
z  MemSiz   Flg Align
> > LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000=
 0x1000000 R E 0x200000
> >
> > 2. Create and mount the XFS/EXT4 fs:
> >     dd if=3D/dev/zero of=3D/tmp/xfs-test.img bs=3D1M count=3D1024
> >     losetup -f --show /tmp/xfs-test.img  # output: /dev/loop0
> >     mkfs.xfs -f /dev/loop0
> >     mkdir -p /mnt/xfs-mnt
> >     mount /dev/loop0 /mnt/xfs-mnt
> > 3. Copy the binaries to /mnt/xfs-mnt and execute.
> > 4. Returns -EINVAL on first run, then run successfully on subsequent ru=
n. (100% reproducible)
> > 5. To reproduce again; reboot/kexec and repeat from step 2.
> >
> > Workaround:
> > 1. Manually flush dirty pages before calling madvise(MADV_COLLAPSE):
> >       int fd =3D open("/proc/self/exe", O_RDONLY);
> >       if (fd >=3D 0) {
> >               fsync(fd);
> >               close(fd);
> >       }
> >       // Now madvise(MADV_COLLAPSE) succeeds
> > 2. Alternatively, retrying madvise_collapse on EINVAL failure also work=
.
> >
> > Problems with Current Behavior:
> > 1. Confusing Error Code: The syscall returns EINVAL which typically ind=
icates invalid arguments
> >     rather than a transient condition that could succeed on retry.
> >
> > 2. Non-Transparent Handling: Users are unaware they need to flush dirty=
 pages manually. Current
> >     madvise_collapse assumes the caller is khugepaged (as per code snip=
pet comment) which will revisit
> >     the page. However, when called via madvise(MADV_COLLAPSE), the user=
space program typically don't
> >     retry, making the async flush ineffective. Should we differentiate =
between madvise and khugepaged
> >     behavior for MADV_COLLAPSE?
> >
> > Would appreciate thoughts on the best approach to address this issue.
>
> Just throwing out a couple of ideas ...
>
> We could just switch the return code to EAGAIN in the MADV_COLLAPSE
> path. At least that
> gives the right hint that retrying is an option ;)

Hey! I agree with Lance here, it seems the solution would be to return
something other than SCAN_FAIL in collapse_file(), then in
madvise_collapse_errno() catch this error and return EAGAIN. We could
use SCAN_PAGE_COUNT which will cause a EAGAIN, or we could create a
new result enum.

Cheers,
-- Nico
>
> Or, what if we just handle it inside the syscall? When we hit a dirty
> page, we wait for
> the writeback to finish and then try again right away. The call might be
> a little slower,
> but MADV_COLLAPSE is best effort, right? That seems worth the trouble ...
>
> Cheers,
> Lance
>


