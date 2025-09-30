Return-Path: <linux-kernel+bounces-837687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700BBACF34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99A31927E23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BC302162;
	Tue, 30 Sep 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kd34YU7l"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944311B4236
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236994; cv=none; b=HDpUNL8pbLyyQx/vBfW9viBiDBT4oMjjS2CDxlym72NSB7g4Eme97Mx2ka0znxAF/KbK4mLwgm/01baYbj6oa6N1HDrtaSNfD7vsrRw1HJ/pFX78NW0xjJwcNm2Tt0b30/5zgDbFdKmVCYXxB5giYYMoR0w3PQuk9NGpJHafTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236994; c=relaxed/simple;
	bh=wuaEAs+MU1Pb9iRm11gp6YbHtZtL01yl1DyTQQnqHYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT3J5mwyQRlDcOV9jCVo+vy7A6IWLN+aVhc0Ga7kgaxQ+HfiN9789TXnBC2SGsYm7YbqOlGHR7UD9qcIKAsY4f88VMZj4+4DcUR0fYWqlT9to2mP9Yt1ZM6zhc0NVfRsnJ0piMsrjIaNB2eAKarSBhqA59PNqT6JGSFp2jrXl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kd34YU7l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q6hpUN6CbROxQUt5hksPnXbH91Pde7bn8IYk5dCRDS4=; b=kd34YU7ltg0x9Af15t1xvzVcZT
	pncB5xeX3ktq+CTRx31FP9Ha1cSUsS0PdX6S5n7bmjIReIW0hRC7E+kkgSh/gUit5EUFo1+CsFoaf
	1sHORkZb0qDNtyAXO33PSJLQSsFaQRiKEdsZZpz/dZ6aJxMkbQDSML0rHS2iZnBwJ2r+eL+CIFXco
	44mbSyzxDZLwWJCvvDt3cehdDW4MqujnyagGpcfrZlVGpnUyjK6VqhytOp75PzvKtemi490nZp6RF
	Kfdaeyg7ZRTjQgcbMxq+093CLNEwBgnlvVsFgNEsiYlJd6yDFkc9JCYNTJTIWUwkLCMdY8wYNspke
	9a6AIkDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Zu1-0000000CqDm-45oY;
	Tue, 30 Sep 2025 12:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A77D300220; Tue, 30 Sep 2025 14:56:21 +0200 (CEST)
Date: Tue, 30 Sep 2025 14:56:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Han Guangjiang <gj.han@foxmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	hanguangjiang@lixiang.com, fanggeng@lixiang.com,
	yangchen11@lixiang.com
Subject: Re: [PATCH] sched/fair: Fix DELAY_DEQUEUE issue related to cgroup
 throttling
Message-ID: <20250930125621.GO3419281@noisy.programming.kicks-ass.net>
References: <tencent_3177343A3163451463643E434C61911B4208@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3177343A3163451463643E434C61911B4208@qq.com>

On Thu, Sep 04, 2025 at 09:51:50AM +0800, Han Guangjiang wrote:
> From: Han Guangjiang <hanguangjiang@lixiang.com>
> 
> When both CPU cgroup and memory cgroup are enabled with parent cgroup
> resource limits much smaller than child cgroup's, the system frequently
> hangs with NULL pointer dereference:

Is this the same issue as here:

  https://lore.kernel.org/all/105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com/T/#u

  ?

