Return-Path: <linux-kernel+bounces-834305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF87BA4627
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB34C5A43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F60200113;
	Fri, 26 Sep 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CruHusi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6etWZQZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDB1FDA8E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900119; cv=none; b=FiNyavn0j8SFpCHTyao+AQzzkTWKjX4Gz1V2ZM1XU7E1A1xYd90MVIWpxE0uX68onucQq5n0dRmX6XbZClljMStpgZGj13jsXuyoMcSIzt5792mx6g/G23i69K65JyiOMaatOnkyUs1dgGehIB+mqKvfRIDJCEMPPi1i83QR1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900119; c=relaxed/simple;
	bh=l4G3AasVAML3RXfG0yQ5XZRWCvVo1T4AAk0iW0DInpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGUzUxczeMqE+2mU/r2YV/a5gCbwSWPliPjwPfsfzUPxj1HJoGTA2w86d6MEsFbzu3kP3masJ1vfGj0+qkuPP6ka30UIgnIu5y2i4vFI8Utg5x94Wd4cnijwxIRlg8+s5KgL5ssoDnFmIkyBfg12vzbnpgt/9yxSDwmtHPT8ViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3CruHusi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6etWZQZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Sep 2025 17:21:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758900115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hT8KVPsa5RdyiLGO57N+TwGOktseVB2WsDCUc2zYvM=;
	b=3CruHusiyg2EWDv/yyHV+xL4uFZcsh4h/eNehOGPH+F6oi1D2lNfRT08nJnTw2b4O+y6dF
	UDbv/uFp8c+ENIV3MpoQPp2G2gcbLizhPBmWuFawOmoXCU6HQPx2TZFzBJJBgxPw0I6A5b
	flTTBflg8kh92/rKPKtX13AWUhVRuVl/nHMyBGwrhFhapvdx0+tN9P43J6ubXf/q3/VeaF
	CPwqNcdh9BgW14C5LV2NQULF5XwKyT6jIVpOX6SU2roS/2/cdn2ljTW1eys+q+xMiyL2Vv
	c0fIMNKPNhvMd6vJPg+95auXtVqsw4AVii8g9kJkupMd/OYwwBgTs07hxo0MVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758900115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hT8KVPsa5RdyiLGO57N+TwGOktseVB2WsDCUc2zYvM=;
	b=b6etWZQZE0mgEcqodZ+mRMiw+zt/etkTESdj45IN8C72/j2AFv6hU5rLJ+r7G6uUbAY7Kb
	Xg+pO3X486C/BUCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>, kees@kernel.org,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH Next] copy_process(): Fixed jump logic error
Message-ID: <20250926152154.MYtjJh-Q@linutronix.de>
References: <tencent_5E4F978D9525A58D97925ADDBADDB2193107@qq.com>
 <f6777d66-a55d-46ef-b972-951eb48337b7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6777d66-a55d-46ef-b972-951eb48337b7@suse.cz>

On 2025-09-26 17:11:12 [+0200], Vlastimil Babka wrote:
> On 9/24/25 14:06, Edward Adam Davis wrote:
> > After futex_hash_allocate_default() fails, the logic should jump to
> > bad_fork_cancel_cgroup, not bad_fork_core_free.
> > 
> > Jumping to bad_fork_core_free would cause a siglock imbalance.
> > 
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> Sebastian already fixed this and it's in tip: locking/urgent

A pull request has been sent to Linus earlier today.

Sebastian

