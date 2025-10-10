Return-Path: <linux-kernel+bounces-848253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D484BCD038
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272EE1A6698D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D77286430;
	Fri, 10 Oct 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcfGXrVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413753A7;
	Fri, 10 Oct 2025 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101436; cv=none; b=RFC3MCye1YF8v3uH6Cc/OctOHcXB/Gi5KwtfSXP4qYjmiZLdNC5Kju7GK5humY4H6Njtwh4Y4S6Oh9KpezFCPzQ3dSdrYkpetquBSg2j3mljOdTKQUV1KkUNfGmxZUpWkyTrneqA9Xht+IjJt7tQBk6LuB9FwHYAmV5Gdx9UrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101436; c=relaxed/simple;
	bh=4dkeYQlzO9bdga4+WITbxMeARdQ2epVo4jp9/qHnDG8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lrhE2FsODowrKMx7YF7pFaAIoUSV2i4LPVVd1oRlVN4nTE914h+l1HtNQqWhAthqt6iUPzueEkiY3bSyq7zsxU1GHC3nbiCDPHYHXD0zYbPhZsQQnfc3k01BK0/IKhY4E7U1iphq/gBNV38ZVKCvlRK0q6Hnk/RAlwe+7ccAWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcfGXrVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82E1C4CEF1;
	Fri, 10 Oct 2025 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760101436;
	bh=4dkeYQlzO9bdga4+WITbxMeARdQ2epVo4jp9/qHnDG8=;
	h=Date:From:To:Subject:From;
	b=PcfGXrVl1wzSUASuGAJ87ktMUH2kNrqWmtsqYgI/4BGYAfhB1aS3uAkUHFIE2dD1r
	 tJJkkQg/dWiqxQNOLGV0lchiw+5Rt+FOEsgoLpK0ETin40Asl7/vN95kp693lKjLwV
	 V3fRXCB8WYVpZpGhmkkdG/hsGpeXyWgOEMTcmVhxwGIrDuJqvh/pKJcGJMTN1537mq
	 eMQkKyabzWBdqnQ7OYeQYdb3UeU1DvU6hvd+9JfdeRNbPoblTJ5oto0w5Uhs93ICJO
	 E+3puXLZ/pgudHPU7JScxgnzq5OI/oHnpMi+F6jbqgLnN8EVXoYW0AgaZg9Y8/XJl/
	 zQw9NDM32yVQg==
Date: Fri, 10 Oct 2025 15:03:52 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and updates for v6.18-rc1
Message-ID: <aOkEOBbCvAdGdF5c@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the patches for the parisc architecture for this merge window.

Just some minor fixes & initial work on perf_events support.

Thanks!
Helge

-----------------------------

The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc1

for you to fetch changes up to f4edb5c52c93b1bc676064472fb517566a3e2129:

  parisc: Fix iodc and device path return values on old machines (2025-10-09 23:45:04 +0200)

----------------------------------------------------------------
parisc architecture updates for kernel v6.18-rc1:

Minor enhancements and fixes, specifically:
- report emulation and alignment faults via perf
- add initial kernel-side support for perf_events
- small initialization fixes in the parisc firmware layer
- adjust TC* constants and avoid referencing termio structs to avoid
  userspace build errors.

----------------------------------------------------------------
Helge Deller (5):
      parisc: Report emulation faults via perf
      parisc: Report software alignment faults via perf
      parisc: Add initial kernel-side perf_event support
      parisc: Firmware: Fix returned path for PDC_MODULE_FIND on older machines
      parisc: Fix iodc and device path return values on old machines

John David Anglin (1):
      parisc: Remove spurious if statement from raw_copy_from_user()

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

 arch/parisc/Kconfig                      |  3 ++
 arch/parisc/include/asm/perf_event.h     |  8 +++-
 arch/parisc/include/uapi/asm/ioctls.h    |  8 ++--
 arch/parisc/include/uapi/asm/perf_regs.h | 63 ++++++++++++++++++++++++++++++++
 arch/parisc/kernel/Makefile              |  1 +
 arch/parisc/kernel/drivers.c             |  6 +++
 arch/parisc/kernel/firmware.c            |  3 +-
 arch/parisc/kernel/perf_event.c          | 27 ++++++++++++++
 arch/parisc/kernel/perf_regs.c           | 61 +++++++++++++++++++++++++++++++
 arch/parisc/kernel/traps.c               |  2 +
 arch/parisc/kernel/unaligned.c           |  2 +
 arch/parisc/lib/memcpy.c                 |  1 -
 12 files changed, 178 insertions(+), 7 deletions(-)
 create mode 100644 arch/parisc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/parisc/kernel/perf_event.c
 create mode 100644 arch/parisc/kernel/perf_regs.c

