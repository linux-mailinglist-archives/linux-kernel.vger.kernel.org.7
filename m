Return-Path: <linux-kernel+bounces-839186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445CBB1006
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A311772B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD2259CBD;
	Wed,  1 Oct 2025 15:12:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1125784A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331567; cv=none; b=Usn1azprR3MjszRvYEoG1g3s8p+0COnVXjqsahUx/pPAKYs6j6B03EYri+ezWr7WhGOsT+g72aYDWtxxAoct9s0E3oZga8RwxfjAoawxOgVwtSuaS7Xwx7E/T3J/GHw50XkDhIAXd4Q6p6yV9ciwpko3d1MFTMdJkj6VJKHXKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331567; c=relaxed/simple;
	bh=PO8dNOnR5LdfOYNk43h0r9q0PVqp21iQRVy3hgR2iOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkQeGxVdQiavKIc0A/u8N6YsEttX+SFmEqAfq3XfFWg77b5NaEdfsiY62jXMEJY+9Ok8o1ZDyfF53I/UmW6/bpeIC7NFfhwt4neM1FV7xADp/HcS6gFsUpfkT3xd7BheBzFo6ILMSaPr2SQQqj7ZeagT4AT9XEWXVPd9vRBXc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1EE8B1384BB;
	Wed,  1 Oct 2025 15:12:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id F143232;
	Wed,  1 Oct 2025 15:12:35 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:14:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 4/4] cfg80211: Remove unused tracepoints
Message-ID: <20251001111413.20d229d4@gandalf.local.home>
In-Reply-To: <1a4ee34782868893a237ba70e518dca17147f013.camel@sipsolutions.net>
References: <20251001144605.585204794@kernel.org>
	<20251001144625.373974129@kernel.org>
	<1a4ee34782868893a237ba70e518dca17147f013.camel@sipsolutions.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tk69pqyrtxsbcaippqquy4e6bkwbwz7w
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F143232
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19C1xPYu/Z3eyH3wA4GULoMQUZOols7LsU=
X-HE-Tag: 1759331555-758420
X-HE-Meta: U2FsdGVkX18SHZ2dl+3tzr1Oa9Wf6A0E45jrDCVqLAcXzusQ2gYYQvB+yyKEFc4I2UclXKJQDvK/uQEXRZ6H6WaV9G/zooNT8CGUyMuvlfKvZFb1L4X6FB9XDoqrDXqZhk9ba2XeP7+7Z5CLQxEX+/tKMgJJD9oEdAU8uC+yMmJDArnKAB8KPU4YJh3zGqHgg0OpQBVA08mu0sioNt0lPEKGlI48N7R4relL7gFO8sc0ssc71BDkXhsRqJNkbOgufS/TlyFGcw06m5eUs2FdpkXbuzR8XdhBprgCFmaF13xHpNaJZgGCxAgJ4Gb0iC0lq5HZJ0tuJygBLodYP+9fmKMHPHEIK6lJmeyJAzJsJhvIdtmfINwixfVlKQgQdCny+gNltxOJwfipSxCnuydgN0ivq9LPr3KoYfv4VbYcyNlvhkVUG5atiwrdo2qS4rq46wkI/lb1XFqJPaLfWkV4TE/Z7E+f5erY+8gPby9yxW0=

On Wed, 01 Oct 2025 16:49:29 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2025-10-01 at 10:46 -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Tracepoints that are defined take up around 5K each, even if they are not
> > used. If they are defined and not used, then they waste memory for unused
> > code. Soon unused tracepoints will cause warnings.
> > 
> > Remove the unused tracepoints of the cfg80211 subsystem. They are:
> > 
> > cfg80211_chandef_dfs_required
> > cfg80211_return_u32
> > cfg80211_return_uint
> > cfg80211_send_rx_auth  
> 
> This is in net-next [1], should go to Linus's tree whenever that is
> pulled [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=58febb47b961a91d0d12ee0c1618a7843c0908ce
> 
> [2] https://lore.kernel.org/lkml/20251001131156.27805-1-pabeni@redhat.com/
> 

Thanks,

I didn't see any notification it went into net-next. I'll drop it.

-- Steve

