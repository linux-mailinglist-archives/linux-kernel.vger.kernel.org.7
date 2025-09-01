Return-Path: <linux-kernel+bounces-794289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC1B3DFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B213AF502
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421D30F81F;
	Mon,  1 Sep 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k81Fohbn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B230F555
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721056; cv=none; b=Iu3yGqfIzs2HltvNfQdYnJttO2/7Pauo6nfzBW6jax3ivzKzsZRBNU2Otxxa29L1r2Pl8ITDAmggcfdYvMDle+5AC28N9BLijrvoaLqvaNzjhOGVeFtzECkdJA2OWnKm4BtgKgBSPCyhzk+4jLE31/7l6zWDCN72D9BOIDQf/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721056; c=relaxed/simple;
	bh=MancrAEGA6sdg9/uF8v3qhw78equA5/hoxm98aHb8ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVW2xIutvy80gS6oBDN73k+DtS07Isz/X/y/Qw84Zb2/TqEUSoL7tdcfESWkASc6HRt24WpqhUbK22QOlB7erGrsc8NuZATRUCobPUUgeZo6QTfxBlD4Ilc8FBaWkpFExpdcyeIJY3BcZt092kHkkTib38RW1NB3wRt1b1hw76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k81Fohbn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MancrAEGA6sdg9/uF8v3qhw78equA5/hoxm98aHb8ks=; b=k81FohbneTQTZBlEDnk0CyDtXG
	dN8wzR74+I87KlL53HPrlSFD9WgjotgPs6Rs7ZOYyg1fAygBJ8mJXz6TE6vWgVdqn9EtxlZTWAYNt
	C+EDwnIS+NjCkFmxWFpVRn9WVTA7gCMz1QTA3SKU9m+vNYKNjS0PVi9LtiiYaSlRViyo4r0ztiTy8
	fQAVE3MTsP5xMmUgIiGu06QhL5RseWa1FTF0AkWtZljp4Ynqo2eE+GS2HBMAYhjrgrRdeDnBphVjl
	73xyAdFyb0Uo/4wXFEvASU6f77PgFGM/mpAHMQGAMO+7k8z9zEigcLymdNsi4mOJlhkrhR2wqfSYt
	LS0plh0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut1OC-00000003hZY-1eEi;
	Mon, 01 Sep 2025 10:03:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4469B300342; Mon, 01 Sep 2025 12:03:51 +0200 (CEST)
Date: Mon, 1 Sep 2025 12:03:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 0/5] Defer throttle when task exits to user
Message-ID: <20250901100351.GG4067720@noisy.programming.kicks-ass.net>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829081120.806-1-ziqianlu@bytedance.com>


Thanks! I'll queue these in queue/sched/core and if nothing goes pop,
I'll move them along to tip.

