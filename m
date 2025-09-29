Return-Path: <linux-kernel+bounces-836710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61997BAA679
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C83A8E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF123D7E9;
	Mon, 29 Sep 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRdeHsND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA19217736
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172738; cv=none; b=g5Cr6SheltXpQYhtxD6xk9hfuO5IVx/PV2FGr450ak64n5x6IJYullL8FhjPOzwwHGRJMSBS7HNt5EigBIdpAtecSUDqM3NkiHy76Yj/AXRpuf5vpHUyMTVe1yMF6Z+0XCGFK8ORXwJaJPtD8yQSVFQ5x2A0TdKZlSeNHoRY7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172738; c=relaxed/simple;
	bh=7dAHzaJQ6VmNHtkX0SwUOUq+IGCkupBlWo61y0sreic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H08T5jSkXHJcs/9E0abZet8NanxydRXHrFRXRVrdkX8qi5fEPMp0XfUMuhXuN6RpfFHTO/OmejpzeAsB5doneJz6NXz3XA1B3WQOdk0KIyE+rCUlaqAHZbnHJ4fuvcIMIk1qMuB3o9XKuZCuom17ELBEONc8jo6Jl/f02TcqLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRdeHsND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDFFC4CEF4;
	Mon, 29 Sep 2025 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172737;
	bh=7dAHzaJQ6VmNHtkX0SwUOUq+IGCkupBlWo61y0sreic=;
	h=Date:From:To:Cc:Subject:From;
	b=eRdeHsNDf9JujZo1zCiq6S0T9QrzBgeUfb+2UywsKB+bnuBuMRJOediqUplOLiPpa
	 mzJS/aRIKZVuJPCJa0kwFfSuJ+mkHZbEMCJl+yelqKd6WoaY18PnWDdAuVCP0vbdFg
	 hLJeBJTjpAm4DEDw1RF4VAu5+ZVRhWrxBzvId7dQygWCofyf8CaNw0kFOE1TMGxgIP
	 YYjBkhznkO4I5M1laXRN16/tQaKzf1f5CKcQvv4dWfzNlJ17tc2Vx4v2jMhf8/oMBw
	 It94Gk1LUM1OmGA9v4S19vTx9W06e0qug+hHhQSPhYRsWn8cfXGw449KOerh9MMRqi
	 vnCqwaYHimGDg==
Date: Mon, 29 Sep 2025 12:05:37 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Svetlana Parfenova <svetlana.parfenova@syntacore.com>,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [GIT PULL] execve updates for v6.18-rc1
Message-ID: <202509291204.89F951B4@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these handful of execve updates for v6.18-rc1.

Thanks!

-Kees

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.18-rc1

for you to fetch changes up to 8c94db0ae97c72c253a615f990bd466b456e94f6:

  binfmt_elf: preserve original ELF e_flags for core dumps (2025-09-03 20:49:32 -0700)

----------------------------------------------------------------
execve updates for v6.18-rc1

- binfmt_elf: preserve original ELF e_flags for core dumps (Svetlana
  Parfenova)

- exec: Fix incorrect type for ret (Xichao Zhao)

- binfmt_elf: Replace offsetof() with struct_size() in fill_note_info()
  (Xichao Zhao)

----------------------------------------------------------------
Svetlana Parfenova (1):
      binfmt_elf: preserve original ELF e_flags for core dumps

Xichao Zhao (2):
      exec: Fix incorrect type for ret
      binfmt_elf: Replace offsetof() with struct_size() in fill_note_info()

 arch/riscv/Kconfig       |  1 +
 fs/Kconfig.binfmt        |  9 +++++++++
 include/linux/mm_types.h |  5 +++++
 fs/binfmt_elf.c          | 48 +++++++++++++++++++++++++++++++++++++-----------
 fs/exec.c                |  2 +-
 5 files changed, 53 insertions(+), 12 deletions(-)

-- 
Kees Cook

