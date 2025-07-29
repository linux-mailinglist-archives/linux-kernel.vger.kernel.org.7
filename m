Return-Path: <linux-kernel+bounces-749024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00DB14901
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307F93AB150
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB21261586;
	Tue, 29 Jul 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VON8cTXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555121CA0C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773396; cv=none; b=tewTu2ium1VqMvRpX5FZyHqXl6JJs+EhUxGdvE5cUw5xKxyCkavFadzih5E/5FrBF97eP3a8jbzrteoz7iGqPaTZC53YZodKPDa7/HaXFjke+oBvMzbPbbwKaSzoCak/fICLjZTzsLYVjzjrdVTPmHSCR+/K6+uh32hbvieF9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773396; c=relaxed/simple;
	bh=3Ztp8YVllXJki+zlS86d8YKpLzJo+yhrr9eH5X7xVLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPLFvJn3Fqq4rpapAjSJo3CnWnirIstVIRcx2ouxr3vXl9awL9Ul2BsbDgWGHwNC+W6u26I3a26olrDc5qu5io8RV+aaQtvwCIwsdVoIk4VB4OeeElq9eYcOLz0y0tEFE8GBBswT0R32LBfbSPSf8j/OJlun3m8ORudl5vtONmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VON8cTXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971A3C4CEEF;
	Tue, 29 Jul 2025 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753773395;
	bh=3Ztp8YVllXJki+zlS86d8YKpLzJo+yhrr9eH5X7xVLY=;
	h=Date:From:To:Cc:Subject:From;
	b=VON8cTXrDcvRKlkBLQmOPrN+pUYzYsmTksxF+Dzu0EniaPk61wnuw04OuapnRjhJ3
	 q0Kl6J6HOzVh3MeXYbxMtLnTKNHAUyLiMMjbU8AJgoaAqcqj99Wtuk/TVnPgcvxZfa
	 ngZPflgcqplPBw1uuPo1yL9RCKxsMkj/AqR9Y+UHbDIPHkqNhFcLrlur3roON+d0bU
	 KB8kQtHp0I3xC2Lxi4gTAl+5cCJ2eYIexk/42LLgj9+2quxxUz+5YVmq8GO8EkIF0p
	 7lOYY8DmKH+ni9OyLkeWy8RFCJ+GysuNIXdBuB521CYKaTfAEo3Ln6tpQ8di/JhA+E
	 gJj8X8PLAhmKA==
Date: Tue, 29 Jul 2025 09:16:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/kconfig changes for v6.17
Message-ID: <aIh1UCUUn5vcb1Pj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/kconfig Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kconfig-2025-07-29

   # HEAD: 9df5e79bf1a30b94dc068ab2ed2279e40f430b88 x86/tools: insn_sanity.c: Emit standard build success messages

x86/kconfig changes for v6.17:

 - Emit standard build success messages in insn_sanity.c
   and insn_decoder_test.c. (Ingo Molnar)

 - Refresh the x86-[64|32] defconfigs mechanically (Ingo Molnar)

 Thanks,

	Ingo

------------------>
Ingo Molnar (4):
      x86/kconfig/64: Refresh defconfig
      x86/kconfig/32: Refresh defconfig
      x86/tools: insn_decoder_test.c: Emit standard build success messages
      x86/tools: insn_sanity.c: Emit standard build success messages


 arch/x86/configs/i386_defconfig    | 19 +++----------------
 arch/x86/configs/x86_64_defconfig  |  9 +--------
 arch/x86/tools/insn_decoder_test.c |  2 +-
 arch/x86/tools/insn_sanity.c       |  4 ++--
 4 files changed, 7 insertions(+), 27 deletions(-)

