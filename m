Return-Path: <linux-kernel+bounces-729964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A333B03E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246C03A1A36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E2248195;
	Mon, 14 Jul 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="gp3otAwy"
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DEB246BD1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494817; cv=none; b=SzR7GX2gBIn6IVtoXXi+5nNhcFgzIqFRgsuiJTTYKJV6yj+ifZer2qaRgjCmDKzD1HFDWLiXaCXC5oXt4sCgvdu3cTOdF4bb6UxlIHL8kgUO3uKcZRajMev5M/unsPzqEXPHwAQAO/gkDDZDyhBFhve9ZTj1gA/oItQbya09kA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494817; c=relaxed/simple;
	bh=1Fw987TcN6BIXxxiTjm+t/KkenDoc+b4LUeEdbU8NN8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bbx0gBVIPFSXfKkpReu24clfyh76sq4+fz4rQ1DbCAqBSds7hvwj1V1y7fAe8joNH5Nl7a2iGSIdh3JEADFOJxZI7RUT3e65E106kSMo/C6hPR8SD6uSGsuS7h7P7Kvsq+iwnFFVIwEsxkFtGNgaytsyeYVvmIdt+1047Tm69Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=gp3otAwy; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752494812; x=1752754012;
	bh=1Fw987TcN6BIXxxiTjm+t/KkenDoc+b4LUeEdbU8NN8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gp3otAwyRmk57+7bfczKQ2/lFhXI8ZgqvtaYOQkmY7s2oBz+Ke3kCZd0pPQd8A8aq
	 bM23J52hnbtvvGI0DbOQtpkII4PMDDypPzxmS3/+BtkBSnrzl4sCH5ryuEXqog9BFI
	 LG3qYj9UPMDehHXSj3pGll29a7WLElrB3mfFjK+HaNOJPeZmoSjKZICNCuk4hGWokO
	 Ad2pnTOBFwRNKa0r/4qFpZx7fqMIZVCHMqeA6Ul7zJPEEoDbDdaKotTOhK4wVdKCOr
	 bgr1ecevh83CrpYWexwOoGJzpljhWuPJhdtgPTX3HlHHWb3730x9oGWmDWY4zu0gd9
	 ZI0WfLTad621w==
Date: Mon, 14 Jul 2025 12:06:49 +0000
To: remi.buisson@tdk.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/8] iio: imu: new inv_icm45600 driver
Message-ID: <zkxaafrvyizbnxtuuj7jwh26jdat7tbvsnnxpnfz7fnmqjuycy@qqr6fzb46kvg>
In-Reply-To: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 2508852859c9f3c843a59282947e77c33953914b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 08:57:55AM +0100, Remi Buisson via B4 Relay wrote:
> This series add a new driver for managing InvenSense ICM-456xx 6-axis IMU=
s.
> This next generation of chips includes new generations of 3-axis gyroscop=
e
> and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
> intelligent MotionTracking features like pedometer, tilt detection, and
> tap detection.
>=20
> This series is delivering a driver supporting gyroscope, accelerometer an=
d
> temperature data, with polling and buffering using hwfifo and watermark,
> on I2C, SPI and I3C busses.
>=20
> Gyroscope and accelerometer sensors are completely independent and can ha=
ve
> different ODRs. Since there is only a single FIFO a specific value is use=
d to
> mark invalid data. For keeping the device standard we are de-multiplexing=
 data
> from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer an=
d 1
> for the gyroscope. This architecture also enables to easily turn each sen=
sor
> on/off without impacting the other. The device interrupt is used to read =
the
> FIFO and launch parsing of accelerometer and gyroscope data. This driver
> relies on the common Invensense timestamping mechanism to handle correctl=
y
> FIFO watermark and dynamic changes of settings.
>=20
> The structure of the driver is quite similar to the inv_icm42600 driver,
> however there are significant reasons for adding a different driver for
> inv_icm45600, such as:
> - A completely different register map.

At one point we asked TDK/Invense for a driver for icm42670. It also
have a completely different register map... Grrr :S

Anyhow, should we combine these drivers in inv_icm42600? Like
st_lsm6dsx?

/Sean

> - Different FIFO management, based on number of samples instead of bytes.
> - Different indirect register access mechanism.
>=20


