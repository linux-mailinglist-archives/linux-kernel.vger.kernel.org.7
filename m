Return-Path: <linux-kernel+bounces-878155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EAC1FE78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56D61A22FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217934F279;
	Thu, 30 Oct 2025 11:59:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D3314D27
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825563; cv=none; b=MPwI2B5FWags1Ixut6ZuJ/BGkWs8ookzDTp0QVh4V+QL6vU41UGBYZz2YdFuBjX33hOXQwZaDEyWQR38uR1fVaFBhNgIxjj7fvKsoxStktT2HdJethSHJiUcR39UraSi2G+fUF9LF3aPNO2tZ9C6gVD7pgznKQYK1DWQpmquRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825563; c=relaxed/simple;
	bh=YzlFTWK/6NZkxYGlD1l/ZqKEZ5Ua9dUvbSOCmGR1xcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njL17g7Vdb5BVMG2lj0z1QKYYZvYBV44Yh23QtmX2v4I9dBxLuWdbkElPx01ObOB1q3/avw8AZ3szrinEXwB+FLqH6k3OWFaPyFIIv4+5kIiZg87StmDn8InXgYGbEgEV//TRFoTR02htU3CqJsTey9/3ZJMzT3uqzPN4NLXoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERJD-0006Wy-Bp; Thu, 30 Oct 2025 12:59:15 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERJC-006ChC-27;
	Thu, 30 Oct 2025 12:59:14 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERJC-0000000084i-2S8z;
	Thu, 30 Oct 2025 12:59:14 +0100
Message-ID: <db672a51eced932d4513ee599b68771b5b246c13.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] reset: always bail out on missing RESET_GPIO
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:59:14 +0100
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

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

