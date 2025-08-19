Return-Path: <linux-kernel+bounces-775531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D959B2C040
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E258162046B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D7284887;
	Tue, 19 Aug 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVtS1ecu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA627876E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602611; cv=none; b=UvLwuQO/ECopo8DBPbpIMq5pbezwgusLpNTN/stC64uf+fzlmuhVSxoo9AbJEu1fgE4/TMvJpFXce6HoxAC0OCee/XP9vFZajxPFi28J3KGQdt7hTxZCwDTFtbJYE7FIWPiO7Xszo+0lzpHTBGE2rLpbnZh68Q6GhVQokkL2hKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602611; c=relaxed/simple;
	bh=cpyHuTdQHuR3OFKNmqQQqklmfm2+TKFGXshGKaTMBQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNWN+vRXQo91xNJsJByHlrA96LJNGkmQ3Y1KBDWK0SgWoL/dPmVDLtRRO7qsIAYuZn+sM4CgNFD12SW1JCKgAjqQAkNAo6IfeEuDx3Jb5z2gmqalo1oDpY5MW7bq3UL8/NRDjU9u8kEnBzRE/Z8bod/CYPsSW5/aCcmhO4LNYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVtS1ecu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8685C4CEF1;
	Tue, 19 Aug 2025 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602611;
	bh=cpyHuTdQHuR3OFKNmqQQqklmfm2+TKFGXshGKaTMBQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVtS1ecuK+ffSls3EPjrhhdCQbTsu1EQ+Ma90H+z9LaAqG3vTXQ4D4vWcws+ykCzZ
	 HfQ49uCrvfuAHyuQYyKCqOm0zGwrCGYlQCfzSqmv2wIHCVwgLaFlV+ZmhhOhRpo9P0
	 VU1rhliYDx5RSUc81gnnJHSE3yUVl6PPRlV8+M4WMwWlMsj7sI+tKQy3mxh9DiHGC0
	 BJNoJd/m3kDvcOT38nwFln0OJU0GmdLrGC/zBjHJzD5I9AWiW75F/9zdhNBQ1GIjpU
	 H6TYvmjEhXHOCEsNaqlzec8nWUvEf83hoM+Q77/4/kmCbq4Mduew37GW5QPsZZo7to
	 R6uiJu6ozNucQ==
Date: Tue, 19 Aug 2025 13:23:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/2] Workqueue: fs: replace use of system_wq and add
 WQ_PERCPU to alloc_workqueue users
Message-ID: <20250819-maden-beteuern-82c84504d0b3@brauner>
References: <20250815094715.54121-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815094715.54121-1-marco.crivellari@suse.com>

On Fri, Aug 15, 2025 at 11:47:13AM +0200, Marco Crivellari wrote:
> Hello!
> 
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an isolated
> CPU where "delay" value is 0 or greater then 0:
> 		schedule_delayed_work(, 0);
> 
> This will be handled by __queue_work() that will queue the work item on the
> current local (isolated) CPU, while:
> 
> 		schedule_delayed_work(, 1);
> 
> Will move the timer on an housekeeping CPU, and schedule the work there.
> 
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> === Plan and future plans ===
> 
> This patchset is the first stone on a refactoring needed in order to
> address the points aforementioned; it will have a positive impact also
> on the cpu isolation, in the long term, moving away percpu workqueue in
> favor to an unbound model.
> 
> These are the main steps:
> 1)  API refactoring (that this patch is introducing)
> 	-	Make more clear and uniform the system wq names, both per-cpu and
> 		unbound. This to avoid any possible confusion on what should be
> 		used.
> 
> 	-	Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
> 		introduced in this patchset and used on all the callers that are not
> 		currently using WQ_UNBOUND.
> 
> 		WQ_UNBOUND will be removed in a future release cycle.
> 
> 		Most users don't need to be per-cpu, because they don't have
> 		locality requirements, because of that, a next future step will be
> 		make "unbound" the default behavior.
> 
> 2)  Check who really needs to be per-cpu
> 	-	Remove the WQ_PERCPU flag when is not strictly required.
> 
> 3)  Add a new API (prefer local cpu)
> 	-	There are users that don't require a local execution, like mentioned
> 		above; despite that, local execution yeld to performance gain.
> 
> 		This new API will prefer the local execution, without requiring it.
> 		
> === Introduced Changes by this patchset ===
> 
> 1) [P 1] replace use of system_wq with system_percpu_wq (under fs)
> 
> 		system_wq is a per-CPU workqueue, but his name is not clear.
> 		system_unbound_wq is to be used when locality is not required.
> 
> 		Because of that, system_wq has been renamed in system_percpu_wq in the
> 		fs subsystm (details in the next section).
> 
> 2) [P 2] add WQ_PERCPU to alloc_workqueue() users (under fs)
> 
> 		Every alloc_workqueue() caller should use one among WQ_PERCPU or
> 		WQ_UNBOUND. This is actually enforced warning if both or none of them
> 		are present at the same time.
> 
> 		These patches introduce WQ_PERCPU in the fs subsystem 
> 		(details in the next section).
> 
> 		WQ_UNBOUND will be removed in a next release cycle.
> 
> === For fs Maintainers ===
> 
> If you agree with these changes, one option is pull the preparation changes from
> Tejun's wq branch [1].

I'll take it through the vfs-6.18.workqueue branch.
Can I just pull the series from the list so we have all the lore links
and the cover letter?

