Return-Path: <linux-kernel+bounces-843360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFEBBBF042
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96664EA7A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563D2D480E;
	Mon,  6 Oct 2025 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtHSBpbk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEB1F7098
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776440; cv=none; b=E/zxP9AcjTmNq7gu6oJLNVFM/+joNZD+3KEEp3tpkhVdYP4jR94mWknPjC0aP+ORUSbghTX2GQaOYwEY9EUFzwq0EH9omnE0nndGgGo5OLpZk1UOzs/Qyb0hOXmIJhf0mhTW8Ub9tfEafTqjbs0/0i4DpA4msZNDV9QCfBoasiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776440; c=relaxed/simple;
	bh=dz3EaTftM68WYDI5QUGLwUNFeWQJc6fMj7wKjs0g9Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scrKDVVeKyoGflqMxoUBVrYnJ3l7hZiAODZ+NTG0/Akf/mgowDU/IVC6cqUZq6eovY/xYWrIsXQmpLdC6/gUHgCvCJhMoOAVnr132qZ9+jS+quVMiw1W0kFqvabPqLGSDbQchiq2xZbwTlnxBRGg+k1r5HoUSZPFhyNr3/aZRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OtHSBpbk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+I2xLAYt2OoMeVLgx0KRyf7wDz88hABcrvYBUZYVCf0=; b=OtHSBpbk6v+Gi2YFRqHbneXhoq
	7fbD2MwtByfjI0zDp/HT03z0Zgk9jcBQPG//p2iPeNgg+Z2YR750sU/UgEGKsT4SHTZOGxRLHOWda
	7jxPOiJ4CCPKOCF7YGpCqZa6IPwcbvJxLzhd/3ooYKnQg/McyaUqmxytjVixcRlOT+uCMi0Z8bl3r
	QuXScJmh2Q7snzjKywYRTY8ZwYC/i9SXxAHNOvZSN0IUHKy+VqKp4kVpapqxe5gJjtAy//AvZ6Ihp
	9mErCrN+NomsrSYj3oLIBKn+SeHWubcv1vm0PiKn8FSdDjxU4Cmgrci+XzhPXjgzW8uAkSAXsbljp
	QPstXGIg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5qEp-0000000H792-1nnr;
	Mon, 06 Oct 2025 18:47:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72350300212; Mon, 06 Oct 2025 20:47:10 +0200 (CEST)
Date: Mon, 6 Oct 2025 20:47:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Doug Berger <opendmb@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
Message-ID: <20251006184710.GX3245006@noisy.programming.kicks-ass.net>
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
 <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
 <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
 <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>

On Tue, Sep 23, 2025 at 11:03:18AM -0700, Doug Berger wrote:

> 
> Is there any way I can help to move this patch forward?

Let me just apply it before it gets lost again. Sorry; sometimes the
amount of email is turning me into a goldfish with ADD :/

