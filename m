Return-Path: <linux-kernel+bounces-796715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1354B4063D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB41888D53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860B2DC35C;
	Tue,  2 Sep 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA5blmGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE941DD9AD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822073; cv=none; b=HEy6frr8wHayijENKVd7g0Fe2/c1FxIQ/IJ8142V167/aKk0qQK5mfuJqQ/tpjDUoYzXAf6xOsYc+tIAfV43zaxxXKgQd4UGu3fuXZWuWnTFMkXspJlJY4EJpgr9Ic4TpuhRpKRLjHQz9pLVvREyoXRzSvcLeVFkqLwQehenCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822073; c=relaxed/simple;
	bh=p1qrbKnj4Bt7+IGreowskpbZZPaeUQzHJl1H6XVC5rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ZF6OI8HfmC01vESC32wkuY7KIxbS/p8SWZwdOma2SOn0HYm5TfscQaNYkQTSWOB223r/xT4ZHx9Q1hsui3neiSh3v+ox76SF8DNO6/jreMcAb6+mrf+BIGPlSWMnDlPZ2c8Vio9Y/R9aIy4QYVMprfw9NVKnIry4eZ77VRKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA5blmGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE0C4CEED;
	Tue,  2 Sep 2025 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756822071;
	bh=p1qrbKnj4Bt7+IGreowskpbZZPaeUQzHJl1H6XVC5rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA5blmGItnocjbLU8clU2jPJmQLCzpZbP6dtyRkeSwFRiOc09n7ureXZv6XsfIOIO
	 sjA7Z7mzFgakwmDPCdbzx6Tpz30RHR1Dlg2oXrdWSar59Hri+Vzxy/bYz0eo5QwVXd
	 SYkkFpBDCHuszwpAjtvXwkIPAdHtYWZmZokfUco1vQ+xv0ovTyQm2apCebbhhmsuXf
	 RQXPsJY0WnRsHfSsa8Qmv3DyZZQ4H/aiWtmC2o4FlQj/jXLp2jisricrZscW9QJFYb
	 Xw7Irx/QAzic+qcL8mPjlSSmXZCzpgTS9xuShMtA0JRIjPB+eOf0a7fbO5xHwe9gi1
	 xXgMWsRdDYgOA==
Date: Tue, 2 Sep 2025 16:07:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: Remove unreasonable detached state set in
 tick_shutdown()
Message-ID: <aLb6NFWw3CP2MYp-@localhost.localdomain>
References: <20250807035954.2412399-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807035954.2412399-1-maobibo@loongson.cn>

Le Thu, Aug 07, 2025 at 11:59:54AM +0800, Bibo Mao a écrit :
> Function clockevents_switch_state() will check whether it has already
> switched to specified state, do nothing if it has.
> 
> In function tick_shutdown(), it will set detached state at first and
> call clockevents_switch_state() in clockevents_exchange_device(). The
> function clockevents_switch_state() will do nothing since it is already
> detached state. So the tick timer device will not be shutdown when CPU
> is offline. In guest VM system, timer interrupt will prevent vCPU to sleep
> if vCPU is hot removed.
> 
> Here remove state set before calling clockevents_exchange_device(),
> its state will be set in function clockevents_switch_state() if it
> succeeds to do so.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

On a second thought, it may need the following tags:

Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")

Because those commits removed shutdown calls made from drivers that assumed the
core would do on their behalf. But it was not the case before your fix.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

