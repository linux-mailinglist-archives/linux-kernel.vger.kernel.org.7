Return-Path: <linux-kernel+bounces-766227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED0B24410
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC4E585E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F22ED17F;
	Wed, 13 Aug 2025 08:18:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C22D3720
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073081; cv=none; b=tG3CTe9OOMTlX18DVhg/BZ4Q5v63j0qLCUl9buWlX1VI5vqUFQUWfD9K1SJ5y5Cu56TLoWHys9RC5Vb03nQGqwukyhotAasowvJoMwyZOw6+sqjNbegalT7vkgxiSNdQFIjAa5j2kVO6xT02pPZZhxL693uBW9rpTzRVdMonkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073081; c=relaxed/simple;
	bh=abEsGjaUdk6F6Crnm8dR4Aqi1CyjDey/R/XrpgG3A7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mjs/yauZtuAmjtU2yA8q21AOWhfVPnhEq/hRt5s6XD9ZqWyMO3C3ECE88XpUWskUrmuEoTlaz1AZqUXpTSQJmu2HzOYUAsgciIlK1RVN+bCbEY2YIeiZS4QOE+lPK19P+f8QKiguHZeu/8wLo22wyppM96YCnJHdYpWDCyKWE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6gB-00036X-0G; Wed, 13 Aug 2025 10:17:51 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6g9-0003nI-1E;
	Wed, 13 Aug 2025 10:17:49 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6g9-0004i6-0x;
	Wed, 13 Aug 2025 10:17:49 +0200
Message-ID: <239711fdd1eb6f79a89af7396ef7eb60f485ec12.camel@pengutronix.de>
Subject: Re: [PATCH 0/7] can: m_can: fix pm_runtime and CAN state handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik
 Flykt <patrik.flykt@linux.intel.com>, Dong Aisheng <b29396@freescale.com>,
 Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram
 <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linux-can@vger.kernel.org
Date: Wed, 13 Aug 2025 10:17:49 +0200
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
References: 
	<20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
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

On Di, 2025-08-12 at 19:36 +0200, Marc Kleine-Budde wrote:
> The first patch fixes a pm_runtime imbalance in the m_can_platform
> driver.
>=20
> The rest of this series fixes the CAN state handling in the m_can
> driver:
> - add the missing state transition from from Error Warning back to
>   Error Active (Patches 2+3)
> - address the fact that in some SoCs (observed on the STM32MP15) the
>   M_CAN IP core keeps the CAN state and CAN error counters over an
>   internal reset cycle. Set the correct CAN state during ifup and
>   system resume (Patches 4+5)
> - add support for optional shared external reset, to properly reset
>   the IP core (Patches 6+7)

Should this declare a dependency on
https://lore.kernel.org/all/20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbf=
ced1f@pengutronix.de/
or is that already merged?

regards
Philipp

