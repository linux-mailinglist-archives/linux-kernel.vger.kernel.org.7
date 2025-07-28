Return-Path: <linux-kernel+bounces-747820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBAB138C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C63AB623
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123D25CC64;
	Mon, 28 Jul 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EGlSUO0F"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706F2586FE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697836; cv=none; b=LUIOYvlJpFWp6+kf05sbMLRA5/n4oGMd6UnR8FIKJIFidajPfnh2H4vaTjCqVWHuaqi5/qpNC9Cv3co1R74RB0nqzIttfzE4NgRCuw4qhkr/KM0kDkgLGggasSo4Lq0EF+sRh4pQVCx7zmuMalcS5FDgAyEvH0h2abSV1Td8u4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697836; c=relaxed/simple;
	bh=Sp4zwLWH4i0VQu0uO0muhp4dnn0al9+9chRimBps068=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/auaunIgjN1ijXEiODjoT1zuMZxTRKXp5xUOao2vOcJ06lpEYnDyvARCIeXduW2My+zV5gLxKifkVg7XTOJCuSceOzLEG5shxQkkQN8eFowM9BlISrXVWlvjQRd1dmU0QIsdDQnz7BJMTfIWK1dJ/DJSRbRWgrs/zM20LGBuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EGlSUO0F; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7860343252;
	Mon, 28 Jul 2025 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIdf1rusMM2utxFOgdWZXg7UVjylZoesGKXTK2HALPM=;
	b=EGlSUO0FLvU4g/5I6IeveWOzyL7GdC+2HBdNmoMfaq837fyt4Zz7PrADj/lZpgepqZA6Ws
	E4DSNtypYSEhe5Q0Plz2zQSFqvl12uYdpnuPaGFXnQmI/dbo1SuZs+CS26WhD4fWde3u87
	TMsd8s0Pt4D92eJc+vJpIh8UQsbzA9/Q59I6v155gT7eWpWjVS+UHEqaNmcCI1NxsZLdj1
	mbJrwvYB5lpmTpSS0CfnY2PVx1IRV+TdTRdY35icVp6dmNw/fyBWXrCApnWSqXWlpvz5+W
	SUA4+M/Rv14nYkmE8qGSffzDoVnG2lU/mXanZdZSNxdoXI8iBB28NicjBL9FSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: bbrezillon@kernel.org, Hector Palacios <hector.palacios@digi.com>
Cc: korotkov.maxim.s@gmail.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250704094109.3646314-1-hector.palacios@digi.com>
References: <20250704094109.3646314-1-hector.palacios@digi.com>
Subject: Re: [PATCH] mtd: rawnand: hynix: don't try read-retry on SLC NANDs
Message-Id: <175369782644.102528.12960625311289516996.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:06 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegssghrvgiiihhllhhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhorhhothhkohhvrdhmrgigihhmrdhssehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgvtghtohhrrdhprghlrggtihhoshesughighhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 04 Jul 2025 11:41:09 +0200, Hector Palacios wrote:
> Some SLC NANDs like H27U4G8F2D expose a valid JEDEC ID yet they don't
> support the read-retry mechanism, and fail.
> Since SLC NANDs don't require read-retry, continue only if the bits per
> cell is bigger than 1.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: hynix: don't try read-retry on SLC NANDs
      commit: 7f21229fcc35dbdd6ff866bcd68661cc28080a47

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


