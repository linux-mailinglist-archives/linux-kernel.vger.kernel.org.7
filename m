Return-Path: <linux-kernel+bounces-747821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C23B138C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D45E16D1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827AE2620E4;
	Mon, 28 Jul 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMrEeugy"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E425A2CD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697836; cv=none; b=SPvr943a1mbaBz3oY8cbXz3AZa3838eqxIcuvEXmTo9P2yzq1BmGK3P628m2YXkrqOdI48nwke6UqzRvnCLVAr11VNZoH4K7CEhc91wsVGcp34YeiJDVlSNDTr9QwjoG/tVBoItfCPG/dT8I5BlImZRRnjnmPYClbyHqP7mbc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697836; c=relaxed/simple;
	bh=SuW6Jkq4v3NgwKUo5wA4c82RPnlF5A5rHXkcqf+BYbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HILR7rrxdep0dYv7dsHZrL8ruaGTmfVtofUlWWjYQp5x6RxHZbXnceNE07b6x6WiX1W6R55jkOunJy9R3xqreHyAl3IgBQVBh8/pZEz6Jo6yOUlNFziold3IpAl/LF51U1lvVqVEfhItKVANMx6J6KH2kBQg/auTtPAHXhnVcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMrEeugy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA56143292;
	Mon, 28 Jul 2025 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke/PcRqDTW/FMp/3ob8XCd3S2uQ0KPzfCYd8FTbMaV8=;
	b=DMrEeugyTNMXGKe1CzbreCKWjokenAc8UxJeIvfsxDVtEzNl5HnTdUD/B1HSBTdFQbfjPx
	P54fmXSzxO9JNTSKsmBchXcE2W1TKHalp8XfoIdmP1VDl3p1xjT3LnC530DFefdYihPyxY
	IQa2PJ7mH72uV6k2I7cjE5zjT6gXQlv4UexV94XQmbHuatogHWUtssVcsXMDCIo60ye4wZ
	XPd4RuBLGVIOofanoAO+aajL+GCpNFnwbOQjPFg1Xdn45yBBgiD4QrtAu/NR8sN02G8Pfa
	zXHcfOvGH+JuHOMZW5uvrKBz6fw2DA6M+0tPwdXSwu3zHjgwHB0/rn+oJATrXA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707071555.17704-2-fourier.thomas@gmail.com>
References: <20250707071555.17704-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: rockchip: Add missing check after DMA
 map
Message-Id: <175369782677.102528.4677825344596689403.b4-ty@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhurghnjhhinhhjihgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtoheplhhinhhug
 idqrhhotghktghhihhpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohephihifhgvnhhgrdiihhgrohesrhhotghkqdgthhhiphhsrdgtohhmpdhrtghpthhtohepfhhouhhrihgvrhdrthhhohhmrghssehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 07 Jul 2025 09:15:50 +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: rockchip: Add missing check after DMA map
      commit: fd277532a84f4c9d9129a87e73dde6a6d9f34200

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


