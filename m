Return-Path: <linux-kernel+bounces-897031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C271DC51D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06F054F6688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726930DD1A;
	Wed, 12 Nov 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxEs6The"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256230C618
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945209; cv=none; b=TMaY6TVM5pj4vrn36kfwxfpSxf0tbu3bRFMRizA77DtTuo1Zj4dwHrw8vl9VZ5b6Ug2j3ovZS9q7mpwJsM6wIBcdd8FCB7RKtY9D4I6ZYs5HtX14NrKCxU2EkiFht4SOIjkNIlkvpyV41yjvPuD7uIRZ2A+BkB37WUyaJ6diUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945209; c=relaxed/simple;
	bh=MoI+zCjPUouomucxHrl4Tm9QWJIl5C3ILMFkQq123zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp4IefrNEqBvb5VPe8xz69ddgEjkETE3adHdJRCh0p3kuwx+f4QhF4TwWrwU95Cq06SCZZY3ROY/zw+lq6SVLq0q8+iBcLQBlxDzkJQLKSh5p1Fa8olmhFS0mpv8R1FBoi1STOcjXk/wuVTPmS4AgIzc7ON9NKmJyS6Ct1CUNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxEs6The; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BF5C2BC86;
	Wed, 12 Nov 2025 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762945208;
	bh=MoI+zCjPUouomucxHrl4Tm9QWJIl5C3ILMFkQq123zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxEs6The13lWerIlCALfpC9a53iUcOx4yeRK93Bg4SRTYYz1kngeKFEZpnlY1WGfl
	 WLYetw4VLDk9i3O8UdykpKdVPcQS4C87AViibteGdkAUFtPiyrLxHg1lGpc5y0Sqr+
	 XgveBCmYEZe3RJ77E0ilJzT9OSFw/lQLWqztllwX4R4fKNurvqLKNSft7mk/PqN+EY
	 gjPncjDMk/4saWjeN3DuC6qrU7hRpICBUD1r5gqu17vGwke/JwKyDQFH0pNFncCQn4
	 LkwKqGypRn33HL99W9EXveGoAhoy3pM5+Ufd5cmc5IWVevv5tH1TAR4nCy9AJVRIJk
	 g/BocBSJ/zStw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJ8a8-0000000027v-21Dy;
	Wed, 12 Nov 2025 12:00:08 +0100
Date: Wed, 12 Nov 2025 12:00:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clocksource/drivers: Prevent clockevent driver unbind
Message-ID: <aRRouCZKoPYKH5fA@hovoldconsulting.com>
References: <20251111153226.579-1-johan@kernel.org>
 <a728c035-d37c-4e75-89ba-b8081241314f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a728c035-d37c-4e75-89ba-b8081241314f@linaro.org>

On Wed, Nov 12, 2025 at 10:48:22AM +0100, Daniel Lezcano wrote:

> On 11/11/25 16:32, Johan Hovold wrote:
> > Clockevents cannot be deregistered so suppress driver bind attributes to
> > prevent drivers from being unbound and, for example, releasing
> > underlying resources after registration.
> 
> For non architected timers, we want to be able to convert the timers as 
> modules.
> 
> That's an on-going work [1].
> 
> Your series assumes we won't convert that into modules, so you do the 
> conversion to builtin. But actually, there is a slow move to module 
> conversion.

No, that's not the case. The builtin_platform_driver macro still allows
building drivers as modules, it just prevents unloading them.

Johan

