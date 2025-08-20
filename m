Return-Path: <linux-kernel+bounces-778664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9102B2E89E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826AE1CC42B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33C2DE1E4;
	Wed, 20 Aug 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6lI8d/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0F280312
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732235; cv=none; b=eUAh7S/8aWsm3OuHyR2lHk+A0X3/4advAENWRkfGJQWoLM4AJYqDZyy0iCBEo7jdmbQMCpWf4Rt6oh4wO3JRSUSlOlGubeJf+06eFbxs9+ceVZKi6eX+oSpk+aJmhLkLwh0g2dIecRQj2YdTdP/FFCJ9BLwt7N8Y562edU2i2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732235; c=relaxed/simple;
	bh=eOEY776xmzTo3F7iD8nSPkn3OyCrANl5p+Xc6A7/yE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onn1MUzwoNAxdUr0vCUgwjpMEYL6eDP0zkuoSZal2ocjfxQR5p83jhBso9qOeBiisxkVXYUoJGPsG6DKZAkBvIHgWVUeA1ZIVD5FNdI47VLQlc8LjTooT5CCVgpETFz2LrslAZexKK1xz4c8mBWegWDhq3V5kq1DstuPezBDNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6lI8d/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA54C4CEE7;
	Wed, 20 Aug 2025 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732235;
	bh=eOEY776xmzTo3F7iD8nSPkn3OyCrANl5p+Xc6A7/yE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6lI8d/MCBQaSLBtgjKs4whXQSCDLOkfOy6lWRyBuruHpnpbeXaREFGMiVzbRh/SR
	 VQMiR6RAZqDNIR9ucXpStztV/K6fkThS/HY3rEA0X9IIKtTo/xcmlJ3Pys/PeFtt/h
	 kwqUJRWPjG9BoulOmoAwn0rNAnAdVDPgUDvPGStSV8uFWIcq0QVq1aXHYX3hz5+0kB
	 LBbjah+dcz6tp2aTcsSLtMUfCLkwV7ChGpyBXi3/xt966v9KUExzwkL0LESQqJ1puq
	 AZdQ/rXkLIhEyTS/+F2+8xkFueCNdFwBNqApNGqp0o1T1N43lfllCmpG1S1TZMx2pv
	 SMRqKWijGR0lg==
Date: Wed, 20 Aug 2025 13:23:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/2] Workqueue: fs: replace use of system_wq and add
 WQ_PERCPU to alloc_workqueue users
Message-ID: <aKZZCrE7IxtQz8kG@slm.duckdns.org>
References: <20250815094715.54121-1-marco.crivellari@suse.com>
 <20250819-maden-beteuern-82c84504d0b3@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-maden-beteuern-82c84504d0b3@brauner>

Hello,

On Tue, Aug 19, 2025 at 01:23:26PM +0200, Christian Brauner wrote:
> > If you agree with these changes, one option is pull the preparation changes from
> > Tejun's wq branch [1].
> 
> I'll take it through the vfs-6.18.workqueue branch.
> Can I just pull the series from the list so we have all the lore links
> and the cover letter?

I believe all the prerequisites were already in -rc1 and you should be able
to apply the series without pulling anything else. Marco, please correct me
if I'm mistaken.

Thanks.

-- 
tejun

