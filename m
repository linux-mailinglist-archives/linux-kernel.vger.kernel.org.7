Return-Path: <linux-kernel+bounces-878258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFEEC20213
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989D24636A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4E355042;
	Thu, 30 Oct 2025 12:55:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BC35502E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828943; cv=none; b=OF99p2D9GgKEDfXd2AwFE/rNM8v2n36+4kavPmNVId+zRGBkkHg1G3NRNKsPdEJtYLmjTNAz26n7pQtKsStqIttqe5PVv8pmzadPgJtJFE43niOCRw1cmKG8J+/I0CInqMWVTNQNNQqrO+NQJc1T7wtr8Wz0WbtwHVuw89ufbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828943; c=relaxed/simple;
	bh=Iy+PnbmCNBkfu351AE1ku30RF+j4SK4VjdDEzOeh/kA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIXQl2EnzqfKzTB8evHbRLzFxnn0FkMLUFxvpCIacOJ/N5ICAM5bGnNxNEZI+b5KY4Jd5Y2tnqSU4l1j3gFC0zD2gDHzj4XnfZkf35oyzvo1X8HpuaGhLrSCNEPlmi9QsExLZbV/42HS+Oml0Le4xfnng5F/pMglBbDii+D5c5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBh-0004m3-DV; Thu, 30 Oct 2025 13:55:33 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBg-006DFf-29;
	Thu, 30 Oct 2025 13:55:32 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBg-000000009Gw-2UjF;
	Thu, 30 Oct 2025 13:55:32 +0100
Message-ID: <02c89eed4c8f8ee5b4fb1d2e7d6956eb6a562d23.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] reset: remove last remaining user of the legacy
 lookup and drop unused code
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner
 <david@lechnology.com>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 30 Oct 2025 13:55:32 +0100
In-Reply-To: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
References: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
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

On Mi, 2025-10-22 at 15:51 +0200, Bartosz Golaszewski wrote:
> The TI DaVinci platform is the only remaining user of reset platform
> lookup. Except that we no longer have any legacy, non-DT boards in
> mainline so we can now safely remove it from the PSC driver and drop the
> legacy lookup support from reset core.
>=20
> The DaVinci clock driver doesn't see a lot of traffic these days so I
> suggest a simple Ack from the clock maintainers and routing it through
> the reset core for v6.19.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to reset/next, thanks!

[1/2] clk: davinci: psc: drop unused reset lookup
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dd8b79ad1f40c
[2/2] reset: remove legacy reset lookup code
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D205b261463ff

regards
Philipp

