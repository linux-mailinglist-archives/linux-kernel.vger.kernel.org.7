Return-Path: <linux-kernel+bounces-747258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B5B1319A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5237C1897761
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB322D780;
	Sun, 27 Jul 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnX8h4wt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B622ACE3;
	Sun, 27 Jul 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646299; cv=none; b=AEcc2LQRJHnshXt+VnlV4GiyR8kytcVyTdu3OOzSqjpRKyMG1/qfv8ZnTrluwz5ZuUgSJ+qbwPaqh6otb72traVEhC/1o+cC29au7trd/Fv44wa75Nwrml5rvXAIgI4AK2nPlrWLz+NyZiGNUw8JpyUqfiZXpika3rDpryUjOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646299; c=relaxed/simple;
	bh=MQriHyB3xdTvzzCtjBZYzfIZZsUp6BJ53BqMl3Lm9eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lp41iGsppBeEgwHwPl3fIS9cGqO8giajjYtj3smx1IMofQSi413qkyQZ8SFKPLEEt14ZFeZCFzIUk8XQYOgnxm8O2ivm4DnICnw9t1HUb+GL60NMIJB3+HK3vajak/WVE9P2YrlmcE0kN4Q29Bk08CJTUquRnegPjvC5nHxS6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnX8h4wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BBDC4CEF8;
	Sun, 27 Jul 2025 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646299;
	bh=MQriHyB3xdTvzzCtjBZYzfIZZsUp6BJ53BqMl3Lm9eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnX8h4wtYpvBh5aknZlvRKuTaaF8EroKcnMaINaB64nbDb6jRzDFq7z8bfl7zyH1H
	 0sziZwhkHJFJ38knsHHAGWC3ImazJFClbW5/kz6jAUusSnUMK4w+8ZHj0+Xj2vLS8S
	 HNxpdoT0srL7xDVv/Jax053nov96X0oF5nTFNyzipcPCHvextCUZYUSuwRIsjdXol1
	 5Xji1Zz/rv8WnHLm7yXjunup/Zpnxs7prgD/8y4yb8Rx7lQ2wDxrPrM1X4LMVT4gos
	 EeuB58X1lxnHcaZQKDQuOKe/n2jx/1ELwLGQvjedhKsBpOC5Ci5kkgEb5qsWm/Ec1/
	 JRxGBpX1hhQ6g==
From: Sasha Levin <sashal@kernel.org>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: sashal@kernel.org,
	josh@joshtriplett.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: [PATCH 1/4] agents: add unified agent coding assistant configuration
Date: Sun, 27 Jul 2025 15:57:59 -0400
Message-Id: <20250727195802.2222764-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727195802.2222764-1-sashal@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a single source of truth for agent instructions in
Documentation/AI/main.md with symlinks for all major coding
agents:
- CLAUDE.md (Claude Code)
- .github/copilot-instructions.md (GitHub Copilot)
- .cursorrules (Cursor)
- .codeium/instructions.md (Codeium)
- .continue/context.md (Continue)
- .windsurfrules (Windsurf)
- .aider.conf.yml (Aider)

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .aider.conf.yml                 |  1 +
 .codeium/instructions.md        |  1 +
 .continue/context.md            |  1 +
 .cursorrules                    |  1 +
 .github/copilot-instructions.md |  1 +
 .windsurfrules                  |  1 +
 CLAUDE.md                       |  1 +
 Documentation/agents/index.rst  | 10 ++++++++++
 Documentation/agents/main.rst   |  7 +++++++
 9 files changed, 24 insertions(+)
 create mode 120000 .aider.conf.yml
 create mode 120000 .codeium/instructions.md
 create mode 120000 .continue/context.md
 create mode 120000 .cursorrules
 create mode 120000 .github/copilot-instructions.md
 create mode 120000 .windsurfrules
 create mode 120000 CLAUDE.md
 create mode 100644 Documentation/agents/index.rst
 create mode 100644 Documentation/agents/main.rst

diff --git a/.aider.conf.yml b/.aider.conf.yml
new file mode 120000
index 000000000000..a5120c4e5d0a
--- /dev/null
+++ b/.aider.conf.yml
@@ -0,0 +1 @@
+Documentation/agents/main.rst
\ No newline at end of file
diff --git a/.codeium/instructions.md b/.codeium/instructions.md
new file mode 120000
index 000000000000..aa9a2063afbd
--- /dev/null
+++ b/.codeium/instructions.md
@@ -0,0 +1 @@
+../Documentation/agents/main.rst
\ No newline at end of file
diff --git a/.continue/context.md b/.continue/context.md
new file mode 120000
index 000000000000..aa9a2063afbd
--- /dev/null
+++ b/.continue/context.md
@@ -0,0 +1 @@
+../Documentation/agents/main.rst
\ No newline at end of file
diff --git a/.cursorrules b/.cursorrules
new file mode 120000
index 000000000000..a5120c4e5d0a
--- /dev/null
+++ b/.cursorrules
@@ -0,0 +1 @@
+Documentation/agents/main.rst
\ No newline at end of file
diff --git a/.github/copilot-instructions.md b/.github/copilot-instructions.md
new file mode 120000
index 000000000000..aa9a2063afbd
--- /dev/null
+++ b/.github/copilot-instructions.md
@@ -0,0 +1 @@
+../Documentation/agents/main.rst
\ No newline at end of file
diff --git a/.windsurfrules b/.windsurfrules
new file mode 120000
index 000000000000..a5120c4e5d0a
--- /dev/null
+++ b/.windsurfrules
@@ -0,0 +1 @@
+Documentation/agents/main.rst
\ No newline at end of file
diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 120000
index 000000000000..a5120c4e5d0a
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1 @@
+Documentation/agents/main.rst
\ No newline at end of file
diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
new file mode 100644
index 000000000000..109266ca91ec
--- /dev/null
+++ b/Documentation/agents/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Agents
+======
+
+.. toctree::
+   :maxdepth: 1
+
+   main
\ No newline at end of file
diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
new file mode 100644
index 000000000000..98aa8250be9d
--- /dev/null
+++ b/Documentation/agents/main.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Linux Kernel Development Agent Instructions
+=====================================
+
+This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.
-- 
2.39.5


