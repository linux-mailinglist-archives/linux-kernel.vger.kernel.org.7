Return-Path: <linux-kernel+bounces-778658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0065B2E893
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2274F1CC3E47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ECF2DCF79;
	Wed, 20 Aug 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO3zEQsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467182DCC1F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731986; cv=none; b=smiSwPtHCvtCGAMPMmiSQGp8flMeSXqelQIuK95mQpYcS1SS84uBdHQzv7+Kecz4LtIMdf1NkNS9dsBRGVpvffMfhOnFjCJXdtoftSZSiiabqORtLYV2vpF8RqOpxooIbbKGL7W1J64q8gu7TUnlMG7RGgWksUJacMwG/64sHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731986; c=relaxed/simple;
	bh=yZaWdMLAsy4C/5siwNjbC65S7n4WvYketpGJLufA4Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy971QLHGUZLeo8wTkLATGuP+sfhuxttSAsK6bMxrZmQVtpYwzfxjRQiRRqrEpGHLVnUD+AeqzO29/khVTs9obnUmPUie3MtakZ5KE8RxOfZ/D6X4c5x23A8huJSduKV8LUoN7TuES9OMsZEinn1vE2Ve/zTRL2EnO1KKO+7+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO3zEQsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F1C4CEE7;
	Wed, 20 Aug 2025 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755731985;
	bh=yZaWdMLAsy4C/5siwNjbC65S7n4WvYketpGJLufA4Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sO3zEQsrda0tP9MveafyAvfBc3YmlDI6FZTBkBjAlMRdub+/eWp12Eamr5Epw67tV
	 O1NIlMzKSsd58ORDNs8GzqazyJkPq+cKraNBwbz5oKtc9+IcP38S29dPywRro9ShOq
	 WfTHv8Ek2f0/hniu3k3idVm6YdgBmVVQJiJeDmHH/FX+cVt1GY5HvyCw9jTLzYtNcZ
	 W9m/FjrHJL74t2j5jDNCtur6qfi6yPgoknjAfXdTb8It4AfE+V98Hj3Y3VdyqaDDtC
	 45qWqXRdtIOqH8TrdNDd5UqTD7oE4HJkNk6T+XNvVM2K4OdrohEo22mYGfEf4XuGk+
	 wrw9w+rb6R8dQ==
Date: Wed, 20 Aug 2025 13:19:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
Message-ID: <aKZYEDYHYs3W2OL0@slm.duckdns.org>
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org>
 <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>

Hello,

On Tue, Aug 19, 2025 at 02:28:12PM +0200, Marco Crivellari wrote:
> Sorry for another email.
> 
> Another question / observation: I guess maintainers can't just pull
> the changes and merge for the next release, if the workqueue changes
> (e.g. changes in queue_work() etc) are not also merged, right?
>
> I received a reply here, in the meantime, in "Workqueue: fs: replace
> use of system_wq and add WQ_PERCPU to alloc_workqueue users"
> (https://www.spinics.net/lists/kernel/msg5811817.html).

I can prepare a branch that fs can pull but aren't all the prerequisites
already in the master branch from the last cycle?

Thanks.

-- 
tejun

