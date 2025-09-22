Return-Path: <linux-kernel+bounces-827483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B66B91E18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA433A8A85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22B2DFF04;
	Mon, 22 Sep 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlIptims"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864F2820D1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554426; cv=none; b=WfPzWuLIRi3qeH/5UevLmnkjWtLdgJFz57bgC3y35dyz+PcFfh4qIubef3XqwEXn83y97TvN4wkNmHUwppYXuFxSpa3SZoPE/N3Xkb11aYp0Tu2iv0MwBNYl7XuqnNCaHOapV9v+vhm3gorDOnIRA+Tj0+goy+NRRFMZfUqg6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554426; c=relaxed/simple;
	bh=OItNXivxvXjl3aMGPmeElGX+iifBDz1qjZCikif9gd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d61AY+n84idymJbBIya3Y+DrhQQcWWJNxWkc58UR/qUNCLkDJrMp87Lsz/k/nYv69Fh8Ac/ZSu8Ws6xhjtixNXmcVkP+KPn9jIRLoVMBKthdHbroe7/PTJN7x0anQPyxNIFL7SXxtWu1vCdoRl3l/8eVvIVZ5jTHMQz4nayjyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlIptims; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F4FC4CEF0;
	Mon, 22 Sep 2025 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758554426;
	bh=OItNXivxvXjl3aMGPmeElGX+iifBDz1qjZCikif9gd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlIptims1OLFqRlrCfYUfS/y1/c2LZsgxeC4oVCOWt6UUSVqC6H2yzYjJiOVqBbf8
	 g4gehO/OPho85wGpj9pzxLkYoPxg0y+Dj8QdQziDF8bg0m1uXcffYcMSh6ehcSvHpu
	 OmxGcfoJt+8iAmNsYK345d1Q511V88gWlbrOfcO7kBAMql5oofjjRannKdH1sldbt0
	 XPIAXz6jhszzbkDwnqscPFfQVuBTLzU4KWz8a5Hm8FpIeqKqZxmC0XBc+Fv4PTWgFs
	 LqTvNKZlPp/NT913QorJvn7F1P61QHtWclTYpzEslkDFuw0JJVGSecReSjr2GuyEk1
	 lR+sWj+5QgIGQ==
Date: Mon, 22 Sep 2025 17:20:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
Message-ID: <aNFpNijJ0tT0rjPa@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
 <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
 <152b067c-1fa3-4b73-98f3-7e0a0c87e388@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152b067c-1fa3-4b73-98f3-7e0a0c87e388@redhat.com>

Le Tue, Sep 02, 2025 at 11:48:16AM -0400, Waiman Long a écrit :
> 
> On 9/2/25 10:28 AM, Waiman Long wrote:
> > 
> > On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > > It doesn't make sense to use nohz_full without also isolating the
> > > related CPUs from the domain topology, either through the use of
> > > isolcpus= or cpuset isolated partitions.
> > > 
> > > And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
> > > 
> > > This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> > > alias) is always a superset of HK_TYPE_DOMAIN.
> > 
> > That may not be true. Users can still set "isolcpus=" and "nohz_full="
> > with disjoint set of CPUs whether cpuset is used for additional isolated
> > CPUs or not.
> 
> Instead of "is always a superset", I would prefer to use "should always be a
> superset" as it is a recommendation but users can still violate it.

Good point!

> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

