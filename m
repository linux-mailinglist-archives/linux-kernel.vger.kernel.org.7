Return-Path: <linux-kernel+bounces-819578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F758B5A355
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131181882F81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEEE306486;
	Tue, 16 Sep 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksCssMJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883031BC9D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054908; cv=none; b=k/zUeUpfFUuBStmlER/Feo08mJFmwbRkFDQpd6v59qIUmz4L+5gMtI6dfO5zbCNqK/XlaQwaKfcS6QP2tpIj77OVDu73Kht6C5pzIlrHvcXaWPD9+kd9KMMFbDOe1Pl34EVR3V2m6j7mAscSpplgQOJtl6D+6bNrxbR1EhGTWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054908; c=relaxed/simple;
	bh=QyCMXi01YRgiNm5XeMkGS/vMIHfEeyOTHut8SMzsyWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCvnsD2a2yCSCqzbOct0wJ3n4bxC607rYdTnU6gTKaJ4SgIDAV3ezHqYsRUGind1b3DCWCgXSyIYIYxg8OWua7lue66BpeebDRNQowXO503IIHdaybWoktbWZ7UrmcbFh1RkH+vpgKX00q5JO+5nZyI/A7rjaNq35lgQCg2cPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksCssMJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF5BC4CEEB;
	Tue, 16 Sep 2025 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054908;
	bh=QyCMXi01YRgiNm5XeMkGS/vMIHfEeyOTHut8SMzsyWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksCssMJkHC1fJm5afHLr48d8QOmObUEluTWdhYmp3YBvQlp9KLzCY1/wSDDxkhkUz
	 RoR4oBGptykrTWdUYW1nYV2qcRVY6R1ttwYsrkUmEh0ZIFjbgbcfolQzpvnuLZfwpM
	 QtjWjWCNLwdDBtOH8gweCybCoAU/zLycs+DTttM1pyZXsRCTqy8fqBGI+30yLjROHw
	 n94wfGxqT9Z9mGQSjG0BaB6z30RDdhc2WujAqannNfz49RdDAeoxpKgtZLmgdRHy64
	 rUhw+2ttL9ziVuBaixdCzyuTScBqYfHtO7kdiBOvRKi8NUt5XMK+qqelEDYsq6YF8t
	 uMywT6owDHMLg==
Date: Tue, 16 Sep 2025 10:35:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/1] workqueue: WQ_PERCPU added to alloc_workqueue
 users
Message-ID: <aMnJ-7PKbo6Lf7h_@slm.duckdns.org>
References: <20250914134426.43269-1-marco.crivellari@suse.com>
 <20250914134426.43269-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250914134426.43269-2-marco.crivellari@suse.com>

On Sun, Sep 14, 2025 at 03:44:26PM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This patch adds a new WQ_PERCPU flag to explicitly request the use of
> the per-CPU behavior. Both flags coexist for one release cycle to allow
> callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied to wq/for-6.18.

Thanks.

-- 
tejun

