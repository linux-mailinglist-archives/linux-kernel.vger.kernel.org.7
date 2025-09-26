Return-Path: <linux-kernel+bounces-833960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5588BA36BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBE6247A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355C2EC565;
	Fri, 26 Sep 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhOkHTMw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD71A5B8F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884458; cv=none; b=Ssi5kdx4V3smp4OD30iZb5InRicdXcWxW8MvvL5bfJF2ZGbrq9iajJbCmaV8bsQ2urNf4HCA/lEu311ZgQAcpD+oRdP0XJk1w3KII+JBOwIE4gw3vvG+DVToUZxUr1V/xqPhiCJVaTHFWgrh2xQtPyRGEssvjvCH9bedMOPTe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884458; c=relaxed/simple;
	bh=k0aioiAOBAjoZzShaHhAoOQJ9xXzEkHUpBiHnBuZkx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmj2P758/QjsHZ7XtKnO2ZxF8IN5J5PibBe7IhD3+VU9fadZDljbpm32RuLTw6ls/nSQpkHKe8O7XPwSxrtYLUiqkwmimPvbH1T1yx+iaecOPkRFF/gsrW9TUCKIjwRyPYeyaWU0WV4PnNG1g7DCUoi6Ri7LuiH9V0W4s3hpLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QhOkHTMw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5jLtimohSkXYYR/kiiLeEyE05nLWXqacLQ9rdnOcqXE=; b=QhOkHTMwTVeczsgJhw0Hd03Ttt
	HfXBEgiQuy6RaRbnYvJG9ngjtdI4NJLZTNNNNVjgJzTiDGsW6D5WbNs/PJu+0J8OLJVJb97TnWFqo
	KaFZCCVEu0larDbRX3Z1cVnFpk7eJB6cCr96Wyz+oifAyO5VT3QxHpkJs9zvSVxEhDe17MPsiTEoT
	etHH3oLfrrwDLK8DhcXWXa3tdRq1ecbTmHYXxpY2zaggSHG+QSJ/B+pZ/lbB81vD8RKwPZAq0/yUQ
	Q1gUqbf2r/VknPr2oRoBg4fQC0wDihfSOdx9jC5V7R+QYvHK9E3Gl+zcBt5nVdsX+kbRsCDHRKeUm
	u+iRmUwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v26Bz-0000000AgB0-2VOV;
	Fri, 26 Sep 2025 11:00:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D4DD3002BF; Fri, 26 Sep 2025 13:00:47 +0200 (CEST)
Date: Fri, 26 Sep 2025 13:00:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH] sched: Fix some spelling mistakes in the scheduler module
Message-ID: <20250926110047.GB3245006@noisy.programming.kicks-ass.net>
References: <20250926092832.1457477-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926092832.1457477-1-jianyungao89@gmail.com>

On Fri, Sep 26, 2025 at 05:28:32PM +0800, jianyun.gao wrote:
> The following are some spelling mistakes existing in the scheduler
> module. Just fix it!
> 

>   borken -> broken

That is not a typo. Also, in general I;m not really a fan of spelling
patches.


