Return-Path: <linux-kernel+bounces-749909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA4B1549C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CB47AAAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A8279783;
	Tue, 29 Jul 2025 21:18:00 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A991A23B1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823880; cv=none; b=HlVg/XlUN+B2hweMykXs04p6IJBB0vPS6BQKKWWE1BOT1p3g5ssPuSBuhfV8Wl3oNFYawIOXUan9cuXQJLEJrku0+KRe8XruI9JxyRilVT+wLgy1uoprMVMYm/vOyqK+XuRKybQES+FVDt9Xce1bE63VaDq43d7g0cju9TKQq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823880; c=relaxed/simple;
	bh=BGP7HmlGyiYAmngJcemPKytYkhpwG+Ms4C/EnPCQeKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpealGS06IIc9h+oFk4eJ7+kGUx96Utumw5KBpBHCva8/IiVcJ3Ty7duauXLk50KnAo5pthaRfNM4eJXFmFqcfOQXMeKh/aLGyz90JtD3t8WgaD3AX+wgKFc3ox4GRcS7S+eTG2Aq/1atsO63fVy8AwaV94InfZnp9HpEXam+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B5F6E1401E6;
	Tue, 29 Jul 2025 21:17:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 99EB520012;
	Tue, 29 Jul 2025 21:17:53 +0000 (UTC)
Date: Tue, 29 Jul 2025 17:18:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
Message-ID: <20250729171808.505c67c2@gandalf.local.home>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qkf9jn5pxnfpfzhoyg13fzkys5wtx83j
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 99EB520012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197idenOXj/Buw9CB9FuzY42flk3R8yMwo=
X-HE-Tag: 1753823873-862548
X-HE-Meta: U2FsdGVkX1+9h+Af1sdi7iDxolgeIwnw0Nmi80YzLYLlRBLCHd/cwWhJEngfUhFo21cyV2T2f0UK+0lvYTlNFVOpN1eZG9VhhV2KFGZ8+3CN+NVxb7jwSczkJkI4pZ5RhD9WiKjX55I0IX8f3IyuaIIG4SucxvsmTcbRIiBtvYX2fF7voBO2P2a+NpO6xnr4o3dOvVKf40Tw7nsJ7z2rjJfc8UvPKA815wpUJqKHFTHU7DkDoulU34J3aVcC0TBnLdbT9e+b2NjqrTfWscny00dCdKmS4JBvvam1ThHAGrWBIqI9XqHXi2Fh/OAw6wf95ZwKkR2dIaOhdS4YsycuAHCVoPK9bHI61WBUz9Uq63g4sNCckWUnzzkiQ0OH4RBOhj0ijA7QCBXTnOIJXyseK0Bbv73eLNOY882903qBhHY=


BTW, please make sure that the cover letter is Cc'd to
linux-trace-kernel@vger.kernel.org along with the patches. I use patchwork
to see the cover letter, but it's not present when it's not Cc'd.

Thanks,

-- Steve


On Wed, 23 Jul 2025 18:12:35 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> This series introduces various improvements to the rv/rvgen tools as
> first posted in [1]. It also adapts generated kernel files accordingly.
> 
> Specifically:
> 
> Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.
> 
> Patch 2 allows the rv tool to gracefully terminate with SIGTERM
> 
> Patch 3 adjusts dot2c not to create lines over 100 columns
> 
> Patch 4 properly orders nested monitors in the RV Kconfig file
> 
> Patch 5 returns the registration error in all DA monitor instead of 0
> 
> This series is based on the linux-next tree.
> 
> Changes since [1]:
> * Cleanup python code to improve PEP8 compliance
> * Fix condition for long line in dot2c
> 
> [1] - https://lore.kernel.org/lkml/20250721082325.71554-1-gmonaco@redhat.com
> 
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Nam Cao <namcao@linutronix.de>
> Cc: Tomas Glozar <tglozar@redhat.com>
> Cc: Juri Lelli <jlelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> 
> Gabriele Monaco (5):
>   tools/rv: Do not skip idle in trace
>   tools/rv: Stop gracefully also on SIGTERM
>   tools/dot2c: Fix generated files going over 100 column limit
>   verification/rvgen: Organise Kconfig entries for nested monitors
>   rv: Return init error when registering monitors
> 
>  kernel/trace/rv/Kconfig                       |  5 +++++
>  kernel/trace/rv/monitors/sched/sched.c        |  3 +--
>  kernel/trace/rv/monitors/sco/sco.c            |  3 +--
>  kernel/trace/rv/monitors/scpd/scpd.c          |  3 +--
>  kernel/trace/rv/monitors/sncid/sncid.c        |  3 +--
>  kernel/trace/rv/monitors/snep/snep.c          |  3 +--
>  kernel/trace/rv/monitors/snep/snep.h          | 14 +++++++++++--
>  kernel/trace/rv/monitors/snroc/snroc.c        |  3 +--
>  kernel/trace/rv/monitors/tss/tss.c            |  3 +--
>  kernel/trace/rv/monitors/wip/wip.c            |  3 +--
>  kernel/trace/rv/monitors/wwnr/wwnr.c          |  3 +--
>  tools/verification/rv/src/in_kernel.c         |  4 ++--
>  tools/verification/rv/src/rv.c                |  1 +
>  tools/verification/rvgen/rvgen/container.py   | 10 ++++++++++
>  tools/verification/rvgen/rvgen/dot2c.py       | 20 ++++++++++---------
>  tools/verification/rvgen/rvgen/generator.py   | 16 ++++++++++-----
>  .../rvgen/rvgen/templates/container/main.c    |  3 +--
>  .../rvgen/rvgen/templates/dot2k/main.c        |  3 +--
>  18 files changed, 63 insertions(+), 40 deletions(-)
> 
> 
> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a


