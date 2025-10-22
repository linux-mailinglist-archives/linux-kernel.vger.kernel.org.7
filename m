Return-Path: <linux-kernel+bounces-865349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86431BFCDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21FB53525D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AC347FFF;
	Wed, 22 Oct 2025 15:25:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC430E83A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146750; cv=none; b=Kn7qkieluGB8p3A2nNxFPRTULQlw/VHcknZj8nZ9zd6EYXITeb50XoZoITY+kVmhss7N7+fxvHyyBqcbwbfSSnRMOc9TILatwExUB5y9UhhlUDuGPNZkzv4ZSE14wq6vQgCC0NX75XGZTVUioqQln53F22dxCpDmZcgrVUiwPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146750; c=relaxed/simple;
	bh=hbmLrc24WafPnMtHoE1PHeacio9oqQuQ9yoqmgNH92g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWSkYpFcduKsn3JPcYNARECFV5P/zT+5xS7fpKFaDvI/N/Nk6jablBbzuelezfvyY+5nIQS7wJxEZJS/utgqfDS0hqRAkP0MZ4eIFGI05OL7kPMGv/6cZeAqnMCnoEOWWkeB0aqiw8mNuoCvz0fKklcRObNrsROmoqmKjIXfK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4499513BE64;
	Wed, 22 Oct 2025 15:20:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 790EE2002B;
	Wed, 22 Oct 2025 15:20:08 +0000 (UTC)
Date: Wed, 22 Oct 2025 11:20:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] unwind: Simplify unwind_user_next_fp() alignment
 check
Message-ID: <20251022112032.130218cd@gandalf.local.home>
In-Reply-To: <20251020102814.GN3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.497867836@infradead.org>
	<20251001115524.24542fd8@gandalf.local.home>
	<20251020102814.GN3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z56tb5miya7gxd7onjazhfieyeqe7dq5
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 790EE2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UhHQ+lOUxC3gMX2E7U1UG9zm4pStVD5E=
X-HE-Tag: 1761146408-598763
X-HE-Meta: U2FsdGVkX1/IZ42Cvls63khAf315cnHdu1O0Jma6lbqS7EMzEOSWobIFue6omfg5g6uTkngowmSvU0PmEG3L4wXZBBYBAjloM0HOSXo9BIUCBR1NlSUJwX+lvNiBUslGAkQ87aEJ55XwFDgG9YTaF7FHXJVTg36SuFs4Bjv7hLKAY1/7qB8qletUTiJSSugfSuo/E/986rPy9rwdl9mNerIpZAPu9KVgfjBC9ICvACvUWb+BHKmH50+Wnb2gNs9uxLtIGPe/Kvu8aDp2g0CjBQf43eaw5k7G2RVNKyaoLNfAz9tDyecO2WUbxv+Frl7xEJkrl/NkF4/tLjoJxOO+XOKCmvDQEmuXZjUJiV2pFyuYUBzuS2E/epS55x7P77w3Wa9L5+tLdaOxO9z1wIYAQPYEzVGep/LglyGw9EHlaH2Vjl+h1ixcQhmq9XEbVYzN

On Mon, 20 Oct 2025 12:28:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 01, 2025 at 11:55:24AM -0400, Steven Rostedt wrote:
> > On Wed, 24 Sep 2025 09:59:58 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > I would add a change log. Something like:
> > 
> >   sizeof(long) is 4 or 8. Where 4 = 1 << 2 and 8 = 1 << 3.
> >   Calculating shift to be 2 or 3 and then passing that variable into
> >   (1 << shift) is the same as just using sizeof(long).  
> 
> I've made it: "2^log_2(n) == n". I find it very hard to spend that many
> words on something this trivial :-)

What you don't like Common Core Math[1]?

-- Steve

[1] https://3010tangents.wordpress.com/2015/03/03/common-core/

