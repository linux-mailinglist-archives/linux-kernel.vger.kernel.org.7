Return-Path: <linux-kernel+bounces-828678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D4B952C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA1F480932
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14913203A0;
	Tue, 23 Sep 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN9vHty0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EE31C584
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618693; cv=none; b=Jl0fxngH0VAxO5MD+w9wFUGvOjbiq+IKWyINJ4N8bTKT3YePT8em66pb8MqJd0jhAm+R0AVqpZAW4vZKRvfrVG7BvJQSdHX5oIFOKzFzDoXchMLDFei+ul/YIj3RjhDC9exe1zBc+yBVq6AxdIQo4Re7JuyUvVcah5ndYkN1BwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618693; c=relaxed/simple;
	bh=l2G9vnb85Aol30YILUsnFuVbZezPaHNRcRjRUT2jmWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpBIcFNdtZ90ppa3JbW6oTbeqjtWa1sMVW2/zcc1qtZD7CepTfrYx5sEA8A2W+vSa1B40wK345lWrlLNBz/revlQ9J2c5Zp20OQPa4r4TzNznrG6KiVOht3dkIUcd94duOX25qDpkeS+rzfNB8Wm6EOgss4nn/8SU5SIaVSwKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN9vHty0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5101BC116B1;
	Tue, 23 Sep 2025 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758618692;
	bh=l2G9vnb85Aol30YILUsnFuVbZezPaHNRcRjRUT2jmWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN9vHty0N7IRvpoV9Xr4yAd0Ffb+s8yHoFeeZVpw3zZ17qNK9OJiNIFZ5CsmI8qLa
	 z2SVUD0xMEGr3v5O0UvgQuRs3l0H3EEtVda1kqUaGjDM2tfMjJH0QbZmOwuiCFWJRn
	 shmzZG9m7afJOY9g8BnlK5fg0R2+Vj7CzXK3ZIsSK+V03PvElsee9pL2ZmMOGk4vkO
	 jUfEC9NnBF+Pv40dL4Ef9ga1SkyhLi2z2C6u08sRNvFmylf9Kyfn972uwb/GzfNcqy
	 03SVwGGQVCS3eVqE7o5tqfiZAOtoaaR7jbKPaeHL+s9989L8hTlOjMRO0tSICB1w9y
	 klI6e9fgvwkOQ==
Date: Tue, 23 Sep 2025 11:11:28 +0200
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
Message-ID: <aNJkQIO3L5SwvCbE@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
 <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
 <aNFpHgRnf-mV-4d8@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
 <1c77c072-ddf1-4894-a5bb-73bf13a838b9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c77c072-ddf1-4894-a5bb-73bf13a838b9@redhat.com>

Le Mon, Sep 22, 2025 at 05:59:12PM -0400, Waiman Long a écrit :
> 
> On 9/22/25 11:19 AM, Frederic Weisbecker wrote:
> > Le Tue, Sep 02, 2025 at 10:28:58AM -0400, Waiman Long a écrit :
> > > On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > > > It doesn't make sense to use nohz_full without also isolating the
> > > > related CPUs from the domain topology, either through the use of
> > > > isolcpus= or cpuset isolated partitions.
> > > > 
> > > > And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
> > > > 
> > > > This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> > > > alias) is always a superset of HK_TYPE_DOMAIN.
> > > That may not be true. Users can still set "isolcpus=" and "nohz_full=" with
> > > disjoint set of CPUs whether cpuset is used for additional isolated CPUs or
> > > not.
> > There can be domain isolated CPU that are not nohz_full indeed. But OTOH nohz_full
> > CPUs that are not domain isolated don't make much sense. I know such settings
> > exist but it's usually a half working misconfiguration. I wish I had
> > forbidden that since the early days but this was from times when we didn't know
> > about all the potential usages.
> 
> The assumption is true for cpuset isolated partition, but users may still
> set conflicting nohz_full and isolcpus parameters by mistake. We should
> probably a warning if this happens and document that clearly to enforce such
> rule.

Good point, warning and documention should be a good start!

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

