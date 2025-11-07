Return-Path: <linux-kernel+bounces-890457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38425C4018A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6698424A69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C62DC780;
	Fri,  7 Nov 2025 13:26:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D82DCF5D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521960; cv=none; b=ldfULOsbPNZuGmlIOt9JVx2c6/FOweMG7T74cmds2vwx3kdvpVmAvpLbVhGbBAtVROTygn8SrXNZ5RfgDSIv1M/ZS+TF2dcqXkmjfe4QBf4xarmzB5j1nWacI0PS4gWBT26asBO5iMlkfSkceJ89t603WcWe2iYQL051qCSs1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521960; c=relaxed/simple;
	bh=F3HoWWL2iPXP2AITSwQw6GlZ1uNOvQA21H8sYHX5tFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AadZTyo0uO0o6llL5aPJ1sa4yFuphI90DKbs0acJaXI9ix2WsYxlhTNvh15J92zWBIDPQvr8xTwuSOfAMkT8nGNhekMTARTPEqpGcMKmH02qTj0bvL0KJJMljOR7waTJfSp3+fEoV00DSY+nRu+M0ogfBkHQrJIh0HbJt152Syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMTV-00041n-73; Fri, 07 Nov 2025 14:25:57 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMTU-007XJu-1V;
	Fri, 07 Nov 2025 14:25:56 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMTU-000000007SM-1eC5;
	Fri, 07 Nov 2025 14:25:56 +0100
Message-ID: <908ca24da436028417ed916a1a1abb3b642cc646.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: rzg2l-usbphy-ctrl: Propagate the return
 value of regmap_field_update_bits()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Fri, 07 Nov 2025 14:25:56 +0100
In-Reply-To: <20251106143327.3049052-2-claudiu.beznea.uj@bp.renesas.com>
References: <20251106143327.3049052-1-claudiu.beznea.uj@bp.renesas.com>
	 <20251106143327.3049052-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Do, 2025-11-06 at 16:33 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Propagate the return value of regmap_field_update_bits() to avoid losing
> any possible error. With this, the return type of
> rzg2l_usbphy_ctrl_set_pwrrdy() was updated accordingly.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

