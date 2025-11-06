Return-Path: <linux-kernel+bounces-888297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59FC3A726
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED433A647E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613DD2ECD3A;
	Thu,  6 Nov 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3gmFzIt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AF2E7F02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426667; cv=none; b=knQlFdPWPrWP9+5xA+5HAcpguPWhkEvl4NaLzKygDZL6iFl/UMyw8l+UL4eZVe1w/OEV+mdDTh9SPQY8KKR/lNUC4koq+rXC2RkbqATigiAg664lvOngAbuo/ICAyrGsnaAscqUted7+sVwB+T4GL3Z8GC2kmYH/D/AimpUZbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426667; c=relaxed/simple;
	bh=Pl/TCYsk7V6WSn1n4LeDxsgZRuuIxN4Rhgs2WV8q2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MePXJoub0I6zzA7bHxkH0IozDVSow3Ibt1v/sFeN2ROlxkj8Rxf549AFEOP3zW5f/zl3MdFgs32uViyS+Kp4lIlkdj8PzSyzW+g/LRUZxJOdNyiOtcWbFN+feRpblSXPWuZ1f3C+qNCB85x8ZiD1DC++24/Wn8OFEQWWkwJL5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o3gmFzIt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0m6PFCBA0tdiO6/JLX6FEs3Znbw0AJruUg5H+BCkQY=; b=o3gmFzItLW0iv/YXWFDoC1U4YV
	QRRavoElVArMXQTxR2z5TzTnIfrbS1sDvixU+GbqqQFcXLa4jJYHgHblAP1kV/JmuW86oPASGWIEl
	YAJZDzLr9MELf65iTPjI+mY30tzvilWjq4DgC0AHJ4p3HJWILWGqZtLTb/m1IxZLFewuctybSZ80z
	1QuQEN8tf7N9l6lqbwaJbbhL837/uMauf5GQEz8UIddNyOeasYgLzVSbLLJH/0qChyaBrqER8frd8
	RnbW4jzq4YQc+cyl7Rw2Xozi4VtXhV20rxozNhrP3DB7/i9Me8NlHh4NilWsPRe2gXFKO45GzH5gn
	Kbfs+/XA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGwoh-000000044QJ-1bEa;
	Thu, 06 Nov 2025 10:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F142300265; Thu, 06 Nov 2025 11:57:35 +0100 (CET)
Date: Thu, 6 Nov 2025 11:57:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk, jschoenh@amazon.de, liuyuxua@amazon.com
Subject: Re: [PATCH] sched: Proxy yields to donor tasks
Message-ID: <20251106105735.GO3245006@noisy.programming.kicks-ass.net>
References: <20251106104022.195157-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106104022.195157-1-sieberf@amazon.com>

On Thu, Nov 06, 2025 at 12:40:10PM +0200, Fernand Sieber wrote:
> When executing a task in proxy context, handle yields as if they were
> requested by the donor task.

I'll modify this to say it matches the traditional PI semantics.

> This avoids scenario like proxy task yielding, pick next task selecting the
> same previous blocked donor, running the proxy task again, etc.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>

Thanks, I'll add:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202510211205.1e0f5223-lkp@intel.com

Also, for now proxy and ext are mutually exclusive, but yeah, might as
convert that one now too. At some point someone will have to go through
all that.

