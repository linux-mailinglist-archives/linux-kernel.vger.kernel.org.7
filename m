Return-Path: <linux-kernel+bounces-854243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A8BDDE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6254B4E7A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D731B801;
	Wed, 15 Oct 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRC0hocW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D372010EE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522519; cv=none; b=DucKh49sTqDnXC3AbC3O2B9T1g0A4lAuUn/dr56QpywtyI0BscDEBBftMqA9W9/YyhPCWIrMvzKfUuiyAk01uTOm5dgxp9szEM9mvFe949LhGhZk8Hr3tcoIrFunPcjF3J+n1ntpUptPmP2tmzU6mi9ciLFAU/WeiSbwDVm31Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522519; c=relaxed/simple;
	bh=EjWyHXy5+AFfe6EBqUpNk7V6ovaOZaq4S3q8E8N3zug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcKgi5941pw6o+YHitMcw7v+wlgWMxTs9YnDPqq64W+MdjoGGi0kpjNyw0TSVIQd7bdPGymxaB/z2wBjScWiI2lZCe7dSHUwP8TsoK560RW1CyqFTzVxiBQH2vZSUmyV+7eso1HcM0r4CzBXjTl5+i7cDmLq7Ei6wgzY2psFbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRC0hocW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso73601535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760522516; x=1761127316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji3QYXE+o6nnOYdZn4k94bGF503TJ64q3dgtQTNhCcw=;
        b=GRC0hocW5KsRxfQotLR+++78UaJCtJhZND9lFrILGfmUTXf9Q2bbmZ5IGErBgA5eDD
         M/yrrbXR7qdPSFNj2FduEKkdPtbzSlIkgoXaVvVf5s9p+2EQNp69yBD5czZjqe0SNnpw
         3EPiVLfUZckw8HTmqQA++gLsxKPluGUMVN/e5y7QZeJRENPVOYYG+Y0mStSxHKqRWvkT
         YNpurNuZyvlu7fZl2g8/znuM21+uijbvKF5CfaZI7QJ+kjf7c+e19unJIq22hnirY1ZD
         02JEYEwGUoKcCOUdbjoCJ7aQc0A2w8zWrxf34+GToqFQc1kHxnDK6RPJIOF2E420/bNw
         CSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760522516; x=1761127316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji3QYXE+o6nnOYdZn4k94bGF503TJ64q3dgtQTNhCcw=;
        b=jYXxojZbmGI4seLbyu7G8kM+m37h0Zc4A8TzZcu6U8LNMQ2blAnacOSBpZMsS/U26q
         c+iKIk1ijdvJ54qByUmduJVBSZvP1WD8qcYINLV84A/EmXcnGbmHwA/PzYXQ6bYuSlWo
         mgNfgMWSMLO2Hm/WVDxHbT2+oOlnKzKEfujr2FQLgkLSoVrmb6eEufcsb0J8/BxFAOgn
         w3MRpITgWFdiBhs/cCM3TMnX5Att2w00dfeI4ZXslDbkn4Fl8QCjuvrprCvXp6STbvjL
         HcTnD7NjBQl1IVWoZTqGMchIvqdQn7QOiirdRmKb7iOnxBOXO8iCaErDvFajlYNROWT4
         1VqQ==
X-Gm-Message-State: AOJu0YzdET6HBcRUAAP9lx4Tvgs8BeeDRRP3xK5yA8wSP6ua8WzlxNak
	Vpb+apusYZBILXhl0L7spHV5vjX/jXh3BlUvUNgjOyPnOgbYhrpoVJb9
X-Gm-Gg: ASbGncuXElzHTjHb8tHe4Tf6Wh0BmrA65+nibIZQ4KR375C7GRiMtjbvgd0de0BF76l
	ijvJEHedrrc+rPeZeDMGGtZnVzYGcDyu9+rrklQoVK3pI9q+y2E/v94LtGO4fsmJPU+OxCu1VQ3
	W6Kf4sZyi/JKBp1XtgAvNzoZwGU+3M9cd7OINrIo5mcM/hCh+ewLq6cdlFcYOi3Qf78HxrV7BcC
	bnkwRgUFl0iRaIdLYYCeRAcRnRMRjfF1/s0bKzzapW2D4+DsjCLwcuGoXdugegEc7BmUVN6B0UT
	Ldbkul0fF3+0Wzr+cljgrVRknOUHwQlQ03G4W2XXmupcdA5j2ijn0XabyO4/eg20Zv3tiH1EQmI
	cgLYq588xpcSe3ZiKn3BIEaTKmQ8Ij0pRtcIcChD3S7oeak/GYJvLLh/E2uEB9Eu0
X-Google-Smtp-Source: AGHT+IHsh+iw7Sm3pxrGuqOCIvTM24vpCcQlsq2cLRgpJFciDOO1FkJaV/AzwQlOPEsvBTYyLAn19Q==
X-Received: by 2002:a17:902:fc86:b0:273:1516:3ed2 with SMTP id d9443c01a7336-29027403425mr330544905ad.50.1760522516192;
        Wed, 15 Oct 2025 03:01:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0726asm191287935ad.72.2025.10.15.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:01:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 15 Oct 2025 03:01:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tao Ren <rentao.bupt@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
 <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>

On Mon, Oct 13, 2025 at 09:46:44PM -0700, Guenter Roeck wrote:
> On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
> > On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> > > Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> > > 
> > > Things look fairly normal: size-wise this is pretty much right in the
> > > middle of the pack, and nothing particular stands out in the shortlog
> > > of merges this merge window appended below. About half the diff is
> > > drivers, with the res being all over: vfs and filesystems, arch
> > > updates (although much of that is actually devicetree stuff, so it's
> > > arguably more driver-related), tooling, rust support etc etc.
> > > 
> > > This was one of the good merge windows where I didn't end up having to
> > > bisect any particular problem on nay of the machines I was testing.
> > > Let's hope that success mostly translates to the bigger picture too.
> > > 
> > 
> > Test results don't look that good, unfortunately.:
> > 
> ...
> > Qemu test results:
> > 	total: 609 pass: 581 fail: 28
> > Failed tests:
...
> > 	sheb:rts7751r2dplus_defconfig:initrd
> > 	sheb:rts7751r2dplus_defconfig:ata:ext2
> > 	sheb:rts7751r2dplus_defconfig:usb:ext2
> > Unit test results:
> > 	pass: 655208 fail: 0
> > 
> 

Update on the sheb (SH4 big endian) failures below.

Guenter

---

sheb
----

sheb:rts7751r2dplus_defconfig:initrd
sheb:rts7751r2dplus_defconfig:ata:ext2
sheb:rts7751r2dplus_defconfig:usb:ext2

Bisect log:

# bad: [ba9dac987319d4f3969691dcf366ef19c9ed8281] Merge tag 'libnvdimm-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# bad: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 8804d970fab45726b3c7cd7f240b31122aa94219
# good: [30c3055f9c0d84a67b8fd723bdec9b1b52b3c695] xsk: wrap generic metadata handling onto separate function
git bisect good 30c3055f9c0d84a67b8fd723bdec9b1b52b3c695
# good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good f79e772258df311c2cb21594ca0996318e720d28
# good: [f1455695d2d99894b65db233877acac9a0e120b9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good f1455695d2d99894b65db233877acac9a0e120b9
# good: [a16c46c2402026162111ed9fd1fc28d25223443e] dma-remap: drop nth_page() in dma_common_contiguous_remap()
git bisect good a16c46c2402026162111ed9fd1fc28d25223443e
# good: [a5883fa94295f1ef2473eadd84cc1e24dab9ae18] selftests/mm: gup_tests: option to GUP all pages in a single call
git bisect good a5883fa94295f1ef2473eadd84cc1e24dab9ae18
# good: [08498be43ee676d8a5eefb22278266322578a3e0] mm/ksm: get mm_slot by mm_slot_entry() when slot is !NULL
git bisect good 08498be43ee676d8a5eefb22278266322578a3e0
# good: [719a42e563bb087758500e43e67a57b27f303c4c] maple_tree: Convert forking to use the sheaf interface
git bisect good 719a42e563bb087758500e43e67a57b27f303c4c
# good: [b9120619246d733a27e5e93c29e86f2e0401cfc5] Merge series "SLUB percpu sheaves"
git bisect good b9120619246d733a27e5e93c29e86f2e0401cfc5
# bad: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect bad 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
# good: [83382af9ddc3cb0ef43f67d049b461720ad785e6] slab: Make slub local_(try)lock more precise for LOCKDEP
git bisect good 83382af9ddc3cb0ef43f67d049b461720ad785e6
# good: [af92793e52c3a99b828ed4bdd277fd3e11c18d08] slab: Introduce kmalloc_nolock() and kfree_nolock().
git bisect good af92793e52c3a99b828ed4bdd277fd3e11c18d08
# good: [ca74b8cadaad4b179f77f1f4dc3d288be9a580f1] Merge series "slab: Re-entrant kmalloc_nolock()"
git bisect good ca74b8cadaad4b179f77f1f4dc3d288be9a580f1
# good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 07fdad3a93756b872da7b53647715c48d0f4a2d0
# first bad commit: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab

I had to revert commit 719a42e563bb ("maple_tree: Convert forking to use
the sheaf interface") and commit af92793e52c3 ("slab: Introduce
kmalloc_nolock() and kfree_nolock()") in the 'slab-for-6.18' branch to fix
the problem. The first patch can not be reverted in mainline since other
patches depend on it.

There is no console output (earlycon does not work) and qemu exits almost
immediately with those patches in place. I have no idea how to debug the
problem further.

Authors:
	Alexei Starovoitov <ast@kernel.org>
	Liam R. Howlett <Liam.Howlett@Oracle.com>

