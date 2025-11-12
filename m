Return-Path: <linux-kernel+bounces-897263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C54C526D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0FC4E214D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B0329E61;
	Wed, 12 Nov 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kUSxogkl"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8131196C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953048; cv=none; b=au6GbzhnCWy2Q+AepGAcca+4xHTREiwou3qWcLwVJKA/k1Nte+bgjntfRO0qwVRfMozW2h/GxnZ0ZoLQKJX/3jBMxyfXNHb+XGx/JSn4BeX++kAd81cdyRxpmDrAJ1DLbcSNHplk5AM431nx2RN5SShzn2zP6WKMuhqncsLQb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953048; c=relaxed/simple;
	bh=2dGXt8VoW5CaG4YtnVqdqfl+eXlHLYQG2Tc1OSwxsg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKjAEBu7U2juwd7UWdsIgDCJBKmpUsKDVSo4mHsHAlBR+tZIyoPDRC2a7bu1E1OaZNSNiaZQwBZe462LAUgJWZD8USrwssb8m/Kx46db4KYF6VNcL4Znc5Ypq2bgvLooHrQzNZC0yAoeeBvihUmYwx0w9M3+9e9LA/II1CNIQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kUSxogkl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 284F74E4163B;
	Wed, 12 Nov 2025 13:10:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E40A36070B;
	Wed, 12 Nov 2025 13:10:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D8E1102F16E2;
	Wed, 12 Nov 2025 14:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762953044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8FxSJ1YhSz/uKUxjGqRnSA5I1+h/hTb/Q5Ve6fg5lws=;
	b=kUSxogklGuF/0uxGORVdT5LTnPw+kZ0d587IfLv40DmGK4Z+lBtSNKY2kGsYL7NAZNn9GE
	T7DSGjkge483ANaLMiKbiIuGXV832f/B9VYsBmLgik+84PP9epSZm3NVJ2vsryC6L+Jz5U
	sKIRhlgfBjP78+Xl3RGF0C8dSMoh5eRIqRUGLYLRSlcoO0xXN/9WCvp7g2DlIaTg0UC/GY
	Jxivb3R41K5nCtbxNZWqXdmXFrHbEk1Ua5iH8AUPlrhMzi/xJ7GdS87upeh0vwkpEtmMWP
	dbbVSitm57RO0F6D5eG5Sqj4yHEKf+8a2akWSQ/Sh+EKy0LrYBUj0V4hCOqjLw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev> (Sean Anderson's
	message of "Tue, 14 Oct 2025 14:25:10 -0400")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<mafs0ecreontu.fsf@kernel.org>
	<4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
	<mafs05xcpo9sz.fsf@kernel.org>
	<26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
	<mafs0ikgnn07u.fsf@kernel.org>
	<d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
	<33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
	<92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 12 Nov 2025 14:10:40 +0100
Message-ID: <871pm3iegf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Sean,

> # flash_lock -u /dev/mtd/by-name/spi0.1
> # flash_lock -i /dev/mtd/by-name/spi0.1
> Device: /dev/mtd/by-name/spi0.1
> Start: 0
> Len: 0x8000000
> Lock status: unlocked
> Return code: 0
> # test() {
>> mtd=3D/dev/mtd/by-name/$1
>> start=3D$(($2 * 64 * 1024))
>> size=3D$(($3 * 64 * 1024))
>> dd if=3D/dev/urandom of=3D$1 bs=3D64k count=3D$3 status=3Dnone && \
>> mtd_debug erase $mtd $start $size && \
>> mtd_debug write $mtd $start $size $1 && \
>> dd if=3D$mtd bs=3D64k skip=3D$2 count=3D$3 status=3Dnone | sha256sum $1 =
- && \
>> rm $1
>> }

I am also working on locking these days, have you already started
writing extra SPI NOR Documentation/process based on this thread?

I am also trying to clarify what is expected and what the API somehow
does, as it was not fully clear for me at first sight.

[...]

> # flash_lock -u /dev/mtd/by-name/spi0.1
> # test spi0.1 64
> 83a8dc6125ec9672d18f7f18f92e16f867354dbe8e2f3b0aca52b9d0ad7d8ffe  spi0.1
> 83a8dc6125ec9672d18f7f18f92e16f867354dbe8e2f3b0aca52b9d0ad7d8ffe  -
> # flash_lock -l /dev/mtd/by-name/spi0.1 $((1024 * 64 * 1024)) 1024
> # flash_lock -i /dev/mtd/by-name/spi0.1=20
> Device: /dev/mtd/by-name/spi0.1
> Start: 0
> Len: 0x8000000
> Lock status: unlocked <<<< Wrong!

This isn't wrong, even though at a first glance the output is
misleading. The API apparently does not gives you all the
locked/unlocked sectors, it is way more basic than that: it tells you
whether the full range you asked for is indeed locked.

When you run "# flash_lock -i /dev/mtd/by-name/spi0.1", you privide no
start/length values to the command. Hence, the defaults are picked: the
entire device is considered for the check. The tool asks the kernel
whether the range 0-0x7ffffff is *fully* locked. Answer is no, it is not
fully locked.

In the kernel there are two helpers for that, and they won't give you
opposite results all the time:
- is locked:
    - returns true if the given range is fully locked
    - returns false otherwise
- is unlocked:
    - returns yes if the given range is fully unlocked
    - returns false otherwise

So if you want the tool to tell you "yes", you should instead use the
exact range you locked (1024-2047) or any subset of it.

Thanks, Miqu=C3=A8l

