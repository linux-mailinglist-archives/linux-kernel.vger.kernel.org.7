Return-Path: <linux-kernel+bounces-841254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B842BBB6A69
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0D7428DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B722F2917;
	Fri,  3 Oct 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G94u3Hyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A12F2900
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493899; cv=none; b=sMRRWbzSksodrtFRgURo3bNIq8nAvpiqZ8srOsmA0OSJylmaO53XnWhb9LAdDvcz5z1NvG2dmKLLACTA9rDczvkHBwIRWnZYD7D7rqRPeHDAZqY+eJ2aAI50xAbuPCepEzJKRzdnfEbw7wONIO5siW+m+JaY2r1AOtUQSkw14CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493899; c=relaxed/simple;
	bh=JariEKaBeuZ/Bps99dmisJJHJiELXmbvZdYr8sU/UZg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GyFzDSJNvBP6n4cIwgbKOI19nkSNkBsZFs/6dnzWs9y77yE8rpgtlrhly/orn9ofCrPr1f18hN6yy3zmn+CQ5yyN59rvOKd8qgbktbnL8UeuPOAr/Qo5CWwgqbw7BKT4Z3acPyaURuUIpBbiizeEnb5g0/j6PEV4PmS+MjRXgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G94u3Hyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59098C4CEFC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759493898;
	bh=JariEKaBeuZ/Bps99dmisJJHJiELXmbvZdYr8sU/UZg=;
	h=From:Date:Subject:To:Cc:From;
	b=G94u3HyviVJKe8+Zmw9gKOFvz41336SmP+HLQLhqc+7SMmBO0r0PYO2b8TqqzXsfx
	 VABoHY09WP8I6U3Oor3EUx0ooAwICHR51vjPPPHGpdhAfc+C/GYKjBmVu83n0mZ3gM
	 vGaFrarAXAIN9tDFSXA9Sh7S/wmEYOB48Zr7mJ2QLAYkhmWIEyKX3NXxzVN+ZmNOAO
	 txO3rt5RYUzUcWKsdaoUyEcQ06//ph0T4A3oD8slDYFfack+0x9zByVNRfHScwfrSw
	 wD5ImETqcBTKsb5XChmGDm0XqSXWz+OFTUUnrHn9BSO9S6nBX/wHUZ6DYOLf0NomWP
	 85EQasBvUzYVw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e44f22f15so310623966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:18:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3uYzclalsimN2ikAoH+d+5FfUSKjOoq325e1C2ikHc+6TE3DaOXbelkRBwg945lSaOwcuFdsGFzjZcmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1c/ACyt2NBzWV64i/b64DYJLA5BK39Yob3cNq0sweJBTR/Y3O
	ydAzclMfFjV5TPxSfa0ZM4uw9tolgs8M4UAJnC94sskjdFO5qmYfwVsJYS9SxlWbg1dc7iBf/Ii
	ykhWwsOlapX43bMDra5wuf44+XVXd44I=
X-Google-Smtp-Source: AGHT+IGSxUzOIbfbm3FsfzrHMaN29naRCSxhKPN6+v8/0Aak1YHg5gyjiAw3l4QpwCMftYz/oZ85EKFCrUIs8NsVgE4=
X-Received: by 2002:a17:907:7fa7:b0:b3e:5f20:889f with SMTP id
 a640c23a62f3a-b49c1f54854mr334620466b.26.1759493896777; Fri, 03 Oct 2025
 05:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Oct 2025 21:18:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8XfKPTdDMbHKkyQN1FTGLmgKkMTkUiSOuHE=FjB=G==w@mail.gmail.com>
X-Gm-Features: AS18NWDj85efeCrnhmR_6GlearyaVWhbXdxiwoIn6txK-daRoSjTXko9mdOfVKg
Message-ID: <CAKYAXd8XfKPTdDMbHKkyQN1FTGLmgKkMTkUiSOuHE=FjB=G==w@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.18-rc1. I add a description of
this pull request below. Please pull exfat with following ones.

Thanks!

The following changes since commit 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f:

  Merge tag 'for-linus-6.18-rc1-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2025-09-29
19:42:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.18-rc1

for you to fetch changes up to d01579d590f72d2d91405b708e96f6169f24775a:

  exfat: Add support for FS_IOC_{GET,SET}FSLABEL (2025-09-30 13:49:31 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
 - Two small clean-up patches.
 - Optimizes allocation bitmap loading time on large partitions
   with small cluster sizes.
 - Allow changes for discard, zero_size_dir, and errors options
   via remount.
 - Validate that the clusters used for the allocation bitmap are
   correctly marked as in-use during mount, preventing potential
   data corruption from reallocating the bitmap's own space.
 - Uses ratelimit to avoid too many error prints on I/O error path.

----------------------------------------------------------------
Chi Zhiling (1):
      exfat: limit log print for IO error

Ethan Ferguson (1):
      exfat: Add support for FS_IOC_{GET,SET}FSLABEL

Liao Yuanhong (1):
      exfat: Remove unnecessary parentheses

Namjae Jeon (2):
      exfat: validate cluster allocation bits of the allocation bitmap
      exfat: optimize allocation bitmap loading time

Sang-Heon Jeon (1):
      exfat: combine iocharset and utf8 option setup

Xichao Zhao (1):
      exfat: drop redundant conversion to bool

Yuezhang Mo (1):
      exfat: support modifying mount options via remount

 fs/exfat/balloc.c    |  85 +++++++++++++++++++++++----
 fs/exfat/dir.c       | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 +++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/fatent.c    |  11 ++--
 fs/exfat/file.c      |  52 +++++++++++++++++
 fs/exfat/inode.c     |   2 +-
 fs/exfat/namei.c     |   2 +-
 fs/exfat/nls.c       |   2 +-
 fs/exfat/super.c     |  68 +++++++++++++++++-----
 10 files changed, 360 insertions(+), 35 deletions(-)

