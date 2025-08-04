Return-Path: <linux-kernel+bounces-755537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C816B1A824
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CE61890356
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D72472B7;
	Mon,  4 Aug 2025 16:50:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EA17736
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326209; cv=none; b=giYCqrA0144+tFpdEsz4AzIZVWxCUUAlRZ2OU1WSlcPz8XTSwlgirNSTog9okktFNK8KaGLek06B38jqjh35E5hmjY2LwCNJ6zbrKK68ExOBqILJaR+cKKQXGMeZF2ouyzxQ7g3C9/nC0rTrkdtRG74/ATECjHkJzXQzZaHiQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326209; c=relaxed/simple;
	bh=r6VRaWdG2El15IEHhPAu8O3bVwzPE5/USyg3Gi8waEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kC0ja4DZmMVqMmoK4yGk+sAuacuI+m7Ti6HvoJ7U7FSMhn2La9agjX2/D0CIzSlI59fkJXIwbviBpL3ojaYqAf8DnOxR3vIb6eJP30OlHJWBcqEgeq3Ri5xqMCz+ZTWGl/LRcsU6v/yzC4o2uB4y6M8pJOK2n6g2E5jbPW/gWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A12F6B66DB;
	Mon,  4 Aug 2025 16:50:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id C05603D;
	Mon,  4 Aug 2025 16:50:00 +0000 (UTC)
Date: Mon, 4 Aug 2025 12:50:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
Message-ID: <20250804125028.0676d201@gandalf.local.home>
In-Reply-To: <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
References: <aIcdTI3e04W_RdM_@gmail.com>
	<CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: se95msc3fkt34w3jbygqrze5zfydzs8c
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C05603D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mYfjkhSGjcdUo189c+851q8nlw1IXmOU=
X-HE-Tag: 1754326200-631162
X-HE-Meta: U2FsdGVkX1+aCYL/mqSOWJ4R/vOhPiKopnexKH6eWbv90M+zlBc67hoeKw3VHmZ2Qr8u6gkqMT7rpgyqSKVZ3/I0UZX72B3ZyaHO2DG3oXG4zTxZM80cSb97Qzy0OCoyk7G5ZY/RLS/IjeWe8rbnLRphHwYps9+O49miHes6KBm0j7NY5GVzuoWTGy37liXRy4s1P1cCLbiGNxETNOiL5/RVz8oVWHY3w1J9eqaQaFVFftDCRcbESt9PjPWG0R88vkxid8O/wzzQT3N1P44rbtFFvez4t4g1yDPFV6rxF0IiLLTVbvx06bkaTSYt+jYZT5OH3rFM+LwKp1m4S5ya0ud6nLOLCCN/knGmkY2+SswkhmyBmj3lgpk/CpnTXZAF4TjfzyZ+ITGnQCHmdc3iSjFV/zuWTAnJyTHt9LennJIrT8O3FouTcYGxbp2BGQp4gtmZm0FgvT3EPVxarezw32+uBLVfd/F1a5oatgtlw8cFcawkYS9sky9c7552j57mphvXHl1rEZU=

On Wed, 30 Jul 2025 20:31:44 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 27 Jul 2025 at 23:48, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > PSI:
> >
> >  - Improve scalability by optimizing psi_group_change() cpu_clock() usage
> >    (Peter Zijlstra)  
> 
> I suspect this is buggy.
> 

I forgot about this change, thinking it was added, until I saw this email:

  https://lore.kernel.org/all/20250804133240.GA1303466@cmpxchg.org/

It appears that Peter never sent in the change of:

  https://lore.kernel.org/lkml/20250716104050.GR1613200@noisy.programming.kicks-ass.net/

Looks like this could be your issue.

-- Steve

