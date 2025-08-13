Return-Path: <linux-kernel+bounces-767318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F33B252C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B73620264
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64F3A1D2;
	Wed, 13 Aug 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOwUtetC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD72242909
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108425; cv=none; b=Aay2SXvgpUkUmSE/RQj5EmfuayWuusepsjWqHrcRRyMK+dV5w2qdXJgWTafShOKzA9tGqFTMngDP4QIiW6ItYCFynk/Pbd4Bo25ubqOyy/rLCw0UvvNKQlb0IT4Ww2KiBZqufnDN0p0FpYNVGNmh4tg+UrvssW+NvWKqohZ7Qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108425; c=relaxed/simple;
	bh=+K9KYoI/qcqMa4qi+5gllF4t7CU9GMSaqAwo+mhZGmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LCnVk8VcyqbRmfMl+WoLqOHOjBMjPZhpvT/mg+/jRANYh5GqQCCHU8HwKkbUCji6O5CSxdjBfgrVb9zn+GmpWL7VH5H1NKWWb7bzbBBkEsaxDaT//a4B5d3MU83SlB1KX2sNXy3tW7W1F+/4GcJfLKQKAZJcVneZnppAouPYHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOwUtetC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E7C4CEEB;
	Wed, 13 Aug 2025 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108424;
	bh=+K9KYoI/qcqMa4qi+5gllF4t7CU9GMSaqAwo+mhZGmw=;
	h=Date:From:To:Cc:Subject:From;
	b=QOwUtetCILxOt/fAZivXi9wD1UCcdgpxGkKxgWPIPBCrPprJY9oGmMQKp/PME2Yns
	 MKwY+pj5/CnQj78SQ1AiYQ8/D8uuwb6TcUxw6MaVLHEdUFIdTwcJBjqjSjeXu/YYsq
	 +xmr8uvqxY/Q+EjVP+Ks5oZ8joIbGS9E3sc7MELGmm21ir0YJ2wSumFe5rfk5PxX2W
	 TCbMFWreEEXOsSDKPpmnhe8AsRe3A0rPWIDzJf2DFIxnRZYXRzktipeHKCIBwbv0LB
	 QrGSTIvZiwIEC6oOPdCCKdi2fV9oBp0aCEi7ph3LwVIAy3bEv5HYRmRVnNvtWN2Ikg
	 L8tmSKYi3lmHw==
Date: Thu, 14 Aug 2025 02:06:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.17-rc2
Message-ID: <aJzUQt58S0ZEv0zn@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider those fixes for 6.17-rc2?

A few recent random fixes as shown below..

Thanks,
Gao Xiang

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes

for you to fetch changes up to 0b96d9bed324a1c1b7d02bfb9596351ef178428d:

  erofs: fix block count report when 48-bit layout is on (2025-08-11 06:31:19 +0800)

----------------------------------------------------------------
Changes since last update:

 - Align FSDAX enablement among multiple devices;

 - Fix EROFS_FS_ZIP_ACCEL build dependency again to prevent forcing
   CRYPTO{,_DEFLATE}=y even if EROFS=m.

 - Fix atomic context detection to properly launch kworkers on demand;

 - Fix block count statistics for 48-bit addressing support.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix block count report when 48-bit layout is on

Geert Uytterhoeven (1):
      erofs: Do not select tristate symbols from bool symbols

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

Yuezhang Mo (1):
      erofs: Fallback to normal access if DAX is not supported on extra device

 fs/erofs/Kconfig | 20 ++++++++++----------
 fs/erofs/super.c | 28 ++++++++++++++++------------
 fs/erofs/zdata.c | 13 +++++++++++--
 3 files changed, 37 insertions(+), 24 deletions(-)


