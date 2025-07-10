Return-Path: <linux-kernel+bounces-724699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C4AFF606
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92926189AD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F4149C51;
	Thu, 10 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbzPILHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77978BE4A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107696; cv=none; b=F3Kvynx7h/SSWLWcwGyZbEVxFXJ5yM+mof26mdYo9Oc8w5QPMv7BGr8LymOvwbdcdIAip1waNaFHa7DtS1z2Sd/zfQOeYpJH/8lGWhSULS1qjp6RclCdaDqI+G4RCRq4VRqtcXj+Iqh6ri790F5GkmbHhxVHRA1mq7oLnq0h95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107696; c=relaxed/simple;
	bh=xLRcRnANcRQoRs+oyvMuV8lktBM3CxV/xNIcUCy8cXc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kQ6/isy/5oLWdC1OgRJvru+9H4CIHYLQ9ZJcVQkoT2UN0tnpCNLrRcUsxJbq7L937sUWuiyIgxd9bl5h80owIznrnvbEcSMX3XKclV0T9Acxx+6I1lM6oRqWMOELdJDdEqe0G1eZH/Xg4NPNJQ9v8ysK+sBgSAvg3bRy1lDcg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbzPILHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B78C4CEEF;
	Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107695;
	bh=xLRcRnANcRQoRs+oyvMuV8lktBM3CxV/xNIcUCy8cXc=;
	h=Date:From:To:Cc:Subject:From;
	b=YbzPILHS7KaId/9CfXIctv9YetGm+pA+qQMQOjXcso4hYl0vaze4Z6CKz6LIQNg/1
	 ZFGSHAudCHSOKJ/mz8WNoWm2ZVnUJDuSKJwXa+AU1rYiVT/RLz1QhGN5VfPOqHJqqB
	 7voWD8LlraEg1xxPrxmkkbt388QMG5Qm1A2pOVjgb4rrEv/42BReHfbP3ZGpcvmyvi
	 RUJfGtv7KWppgR/iyrBY11rog+hdWtCHbS2YV1zj7O/In4s3Bdvo2Au7RuBs1bq3PK
	 JQLRHaS48Uqrf9ZLZ2CV4dmRafz4sp1w598unb+80Ypip2upQHhnViVHt1b+oEnnoX
	 /Soc1YrS45bGw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001WfR-0QnI;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003437.191509804@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/9] tracing/tools: rv: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 2a4e466dcdfb0c0e9b1a3f4cfb4ff4bc26288059


Nam Cao (9):
      verification/dot2k: Make a separate dot2k_templates/Kconfig_container
      verification/dot2k: Remove __buff_to_string()
      verification/dot2k: Replace is_container() hack with subparsers
      verification/dot2k: Prepare the frontend for LTL inclusion
      Documentation/rv: Prepare monitor synthesis document for LTL inclusion
      verification/rvgen: Restructure the templates files
      verification/rvgen: Restructure the classes to prepare for LTL inclusion
      verification/rvgen: Add support for linear temporal logic
      Documentation/rv: Add documentation for linear temporal logic monitors

----
 Documentation/trace/rv/da_monitor_synthesis.rst    | 147 ------
 Documentation/trace/rv/index.rst                   |   3 +-
 Documentation/trace/rv/linear_temporal_logic.rst   | 133 +++++
 Documentation/trace/rv/monitor_synthesis.rst       | 271 +++++++++++
 tools/verification/dot2/Makefile                   |  26 -
 tools/verification/dot2/dot2k                      |  53 --
 tools/verification/rvgen/.gitignore                |   3 +
 tools/verification/rvgen/Makefile                  |  27 ++
 tools/verification/rvgen/__main__.py               |  67 +++
 tools/verification/{dot2 => rvgen}/dot2c           |   2 +-
 .../verification/{dot2 => rvgen/rvgen}/automata.py |   0
 tools/verification/rvgen/rvgen/container.py        |  22 +
 tools/verification/{dot2 => rvgen/rvgen}/dot2c.py  |   2 +-
 tools/verification/rvgen/rvgen/dot2k.py            | 129 +++++
 .../{dot2/dot2k.py => rvgen/rvgen/generator.py}    | 249 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py           | 540 +++++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py            | 252 ++++++++++
 .../rvgen/templates}/Kconfig                       |   0
 .../rvgen/rvgen/templates/container/Kconfig        |   5 +
 .../rvgen/templates/container/main.c}              |   0
 .../rvgen/templates/container/main.h}              |   0
 .../rvgen/templates/dot2k}/main.c                  |   0
 .../rvgen/templates/dot2k}/trace.h                 |   0
 .../rvgen/rvgen/templates/ltl2k/main.c             | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h            |  14 +
 25 files changed, 1631 insertions(+), 416 deletions(-)
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
 rename tools/verification/{dot2 => rvgen/rvgen}/dot2c.py (99%)
 create mode 100644 tools/verification/rvgen/rvgen/dot2k.py
 rename tools/verification/{dot2/dot2k.py => rvgen/rvgen/generator.py} (52%)
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates}/Kconfig (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/container/Kconfig
 rename tools/verification/{dot2/dot2k_templates/main_container.c => rvgen/rvgen/templates/container/main.c} (100%)
 rename tools/verification/{dot2/dot2k_templates/main_container.h => rvgen/rvgen/templates/container/main.h} (100%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/main.c (100%)
 rename tools/verification/{dot2/dot2k_templates => rvgen/rvgen/templates/dot2k}/trace.h (100%)
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

