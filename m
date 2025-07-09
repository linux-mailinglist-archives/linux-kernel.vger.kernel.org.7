Return-Path: <linux-kernel+bounces-723543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F8AFE858
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78151C48363
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64412DA743;
	Wed,  9 Jul 2025 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRMeoXt0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1702D9EF4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062011; cv=none; b=sDVl3VKI8Q6tOLBpWecl5aza6IMKpigQUPqczb+kLZDP841SMUQ34lEYKSVzEehkoyrPsAPwmm7wR0BKp6oZwEQ9Pf4tZds7Ddz89fJtG7P0JYmRSDoscYD47ZcdOygomrR6s/SN8w7xncrCW55XfUQ114q5eJP+0aKzwO6v1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062011; c=relaxed/simple;
	bh=iVyKalBrykbQzOyHrVdkLQGw3P47ZSLrUWm1tdumHC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiaOqmfKS3DSCQz7zUp/VvELhce0uJ37MBepB1rCD7M3t6l6U6hEoZPA1lG9SoG34/lOND7QrzJrrHtplGhU+Mla87+5pszq1gJBEStAoKCe9yQ5rmdcHLEhtt1LMgQibODkcZi1eFUmDCOM3y+n2ub93dr4EtQcTEOjzBwY91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JRMeoXt0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iVyKalBrykbQzOyHrVdkLQGw3P47ZSLrUWm1tdumHC4=; b=JRMeoXt0wH2Lpwpr5tp7v9eLDc
	z+eOt68MS3S+fbCTe/+b8pfMqtGoAYw5ihlWNHn61aQs8r1vob8T/4Ek8vJNhJ+KtbvmScNiQsoIU
	GmBjL30ID5/dyVoiUjEUllB7n5q+x4yTN18AndTxZdUhB/VRtpyKTod+UbpZVrq4wDEOOJfWzFMpx
	G+P+IKaW5/D+GGvamlWjPmmmp2DsLAVwLHIEvAAKjjaeEjK+SzorfYnemJcyF0p3AeyAcsn7EVXm8
	Tn1fh5qBcWaJRVd/nn2kPOR93rP9teKF/0tfQtf03vgpG6m2OLyh+Dk0AhY0PkzDxEhYzzBGlVFDv
	I2bDeJYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZTMU-00000003n6p-3JkX;
	Wed, 09 Jul 2025 11:53:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E54230029B; Wed, 09 Jul 2025 13:53:17 +0200 (CEST)
Date: Wed, 9 Jul 2025 13:53:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
Message-ID: <20250709115317.GK1613200@noisy.programming.kicks-ass.net>
References: <20250709093829.3213647-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709093829.3213647-1-quzicheng@huawei.com>

On Wed, Jul 09, 2025 at 09:38:29AM +0000, Zicheng Qu wrote:

> The best approach should be to dig deep into why overflow occurs, which
> attributes lead to the overflow, whether it is normal, and how to avoid
> it.

What kernel version are you seeing this on?

