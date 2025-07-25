Return-Path: <linux-kernel+bounces-746330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCEB12598
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69F31CC180A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713525B31C;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTliCzNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA9254854
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475658; cv=none; b=a9SNXs68RvOEpuhcFd9JU5CZb/5etHVrmOgCpvNx9fx7PxAWpLQ4BKrmEhGQu1Ak8XvLYEEChv8l2+LYxwI33z1x51Lx/zMLyH5uzq19RfOsNJGMNF5FoLt0lO3m8Umg/L2Dt89E1sbDkkosuAje6H5Zi2Ph4mbA0p3JLBWZHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475658; c=relaxed/simple;
	bh=xFD70B9cSTB1pdzgoBfk/E5CLr0q04m7PC8mX+Qzqkw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=KN7/ZGH2ZESI5k9B8Rrn7kluiG9mjk2ji0cIVpNJywjWyStwar/0NMX0YxFduPvx6x7ryu4d5Io2qDpaU6e7xMuGurImNhadowTarA1dhZa3nmw/F9uvwpcI4lgocxNy0jK6GRGIlCV+LLFDOdZmDgGntZGUL1MzznDDdtu5/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTliCzNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2ABC4CEF4;
	Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475658;
	bh=xFD70B9cSTB1pdzgoBfk/E5CLr0q04m7PC8mX+Qzqkw=;
	h=Date:From:To:Cc:Subject:From;
	b=HTliCzNnZvfQPZ3tvBTEoHxr3LbLWGetGvDmN7NmsiJ0HidfPa39aGo+XM89XLLhg
	 pcuOeh4ubWKxI9RwHRWGnCqKY37LXx+XDmBRkQOdwnKAWtHAMRParzwm/jCbSAf053
	 9LrZFa3sChLodkttrbatO09vN+fEGPuwZt0LKXHFKobCmX39HPXgtlMhCYd+G+Ssh3
	 7mjH5FUyTZYh1AQ5JMcEpnAeEQL8+HamefV7iHxk9acREH567fSLx6Z+E8PvvEz0s0
	 LOoy967XRbTqlP64qh3Hj+vDf63XuF2kmNu7g7SR/W4xrvD4/Yn49J++I6IaRl/2Ro
	 zquzqKS37NHkw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Y-00000001Qbs-0KFL;
	Fri, 25 Jul 2025 16:34:24 -0400
Message-ID: <20250725203357.087558746@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:33:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 00/25] rv/verfication: Updatse for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
rv/for-next

Head SHA1: b8a7fba39cd49eab343bfe561d85bb5dc57541af


Gabriele Monaco (5):
      tools/rv: Do not skip idle in trace
      tools/rv: Stop gracefully also on SIGTERM
      tools/dot2c: Fix generated files going over 100 column limit
      verification/rvgen: Organise Kconfig entries for nested monitors
      rv: Return init error when registering monitors

Nam Cao (20):
      objtool: Add vpanic() to the noreturn list
      panic: Fix up description of vpanic()
      rv/ltl: Do not execute the Buchi automaton twice on start condition
      verification/dot2k: Make a separate dot2k_templates/Kconfig_container
      verification/dot2k: Remove __buff_to_string()
      verification/dot2k: Replace is_container() hack with subparsers
      verification/dot2k: Prepare the frontend for LTL inclusion
      Documentation/rv: Prepare monitor synthesis document for LTL inclusion
      verification/rvgen: Restructure the templates files
      verification/rvgen: Restructure the classes to prepare for LTL inclusion
      verification/rvgen: Add support for linear temporal logic
      Documentation/rv: Add documentation for linear temporal logic monitors
      verification/rvgen: Support the 'next' operator
      verification/rvgen: Generate each variable definition only once
      verification/rvgen: Do not generate unused variables
      rv: Remove unused field in struct rv_monitor_def
      rv: Merge struct rv_monitor_def into struct rv_monitor
      rv: Merge struct rv_reactor_def into struct rv_reactor
      rv: Remove rv_reactor's reference counter
      rv: Remove struct rv_monitor::reacting

----
 Documentation/trace/rv/da_monitor_synthesis.rst    | 147 ------
 Documentation/trace/rv/index.rst                   |   3 +-
 Documentation/trace/rv/linear_temporal_logic.rst   | 134 +++++
 Documentation/trace/rv/monitor_synthesis.rst       | 271 ++++++++++
 include/linux/rv.h                                 |   8 +
 include/rv/ltl_monitor.h                           |   4 +-
 kernel/panic.c                                     |   2 +-
 kernel/trace/rv/Kconfig                            |   5 +
 kernel/trace/rv/monitors/sched/sched.c             |   3 +-
 kernel/trace/rv/monitors/sco/sco.c                 |   3 +-
 kernel/trace/rv/monitors/scpd/scpd.c               |   3 +-
 kernel/trace/rv/monitors/sncid/sncid.c             |   3 +-
 kernel/trace/rv/monitors/snep/snep.c               |   3 +-
 kernel/trace/rv/monitors/snep/snep.h               |  14 +-
 kernel/trace/rv/monitors/snroc/snroc.c             |   3 +-
 kernel/trace/rv/monitors/tss/tss.c                 |   3 +-
 kernel/trace/rv/monitors/wip/wip.c                 |   3 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   3 +-
 kernel/trace/rv/rv.c                               | 210 ++++----
 kernel/trace/rv/rv.h                               |  39 +-
 kernel/trace/rv/rv_reactors.c                      | 136 ++---
 tools/objtool/noreturns.h                          |   1 +
 tools/verification/dot2/Makefile                   |  26 -
 tools/verification/dot2/dot2k                      |  53 --
 tools/verification/rv/src/in_kernel.c              |   4 +-
 tools/verification/rv/src/rv.c                     |   1 +
 tools/verification/rvgen/.gitignore                |   3 +
 tools/verification/rvgen/Makefile                  |  27 +
 tools/verification/rvgen/__main__.py               |  67 +++
 tools/verification/{dot2 => rvgen}/dot2c           |   2 +-
 .../verification/{dot2 => rvgen/rvgen}/automata.py |   0
 tools/verification/rvgen/rvgen/container.py        |  32 ++
 tools/verification/{dot2 => rvgen/rvgen}/dot2c.py  |  22 +-
 tools/verification/rvgen/rvgen/dot2k.py            | 129 +++++
 .../{dot2/dot2k.py => rvgen/rvgen/generator.py}    | 265 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py           | 566 +++++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py            | 271 ++++++++++
 .../rvgen/templates}/Kconfig                       |   0
 .../rvgen/rvgen/templates/container/Kconfig        |   5 +
 .../rvgen/templates/container/main.c}              |   3 +-
 .../rvgen/templates/container/main.h}              |   0
 .../rvgen/templates/dot2k}/main.c                  |   3 +-
 .../rvgen/templates/dot2k}/trace.h                 |   0
 .../rvgen/rvgen/templates/ltl2k/main.c             | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h            |  14 +
 45 files changed, 1893 insertions(+), 703 deletions(-)
 delete mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 Documentation/trace/rv/monitor_synthesis.rst
 delete mode 100644 tools/verification/dot2/Makefile
 delete mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/Makefile
 create mode 100644 tools/verification/rvgen/__main__.py
 rename tools/verification/{dot2 => rvgen}/dot2c (97%)
 rename tools/verification/{dot2 => rvgen/rvgen}/automata.py (100%)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 rename tools/verification/{dot2 => rvgen/rvgen}/dot2c.py (92%)
 create mode 100644 tools/verification/rvgen/rvgen/dot2k.py
 rename tools/verification/{dot2/dot2k.py => rvgen/rvgen/generator.py} (51%)
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates}/Kconfig (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/container/Kconfig
 rename tools/verification/{dot2/dot2k_templates/main_container.c => rvgen/rvgen/templates/container/main.c} (92%)
 rename tools/verification/{dot2/dot2k_templates/main_container.h => rvgen/rvgen/templates/container/main.h} (100%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/main.c (96%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/trace.h (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

