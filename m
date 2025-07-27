Return-Path: <linux-kernel+bounces-747261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4EB131A2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866B01897890
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387922A7E0;
	Sun, 27 Jul 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6IaTgi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C71221737;
	Sun, 27 Jul 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646305; cv=none; b=XT/h3SEs7ovNBBAE60ZA25+OLjLbj6qd6Yww675kdZMIm0w/dl3OCNNVRioH/e8YRBUHbZg0xXoO+py+rn8wm9Hby2kInUfZlAcmL+LiSbcWPrvC8g5W/xaNPtbk0CHQ2mlMq7pSHDqYopDbUklMZt1LKBtm6SK84r72JN4AknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646305; c=relaxed/simple;
	bh=bjWayEAh716FQw0T22n60tZUcfpnlVvoEVEBTenLoFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcGwECp2FhshqlvX6UvOm9KtsVpVqCIOxwcWD0Iss7ql6j73kVOSorGmgUbvi53IMBpRFiZ9K625wLSMC4QNfQloGlUs2ecKw/0rBr4fbGxEd2MCUQlJC8CdRgiHW1pC14/W4E+ROodYXRhyg0MGv7BT+ev2EEaCvFdFxH1y6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6IaTgi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DEBC4CEEB;
	Sun, 27 Jul 2025 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646304;
	bh=bjWayEAh716FQw0T22n60tZUcfpnlVvoEVEBTenLoFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6IaTgi++JzLAgZk6lhLqW2G2KKCOKmToowTLMUW4B/tD5JVhvgYU534FyMBgz4aQ
	 nDMsT5+z0ydR5IAvXUSOC0WqYqFBggfpgzMKguw0JtJ3XEgifnbJnOMWtYRiEAcrCP
	 vUarHCzm12kqx64+QrrKFIDGVfn46Rl+xVY2UOXTBeeIjrgsfm91ika52A40Rv38YU
	 iiMmFGC5cSou/aHcy71M8M1AY77gYowYzz3qovPwItgZMstTTMziyiQTA2SoBoJ+xO
	 sjmYWLMBUj2KCtsqdLxMd9i72vyflamLlMtdz6VG61a+pJgFdg59CHTCy65Ug/sI+8
	 CcSOUleEaJqtw==
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
Subject: [PATCH 4/4] agents: add legal requirements and agent attribution guidelines
Date: Sun, 27 Jul 2025 15:58:02 -0400
Message-Id: <20250727195802.2222764-5-sashal@kernel.org>
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

And below is the first test of this scheme:

Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/agents/index.rst |  3 ++-
 Documentation/agents/legal.rst | 42 ++++++++++++++++++++++++++++++++++
 Documentation/agents/main.rst  |  5 ++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/agents/legal.rst

diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
index 354af3f025e5..982602db3349 100644
--- a/Documentation/agents/index.rst
+++ b/Documentation/agents/index.rst
@@ -9,4 +9,5 @@ Agents
 
    main
    core
-   coding-style
\ No newline at end of file
+   coding-style
+   legal
\ No newline at end of file
diff --git a/Documentation/agents/legal.rst b/Documentation/agents/legal.rst
new file mode 100644
index 000000000000..67e6b2cdff9d
--- /dev/null
+++ b/Documentation/agents/legal.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Legal Requirements for Agents
+===============================
+
+This document outlines critical legal requirements that coding agents must follow when working with the Linux kernel codebase.
+
+Licensing Requirements
+----------------------
+
+**GPL-2.0 License**
+  The Linux kernel is licensed under GPL-2.0 only with a syscall exception. Coding agents MUST follow this licensing rule with no exceptions. Any code contributed must be compatible with this license.
+
+**SPDX License Identifiers**
+  All files must have proper SPDX license identifiers. For most kernel source files, this should be the first line of the file in the appropriate comment format:
+
+  - For C source/header files: ``// SPDX-License-Identifier: GPL-2.0``
+  - For scripts: ``# SPDX-License-Identifier: GPL-2.0``
+  - For documentation: ``.. SPDX-License-Identifier: GPL-2.0``
+
+Signed-off-by Restriction
+-------------------------
+
+Coding assistants **MUST NOT** add a ``Signed-off-by`` tag pointing to themselves. The ``Signed-off-by`` tag represents a legal certification by a human developer that they have the right to submit the code under the open source license.
+
+Only the human user running the coding assistant should add their ``Signed-off-by`` tag to commits. The agent's contribution is acknowledged through the ``Co-developed-by`` tag as described below.
+
+Agent Attribution Requirement
+-----------------------------
+
+When creating commits, coding agents **MUST** identify themselves by including the following tag in the commit message::
+
+    Co-developed-by: $AGENT_NAME $AGENT_MODEL $AGENT_VERSION
+
+Examples:
+
+- ``Co-developed-by: Claude claude-3-opus-20240229``
+- ``Co-developed-by: GitHub-Copilot GPT-4 v1.0.0``
+- ``Co-developed-by: Cursor gpt-4-turbo-2024-04-09``
+
+This transparency helps maintainers and reviewers understand that a coding agent was involved in the development process.
diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
index 8e0463794b76..9ef75978a2e6 100644
--- a/Documentation/agents/main.rst
+++ b/Documentation/agents/main.rst
@@ -15,3 +15,8 @@ Coding Style
 ------------
 
 For coding style guidelines and rules, see :doc:`coding-style`
+
+Legal Requirements
+------------------
+
+For licensing, attribution, and legal requirements, see :doc:`legal`
-- 
2.39.5


