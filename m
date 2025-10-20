Return-Path: <linux-kernel+bounces-861551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46268BF30AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF054F9E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EF2D4B4B;
	Mon, 20 Oct 2025 18:53:19 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D22D3732
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986398; cv=none; b=jOXNmcgkvV3EJmLU6FXXu6dCyITILUzrsu/GfiQxOlwIRZciG82iDmrp0cEpZlaCRXUuSo6lpFNiDLAAetE3nN/87zSW3Ajiu0zzeDEaXUKPy972aCFC6+DyfBA01XaJlOn8gMrz2yoLzQOGVKVLTqu+bUFC7z6971lsuC963tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986398; c=relaxed/simple;
	bh=sx9p0A72pletnLqfbwSRsBkwVIYuo3cd9U8ciVwdBLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwaSjzeX1fVY/PuwPvNLg9ZanDBORexoCmnelAJwidb9ZN9aNgmdVZtZhEcRInmwB+Cr3hulhu6ZCca2zoTHfxMShuslzHMzYZd6y6af9v9m644OXPjK98kPHSqd30q2Ddsgrbk4Srilm9axSORPMV1lG4cj5oIf8Rd/wQOLie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 5C8A0C0290;
	Mon, 20 Oct 2025 18:53:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A85AF6000C;
	Mon, 20 Oct 2025 18:53:07 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:53:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [GIT PULL] rv fixes and selftests for v6.18-rc3
Message-ID: <20251020145327.4eb61f5e@gandalf.local.home>
In-Reply-To: <20251020124744.111326-1-gmonaco@redhat.com>
References: <20251020124744.111326-1-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A85AF6000C
X-Stat-Signature: wucqntos4myq1oxa69km3zu1j8891a1t
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Z7+1xjy8u1o0lPh9xd0m4Mnz9EIlL57M=
X-HE-Tag: 1760986387-848801
X-HE-Meta: U2FsdGVkX190t5LRt9p0sCaNT9qS6Tyo+GRfcgdhLqgNYBsXAOzsMyntaQ/PjTsPnI//0YEU5z/7x7KjU9y/uhuZofHoFjBVc9/XTReMq9MVC3gYsIyaxAF9RYjT2i1VtNR/9+HJPQXe0A1jUbmeTSvY/VWpQFuqC8XvkK1jBqP8DVHzg3vkq04PLQo2hRUcW+eQWPFjl89AdI3GnvvS16DU4gntKlobLcjX+/OeKOT8B0k6od8UoqFMMj63Fj7eyOpfPv4iZF8vbKZyL/keyFjefciOIWA0TRIQvPpjVSXzLCE3+q5rh/JUOiFQ0BTP/AxWLuB6y6E/IPKZ6Vc/GMajVOtQStpKXaIZ2V2fa7FcwDmLIuh11w==

On Mon, 20 Oct 2025 14:47:44 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Steve,
> 
> The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:
> 
>   Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.18-rc3
> 
> for you to fetch changes up to d9423638c039a15f7a1720f92c6ed0fddc6fea23:
> 
>   selftests/verification: Add initial RV tests (2025-10-20 12:48:20 +0200)
> 
> ----------------------------------------------------------------
> Summary of changes:
> 
> * Adapt the ftracetest script to be run from a different folder, this
>   uses the already existing OPT_TEST_DIR but extends it further to run
>   independent tests, then add an --rv flag to allow using the script for
>   testing RV (mostly) independently on ftrace.

Is the above a bug fix? It looks like it's something that should be added
during the merge window.

> * A bug causing kernel panic when reading enabled_monitors was reported,
>   change callbacks functions to always use list_head iterators and by
>   doing so, fix the wrong pointer that was leading to the panic.

Looks like a bug fix that should go in now.

> * The rtapp/pagefault monitor relies on the MMU to be present
>   (pagefaults exist) but that was not enforced via kconfig, leading to
>   potential build errors on systems without an MMU. Add that kconfig
>   dependency.

Bug fix.

> * Add basic RV selftests in selftests/verification to validate things
>   like available/enabled monitors and reactors. This could have caught
>   the bug introducing kernel panic solved above. Tests use ftracetest.

Not really a bug fix but tests can usually go in with the fixes to bugs
they now detect. Is this dependent on the first patch?

My question is still on that first change. Can that wait till the merge
window? If so, can you remove it from this pull request?

-- Steve


> 
> ----------------------------------------------------------------
> Gabriele Monaco (2):
>       selftest/ftrace: Generalise ftracetest to use with RV
>       selftests/verification: Add initial RV tests
> 
> Nam Cao (2):
>       rv: Fully convert enabled_monitors to use list_head as iterator
>       rv: Make rtapp/pagefault monitor depends on CONFIG_MMU
> 
>  MAINTAINERS                                        |  1 +
>  kernel/trace/rv/monitors/pagefault/Kconfig         |  1 +
>  kernel/trace/rv/rv.c                               | 12 ++--
>  tools/testing/selftests/ftrace/ftracetest          | 34 +++++++---
>  .../ftrace/test.d/00basic/mount_options.tc         |  2 +-
>  tools/testing/selftests/ftrace/test.d/functions    |  6 +-
>  tools/testing/selftests/verification/.gitignore    |  2 +
>  tools/testing/selftests/verification/Makefile      |  8 +++
>  tools/testing/selftests/verification/config        |  1 +
>  tools/testing/selftests/verification/settings      |  1 +
>  .../selftests/verification/test.d/functions        | 39 +++++++++++
>  .../test.d/rv_monitor_enable_disable.tc            | 75 ++++++++++++++++++++++
>  .../verification/test.d/rv_monitor_reactor.tc      | 68 ++++++++++++++++++++
>  .../verification/test.d/rv_monitors_available.tc   | 18 ++++++
>  .../verification/test.d/rv_wwnr_printk.tc          | 30 +++++++++
>  .../selftests/verification/verificationtest-ktap   |  8 +++
>  16 files changed, 286 insertions(+), 20 deletions(-)
>  create mode 100644 tools/testing/selftests/verification/.gitignore
>  create mode 100644 tools/testing/selftests/verification/Makefile
>  create mode 100644 tools/testing/selftests/verification/config
>  create mode 100644 tools/testing/selftests/verification/settings
>  create mode 100644 tools/testing/selftests/verification/test.d/functions
>  create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
>  create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
>  create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
>  create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
>  create mode 100644 tools/testing/selftests/verification/verificationtest-ktap
> 
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Cc: Nam Cao <namcao@linutronix.de>


