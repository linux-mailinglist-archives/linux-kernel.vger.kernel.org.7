Return-Path: <linux-kernel+bounces-877900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B1C1F4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78E5A4E8B77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DF32C305;
	Thu, 30 Oct 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pmGq5W/4"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD533CEB4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816600; cv=none; b=TTSuscnOwCEbnarN3WxtEV/BDatQSL7pd9TvNHb1Z8dfXS9g07CLwVgpSPpPhPUwywCrYfSumzezVMiummK32jrSR9Z+ptP/HYUdv/WlbN5kXSOIV45eAHkzLPBQz810kmYgy+A+C64ymSld5h42nxBT+RBDAgvrdh5QTUt4Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816600; c=relaxed/simple;
	bh=Qc0+Uf2TFezTPsGtg5X2co1br8c8C1ZQ+ZgGCIOw4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDRmX2Xwc/NyfGDsGcoIVYlBP+zykUzeUoFiUIRzcdu3AxcTacega4dREQRUsSzX/p5TLVCZnbvqX5dKDYAfWQstllmvuuUUS4vzOuCFpAFdNjZhCo/6BIxdEjt/sE5WzbVVAFsr2FqXdXd6ERkOPPO99Ji3uz+28r3p31bTpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pmGq5W/4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC3CFC0DAA7;
	Thu, 30 Oct 2025 09:29:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C1EA6068C;
	Thu, 30 Oct 2025 09:29:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F0E4118085A8;
	Thu, 30 Oct 2025 10:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761816594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Qc0+Uf2TFezTPsGtg5X2co1br8c8C1ZQ+ZgGCIOw4lE=;
	b=pmGq5W/44Mtkdq7TTp7dSZj3t/TgnGDAWoHSYDgULOIpMa8IY9s7/DG1No2v0g/ibD7KUp
	/c2WlIdCHUPNC22HynCrww9tlVnYdlC9c0DzeXQkwDcdiSMfXe+fFuNah2dYXjdetMnlG3
	yVvIfGqSkZGntcz4aLJbkakQW3kv4gQ2j8c4b9N+3TbFF6A5pGV5PB2RQApxX0gO/kDaY6
	faJ4kIqqLparBMUWB9QYjDHgxrIoxRfV6Q6cIe4PirYzdS8YSN/ib1BVxVn1p9jI+7t8AZ
	9Tr+l7q2zKCLqM1ytbi1uUqIkpJKY7iD0A6Pet/THIF84zC+C88L21uGLGqH6A==
Date: Thu, 30 Oct 2025 10:29:48 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] dt-bindings: pse-pd: ti,tps23881: Add
 TPS23881B
Message-ID: <20251030102948.49cb0b42@kmaincent-XPS-13-7390>
In-Reply-To: <20251029212312.108749-3-thomas@wismer.xyz>
References: <20251029212312.108749-1-thomas@wismer.xyz>
	<20251029212312.108749-3-thomas@wismer.xyz>
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

On Wed, 29 Oct 2025 22:23:10 +0100
Thomas Wismer <thomas@wismer.xyz> wrote:

> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> Add the TPS23881B I2C power sourcing equipment controller to the list of
> supported devices.
>=20
> Falling back to the TPS23881 predecessor device is not suitable as firmwa=
re
> loading needs to handled differently by the driver. The TPS23881 and
> TPS23881B devices require different firmware. Trying to load the TPS23881
> firmware on a TPS23881B device fails and must therefore be omitted.
>=20
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

