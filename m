Return-Path: <linux-kernel+bounces-604632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F9A896C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA029189D9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512F289376;
	Tue, 15 Apr 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fcgLEDHo"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F22289356
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705890; cv=none; b=qTza51mod/6ZXeYv5t+149mkfgt/bphcCMFI4HTLet8qDUGVzXifm7qmVHORXT3vPRA6tVweF+dYVZfNaRWjQgxjFtdsSbwan2d1Bf476eX2kt7z044SrzrhNMdh/Iz4iI2FR/ELNO8YrU7rhNv4E+Am/KrmMUlbdjqRcUQNGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705890; c=relaxed/simple;
	bh=zApQ/h/ifXVpaxbQ0Lq2U9+GzIOiFfhFE17Y6vm24kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mh/RnjkUa4t4qeX4nbv7kPWEp7/qmZdILaS0YPtnkZ5tPA4E2/YDq9idEsZyUlTlPtO5d+EVOEJ99WNkQwxHunGM5JhBMRWDJC+KX03v+DyjQDG9IX8UiO3Jlt5IPlaeP6i4W8aiOX4ypsrY64gLqRd/f70+u8rbmKtvxt/S+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fcgLEDHo; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9315D4316E;
	Tue, 15 Apr 2025 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744705881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zApQ/h/ifXVpaxbQ0Lq2U9+GzIOiFfhFE17Y6vm24kw=;
	b=fcgLEDHowr4rpUgyD/yam9KVG6ynlVv7xA+0IJuxrxHJBrzuTZt71kxGIn8F6nk9YPIsTr
	dF0Fr6iFRnh+Sn7ywcteVU1GTDjsT5LFcGPUrce8jFOdzYNBMRffSyIIQqgfhGQF6c+Y+9
	g4Qx+azXtxoEMi6601iP3vlyXo5rRYJ1xMMYCNLnCTR5JmNak7hZsukzfNQCWsGkc+DU9l
	Z+D86z8m69OlgOZ2bcYdwiNNpUh29qGc095luhhuIDgNAAUPBb5AXnFqMJKthZihQtQ9Iy
	MffuEjEDqM0wdzAiHuiaEUQezqCHabHKscYDALxXZ+2Icm8Nxghq3cttqkMj0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: frank.li@nxp.com,  alexandre.belloni@bootlin.com,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  tomer.maimon@nuvoton.com,  kwliu@nuvoton.com,  yschu@nuvoton.com
Subject: Re: [PATCH v1 0/2] svc-i3c-master: Reduce IBI transaction time
In-Reply-To: <20250415051808.88091-1-yschu@nuvoton.com> (Stanley Chu's message
	of "Tue, 15 Apr 2025 13:18:06 +0800")
References: <20250415051808.88091-1-yschu@nuvoton.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 15 Apr 2025 10:31:18 +0200
Message-ID: <87ikn5ygfd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeftdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeelvddrudekgedruddtkedrvdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrvdeftddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehsthgrnhhlvgihrdgthhhuhihssehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepthhomhgvrhdrmhgrihhmohhnsehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohepkhiflhhiuhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopeihshgthhhusehnuhhvohhtohhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/04/2025 at 13:18:06 +08, Stanley Chu <stanley.chuys@gmail.com> wrote:

> This patchset reduces the IBI transaction time by the following
> improvements.
> 1. Receive the request in interrupt context.

I initially had a few concerns about that, especially since the wait
periods were bounded to 1s, but actually we are already in the irqsave
situation when running this code, so your series might not have
such a huge system-wide performance impact in the end.

> 2. Emit the STOP as soon as possible.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

