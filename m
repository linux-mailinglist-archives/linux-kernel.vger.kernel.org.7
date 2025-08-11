Return-Path: <linux-kernel+bounces-763227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40251B211F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC908188DAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3C24679F;
	Mon, 11 Aug 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liXkgtiG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4E311C00
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929310; cv=none; b=lMKzUM4N7/eQXRNh/lNEUyUmXyQci/tzKcAGDCGFdAh9h+7EigdOiEVCDun3DBnvMqkfVHwRlVFKh4iupaMzs1CA1zgFcRRItMva222heImV2TWfZm9749b9uAe5fJk/yFYBzfGeSNaUTWnHTnRCbWkUlMDKjVCX6Vydg1XFL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929310; c=relaxed/simple;
	bh=6YHqt8dWj0fcOgUOsveewDH79nk5pj47gaZ/Su64I5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwclMEsZDbSJOfxzVLr4uEvYMTc4R0g1it6JOSFt8eHS9VNb0fbHG3IChvhEn3IeIZVeO89StM6yyGnUF3u+HUUyoWDe3fMqR5TFM0q99nDWvWNcynVGqqVj2nPwnQC+w+rJnwP+kPr8SqPgT517Pji1NU8vX3Z1B5wmiSUERtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=liXkgtiG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6YHqt8dWj0fcOgUOsveewDH79nk5pj47gaZ/Su64I5g=; b=liXkgtiG8wbNgpaQarlZkHQgSv
	4p62NrRciMPAFBLxsx6b3UgfbH1VRls7q3wuLWWT4QXhZwkLfA+k8BrmH57rx9AvlT50SOx9iFXCI
	hK5WidfqB160MtmCqSx7nxFphlYXxCgkCQ1RUkv7o1+XseT/c6WF/OxE6LEuPKRr4EqV5Snrc0UtZ
	E7KVMcaENnK/+GZk75OVQP1a/rHP1Youbcr3qZGtMc5vhzoB300fGlIlFfUzAUlcio3d/+woqjSdu
	pNtXxIh8YuOWlZp33QNposlBXE+ioEqZ+iidTSGhXRKtVY4gbodlE2zo5yq+8QSiQPNNMKyzQ7ggD
	aXCC5mPQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVHG-00000007Mvu-1fZy;
	Mon, 11 Aug 2025 16:21:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CCDF9300328; Mon, 11 Aug 2025 18:21:37 +0200 (CEST)
Date: Mon, 11 Aug 2025 18:21:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	Suleiman Souhlal <suleiman@google.com>, airlied@gmail.com,
	mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, kernel-team@android.com
Subject: Re: [PATCH v3] locking: Fix __clear_task_blocked_on() warning from
 __ww_mutex_wound() path
Message-ID: <20250811162137.GB4067720@noisy.programming.kicks-ass.net>
References: <20250801192157.912805-1-jstultz@google.com>
 <20250805001026.2247040-1-jstultz@google.com>
 <d737c0f0-c0e0-4df5-8246-b484db8d061b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d737c0f0-c0e0-4df5-8246-b484db8d061b@linux.intel.com>

On Tue, Aug 05, 2025 at 11:27:47AM +0200, Maarten Lankhorst wrote:
> Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Thanks both!

