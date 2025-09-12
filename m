Return-Path: <linux-kernel+bounces-813477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA900B545FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304977A5BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBE264F9F;
	Fri, 12 Sep 2025 08:52:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087F17BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667121; cv=none; b=QFAUo+ihMb/5eDx2ZXdytHflAb+2N5W70M536vSEgWjvVcxnKOmXaH0p8r+frOcT2w99UASNZ/SA7zdcz7TNi2cgD/YMYUvpRhnSvIZuM4y6C4tBi3mxy2+kku8CmT3YJC/kUKCMNv/Bq9HQsjzPIgD8ueXOeKkmd29C641/u0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667121; c=relaxed/simple;
	bh=ktE1kTyDrk5JmPj+cCcWpFNgeuUkaMmiOQWH3Q77gWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiNRGD5zVWB1LOTK+LT6psSpPd3RfrDSg5SHjvakkVvuu4lJ2CojVJHLEHEAR/cd/dxi1Or5q0VCSP+c8BwMh+HG1E4rgunJo+62RkK7wD1NHF4jRafDq0jAXAOAj5bQnv9qd8MIdQM96mRho+Xo/IlsqbQGIceAAz0IoeglieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzVc-00034e-Qp; Fri, 12 Sep 2025 10:51:56 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzVc-000u66-0n;
	Fri, 12 Sep 2025 10:51:56 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzVc-002xOr-0R;
	Fri, 12 Sep 2025 10:51:56 +0200
Date: Fri, 12 Sep 2025 10:51:56 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pengutronix.de, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: usb: microchip,usb2514: add
 vbus-supply example
Message-ID: <20250912085156.h4hhye5vc2rbntyl@pengutronix.de>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
 <20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de>
 <175763620958.1187267.14091957840948870392.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175763620958.1187267.14091957840948870392.robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-09-11, Rob Herring (Arm) wrote:
> 
> On Thu, 11 Sep 2025 22:22:45 +0200, Marco Felsch wrote:
> > Add an usb hub vbus-supply example to make it easier for users to
> > understand the binding, after the usb-device.yaml gained the support for
> > it.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/microchip,usb2514.example.dtb: ethernet@2 (usbb95,772b): 'vbus-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#

Well this is just an example on how to use it, we can drop this patch of
course.

Regards,
  Marco

