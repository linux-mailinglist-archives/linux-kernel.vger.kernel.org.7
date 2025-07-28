Return-Path: <linux-kernel+bounces-747812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029EB138B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619C03AA9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE992550CD;
	Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JchHN/qW"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C01F4CBC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697832; cv=none; b=oGqnF+A9eGYkHRLEsmffh60tjtRQ00OxQeHsTL0eLVmE3gcc9GUjnaX06FAL6nAuB/ElxXl3Ox+mL2rZLW4W5OJQptCTJcdZ1A4pWl7UuZfV+QGWtFfbOXgokdqAR7GGUU1vwZzX3RQm4nRyiwRvu2f3OoXu2gFrm5nt112A2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697832; c=relaxed/simple;
	bh=3nV8mLP3NNYs9kvzfrlopmizpX++PEt/5F9LiQyO1zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QWyWAI/WZBbwRMlU1rB6P2o0soWkj8YLU6FpByWTDoJP0AKixZSVcdp4CXfjiAZNXyI7psSXrf+Nv+5jDo9oOPAA5rpxmSF6b1/IdOSMiMkcis5veRsgPKDib+cLqtqEeZEweuYcXXtUYONOmgw3QrzsAZaNPdKsWmNYKR09Zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JchHN/qW; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0240431EE;
	Mon, 28 Jul 2025 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pg1s39hr7gfRoFJ2EYpnz4xFGDCFEkvrgRZa3+yLCA=;
	b=JchHN/qW2Y0ACMeZGRRlqpWF8Tuagy7WEwsi1sy7ZbAc38S7q2aHe4RF1yRjfOu4SqFOo7
	7bfdxZPP+8v5LbjDg34ahxofq6N6SBNnlq7PkQE9xIspJeSc/7MTc7wrabdmuosPR577iZ
	7fgJQK6mqS5uprgX/743zuaOhFxDEvW992Wj/PwP99xUUVnBsvlfidvXFD4taiVvulgO5W
	FWYEvK9dUCwHiGrgRn/9EhkdAmPo4zZ3Jc0YBC7Dv+mMGTudaCt2jJNGJlBXC4EMPO5uh0
	H3NwjCYfBhC2wh9gi/JBcz+lyeCsuEKdnXqhvDTQ4uZht5TaKO+t8uqoNQ766g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250626-qpic_common-unused-defines-v1-1-e31c9e2074c8@gmail.com>
References: <20250626-qpic_common-unused-defines-v1-1-e31c9e2074c8@gmail.com>
Subject: Re: [PATCH] mtd: nand: qpic-common: remove a bunch of unused
 defines
Message-Id: <175369782264.102528.9311179617675976585.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehjgehgkeihjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 26 Jun 2025 17:52:39 +0200, Gabor Juhos wrote:
> A bunch of definitions in the 'nand-qpic-common.h' header became
> unused after the conversion of the 'qcom_nandc' and 'spi-qpic-snand'
> drivers to use the FIELD_PREP() macro, so remove those.
> 
> No functional changes.
> 
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: qpic-common: remove a bunch of unused defines
      commit: 8e37aaf971537f5a428d2e90b0832ddcee2b675f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


