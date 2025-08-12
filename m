Return-Path: <linux-kernel+bounces-765445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2069B235F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE791B627CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6002FF152;
	Tue, 12 Aug 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gowdjz7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F52FE57E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024753; cv=none; b=e6PnP+DYP8xWYm+DMcvLlvXCNi/mA0DYieJCx0zDUFJdW/cIY4C6ZPNUWnqUiG10xod+6bfn18BNjQ/0JbVsTq1uR1cCI2Qcw5gjRD/r2A7hkqafdQ0hv+seCndIHqzXfdw0FYM8UVSCxeKte2qDjS1u2Fp3i0K1kLd991WRAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024753; c=relaxed/simple;
	bh=MrZxGc/QF9ghRGxxSd9twTkgOJXOz7hwOXR/ujviNf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE8pe3iircSjqSJ4ttaTpmd/sc+CrQP2nWDD+jb/m9bOhuEiDS4etpWIkKyvNsktdQeff2D1CJxGwmq4YGc3rTRJ3LNBBrz6prP2eukPy+bYARiGrAcLv0gtMwj+DgYxmUctU4knd89ri+dd+sMPFwyy2XyD7eL6vjoHK+tiVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gowdjz7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C134C4CEF0;
	Tue, 12 Aug 2025 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755024753;
	bh=MrZxGc/QF9ghRGxxSd9twTkgOJXOz7hwOXR/ujviNf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gowdjz7XZ4dkJ+3SoJTNog8xumKVzTPXM0PNoB2RKPdCxAZDtH0AuVmihAdo4SQC9
	 VWnxrPUSjOxNP7WJ8kIZ0Nds+Eo0ZHwe7um3j/phPxY2Yg0CtmAmhWmyXuGzpNZhN3
	 nA9qABaYLGkudO4JMC9j/RQwLQT967tZDtz+qtP9p2MaPaPWm6k+ujgu4dtw2U77jj
	 4KobiYoqxoGHUV8+pbtLUkb9Cra9B1kn1u70IztG9eAcUQ6obXkunFs0dcsZD7eVdI
	 j0Xlk8izSUSVfYtXSlwihtdv3xISAIYsl62c8YMsau01l2TB1QekFhetO2LuFl0HUT
	 b129+xo81nDow==
Date: Tue, 12 Aug 2025 08:52:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: Query regarding work scheduling
Message-ID: <aJuNcM-BfznsVDWl@slm.duckdns.org>
References: <aJsoMnkoYYpNzBNu@opensource>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsoMnkoYYpNzBNu@opensource>

Hello,

On Tue, Aug 12, 2025 at 11:40:34AM +0000, Subbaraya Sundeep wrote:
> Hi,
> 
> One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
> see more delay in their applications shutdown time.
> To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
> apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
> During interrupt handler work is queued and messages are processed in work handler.
> I calculated the latencies (time between work queued and work execution start) of 6.1
> and 6.16 and below are the observations
> 
> 
> 6.1 mainline
> ------------
> Total samples: 4647
> Min latency: 0.001 ms
> Max latency: 0.195 ms
> Total latency: 7.797 ms
> 
> Latency Histogram (bucket size = 0.01 ms):
> 0.00 - 0.01 ms: 4644
> 0.01 - 0.02 ms: 1
> 0.03 - 0.04 ms: 1
> 0.19 - 0.20 ms: 1
> 
> ==================
> 
> 6.16 mainline
> -------------
> Total samples: 4647
> Min latency: 0.000 ms
> Max latency: 4.880 ms
> Total latency: 158.813 ms

Difficult to tell where the latencies are coming from. Maybe you can use
something like https://github.com/josefbacik/systing to look further into
it? All the scheduling events are tracked by default and you should be able
to add tracepoints and other events relatively easily. You can also set
trigger conditions so that trace around a high latency event can be captured
reliably.

Thanks.

-- 
tejun

