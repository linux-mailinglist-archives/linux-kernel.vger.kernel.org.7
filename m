Return-Path: <linux-kernel+bounces-889970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99857C3EF03
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F534C387
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5F30F7E0;
	Fri,  7 Nov 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8tU/REP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186E1DE2A7;
	Fri,  7 Nov 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503949; cv=none; b=EqsqoNPwlAZ7hGf/x5GUr0bY8sf7awUfDPoV8McR/xFsiwAvO2/RJ7suFS+DXw2Swxd0dl9STszb1s3+QbBRx9AX8LZMIDQIAYDu0WCHuuIeO1xYKH9LHQlwJeCtXz3hweNimMgzXs4bjAtl7R/b7ee+UrwvORGuMQRQP2Pl0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503949; c=relaxed/simple;
	bh=fSXTU+ZmbSrNyLZs/hXw56XEFhnbmazFyETIJgsmYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUTsabbnMPNb2SEjRwpJPXuk1ndJWBfCgImKj5ixJ8yt6f6bj//lFkTbcWvaX/DBNyFHlVvPn95lGOz/anAIn9VZoPUi9Aa893bBowbR/Fo2kK2l7k0NlgAtjxKOmCdKcVHk9b7C1UHTs9d4uhvfihRDRdg0Hpy8YtM0+M35WkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C8tU/REP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ElT3P/iQ0ud5lYAR0km91yYuetFA3A5e1fStQ11xLmY=; b=C8tU/REPeIXlYzRQOU4tafFYZt
	68jxZ1j+smi0Sx5VpNF5wnh21aWwBmllH4q8HZqfH8bxNLQPySJiPj+d/5eQehm5XpcLTFzuTboQT
	DmX1F74WZFpccVQW0gq42mlu9vp+TLdjpCzb2GKxRJ5npss9b/n1qvI1Du5RJ5yALPu4DGB2cowG4
	Ba49ikld7zPPJoTDx1Xabgh16bF+9LLvsAlHO2QSGiJYr13j0Ggc4XPvpgMBtDUFUdtbzDOvC16CC
	n92gSHJQ2OOybHgE4Bsf7Cvn8o/jMzYb1Xn4GJAzjfvktCweuRznJzmOQKG+Spvo65ACSP0cF1+TU
	OIu610YA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHHmp-00000004c0s-0LMh;
	Fri, 07 Nov 2025 08:25:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A0143001D4; Fri, 07 Nov 2025 09:25:33 +0100 (CET)
Date: Fri, 7 Nov 2025 09:25:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: kernel test robot <lkp@intel.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, jschoenh@amazon.de,
	liuyuxua@amazon.com
Subject: Re: [PATCH] sched: Proxy yields to donor tasks
Message-ID: <20251107082533.GA1508773@noisy.programming.kicks-ass.net>
References: <20251106104022.195157-1-sieberf@amazon.com>
 <202511071431.9PLsHNo5-lkp@intel.com>
 <20251107081254.110947-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107081254.110947-1-sieberf@amazon.com>

On Fri, Nov 07, 2025 at 10:12:53AM +0200, Fernand Sieber wrote:
> On Thu, Nov 07, 2025 at 02:31:16PM +0800, kernel test robot wrote:
> > sparse warnings: (new ones prefixed by >>)
> >
> >>> kernel/sched/rt.c:529:55: sparse: warning: incorrect type in initializer (different address spaces)
> >>> kernel/sched/rt.c:976:39: sparse: warning: incorrect type in initializer (different address spaces)
> 
> Thank you for the report.
> 
> The warnings occur because my patch changes scheduler yield functions from
> accessing rq->curr to rq->donor, both of which have identical __rcu annotations.
> These are pre-existing annotation issues in the scheduler code, which has been
> directly accessing RCU-annotated pointers without proper dereferencing, relying
> on runqueue lock protection instead.
> 
> If we do want to address these sparse warnings, I can make modifications like:
> 
> -               curr = rq->donor;
> +               curr = rcu_dereference_protected(rq->donor, lockdep_is_held(&rq->__lock));
> 
> This would have zero runtime overhead while satisfying sparse's RCU checking.
> 
> Peter, let me know if these warnings should be addressed.

Nah, I'm happy to ignore them to retain readable code :-)

