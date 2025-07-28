Return-Path: <linux-kernel+bounces-747813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F0B138BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C016818909B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885B256C70;
	Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WkAdMxsk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740F21A95D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697833; cv=none; b=SSmH+uTX6DMZSlI3Yk6yjCBkX8QmhaTz1I/7qn788emZMwjVmpGIqmv1Pu7z5aqCC3WG4Ad3xwEmsl1s98MPv6HFO+5lfzOVaNpmd02Q5NGR0DUEjECEMsZfQHTrREy77EkiqiK4dD9+XtXoRrw0TnTF4md2m0YeCJpUYHg+2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697833; c=relaxed/simple;
	bh=ijpeffJKXZ9ovGHA6Sfbwh0oVnNjq8OpON6NrTa4VG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kPzD2B82xu952t8KKhgV9LDsDPMFEtxIqgFsGJ7msHwU1a1lTgaSS4msOnCmnAZKjw+DKEYvq9Gl6JPevnuMf2kUh2DSgCh4gZEsQgPPEE+M3DFm/1ojZpmefVn4S+H4jQmDy5sGWqxGjvOIwM0X7Jx6v5ZVl5+GKPlG61nLVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WkAdMxsk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81BB643210;
	Mon, 28 Jul 2025 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6TPmirTYIktwxRKxnrYUmhptFTRZmeACOdvV8UNk4Y=;
	b=WkAdMxskiHHZ9qvPIIAl6RvLyzX0LBS3aXgj+A6Wwup/bVUSbZNDHqfonn6j1/6ufo4vlA
	lG7czmoqk4H0Zuuh1XvMdjrS3Z5xcEH6Q8JeqvEHsc3S+80LBFYIl2z68OlrBZ1pVM/10b
	vx//0oNgq6BI/19Bp1YZGZynZPuJikpAf6ZMtkmC34H8rSYl1+HdLsxnumoSiAGCxykrk7
	Agin4Nh+a2Y3i3C9rd1kwf03sD6ziDBUIg+5eczAB/37QJR7ptp1o+PQzXGSC8HQISORCF
	X8Mk4EiYpjX92AE80fFE5Bp34qjPJX4yfBDMKEFMnvMKvbDOGDsGhd6uD3KMaQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, gigadevice2025@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630034931.7962-1-gigadevice2025@gmail.com>
References: <20250630034931.7962-1-gigadevice2025@gmail.com>
Subject: Re: [PATCH] mtd:spinand:gigadevice:Add support for GD5F1GM9 chips
Message-Id: <175369782348.102528.16697706993689245449.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:03 +0200
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehgihhgrgguvghvihgtvgdvtddvheesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 30 Jun 2025 11:49:31 +0800, gigadevice2025@gmail.com wrote:
> - GD5F1GM9UExxG (ID:c89101 3.3V)
> - GD5F1GM9RExxG (ID:c88101 1.8V)
> 
> Both device feature:
>   - 1Gb density (1024 blocks)
>   - 2048-byte page size with 128-byte OOB
>   - 8-bit ECC requirement per 512 bytes
>   - Quad I/O Read support (opcode EBH)
>   - tPROG ≤ 300us typical page program time
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd:spinand:gigadevice:Add support for GD5F1GM9 chips
      (no commit info)

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


