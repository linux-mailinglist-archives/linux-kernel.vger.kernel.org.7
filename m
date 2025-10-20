Return-Path: <linux-kernel+bounces-861715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5565BF3760
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA2218A6BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4632DBF69;
	Mon, 20 Oct 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWrWf6NF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2E2E0408
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992433; cv=none; b=hf4YyY7BYjf6IPPN/sWpoU0c/WkjPcGRQdIBx81uc9ANgOVPuZHvx/BRYwsW5zAiy3k+FKW/n1/8cJv7j/1Cwxo0gtRqk84q1Jr+Ng9Z+zNlwYOPYjA4okpNAGwuX9yJZCX81OLQbSlMcyY6It1Yw2TSJDfcU0iw3dZQsCH9lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992433; c=relaxed/simple;
	bh=a4d4tRclkn02MT8DIZGp0p5K57wmvTmC6iic9goZpEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghm+4TQoIsBDRPC41EpT00NTNXI1V/vm2h4jYcg+746erH9UPrAWRyWI4+K3FnT9ezEcLdCL2ibZMqYLSyNRXZI2UgZHlm/ONWrT5XcxRF/M+CV4UtsXIE9rUCc6esnzE8qi/QowHg+/BFKd32x/t0K1ROEMd5ZS8cBB73kftqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWrWf6NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09CBC113D0;
	Mon, 20 Oct 2025 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992433;
	bh=a4d4tRclkn02MT8DIZGp0p5K57wmvTmC6iic9goZpEg=;
	h=From:To:Cc:Subject:Date:From;
	b=dWrWf6NFh+CFXMHIJDvOY4woF4jQ6jxfwatH370YNTN6wa8vTTeyFB9CNsZDatJAu
	 dC7bcCwM/Oar7b4ouYjQWTtjrBTfuo+p8rpD6wOUrLpl2/NuX7EAFCrMfj14UZ9M5i
	 YAW2WuYuuhPOK8y5EUD2ctu2hJEXAF+I0mFWSqmg1DxRYpjUlF0ckulSzYKR4wGUpY
	 q2tazGlamKmetTSoXj1DFZ/h611IaN25sG3fYrW1PvAAfk2tS8N5fgAQpmRoIezOIA
	 oTnbdEd3SAx/bgegU17evnHUT2QEEBP2b6de7DhUYKrkq+L/mY0aQtDgwRZdap4zbE
	 hlWit9j92o4pQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH] perf build: Fix perf build issues with fixdep
Date: Mon, 20 Oct 2025 13:33:15 -0700
Message-ID: <8881bc3321bd9fa58802e4f36286eefe3667806b.1760992391.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a808a2b35f66 ("tools build: Fix fixdep dependencies") broke the
perf build ("make -C tools/perf") by introducing two inadvertent
conflicts:

  1) tools/build/Makefile includes tools/build/Makefile.include, which
     defines a phony 'fixdep' target.  This conflicts with the $(FIXDEP)
     file target in tools/build/Makefile when OUTPUT is empty, causing
     make to report duplicate recipes for the same target.

  2) The FIXDEP variable in tools/build/Makefile conflicts with the
     previously existing one in tools/perf/Makefile.perf.

Remove the unnecessary include of tools/build/Makefile.include from
tools/build/Makefile, and rename the FIXDEP variable in
tools/perf/Makefile.perf to FIXDEP_BUILT.

Fixes: a808a2b35f66 ("tools build: Fix fixdep dependencies")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/build/Makefile     | 2 --
 tools/perf/Makefile.perf | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index a5b3c29b8d70c..3a5a3808ab2a1 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -37,8 +37,6 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
 endif
 
-include $(srctree)/tools/build/Makefile.include
-
 FIXDEP		:= $(OUTPUT)fixdep
 FIXDEP_IN	:= $(OUTPUT)fixdep-in.o
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef2..02f87c49801fc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -234,12 +234,12 @@ endif
 # The fixdep build - we force fixdep tool to be built as
 # the first target in the separate make session not to be
 # disturbed by any parallel make jobs. Once fixdep is done
-# we issue the requested build with FIXDEP=1 variable.
+# we issue the requested build with FIXDEP_BUILT=1 variable.
 #
 # The fixdep build is disabled for $(NON_CONFIG_TARGETS)
 # targets, because it's not necessary.
 
-ifdef FIXDEP
+ifdef FIXDEP_BUILT
   force_fixdep := 0
 else
   force_fixdep := $(config)
@@ -286,7 +286,7 @@ $(goals) all: sub-make
 
 sub-make: fixdep
 	@./check-headers.sh
-	$(Q)$(MAKE) FIXDEP=1 -f Makefile.perf $(goals)
+	$(Q)$(MAKE) FIXDEP_BUILT=1 -f Makefile.perf $(goals)
 
 else # force_fixdep
 
-- 
2.51.0


