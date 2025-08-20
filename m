Return-Path: <linux-kernel+bounces-778662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E6B2E899
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58AD5C7FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A072DE1E0;
	Wed, 20 Aug 2025 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBwROZD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A92DCBE2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732155; cv=none; b=TEVU7Gn3/LzABIa+shmP+UBvhlZUPBoXdtYuZaPmFYW9IeP8CLiVEvkbMNXJrNgxHD2EP2auWzTVgHfWP/ph6KmHK9eAsTe67NlJpycLt4h+OU/bmzav4lNbv62TyM2zy9NsUGrVyAwBLGKxENTenC82ExdnZSP45pML7vK4//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732155; c=relaxed/simple;
	bh=PpLNXafYyYaJHl4yNf0bRH9rCTDQ/HwRXwL7LoAmxYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLTqyNJmI4QEpoSMInwOwqQYLABw5oTXLaALXkOeBLEp7mE80ipwi7AlNd/obzxnA7CeNY/lknUYY0HI9p4nw/tTq1FCmbcp4gjRlKUZivqoqfD78AuST8w4nYoDDWmLVFxNZr5H1icqgFnDu8TWdSFWHI/LGup4uKX+9DLMYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBwROZD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05882C4CEE7;
	Wed, 20 Aug 2025 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732155;
	bh=PpLNXafYyYaJHl4yNf0bRH9rCTDQ/HwRXwL7LoAmxYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBwROZD+jz6oojHUSaEUyyH7wBDl8HnMPq+RJ9egX8eT/r4Q1DNyp+N/XIvBkgTZQ
	 +i+kNkn/zf1+V5hxkQefxGojUziIFgarsYl8d3+bZy+ZMl+dP5lzh1kMF2m8WqKzBW
	 WvWX3uJUBBXNW4XR6viAkeZi38E0SMeloqkntQNNHgCEwRskSTVk3y4l68oKNHWmEO
	 WNz2MqOfeUbiEecLbLHVPVo4k6CfO7fV/rzzr2fxziDlLyZpa6BEkUkhDGI5FCOR45
	 4zEPxUYOvDdAJNIKPhZCDPeGkEHmQvnAxnEoSIi8ljqKtS7A3ppN1l8Ye0YU0Eitgh
	 Aod5KAOZGF2fQ==
Date: Wed, 20 Aug 2025 13:22:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
Message-ID: <aKZYutvp4BtcqFJT@slm.duckdns.org>
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org>
 <CAAofZF5KtD3zdrNcGekt4=sZCAAG6_a3Pz99NzfhX3iMkqLdyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAofZF5KtD3zdrNcGekt4=sZCAAG6_a3Pz99NzfhX3iMkqLdyw@mail.gmail.com>

Hello,

On Tue, Aug 19, 2025 at 10:41:01AM +0200, Marco Crivellari wrote:
> I'm not sure I have clearly understood what you mean here:
> 
> > e.g. Network flows through the same tree but different
> > filesystems often have their own trees.
> 
> With this, you mean also distinguish between e.g.  fs/ext4/  fs/etx2/
> and fs/btrfs/ etc?
> So if it is the case, in the example above, it means 3 different series.
> Prefixed like this, I imagine: "workqueue: btrfs: ....".

NVM, if Christian can apply for all filesystems, that's better.

> And I guess it would be the same for drivers, eg drivers/net/

I think net should be fine with wider scope patches, actually. It's mostly
about laying things out for respective subsys maintainers so that it's
easier for them to take actions.

Thanks.

-- 
tejun

