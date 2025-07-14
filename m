Return-Path: <linux-kernel+bounces-730903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFABB04C18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F218935FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B397237172;
	Mon, 14 Jul 2025 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="c4oMah1R"
Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93122D793
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535150; cv=none; b=SrsYSY6lSfJbG3eCh+DoUwGbqWxCaokBodNqhQ8C8PRCsbW85XC0wIDIY2ONttZkMJ1T+kxU32lcVv3ag0z4OdUFET0tzNLi6Z91Bvv/apurXIxN+ySN+k6KO8Xd6chDybtPYYyZVksgl5h5pCxVz140zqkHfvCgsOLQKPm3k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535150; c=relaxed/simple;
	bh=15smlFaKdVTOUbPUP9CP0kvf/p6tNEWUXECJt3IvWyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbc+txaypfH2wEtmer/E2G+DNiWEkjyu7i3kNIz9l/eEFpSzz2wrrTqk388S6Mr4IcEAT4gzDTGnwGs8FRYBiIJN3Qe3l0mcIFNgVXSVsr13UbNbgaE00+TZHXwAxW3gZO6cm4B5D6bGndZvkZ6y6oHGLKxEPtjYqC/ByQJRTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=c4oMah1R; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id E66CDA0003;
	Mon, 14 Jul 2025 22:59:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=GFx/VDnaMoNzDHCHMoJfq0V6CJYelNnsTbo6pySCGC4=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=mime-version:cc:subject:references:from:message-id:date:in-reply-to:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752533992; v=1;
	b=c4oMah1RUr4V87EKj6egiEaHrSBvWvoKhk774S1JF/qTc89tiSt4y9xeZ6/+UtC7MEV9/12l
	IpkKejEtfNcQduTq2zzy/wYwN5dbQHplVNMLQa3da/sesoysruPz2GZfx7KmvESXocsXd/ZrL+j
	QaF3MIbMHhC7XuXZw1I420+w=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 208FDA0002;
	Mon, 14 Jul 2025 22:59:52 +0000 (UTC)
Date: Mon, 14 Jul 2025 23:59:51 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] sched: Optimize ttwu() / select_task_rq()
Message-ID: <jitpfox6tlodcrpm233xifjlxdcuavgo5loxorwhwnhpvvrlvg@qxca4uarce3q>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.582321755@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20250702121158.582321755@infradead.org>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752533992801915696.2206.7250175810426137197@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=HKo5Fptv c=1 sm=1 tr=0 ts=68758be8
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
	a=R_Myd5XaAAAA:8 a=xT7S4Q1wwyDd-_6OKKUA:9 a=PUjeQqilurYA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=L2g4Dz8VuBQ37YGmWQah:22

On Wed, Jul 02, 2025 at 01:49:27PM +0200, Peter Zijlstra wrote:
> Optimize ttwu() by pushing select_idle_siblings() up above waiting for
> on_cpu(). This allows making use of the cycles otherwise spend waiting
> to search for an idle CPU.
> 
> One little detail is that since the task we're looking for an idle CPU
> for might still be on the CPU, that CPU won't report as running the
> idle task, and thus won't find his own CPU idle, even when it is.
> 
> To compensate, remove the 'rq->curr == rq->idle' condition from
> idle_cpu() -- it doesn't really make sense anyway.
> 
> Additionally, Chris found (concurrently) that perf-c2c reported that
> test as being a cache-miss monster.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.620602459@infradead.org

*facepalm*

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

