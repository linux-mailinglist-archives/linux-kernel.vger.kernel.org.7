Return-Path: <linux-kernel+bounces-831205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE37B9BD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EF0188FCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D122327A3C;
	Wed, 24 Sep 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cpocQpIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXUXa+Ia"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC62153E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745195; cv=none; b=AagJrmjqqdn+yQzQ9lcvAEs/nSuCRHA3VhjirZnX8sUvBJAvP9Vp3QwIGaGXbP8/5DFYLaLj/38xwITIeB8nDjV5swlV6hM1t4oLPKp3JKQ2h8ybv/Py8GEeLxknXIlBwJ4E5mz8n+UAxc7qDDFMEin0RLoh+UkzHbXRJSf/rhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745195; c=relaxed/simple;
	bh=anqkefCNMWyPcnqMK6cJcJvYpV7ovYdZub/cUscZBrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X3r9HSsY3QdnTg2A0rBRENPFkM+jt+VcO9O3HnbupYrSNZPSrIHunktxjhA0JGWF4oX6W0NO1dJQKzBit1LFmlk9yLEY5+2KJlwDlk0HlIH54YIJJvFJe5Ss/dSPKr7nVgUcxnHiLCgGlrteCP9YotQOPorXyShGWabTU3bRIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cpocQpIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXUXa+Ia; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FF64EC01A7;
	Wed, 24 Sep 2025 16:19:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 16:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758745192;
	 x=1758831592; bh=m8FTw+V0SHUIhk9QAZOvCPg7GbCZfkE73XxcAK3HRvw=; b=
	cpocQpIwrcUOSlbCkz3Q6P4cmFbBy9OnxrQXVU8fZy+1ag0e1MIMW43vie+IR1Zv
	znhl3qHeXeGy9K5o4xFNx+W6JZvpXyB5Su/WlnBir9I/aOsqEtdXlki2BbXuF1Mp
	YgkZeJtwNEJ4rGl71vQCCNbz0IDYedx0gePQ+tU/xw0VKki7KGkVZeVogtZQkWeX
	lQIDxdRg7ubzrjcNgGGFk0GvV6CIUv+nkoJPz+8zF85nj7plDqpHiOK/x1EUpOL4
	GlqbwC91kFEHHw4gn5dNtWRHxAcV152fZR0RE7Psv48OqB6vZZvZu2G38E4faaDJ
	H24r4DweenAGf38wDvMNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758745192; x=
	1758831592; bh=m8FTw+V0SHUIhk9QAZOvCPg7GbCZfkE73XxcAK3HRvw=; b=n
	XUXa+IalwlRDv8bv0wOI4v/Fgwz2XA+iow02LdhRhbDR+nWa6bo4P9gT60eCu1Fz
	bVZLSaLxouQ4//NuH+PgQQbnXSvKHA1yzjPKLIUqYqv4zIyxUEdEWYSbmNKpj8pB
	zBALQJw0MDV3WM4QuOZAD4MEVbfq8IR4jki0OnNisMEx59iTm5jDCOqiR9KAkmMs
	ZbHYLoIO52RQsn/WZr9QMnzhL6cylW/QZ409E0WjM7D/eg5ZbsH3tVGDd0I9bpZ4
	lr2Mx87wtyXelnpFaXZOYfYn9mm7iq5WU2yiXoXZDMpAV1o3wd0qATu83U9ZogHZ
	CG4IBhzs4vhiWz57Edhlg==
X-ME-Sender: <xms:Z1LUaHgVnEyQdPi9R-0v9y9rP8Pjv_a0NpPhW9AfA6BXPqh_pG7zrQ>
    <xme:Z1LUaO3H7Y-fL1iXX_Hm2TfZ0O7R3Py-xVFv3J67JfwQz2MH3zE3SKQxH46UkW_Gk
    fPbFz-pGwwKueH1MLfYLDGTBTYXgJWucMfdJPUUZwsS5aBllpIAlU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehmrghnihhkrghnthgrrdhguhhnthhuphgrlhhlihesrghmugdrtghomh
    dprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomhdprhgt
    phhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpd
    hrtghpthhtohepghgrshhtmhgrihgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegr
    rhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqiheftgeslhhish
    htshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehfrhgrnhhkrdhlihesnhig
    phdrtghomhdprhgtphhtthhopeifshgrodhrvghnvghsrghssehsrghnghdqvghnghhinh
    gvvghrihhnghdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z1LUaAxNFHMOREkqCmAiqLK0kVFUXn7NEDSl03-6lt2zPVP7A1luNw>
    <xmx:Z1LUaEtMj706rlCTvQJXFZfdVdVaCHO1KvcxBy6q3QecJC05INzl7A>
    <xmx:Z1LUaDDauZxDXUOkgzFsdGu2IXAnv2kUn_c4HJenpYX9mVvlpqxGyQ>
    <xmx:Z1LUaGHtNPGtn62llmgvJ099ab7pgUzs4YhNbfXSdrVrvOi0vFFfag>
    <xmx:aFLUaFfT1aUE0B7TavoJicZNHn_2752eUGLhE1ShqnCFQeIe_os41zoN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88C5E700065; Wed, 24 Sep 2025 16:19:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AywbbuUSWNC3
Date: Wed, 24 Sep 2025 22:19:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jorge Marques" <gastmaier@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Jorge Marques" <jorge.marques@analog.com>, "Frank Li" <Frank.Li@nxp.com>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 linux-kernel@vger.kernel.org
Message-Id: <d86da0ed-8293-4356-bc73-98492d08ee8c@app.fastmail.com>
In-Reply-To: 
 <ikwkapgsfntog67hwi2aapdadlq2wy7oydjz6i75gbhgxxd6fc@3e3lxh7xkgy6>
References: <20250924150303.3601429-1-arnd@kernel.org>
 <ikwkapgsfntog67hwi2aapdadlq2wy7oydjz6i75gbhgxxd6fc@3e3lxh7xkgy6>
Subject: Re: [PATCH] i3c: fix big-endian FIFO transfers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 19:01, Jorge Marques wrote:
> On Wed, Sep 24, 2025 at 05:02:53PM +0200, Arnd Bergmann wrote:
> Can you fix, as Nuno pointed, to:
>
>    		writesl(addr, &tmp, 1);
>
> as in the original drivers, and adding this information to the cover for
> further clarification.

Sent v2 now with those two changes.

      Arnd

