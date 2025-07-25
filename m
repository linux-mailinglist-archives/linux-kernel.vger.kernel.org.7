Return-Path: <linux-kernel+bounces-746115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA41B12351
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8712C4E55F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10542F0C43;
	Fri, 25 Jul 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q40H8KeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FD2F004C;
	Fri, 25 Jul 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466046; cv=none; b=Eys65pJnD8rbbuYR+6pq7NITz9i03caHvbySzsIpt8PQAEq/ApKddZ6tnCpYkVypHmAtpp5ZkypOkHdLTXwcfEDvJvBCJe9EEJYUB40tXj1P54lBkM8h1fkXetwiQiwBXqoArNsyo/Mvvy8tUSpdzUychedTHLyc21HYlp21ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466046; c=relaxed/simple;
	bh=liC6C/J/3NYBxHI06Lg4QrAJb0NLB7vWMUEckM80cAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9ASfrxfMWC2I3klrss1444movpwNu8pzKbzvYBjPKqNog65R7iLDxGJ/Dw6aZ/dagdxtwMa13Q1wZC+XszRMohxLDe1LKkc+7wxJ0qBiRgeqHs06LK+V/wYzn9HgMYE01J0InI139bQh45t45IkqJxz2wGXiKZdKCR9Rq+k7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q40H8KeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5043CC4CEE7;
	Fri, 25 Jul 2025 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466045;
	bh=liC6C/J/3NYBxHI06Lg4QrAJb0NLB7vWMUEckM80cAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q40H8KeTwHKCj+xC8FzyAiGZLKTLlQDogUyLwXYIVZadLOugd9decxLS9EcfE2Mug
	 xH2v4NyjJwjensz7Y3XYm7YrzQ0sA5GLecy2wZNUtLxda9Dg4vKP/J2goLLD3s+ZaW
	 xsMTTy5G3fhBU974gU6j6MNEpCzeSSiZU7/r/Yh6XVMVqksb00a5K3NSup8zoUlrDT
	 hy3OfyFK0IVv3P6JttcN0pOCEdtJHGJtLMW/XuPbKgYQqnKm4oifn0Je5W3u3g74/A
	 HX2Fv45I7t2kQp8PkaafrYRzuFEp6akLcrN0nzFGtXRAlT/prOyFqg0enebxGXS9iV
	 T/vkri8WMC34Q==
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
Subject: [RFC 2/2] AI: Add initial set of rules and docs
Date: Fri, 25 Jul 2025 13:53:58 -0400
Message-Id: <20250725175358.1989323-3-sashal@kernel.org>
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

Add rules based on our existing documentation.

Require AI to identify itself in the commit message.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/AI/main.md | 70 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/AI/main.md b/Documentation/AI/main.md
index 959ba50568f57..ca59e52f54445 100644
--- a/Documentation/AI/main.md
+++ b/Documentation/AI/main.md
@@ -1,5 +1,71 @@
 # Linux Kernel Development AI Instructions
 
-This is the Linux kernel repository. When working with this codebase, you must follow the following rules:
+This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.
 
-- [ TODO ]
+## Essential Documentation References
+
+### Core Development Process
+- **Documentation/process/howto.rst** - Start here! The comprehensive guide on how to become a Linux kernel developer
+- **Documentation/process/development-process.rst** - Detailed information on how the kernel development process works
+- **Documentation/process/submitting-patches.rst** - Essential guide for getting your code into the kernel
+- **Documentation/process/submit-checklist.rst** - Checklist to review before submitting code
+
+### Coding Standards and Style
+- **Documentation/process/coding-style.rst** - Linux kernel coding style (MUST READ)
+  - Use tabs (8 characters) for indentation
+  - 80-character line limit preferred
+  - Specific formatting rules for switch statements, functions, etc.
+- **Documentation/process/programming-language.rst** - Language requirements and standards
+
+### What NOT to Do
+- **Documentation/process/deprecated.rst** - Deprecated interfaces and features to avoid
+  - Do not use BUG() or BUG_ON() - use WARN() instead
+  - Avoid deprecated APIs listed in this document
+- **Documentation/process/volatile-considered-harmful.rst** - Why volatile is usually wrong
+
+### Patch Submission Process
+- **Documentation/process/5.Posting.rst** - How to post patches properly
+- **Documentation/process/email-clients.rst** - Email client configuration for patches
+- **Documentation/process/applying-patches.rst** - How patches are applied
+
+### Legal and Licensing
+- **Documentation/process/license-rules.rst** - Linux kernel licensing rules
+  - Kernel is GPL-2.0 only with syscall exception
+  - All files must have proper SPDX license identifiers
+
+### Specialized Topics
+- **Documentation/process/adding-syscalls.rst** - How to add new system calls
+- **Documentation/process/stable-kernel-rules.rst** - Rules for stable kernel patches
+- **Documentation/process/security-bugs.rst** - Handling security issues
+- **Documentation/process/handling-regressions.rst** - Dealing with regressions
+
+### Maintainer Guidelines
+- **Documentation/process/maintainers.rst** - Working with subsystem maintainers
+- **Documentation/process/maintainer-handbooks.rst** - Subsystem-specific guidelines
+
+## Key Principles
+1. Read and follow the documentation before making changes
+2. Respect the existing code style and conventions
+3. Test thoroughly before submitting
+4. Write clear, descriptive commit messages
+5. Never break userspace (the #1 rule)
+6. Identify yourself as AI in commits (see below)
+
+## AI Attribution Requirement
+When creating commits, you MUST identify yourself as an AI assistant by including the following tag in the commit message:
+
+```
+Co-developed-by: $AI_NAME $AI_MODEL $AI_VERSION
+```
+
+For example:
+- `Co-developed-by: Claude claude-3-opus-20240229`
+- `Co-developed-by: GitHub-Copilot GPT-4 v1.0.0`
+- `Co-developed-by: Cursor gpt-4-turbo-2024-04-09`
+
+This transparency helps maintainers and reviewers understand that AI was involved in the development process.
+
+### Signed-off-by Restrictions
+AI assistants MUST NOT add a Signed-off-by tag pointing to themselves. The Signed-off-by tag represents a legal certification by a human developer that they have the right to submit the code under the open source license. 
+
+Only the human user running the AI assistant should add their Signed-off-by tag to commits. The AI's contribution is acknowledged through the Co-developed-by tag as described above.
-- 
2.39.5


