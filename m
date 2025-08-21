Return-Path: <linux-kernel+bounces-779631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6223B2F690
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C33A77D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A22EA496;
	Thu, 21 Aug 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMXeOdY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D21DF756
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775392; cv=none; b=bEHxcMrXf+5r85RKXig5GHv8VkB8718uo/5D+Je0gzDKJUy31Py4WAXp602TtITNgWwuFr9g3Io31gVHKZQGDcpXwZv+ePZYia98QBRrK6/f411yHHarZhfqwU5rIU2Nmd7X++/ghRbcS2spNn8/QuCBVG22FLp8D6GitFf5qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775392; c=relaxed/simple;
	bh=mWJEKc5jIaYJEG099XxYCzMuKRNuIYKpy4QvY9UX7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpiulGrdNP1+kD5Fuxn/DC1ViOZW9GmOYx10Gi8OMjr1XCf79B4hCMbXSAAV4ck6UfoLkRrgOiZYtsTfFOUE25CsRsgOJj9LQfM8IyDunTK+KweinhA2e+p4cAMCZTY4u+6K/7LLN4dbXM7tzH2xC+HjGeCvHt8n+M3v4x6uE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMXeOdY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F27C4CEEB;
	Thu, 21 Aug 2025 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755775391;
	bh=mWJEKc5jIaYJEG099XxYCzMuKRNuIYKpy4QvY9UX7PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMXeOdY2KYSyNpUy7Wvfvlfu1THCJpyoP0+cjtfseDScegyH4gE2i12MwZTmvEGqj
	 ul5CZKppl9O/oeZTVKMNOMDDTda4EBQjI/vENAsK1CRolaMehoF0szxiz55CYgqjgy
	 gmtCkedfpnmKu68Bow72XFEkyS1ucR29CLTPmgLXJ9a+RNy/AOX5PKUPzcZJ3TjmHy
	 o3NH9vv5HVsAfOhARuCV/qb/KY1BbPjtBzuHlpNX4KVUqsyfZHODxBDsJ5Y4I8gqjO
	 bHBrMnu6w5n/mscXhGAWZGHiFkklvEBgwJ+9hlupQOKfHlxW8zW6xEq+WRtD3vxeYy
	 +AD4yT7nol9sw==
Date: Thu, 21 Aug 2025 13:23:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/2] Workqueue: fs: replace use of system_wq and add
 WQ_PERCPU to alloc_workqueue users
Message-ID: <20250821-hufeisen-heute-8005f698a331@brauner>
References: <20250815094715.54121-1-marco.crivellari@suse.com>
 <20250819-maden-beteuern-82c84504d0b3@brauner>
 <aKZZCrE7IxtQz8kG@slm.duckdns.org>
 <CAAofZF4SKz8UDmWuaiVkNVw5NYf0ZfDacdcOxSFYUNOyJ0=-KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF4SKz8UDmWuaiVkNVw5NYf0ZfDacdcOxSFYUNOyJ0=-KA@mail.gmail.com>

On Thu, Aug 21, 2025 at 10:40:30AM +0200, Marco Crivellari wrote:
> Hello Tejun and Christian,
> 
> > I believe all the prerequisites were already in -rc1 and you should be able
> > to apply the series without pulling anything else. Marco, please correct me
> > if I'm mistaken.
> 
> Yes the prerequisites are in rc1.
> 
> But there are changes introduced in
> https://lore.kernel.org/all/20250815094510.52360-4-marco.crivellari@suse.com/
> ("Workqueue: WQ_PERCPU added to all the remaining users") that in my
> opinion should be present as well when this series and the others are
> merged.
> 
> For example, there are changes in __alloc_workqueue(), and also
> changes inside queue_work() (include/kernel/workqueue.h) that were
> added only in the "core" patches / series.
> 
> About queue_work() and the other functions, changes are made by
> ("Workqueue: replace use of system_unbound_wq with system_dfl_wq") and
> the related patch (about system_percpu_wq): it is mostly about add a
> pr_warn_once() if the old wq is used, and redirect on the new one.
> 
> Btw: in this fs branch I only have the prerequisites and this series,
> and I can compile and boot.

So either you can give me the fs specific changes without any additional
workqueue changes and I maintain a stable vfs-6.18.workqueue branch that
you can pull and base your additional changes on or Tejun gives me a
stable branch with the preparatory workqueue changes that I pull and use
as the base for the fs specific changes.

(Please note that vfs branches are usually pulled first thing during a
merge window.)

> 
> Thank you!
> 
> 
> On Thu, Aug 21, 2025 at 1:23 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Aug 19, 2025 at 01:23:26PM +0200, Christian Brauner wrote:
> > > > If you agree with these changes, one option is pull the preparation changes from
> > > > Tejun's wq branch [1].
> > >
> > > I'll take it through the vfs-6.18.workqueue branch.
> > > Can I just pull the series from the list so we have all the lore links
> > > and the cover letter?
> >
> > I believe all the prerequisites were already in -rc1 and you should be able
> > to apply the series without pulling anything else. Marco, please correct me
> > if I'm mistaken.
> >
> > Thanks.
> >
> > --
> > tejun
> 
> 
> 
> -- 
> 
> Marco Crivellari
> 
> L3 Support Engineer, Technology & Product
> 
> 
> 
> 
> marco.crivellari@suse.com

