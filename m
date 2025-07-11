Return-Path: <linux-kernel+bounces-727611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C1B01D04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD4216A962
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E42D0C8F;
	Fri, 11 Jul 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTj6ISOa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AB288C06
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239403; cv=none; b=L6pLziPB6aB754qdoHmAdPYedysiDAzdJ+W3KWbNJ8ByxYIUquoG7e42Q6zkOBgHYNjTu+l39TqlMBXSSZcBgiwseDl6r6DUUfV8BTAVO7A8nOSPGgQFF4iNfZHmj/w01ZsDGFT359fkpgfKqRbiO5EyqVIaZWNSDRegBfkMKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239403; c=relaxed/simple;
	bh=l2kgkk9xNpPa9QiKWIP+KxN8wWr1r7M8UVfBRK/jcPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kroUxnjrQiwHb5SlBLGaTqyxlWG8LqtKFgsIQqN1o+3scSlftEIUPvc2mdy/C1rwXuTL7s16uXghafMCyx41kYrNuZGXBXbJlR9Tw+AllrVn/1klpSnExX247HBOCw7HOP1rIew3upKelKIeK6Y8RctNBDSUCZo8Cv6lMBaH2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTj6ISOa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jJ9z3gVvaFTh21iGXCCDg5+8s0Zk5FZyfClCmjPL2vM=; b=nTj6ISOaQ1OJrMN+G5W3vqtktG
	MtJRpu06PcdPCVJ8VrDcm9LzHu8kl5oiUa6iHIBX2D5r+zbTnIlyFseOAGELImrlmyygK5/fcvHd6
	N4ZY8n7af//G3mpX6aoDxx18pL43aMPjML0KE0g/VOZjOo3zJ662oGRoLtJJTWw9wtipxJ6JOlll4
	ctuISOcMEdUB6HuFeLcLAIK6/5CxAlrhIUyHoXFKrQIp9GzkTtKpZE3pAOZTVhk0KaiL2dN2ntm0l
	b8KMTGPsnaVCyFO4/H9pBbY9qAPmqKjgA1MIUE041cZADn8tNVoK1Byajro22+IhECkA42GJZGUbs
	ftMCYPXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaDVj-00000009GRR-408q;
	Fri, 11 Jul 2025 13:09:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D0903001AA; Fri, 11 Jul 2025 15:09:55 +0200 (CEST)
Date: Fri, 11 Jul 2025 15:09:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH RESEND] sched: Change nr_uninterruptible type to unsigned
 long
Message-ID: <20250711130955.GE905792@noisy.programming.kicks-ass.net>
References: <20250709173328.606794-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709173328.606794-1-aruna.ramakrishna@oracle.com>

On Wed, Jul 09, 2025 at 05:33:28PM +0000, Aruna Ramakrishna wrote:
> The commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
> 32-bit") changed nr_uninterruptible to an unsigned int. But the
> nr_uninterruptible values for each of the CPU runqueues can grow to
> large numbers, sometimes exceeding INT_MAX. This is valid, if, over
> time, a large number of tasks are migrated off of one CPU after going
> into an uninterruptible state. Only the sum of all nr_interruptible
> values across all CPUs yields the correct result, as explained in a
> comment in kernel/sched/loadavg.c.
> 
> Change the type of nr_uninterruptible back to unsigned long to prevent
> overflows, and thus the miscalculation of load average.
> 
> Fixes: e6fe3f422be1 ("sched: Make multiple runqueue task counters 32-bit")
> 
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

Thanks!

