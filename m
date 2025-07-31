Return-Path: <linux-kernel+bounces-752564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52EB17743
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BE87B62ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB22512C3;
	Thu, 31 Jul 2025 20:38:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0B13A258
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994305; cv=none; b=cw4d1vpy+QcJil7EhS0t+1xU33tYJsbTjF5QKJaokH2KKHpyXkov+KRF9FdRVOo47j5Hcm7POReVxOGnHhl3+mo8RX2uNZHpmmNabLEWD05waHfNHISAI8RuetEQFMUT8U/9Zpp2Cd+XcilHbU7pffsvra0XbNjk/6QAUA/pFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994305; c=relaxed/simple;
	bh=1KPaxC0K1jqzqH1DBJnT9tvxhl2GYbl459Kl5KPn0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0BbEg9icBthbZnIvLwrdrqasbIVz6RRzg04ObKow+r6Fb9eB03+T7LTvMTDNchDnui4ggBH+z40VUMpZenHdgMtp7kw0gyLkpfesNX1jkr9paFedHRWUIXzwQyp00VYgdXAmXAnIKlo2mvOvca2ycHvThOK1F29DU+WJOXRbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 63EFC11494F;
	Thu, 31 Jul 2025 20:38:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 307CA20025;
	Thu, 31 Jul 2025 20:38:13 +0000 (UTC)
Date: Thu, 31 Jul 2025 16:38:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.17
Message-ID: <20250731163831.3149a14a@gandalf.local.home>
In-Reply-To: <6z7h63sg3ljhy2k2ymnysm7hhcmtb76follkdy2y2iu54npxqj@wppxbg2qok2p>
References: <20250731101717.6c340b66@gandalf.local.home>
	<6z7h63sg3ljhy2k2ymnysm7hhcmtb76follkdy2y2iu54npxqj@wppxbg2qok2p>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fhaikc453petwypw16czn5gh1emf6uuk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 307CA20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JfQkqqQdY9w/KYroK2NkBsJKzvkobai0=
X-HE-Tag: 1753994293-27466
X-HE-Meta: U2FsdGVkX18NB+2JuNBVBKqnW6z9/5A4Kq6RXgc219zpoObWYT/y9IPp3RFQtVczCsrjsJg+2DxMSG1Yu2mIyT9bz55BOxEhT1Q06xeq3JU9/5wMss9O3mmiQCNfsa02fHTxc5n1rk1jrFbOlMsWHF/tah+ZwMnqFfepT3bBFOfCUjL2K7mFPHFUFUyGkbb/FohXS+Ss87ZciJ010eGDo4atmZ1xpRjrH8n1PqryibtjMirbYJqm124E3PU2Bar+lt31qllef5E+WThSvRJTBV0290GCA2AI/+56aClYwoRV/PwrvsZd+8JVUVgqdeWHwsEpynuTQBcT4F8LkJwoOlaF1g5PyCODgKZk5HMJrHPBxWPQf976gw==

On Thu, 31 Jul 2025 10:29:49 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> In 5 years all these tools can switch the order, no problem,
> but I don't get the point. Most, it not all tools, have similar tracefs
> detection logic. Just remove automount right now without warn,
> since the warn is only noise and churn to tools to swap the order
> of detection ?

The issue is that if we just remove it now, it *will* break a lot of
scripts. I know many people that have scripts hardcoded with just
/sys/kernel/debug/tracing in use (Peter Zijlstra for one).

tracefs has been in the kernel for over 5 years and there's still kernel
developers that are unaware that it has its own directory! After posting
this patch to the public, a had a couple of people tell me privately that
they didn't know about /sys/kernel/tracing. That's why I want the warning.

I'd suggest to switch the logic, or do what libtracefs does and parse the
/proc/mounts directory:

  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89

It only uses debugfs if tracefs isn't found.

Even my own scripts have been doing this for years: (from the ftrace kselftests):

TRACING_DIR=`grep tracefs /proc/mounts | cut -f2 -d' ' | head -1`
if [ -z "$TRACING_DIR" ]; then
    DEBUGFS_DIR=`grep debugfs /proc/mounts | cut -f2 -d' ' | head -1`
    if [ -z "$DEBUGFS_DIR" ]; then
        # If tracefs exists, then so does /sys/kernel/tracing
        if [ -d "/sys/kernel/tracing" ]; then
            mount -t tracefs nodev /sys/kernel/tracing ||
              errexit "Failed to mount /sys/kernel/tracing"
            TRACING_DIR="/sys/kernel/tracing"
            UMOUNT_DIR=${TRACING_DIR}
        # If debugfs exists, then so does /sys/kernel/debug
        elif [ -d "/sys/kernel/debug" ]; then
            mount -t debugfs nodev /sys/kernel/debug ||
              errexit "Failed to mount /sys/kernel/debug"
            TRACING_DIR="/sys/kernel/debug/tracing"
            UMOUNT_DIR=${TRACING_DIR}
        else
            err_ret=$err_skip
            errexit "debugfs and tracefs are not configured in this kernel"
        fi
    else
        TRACING_DIR="$DEBUGFS_DIR/tracing"
    fi
fi


-- Steve

