Return-Path: <linux-kernel+bounces-821375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA8B81183
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A331A7A9F09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF282FB987;
	Wed, 17 Sep 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX1HPbir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866A280335
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128347; cv=none; b=kzhn7mps197aG04nbRT9nmA9VuWT7qsg05FW4izevfqDsHAhm97VUMWW/K4/Mr0d4n8gXMfiiqdWcO1FecccTBEhdMIHh3Wj29Cy22UrOX9mkhI6Ba3jzXO9XBnTmQU/2ZfnONQhJjgnT8ILgFZHxGAHFnC8WrQaatY7pqDQl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128347; c=relaxed/simple;
	bh=e4wcLdszx6UoRJWCXErL9rJQG8rZ+mwCiwSXlJle9Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv5xMK3h6EdNrWGiMp7oUPgpqRnpQkx1+29rOPqEoqipovPes8JyOFhDOV+lpgiHov0GhL3Tp3cOjphcID8OrX6bpSgdt0jzOux83uKimsunMjyMF+Z8zvLBmBxVRY+4zA/8q3+D9oPh1Kq/spvf7379JSjL0lx9PysfTCdz7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX1HPbir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2CEC4CEE7;
	Wed, 17 Sep 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758128347;
	bh=e4wcLdszx6UoRJWCXErL9rJQG8rZ+mwCiwSXlJle9Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jX1HPbirF7Ie67riVz92vAEJ3HvH4inia0iQAjO3bwfgNH/GeqlaGPHikhpORGWkR
	 rTtpZJiIKuLMhlGX9JUnCoLRWAk1SUefWvIKI9Gvi7rATSoW08O4A/InPrbbLuplXF
	 AUMx226JODb4jULlZDqbs+kcFsZ8sSjD3pVeJV01PkiEMZfkHYOOA+E7N1legR7t7R
	 FcLIrnixNyUkbPxWkiJc0C0HoTlCtCJSx7qUaOBRYHgR3+b3wd0Y5MyoZL7r7SqMgX
	 GCG/85eNmsbIzbW2puCp/3V7eeemR+SPY2Vprd96mbBn8SjK2TTGkjsxKB7+BhtVeb
	 UwfbHI/8v+76g==
Date: Wed, 17 Sep 2025 18:59:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v13 9/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aMro1w4aeu16wJ9O@localhost.localdomain>
References: <20250917161958.178925-1-gmonaco@redhat.com>
 <20250917161958.178925-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161958.178925-10-gmonaco@redhat.com>

Le Wed, Sep 17, 2025 at 06:19:58PM +0200, Gabriele Monaco a écrit :
> The timer migration mechanism allows active CPUs to pull timers from
> idle ones to improve the overall idle time. This is however undesired
> when CPU intensive workloads run on isolated cores, as the algorithm
> would move the timers from housekeeping to isolated cores, negatively
> affecting the isolation.
> 
> Exclude isolated cores from the timer migration algorithm, extend the
> concept of unavailable cores, currently used for offline ones, to
> isolated ones:
> * A core is unavailable if isolated or offline;
> * A core is available if non isolated and online;
> 
> A core is considered unavailable as isolated if it belongs to:
> * the isolcpus (domain) list
> * an isolated cpuset
> Except if it is:
> * in the nohz_full list (already idle for the hierarchy)
> * the nohz timekeeper core (must be available to handle global timers)
> 
> CPUs are added to the hierarchy during late boot, excluding isolated
> ones, the hierarchy is also adapted when the cpuset isolation changes.
> 
> Due to how the timer migration algorithm works, any CPU part of the
> hierarchy can have their global timers pulled by remote CPUs and have to
> pull remote timers, only skipping pulling remote timers would break the
> logic.
> For this reason, prevent isolated CPUs from pulling remote global
> timers, but also the other way around: any global timer started on an
> isolated CPU will run there. This does not break the concept of
> isolation (global timers don't come from outside the CPU) and, if
> considered inappropriate, can usually be mitigated with other isolation
> techniques (e.g. IRQ pinning).
> 
> This effect was noticed on a 128 cores machine running oslat on the
> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> and the CPU with lowest count in a timer migration hierarchy (here 1
> and 65) appears as always active and continuously pulls global timers,
> from the housekeeping CPUs. This ends up moving driver work (e.g.
> delayed work) to isolated CPUs and causes latency spikes:
> 
> before the change:
> 
>  # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>  ...
>   Maximum:     1203 10 3 4 ... 5 (us)
> 
> after the change:
> 
>  # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>  ...
>   Maximum:      10 4 3 4 3 ... 5 (us)
> 
> The same behaviour was observed on a machine with as few as 20 cores /
> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> 
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

