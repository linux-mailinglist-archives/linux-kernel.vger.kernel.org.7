Return-Path: <linux-kernel+bounces-868503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE79C0557B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E7A19A6F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317D30AD0C;
	Fri, 24 Oct 2025 09:30:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049430AAD6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298225; cv=none; b=XdClZqIEgvPe+455NvKhS/nbyqqofPbslQbPgdzcOvZPLyGmwW73N8nlWS0G/JADF+5sepOnw5r5J/KGewtqNidxPkBMQq0S4pHkbFIdCzlsIHhglfocsyzmvdddfuMzqV4pjUeRmb3BtFZ0WENNt4JoLpoFXOxo4xcUVGha+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298225; c=relaxed/simple;
	bh=9yMzdBC7HjA9K+nry0YDFzVoI1L7X3qblLDJt70kctk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sl/ImXe68fO/wN5EjR7hMpOG8slaYxUEkoejv+mYvHYAr7mdwdpB5CFugMfpTk3c0BAEOAFBadsLxtE6IQwEM+bKGRxCpfpKtt7GxC0We0bO6cN+JXZvmFxHG5uwNfYVk76YHy7RTFSodq+3lqrjmCaFvCGPkPk+IbTWJxqRvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vCE7g-0004Lw-Bd; Fri, 24 Oct 2025 11:30:12 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vCE7g-005CdF-0U;
	Fri, 24 Oct 2025 11:30:12 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vCE7g-000000004y2-0IVk;
	Fri, 24 Oct 2025 11:30:12 +0200
Message-ID: <80bce917a7bddf79d25fcf3c7497756fd6035a35.camel@pengutronix.de>
Subject: Re: [PATCH v8 5/7] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu <claudiu.beznea@tuxon.dev>, vkoul@kernel.org, kishon@kernel.org,
 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, 	magnus.damm@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, 	biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Claudiu
 Beznea	 <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang	
 <wsa+renesas@sang-engineering.com>
Date: Fri, 24 Oct 2025 11:30:11 +0200
In-Reply-To: <20251023135810.1688415-6-claudiu.beznea.uj@bp.renesas.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
	 <20251023135810.1688415-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Do, 2025-10-23 at 16:58 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
> signal from the system controller. Add support for the Renesas RZ/G3S SoC=
.
>=20
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

