Return-Path: <linux-kernel+bounces-746113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C9B1234D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388031CE2EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEB2EFDB6;
	Fri, 25 Jul 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITpUD1xS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D102EFDA7;
	Fri, 25 Jul 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466042; cv=none; b=nkXYZrYzbpe1AfRLkj9vNDdI/PNcdeNhKusmtzS0Jl4Slzdi0/jF39TPM+gVQRRe7eHLUHckgXURV1amhXCPmd2RcJyFu7n8n5LipdYQQSIB2w46lbfs44XFtypjxe+kCtALHiIHyBJ/ee0IVtHuMs9whdJR5iHNxb0DEPHocL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466042; c=relaxed/simple;
	bh=aNHTPcPmJgTe6jlcMuYedphKpF139DO8jV3SXEgqtRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rGymVvVELHO9KbthwuXQxxS8Z6UVnvniIBfSDgZERbvHa5PsaTWYwPV5hFZO+tqizSRDnnhG6/ALTduRjhP+7siDGC1811t3SKMiVnxgZopguWXkmRRH32qugKv5eym8MObEsJqro869yOQaQuK17kIxGs4sTFKtq9bYw9pJ5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITpUD1xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B204FC4CEE7;
	Fri, 25 Jul 2025 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466042;
	bh=aNHTPcPmJgTe6jlcMuYedphKpF139DO8jV3SXEgqtRE=;
	h=From:To:Cc:Subject:Date:From;
	b=ITpUD1xS7m9scpB3DouFV8OZPwR+tZfpNHAwRIbkzdpyShaUrC5ilLE52zT5SEO/S
	 Nc+Vzc1Q56IGmqeXofIifnHmS8+TNfM8j3+aWDgHHE/pfkSAZR9NlTLK7BSf9UqQE8
	 G90LKTfo96V5iwpJ5v7AMzE13/1a9HsGVa/VUW6At4v+sGdU3BHU8tKV+H9YWQrEp5
	 X1s19oU8mgWZP2lAwG+IaYwR4R5TFeQ/7G+kenhg+rZUWP9PA26okPBmZS/cCY3S/v
	 TDPdP/8YnssarUFdO0g6DgYHwjiOzHw8pq0XM9d/ghq1xURbBIhx+PVfmDMVMOJP2e
	 sRt0B5kLKMlpQ==
From: Sasha Levin <sashal@kernel.org>
To: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	corbet@lwn.net,
	josh@joshtriplett.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Date: Fri, 25 Jul 2025 13:53:56 -0400
Message-Id: <20250725175358.1989323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds unified configuration and documentation for AI
coding assistants working with the Linux kernel codebase. As AI tools
become increasingly common in software development, it's important to
establish clear guidelines for their use in kernel development.

The series consists of two patches:

1. The first patch adds unified configuration files for various AI
coding assistants (Claude, GitHub Copilot, Cursor, Codeium, Continue,
Windsurf, and Aider). These are all symlinked to a central documentation
file to ensure consistency across tools.

2. The second patch adds the actual rules and documentation that guide
AI assistants on Linux kernel development practices, including:
   - Following kernel coding standards
   - Respecting the development process
   - Properly attributing AI-generated contributions
   - Understanding licensing requirements

The examples below demonstrate how these guidelines work in practice, showing
proper AI attribution in commits and the assistant's understanding of kernel
documentation requirements.

All AI assistants are required to identify themselves in commits using
Co-developed-by tags, ensuring full transparency about AI involvement in
code development.

"Hello world" test:

	$ claude -p "do you need to attribute your commits?"
	Yes, according to the CLAUDE.md file in this Linux kernel repository, I must identify myself as an AI assistant in commits by including:

	```
	Co-developed-by: Claude claude-opus-4-20250514
	```

	I should NOT add a Signed-off-by tag - only you (the human developer) should add that, as it represents a legal certification.


Example patch creation with Claude Code:

	$ claude -p "Fix the dont -> don't typo in @Documentation/power/opp.rst. Commit the result"
	Done! The typo has been fixed and committed.


And the resulting patch (no manual edits):

	From 7613561f430920803d945b3cd53aa81440d4f6f0 Mon Sep 17 00:00:00 2001
	From: Sasha Levin <sashal@kernel.org>
	Date: Fri, 25 Jul 2025 13:38:43 -0400
	Subject: [PATCH] Documentation: power: opp: Fix typo dont -> don't

	Fix a typo in the OPP documentation where "dont" was missing an apostrophe.

	Co-developed-by: Claude claude-opus-4-20250514
	---
	 Documentation/power/opp.rst | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
	index 1b7f1d854f14a..3eae4b955a63b 100644
	--- a/Documentation/power/opp.rst
	+++ b/Documentation/power/opp.rst
	@@ -149,7 +149,7 @@ dev_pm_opp_find_freq_exact

	         opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
	         dev_pm_opp_put(opp);
	-        /* dont operate on the pointer.. just do a sanity check.. */
	+        /* don't operate on the pointer.. just do a sanity check.. */
	         if (IS_ERR(opp)) {
	                pr_err("frequency not disabled!\n");
	                /* trigger appropriate actions.. */


Sasha Levin (2):
  AI: Add unified AI coding assistant configuration
  AI: Add initial set of rules and docs

 .aider.conf.yml                 |  1 +
 .codeium/instructions.md        |  1 +
 .continue/context.md            |  1 +
 .cursorrules                    |  1 +
 .github/copilot-instructions.md |  1 +
 .windsurfrules                  |  1 +
 CLAUDE.md                       |  1 +
 Documentation/AI/main.md        | 71 +++++++++++++++++++++++++++++++++
 8 files changed, 78 insertions(+)
 create mode 120000 .aider.conf.yml
 create mode 120000 .codeium/instructions.md
 create mode 120000 .continue/context.md
 create mode 120000 .cursorrules
 create mode 120000 .github/copilot-instructions.md
 create mode 120000 .windsurfrules
 create mode 120000 CLAUDE.md
 create mode 100644 Documentation/AI/main.md

-- 
2.39.5


