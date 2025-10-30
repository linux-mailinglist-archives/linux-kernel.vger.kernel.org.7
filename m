Return-Path: <linux-kernel+bounces-877865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE0C1F3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727AE189F0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940A340A7F;
	Thu, 30 Oct 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJmcldq6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F9340293
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815666; cv=none; b=lmR6C4rDhOja4cACjLvOIZDFzrpg9+/1FCzujGz9UyU/ZVHFKZhaaBE9b8ZofwdXW6xSt2HV6kpu+blUx/PHnfRHauVN5HT3NDWX51P1yizt5zxCpfKHU4V2/6UfwXbj7XhxxQwpLd73RKNDhc6OdohjeiZc3H5LHmCa4RQBwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815666; c=relaxed/simple;
	bh=VTHuoux7iZ0H+L1zsN9nS7CmPv6xdJAR4YnXRw7kosU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbaK+kl/SX5ZDEUhCgfJtaMmcEwi7TcdfmS4uLkvYSOaTPDN4pJkeFwlvBXdbJ2YMmQrfZRyWZoXE6nIOD6F2+mYxqcfDrvTWAQ6lGjqtCRQo1ZGTv+G3W8oaDTVLRDK8lh2c9cG2cHm+csHSOIvybCYHZ1istvttwoWCKBCsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eJmcldq6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DlaN7HNAG6kMS65pXiDWQhmd2EIlQNxi6PRcrBNdhzo=; b=eJmcldq67cSTMBU9v4jGUPCuCh
	c+RjYc7GYsOU5Jk1Wx1M4FpsFXtkun+TDy2Tt1UKyrShf2IxkavPcKhyZ7IdNEgTt1eEOwzQhFmpt
	nQWQKKojBOnHZI9BI90soQ+YW4O+IEuh4djlmS7L4WvRklOMXJhmSikCwdPg0XemR0gcdm5vxLRzj
	0xUulE7k618cPHJHcY80Q66Uuag5CeXlaDYhB6ZBWNn7O23ofYhHe2LkS2FVDmXB88nm5gebA+Z6n
	3ZSjnNDsxmr0KeJghnT+e+ctCueNb/DlahHfS8I+LQKq2Ccc8u467bwF703Fab4xNvQblmO7FkBzu
	G2rcrxgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vENro-00000008kRe-3DiU;
	Thu, 30 Oct 2025 08:18:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58D7630029E; Thu, 30 Oct 2025 10:14:15 +0100 (CET)
Date: Thu, 30 Oct 2025 10:14:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, mingo@redhat.com, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] sched/core: Remove double update_rq_clock() in
 __set_cpus_allowed_ptr_locked()
Message-ID: <20251030091415.GH4067720@noisy.programming.kicks-ass.net>
References: <20251029093655.31252-1-jiahao.kernel@gmail.com>
 <ee2746bd-1baa-48b1-bdaf-89c14a21b4fc@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2746bd-1baa-48b1-bdaf-89c14a21b4fc@amd.com>

On Thu, Oct 30, 2025 at 09:34:00AM +0530, K Prateek Nayak wrote:
> Hello Hao,
> 
> On 10/29/2025 3:06 PM, Hao Jia wrote:
> > From: Hao Jia <jiahao1@lixiang.com>
> > 
> > Since commit d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage"),
> > update_rq_clock() is called in do_set_cpus_allowed() -> sched_change_begin()
> > to update the rq clock. This results in a duplicate call update_rq_clock()
> > in __set_cpus_allowed_ptr_locked().
> > 
> > While holding the rq lock and before calling do_set_cpus_allowed(),
> > there is nothing that depends on an updated rq_clock.
> 
> I couldn't spot any dependency on rq_clock() until do_set_cpus_allowed()
> either so please feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Indeed, thanks!

