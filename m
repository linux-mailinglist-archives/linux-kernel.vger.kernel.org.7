Return-Path: <linux-kernel+bounces-799532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9EB42D37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6223B2425
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57612F066A;
	Wed,  3 Sep 2025 23:10:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FF2C0F7E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941020; cv=none; b=uhb9shGnYXxvqBlGsM7Xtoisat7UurgWmeRHU4JZ2Vg5u3njL58J6yqyPO9VG/2p9724Ak1zaID4/boaiRND/Si1dyyCPVbe+GhsltknLNCRDJDoE6rWWc9V0G3gruDPeAXqNF82ffRRuQJTF8eygvkmqtSw3dlx0Eg9/e3zVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941020; c=relaxed/simple;
	bh=zF0rpYQcropjs/QHVgLpXTyYqcX8FR6+GfZCmWuGNyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS1KFqiUJiYUfoTbqaMgdg6qyed+1+U99V+Qdo05mQCl/8w+pdzSw7kB3tKqYgdredsodYARVDGrqtmkwpgI0OREHbDHIK8U/qBdoN0Dp76LVuoy9VLESMg+mSZZFOvzNUiYUb0uqlsAfiFM4s3Jag6kR8fJz22gDXg1i/QJWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwcA-0003ct-05; Thu, 04 Sep 2025 01:10:06 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwc9-003dGy-1b;
	Thu, 04 Sep 2025 01:10:05 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwc9-0008y1-13;
	Thu, 04 Sep 2025 01:10:05 +0200
Date: Thu, 4 Sep 2025 01:10:05 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: microchip,usb2514: add support
 for port vbus-supply
Message-ID: <20250903231005.jblajn7yxihsgfpp@pengutronix.de>
References: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
 <20250821-v6-16-topic-usb-onboard-dev-v3-3-6d2b38a5d818@pengutronix.de>
 <20250822-maize-elk-of-growth-2a30bb@kuoka>
 <20250822103005.c7ba7dclbgdadyw7@pengutronix.de>
 <dc4046e5-7912-4942-b313-20f29213773c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4046e5-7912-4942-b313-20f29213773c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-08-24, Krzysztof Kozlowski wrote:
> On 22/08/2025 12:30, Marco Felsch wrote:
> >> The binding does not list ports now, but lists hard-wired devices, so my
> >> question is now: is this per hard-wired device or per port (even if port
> >> is hot-pluggable)?
> > 
> > Sorry but I don't get you. The binding lists the regulators required to
> > enable/disable the hub downstream port VBUS. These regulators are
> 
> Is the port an external facing connector or a hard-wired USB device
> (please read the binding)?

It's completely irrelevant isn't it? The host is in charge of enabling
the VBUS supply via a dedicated GPIO (e.g. a I2C GPIO expander). If the
VBUS is off, no device appear, if it is on, the device gets powered and
appears within the system. If no device is plugged yet and the VBUS is
enabled, the device gets enumerated immediatly.

Normally the VBUS supplies are controlled by the HUB control signals,
but unfortunately our design didn't used these and yes in my case it's a
hard-wired device.

Generally speaking I don't see how this will make a difference for
hard-wired or hot-pluggable devices.

Regards,
  Marco

