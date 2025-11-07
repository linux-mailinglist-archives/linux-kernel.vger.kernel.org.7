Return-Path: <linux-kernel+bounces-891097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7575C41D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6252B18990F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58E313E05;
	Fri,  7 Nov 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E//4516U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFp0DbKc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D41E9B0D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554515; cv=none; b=tvPMasjf/OHBnVcxcR5GHNHoOYRLwGHxwmCgPPdGqDzYG8lrydasZZjyCU4vwW2P4QtLProvFqTHJNQhx5/lm4cbwH1oT0R/bhHvBnT6ESg6y8WHfkbyAGfBPwB/0GqC1gK98IOQN1UjP8pdDV40OcrkUkZSAhRXZdwD5Z0KUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554515; c=relaxed/simple;
	bh=rONlwRIeqOj7Wiserm4zt5d0JAPS8IvKqyqGWxAgWtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3HnVjNoDLBR4jqOoNT8MNAH+RhqQUOm0unZTkM4X+u6yw97tkIsDaQZ/3IANQV9UqVlkk774VFjEZ15MgRELAmGYtBBPQSBNiu21k4TCEugkMmcPohMLoCxArGg0sgW/eAI8D0+gjKngiVAoC22Eyxv8dHb0oDbcuj6QvRO0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E//4516U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFp0DbKc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Nov 2025 23:28:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762554511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r05CHmfoNFTHMRYgAoEg/9Ojn29EhWfm42yusnTJdis=;
	b=E//4516Usei6KfxkW0VjO5fwuqvyKu2H9NUR7glhF8Sc06hzlRc7Z6XKWS4IdhLnZk8Umv
	jXR3A9wbj88+PHn1fvmkmgd4we9EGNCyAj9Ar8XqUigx8WfXO4tDmuXJbFutSsVKSGYQ+Q
	d2Y3vVSySqQm5dK4EIQNz5uW575pw+igaPt7aOQUN8fSshT4cx4JZ87Qw/xdLRIa3U2n9Q
	Zaf358lvlY3fjFXyWEVTBPRU2xHIYIhbI0MfQ17tQMm+wxFHXSM0xiWAKIZxxwlv4j61AB
	MvSpdq2l/RBw949y0fGERe6orl/tGlAn0RYO7Be4udr5mHs5bb60Gun7w6Y0WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762554511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r05CHmfoNFTHMRYgAoEg/9Ojn29EhWfm42yusnTJdis=;
	b=eFp0DbKc5vEkh3T0CEsUE3+9/i5wyzD9RUNLK/kEkYOV1e74GE229kDjSoI6P1CBsEKcFk
	zVd9DlbJEvEofyAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] i3c: master: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251107222830.oPfVHd-_@linutronix.de>
References: <20251107132949.184944-1-marco.crivellari@suse.com>
 <aQ5d1g95N86lXXT2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ5d1g95N86lXXT2@lizhi-Precision-Tower-5810>

On 2025-11-07 16:00:06 [-0500], Frank Li wrote:
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index d946db75df70..519b98c37ac7 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -2925,7 +2925,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> >  	if (ret)
> >  		goto err_put_dev;
> >
> > -	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
> > +	master->wq = alloc_workqueue("%s", WQ_PERCPU, 0, dev_name(parent));
> 
> Maybe off topic, I think it is not neccesary to create wq for IBI at all.
> it can directly use system_bh_wq, or other wq.

Do you really meant system_bh_wq or would system_unbound_wq do the job?
The _bh_ one would imply softirq usage, I don't think you want that.

> Frank

Sebastian

