Return-Path: <linux-kernel+bounces-761288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB28B1F73F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972E717CB03
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855527F003;
	Sat,  9 Aug 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENwbZQ4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00E27C150;
	Sat,  9 Aug 2025 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754782824; cv=none; b=apf+8J7gbY76r+qCmVj27+uGO2V8kxfhy71s8Q1gLUtpKFv9uJvbI2QSpWBvumN2j4fc2bMPru7/LeUwGhEb2vjHB85W+6Q/aZF+hNnySsCMdAXUXvCs16+8Qt1PbTVnefOjH6V25cEobKlzfxeVMcSAQy9z9+Ca7xv6aPZqnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754782824; c=relaxed/simple;
	bh=bw07Fr1gTAdH082foLnfmefu4jiolGMa+jzOWbAyKEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7Zns1BB1xuudZ/oJSSCMit6Ijwh5dfvwayWQpD3gBuiNS0aiFOdt0PLvlJsO9kkgYy7RmsfcaC/rtvt8c2RcARdn81ctCsBc9XBVdA+o+wMZWrQOQcqnFQXpab80Vgvg87Z15WGh6brLon7ceQVIpQ8B5NMwd0V5H8nODixm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENwbZQ4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F39C4CEFA;
	Sat,  9 Aug 2025 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754782824;
	bh=bw07Fr1gTAdH082foLnfmefu4jiolGMa+jzOWbAyKEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENwbZQ4mMhukDFwUfGdqsz03TJDFBAUwmaXERI0WyXbNrJr1MEk+T5miEjymZxBRs
	 yXZ8Pn39YqzkNMZjz/1gmu4yqJXh4668P5wGtwGyqOWBwWWirwNd/YWxBZcjC1SeTD
	 4Dwz+Gv/nUhzHPCIJLDpQQcxcMmUHBoZ7w+PUEdkYfaSbIg1PW+4OkuZvJwuFG+7Ev
	 uZRAy3H60unKQMyNRGIlGNUDE2bdWF/9ofK4MMcODuNlOidlaV0CKV8V2A9IHd4wTU
	 a5CYiLUE3mr4700Z1Nf5goybay3Al2ShQFj7ZgL8qNnXdMF6UDQpzMF41cciieGUjR
	 4GDOSmkzoQGpA==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org
Cc: corbet@lwn.net,
	josh@joshtriplett.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: [PATCH v2 2/2] agents: add unified agent coding assistant configuration
Date: Sat,  9 Aug 2025 19:40:08 -0400
Message-Id: <20250809234008.1540324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809234008.1540324-1-sashal@kernel.org>
References: <20250809234008.1540324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a single source of truth for agent instructions with
symlinks for all major coding agents:
- CLAUDE.md (Claude Code)
- .github/copilot-instructions.md (GitHub Copilot)
- .cursorrules (Cursor)
- .codeium/instructions.md (Codeium)
- .continue/context.md (Continue)
- .windsurfrules (Windsurf)
- GEMINI.md (Gemini)

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .codeium/instructions.md        |  1 +
 .continue/context.md            |  1 +
 .cursorrules                    |  1 +
 .github/copilot-instructions.md |  1 +
 .gitignore                      | 10 ++++++++++
 .windsurfrules                  |  1 +
 CLAUDE.md                       |  1 +
 GEMINI.md                       |  1 +
 8 files changed, 17 insertions(+)
 create mode 100644 .codeium/instructions.md
 create mode 100644 .continue/context.md
 create mode 100644 .cursorrules
 create mode 100644 .github/copilot-instructions.md
 create mode 100644 .windsurfrules
 create mode 100644 CLAUDE.md
 create mode 100644 GEMINI.md

diff --git a/.codeium/instructions.md b/.codeium/instructions.md
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/.codeium/instructions.md
@@ -0,0 +1 @@
+@README
diff --git a/.continue/context.md b/.continue/context.md
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/.continue/context.md
@@ -0,0 +1 @@
+@README
diff --git a/.cursorrules b/.cursorrules
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/.cursorrules
@@ -0,0 +1 @@
+@README
diff --git a/.github/copilot-instructions.md b/.github/copilot-instructions.md
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/.github/copilot-instructions.md
@@ -0,0 +1 @@
+@README
diff --git a/.gitignore b/.gitignore
index bf5ee6e01cd4..f8f575ab8cf6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,3 +182,13 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# Agentic coding assistant configuration
+.aider.conf.yml
+.codeium/
+.continue/
+.cursorrules
+.github/copilot-instructions.md
+.windsurfrules
+CLAUDE.md
+GEMINI.md
diff --git a/.windsurfrules b/.windsurfrules
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/.windsurfrules
@@ -0,0 +1 @@
+@README
diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1 @@
+@README
diff --git a/GEMINI.md b/GEMINI.md
new file mode 100644
index 000000000000..8b6a7196d2b0
--- /dev/null
+++ b/GEMINI.md
@@ -0,0 +1 @@
+@README
-- 
2.39.5


