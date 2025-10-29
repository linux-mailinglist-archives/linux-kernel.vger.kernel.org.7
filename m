Return-Path: <linux-kernel+bounces-876230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B014DC1ADD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A44E34F1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D933B6F9;
	Wed, 29 Oct 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DH0fqoJ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v1425Yqs"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD12874E0;
	Wed, 29 Oct 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744914; cv=none; b=PuzkLfQsRMkr0dX7STfldcwIP1b6YafuT5EZRi4BV3XB6VmkiRgZPYCqMXA15wq3KR4kZDTYBwFZT/dAra3UAkwKenVkvGAGMv+4Sw6r9IHnM8vBSVyimlojrDF4j9ZsAhEgKQp5vQFl0yRsEMPjymPLzJmz19KpormS/szbzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744914; c=relaxed/simple;
	bh=zk6u99OtGnbAQaUuV35Pxy7dNCuKsP/fJdfEn8rLNbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SeP6IF49Qq9/aJ8eTcZbpldnZFSdlHlDt6Fr7qqtz8+Frz/GFnQf6CfBCalNe7dJFMOtHEp/qJ3oGvBXV7ZCyDnaMLouwB+zT6Y1KqPupCdYE3mlSOg41mP0b5iCFVWjknSxsIyTZu+TXbZXJMca/3YRJqoALy4uaeiIAHddaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DH0fqoJ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v1425Yqs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8511AEC080F;
	Wed, 29 Oct 2025 09:35:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 09:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761744909;
	 x=1761831309; bh=LOXt9ukdE/myXtxPN27g0WsvCr/T7HGAPyXOfP8W8tw=; b=
	DH0fqoJ5K3HA9N2X714F+VSdjfUN8x6I0Yy338O0/zXvHrNjnx6dtVpN/vhvTmoF
	D+PmDG3coSa3j+ik/57On2kUJwnnTZzm19+L1VS77ee81nNiLFoWY5ELlDPl7dps
	sPWnjYTKoqCzA9O7OM56RuIwdWyGOdQIYd57OBvZhiWVxqQe+RglNmxSS/u+fAtS
	XfzgUT/VbWo7G8j8LavNv+GitBKp+k7yS4CYcY/8yZkvRHzICIRHDGCHnHZ3/8rz
	Dta2UFz1D50ymvMLAX8nRz8SQ8hdRGB033r6ScN+kfzpFU0Z2Z0e+lVY7QDJtpel
	pZ9asHO8pnp5WVJToaastg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761744909; x=
	1761831309; bh=LOXt9ukdE/myXtxPN27g0WsvCr/T7HGAPyXOfP8W8tw=; b=v
	1425Yqsk7qoEPHLQtxftO7qN2WuSsFyZkfZTNyEFrDQugn1/t1WxJQrie+5o8zFA
	2kz7hZQnPRF8G9zjMj/ixPsyaqSL/QWAPfQhphAnOt3/Fud+MjmmWPk2qYlUnws/
	+HK40ckOlZ5BZom6Y6429taSSil/YTGkoGu21z97GRg5XaEjOgRk44ZWs14du47C
	iydKfJxAv7Uw81QL2EV9RLnAumk9Rw5ED/9cNZfjH1gCbOF0ug70Ixuo5+Vu4QEB
	X7qYzRuHVQKSj7khMDo7J+nN33JqIOqqet+HU6ziN5qFdR6JVrh0HjpMItdh+6kw
	rX6mgv6C1bPIGEuOWi8rA==
X-ME-Sender: <xms:DBgCaSY0nyzSH69wt4S9SKgdeX-vyU_MkPQLwA3wjj7r9g7bqTfRCQ>
    <xme:DBgCaQMsOusvQV3Dpz0STi0OrbHQw538x24XIzc9FW-PHrEEZ-VTYNnkHUs5elnI0
    dmjBgMbx9NzpnnpV89IsccuLBb3XD5RxZN0tUuJ0ISEbdVqY4pNA2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrughhuhhrkhhumhgrrhdttdegsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthht
    ohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epmhhirhhqqdhlihhnuhigsehrvghrvgdrqhhmqhhmrdhplhdprhgtphhtthhopehkvghr
    nhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DBgCac_GRxcACcOKBLRJHk3p5ta3k2kzB7hfJWT9BqdbhyBoFOEw4w>
    <xmx:DBgCaW-kzy0T9cr2b0KRDM8Pkxc5LDqEIOeI86nZSUDI6diTxFh4bg>
    <xmx:DBgCaUSZvNJVOnJJ-XWnjGzQDrqxky0cpdXIFxP-eH1G_7xpyz44iw>
    <xmx:DBgCaSfIX_3rFJG3Y9y2FO6fxyKLiovnSlxY_qquXQCtxSc8SOwqaQ>
    <xmx:DRgCaYTEMg8szP4v9qWjhcmzKqzNCEilTzrtgCcxOXbj4dFekjY7x4t2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 82F08700063; Wed, 29 Oct 2025 09:35:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhXEKh3rk67k
Date: Wed, 29 Oct 2025 14:34:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Madhur Kumar" <madhurkumar004@gmail.com>
Cc: =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-Id: <25164f38-842b-4b35-8012-e2c548b2a4f8@app.fastmail.com>
In-Reply-To: <aQITFDPyuzjNN4GN@stanley.mountain>
References: <aQITFDPyuzjNN4GN@stanley.mountain>
Subject: Re: [PATCH next] misc: cb710: Fix a NULL vs IS_ERR() check in probe()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 14:13, Dan Carpenter wrote:
> The pcim_iomap_region() function never returns NULL, it returns error
> pointers.  Update the checking to match.
>
> Fixes: b91c13534a63 ("misc: cb710: Replace deprecated PCI functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

