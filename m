Return-Path: <linux-kernel+bounces-873945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857DC15246
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8416465B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D038337B8C;
	Tue, 28 Oct 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoHc/qo0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7C3376BA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660924; cv=none; b=YKGqOA6u1/6/GhbP8HwuxNyOQQxyxf9bABjUAKfJiXGVqWu+ErjBH/d1QdZdqoFHCe0XXWlcLLVYFihiXDaOjU+wPUlu6xsM60BpHFZbZvYa+0Clzo0oWCrK9jyffEMl3FSvrktqBMMpFPLzdqo/4txb2YKaCugEQIyXFicwiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660924; c=relaxed/simple;
	bh=w6W58KPIqppLBJ8713spB2vK0wRO9BnnMYzmPBcmjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3lhlxcwKyfGzCLAPm2w2Bq3HaZ9DH9V5KawCpYawZGhCH9E4ih3sCw/RQeHkyZg98yMA8WT/Qr/eMr+Qv3azb3yuvX9QDTO98mMo1Ryw9IVSEF0L+BCYRDSYLgJH0m20d7qYazSQPLYjOXtXd73TXNat6/w60gyx9AoGo3oRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qoHc/qo0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sz8Vgt55hTJIM/bJ/oXGjLSRqQof2L2ZpnvW6wpuL5Q=; b=qoHc/qo0Xrc/I4IakGBs2dLz1Z
	eMMC0VQu3Uo1UOgQ9N4FM0oczjqQ8R14itQZvCZKeN3RSmWWcqTYMctn1NVgNZUqlb+WLDH1UXWjN
	qTQW+EtIg3XgIJMZhPSQPRCyEjxUgp4nzW4JQk4l0JXJp8oDJ/SvM2QnI65Pv3dKqvVlnkT4wV+lR
	LtKs5X6+lOI9scSLJCazJm8TNNM5KDCrLP1WLw4wt0SpULWPUdSB7jNdE7wYqunavUAmVzCwtw6Vc
	3urCHQPePNGqCA3Lf9+9WEu4b6iROdoVhpP7UpzOqOs/1F5B35ZppG0MTBZuT2cRyF0236EREtNFO
	mOX2bdzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjc3-00000004X0u-2dzh;
	Tue, 28 Oct 2025 13:19:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67B39300220; Tue, 28 Oct 2025 15:15:18 +0100 (CET)
Date: Tue, 28 Oct 2025 15:15:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
References: <20251027212724.1759322-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027212724.1759322-1-namhyung@kernel.org>

On Mon, Oct 27, 2025 at 02:27:24PM -0700, Namhyung Kim wrote:
> On large systems, it's possible to trigger sched latency warning during
> the DS buffer allocation or release.  Add cond_resched() to avoid it.

We're >.< close to deleting cond_resched(), it makes absolutely no sense
adding more.

