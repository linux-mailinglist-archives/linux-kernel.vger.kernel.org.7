Return-Path: <linux-kernel+bounces-735516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB8B09066
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135227AA26B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754282E49B1;
	Thu, 17 Jul 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e69wEdF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56771E5705
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765525; cv=none; b=cnu42edfA+gD4H6tn9yeW8KgR/zrUtLA48R9Zodf96zJiFOECiDZ6Fhzal5UcVAplschnPx3q4XRJAX/hweuWEsnmggazjo20lDsyYMlxNRzYTXZctRhtgpJG0Ul6CNF2VmtA/7dMH8ekzLGiYKrZE5h3DoZpFWQsCkWTZajTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765525; c=relaxed/simple;
	bh=Jw+UufvGG9YoXeX/nFnnouHPq9n7dVmvn+Bie3jDHBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1d11K9XMATahV8KIOQR7d4tvZr2ThZSIZMCuKU+6o157/OUovhnNPz/pDoEKT5OevnojSKrfAi76NoZZ45kOepqyZ0ePEC/JHu/q9OYWUY1N1iDdChBJ/TC11ZaH6sXkk8U3JUMETe4J3SCEJd3R/dVQCgyhrAqPJQPY0axc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e69wEdF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D86C4CEE3;
	Thu, 17 Jul 2025 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752765525;
	bh=Jw+UufvGG9YoXeX/nFnnouHPq9n7dVmvn+Bie3jDHBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e69wEdF7/wu2NNbteCHp+xXQoVctHXe5Ybgobxf+pddr4vSu5vqcHmV+ouuoU3iWz
	 ysx9L7jOmtyRhQ8h9k9Sa7IoMhPoHhKj6y8GlCQ8yCdGOsRrZmiX4YgYrzxCfvaCSO
	 8V8lX167yI5kxnDhHeBsh5o0N6ZsEAyxqyjzuroMJB2jnaapO3h9gWgmDg1EXOkNK5
	 498azzqhrCdaZfJZs4nO4VJBjSP5Bwb6ZVtllbmTVRFCwY9QLdgB56tgeN+FISA9af
	 2mrE01RsEv8uLPu6Vr/xmwvDNjGXdSyaX/XwHx7Y4A4lL2wRmkbN5kGlDMaZRdOrX8
	 YOs1/LuW1gzKw==
Date: Thu, 17 Jul 2025 17:18:41 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Message-ID: <aHkUUWFk/AIxh1Nj@lpieralisi>
References: <cover.1752693640.git.dan.carpenter@linaro.org>
 <4787a3c4-9713-4b99-9b8a-7ba227e91d02@sabinyo.mountain>
 <aHjBe9k2Igl2iopq@lpieralisi>
 <5c22b679-853d-410c-973a-ba3c91a54b84@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c22b679-853d-410c-973a-ba3c91a54b84@suswa.mountain>

On Thu, Jul 17, 2025 at 05:41:06PM +0300, Dan Carpenter wrote:
> On Thu, Jul 17, 2025 at 11:25:15AM +0200, Lorenzo Pieralisi wrote:
> > On Wed, Jul 16, 2025 at 02:38:22PM -0500, Dan Carpenter wrote:
> > > There are two issues to fix in this code:
> > > 1) If gicv5_alloc_lpi() fails the original code was checking the wrong
> > > variable.  Fix the mixup between "ret" and "lpi".
> > > 2) If irq_domain_alloc_irqs_parent() fails, then clean up all the loop
> > > iterations instead of just the current iteration.
> > > 
> > > Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > >  drivers/irqchip/irq-gic-v5-its.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> > > index 55360ae9f1f6..8cc8563e27d5 100644
> > > --- a/drivers/irqchip/irq-gic-v5-its.c
> > > +++ b/drivers/irqchip/irq-gic-v5-its.c
> > > @@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
> > >  	device_id = its_dev->device_id;
> > >  
> > >  	for (i = 0; i < nr_irqs; i++) {
> > > -		lpi = gicv5_alloc_lpi();
> > > +		ret = gicv5_alloc_lpi();
> > >  		if (ret < 0) {
> > >  			pr_debug("Failed to find free LPI!\n");
> > >  			goto out_eventid;
> > 
> > This should be:
> > 
> > goto out_free_lpi;
> > 
> 
> Yes, you're right.

While at it I'd rename the label, out_free_irqs or something like
that, now we are doing more than freeing an LPI.

> > otherwise we miss cleaning up for [0, i - 1] on LPI alloc failure.
> > 
> > I can fix it up - not sure it is worth splitting it into two patches,
> > just let me know please how you want me to handle it.
> 
> I don't think it should be split up.  As a reviewer I would be annoyed
> by a split up version of this.
> 
> I'm a little bit surprised by the offer to fix it up for me...  Is this
> going through your tree?  It's probably easiest if I just send a v2...
> Let me do that.

I just wanted to help. FYI Marc has sent a PR today mentioning these patches:

https://lore.kernel.org/lkml/20250717122306.4043011-1-maz@kernel.org/

I think that keeping the CC list is good so that Thomas can pick them
up if he pulls the branch.

Thanks again for fixing these issues.

Lorenzo

