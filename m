Return-Path: <linux-kernel+bounces-894975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF8C4C98F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2429189FB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454682ECEA7;
	Tue, 11 Nov 2025 09:15:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0242242D6A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852544; cv=none; b=oPl5vMtkGRD/ztC3pxf/WTQeqVfM7ox7pRuSHjMgWxhq86C1mmSXV6ijIvHUzbGSWK/ckD/mHpOYM8l/KSlmHTHCBtMLJhw7Ra4oksQ2Au6wBqpNVoV2tNYvzFID/xPcELSHGKg12q7jZRlgLrmVYs4g9sZo7zUY8lESRViti44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852544; c=relaxed/simple;
	bh=YR0eoIFydfEz+0f3RUaWyHvwfBv/96v6P8ApNu69bHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kec5o5erqRClAZxDLO27IFWrCFyL+xfHLZGF66C921JFjXYz3x8ItN7Zt4N0V3hRHrINPV/SnF0uZZ2vGEfE0h74WeUFPtzm2IDivRJ/UanSFjqw39NsMWog0oPDe91Mm0d+auN43Vkwt2RhNY9vknkezrqoWF15F3Tuls/b3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIkTB-00079y-Co; Tue, 11 Nov 2025 10:15:21 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIkTA-008Ass-1m;
	Tue, 11 Nov 2025 10:15:20 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIkTA-000000002G0-23kI;
	Tue, 11 Nov 2025 10:15:20 +0100
Message-ID: <e3c2096459bdd0c1d48c00a837cc7f8c18044631.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] i2c: designware-platdrv: handle reset control
 deassert error
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>, Mika Westerberg	
 <mika.westerberg@linux.intel.com>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, Andi
 Shyti	 <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 10:15:20 +0100
In-Reply-To: <20251111075400.2982270-1-a.shimko.dev@gmail.com>
References: <20251111075400.2982270-1-a.shimko.dev@gmail.com>
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

On Di, 2025-11-11 at 10:53 +0300, Artem Shimko wrote:
> Handle the error returned by reset_control_deassert() in the probe
> function to prevent continuing probe when reset deassertion fails.
>=20
> Previously, reset_control_deassert() was called without checking its
> return value, which could lead to probe continuing even when the
> device reset wasn't properly deasserted.
>=20
> The fix checks the return value and returns an error with dev_err_probe()
> if reset deassertion fails, providing better error handling.
>=20
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Looking at the surroundings, this driver could be simplified with
devm_reset_control_get_optional_exclusive_deasserted().

regards
Philipp

