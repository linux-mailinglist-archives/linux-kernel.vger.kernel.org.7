Return-Path: <linux-kernel+bounces-751047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886BB16492
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E9B7AAC03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F52DCF46;
	Wed, 30 Jul 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzlZCk7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1F1DFD96;
	Wed, 30 Jul 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892744; cv=none; b=hJnGilyLlk2/UOA87ljJV/G4H5YlK8vWui09lpgC2va3V/1xyA0HGi3tYQNAYXDZGpJgy1/VidArA1GFbD4a1BGliOqeR+qzHfot9ZxOAG7a0oGMb9G4Jm9EPzjX+7moLLTMOlyt5Fft0kNzNRRUVNrFiNQ88X6QZpCONUGkazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892744; c=relaxed/simple;
	bh=UQeE2zjdzbOt9gppZh3hry9Bml97lFABzH2PwcilJz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLAn07KaqISYOoDLfQcJ4p9OFxqS3MYuUkz2Yno7OVSJxA78hnTQUgLIrsDIisbcidBem4SdScQGWighA5YiBMIbwC7Hn2LA1PPKnczjjCLvaSyrR4eWJge0lmvt+GY8FpdV+uEWV6QNtIIPTGxVEj48MG3+XrtSCtGIkRpTntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzlZCk7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC4AC4CEE3;
	Wed, 30 Jul 2025 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892743;
	bh=UQeE2zjdzbOt9gppZh3hry9Bml97lFABzH2PwcilJz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzlZCk7/ajeF9qnGBxfUh13bAUQxcbI2lb2iUQQFQUDnyQS+MDyBeYMrwHoYr6Q1+
	 emx3+V90rFwNiNg67cllBF1grTIPiLieyTVm6nWzgJql4xKPiuuBKG5yp2sF1QHoZc
	 uChTbKQ78gMELP8KH4Q1AkT6nR4Gl72TQJp7z45X7n2Zv7wKBciPVq99OoQKXaTX+w
	 HRWITUYVIhIHs0qgf+UawXErGoavGrbFdrtKqafm5rUqY9ipqBix0Tj0tiGRF+8Gif
	 jc8yr7IQpZlOR4/VH4NFyKjZp7wkbfI+xqrzNG7sJ93uKPVcMZ41lPxNrJ+l/vps6j
	 BtVco7Igkb74A==
Date: Wed, 30 Jul 2025 12:25:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIpHhR8AhPJZE2Rp@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
 <202507272203.BECE244@keescook>
 <aIcRzndNUdh-9R18@lappy>
 <202507272310.FCB96F5E93@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507272310.FCB96F5E93@keescook>

On Sun, Jul 27, 2025 at 11:18:14PM -0700, Kees Cook wrote:
>I think the above list is perfect contents for the README. Yes, please
>make that an entry point, or point to some other .rst entry point that
>will have a list of roles like that, with some common starting points.
>And yes, a line for agents in there seems fine. Maybe "If you are a
>coding agent, also see ... for agent-specific details."

What about something like below for README:

Linux kernel
============

The Linux kernel is the core of any Linux operating system. It manages hardware,
system resources, and provides the fundamental services for all other software.

Quick Start
-----------

* Report a bug: See Documentation/admin-guide/reporting-issues.rst
* Get the latest kernel: https://kernel.org
* Build the kernel: make defconfig && make -j$(nproc)
* Join the community: https://lore.kernel.org/

Essential Documentation
-----------------------

All users should be familiar with:

* Code of Conduct: Documentation/process/code-of-conduct.rst
* License: COPYING (GPLv2)

Documentation can be built with make htmldocs or viewed online at:
https://www.kernel.org/doc/html/latest/


Who Are You?
============

Find your role below:

* New Kernel Developer - Getting started with kernel development
* Academic Researcher - Studying kernel internals and architecture
* Security Expert - Hardening and vulnerability analysis
* Backport/Maintenance Engineer - Maintaining stable kernels
* System Administrator - Configuring and troubleshooting
* Maintainer - Leading subsystems and reviewing patches
* Hardware Vendor - Writing drivers for new hardware
* Distribution Maintainer - Packaging kernels for distros
* Agentic Coding - AI assistants working with kernel code


For Specific Users
==================

New Kernel Developer
--------------------

Welcome! Start your kernel development journey here:

* Getting Started: Documentation/process/development-process.rst
* Your First Patch: Documentation/process/submitting-patches.rst
* Coding Style: Documentation/process/coding-style.rst
* Build System: Documentation/kbuild/index.rst
* Development Tools: Documentation/dev-tools/index.rst
* Kernel Hacking Guide: Documentation/kernel-hacking/hacking.rst
* Core APIs: Documentation/core-api/index.rst

Academic Researcher
-------------------

Explore the kernel's architecture and internals:

* Researcher Guidelines: Documentation/process/researcher-guidelines.rst
* Memory Management: Documentation/mm/index.rst
* Scheduler: Documentation/scheduler/index.rst
* Networking Stack: Documentation/networking/index.rst
* Filesystems: Documentation/filesystems/index.rst
* RCU (Read-Copy Update): Documentation/RCU/index.rst
* Locking Primitives: Documentation/locking/index.rst
* Power Management: Documentation/power/index.rst

Security Expert
---------------

Security documentation and hardening guides:

* Security Documentation: Documentation/security/index.rst
* LSM Development: Documentation/security/lsm-development.rst
* Self Protection: Documentation/security/self-protection.rst
* Reporting Vulnerabilities: Documentation/process/security-bugs.rst
* CVE Procedures: Documentation/process/cve.rst
* Embargoed Hardware Issues: Documentation/process/embargoed-hardware-issues.rst
* Security Features: Documentation/features/seccomp/index.rst

Backport/Maintenance Engineer
-----------------------------

Maintain and stabilize kernel versions:

* Stable Kernel Rules: Documentation/process/stable-kernel-rules.rst
* Backporting Guide: Documentation/process/backporting.rst
* Applying Patches: Documentation/process/applying-patches.rst
* Subsystem Profile: Documentation/maintainer/maintainer-entry-profile.rst
* Git for Maintainers: Documentation/maintainer/configure-git.rst

System Administrator
--------------------

Configure, tune, and troubleshoot Linux systems:

* Admin Guide: Documentation/admin-guide/index.rst
* Kernel Parameters: Documentation/admin-guide/kernel-parameters.rst
* Sysctl Tuning: Documentation/admin-guide/sysctl/index.rst
* Tracing/Debugging: Documentation/trace/index.rst
* Performance Security: Documentation/admin-guide/perf-security.rst
* Hardware Monitoring: Documentation/hwmon/index.rst

Maintainer
----------

Lead kernel subsystems and manage contributions:

* Maintainer Handbook: Documentation/maintainer/index.rst
* Pull Requests: Documentation/maintainer/pull-requests.rst
* Managing Patches: Documentation/maintainer/modifying-patches.rst
* Rebasing and Merging: Documentation/maintainer/rebasing-and-merging.rst
* Development Process: Documentation/process/maintainer-handbooks.rst
* Maintainer Entry Profile: Documentation/maintainer/maintainer-entry-profile.rst
* Git Configuration: Documentation/maintainer/configure-git.rst

Hardware Vendor
---------------

Write drivers and support new hardware:

* Driver API Guide: Documentation/driver-api/index.rst
* Driver Model: Documentation/driver-api/driver-model/driver.rst
* Device Drivers: Documentation/driver-api/infrastructure.rst
* Bus Types: Documentation/driver-api/buses.rst
* Device Tree Bindings: Documentation/devicetree/bindings/
* Power Management: Documentation/driver-api/pm/index.rst
* DMA API: Documentation/core-api/dma-api.rst

Distribution Maintainer
-----------------------

Package and distribute the kernel:

* Stable Kernel Rules: Documentation/process/stable-kernel-rules.rst
* ABI Documentation: Documentation/ABI/README
* Kernel Configuration: Documentation/kbuild/kconfig.rst
* Module Signing: Documentation/admin-guide/module-signing.rst
* Kernel Parameters: Documentation/admin-guide/kernel-parameters.rst
* Tainted Kernels: Documentation/admin-guide/tainted-kernels.rst

Agentic Coding
--------------

Essential guidelines for AI coding assistants:

* How to Do Kernel Development: Documentation/process/howto.rst
* Coding Style: Documentation/process/coding-style.rst
* Submitting Patches: Documentation/process/submitting-patches.rst
* Submit Checklist: Documentation/process/submit-checklist.rst
* Programming Language: Documentation/process/programming-language.rst

Critical Requirements:

* License: ALL code MUST be GPL-2.0 only (see COPYING)
* Signed-off-by: Agents MUST NOT add Signed-off-by tags
   (Only humans can legally certify code submission rights)
* Attribution: Agents MUST add Co-developed-by tag:
   Co-developed-by: $AGENT_NAME $AGENT_MODEL $AGENT_VERSION
   Examples:
   - Co-developed-by: Claude claude-3-opus-20240229
   - Co-developed-by: GitHub-Copilot GPT-4 v1.0.0


Communication and Support
=========================

* Mailing Lists: https://lore.kernel.org/
* IRC: #kernelnewbies on irc.oftc.net
* Bugzilla: https://bugzilla.kernel.org/
* MAINTAINERS file: Lists subsystem maintainers and mailing lists

-- 
Thanks,
Sasha

