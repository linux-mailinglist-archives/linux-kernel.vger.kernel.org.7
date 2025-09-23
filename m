Return-Path: <linux-kernel+bounces-828737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06AB95502
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8A3AFDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB728850B;
	Tue, 23 Sep 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9xv+a2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793181946DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620921; cv=none; b=HZYjjMGrVMBOARUjy1MrWTFawEhR2Sqctu+92Wmv0jZCZODyiDr9qKI8D4xv91U0rDtVF1RFDbun9U0sRoZrt2h7wQPJpcmO8o2TdEX8oiTz+Kgg32/Z5aF7hKLOgwNvRtQZXknP2BL183x+VUhL2b8DvJ+JyrgLJsdhmS2xIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620921; c=relaxed/simple;
	bh=MUTJyUmPBpqLN9hqtNUmJGdo8aqooEv8GUyAnE8TPP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbXUyNIjiJEYSAURI+2ZFeYKo+i++QkMXT340UkouVCsWjcG3jH+HmHqT63dbh02Gs3nzE5UiA4dsd5yI60iu25G0zcK3GX4XPE2xdI8t36DlsfrudP8JFjdUvRYedf7DOhdTOM6SG0woLEwOzZiW4qmpAZGIFYS4ORWlhUlQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9xv+a2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9513AC4CEF5;
	Tue, 23 Sep 2025 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620921;
	bh=MUTJyUmPBpqLN9hqtNUmJGdo8aqooEv8GUyAnE8TPP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9xv+a2muPf13/zBgUAlkETgkrWIgRKNar7/rtmx5BcW182ueWNO5Amf/nB263X5u
	 7fFjUrgZ4afVw2NbI4fHhzdXP0f8ZZ+icPQqyZfyVWzuOLh441R3knmUvga/LjSV9Y
	 uFiplLeGXQfSLos6E/Qc4iIEULlMiWhx3Zf+7IMgVA7tC+BCSi/94I8q0bKEtfYgS+
	 XoAAxBtQbJUUGKBbUh8AqouOb1n+iPE8k+Jo1sJ92Z15RbaK4DMlgytyELOD7O11ed
	 0AMQLOwQzLufidsTPHGYweV2vWRWJP8IJ5ft7LOv0IOZwofpkae4TLyl21wbLwerZa
	 jBpnQE77SZLnQ==
Date: Tue, 23 Sep 2025 11:48:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/33 v2] cpuset/isolation: Honour kthreads preferred
 affinity
Message-ID: <aNJs9cLYEeiDr63g@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <99f02e8d-7cb8-4190-ac0c-343b1e9fb735@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f02e8d-7cb8-4190-ac0c-343b1e9fb735@redhat.com>

Le Tue, Sep 02, 2025 at 03:12:04PM -0400, Waiman Long a écrit :
> On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> > Hi,
> > 
> > The kthread code was enhanced lately to provide an infrastructure which
> > manages the preferred affinity of unbound kthreads (node or custom
> > cpumask) against housekeeping constraints and CPU hotplug events.
> > 
> > One crucial missing piece is cpuset: when an isolated partition is
> > created, deleted, or its CPUs updated, all the unbound kthreads in the
> > top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
> > their preferred affinity along the way
> > 
> > Solve this with performing the kthreads affinity update from cpuset to
> > the kthreads consolidated relevant code instead so that preferred
> > affinities are honoured.
> > 
> > The dispatch of the new cpumasks to workqueues and kthreads is performed
> > by housekeeping, as per the nice Tejun's suggestion.
> > 
> > As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
> > from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
> > now modifyable with specific synchronization. A big step toward making
> > nohz_full= also mutable through cpuset in the future.
> > 
> > Changes since v1:
> > 
> > - Drop the housekeeping lock and use RCU to synchronize housekeeping
> >    against cpuset changes.
> > 
> > - Add housekeeping documentation
> > 
> > - Simplify CPU hotplug handling
> > 
> > - Collect ack from Shakeel Butt
> > 
> > - Handle sched/arm64's task fallback cpumask move to HK_TYPE_DOMAIN
> > 
> > - Fix genirq kthreads affinity
> > 
> > - Add missing kernel doc
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	kthread/core-v2
> > 
> > HEAD: 092784f7df0aa6415c91ae5edc1c1a72603b5c50
> > Thanks,
> > 	Frederic
> 
> I have finally finished the review of this long patch series. I like your
> current approach and I will adopt my RFC patch series to be based on yours.
> However, I do have comments and is looking forward to your response.
> 
> Thanks,
> Longman

Thanks a lot for the detailed reviews, I'll try to address all that and repost!

-- 
Frederic Weisbecker
SUSE Labs

