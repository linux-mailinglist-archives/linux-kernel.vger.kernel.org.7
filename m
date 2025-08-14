Return-Path: <linux-kernel+bounces-768653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10BB263B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F96B1CC7D86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A370301470;
	Thu, 14 Aug 2025 10:56:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E530146F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168994; cv=none; b=GVpUpnmVI/Ccti6jArt2M5+0fRNVcZLsKrKNRzyz+yDVE2NJk5T45+NjKUEdCRfZyXA0w1MuOnVqtTltwPT9Jlo9roKDVjNJM9A79JBwAcfqMWQj3HPr+oecF2ETGcmdeRnk8MIBrJRohbVcJGEetYqRpBMoGtc/Qx8FEnS00d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168994; c=relaxed/simple;
	bh=hkR30hb3y9hPOFxoD1rIq3gAUNJUptUdgsxnsJVj5uA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUi2X6YH2O6cukPxVJ15/n9zvO42PYO4PradCf7uIT/bFWlCpKM8E4o6oSProKN3GgH914Zhs+3P+TNN23ppQtzFSUyiFqhpTNCa6EgE0m6Ni2lDem2ESuCS7qpPheh1n7wGK1ekthoEJagT+YbjruEXY1x2bwKe4pV779kAu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVd7-0001aT-If; Thu, 14 Aug 2025 12:56:21 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVd7-000EyP-0z;
	Thu, 14 Aug 2025 12:56:21 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVd7-000Hyw-0k;
	Thu, 14 Aug 2025 12:56:21 +0200
Message-ID: <01e5b62d71ef7825a7a61f1785fb2bcb47a92cda.camel@pengutronix.de>
Subject: Re: [PATCH 16/21] reset: remove unneeded 'fast_io' parameter in
 regmap_config
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo
 Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
 linux-arm-msm@vger.kernel.org,  linux-riscv@lists.infradead.org
Date: Thu, 14 Aug 2025 12:56:21 +0200
In-Reply-To: <20250813161517.4746-17-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
	 <20250813161517.4746-17-wsa+renesas@sang-engineering.com>
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

On Mi, 2025-08-13 at 18:15 +0200, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot =
is
> happy, too.

Applied patch 16 to reset/next, thanks!

[16/21] reset: remove unneeded 'fast_io' parameter in regmap_config
        https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D1527cd3b89f0

regards
Philipp

