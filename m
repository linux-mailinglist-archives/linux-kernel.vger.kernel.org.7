Return-Path: <linux-kernel+bounces-724617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E573AFF4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D7C3A8938
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA57191484;
	Wed,  9 Jul 2025 22:46:32 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58475944F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101192; cv=none; b=TS3hMu6uZL/Cp//HJ8Zao3CQUGOxiY8kricGjzElOCCwKAUPkrxFAt6XnDWfyxHcQWT1KuZsHPCtf2UYNyYA8qV3Q4inF4f3wrrQdSQddvh0+sk7ZJ02qDzRXM9sDLerX6svTUi3iHEhUdTPVXhB9lLm72Jj1PJmwf9aN0uJL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101192; c=relaxed/simple;
	bh=pZi8pi90uc8wi6TyC83UlDQE78r6g14/m4gdNOHaUbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAKQQ0iXANuFtYvKv8vY3yd/BpGT2GT15mGc4TtsZMHjFknKXrA+hyxwDY0RO8RrqEy1hYlRzxu664ngMmU+5h9Icc8M0y1E8w7fGv+SCWhVum4wcg7Vr+0WMokxyrwS8PuYNnnSnpsYrqXQVIZc6M8hq69Sk6+wDklJqsAhUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 77118C0203;
	Wed,  9 Jul 2025 22:46:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 2A22B1B;
	Wed,  9 Jul 2025 22:46:25 +0000 (UTC)
Date: Wed, 9 Jul 2025 18:46:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jon Pan-Doh
 <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek
 <karolina.stolarek@oracle.com>
Subject: Re: [PATCH v6 1/3] lib: Add trivial kunit test for ratelimit
Message-ID: <20250709184629.563f0cab@gandalf.local.home>
In-Reply-To: <20250709154152.8d2a3de8894b80e4d85d1692@linux-foundation.org>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
	<20250709180335.1716384-1-paulmck@kernel.org>
	<20250709154152.8d2a3de8894b80e4d85d1692@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2A22B1B
X-Stat-Signature: irmu8sjxb36pmyzf4to4iwgmfwt469cw
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+EKxa8G6L/uT54ZTcXzhpVDxUd73R4Ols=
X-HE-Tag: 1752101185-70261
X-HE-Meta: U2FsdGVkX1+Ox6Lduli2zLwUfot5WzhCSIjHvTWfXEf4TiUeEl8TGqt8DmO+HTj9VOoPNbsQVzOvEMSfVlQ0RXWlh06D5upbs2fHo3B75Gme1c8HtdkwraSva169V7RjQ1aQwj/KmFCTC5hFWqxJGa/orOq/d6MBIrt7jwB2f9mOQj+dVbikgFKCDoq6zdsm7x1wN0duCpvb5NbNnWJXinZ95fnApuf3ORobjJ6NPE5E0FNkfhjAQynb9h1vfGwv/wSz+a59nSSWSPXVgSVdViYHgo3SK7L+tY098wBtvC7KtPwCWMaqW2FvBy+WczgTizsVxyi8MeSMGxR6Potl5r2f0ySoohpynS9Q8rB1XxQITbUx+xFRL4TrGVAICox7YG6mTSO7tSdsXsa/KmAsc20HP54YPWiRPetBOcgLTXlg0La1Tvag6MGDa6vHeupq6qmIw7if+q4Ezg0L3+RPBfrIwmXYppRqGTKNMMfeI/c=

On Wed, 9 Jul 2025 15:41:52 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed,  9 Jul 2025 11:03:33 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Add a simple single-threaded smoke test for lib/ratelimit.c
> > 
> > To run on x86:
> > 
> > 	make ARCH=x86_64 mrproper
> > 	./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_RATELIMIT_KUNIT_TEST=y --kconfig_add CONFIG_SMP=y lib_ratelimit
> > 
> > This will fail on old ___ratelimit(), and subsequent patches provide
> > the fixes that are required.
> > 
> > [ paulmck:  Apply timeout and kunit feedback from Petr Mladek. ]  
> 
> The above line makes me suspect that this was paulmck tweaking someone
> else's patch.  If the authorship correct on this one?

Looks to me that Paul just took some advice from Petr and was just giving
credit. Perhaps he could lose the "paulmck:" part?

Perhaps:

  Suggested-by: Petr Mladek <pmladek@suse.com> # for timeout and kunit feedback

?

-- Steve

