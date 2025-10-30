Return-Path: <linux-kernel+bounces-878255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E8C201C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6957E188FEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E40342177;
	Thu, 30 Oct 2025 12:55:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECB341645
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828915; cv=none; b=O5bxFBRu0tNviIyrLOggekgj2ADYd1xufB36cu9f/FTO92lV2+U/CIWjdYd340Qbu2si9hjAvVm2rXPPgpiOdWU2GSAZ1ZzMaGIVceEfmUpdUh8EwxIAe2I70g1wIiHFGmBpNOMEai9XA/HcSTwiA1G3BfmLFp82iPftOUGLn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828915; c=relaxed/simple;
	bh=9iSAiY/NnBbYBJLM+p73opi3Hl9pdaqSwMVuL4F62Jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGfE9KqQ8OcCTM0uoOTxcjo/EYklIhgFOBoAMMuv+X32pAhoKWK8EnpekIpaxlxbc9iPOcb7EOFvhz1rVZfKqlRmuisJ9iUGztkJzNSz7Kyyurkj2yFdek3akDuFvjJJfwi6t9jMfZrMKpv8zVyP7PXACs4tYc0nhe7HQTRoRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBA-0004h1-BJ; Thu, 30 Oct 2025 13:55:00 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESB9-006DFT-2D;
	Thu, 30 Oct 2025 13:54:59 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESB9-000000009CO-2aEz;
	Thu, 30 Oct 2025 13:54:59 +0100
Message-ID: <35f619a73a83207b83de095967014b03b7d3e8f0.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] reset: always bail out on missing RESET_GPIO
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 13:54:59 +0100
In-Reply-To: <20251015205919.12678-5-wsa+renesas@sang-engineering.com>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
	 <20251015205919.12678-5-wsa+renesas@sang-engineering.com>
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

On Mi, 2025-10-15 at 22:59 +0200, Wolfram Sang wrote:
> Optional GPIOs mean they can be omitted. If they are described, a
> failure in acquiring them still needs to be reported. When the
> RESET_GPIO is not enabled (so the reset core cannot provide its assumed
> fallback), the user should be informed about it. So, not only bail out
> but also give a hint how to fix the situation. This means the check has
> to be moved after ensuring the GPIO is really described.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch 1 applied to reset/next, thanks!

[1/2] reset: always bail out on missing RESET_GPIO driver
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D25d4d4604d01

regards
Philipp

