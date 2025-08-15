Return-Path: <linux-kernel+bounces-771322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159DB2857B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AED1D042FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D130DEAE;
	Fri, 15 Aug 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p21xSf84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCE2F9C5D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281088; cv=none; b=NmgQQRZ0Va+MNrNHBVqI1DmFrSkwoSu4xeCpm/IadqiOXI3ctaTkZClWvjuo4SzM/X/p8WlaN29t/8Aauz2xjbciR2Thh6adtM59mY56RxU4WUcnVkkg/a7x9iXWyS44XHqvdESA0jOlni8TmbYnPoAxKmE5zSnmHga7Tgd0vQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281088; c=relaxed/simple;
	bh=8gEuthXk9CBAXhxkBsrpmxZWu3cLD9TLj8GcNEmqiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRHaG2wt+nCzKbh30oLVuXwydFxpP/fHTIyf+ee/f7U/SLx0qoNJqxARHNWd/IvZ2HfKMp4awxGcNklHwD9b849ky5Avx84TEUVAPOauVVFNPXqRbX/NrLPpbWwSblpK/gZH8us20uqNcxCWcNEJVlr6E2piIaxXRHTWqJjbysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p21xSf84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95B2C4CEEB;
	Fri, 15 Aug 2025 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281087;
	bh=8gEuthXk9CBAXhxkBsrpmxZWu3cLD9TLj8GcNEmqiwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p21xSf84vNYEbThY/mARQdIc3i4hDxwU9DXUEotL6Ukh2HEMXg0Xe1ie5KSvvJs/Z
	 lXWX0gW2/R32hTJXxg0JTizO1EijYwmAQ81bSVbJuYhsGvpamI/Dn90VvyO3l2gvrG
	 nc0mvH1OInW4RRf/tIArUjq3FCw09z0ywDvNsbRuq491en7A4B2/AUyXrDQMXTUG/V
	 dM+N35cJC8PmbTadiH6V5cYKLtJqqdTXVD6DDEAAPvyK8wCNTkCi9U23oorWca7QLy
	 +uKAsfO9BO1hrJmxTW+6Gn9t9p+kEEG1unMxpKQOFmxrvq5GsaNNsJyECYrcIiUe1f
	 6Le3NaGOC/MmQ==
Date: Fri, 15 Aug 2025 08:04:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
Message-ID: <aJ92vqBchsh-h-0z@slm.duckdns.org>
References: <20250815094510.52360-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815094510.52360-1-marco.crivellari@suse.com>

Hello, Marco.

On Fri, Aug 15, 2025 at 11:45:06AM +0200, Marco Crivellari wrote:
> === Introduced Changes by this series ===
> 
> 1) [P 1-2] Replace use of system_wq and system_unbound_wq
> 
> 		system_wq is a per-CPU workqueue, but his name is not clear.
> 		system_unbound_wq is to be used when locality is not required.
> 		
> 		Because of that, system_wq has been renamed in system_percpu_wq, and
> 		system_unbound_wq has been renamed in system_dfl_wq.
> 
> 2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users 
> 
> 		Every alloc_workqueue() caller should use one among WQ_PERCPU or
> 		WQ_UNBOUND. This is actually enforced warning if both or none of them
> 		are present at the same time.
> 
> 		WQ_UNBOUND will be removed in a next release cycle.
> 		
> 3) [P 4] upgraded WQ_UNBOUND documentation
> 
> 		Added a note about the WQ_UNBOUND flag removal in a next release cycle.
> 		
> 		
> Per-subsystem changes will be submitted in different series inolving also
> maintainers.

I'm afraid these are a bit intrusive for me to apply directly. Can you
please split the patches in this and related serieses on subsystem tree
boundaries? e.g. Network flows through the same tree but different
filesystems often have their own trees. Please prefix the patch title with
the respective subsystem's name. As the base patch is already in the master
branch, you can ask each tree to take the patches. For trees that don't
respond after a couple pings, we can route them through wq tree.

Thanks.

-- 
tejun

