Return-Path: <linux-kernel+bounces-791407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A394DB3B673
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E03AA04F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62C29B8E2;
	Fri, 29 Aug 2025 08:50:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C72D8785
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457419; cv=none; b=rM4SSRgYCFy8HIwHxxbBLZ0Yqbg2OcvPjPv8W74WTejdFewCpL6KLZ132/0KSyEvAuhPfJD/MKZKIcGyHw7d4+sRqkqPnC5g4m76h12aK747Az6jnTb+AwWZT8ijwPq1mZ0JAe/QHCofodMX0zZmZOSxcypu8R1EYKdeoFeBOcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457419; c=relaxed/simple;
	bh=0FkEUj2lsFv78VNsrziL4rQ0LAntUHeKDO6JjSLwJvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOFlEuCjkTT3IC2Pjr1bYNCieubVAwM2EvhGOGOxycj9cTYlSdLXZG3KRINBBfY2ljjlAz3nJ6thOElEeMJqQc+v/ACpbYGbJZYIXRAmt9/SXiqGhKQNPQu+Qypyl18vz2p0INPNuOJI52FTAxOrbu7YoNytMRlGEi/vwlmgEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uruo3-0001g1-MZ; Fri, 29 Aug 2025 10:49:59 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uruo2-002hPH-1W;
	Fri, 29 Aug 2025 10:49:58 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uruo2-0009f3-1D;
	Fri, 29 Aug 2025 10:49:58 +0200
Message-ID: <a1734ee3296add23e8d61f0ed666bb46bd5717f5.camel@pengutronix.de>
Subject: Re: [PATCH] media: verisilicon: imx8m: Use the default Hantro G1
 irq handler
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Paul Kocialkowski <paulk@sys-base.io>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Date: Fri, 29 Aug 2025 10:49:58 +0200
In-Reply-To: <20250828135820.1859316-1-paulk@sys-base.io>
References: <20250828135820.1859316-1-paulk@sys-base.io>
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

On Do, 2025-08-28 at 15:58 +0200, Paul Kocialkowski wrote:
> The existing imx8m_vpu_g1_irq implementation is an exact copy of the
> default hantro_g1_irq one. Switch over to it instead of keeping a
> duplicated implementation.
>=20
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

