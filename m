Return-Path: <linux-kernel+bounces-837375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF5BAC2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDABC1921CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00616277030;
	Tue, 30 Sep 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHKvfUo6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440D13B7AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223021; cv=none; b=FCyh/VxLeWujt5CW0DXi4IUva+ies+0mSXzEcIGMtgmhGCAidgLNZK3p6vmeevHz65tSK+VHbuVXsqD3CDgE2M5SXLnL/dNYHBYwWxoCrUxy3oJFJsXGHEvmhDxQQx79bWliFmdY8aJxMSFDo7WXwMAALvNYZQT0lBwOQqm9bnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223021; c=relaxed/simple;
	bh=qWS5rNgUGgzle+jqWsp87QqozEh6L+jJBSXSaTqlnEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT0Crm6gj5r+Lu60nrbnrpAVk03vLOlDcWgkzPylU/5F6x+x0KEj8WZXZQyYv+pS0joLcx+/12aMMSsStMLRSibO8+nar3avRRaXHhfz2ivQlvLRIOBnGnSpvqCGvHIHZ5UL687m9Qd6BGCWcYS20EG3cKF9T+BqU6VkI9nraHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XHKvfUo6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3bQJ9wWoUn4DjHfDf34doK6NmnBZwFVYWz654EUSvPw=; b=XHKvfUo6Bx9vw/F8odXQmkVW95
	fqmRHe4xWrYBZUDCduEiqf7IOY55N/3eMnqRNqA/6wffHlic9OV36puVpqIxM4fX5P6iEUnKw1TQZ
	RUY1KhS5InssYgEKRxubq09q3eIcgOzY0BUZ01jgBgHu6FXNHwBD/NsNdta4kOV7QzfI2BS29hWKx
	Xw55W009vrnb+IGzBgJ7uv39sHdMEzgjWtEYTcOdCxAVs7fG6sA4ve0pP/09B6WzGF4WM6/L4vzvk
	/9ifpNgTlkDwP7wBPiqaI5XlMw9KPwtR1+3D3IYVkl7qiXLqzqCjBKrTyjTciO3JwgmX+oKh3hzLi
	oYQmh1Nw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3WGk-0000000CiUO-38X6;
	Tue, 30 Sep 2025 09:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 533E1300220; Tue, 30 Sep 2025 11:03:34 +0200 (CEST)
Date: Tue, 30 Sep 2025 11:03:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <20250930090334.GI4067720@noisy.programming.kicks-ass.net>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:47:33AM +0800, Pingfan Liu wrote:

> > > This patch uses the rd from the run queue of still-active CPU to get the
> > > correct root domain.
> >
> 
> Sorry that I haven't explained it clearly. I mean the still-active CPU
> in task->cpus_ptr,
> 
> > That doesn't seem right in general. What if there are multiple root
> > domains; how does it know which to use?
> >
> 
> In the case of task->cpus_ptr, there should be only one root domain, right?

IIRC there was a corner case somewhere; something like clearing the old
cpuset load_balance flag on the root domain would not iterate all tasks
or so.

The result would be tasks with all-set cpumasks (the default value)
spread over multiple root domains. Every task would be caught in
whatever root domain it was at the time of toggle.

This might have been fixed, but I can't remember.

