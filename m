Return-Path: <linux-kernel+bounces-888263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE26C3A584
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CF43A7D95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1672E11A6;
	Thu,  6 Nov 2025 10:44:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62342DECDF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425883; cv=none; b=f6iw+FCUlu+rmr2KwbjccSg2f1KeiisB4bN8H/x4PlItD0BYKZW22pDMXRIn4otJ3MxZsPQOm17gSa77MaUnwNsPhpVPR6EuR56D+Q/bMB/JAn4h+KnOoTMYOgW+SiYck9m2h8AF6wrh5vWBWY/1GNFmckP+V4UNlyGcfAdVd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425883; c=relaxed/simple;
	bh=XCy5GKbtcnoIwU/cbmwio1bDMDjKohQStt86XJ4W4Hw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eqk9fJbJkwB0jttypNVVPI/vEyMdNXjqvX2JMGlfH7JEEq60TfS0ahfRAUciWFOzZnId/92pPnZFv6gso0B+FWKiJIRtvXDNfYXkkWuMO2urP0tZcGHU6G4rAmt4cppL97xDHtvbIgWyFQmiRTsFn1ol+CNkTKDaZ3JN1NNEC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGxTg-0001J7-US; Thu, 06 Nov 2025 11:44:28 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGxTg-007LZE-0x;
	Thu, 06 Nov 2025 11:44:28 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGxTb-0000000049j-0omw;
	Thu, 06 Nov 2025 11:44:23 +0100
Message-ID: <3e7c80cb273d8a8a7741ae45fab9cfdf3367a229.camel@pengutronix.de>
Subject: Re: [PATCH next] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR()
 bug in probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>, Claudiu Beznea
	 <claudiu.beznea.uj@bp.renesas.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Thu, 06 Nov 2025 11:44:23 +0100
In-Reply-To: <aQYKqxD6qCQwFCye@stanley.mountain>
References: <aQYKqxD6qCQwFCye@stanley.mountain>
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

On Sa, 2025-11-01 at 16:27 +0300, Dan Carpenter wrote:
> The devm_regmap_field_alloc() function never returns NULL, it returns
> error pointers.  Update the error checking to match.
>=20
> Fixes: 58128aa88867 ("reset: rzg2l-usbphy-ctrl: Add support for USB PWRRD=
Y")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to reset/next, thanks!

[1/1] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dce2883a0339c

regards
Philipp

