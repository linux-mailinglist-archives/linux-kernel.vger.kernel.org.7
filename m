Return-Path: <linux-kernel+bounces-747260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B17B131A0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E02B1898477
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742E2367DA;
	Sun, 27 Jul 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5rKyL8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D02356C0;
	Sun, 27 Jul 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646303; cv=none; b=Re4MZriEgerbvbhwpgcs1Ma27RXeiRoW8Qn+UJqG8SGOT0vBA/LFx3jAFUGdVB58MotBpF/Xjj0iYyAghmSLyJ5597eI5hHxmvklPM+YGIuXeoTXlxVFAlPgbfSMcHZH1J6EH4Qsx2NC3u5mrSJ/Nk5PLv0Bq71jbmWyHOmGBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646303; c=relaxed/simple;
	bh=ixTKyJfBR0xmMaTaFtvOU7QBpVjahgLuJtscAk6EDmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8hvMCcgzoH9H4/J/mCOOFeQh9duHVbHLntm3hZNrIs6rf/GEL/LcW7A92a45G+DWqtxvc67K8ngO47D7n5v7n7Pn/88qPOcAQWDRTBoqzdJimfxOw7aHbfPQnLM7K2EmiWcVggamld8K9ntK0S7414wBcK/hcmjDuPQ6JiRSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5rKyL8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72823C4CEF8;
	Sun, 27 Jul 2025 19:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646303;
	bh=ixTKyJfBR0xmMaTaFtvOU7QBpVjahgLuJtscAk6EDmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5rKyL8aI/ol53BFcr+KPmkFF0QiTSJdmjHQTGbHtUJGgNeOePc53sIm00++RCwaG
	 StwretWahDqyOUoWREspYETQeZ4ASTxtvT/sIyTXGULyjH/E8Eu4mTCT88JXEIi7CT
	 ODFtplD/mkBHC8+H3hrErga0unE2vYkvN7bNyYSmroqv9uuIzdwuKYEBZOqarOz5Ds
	 c8GomqPcYLNQVARz3u9iY6N6hnDt7zdrCbjuhjHTasguc0pjyM79MavmQnmsl24g2N
	 QQn0DjDTvgaQhBY5CAb/gwZOQTVm7DVdWBmMj3lpfDQhvDL8Gm/q6NcKgpDXynTLkH
	 3/mRmw770Ns7A==
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
Subject: [PATCH 3/4] agents: add coding style documentation and rules
Date: Sun, 27 Jul 2025 15:58:01 -0400
Message-Id: <20250727195802.2222764-4-sashal@kernel.org>
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

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/agents/coding-style.rst | 35 +++++++++++++++++++++++++++
 Documentation/agents/index.rst        |  3 ++-
 Documentation/agents/main.rst         |  5 ++++
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/agents/coding-style.rst

diff --git a/Documentation/agents/coding-style.rst b/Documentation/agents/coding-style.rst
new file mode 100644
index 000000000000..b0332ee91e6c
--- /dev/null
+++ b/Documentation/agents/coding-style.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Linux Kernel Coding Style
+==========================
+
+Essential coding style documentation and rules for Linux kernel development.
+
+Coding Style Documentation
+--------------------------
+
+The comprehensive guide to Linux kernel coding style, covering indentation, naming conventions, functions, and more.
+
+See :ref:`Documentation/process/coding-style.rst <codingstyle>`
+
+Programming Language
+--------------------
+
+Information about the C programming language dialect used in the kernel, compiler options, and attributes.
+
+See :ref:`Documentation/process/programming-language.rst <programming_language>`
+
+Explicit Coding Rules
+---------------------
+
+The following rules must be followed when writing kernel code:
+
+**No trailing whitespaces**
+  Never leave whitespace at the end of lines. Git will warn about patches that introduce trailing whitespace.
+
+**80 character line limit**
+  The preferred limit on the length of a single line is 80 columns. Statements longer than 80 columns should be broken into sensible chunks, unless exceeding 80 columns significantly increases readability and does not hide information.
+
+**8 character tabs for indents**
+  Tabs are 8 characters, and thus indentations are also 8 characters. The kernel uses tabs for indentation, never spaces. This makes code structure clear and warns when nesting becomes too deep.
\ No newline at end of file
diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
index 2737ab62efa0..354af3f025e5 100644
--- a/Documentation/agents/index.rst
+++ b/Documentation/agents/index.rst
@@ -8,4 +8,5 @@ Agents
    :maxdepth: 1
 
    main
-   core
\ No newline at end of file
+   core
+   coding-style
\ No newline at end of file
diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
index 34f13d0b975a..8e0463794b76 100644
--- a/Documentation/agents/main.rst
+++ b/Documentation/agents/main.rst
@@ -10,3 +10,8 @@ Core Development Process
 ------------------------
 
 For essential kernel development documentation, see :doc:`core`
+
+Coding Style
+------------
+
+For coding style guidelines and rules, see :doc:`coding-style`
-- 
2.39.5


