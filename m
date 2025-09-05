Return-Path: <linux-kernel+bounces-803459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A3B45FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA60188BF69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FE3568E0;
	Fri,  5 Sep 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB2V6XtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19530B507
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093053; cv=none; b=BCITklEr+2s6RvZJm/GR/rYafiI67KOFV4pqOG1Y/2hGyoLtWEJ/hGEl0q3ZkT/Jhf6vOzrlyMLQoYerOP/qRRWFOJ3ioxfxcTYNc94RRR+G8WsynAY0hTmhMFcvvEM2I3Zk+wnDBkyjl0mEw8WzzQK8LmOQqh/XrSmytIuvaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093053; c=relaxed/simple;
	bh=LFG9QiUgt+ymXhzv0BXKuROD54gJ69W+WTz6Ff6/l9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeKe00lSWd167XFnDc7/bQMV/84xOc8ogfzpL/bi9lIufGFz2jybaWAxN9BjggI6dL4Y8zL2UZXGYvDdvOQPTzqmSHGfXRn7W7WHemm/F0bZ+V+AncPSOnOTvN9NmlOUeBlZ6QPiUXn8nDoyA4w0m5hNVKwA7zBoB52gYbskwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB2V6XtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E2FC4CEF1;
	Fri,  5 Sep 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093053;
	bh=LFG9QiUgt+ymXhzv0BXKuROD54gJ69W+WTz6Ff6/l9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB2V6XtTFbXI258LPJiV/9grht+No8/4SHhq8vW9pC17kKUKooZOfRV2WlYR2fnDU
	 W0wx15ljj9PY8Okh3wEk4+aZlcEFy+gCRczaNx6iZNSz9T7mxb+JMoAnFdyfughAaV
	 1DYCljowQR0N4/YMcQIvPhJ2lndvGweXWWIqBao8yBdywL560sEPExg/pPbPIreC7w
	 zmQ7StW63vOC8BQbdQi7ejrZMW0CJDQcz/8qNWbHjUx4DRGaypBXtQrMVdGaNPgpW/
	 tVR+gU6PRL7BCVK+YXrEwkfPLRIejl4S70h2suwDAnAoTf1tdkRHen0CBeVmyqNW8J
	 XOO+JzF5i6GqA==
Date: Fri, 5 Sep 2025 07:24:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/3] workqueue: replace use of system_wq with
 system_percpu_wq
Message-ID: <aLscu4p7hU8HJRkK@slm.duckdns.org>
References: <20250905091325.112168-1-marco.crivellari@suse.com>
 <20250905091325.112168-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091325.112168-3-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:13:24AM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied 1-2 to wq/for-6.18.

Thanks.

-- 
tejun

