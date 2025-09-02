Return-Path: <linux-kernel+bounces-796673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19896B405CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1090C3B6814
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7E2D4818;
	Tue,  2 Sep 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhSJElul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE51F61C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821003; cv=none; b=nk0tqFIgXP3Senkpj7V1PBzc8FugP5TIPZBMwoGtLS5hCYGAGOB7xfK0M56N/h9H6OW2rCi76YuA2DrAfNtrR/b86FgjX9ll6N1FN7ahhbspnt35zQowXhr/86glvAF/UoggyJGP83FSMs8bHtK9JX3mx6mKgb/6IH+ElHyxmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821003; c=relaxed/simple;
	bh=+wPuKdc/Rol6aNMF8Od+YrhItlb5399wVfGd0zdb71M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvOfhJh5eQaqFmb+8G8pOxQ0laZ9pGJh/coCstXKLUIHasqgRYHOt4HBvUwqBsy+06LCcCrDCs+Qy8J0/khM/G8l6qDpD+Vs+zdfHGIg2m6bNFrYrYGhlXtQYnI+iTIfOaxZCKcqRjvTszpmLJTa8IvkrtopvLp7t9j2eMP1sj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhSJElul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC65CC4CEED;
	Tue,  2 Sep 2025 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756821003;
	bh=+wPuKdc/Rol6aNMF8Od+YrhItlb5399wVfGd0zdb71M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhSJElulfDzcfFS3Z+tB2Znyt8zlpD1RDZe3L3jQMNFF/VRc3ydd2EV0qMooFvPnN
	 TnLdp8OiOWa15He0VlOjEhLY4FZ2NxzrYjbPxEMeBftom/qNxOSDvY3zIuH1PFB7mJ
	 7UUmnZTAQnV75hmMFuC6FmaOWrBVyWU1kFftakafZKV423UwPcbxf5rLrGiqMQd6be
	 yfXXZd2RJi1dgoXpnZiqH03ba58wNaK9n292nxpoV0lQ7G52F0qIkkx1kYelSoflgh
	 Zpa57/Q0zq1s3MO8xCrCclT6ZVw4/l+JBHG0sHjLHENMlM4Wk5sgpMoebsmZIMz3WP
	 Y/hcBqE+QIBYQ==
Date: Tue, 2 Sep 2025 15:50:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: Remove unreasonable detached state set in
 tick_shutdown()
Message-ID: <aLb2CIlAoaIsY4H8@localhost.localdomain>
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

Good catch. Looking back, it has been that way since the introduction
of clockevents and tick. Therefore it's not a regression and probably
not worth a Fixes: tag.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

