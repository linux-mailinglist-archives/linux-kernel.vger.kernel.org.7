Return-Path: <linux-kernel+bounces-839213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3972BB1127
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EB1944C66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054B256C76;
	Wed,  1 Oct 2025 15:30:20 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1A258EFB
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332620; cv=none; b=mA5yRQdUizLzIWDtama2g7b+YSC3F64bSL8+010WxLvdErq+O9bGuuupSssMlrw8Tzp5u2VzfgEBd4Ldd8X3zKIZBUgq8Tg0cm2b+BAf94LRtWMAuINzB202Vu2yTwi7R8p7oQE3FDN6xFbGbt59+FHgJ9ByJNQRLHhy5kOKIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332620; c=relaxed/simple;
	bh=CXwG/R+Rnn7AkKam2k9JX1aU4zJyU59IGQaNQgzAeno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYDobvufUicWVmUEWYCpCl+CbT8pZ4yoG1tgHlWLfexQ7tEQXuJhTGFRAtWzRfa7tDHE2HkervQg/QC8YD68awTW7sptSxaDnfWQtAW4BCAZVRh8gDIIAFJarMjpbXZVlNT3riFmylXre2Ci2bvLqau9N4L8nzdl7IqIadZM39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9AC0E55EB1;
	Wed,  1 Oct 2025 15:30:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CECBA2F;
	Wed,  1 Oct 2025 15:30:07 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:31:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] task_work: Fix NMI race condition
Message-ID: <20251001113145.72e10530@gandalf.local.home>
In-Reply-To: <20250924080118.425949403@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.425949403@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wm1u53iazytns5ejtjdsh13a91rrk6bk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CECBA2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NQk0AiKdfmpm0DXOLHjBnoUgAsU6cNCw=
X-HE-Tag: 1759332607-190467
X-HE-Meta: U2FsdGVkX1/lqmIJhBB/K2L6Gh7XKgysIB7soH30sjN++xRp9QFU3SXockUFgkpFdSHQjf46BNjBnd0r8pBpg5ZnaeFJh4aDfPWFwTQj3qYY0qcpHmdb2oRUB/87A4cjRZiAqjGI0hKvP6YmXXmSg6PTwfYotZ0h0JdYb6zeqpy9o2hTwMHfLd2jmTyYE5yO/i1a6XYIQFO/Fdv7ff8w8jKQ7BO3zT99Np/GaIX9lQaPME9ZUSLrCJJWkfhwVIkZ35KhM2XoFv4DIZTHJevm/hRq/TfO7+7RONmgp1VvUCt4QJpF/yT82oskjDom3RAjE/TMb9gqP9IGpOdMamqhU6xLq8rM1ieR2yyMKT7hfytNzJSne2uYu8+79DZbJJ4nJGh4j8H82tdVuuuzbgWLeLwuYRU0wMN1e6ol4QX6UMvimJlMmq9/Rt6GQKKx/jh2/X0HnEi+pQ2mMLcbrFe7Lg==

On Wed, 24 Sep 2025 09:59:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

>   __schedule()
>   // disable irqs
>       <NMI>
> 	  task_work_add(current, work, TWA_NMI_CURRENT);
>       </NMI>
>   // current = next;
>   // enable irqs
>       <IRQ>
> 	  task_work_set_notify_irq()
> 	  test_and_set_tsk_thread_flag(current,
>                                        TIF_NOTIFY_RESUME); // wrong task!
>       </IRQ>
>   // original task skips task work on its next return to user (or exit!)
> 
> Fixes: 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify mode.")
> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

