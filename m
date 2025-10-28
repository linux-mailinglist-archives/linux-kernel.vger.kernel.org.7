Return-Path: <linux-kernel+bounces-873489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FAC140C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9456C3B76C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E91306B0C;
	Tue, 28 Oct 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T2mWuyF1"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AC2E540C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646610; cv=none; b=Co8m7jAQjS7bfVCMzy7pQx9oC0jFblSWwNV9IMKDn3njCnfqFhZ5BGQOggNjyP2SOEUdSD24oN7/65DsFlppZiemXbf4UTcq/J5j3s08242W526I3vzWOV4g4XkNLV8iMyWbsy8yFkNba5ei2G+FdLRi4oZBujBLtgcSRASnLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646610; c=relaxed/simple;
	bh=yJZzbNfqtoEwc2kYNlqzuH0OD+6uRNTN10RJVs8dHjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSaqocDJ7833VqETT4zOwi4VP9YvV4xLcmqoMAqGtjj9G5rJ8MWqF28hthVadi6SZ/LsO7BZitXFVuWXYQ9ozjD+nSa3RMsIt2uozNOdz6dRAw0R6mLFTrHWDZ6J+0FKRsrHI8tSJdzV93ObEb1zpn/TQ72swXlg9uDSltqFuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T2mWuyF1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5E34E1A16F9;
	Tue, 28 Oct 2025 10:16:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2EE15606AB;
	Tue, 28 Oct 2025 10:16:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EABC1179B169;
	Tue, 28 Oct 2025 11:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646605; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ls9js8pk1OxApOPfHjg+6OhXCiFAAL8Poa+LHhv8b+I=;
	b=T2mWuyF1Qd8XV3vwoWIodU+brS+15SaCjgzWX2XlEE5kUJTtJQyb0GGWuqTyZhH+FFDKpc
	Xqqvn5L2mdvJ0MNnISgT0M6sIU8mXNXeLM9S2z65uY1z3ukIyHZ0Xwr68Hha+oAXOtfkIq
	aA/mFYHiKksHLih9RQc5ooPMSLYOf1Ml8ex93rbVOk7S95p5VZ8JzIBngXxbW6J82SowfD
	DOv2auU7aXka0nHFhn9wPan+sLhIOmuRtM3yeXOFknGNV3rsdnAvD2eS2hBfT0jIApcrSG
	H/xvyhnJEHWwN3EkGE8s920SdZ66mHv5s4MtvnLKB7JooqhGCynqXJP8+XQIbA==
Date: Tue, 28 Oct 2025 11:16:36 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Add a devlink attribute to
 control timestamping mode
Message-ID: <20251028111636.7eaba25e@kmaincent-XPS-13-7390>
In-Reply-To: <20251024070720.71174-3-maxime.chevallier@bootlin.com>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
	<20251024070720.71174-3-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 24 Oct 2025 09:07:18 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> The DWMAC1000 supports 2 timestamping configurations to configure how
> frequency adjustments are made to the ptp_clock, as well as the reported
> timestamp values.
>=20
> There was a previous attempt at upstreaming support for configuring this
> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
>=20
> In a nutshell, the timestamping can be either set in fine mode or in
> coarse mode.
>=20
> In fine mode, which is the default, we use the overflow of an accumulator=
 to
> trigger frequency adjustments, but by doing so we lose precision on the
> timetamps that are produced by the timestamping unit. The main drawback
> is that the sub-second increment value, used to generate timestamps, can'=
t be
> set to lower than (2 / ptp_clock_freq).
>=20
> The "fine" qualification comes from the frequent frequency adjustments we=
 are
> able to do, which is perfect for a PTP follower usecase.
>=20
> In Coarse mode, we don't do frequency adjustments based on an
> accumulator overflow. We can therefore have very fine subsecond
> increment values, allowing for better timestamping precision. However
> this mode works best when the ptp clock frequency is adjusted based on
> an external signal, such as a PPS input produced by a GPS clock. This
> mode is therefore perfect for a Grand-master usecase.
>=20
> Introduce a driver-specific devlink parameter "ts_coarse" to enable or
> disable coarse mode, keeping the "fine" mode as a default.
>=20
> This can then be changed with:
>=20
>   devlink dev param set <dev> name ts_coarse value true cmode runtime
>=20
> The associated documentation is also added.
>=20
> [1] :
> https://lore.kernel.org/netdev/20200514102808.31163-1-olivier.dautricourt=
@orolia.com/


Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

