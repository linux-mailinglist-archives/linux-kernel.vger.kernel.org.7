Return-Path: <linux-kernel+bounces-841411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70ABB73A4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353263B4A29
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC94158874;
	Fri,  3 Oct 2025 14:46:04 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6F27FB1F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502763; cv=none; b=EQz5zPw6pp2+BZI0bpLrJ8eCmTAOAyQAhlH1xMuRwkmlrCkURtSHPWQtcVN2Iczy177sP+6wDq77TYkVFza8rMb0yVsuXFvjYn09Wukq0bfmrmHhwZPwZfTZJ2upe4oaRQwUfjmMVZjhNbK7W/y7c60nqM2Dc85YIkK/WB9dw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502763; c=relaxed/simple;
	bh=oVJF+DNaBKfn6ND0f/6ZRjehxePDmGLfpJlkbvlJlDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mRGLUuac0LLiYbwmi8LcYmJndNQRdB0dnV0qtgJRWVm+1boJaV9IpI2Oc+5km1uHeKQHBNfzyEF2IEvb8HxiRjJIRpcHc2Mnq9OcM/HF6QsE8osfL9Lj/3WfFieuuPhVLVlxlm/iWGsrMbBT4yCo73j4DWFi96wK4e0IhHNf7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5ADF2B6C48;
	Fri,  3 Oct 2025 14:45:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 08AF017;
	Fri,  3 Oct 2025 14:45:56 +0000 (UTC)
Date: Fri, 3 Oct 2025 10:47:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [GIT PULL] tracing/tools: Update for v6.18
Message-ID: <20251003104739.3d09e60e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3uam5e4t5p551tgo9tpz8rejwdk6j7y3
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 08AF017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Gv7rxy9UcHFj0n6zQmtMz/6QqP43gGrE=
X-HE-Tag: 1759502756-675094
X-HE-Meta: U2FsdGVkX1+DliZdijpezt3At2N81IpFLSDm66GaLTH6mOmFcvfTQw+b3WmteFW+qf0vas+HPJUuwT2B6QKXfO80FydGvVEoByV5iMcfgUAhfeSVYv/8kld9HebW72O6bDVeHU8KVdBtRDn+e6pMbRBo67iZ1X5FbVDqGkftY7YcrYswoRXDbvyt4qLd4Kh8IEJyhpnMLTsJ+wzNk4QoQTw7JBR/LUrTqITbP7GaLty1oDXXB7qRYLJDTp6LEKGRCDcrEPkapDkyR2tKjokyveY4NOSDUQVTXjKpR7t2NIHstcvy747f1X8cZs9HKLUf23gDisvvzNXnD0aiTQsLigErF/5Q7Ucj


Linus,

rtla: Updates for v6.18

- This update is mostly just consolidating code between osnoise/timerlat
  and top/hist for easier maintenance and less future divergence.


Please pull the latest trace-tools-v6.18 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.18

Tag SHA1: a9be3d59c1174c9571a39e7c0cd8759bcc6fe092
Head SHA1: 05b7e10687c69e0c28e62b9a74ce78b3e7463806


Costa Shulyupin (1):
      tools/rtla: Consolidate common parameters into shared structure

Crystal Wood (6):
      tools/rtla: Move top/hist params into common struct
      tools/rtla: Create common_apply_config()
      tools/rtla: Consolidate code between osnoise/timerlat and hist/top
      tools/rtla: Fix -A option name in test comment
      tools/rtla: Add test engine support for unexpected output
      tools/rtla: Add remaining support for osnoise actions

----
 Documentation/tools/rtla/common_options.rst        |  61 ++
 .../tools/rtla/common_osnoise_options.rst          |   8 +
 .../tools/rtla/common_timerlat_options.rst         |  74 +--
 Documentation/tools/rtla/rtla-hwnoise.rst          |   2 +
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |   2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst      |   2 +
 Documentation/tools/rtla/rtla-timerlat-hist.rst    |   2 +
 Documentation/tools/rtla/rtla-timerlat-top.rst     |   2 +
 tools/tracing/rtla/src/Build                       |   1 +
 tools/tracing/rtla/src/actions.c                   |   8 +-
 tools/tracing/rtla/src/actions.h                   |   2 +-
 tools/tracing/rtla/src/common.c                    | 344 +++++++++++
 tools/tracing/rtla/src/common.h                    | 154 +++++
 tools/tracing/rtla/src/osnoise.c                   | 101 ++--
 tools/tracing/rtla/src/osnoise.h                   | 114 +---
 tools/tracing/rtla/src/osnoise_hist.c              | 369 +++++-------
 tools/tracing/rtla/src/osnoise_top.c               | 303 +++-------
 tools/tracing/rtla/src/timerlat.c                  | 210 +++++--
 tools/tracing/rtla/src/timerlat.h                  |  55 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  22 +-
 tools/tracing/rtla/src/timerlat_hist.c             | 642 ++++++---------------
 tools/tracing/rtla/src/timerlat_top.c              | 568 ++++--------------
 tools/tracing/rtla/src/trace.h                     |   3 -
 tools/tracing/rtla/tests/engine.sh                 |  26 +-
 tools/tracing/rtla/tests/osnoise.t                 |  27 +-
 tools/tracing/rtla/tests/timerlat.t                |   4 +-
 26 files changed, 1395 insertions(+), 1711 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c
 create mode 100644 tools/tracing/rtla/src/common.h
---------------------------

