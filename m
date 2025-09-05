Return-Path: <linux-kernel+bounces-803384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E232B45E72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A68A0569F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE86306B35;
	Fri,  5 Sep 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBo/Zn6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83951D86FF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090573; cv=none; b=dHeWgHB+9tTub5ibckqhbVbLpDhQpRiaRNUJEgULQWNmLTOYEX32Gy9g0tlRIIy8vUId8ybNAMGtS5r9d2tquyxG4+3BM+icPhLTjhbsi0GxsBlvQAEGV9iirc36+vIwl4E10SNLnjXzfMIrbKWRhTTUqbAhXgy+73cDfg/PdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090573; c=relaxed/simple;
	bh=wRUm2hwYPLI3a1cUGnowuCoYxvDFlUOcQoejEugtRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxAf70qpHzcB57xHOzDmSnYK94kSSiQL96qvE32vzFrd4vQTyaYCILqkqabTr8nHZ5kT2soOfr+5yUn78qOJRXB0O1Rmxpio4nfrhaB9C10d0Iw6zWMacmoHGx9V+FoI/V2wYzp6vThT4e5ykwtG3tz7odgHIPJvyzadjd2ZmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBo/Zn6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC2EC4CEF1;
	Fri,  5 Sep 2025 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757090573;
	bh=wRUm2hwYPLI3a1cUGnowuCoYxvDFlUOcQoejEugtRzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBo/Zn6LplQPDTRKnETC3Ywms7EUCtiAjvMednwtMGAQ8B9cPzgBQWQOdTuB1Q/4j
	 VO1vtzdTO6mGl/LlwUVnTHyXm0vLroB/42VleDvfNX+LgGiZHG7O6qx6WMYDS609UY
	 YVjQPpWFe3b14tTYJId3Vy4SM0RbsqX6pzcB14Lk2jotwe7kAdLENusU2IyFiqGo2f
	 Z43SdDB+o5saIlqxBXLwmUuvuPLt5NGcD8jC05v5vo/x1oEuO7l2ZkF72rY56ekYfU
	 VZmfBP0cE5J22nV2Fe0zhBlo4T9tXC32VWRKKKu4n79zuzApXjpeJ0hu6HrI2JzHmH
	 mzInJcrsgFxXA==
Date: Fri, 5 Sep 2025 06:42:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/1] sched: replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <aLsTDFHzWcRXauH-@slm.duckdns.org>
References: <20250905090928.108703-1-marco.crivellari@suse.com>
 <20250905090928.108703-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905090928.108703-2-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:09:28AM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_unbound_wq should be the default workqueue so as not to enforce
> locality constraints for random work whenever it's not required.
> 
> Adding system_dfl_wq to encourage its use when unbound work should be used.
> 
> queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
> new unbound wq: whether the user still use the old wq a warn will be
> printed along with a wq redirect to the new one.
> 
> The old system_unbound_wq will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

