Return-Path: <linux-kernel+bounces-746114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D1B1234F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FE4581BED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242142F002D;
	Fri, 25 Jul 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVTRZj27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1202EFDBD;
	Fri, 25 Jul 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466044; cv=none; b=iNrO0UCXK6xwESciz6SWGIfy0mGF+fO839iQ8VG4GjsvPaMa6p9eZXpcM0ZkIZtdkG1CmFiLhmHPpyAvH3Z8JNjoaK3jl9oJin6AppCAcFYYBIiuaS9Mkc7RJ7hRWYl34Zdv71qn3t+rTbhoQ7r0pUGY9zYjOBgQWtUGURgzsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466044; c=relaxed/simple;
	bh=2GxaTK4CkQ28Mf7+PHK9cNeBUB7/wit3MFYBmfWYlZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHXaPvg2SB1HeLP0KNiH4r9YVChZsQNAlwFNzr02tNTRY90483pBJoSiJih1wznCkiaWFHSd6PWYyeOiR0cnPCwVDhsOCxUdzq8B5f3X5SYOgAztq6En9asUUN6caj02vudmeXhSHkEesI4YLsUHicQY30W8BA7LwTWtVhpee9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVTRZj27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87052C4CEF6;
	Fri, 25 Jul 2025 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466044;
	bh=2GxaTK4CkQ28Mf7+PHK9cNeBUB7/wit3MFYBmfWYlZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVTRZj27xwrTyBvXH2pL63WDZb6qiBSf675gAW/fVsBZ7MSqNH+SdVdOhYAg13z2J
	 hDDo7i+NasQ1orROfRufXbzuA03AVfaDJwnfi/F3IkfKY+HDsVlRySJj0rol7hw3uM
	 yI2IJEWYkmE9tGGAR83e8dJBdT7QkAvLinrLnuB9FISrXpGiSB7QFX7uLa+sMRWTxQ
	 4ZM3uwIYfVWnvrGZArZrH0U/8Lbb1ZPvvSUs1lIAsbw/Ly1Mwj7Rp44OOPbfnUgxms
	 +bWCoQpkHGFHI2jnJIYD7uEuMwl96v+Xo3jgLEUxsIj/o6zaj8pAclamp6B3Vv+2y1
	 JT6uKkwey/7OQ==
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
Subject: [RFC 1/2] AI: Add unified AI coding assistant configuration
Date: Fri, 25 Jul 2025 13:53:57 -0400
Message-Id: <20250725175358.1989323-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725175358.1989323-1-sashal@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a single source of truth for AI instructions in
Documentation/AI/main.md with symlinks for all major AI coding
assistants:
- CLAUDE.md (Claude Code)
- .github/copilot-instructions.md (GitHub Copilot)
- .cursorrules (Cursor)
- .codeium/instructions.md (Codeium)
- .continue/context.md (Continue)
- .windsurfrules (Windsurf)
- Documentation/AIder.conf.yml (Aider)

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .aider.conf.yml                 | 1 +
 .codeium/instructions.md        | 1 +
 .continue/context.md            | 1 +
 .cursorrules                    | 1 +
 .github/copilot-instructions.md | 1 +
 .windsurfrules                  | 1 +
 CLAUDE.md                       | 1 +
 Documentation/AI/main.md        | 5 +++++
 8 files changed, 12 insertions(+)
 create mode 120000 .aider.conf.yml
 create mode 120000 .codeium/instructions.md
 create mode 120000 .continue/context.md
 create mode 120000 .cursorrules
 create mode 120000 .github/copilot-instructions.md
 create mode 120000 .windsurfrules
 create mode 120000 CLAUDE.md
 create mode 100644 Documentation/AI/main.md

diff --git a/.aider.conf.yml b/.aider.conf.yml
new file mode 120000
index 0000000000000..201abbf2af4de
--- /dev/null
+++ b/.aider.conf.yml
@@ -0,0 +1 @@
+Documentation/AI/main.md
\ No newline at end of file
diff --git a/.codeium/instructions.md b/.codeium/instructions.md
new file mode 120000
index 0000000000000..69274c2ad2f60
--- /dev/null
+++ b/.codeium/instructions.md
@@ -0,0 +1 @@
+../Documentation/AI/main.md
\ No newline at end of file
diff --git a/.continue/context.md b/.continue/context.md
new file mode 120000
index 0000000000000..69274c2ad2f60
--- /dev/null
+++ b/.continue/context.md
@@ -0,0 +1 @@
+../Documentation/AI/main.md
\ No newline at end of file
diff --git a/.cursorrules b/.cursorrules
new file mode 120000
index 0000000000000..201abbf2af4de
--- /dev/null
+++ b/.cursorrules
@@ -0,0 +1 @@
+Documentation/AI/main.md
\ No newline at end of file
diff --git a/.github/copilot-instructions.md b/.github/copilot-instructions.md
new file mode 120000
index 0000000000000..69274c2ad2f60
--- /dev/null
+++ b/.github/copilot-instructions.md
@@ -0,0 +1 @@
+../Documentation/AI/main.md
\ No newline at end of file
diff --git a/.windsurfrules b/.windsurfrules
new file mode 120000
index 0000000000000..201abbf2af4de
--- /dev/null
+++ b/.windsurfrules
@@ -0,0 +1 @@
+Documentation/AI/main.md
\ No newline at end of file
diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 120000
index 0000000000000..201abbf2af4de
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1 @@
+Documentation/AI/main.md
\ No newline at end of file
diff --git a/Documentation/AI/main.md b/Documentation/AI/main.md
new file mode 100644
index 0000000000000..959ba50568f57
--- /dev/null
+++ b/Documentation/AI/main.md
@@ -0,0 +1,5 @@
+# Linux Kernel Development AI Instructions
+
+This is the Linux kernel repository. When working with this codebase, you must follow the following rules:
+
+- [ TODO ]
-- 
2.39.5


