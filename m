Return-Path: <linux-kernel+bounces-782798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D444B32580
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC592AA8998
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706E2D837E;
	Fri, 22 Aug 2025 23:57:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47F272E61
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907070; cv=none; b=KyLf4cNtNhSoIBb8o7Y6ZTXhallbiyD91Hwo5d5wILzuGb1Cw/paM/Rv485Ilzrzm4fnscs4IUzwOJdh99si/Rgfe+cJsSLErOSYHxru4WCHWOTi6jDnmQQ4DlZ8tpV615rQ+BPPX9y1IL6QUsqInqkmDTErwO1oz4EVNZOkMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907070; c=relaxed/simple;
	bh=dGoenL52dEOiD3oJLVvWfmMoCrfrrQozOzmf2DN8YkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyfKs4MZy1Pssm2R+Dopq6qNHd19ueL8C0q6YE5tUC0osmXqQKWU7lQ5VEbsO1fewtP5hHWA4TeiHbXNuuIx/Ukf2sLppxBSeWuOy1JN5WmtZGEpHjQV+wYSWaWDPvyzbFSL4YkbqYYmz1D6iXFHJgMb0Qy+tS3frsphsLfZR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2D80383A31;
	Fri, 22 Aug 2025 23:57:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 8B9CF20025;
	Fri, 22 Aug 2025 23:57:43 +0000 (UTC)
Date: Fri, 22 Aug 2025 19:57:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Liao
 Yuanhong <liaoyuanhong@vivo.com>, Pu Lehui <pulehui@huawei.com>, Tao Chen
 <chen.dylane@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, Ye Weihua
 <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822195742.7f28330f@batman.local.home>
In-Reply-To: <20250822235536.GA1367428@ax162>
References: <20250822124933.74965607@gandalf.local.home>
	<20250822192437.GA458494@ax162>
	<20250822170808.5ce49cc3@gandalf.local.home>
	<20250822171637.7ee1cf7e@gandalf.local.home>
	<20250822212311.GA1629566@ax162>
	<20250822173959.72e636c4@gandalf.local.home>
	<20250822235536.GA1367428@ax162>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ekbaob5ymnm6npemczxxr1wfizeha7nq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8B9CF20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aerq7fBr6brFoKLs4E8m5N9iTzJbrUXs=
X-HE-Tag: 1755907063-79402
X-HE-Meta: U2FsdGVkX19HwgBcmUwfpekbII+rTC5AiVnmf8NMYe/MC4Ws1XblQ3aFdlcbzmDliqUeBrtYhCWAJLgOIpahoQq7Q6xmrpGmrQlT4NphyGw9Pu5R0rKhLvwjPhqYFLdxuqwC/rAvA+SOW8FPVAM25xVFHIu+aT0PMpMwQMqRR1rkzTCpYV1JfI38YvWshsWbYSc1zja/ieidIiimWP+OCmmujUkO6Cah4hZ07twNy96wAyg1M7QYPNrovC3jE2bL9mD0MogO0uhME7RrJ9NU+BOSPBjpa/W9udIL++72WfJxFuhZnGHdYK2R782GhUgUNdxt81SvxTY1cULEAyE4y0EoREk4zRU7

On Fri, 22 Aug 2025 16:55:36 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Fri, Aug 22, 2025 at 05:39:59PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Aug 2025 14:23:11 -0700
> > Nathan Chancellor <nathan@kernel.org> wrote:
> >   
> > > > Actually, can you see if this fixes the bug you are seeing?    
> > > 
> > > Yes, it does.
> > > 
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>  
> > 
> > Ah, that patch isn't good, as iter->hash must be non NULL going forward,
> > otherwise it thinks it failed to allocated.
> > 
> > Could you test this one instead?  
> 
> Yes, this one works as well for that test.
> 

Thanks for the report back. I'll re-add your "Tested-by" tag.

-- Steve

