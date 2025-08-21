Return-Path: <linux-kernel+bounces-780637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DDB30728
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BBA3ABAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605C283FF4;
	Thu, 21 Aug 2025 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jygWIEZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560428134D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808178; cv=none; b=CeIJbjn+FGSKLcOUEdgilKKnpIsXozUjeM9iV1Rt1oLqFrN8JpU3Y9PbwpGeSkPMX8f3TiZqlUHpiegIMZjfaII89++2qptQsDYIHODz5mEQx5bOTIXEX5nxe5CT2uKbB5W1VLVOdZOhGdLZzC4uBt/pi/hOL77mZV4LFOg1T5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808178; c=relaxed/simple;
	bh=7K3kx1KyG/76XsV5uTDkdTJ78pLV7GXuiU0eWqdi8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4BSDsKrAPRK9di9oaQie+hsC0IvMn8DQfrYsaN75M17h+NMdK5Z7Potg0OL68fZmxNAX+F/UgV6d2JhM7WAxRQAcz6158SboytgytLfUbNhgRUsvphA4q8h5r8oKumI+NBCHDGdJEjGyORjcxpJ3kOAjYET2UchPh+rbuKjO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jygWIEZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4F8C4CEEB;
	Thu, 21 Aug 2025 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755808176;
	bh=7K3kx1KyG/76XsV5uTDkdTJ78pLV7GXuiU0eWqdi8Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jygWIEZznwh3c8GRwpzJhzpe+U3lR6yGwXR3jYLJSRlbJ2PZk/Y5Qzh+4vWSP2Loj
	 JCDohpEZsikoGAZUfOsPn96nzvU/9nmrkcqmoKcscdN5wdrGtpf4VEn/Vy+s3XQOFv
	 eTmBq2AtDBmGKBSbHYn8lIrBXvs4/2eT9ZaQwg2nFgD5UMJkZdma6Gh3pCxsyduxDe
	 eePUahMPLPubRBLDu4oxzc2s/40Rq3Pb3KxbABVQj7gnSixWBC6LyR2RUTDN85GprI
	 MOTkDyISIm+X+XI7jsSMcj4cQ3dn4ZW7IfJRj4dxK9wpcllSluT5hyFSNGOkFIIRPJ
	 Z7G5jbUqR6L/w==
Date: Thu, 21 Aug 2025 10:29:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
Message-ID: <aKeBr3eBfh0wr_fH@slm.duckdns.org>
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org>
 <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>
 <aKZYEDYHYs3W2OL0@slm.duckdns.org>
 <CAAofZF7gEeKVWf_i3uCj=QPNpDXmunb30_6MqiXRHbb9wGHKCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAofZF7gEeKVWf_i3uCj=QPNpDXmunb30_6MqiXRHbb9wGHKCQ@mail.gmail.com>

Hello,

On Thu, Aug 21, 2025 at 09:40:58AM +0200, Marco Crivellari wrote:
> > On Tue, Aug 19, 2025 at 02:28:12PM +0200, Marco Crivellari wrote:
> > > Another question / observation: I guess maintainers can't just pull
> > > the changes and merge for the next release, if the workqueue changes
> > > (e.g. changes in queue_work() etc) are not also merged, right?
> > >
> > > I received a reply here, in the meantime, in "Workqueue: fs: replace
> > > use of system_wq and add WQ_PERCPU to alloc_workqueue users"
> > > (https://www.spinics.net/lists/kernel/msg5811817.html).
> >
> > I can prepare a branch that fs can pull but aren't all the prerequisites
> > already in the master branch from the last cycle?
...
> There is still the logic inside "include/linux/workqueue.h", in
> queue_delayed_work() / mod_delayed_work() / queue_work().
> Just the pr_warn_once() and the workqueue redirection.

These are not prerequisites, right? In fact, we should add the warnings only
after most of the tree have already been converted.

> These changes are introduced by 2 different patches, based on when the
> two new wq(s) are replaced inside the code.
> 
> There are also changes inside  __alloc_workqueue(), always in this
> series (when WQ_PERCPU is used), because they are the "general" (core)
> changes.
> 
> If I remember correctly we decided to keep the prerequisites without
> any more "logic".
> As long as this series is merged before or anyhow in the same rc, I
> think there are no problems; right?

I'm having a bit of difficult time understanding the logic behind how the
patches are laid out. This, while a bit tedious, shouldn't be that
complicated:

- Add all the new things to workqueue[.hc] so that the users can be
  converted in whatever unit each subsystem wants. Note that this shouldn't
  add any warnings or cause behavior changes. Just introduce new interface
  and convert the subsystems clarifying that it's a noop change.

- Once of the initial conversion pass is done and merged. Add warnings and
  other mechanisms to get the stragglers and prevent further addition of old
  interface. We can do this right after a merge window as a fix patch so
  that we don't have to straddle multiple releases.

- Go subsystem by subsystem and make the functional change you want to make
  (here, converting from percpu to dfl). This can proceed without being
  coupled with anything else.

- After a cycle, drop the old interface.

What not to do:

- Don't make workqueue changes combined with a lot of changes to other
  subsystems. Workqueue changes should come and after those, not together
  with.

Thanks.

-- 
tejun

