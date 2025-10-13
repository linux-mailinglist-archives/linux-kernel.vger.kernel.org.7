Return-Path: <linux-kernel+bounces-851221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29560BD5CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1164218A41C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EA2D8782;
	Mon, 13 Oct 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxyxqFav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD52D8764
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381821; cv=none; b=AGGujDNGg1aw9U3F2T/xby7T36PgDqjIpy4L3SaElyBDfuUvLhSybFI7xgfC/7E3iDjytoOkLfsUsNnd09L0GQGHpvSGUgFiHY8Zl9lE6GyfXQe8i2805p2wEG9GJPm5EI7n1iICJc39lXlq78SKvTxdskLyvghRDd+xKY50oGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381821; c=relaxed/simple;
	bh=Ti5zW6NXVJz9qw1S/4f/bUVmLnDUv9GHD+fc0xUG3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMpatFQ0SikavlNgEsFgWzM0RXB4FvtPML0FAjLKGtpL15ie7W356o7dswjcXCxnda1WhHmz+uwG8XoVMi9+1eMkutkazl48HP3dG4mI3PcQOb3dHgfSeo95bKDFS0FPsfpZLcdLzgDzjWLFZO/jnVBLB7dpIlUEawGmcGOmuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxyxqFav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24622C4CEE7;
	Mon, 13 Oct 2025 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381821;
	bh=Ti5zW6NXVJz9qw1S/4f/bUVmLnDUv9GHD+fc0xUG3zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxyxqFavwYpxV4FnyWzfas+hoic9slysnq6O7YPUarJ9TmUZStkzwSOf/wTcirQcF
	 91ZcX+1nwVLh6+te3smhW5RJetrtZlQu7uwqqbBsMZDNppd2lapU7Bb+otG8HknJWn
	 5XP03hqXmIiwdKQJgOIEhC8GGMZ6o36pJbK7H6vM0djVFR7QfsIdP7zYPYyRvtzhMQ
	 /rqswDWHJUdV+zf+xR0kfoIHMvTNU/zYI71y1WHBT07ZyHlsWazbHtYbSMTtK11Hgz
	 dZY6RVFd/pGusvXk//N/mQBS0a4cJyck65J6Js1nJ+q+4FwvciugOcoSFYVJXQjMmJ
	 WrLXkXzk8wBtw==
Date: Mon, 13 Oct 2025 08:57:00 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: linux-kernel@vger.kernel.org, suzhidao@xiaomi.com
Subject: Re: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Message-ID: <aO1LfA-G_Zb4Sqc7@slm.duckdns.org>
References: <20251011071651.99392-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011071651.99392-1-soolaugust@gmail.com>

On Sat, Oct 11, 2025 at 03:16:51PM +0800, zhidao su wrote:
> From: zhidao su <suzhidao@xiaomi.com>
> 
> Implement the missing cgroup_set_idle() callback that was marked as a
> TODO. This allows BPF schedulers to be notified when a cgroup's idle
> state changes, enabling them to adjust their scheduling behavior
> accordingly.
> 
> The implementation follows the same pattern as other cgroup callbacks
> like cgroup_set_weight() and cgroup_set_bandwidth(). It checks if the
> BPF scheduler has implemented the callback and invokes it with the
> appropriate parameters.
> 
> Fixes a spelling error in the cgroup_set_bandwidth() documentation.
> 
> Signed-off-by: zhidao su <soolaugust@gmail.com>

Applied to sched_ext/for-6.19.

Thanks.

-- 
tejun

