Return-Path: <linux-kernel+bounces-877837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89DC1F29E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E13FB34CE84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCDB33F360;
	Thu, 30 Oct 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mY6pkPFU"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0233CE81
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814769; cv=none; b=RfYyLeKDPIHmHfmKDuR5yp2MvCCIeIWkwZJbtQt4ItIXyBNW0BnT/E6FG+UCYNDcammUaKktNqOvJ+ASw2/E4fiUNoIPCoP8ehw7avaDyULRDkgZJgwrOfdTuS+UySUiOIrnukl+HXNskJReGRZNUpMWhrY54YpSxd2etE3SMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814769; c=relaxed/simple;
	bh=U6heQvyewxIdyBoQbMeJi5kw1p1bSqxUUFx25JMoL+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm1oD/vMye6Hs6sCs2coqvJ9xN0HKPoC8hKczCQcENkHpilCG/winOjw+00cUcs7SyzJ5MNkbkqUecveCLXSmsRQUXigfBwZ5soKNRIx2YifUK3zBZJvQQV41iP0OX9tLoRxgKErinPpqn0bcUD/UcJMscSgPTBANmejvCb/f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mY6pkPFU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5452920019;
	Thu, 30 Oct 2025 09:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761814756;
	bh=+sawMQzYmweVNdKEd3u5PdAq+llfD6bZkkqabCx4ovc=; h=From:To:Subject;
	b=mY6pkPFUa+xw+4TJSm5dXDUyc7xw/FVpq1bsbGmjh+3kVBZ4E3ohTSH0/nMl+qE8o
	 l0xkWPTRFUfiUPSjZCuk32isBirZPg2UoM5TsVFfBD7gozvdlh9EMilmmX1WUMqGeQ
	 u4es9J4NGv9jyJcOtMMpmD9um/Sj8iyMC6FsuksW0DS2KgEO8HxubUXJrNIBbszegD
	 C86URS2GfrE4yE7PEx9k/gkHwM65xqmc6fUU0lY3cw6iPO9DoTI6rShKSM2JUtk3On
	 J9hAvpBtgnCuChfLrcdUvshh5D3lSyVW+Ns/FLWPWIkuyB1KY1dDEBVx0o2eCw0XSC
	 mg+K642z2zSCg==
Date: Thu, 30 Oct 2025 09:59:12 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	hiagofranco@gmail.com, u-kumar1@ti.com
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
Message-ID: <20251030085912.GA19297@francesco-nb>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
 <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
 <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
 <abec6709-b9ef-4f33-afbd-eeb69a07b941@ti.com>
 <da788554-1962-4fca-8318-278e9224af59@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da788554-1962-4fca-8318-278e9224af59@ti.com>

On Fri, Oct 24, 2025 at 09:08:09AM -0500, Andrew Davis wrote:
> On 10/23/25 11:48 PM, Beleswar Prasad Padhi wrote:
> > Hi Hari,
> > 
> > On 23/10/25 22:48, Hari Nagalla wrote:
> > > On 10/22/25 23:38, Beleswar Prasad Padhi wrote:
> > Hmm, this was how it was until 2016 when commit
> > 9f0cee984a25 ("mailbox/omap: check for any unread
> > messages during suspend") was added. Do you
> > suggest reverting 9f0cee984a25? Hope it doesn't
> > break any existing usecases for OMAP platforms.

> 
> Checking for unread messages during suspend is still correct,
> what we then do when we find them is the open question. We can:
> 
>  * Not suspend (current situation)
>  * Suspend anyway, deleting them but with a warning

I would propose that we improve the current patch and just add a
dev_warn when there are unread messages.

Andrew?

>  * Save and restore them

As of now our platforms (Toradex) are broken because of the changes in
this series https://lore.kernel.org/all/20250908142826.1828676-1-b-padhi@ti.com/
(now in mainline), and I would love to get it fixed sooner than later.

Francesco




