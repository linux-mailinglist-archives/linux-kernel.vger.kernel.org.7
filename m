Return-Path: <linux-kernel+bounces-834117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE35BA3EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267F8384C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532202F6164;
	Fri, 26 Sep 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhSKEJau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B91E489
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893967; cv=none; b=Ty87lqAFDcTSwqlc/v+5P2r7BGQGWv5u8JoWkHQKFyo8W/m/kfpyZRIDZVZLY97kZLn//hNKYT+eCZ1qE8n0MVjeCbrLOGZn/u70qLdEkT9xi5RZAA9e+U/Y1YDNEJuqPWfJFjie+gAPjUwMyGeuLxzInMnD6IjV3qoCKyRispI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893967; c=relaxed/simple;
	bh=ZUTUEcL+htdGmpPZK3PnCcTg5DlA13V+CFJK/1AaKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q3pp7j3VB1TdXnSi4AxgbvSfHrluKZ5PpDZr8vslX0ha886AB3U48h9c0sI2WsPETXcRS4LvHXz1qWlXL1iJ6FfGcJeMppSZi1oaEahYvUxXs/9dUyi2uCIPbIPsqFIJRc6AQAxoZFH8Mdcvc9FTRxQRaYTNYsRFu439kjgyqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhSKEJau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56CCC4CEF4;
	Fri, 26 Sep 2025 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758893967;
	bh=ZUTUEcL+htdGmpPZK3PnCcTg5DlA13V+CFJK/1AaKMo=;
	h=Date:From:To:Cc:Subject:From;
	b=bhSKEJauyxS+u963iSsGPZfo3mkvg90TzD0he7BmsSSuPKQSTqHnDlAumuDfCljir
	 FLSQNmIqVrqqjnSSwN7UiiEk0S3bCj4GrwdS0Rt+srbX9OJO+mnDi2IgZu4s0kxyn6
	 NZRPElSd44/ZB0UhpqbMJVV2WwYjAnSvp1QgdVo84aSwfr4sM2/xbliTHM5onPtxRQ
	 JvEjHc/z/BDuKeKDTQgx95nQElpJtcCFyGaHu1n86Qve80fWbzpdLIPg4AAPKwKL67
	 oKMnro94391bEM6xOGRLCYYs9WeGKXCrTEBlbi4/zyeEa0wOXqY5+uW/KBe0lpP6oc
	 S3MyhS83HTGXQ==
Date: Fri, 26 Sep 2025 15:39:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/urgent fix
Message-ID: <aNaXicdHkJpTu6-P@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest core/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-09-26

   # HEAD: e2ffa15b9baa447e444d654ffd47123ba6443ae4 kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17

Fix a CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y bug on older Clang versions.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17


 init/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index e3eb63eadc87..ecddb94db8dc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
 config CC_HAS_ASM_GOTO_OUTPUT
 	def_bool y
 	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
+	# Detect basic support
 	depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
+	# Detect clang (< v17) scoped label issues
+	depends on $(success,echo 'void b(void **);void* c(void);int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b)))=c();{asm goto("jmp %l0"::::l1);return 2;l1:return 3;}}' | $(CC) -x c - -c -o /dev/null)
 
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	depends on CC_HAS_ASM_GOTO_OUTPUT

