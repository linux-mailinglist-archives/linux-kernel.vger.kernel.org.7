Return-Path: <linux-kernel+bounces-878252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C9C201E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565B1465C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0A34214C;
	Thu, 30 Oct 2025 12:55:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774332E0922
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828901; cv=none; b=UnOojEj5iaHtYd4kPc9fZBBEjkE6O7Nn7CKbSSsSKWpV5q4xbvpP7xuDkDa3TpzC4NUNx/oX/LjM8ivXoVJlwBXQ9M8MdZHdfme/Xrn3QEQZw1viKGbU2FMBbMapZxW420ZXYjDgGJb+zdEsJiBsPqcBwefLYYXdcJLVeLptcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828901; c=relaxed/simple;
	bh=LDhXHstGizu16iZpiJKzApvDo297JYrOQsKCAq1BTAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uD3G73Ziuz4Pljq1SiPvwIDvaxvYSKMn54JfXZ5AT6ZUG72UyhNX93wF0h7rVtuP0ltHDsSzLN10i4XWaK207Yh9FdXaRmEwSxLjc7LR8XKvhKcQziZZFz8IuWmVI3ZsDlNxGar0E5XS70FBy10HY6m/E3n/mH5LBfYuNi/dTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAl-0004dc-QN; Thu, 30 Oct 2025 13:54:35 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAl-006DFL-0u;
	Thu, 30 Oct 2025 13:54:35 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAl-0000000099K-0qda;
	Thu, 30 Oct 2025 13:54:35 +0100
Message-ID: <0cd212879b8fedf0edb574cb17bf7a3603a84310.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: microchip: Add LAN969x
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, steen.hegelund@microchip.com,
 lars.povlsen@microchip.com, 	daniel.machon@microchip.com,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Date: Thu, 30 Oct 2025 13:54:35 +0100
In-Reply-To: <20250922142813.221586-1-robert.marko@sartura.hr>
References: <20250922142813.221586-1-robert.marko@sartura.hr>
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

On Mo, 2025-09-22 at 16:27 +0200, Robert Marko wrote:
> LAN969x also uses the Microchip reset driver, it reuses the LAN966x
> support so use a fallback compatible.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied to reset/next, thanks!

[1/2] dt-bindings: reset: microchip: Add LAN969x support
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D0616ef5e16ed
[2/2] reset: sparx5: add LAN969x support
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Df764bafcdf58

regards
Philipp

