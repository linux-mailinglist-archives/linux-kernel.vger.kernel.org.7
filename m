Return-Path: <linux-kernel+bounces-761287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C7B1F73D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22217B027E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484F2798F3;
	Sat,  9 Aug 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVv85DvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5A26E714;
	Sat,  9 Aug 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754782822; cv=none; b=T+TTysOAYF4jl+3wKJGchktRHQm3R6/MnQk7qXVRkDNCbjYADWOLXb0a+7ssqmIrpo5njq5AgmR51hOv/npReagcXXqZppNFONh1RvFb+oCuYI/9PprzD6z0o690ZsuswJK4Tlf871mjBeiT8qsLhZmOMDiEC3B3A7c2gqdiZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754782822; c=relaxed/simple;
	bh=S5zAZtmbm67QewM7TBsdSnpKk0Z73TNVvpADSo0YZl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTJiRgQrA+hgwFysmB9LJmuASvYVyiSyYyucbHtKFGzStG5k9MdOrRQjOHPMHNgCqYwJacwvd/8NhSnHCGXk7PWof3YSlxETPEJYsAiJ/VdYMrK9+lyK51HXoBJDMUG3lvuV0PF7axxS012BCEyw0U5CHJ6LGnihVjuRY9n3QRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVv85DvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC759C4CEF6;
	Sat,  9 Aug 2025 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754782822;
	bh=S5zAZtmbm67QewM7TBsdSnpKk0Z73TNVvpADSo0YZl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVv85DvRIwQb0Z8s1q6dFhCZR28yZNZ4oGeGE51oMC+1sK1OQZO4ArqWJMMYiITQ1
	 r8ca9SCK52c+o5usAl9T9I44qGByJ6qCVtipXuACsBCem6pYKx7Pt4Y7uudTE3roWt
	 kiJm6a6iVZJwuYcB51WjM368iqyw2W98YReDpWL96TFAmestBH9OLPoY2LGIYUZCFI
	 5DEZUms3L9fWVTRfzrq4S2Ln8dIirdpRMu/GmyKp6t8oeHqs5Sbs1duDNYSBvLLxXw
	 kEoaBlkckG7ZfOveuX64fpKuTcQlt+7xPk0mL9P0cHl2/UNKVMD4j05H5UlocUmU0j
	 RCSBZ8OTelLWw==
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
Subject: [PATCH v2 1/2] README: restructure with role-based documentation and guidelines
Date: Sat,  9 Aug 2025 19:40:07 -0400
Message-Id: <20250809234008.1540324-2-sashal@kernel.org>
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

Reorganize README to provide targeted documentation paths for different
user roles including developers, researchers, security experts,
maintainers, and AI coding assistants. Add quick start section and
essential docs links.

Include proper attribution requirements for AI-assisted contributions
using Assisted-by tags with agent details and tools used.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 README | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 173 insertions(+), 11 deletions(-)

diff --git a/README b/README
index fd903645e6de..251677d7cd09 100644
--- a/README
+++ b/README
@@ -1,18 +1,180 @@
 Linux kernel
 ============
 
-There are several guides for kernel developers and users. These guides can
-be rendered in a number of formats, like HTML and PDF. Please read
-Documentation/admin-guide/README.rst first.
+The Linux kernel is the core of any Linux operating system. It manages hardware,
+system resources, and provides the fundamental services for all other software.
 
-In order to build the documentation, use ``make htmldocs`` or
-``make pdfdocs``.  The formatted documentation can also be read online at:
+Quick Start
+-----------
 
-    https://www.kernel.org/doc/html/latest/
+* Report a bug: See Documentation/admin-guide/reporting-issues.rst
+* Get the latest kernel: https://kernel.org
+* Build the kernel: make defconfig && make -j$(nproc)
+* Join the community: https://lore.kernel.org/
 
-There are various text files in the Documentation/ subdirectory,
-several of them using the reStructuredText markup notation.
+Essential Documentation
+-----------------------
 
-Please read the Documentation/process/changes.rst file, as it contains the
-requirements for building and running the kernel, and information about
-the problems which may result by upgrading your kernel.
+All users should be familiar with:
+
+* Building requirements: Documentation/process/changes.rst
+* Code of Conduct: Documentation/process/code-of-conduct.rst
+* License: COPYING (GPLv2)
+
+Documentation can be built with make htmldocs or viewed online at:
+https://www.kernel.org/doc/html/latest/
+
+
+Who Are You?
+============
+
+Find your role below:
+
+* New Kernel Developer - Getting started with kernel development
+* Academic Researcher - Studying kernel internals and architecture
+* Security Expert - Hardening and vulnerability analysis
+* Backport/Maintenance Engineer - Maintaining stable kernels
+* System Administrator - Configuring and troubleshooting
+* Maintainer - Leading subsystems and reviewing patches
+* Hardware Vendor - Writing drivers for new hardware
+* Distribution Maintainer - Packaging kernels for distros
+* Agentic Coding - AI assistants working with kernel code
+
+
+For Specific Users
+==================
+
+New Kernel Developer
+--------------------
+
+Welcome! Start your kernel development journey here:
+
+* Getting Started: Documentation/process/development-process.rst
+* Your First Patch: Documentation/process/submitting-patches.rst
+* Coding Style: Documentation/process/coding-style.rst
+* Build System: Documentation/kbuild/index.rst
+* Development Tools: Documentation/dev-tools/index.rst
+* Kernel Hacking Guide: Documentation/kernel-hacking/hacking.rst
+* Core APIs: Documentation/core-api/index.rst
+
+Academic Researcher
+-------------------
+
+Explore the kernel's architecture and internals:
+
+* Researcher Guidelines: Documentation/process/researcher-guidelines.rst
+* Memory Management: Documentation/mm/index.rst
+* Scheduler: Documentation/scheduler/index.rst
+* Networking Stack: Documentation/networking/index.rst
+* Filesystems: Documentation/filesystems/index.rst
+* RCU (Read-Copy Update): Documentation/RCU/index.rst
+* Locking Primitives: Documentation/locking/index.rst
+* Power Management: Documentation/power/index.rst
+
+Security Expert
+---------------
+
+Security documentation and hardening guides:
+
+* Security Documentation: Documentation/security/index.rst
+* LSM Development: Documentation/security/lsm-development.rst
+* Self Protection: Documentation/security/self-protection.rst
+* Reporting Vulnerabilities: Documentation/process/security-bugs.rst
+* CVE Procedures: Documentation/process/cve.rst
+* Embargoed Hardware Issues: Documentation/process/embargoed-hardware-issues.rst
+* Security Features: Documentation/userspace-api/seccomp_filter.rst
+
+Backport/Maintenance Engineer
+-----------------------------
+
+Maintain and stabilize kernel versions:
+
+* Stable Kernel Rules: Documentation/process/stable-kernel-rules.rst
+* Backporting Guide: Documentation/process/backporting.rst
+* Applying Patches: Documentation/process/applying-patches.rst
+* Subsystem Profile: Documentation/maintainer/maintainer-entry-profile.rst
+* Git for Maintainers: Documentation/maintainer/configure-git.rst
+
+System Administrator
+--------------------
+
+Configure, tune, and troubleshoot Linux systems:
+
+* Admin Guide: Documentation/admin-guide/index.rst
+* Kernel Parameters: Documentation/admin-guide/kernel-parameters.rst
+* Sysctl Tuning: Documentation/admin-guide/sysctl/index.rst
+* Tracing/Debugging: Documentation/trace/index.rst
+* Performance Security: Documentation/admin-guide/perf-security.rst
+* Hardware Monitoring: Documentation/hwmon/index.rst
+
+Maintainer
+----------
+
+Lead kernel subsystems and manage contributions:
+
+* Maintainer Handbook: Documentation/maintainer/index.rst
+* Pull Requests: Documentation/maintainer/pull-requests.rst
+* Managing Patches: Documentation/maintainer/modifying-patches.rst
+* Rebasing and Merging: Documentation/maintainer/rebasing-and-merging.rst
+* Development Process: Documentation/process/maintainer-handbooks.rst
+* Maintainer Entry Profile: Documentation/maintainer/maintainer-entry-profile.rst
+* Git Configuration: Documentation/maintainer/configure-git.rst
+
+Hardware Vendor
+---------------
+
+Write drivers and support new hardware:
+
+* Driver API Guide: Documentation/driver-api/index.rst
+* Driver Model: Documentation/driver-api/driver-model/driver.rst
+* Device Drivers: Documentation/driver-api/infrastructure.rst
+* Bus Types: Documentation/driver-api/driver-model/bus.rst
+* Device Tree Bindings: Documentation/devicetree/bindings/
+* Power Management: Documentation/driver-api/pm/index.rst
+* DMA API: Documentation/core-api/dma-api.rst
+
+Distribution Maintainer
+-----------------------
+
+Package and distribute the kernel:
+
+* Stable Kernel Rules: Documentation/process/stable-kernel-rules.rst
+* ABI Documentation: Documentation/ABI/README
+* Kernel Configuration: Documentation/kbuild/kconfig.rst
+* Module Signing: Documentation/admin-guide/module-signing.rst
+* Kernel Parameters: Documentation/admin-guide/kernel-parameters.rst
+* Tainted Kernels: Documentation/admin-guide/tainted-kernels.rst
+
+Agentic Coding
+--------------
+
+Essential guidelines for AI coding assistants:
+
+* How to Do Kernel Development: Documentation/process/howto.rst
+* Coding Style: Documentation/process/coding-style.rst
+* Submitting Patches: Documentation/process/submitting-patches.rst
+* Submit Checklist: Documentation/process/submit-checklist.rst
+* Programming Language: Documentation/process/programming-language.rst
+
+Critical Requirements:
+
+* License: Use proper SPDX identifiers per
+  Documentation/process/license-rules.rst; kernel code is generally
+  GPL-2.0-only unless documented exceptions apply (see COPYING)
+* Signed-off-by: Agents MUST NOT add Signed-off-by tags
+  (Only humans can legally certify code submission rights)
+* Attribution: Agents MUST add Assisted-by tag:
+  Assisted-by: $AGENT_NAME-$AGENT_MODEL-$AGENT_VERSION $TOOL1 $TOOL2 ...
+  Examples:
+  - Assisted-by: Claude-claude-3-opus-20240229 checkpatch git-bisect
+  - Assisted-by: GitHub-Copilot-GPT-4-v1.0.0 coccinelle sparse
+
+
+Communication and Support
+=========================
+
+* Mailing Lists: https://lore.kernel.org/
+* IRC: #kernelnewbies on irc.oftc.net
+* Bugzilla: https://bugzilla.kernel.org/
+* MAINTAINERS file: Lists subsystem maintainers and mailing lists
+* Email Clients: Documentation/process/email-clients.rst
-- 
2.39.5


