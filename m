Return-Path: <linux-kernel+bounces-878409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844ACC2084D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6147C3B86A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769922D7B6;
	Thu, 30 Oct 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZJF3QgWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHSYxCoc"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1713777E;
	Thu, 30 Oct 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833485; cv=none; b=Pvna30I3L9SYk/EiZSmZeUMdEGLePGygQWYsB8uTg1G3pgMzlW7C9oEjvCbsb8IHk8L6YxjXbB/EHUSSomm81zJDJeojZNzOhEfwoc6Ja8hkGwoSLgr6Gn1sPTCPqOdKxFg4pIbMFByA/u8tVsnTbzDWRwps0MeKUpSFzhSqIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833485; c=relaxed/simple;
	bh=l4JS5lND9Jw9NGezG0B3qnDmtn6thOLysKTQHHP0lYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PqvYxCijJFIKEklX/i9vjOQfduMOI2ZOsIJu8nfkG5htW5hbm7dQZw9ZQBHMv2ChhPJ2hjiJIOQ3katg7NgY+Src4FPTJCKJFjX8LIHrqQBJ3VGaX8mZpiLzch383fxwaCRbgcFZgTqV2s7DWgXKJjj8KgTwZpMavSuNVafYkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZJF3QgWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHSYxCoc; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 678281D000B4;
	Thu, 30 Oct 2025 10:11:21 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761833481;
	 x=1761919881; bh=XADclG7x2nt5LtAAIY7ejRpRPo+LWILNnisG3WQHGeI=; b=
	ZJF3QgWza+Wiowm/Kr1j25y2aVHe3wnXFuPBpJnNpLxsr8bn0EzK9TzirIDKEl33
	Y6szaE5C03ykaOEHYJ3QKma/crhnC/eZUJES8LE6tOKTpaoxiU/ZsGS4ryD1Gnex
	9ojvwW+qp1p09qaiGXd6Fea++cXMWAQ/JOPDa7J4FWeKk1vjLUnAvKuwdaVKGXtg
	cjMaLVyxMEo+oCMK1s70mE5dsDA6HGKSd7tM0SPdDfpSAJI7OpyQYsXjq+6UDQk2
	vUjoGo4+tCBTta0Ho/mxo5uAzupJigY8/y7GmGgXqWojUeIgP/hPrL5uLS9mTAPV
	ra1bRgXoZmRYEjGS8NkA8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761833481; x=
	1761919881; bh=XADclG7x2nt5LtAAIY7ejRpRPo+LWILNnisG3WQHGeI=; b=w
	HSYxCoc2kPsvbEM9zLLwR4c2uGa3RcySEhYwRUO+5EwMJhKqkvaq9+DD5ARN8OxT
	CoIrc+/PX+ftRAizlVSpZED3yh6W/mnDqObNxL3ZyTp0FaYGVEcL6T4dDeAnZMub
	LBBakkKVQfctvtPeYelLKBXah34UlIRIVOOiiCLlalTAAs5YETtBjo8p4uqaqgym
	8VgdJVWD+ZDYjwM/BBfeCp1JZiMOLQ9CtZXceND+VzkjpNKvH7hD5FMTFyLD863S
	ELxySf32vWRS/NiM2pqHFqtVD/R1aXchYoid86TyhwamncdmaupgzRo/ZJB8KZsz
	+J+BF3VY+lsAo3192N/Rg==
X-ME-Sender: <xms:CHIDaZzMhjkEGhjPzgWKxiG98NBQj_VBpQytQEPw7SSJROsMnEhENA>
    <xme:CHIDaUEamF0PWf8H5itTDcmqoOjQK3WLb0hXp24GDbBh4Jmu2jleOXePEau6EmomS
    TQhgJshB3lSPzhq3ggPLIrBiuw-R7NiPygkNKh3wNVPjs3VD4C6Y20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjohhhnhdrmhgrughivghurdigrgessghprdhrvghnvghsrghsrd
    gtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfigvnhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvrdgurh
    grshiiihhksehlihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhht
    vghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehpvghtvghrrdhgrhhifhhfihhnse
    hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:CHIDaYZdLgOLNk1eFOYdLVGuqMvZPkq5Ivbsg2WFkqRVx2gwmCFjvw>
    <xmx:CHIDafOgfStkr7znrXCs8MWNFW7_EsjksJY5eSeSvDRrZ0W7aKsoGg>
    <xmx:CHIDaeUSbUXNgaUCYJWboUUrMS5ts3Y655NeFDF1s2kY3Cpa5GoQ8w>
    <xmx:CHIDacIGNcJqPLjGNvCoHnKqI9LYOctBjhbFoBjywEyp_67n2Bk1AA>
    <xmx:CXIDafbM5KEadsGns_0piyJIsllOjRhizvIzKzmCpLWEipz1IZeDQNfi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66607700054; Thu, 30 Oct 2025 10:11:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK9Cqudmt2dw
Date: Thu, 30 Oct 2025 15:10:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Chen-Yu Tsai" <wens@kernel.org>
Cc: "John Madieu" <john.madieu.xa@bp.renesas.com>,
 "Lee Jones" <lee@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, "Rob Herring" <robh@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>
Message-Id: <a84a68dd-8068-4e84-b0bf-f8f9230e05e8@app.fastmail.com>
In-Reply-To: <aQNjoM3fgAW6kxUz@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
 <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>
 <aQNccP-lHqgygmsu@stanley.mountain>
 <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>
 <aQNjoM3fgAW6kxUz@stanley.mountain>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 30, 2025, at 14:09, Dan Carpenter wrote:
> Yeah.  Let me send this tommorrow if no one objects.  Pretty simple
> solution in retrospect.
>
> [PATCH] mfd: syscon: Return -EPROBE_DEFER in device_node_get_regmap()
>
> These days we can register syscons with of_syscon_register_regmap() so
> if we can't find the syscon that probably means it hasn't been registered
> yet.  Return -EPROBE_DEFER so the driver will try probing again.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

This clearly needs some testing, but I like it!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

