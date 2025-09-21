Return-Path: <linux-kernel+bounces-826253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92AB8DFE9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4529B1895084
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426619B3EC;
	Sun, 21 Sep 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kWXj+MI0"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F024EF76;
	Sun, 21 Sep 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472557; cv=none; b=ling2kmEF2zCR/EoZ3CBU4Al1GEX0t8oCXpvH5gCPZMBS3CmGLdRt9/KXi64YP8lybSkBT6fYTAH78LIbJVFELyoVsF+HYhyAPhgJA+QGR+rvVl2cw760tQWldmbCLBonbrdkNPqqm9gLpkTa5v5vdsJ748jDYHJRhaHkaE5U9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472557; c=relaxed/simple;
	bh=ucOYN8jGRfe0k7mWUO9XrtxY9r0jSIW5uNsTSyoi1Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTEpYmWZyW8pXKyqTYMGgaWXxSj2Ti1OTPtg2eCowabb9YgbLUSw1Z/WxZAwsMrvdiYDYV9PbXd5FfErWoEQf/JnSlTaBedsHGKqD4QHWa+zbkjavqHzg4QDsnMzHpPVrGAmOq9jrZGUxz85HJOL26nbjvfltNTfmWHbVMQL5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=kWXj+MI0; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PJAFZPocu44Z5wMzUpWIn0ycbvf7q7I00Yw5JWktijI=; b=kWXj+MI0mTxNo5KCQmDHprlTTL
	H7GmAZb4diZFQmZHKG5gC2HEd4EcB80ZPZhatcty/bBd/0NM5MGNsxjZ1lD8v42tqyLJcpg2tLSun
	nBR+/GAlJVbgc5WzjLFhLr4R3dvu7OlNKisvmO6WvzfCvOGXWcG+G/ioeUbQ2hzYBaJbZBt99wX9d
	V4N0nvkEk3421/44LCMSBNPAqCyAJeXxmGTLmBCxm8MORVEP26gYUyZs5MGJbPgAmxHTtsYR7n1lD
	z/M9rcwiJ/1j367ldjy0q8wjBGy6TMd9b/RzOUioCVUidlhI2MahaB3qeZ7QudSipWRviumPMT+8N
	Ss8c1a7Q==;
Date: Sun, 21 Sep 2025 18:35:36 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20250921183536.5368d634@kemnade.info>
In-Reply-To: <473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 23:18:59 +0100
Mark Brown <broonie@kernel.org> wrote:

> > The wanted regulator is the one defined in sy7636a-regulator.c. So it
> > is all an issue internal to the sy7636a.  
> 
> > Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> > I see several other solutions:
> > a) call device_is_bound() on every other children of dev->parent, if not
> > bound defer.
> > b) do not care about the regulator api at all, just check whether
> >    the corresponding bit is set before reading temperature, return
> >    -ENODATA if not, some mutex is probably needed.
> > c) do not care about the regulator api at all, just set the
> >    corresponding bit (together with some mutex locking and counting).  
> 
> I assume this is using the regulator API because someone might use an
> external regulator in a system design for some reason (better quality,
> power efficiency or a shared reference between multiple devices I
> guess?), or because the supply might also be used by external devices?

So just what is behind enabling the regulator:
a bit controlling two boost convertes, two ldos behind tham,
and the name-giving vcom regulator.
Enabling this bit is also required to have the temperature register
working, althogh none of the regulators is used for measurenig the 
temperature.
All these regulator are designed for powering EPDs. So the
regulator API is needed. The only question is whether it might be bypassed
for internal usage (which of course needs some locking, etc.)

Regards,
Andreas

