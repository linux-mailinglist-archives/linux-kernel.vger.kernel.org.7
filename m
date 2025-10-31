Return-Path: <linux-kernel+bounces-879629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F13C239CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AA618869C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4AE2F12B5;
	Fri, 31 Oct 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="OB+1MkaC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCj8OVxd"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565117C77
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897050; cv=none; b=Noz2lFElh/3FW/K0jbTg/zCjYgGl3enhXfwMN/ioYL08P91IikzQvI9O3FkwxL9tbXd4pOoOsueLwzQu2cPwdkCMkDH6P+YyUWNmcm2YEV7UlZk5Z/vucBasHhPzn/tMwxBUYlpn8T0n1MiM9lT49b+dzfHEBOrN/ipgZVKGgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897050; c=relaxed/simple;
	bh=SMtMJt9229H5PjTDv6S5YGs3DXegSlRLe7j1ltiWon0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z2/Fr8EJayp2O8hnLwnYb+UopaU/FQejzWc3pVvBibuuuelM/8mw2+ZF5MlnFaAwBogJoUmg8p9MNLAjgJLGjxXvBVN0wxitY2lhYr06yZVuQSmQZcxYgFR3z5npFys3KuVK9fDG6PD9fdUL+qU4f0gsuRk0NC4nEfR+DmnwcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=OB+1MkaC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCj8OVxd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F78A7A016A;
	Fri, 31 Oct 2025 03:50:47 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-05.internal (MEProxy); Fri, 31 Oct 2025 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1761897046; x=1761983446; bh=SMtMJt9229H5PjTDv6S5YGs3DXegSlRL
	e7j1ltiWon0=; b=OB+1MkaCVWJdu474hTwAov/7B/NxRFLvIVtnUhsIeK0sQtLp
	yknoVs2AECKZXFEWcBcEO5Q7QeEdJ4k2cFpK8ZZX13BgjJBxda7ofogMPwSjA1zd
	EvmUxfTxe+os/y0Iyw5z5FId6NozzLeeku4OGJz2XeMkijXkIUa7vJPIFMnsABK4
	MwbDkh+0T3lJqSXzUf5p6EFEJ56JaNAV7dxZUoV2IYLdYUmgvwYnweLxi2VBkQ7R
	aN+Ls/yN133hmiN2GuEDIKGP2ondpXTm209AB91WpIM1DAkc/SKxXJ3Du3HYnZ7Y
	7eeptWFZpnLIObY5SfivJz1FhHXcKVi3GHVKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761897046; x=
	1761983446; bh=SMtMJt9229H5PjTDv6S5YGs3DXegSlRLe7j1ltiWon0=; b=j
	Cj8OVxd1qClL8je34LdIaiNeVR74mLhSNue1Vdv7RDWAt2tRL81dzEbIZKiEQ5aw
	z71FFci3hY+oWohmd6H2cLSXRH2nbzFLj52wNbUpJg/H3gRM6w3U133cDxAcUZW0
	m0F7+Bmb/BgHESK3M1zVRxiWT1jKJHDFqhBGcGuTJfCEfJqoP/m3arxOUaQYJepS
	wxfnxyFHAuHwjqJ3oy5i782/Ve5fJnItjYkD0BXqtbRl317bdeTDiXNSCO3//vYZ
	TxT307a/ZQe1UX9kte4zq0Pda7akUljwF9STLloxvQTEUVuHFzN6PHmEgdEZVixn
	n74Lj1piIj90OhJXb405g==
X-ME-Sender: <xms:VWoEaZc-EVrGLSTj6lpolqjshjtG6sQ6diIq-D_qg8wNJvcK8jxdcA>
    <xme:VWoEaSAkVliCLoSx0OI0T-xKP6XGuBUgJ8uRfOhiVJiuq5jdjzFnfddpPJUFmmCYK
    A0rBNOqQN8k7A7iiFLX-fNHW7R19PIwfC2l2tl0VDPXJHUOK4wgjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftfihrghn
    ucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecuggftrf
    grthhtvghrnhepjefhueekjeejgfduvdffheevveejhfdtuddthfduuddvveefjeffgfdv
    leefuefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprhihrghnsehtvghsthhtohgrshhtrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigvnhhssegtshhivgdrohhrghdprhgtph
    htthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheprghirhhlihgvuges
    ghhmrghilhdrtghomhdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhk
    thhophdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhish
    htshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhsuhhngihi
    sehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:VWoEadQZHgRdyPiy2BkK6XNrlf-V3We4qlYVrQYbWcgbycQzDPe3iQ>
    <xmx:VWoEaTfDH4HDoLDN7Y9tLn4_42UlWlcvPSlHsNdWoFn8xCnqEIqzPw>
    <xmx:VWoEaWtri6bahWOI8KkZ9AHJMqqeyRswKe4Awru-zvqZibiqzejCAw>
    <xmx:VWoEafLRSJr789YZa1LVKQO3D0l4yhDVoc0oshnGtDIxTnbH5R1tfA>
    <xmx:VmoEafI-Zdjb1igu5VB4L0qBPslqvbA2_v_nmQGK38gfVU9fzUG23UFI>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CAECC40054; Fri, 31 Oct 2025 03:50:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzHZpsL-MR1k
Date: Fri, 31 Oct 2025 20:50:23 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, simona@ffwll.ch,
 "Samuel Holland" <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <64c0a4e1-15a5-4f41-9fba-852b0e83fd6f@app.fastmail.com>
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH 00/30] drm/sun4i: Refactor layer code for proper DE33 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025, at 8:23 AM, Jernej Skrabec wrote:
> Current DE33 support in sun4i-drm driver is based on my PoC code. It was
> written with *a lot* of hacks, because it was never meant to be upstreamed.
> Fortunately, DT parts were never merged which give us a chance to do it
> right.
>
> This is first of three series with proper DE33 support for H616 SoC. It's
> the longest, since it prepares terrain for new drivers in remaining series.
> Point of this work is to completely decouple mixer and layer code. Till
> DE3, mixer and layers were intimately connected. However, from DE33
> onwards, this is no longer the case. DE33 and upcoming DE35 planes are
> shared comodity between all mixers and can be assigned in any way driver
> (or user) prefers. This requires planes code to be completely independent
> from mixer. The only exception is mixer clock frequency which is used in
> VI scaler, but in that case mixer pointer is obtained through currently
> assigned CRTC.
>
> Second series will introduce separate driver for DE33 planes and adjust
> mixer code to new DT bindings. Third series will introduce TCON(-TOP)
> adjustments, HDMI PHY and finally, DT updates for several boards.
>
> Current WIP code for remaining two series can be found at [1]. Code has
> been tested on Tanix TX6, which has DE3, for any regressions and on Myir
> MYD-YT507H board [2], which has DE33, with HDMI and LVDS panel outputs
> running simultaneously and independently. This confirms that plane code
> is properly decoupled.
>
> Please review.

Thanks Jernej, can confirm that this patch series, when overlaid with the remaining out-of-tree patches and my previous LCD DT patch series, allows simultaneous HDMI and LCD output with separate framebuffers on the Anbernic RG35XX series of devices with the Allwinner H700.

> Best regards,
> Jernej
>

Tested-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan

