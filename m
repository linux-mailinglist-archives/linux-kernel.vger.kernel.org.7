Return-Path: <linux-kernel+bounces-857928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C597BE843B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3241AA22B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C4340D9C;
	Fri, 17 Oct 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AUMuWmrW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B82BE03B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699565; cv=none; b=qkxs/xuBUNvfKONpaffoV366iJ6U571BkAXN4udmYV9PvUvUB1ciQRi9h+yo7EgXvC7Okaf2+iyJz7+vDKHBhS1f2goyvRpzZfRDjNH6fMnV78xhW9LWkYMgm/MYfC/5JiWPTBUubaMfFx4QUA9OlXAKmC8jEtzOrc6smEMWCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699565; c=relaxed/simple;
	bh=pIQGPKhSM5rhJpnULbKj2TOAOnhZdKVD6iAy8hQtz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0J5AmMzLl/yyBpx9bGDxTZO4tj1teLnQliLzgZrsK7VNI2dozo4uqZKjjSOBxp7jEqtfd6unTLUyP3uSymquANLKLnL6XqosfU5rgQVR3vjjju1zbNslxwsU/GFWFh2d2SV4S6Frc88MrAHA4JtQ2j7yrLdrqmg/a30yhiBBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AUMuWmrW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NbIdsWgAOxakiSHw1DpF2sYaAbTCd6lgKA726w3e14o=; b=AUMuWmrWHX/+GLnkJrFulHBxba
	8HCznm0ZyLDX74mXJSB9XKamXLGe9f0+1awK1MgoqBUtWAOTJsdw2zUeYgmtHaRyON3UTqTLaH2WU
	xkLRWUr7gldeHarUtAqkmxgo2CBoje+yzQ3HNTDWLyI9btcTNhJI5Xe/IeyXdF5xKeydNRj7RDoAz
	4upzn9axP/h9TloxlFjdD1VebJ9w4zjey/kCmATK8ze9jrvrk/ynqMPFZshU24w9LUEvBsV1PB0Yq
	jBTx/nztEws04MadTWUI4WyHhZMvewQB8kwcwcsDpcwA4ppOCsoZQ+MAN4Xj7FjqDLp5ZWTj+34qS
	Qg5uH1wA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9iNn-00000007W5f-1PPu;
	Fri, 17 Oct 2025 11:12:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D81D330300D; Fri, 17 Oct 2025 13:12:23 +0200 (CEST)
Date: Fri, 17 Oct 2025 13:12:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
Message-ID: <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015172834.694547089@linutronix.de>

On Wed, Oct 15, 2025 at 07:29:34PM +0200, Thomas Gleixner wrote:

> +	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
>  		return;

FWIW this doesn't work on architectures that change their
cpu_possible_mask around (eg. Power).

