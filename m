Return-Path: <linux-kernel+bounces-750329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC457B15A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35683A8139
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A193292B2B;
	Wed, 30 Jul 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z8CNQMtX"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05424290BCC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862396; cv=none; b=pe6HTq7jG3aqw2nLs3cdSlRI7zp34jiqiXHgJ3lApNJJGwL2adQ2x+1xCmEQcE9P/sqGGKusV0AJkOZe/1OWUuN1r2McIOEgTNrsWmspRhWHg8LXeQQ7ukBBfFQgI++E5zC6NSmRRcrVIzhkM0qPsuXtewefXliiJt53oR3dt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862396; c=relaxed/simple;
	bh=sWLJzoxGMyk+AMMLTL6p1dcK8qNXJLvsTF7DGbZkpKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c3xpQYCJQKaH8AdGwl86D83zLPetnaWGSm9OTyFvyCSHe5Zz4EXL6WCnD3do8IUWfatmMklLeMo0/lJdauxraD7t+bvUwjRjtcsuzmLFaOloVjT0cMHX5U98NW5s9WTkKnPszUPepAYwJXtN1wpGDhtdLa/xGqt/dgYygN4FAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z8CNQMtX; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3B1D442DE;
	Wed, 30 Jul 2025 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753862385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWLJzoxGMyk+AMMLTL6p1dcK8qNXJLvsTF7DGbZkpKE=;
	b=Z8CNQMtXjH+12nd0PlDVNAXtyanqvVF+Y9slHedmqRJtgi7Lx50e15UAzrNksfoIC7aCdY
	m8JB64gICFyHYeHakRCbTpH3mqkmPKXt77u1pf1AczS6mPx5CjA4sJZkRr+FtLVAogtRm8
	FXgSWVjwfMsoreG86RqcLAZkOr2Ub9KSJdN/3mdaVUT1QX7yVb6HSyYBcOr8oe8e4tbitG
	Llz21TLJZJwBH8f7GH7o2sIFEGZuXjUXY1lLuJfcZZITlHu86+WRDKQmBiSk1GpKCNXzwD
	/moooGGtEtYjiUIl9J4Hr0cvJHrOcyUTD58yIJ5dIP1wjone6W9XgIqjFdn2WQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: frank.li@nxp.com,  alexandre.belloni@bootlin.com,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  tomer.maimon@nuvoton.com,  kwliu@nuvoton.com,  yschu@nuvoton.com
Subject: Re: [PATCH v3] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
In-Reply-To: <20250730003719.1825593-1-yschu@nuvoton.com> (Stanley Chu's
	message of "Wed, 30 Jul 2025 08:37:19 +0800")
References: <20250730003719.1825593-1-yschu@nuvoton.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 30 Jul 2025 09:59:43 +0200
Message-ID: <87tt2unm6o.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepshhtrghnlhgvhidrtghhuhihshesghhmrghilhdrtghomhdprhgtphhtthhopehfrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehtohhmvghrrdhmrghimhhonhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopehkfihlihhusehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohephihstghhuhesnhhuvhhothhonhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Stanley,

On 30/07/2025 at 08:37:19 +08, Stanley Chu <stanley.chuys@gmail.com> wrote:

> From: Stanley Chu <yschu@nuvoton.com>
>
> In a private write transfer, the driver pre-fills the FIFO to work around
> the FIFO_EMPTY quirk. However, if an IBIWON event occurs, the hardware
> emits a NACK and the driver initiates a retry. During the retry, driver
> attempts to pre-fill the FIFO again if there is remaining data, but since
> the FIFO is already full, this leads to data loss.
>
> Check available space in FIFO to prevent overflow.
>
> Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")

Still missing Cc: stable here

> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

Thanks,
Miqu=C3=A8l

