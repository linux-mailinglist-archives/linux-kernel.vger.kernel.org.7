Return-Path: <linux-kernel+bounces-841262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B494BB6A99
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771133ACDD1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDD2EDD76;
	Fri,  3 Oct 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byEA+8fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D51448E0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494634; cv=none; b=bxIZygngbNGcr7yyzVkECEbppJMxGxnObxLGq+XTzUmJXpfkcL+ZP1azsV4zYLCshWxCUfj29Q68lIbz9mxkIWKXuGCsISLLHMcZ+R5W1Ejreh/J73W4AMlyeJa2/M0oNK3U65y78HOa4o/UKh4CU2agw+rkPiTqZkB/ApjeEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494634; c=relaxed/simple;
	bh=3FZr+Y1VvLm81Wm7xBrPXgryVeF31ukjEzdZyQgX1D0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PsokFlxlxR6tDj6fqmm0UQnyrd+1nKqyY+u+EUuqe6r8WfssC2pPgwG9c6vlg2Ako8Lb6wxUdqdi+XVhmFQCqMbIaOieEjRlImaHLlE5OrTaBIag9VhziVVUQtYZHWlh3OVcsEVNkkPIJGuGskYxMO6G/eLLuQ9c41esom3qz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byEA+8fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E1AC4CEFA;
	Fri,  3 Oct 2025 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759494632;
	bh=3FZr+Y1VvLm81Wm7xBrPXgryVeF31ukjEzdZyQgX1D0=;
	h=Date:From:To:Cc:Subject:From;
	b=byEA+8fbLFYtxVNysji1C2dkqgDa8/6YzF71vC44WK7RMzJcsC1McokZaWRGauz+A
	 qR92EPYt+6tL1xmBdeJUMS/2DZMT5F7xFVqmT4NqnaqgLw9L0tgnxzCIggjh8sMxPY
	 Sh2i3PU5geo/R/ufm/2NsFZhVryULLUo/M9KN8G/4G0VzzTZwbvFTwRghkW2qNTN+z
	 sZ65pwKSIQ4SnTCEiBm8huJn/FJ/AKAl5+c1lGFf6TpFV1yU/696SXfZUqkH/Eo3ET
	 7BT4Y9fb2np563moKUsUvCgF8A4M2ji6DOyUdiltmXc0idHI7/Cyg9n4VDcAiNYouF
	 ysYA1bB11vPCw==
Date: Fri, 3 Oct 2025 13:30:28 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: [GIT PULL] kgdb changes for v6.18
Message-ID: <aN_B5NanyUEXsLxo@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.18-rc1

for you to fetch changes up to fdbdd0ccb30af18d3b29e714ac8d5ab6163279e0:

  kdb: remove redundant check for scancode 0xe0 (2025-09-20 21:19:09 +0100)

----------------------------------------------------------------
kgdb patches for 6.18

A collection of small cleanups this cycle. Thorsten Blum has replaced a
number strcpy() calls with safer alternatives (fixing a pointer
aliasing bug in the process). Colin Ian King has simplified things by
removing some unreachable code.

Signed-off-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

----------------------------------------------------------------
Colin Ian King (1):
      kdb: remove redundant check for scancode 0xe0

Thorsten Blum (5):
      kernel: debug: gdbstub: Replace deprecated strcpy() with strscpy()
      kdb: Replace deprecated strcpy() with memcpy() in kdb_strdup()
      kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
      kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
      kdb: Replace deprecated strcpy() with helper function in kdb_defcmd()

 kernel/debug/gdbstub.c          | 29 +++++++++++++++--------------
 kernel/debug/kdb/kdb_io.c       | 14 ++++++++------
 kernel/debug/kdb/kdb_keyboard.c |  3 ---
 kernel/debug/kdb/kdb_main.c     | 14 +++-----------
 kernel/debug/kdb/kdb_private.h  |  1 +
 kernel/debug/kdb/kdb_support.c  | 35 +++++++++++++++++++++++++++++++++--
 6 files changed, 60 insertions(+), 36 deletions(-)

