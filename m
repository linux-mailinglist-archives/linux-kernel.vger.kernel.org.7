Return-Path: <linux-kernel+bounces-880495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBADC25E43
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4312B1A62C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31126F295;
	Fri, 31 Oct 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHC9Fmsu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F12E1C64
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925503; cv=none; b=LhX0N0FAHw8JIQjQxG1K8Qaa7nzN3ezNGjK12SAGgbrPoWxQKyCLDsrZdr36oczm4g27AB8ds1XKiwf7ApDSjPeJ/+KVsBNVMF55xJPmJr3IlI+ExPB3UFITVtWkHYD5mIw2+PdciCes+tYKYyk9qmCzXkJUYx6fC71SY1mHxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925503; c=relaxed/simple;
	bh=ypMtBGUhGuLGPMYw20TcunN3REtxMlShGKVp96O99z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVVXeDfGh9/VYVH4spv7Yrsp2YeWOHoRh1RGSg7x86j6ugtIuJpehSDQh0OZHP92KmDSW0FUcS/hA68HzJfAur8dvHsCXDKOAPk1yATrslvcEmLcz7Q3JUPxuYwX2GzxsXf1w6Ny9QQDe+/tIg2670QrC8k8PwBcRrAAT6qA7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oHC9Fmsu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u6TEXufq1HcpSsKv+Nf0HEDitWllQk6xb8XmwF2VTbM=; b=oHC9FmsuxpQlml9HeIH8y16IiR
	ML0ETOHns+t4AqqG+ckhyv/dKQnLv5srCtSfz7FvJVbEfxlSxZjPkooJSIZnpwiGNt8R0MeZquKUJ
	GLBdPLGhPKAbb7caahbSZ2uFjyMTpY3V440sUi7O64dDbCierjz1QqiYXoeqc8JJJtWMLi6iCA2IR
	SsLwl0ViTyssoI4PVcXxJb6im7NxOv2i19LzFQgu626te5se0KdOF3ZkPXmXRuOPex6oKYuGyot0n
	eubTQ3TEg22Z4LPl6Igt5YIIp3d2iXl7+LVxExtI1L9TFs6drZ/H9D4OTawwmb4m4hJX0ypYv4X6V
	OcekGdtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEqRS-0000000BYeI-08mn;
	Fri, 31 Oct 2025 14:49:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E2B230029E; Fri, 31 Oct 2025 16:44:55 +0100 (CET)
Date: Fri, 31 Oct 2025 16:44:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
References: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>

On Fri, Oct 31, 2025 at 04:41:22PM +0100, Gabriele Monaco wrote:

> > Humm, let me noodle a bit more on this. Also, I should see if I can get
> > graphviz to draw ascii art state diagrams :-)
> 
> Dot doesn't do it but graph-easy does reasonably well.

yep, just found that. Seems to work well:


                          +----------------------+
                          |        A:init        | <+
                          +----------------------+  |
                            |                       |
                            | 1:dl_server_start     | 4:pick_task_dl
                            v                       |
    2:update_curr_dl_se   +----------------------+  |
  +---------------------- |                      |  |
  |                       |  B:zero_laxity-wait  |  |
  +---------------------> |                      | <+------------------+
                          +----------------------+  |                  |
                            |                       |                  |
                            | 3:dl_server_timer     |                  |
                            v                       |                  |
                          +----------------------+  |                  |
  +---------------------> |      C:running       | -+                  | 2:update_curr_dl_se
  |                       +----------------------+                     |
  |                         |                                          |
  | 6:dl_server_timer       | 5:update_curr_dl_se                      |
  |                         v                                          |
  |                       +----------------------+                     |
  +---------------------- |     D:replenish      | --------------------+
                          +----------------------+

Anyway, back to noodling on how to make it stop on idle :-)

