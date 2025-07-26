Return-Path: <linux-kernel+bounces-746691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFBB12A17
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787991665F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5423C8A0;
	Sat, 26 Jul 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xfzysom2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mx03dr3u"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31C23BD06
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753526067; cv=none; b=IVs+L2Rm/tQ4GOd42OdNXaZFz4ywQFiRlMQ+0zlcFwKNeCP60HRmsosaLLTokTnb/kcTVuq6LpuzsRuWtc8MXGMK0Y8XN4TbsYTxCiygGUdzqNi/cSLG2AtouwVMr7sb8YXfPA/LvsSasGJ6nrUGWcWMo0ep1HUlz5WhCDaoogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753526067; c=relaxed/simple;
	bh=HbnXIdFQ1qdPs72J/fcRpqxCeU3VxMid1h+x6KbLNGI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=guU7qBbBLBaK5XGa/w0qc3uJc4Tf0oxS+THxg7qoFrlSV5j2TbZu+WINWgD51iwp9rDyh4yC3FKY1yvp1TFeJeLXiQS1HJfEd4pQGUg6YkNepJkka68m8pkVKOkYJYJP02vH4+yyY7s50+aBmm/68qenwNS14wvkWNKrUhkulWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xfzysom2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mx03dr3u; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CF0014001E4;
	Sat, 26 Jul 2025 06:34:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753526065;
	 x=1753612465; bh=KLI+bwgAyYHVhyi87lwVwQoEjhWitZId0wvrbdQW7/s=; b=
	Xfzysom26R2RjyJrrIW92okcrl2+vzW9m0tBjhhDAvvD4rEl1N8bcVdROz5KpEQz
	WAi2RrM2aRT85kDROYIG3Q0SLxDzRhX36CnYfMEVfnHzUAvFMo2VxwJXQgvt3xUj
	WXg/45NYPIDGczaWAwI7QtXvfYoe02SD/T0RGJI4q3/OJMgJYAjZCoJ12CtuJ0+v
	neVpmUmz8ChIk4UEL+72sXXihfl9igPcsOZODYbXGAGVxOgOwitQQzP8THTN0vLV
	KiMqKw1DBR/ZTC7XdT6CIsK5qtBT77IL7albR78O+aVvtuV5bMc3vReZw6yVqJYh
	ky1Q9hbhqArLZ9peYDP30w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753526065; x=
	1753612465; bh=KLI+bwgAyYHVhyi87lwVwQoEjhWitZId0wvrbdQW7/s=; b=m
	x03dr3uTx5r+GnddzjZCzbHSy0Gm6lGiEMIQXr+MvCLUtUsm6ME2drf/yDHa6NHm
	zVnCT0JFpAU7fM87WwF17fL4IovU2fJqkFF5P8qKfnbIk8gaNBtf45cfVEFowcQP
	vMor86izYByV8pQmuoAP5juDsNC0vLrUeT2EyNj/UJsU9GWsrwqVcGZ8qvs2uqos
	/SrfmnuVxMBJD+RUfsT6PMg+2rwU1aVl8DgVZIC6B6CP0+cYW64+BoWk+U0gzK6w
	Q/BNz5N1H+qxCGt/YJ3hthbO8N5RDymisMsTL6qfcNBn0oRj2pMaWptKgz/+Hn2V
	uWDSz1PIr0TJ3M5sS8llw==
X-ME-Sender: <xms:Ma-EaPpN-lIJuF-oNg8egt7lr7-ypen3shPYycjMWceQboN_mFm4vw>
    <xme:Ma-EaJrrDy0G51qEb3Hl8zZd9CmeNv0GsBqSxOk7H2F8vBL5k2me16f3p5rTTndyr
    TG7xzdssgjFf80d09Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ma-EaDrtn148dgbNIN-Fc3r4_fu1Yqz5-kO5lFBYQEfL4FygR9pxIw>
    <xmx:Ma-EaJKwxJl0UOy94DctHqxasSgEXuZkSLcrJflBVS_Jj34LjoqGsg>
    <xmx:Ma-EaGqEmxcTI0mIV3kUZtWcFy5MxismkOUa27AJgGsCkrBhn0d4Ew>
    <xmx:Ma-EaBxa_PjZSkYA2QjULikhUEiFDSAe8qzg162hoYj3TUG3v4ki0Q>
    <xmx:Ma-EaMxiZcLc_iMiL3M2pZGNE4WXy0Hk_ic2VJGYzIxGdBLC5r-Jymob>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E014E700068; Sat, 26 Jul 2025 06:34:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf28ea043109521c0
Date: Sat, 26 Jul 2025 12:34:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Message-Id: <4dcacf2f-90b2-4f24-9f72-91707b77b9dd@app.fastmail.com>
In-Reply-To: <66ad07fe-3aa5-496c-8c5b-1b7ed18eb056@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
 <66ad07fe-3aa5-496c-8c5b-1b7ed18eb056@app.fastmail.com>
Subject: Re: [GIT PULL 0/5] soc: new SoC support for 6.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jul 26, 2025, at 12:31, Arnd Bergmann wrote:
> The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:
>
>   Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git 
> tags/soc-newsoc-6.17

This should have been [GIT PULL 3/5] of course. The order between
the five branches does not matter this time though.

    Arnd

