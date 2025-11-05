Return-Path: <linux-kernel+bounces-886151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585CC34DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8853AFD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B52FB0AA;
	Wed,  5 Nov 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="39Ar6L71"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEF2DAFBB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334759; cv=none; b=hK47JPf6rt0xo1dgk2ABpYVZR+5X2uhjRT1hsYxOu5TcrZ4f2wj18/lIyuvm6MRFNwpDdlcETKmeDoEJBpAIQqvoMI0fubcVcnRj6DCvvR7fx2eZk+fXxvCLdc+JTE4K7IFTTkKBmDn/h6ZiLQRUJPqAWviLn2W1vmUQpWhI7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334759; c=relaxed/simple;
	bh=YLCY6KoZNLa7vHc5RNaTfKuapI5hlvT7WdHoBE/M/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU6twudhILP/ekFEGYXEyPcXcQMR09frJ7Fw6VsGLLFFgct7eXkGSjFV/6VFi3CV3sEj8YWh0jHhft2j2TpWWXbkLRXfYKkYEZZ0NvwyVgiAKQDH9MGkpURKowiLdYbSSQJf1vF1OqnfI6OFvk+ppX1wZBOQmI9VVb48WrR/tGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=39Ar6L71; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sqgWRXjttzObVJLymVW8XIkn2e1aek+kDMfNqUEVqsk=; b=39Ar6L71VuxTgbn3BslsYXsECY
	q6u6z05IYn43nxegoaDhyN6RjUTdvel8SZR/6JG949XEi8HSgJ8sbec49bOOn9Fxi7iy/9C0kwiDf
	U6j+cK2gcadGMk1541Np+0CZZdo+Na6+udx5V5MNozEMUKbss9KEz6/v4/9Pk5/9jTgCGG3niUSrD
	ucNqIC2RFRG/Hn7gSMX3uUgCZJ05x1YNuCQZ5QX7GYW/Bv819kCYTBzQyL325D/S/TF09jKZ5X9ZM
	f7ZyX1Vluco+OlsRCknMhE++w66xi2wTlkaq84tvOj+uY2ytRL5zeQmw4m0XcdBfvPZReIsm5ueis
	5k3xLbsA==;
Date: Wed, 5 Nov 2025 10:08:52 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix constraints handling if
 current state out of range
Message-ID: <20251105100852.2c01dd9f@kemnade.info>
In-Reply-To: <aQoFC3YDNlw4imML@finisterre.sirena.org.uk>
References: <20251103-regu-fix-v1-1-c8a46581c850@kernel.org>
	<aQoFC3YDNlw4imML@finisterre.sirena.org.uk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 13:52:11 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Nov 03, 2025 at 08:32:41PM +0100, Andreas Kemnade wrote:
> 
> > -		if (current_uV < rdev->constraints->min_uV) {
> > +		if ((current_uV < rdev->constraints->min_uV) ||
> > +		    (current_uV > rdev->constraints->max_uV)) {
> >  			target_min = rdev->constraints->min_uV;
> > -			target_max = rdev->constraints->min_uV;
> > -		}
> > -
> > -		if (current_uV > rdev->constraints->max_uV) {
> > -			target_min = rdev->constraints->max_uV;
> >  			target_max = rdev->constraints->max_uV;
> >  		}  
> 
> There's a valid issue here if we can't represent the exact constraint
> (the hope was that people wouldn't specify constraints that their
> hardware wasn't capable of representing but we can't exactly stop
> them...) however this change is risky in the case where the voltage is
> too high since if we specify a range from minimum to maximum we'll try
> to select a voltage as close as possible to the minimum.  That could
> result in a large change if the range is wide, and potentially go under
> the voltage the hardware needs for it's current configuration.  We were
> trying to set the highest voltage in the range to minimise the risk
> there.  This isn't a concern in the case where we're raising the
> voltage.

So basically you do not trust the constrains too much (which is
understandable) and think that
a voltage near the boot default is the safest one.
As a hw engineer I would first try to wire things to regulators having
useable defaults (in that case a too wide range does not harm, because
voltage is ok). As a second choice I would use a regulator being off per
default which needs to be configured to a safe voltage. Then of course
ranges matter, but IHMO there is no indication which voltage in the range
is the safest one.
But again, this change is dangerous. maybe another tag like
regulator-prefer-low/high might be interesting.

Having to specify odd values with more than 1 ppm precision for
a regulator with maybe 1 percent precision is also ugly.
So the only improvement possible is to find the nearest possible
voltage via list_voltages() still matching the constraints.

Regards,
Andreas

