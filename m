Return-Path: <linux-kernel+bounces-800525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B950DB438C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C00682CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB12BF3F4;
	Thu,  4 Sep 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYAnwlqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E65661;
	Thu,  4 Sep 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981986; cv=none; b=mwUlwZnTa4UoJXOaEgaqxJJkcN0TuFExT3zDsGazqEwrj/AH0a+MxGeqcOA+3WnzjHSmx4NR0o7yROPv/iq83BC0LD+ek81io44WWuLLl4mdEReHXP7dS1ONwY6ZMr3pYFELEP3cvuScxgL/90P5HvcMlhO6ZKvdwx8xCAR58yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981986; c=relaxed/simple;
	bh=w5U7iTCeKoek0KyThv+JByD+nMze6+Bs9QJCk18phks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uajb0PvnZzYsEWMiKm+RmgRJah25aaoahXyiCZ6IFvDAdCu6Dvo37JCEf2VaEBmAiNPgjxq8lN1DXP++3Ne0FM3hCDNMaiNLJDwHQWMRrP8zFcnkVDNUi3evMK6Xr3/bOXJ5WI3+q38oUXOegDpXg5S90ujqv2JwMXqjMR/uaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYAnwlqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B959C4CEF0;
	Thu,  4 Sep 2025 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756981984;
	bh=w5U7iTCeKoek0KyThv+JByD+nMze6+Bs9QJCk18phks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYAnwlqwGbdT7u3Vg/YVPMzg2rtqnmgdtQAOZjzcs2SDlHg/w4937tLASqmUG/OAK
	 9IYRchGfIKstWELzYMBGcEyRB3aPnhXekEIAEAgunlnaWBcem7odA/OInJAq/oMJLg
	 ptVmo1PJb+e0eABHZcCznvhQydzyBCserF8P4ani4fs5Uyw5Z9wug1ErRp+675uNK4
	 NstAFiuEl6TcOfy9WuZ9VdMkkIWBh/H0z3uZ70RNMmYfL1odaF9iLrkgrmmGeirm14
	 FcB1Ow+QjsVXr/UT1McAIi+2KYMms3YASly9LSt7TUpuIPlfMrVl8odRddjkRYYqPO
	 6ZY7Hrx1CmSFw==
Date: Thu, 4 Sep 2025 12:33:01 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/2] tick: Remove unreasonable detached state set in
 tick_shutdown()
Message-ID: <aLlq3Um6y5Ez07ak@localhost.localdomain>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-2-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904071732.3513694-2-maobibo@loongson.cn>

Le Thu, Sep 04, 2025 at 03:17:31PM +0800, Bibo Mao a écrit :
> Function clockevents_switch_state() will check whether it has already
> switched to specified state, do nothing if it has.
> 
> In function tick_shutdown(), it will set detached state at first and
> call clockevents_switch_state() in clockevents_exchange_device(). The
> function clockevents_switch_state() will do nothing since it is already
> detached state. So the tick timer device will not be shutdown when CPU
> is offline. In guest VM system, timer interrupt will prevent vCPU to
> sleep if vCPU is hot removed.
> 
> Here remove state set before calling clockevents_exchange_device(),
> its state will be set in function clockevents_switch_state() if it
> succeeds to do so.
> 
> Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
> Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
> Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
> Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
> Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
> Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
> Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks a lot!

-- 
Frederic Weisbecker
SUSE Labs

