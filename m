Return-Path: <linux-kernel+bounces-877981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C524C1F7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 894BD34DCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C3351FA3;
	Thu, 30 Oct 2025 10:22:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C626B2C8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819759; cv=none; b=cawciLeBm9rvJq26vxAcjuWAx2MscP62yHwjV1pYzIxQ2n6I3AabgWJFYxrbTUDxawGAMElRX1B9wwA4t/bZQvC9UVWOLF16ihJwU9HNpDCf6ylHWOX17OGFq+jsAvE1JACeeKNC9f8I7cpyyDjWXc9je0XNupX6MbT8wYLAKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819759; c=relaxed/simple;
	bh=h6ZeZMm+kh/ZMKD2CWbwzRP0dY/DOi2RxLvBAU5tIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok+0i/68bBqNMcfjIRQr+bMafxz+igo7X4D0f8Hq8fV2Gy9EAbyELNxiq2VFzJJM4s0a/My19sQemjv+EDXZUcl0nUM09IFCLuBL142Rkxe6ZXvlVlg6yYBNVCns/Ty7EOxOqA7h0jDpAXAsoTQ7IqRZn+d6LuaBs0t9CVRTQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnK-00035h-B2; Thu, 30 Oct 2025 11:22:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnI-006C7e-30;
	Thu, 30 Oct 2025 11:22:12 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnI-008rEb-2Z;
	Thu, 30 Oct 2025 11:22:12 +0100
Date: Thu, 30 Oct 2025 11:22:12 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: pse-pd: tps23881: Add support for
 TPS23881B
Message-ID: <aQM8VF2YN7fACzNm@pengutronix.de>
References: <20251029212312.108749-1-thomas@wismer.xyz>
 <20251029212312.108749-2-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029212312.108749-2-thomas@wismer.xyz>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2025 at 10:23:09PM +0100, Thomas Wismer wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
> 
> The TPS23881B uses different firmware than the TPS23881. Trying to load the
> TPS23881 firmware on a TPS23881B device fails and must be omitted.
> 
> The TPS23881B ships with a more recent ROM firmware. Moreover, no updated
> firmware has been released yet and so the firmware loading step must be
> skipped. As of today, the TPS23881B is intended to use its ROM firmware.
> 
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

