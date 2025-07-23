Return-Path: <linux-kernel+bounces-741682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8EB0E7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA46C22F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C54142E83;
	Wed, 23 Jul 2025 00:51:02 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3CF4A1A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231861; cv=none; b=QFW+TnQ0K3tIZeiaygrxWdD+z7ii3wMhxfYVfq1xDy0GmxO5XSupgoDh2ouv9oGrE7eQ75rWkjmMDQkD8xXJZfXSH3TT/EKKK7NsQIj99Q1bG5UZdYe0bLBp9Kr8QUAzDTkJbMJueapI98YPefzAerzc+t4AcJieR8Q4olu/gQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231861; c=relaxed/simple;
	bh=hgQ51q/RpKZtfqP3A3qw53Z9D/xBT2ghky2bzXKjwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViLmLPE/2aWLK66s8JFOx13cRlmpSINragGiI7UwOgSipgC0S9Lz7aixfXNA9kQVFPIGtsR2Z6O+5LwH0FMURzD0spOFuWUj99TifCfFmjjhW9HNW22mtl5cwIZcTg6MfCgLT0x+vhtJ9vLssOv5P5wkztmQM/CrRi8fVlo/AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9DE991D8B5A;
	Wed, 23 Jul 2025 00:50:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 7C62320027;
	Wed, 23 Jul 2025 00:50:48 +0000 (UTC)
Date: Tue, 22 Jul 2025 20:50:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 00/14] rv: Add monitors to validate task switch
Message-ID: <20250722205047.621efa7e@gandalf.local.home>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rot59xq6n7b5otrstygwbtfgwbzndbg8
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7C62320027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LwjtOPHPrUV9v4psN1/4giZuKDSepxqc=
X-HE-Tag: 1753231848-433730
X-HE-Meta: U2FsdGVkX1/m62/imTaeOsu5pbhBHluMWv0eMufCohr4ftFd8IKRYKrRS0O0J8vQAv5lBPW6tSjixsbKADxVSRP4JsZbqSmvAULBFq7tGhqRXivUwdo7aGtpEfFlDScWZRMQCxAHfJPzvQWE+VXy61OaqLZyrMVDqiGs3dTuht1YljXLb3Uqtrx+6plD0Yiv+s7BxI7Z6UutgP0qsBpSRD9YNN+xMeeNKEYUg1ZSdlj4tCZQDqW2boRzEHF81ReXxD/z2MhASZhvPKaZwBaCZ8z6jCmiZUMYlGzJoSu0aVMg86FAmWrzLwatKmgKY3ARhpKATQzAojIggrTjIieQbpdkSuqY79Sl

On Mon, 21 Jul 2025 10:23:10 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

>  Documentation/trace/rv/monitor_sched.rst      | 307 +++++++++++++++---
>  include/linux/rv.h                            |   3 +-
>  include/linux/sched.h                         |   7 +-
>  include/rv/da_monitor.h                       | 129 +++++---
>  include/trace/events/sched.h                  |  12 +-
>  kernel/sched/core.c                           |  13 +-
>  kernel/trace/rv/Kconfig                       |  16 +-
>  kernel/trace/rv/Makefile                      |   6 +-
>  kernel/trace/rv/monitors/{tss => nrp}/Kconfig |  12 +-
>  kernel/trace/rv/monitors/nrp/nrp.c            | 138 ++++++++
>  kernel/trace/rv/monitors/nrp/nrp.h            |  75 +++++
>  kernel/trace/rv/monitors/nrp/nrp_trace.h      |  15 +
>  kernel/trace/rv/monitors/opid/Kconfig         |  19 ++
>  kernel/trace/rv/monitors/opid/opid.c          | 169 ++++++++++
>  kernel/trace/rv/monitors/opid/opid.h          | 104 ++++++
>  .../sncid_trace.h => opid/opid_trace.h}       |   8 +-
>  kernel/trace/rv/monitors/sched/Kconfig        |   1 +
>  kernel/trace/rv/monitors/sched/sched.c        |   3 +-
>  kernel/trace/rv/monitors/sco/sco.c            |   7 +-
>  kernel/trace/rv/monitors/scpd/Kconfig         |   2 +-
>  kernel/trace/rv/monitors/scpd/scpd.c          |   7 +-
>  kernel/trace/rv/monitors/sncid/sncid.c        |  96 ------
>  kernel/trace/rv/monitors/sncid/sncid.h        |  49 ---
>  kernel/trace/rv/monitors/snep/Kconfig         |   2 +-
>  kernel/trace/rv/monitors/snep/snep.c          |   7 +-
>  kernel/trace/rv/monitors/snep/snep.h          |  14 +-
>  kernel/trace/rv/monitors/snroc/snroc.c        |   3 +-
>  .../trace/rv/monitors/{sncid => sssw}/Kconfig |  10 +-
>  kernel/trace/rv/monitors/sssw/sssw.c          | 116 +++++++
>  kernel/trace/rv/monitors/sssw/sssw.h          | 105 ++++++
>  kernel/trace/rv/monitors/sssw/sssw_trace.h    |  15 +
>  kernel/trace/rv/monitors/sts/Kconfig          |  19 ++
>  kernel/trace/rv/monitors/sts/sts.c            | 156 +++++++++
>  kernel/trace/rv/monitors/sts/sts.h            | 117 +++++++
>  .../{tss/tss_trace.h => sts/sts_trace.h}      |   8 +-
>  kernel/trace/rv/monitors/tss/tss.c            |  91 ------
>  kernel/trace/rv/monitors/tss/tss.h            |  47 ---
>  kernel/trace/rv/monitors/wip/Kconfig          |   2 +-
>  kernel/trace/rv/monitors/wip/wip.c            |   3 +-
>  kernel/trace/rv/monitors/wwnr/wwnr.c          |   3 +-
>  kernel/trace/rv/rv_trace.h                    | 114 ++++---

Can you break this up into two patch series? One that modifies the kernel
and one that modifies the tools directory. Linus prefers changes to tools
come in separately to changes in the kernel. So do I as I test them
differently.

Thanks,

-- Steve


>  tools/verification/models/sched/nrp.dot       |  29 ++
>  tools/verification/models/sched/opid.dot      |  35 ++
>  tools/verification/models/sched/sncid.dot     |  18 -
>  tools/verification/models/sched/sssw.dot      |  30 ++
>  tools/verification/models/sched/sts.dot       |  38 +++
>  tools/verification/models/sched/tss.dot       |  18 -
>  tools/verification/rv/src/in_kernel.c         |   4 +-
>  tools/verification/rv/src/rv.c                |   1 +
>  tools/verification/rvgen/rvgen/container.py   |  10 +
>  tools/verification/rvgen/rvgen/dot2c.py       |  20 +-
>  tools/verification/rvgen/rvgen/generator.py   |  16 +-

