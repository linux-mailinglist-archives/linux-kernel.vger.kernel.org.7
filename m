Return-Path: <linux-kernel+bounces-768654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C719DB26395
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFC7B52CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90A2F83CC;
	Thu, 14 Aug 2025 10:57:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378392EA472
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169044; cv=none; b=kkdGqtbchzfNaxAc91jRtswLRNSLVoVOejHAQibnIcQjrDfDqqqMVPJe3i0TsqslMwJ/x0oKvC+ndPHYA0wfMYNrx12H6iZTUUjbJum41Ja0SpQcJyOkW6WqxF4RGwS3qZihPl+X4Jx1+zM5SFxeb+Se9djW8MMV4FRvlRt9ArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169044; c=relaxed/simple;
	bh=Q5wFcGljVGF+9lLQ4rmalAeB56Hon75f5JsZyOTlPrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PC7tLNcdhkK2hE7dwr27BLDqK2+gv+MBPHDeLBnc6WfBSb+sgQOsNZ4n0SISg0ajNxcwFHa9dBaH5pZpvVGi5m5HW4CxiCon3cqGtvGTS74XMNhwt+CPY6d0R+LOCAZ1l2OBev6drdY7oKXG+gbuMJUactBLStSCoQ6tspbJ0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVe1-0001iR-BF; Thu, 14 Aug 2025 12:57:17 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVe0-000EyY-2z;
	Thu, 14 Aug 2025 12:57:16 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVe0-000I31-2h;
	Thu, 14 Aug 2025 12:57:16 +0200
Message-ID: <0af65202bca6ef30ee6530703db303e81ec190eb.camel@pengutronix.de>
Subject: Re: [PATCH 0/6] reset: bcm6345: add support for internal ephy
 resets on bcm63xx
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Kyle Hendry <kylehendrydev@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?ISO-8859-1?Q?Fern=E1ndez?= Rojas
	 <noltari@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 12:57:16 +0200
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-07-08 at 19:47 -0700, Kyle Hendry wrote:
> bcm63xx SoCs have a register in the gpio controller that controls some
> of the phy functionality. Some of the bits reset individual phys and=20
> need a driver to set.=20
>=20
> The other fields in the register configure phy power and will be set
> by the network device driver.=20
>=20
> Kyle Hendry (6):
>   reset: bcm6345: add support for bcm63xx ephy control register
>   dt-bindings: reset: add compatible for bcm63xx ephy control
[...]

Applied patches 1 and 2 to reset/next (in inverse order), thanks!

[2/6] dt-bindings: reset: add compatible for bcm63xx ephy control
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Da341bcfbfa74
[1/6] reset: bcm6345: add support for bcm63xx ephy control register
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D6e273caeacf0

Do you agree that patches 2-6 are not necessary?

regards
Philipp

