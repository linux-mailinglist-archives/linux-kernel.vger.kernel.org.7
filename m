Return-Path: <linux-kernel+bounces-894284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E8C49AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A614EABA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7A2FC89F;
	Mon, 10 Nov 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lxDn1Fxj"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F25285042
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815378; cv=none; b=UJYG1CFIxj0THJNaSb4Pq9YJRJRO5OxRK62a7kmOhGmJcHM5tVgDf74BHPglOIGGKTIP7RfC7hUcuok0u5nmi63j6iPFaxi9JQ++JzrezzXQEVPhvmzpPbBk+AiTmUToJ6Y2+QRM88JMe21VyDt70QznsyNkt8AvgPwjKlISomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815378; c=relaxed/simple;
	bh=vLIxARpKcErC7wk4JXZzQ3amecQzKjehsKBpEBGy4vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVwHMnj/kdrgqu0cyCiQ7sxJxiCsuNaDFylqAHUCfik+kkS/Mc7kuM43KzQOUXuNdh7Kcq0gISxRJv84uU8j+TlvYa2zW6M5b9nFZbVK0Iu3F+tH9obeXArIXoF+x32NibvAITbhc/kD6uQ9QC2M2TC/ZXt7YobzSNQP6tXyk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lxDn1Fxj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E74E14E4160B;
	Mon, 10 Nov 2025 22:56:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F06E606F5;
	Mon, 10 Nov 2025 22:56:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97BAA103718E3;
	Mon, 10 Nov 2025 23:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762815370; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=N3XlahNel7+bMFIXgUQOE7mTQREs+Hvom8NVkTGqzuA=;
	b=lxDn1Fxj4TCJYAuGyNLBtgZTBKYt7oXgv+9JYBFWhv570AzAsX1mu+MlTAZTjx3Tm2NmeN
	fXns+zAJtHPyttmQdctQF1EhkvESl6FrplijQBuuYuaUguyIGAhUjiDO8pHHWlKSxkFlD2
	lnMidvKJ9vy2pcXBb4v2ffJKQ2vLXDul961IcoMU6nf8HoQIYK/J4cueyrePSkeaNC9szo
	tXDzc+8g36za1mdSFUHn1em56WkeKr+nUTj9LC57+kGP9Zo5X9j3m3YybeMd/6uh6J6Fw2
	29MywZQyprVW2H4hieAM8fI1gEp5QJwHuBHAsUbnKpxsYQjTHh8iFQtdoXfLGA==
Date: Mon, 10 Nov 2025 23:56:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] i3c: master: add WQ_PERCPU to alloc_workqueue users
Message-ID: <202511102256074aa37109@mail.local>
References: <20251107132949.184944-1-marco.crivellari@suse.com>
 <aQ5d1g95N86lXXT2@lizhi-Precision-Tower-5810>
 <20251107222830.oPfVHd-_@linutronix.de>
 <aRIaQOQkbPOFpJM+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIaQOQkbPOFpJM+@lizhi-Precision-Tower-5810>
X-Last-TLS-Session-Version: TLSv1.3

On 10/11/2025 12:00:48-0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 11:28:30PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-07 16:00:06 [-0500], Frank Li wrote:
> > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > > index d946db75df70..519b98c37ac7 100644
> > > > --- a/drivers/i3c/master.c
> > > > +++ b/drivers/i3c/master.c
> > > > @@ -2925,7 +2925,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> > > >  	if (ret)
> > > >  		goto err_put_dev;
> > > >
> > > > -	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
> > > > +	master->wq = alloc_workqueue("%s", WQ_PERCPU, 0, dev_name(parent));
> > >
> > > Maybe off topic, I think it is not neccesary to create wq for IBI at all.
> > > it can directly use system_bh_wq, or other wq.
> >
> > Do you really meant system_bh_wq or would system_unbound_wq do the job?
> > The _bh_ one would imply softirq usage, I don't think you want that.
> 
> My major means is that not neccessary to alloc a work queue for IBI. Use
> one of system predefined should be enough. system_unbound_wq is good
> candidate.
> 

I don't agree because you may want to be able to prioritize handling
IBIs vs other work so I believe it makes sense to have a separate
workqueue.

> Your change is also good, let's wait for more reviewer's comments.
> 
> Frank
> 
> >
> > > Frank
> >
> > Sebastian

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

