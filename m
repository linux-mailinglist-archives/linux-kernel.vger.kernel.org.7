Return-Path: <linux-kernel+bounces-747824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41BB138CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAD03B581B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D5259CBB;
	Mon, 28 Jul 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZEn4oMM7"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C2259498
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697911; cv=none; b=AvjXgnq7N9wbqyz08nI/Qvw3IF/UdePPGeT0kQC+51XzFrF+arJkn5cqwEMHOwUbwGWRPKm4106V2nkloiN3lkm4D/Q/LHvAKhVDvxQ3193qDstKGA9fb9Qkd1ozB9W5s6cwcXssWwIlWsnFekxk+dtmAVJxpwDdVk2LAbWP3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697911; c=relaxed/simple;
	bh=3el5hihMWzNALKB9/lgWX1J6i8LyhqKA9nJQX9WOFn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FdZcNvWAsSolVC654snJyCOJKy2pzN9qxygVs5+61sieD0GhrUTYNjkWcDd9HiCyjqKBVdG+kZJM1e/6dFpvZ0EDf9MWEAR0Rpu7zP5WaReU+KHMque6wG/n2njDe8rvUIjlxsp6gYnwfUuugEdy6vJraIGgT12K1Cc3Gtm45zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZEn4oMM7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99ECF43207;
	Mon, 28 Jul 2025 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4wkqLxHY+RoBc1uK2vAFB86qGeFPMMdWw1AN5D2+K0=;
	b=ZEn4oMM7Iv+ycDpPwVaonXt85rgzoSjZ3I5sxVaIISnN+aNRaHgQ2RgjwEfygtEEMBjQeX
	tZWcfVDq0qj7kHjM3K7sIuTQkDxwtxsE4dRCcAyAF4XfZKXXN1H7BKKVOAA8PvlUU/aghT
	WFZup0ZtoX+xiXBCaiLnUsuQlY/n2/QWwoLeboPzAaafcyo88/yG5pyXTK7xvOzalf+bbk
	J5IrnLChtCJOJl4/mcdt5EAxBzmIXE2/MgvpSUpv5Jad7IsKXI2Mmu1Glelo7yHSCxPdkF
	wJy3E8A9bvdVgcrJ2KbtE6YORE7d2A9J8dE1mNQFfJMkD+pzgG1F8uXpRM2UnA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20250626160812.325940-1-andriy.shevchenko@linux.intel.com>
References: <20250626160812.325940-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] mtd: map: Don't use "proxy" headers
Message-Id: <175369790143.102852.15567348497821292698.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:18:21 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehli
 hhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 26 Jun 2025 19:08:12 +0300, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Note that kernel.h is discouraged to be included as it's written
> at the top of that file.
> 
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: map: Don't use "proxy" headers
      commit: 56eb7c13b97c6f9e2fed9e9899b01d1a6a595f28

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


