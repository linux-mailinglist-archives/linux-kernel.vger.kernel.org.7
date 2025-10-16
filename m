Return-Path: <linux-kernel+bounces-855675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76541BE1F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C2B541375
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B12FA0F2;
	Thu, 16 Oct 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hXClE1fA"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DA2F9DA7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600278; cv=none; b=r703WVNF4kmeEyGHX32vD/c1Q/mXUMALI7AsIZKW/jhdY3TVx/U4IPXU7V9JlDpWfLPCxOLiSfMyRVo/IM0WS/LFzOWwmEwbiqB7ahtiQcPZsotVmyMYcZszmkqLnZh9e2SdGtJa942F0lrkzxrH1UxL/kq6vA17goAJSa5ilOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600278; c=relaxed/simple;
	bh=gS9F+gN5jscHHwyj6Z+hu2js/6crT04u2epLWqCxhMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPNKunkkR8vRNpVNnRXSSH234+PoiZu+RQ5SOVFenlid/DmdynBrXzNFOUx0kS2GnHYSiceTnCWQPU0nGJrev5s1gW6zNuan9ci/bpxGd9J4pdiU1FpXBRpEFqMKqLTRXSGyvKcUOgjyRxI5F0Ht563c5/Vd4fM+MLkl0ZGH2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hXClE1fA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Gd3v
	OEz3/H0QA/38uI9tsC4yGi+xpW+XNdrIuSQvnmw=; b=hXClE1fAU+kSkVQvwfU3
	facxtvhnBaHmxgf0skpmfKC2v3Fe6GD5J9kbJT43o/kHOvjkzp14f7zviOBYhp2I
	MhbV0NQqvrZ27bFUurdVFebGQkADFG3Pn5HJzb35uqZNGa6gh+BJeN2LdTdDXzu+
	mAIEXccz7ycitVCRZOPBSan5cRlLbcj5ZyRegN0Uz+UAdCDh5FEY4AoYEQBAAQ18
	5NbhT1jkjyWFu+6w2wooo0uuXc2uzAsrUBFYrH8QZGogTekTKkojS4gGasZcvGCQ
	n0RKyNjjbHx3U0jgoiiO7i9eLa1Edmtnum8SBnNCd4qpfK+6fOhBtXk+paMa5Qeh
	EQ==
Received: (qmail 3710845 invoked from network); 16 Oct 2025 09:37:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Oct 2025 09:37:54 +0200
X-UD-Smtp-Session: l3s3148p1@6ZPssUFBTqwgAwDPXwQHAL/S9V79e5yL
Date: Thu, 16 Oct 2025 09:37:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: adrianhoyin.ng@altera.com, dinguyen@kernel.org, Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] i3c: dw: add option to disable runtime PM for
 DesignWare I3C controller
Message-ID: <aPCg0bFm4-DnmhAp@shikoro>
References: <22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com>
 <20251016071051c3f647ce@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016071051c3f647ce@mail.local>


> > Add a new Kconfig option, DW_I3C_DISABLE_RUNTIME_PM, that allows
> > disabling all runtime power management (PM) operations for the
> > Synopsys DesignWare I3C controller. When this option is selected,
> > the driver skips all runtime PM calls such as pm_runtime_enable(),
> > pm_runtime_get(), and pm_runtime_put(), keeping the controller
> > permanently active.
> 
> While the quirk may make sense, it definitively can't be activated by a
> Kconfig option. This should rather be tied to a new compatible string or
> a property.

I wondered why this is a quirk, at all, and not default behaviour. Is it
because it works with some RPM implementations and not with others,
depending on the platform?

But even if that is the case, it might be worth to opt-in for power
management instead of opting-out for buggy behaviour. Because I would
not assume that IBI have been thoroughly tested when a new platform
using this driver gets upstream. So, the buggy behaviour may only be
recognized later. Or?


