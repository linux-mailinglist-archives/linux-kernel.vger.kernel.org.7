Return-Path: <linux-kernel+bounces-814397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D257BB55399
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117CF1D66963
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3ED3112D3;
	Fri, 12 Sep 2025 15:31:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD31FDA61
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691062; cv=none; b=fvC3vqPkC/a9GjtTrUFyk7PZX8tvCmr39wfEU9UijV3TJ57bAwVyq/792+4whGnm7H9jTIZjoCZoUenwC61OGh41659rqqKBsdhRIFg3TlP+DLaxavJ7G2AST05ZtFVVYJO/LhYohZx2C8CfwaHTTg1lSny/OsBTMZHhqQuqRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691062; c=relaxed/simple;
	bh=H0jXXB+1J5btXH4NTziHG1bNKRsdMn8D2kQ0d+XW+mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDocVWQns9K+ozgBaugYnRttS5oIXrToQtFF7v3ejm25bN211KM5xTYaeWHhs3pRtwMQGpWsuJexyeFNmVbdT4X2Mk2zgHUmFrVcKfsd629JNE8lIgvNgYMZ4r81Y0f4dqFDx5V7VzWTRkG+GkAF1AJpLYzjRs9VZ0t56LugVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5jl-0006CG-Vf; Fri, 12 Sep 2025 17:30:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5jl-000xJG-24;
	Fri, 12 Sep 2025 17:30:57 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5jl-0032pT-1b;
	Fri, 12 Sep 2025 17:30:57 +0200
Date: Fri, 12 Sep 2025 17:30:57 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <20250912153057.ovywbksnwq6ganvb@pengutronix.de>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
 <20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de>
 <175763620958.1187267.14091957840948870392.robh@kernel.org>
 <20250912085156.h4hhye5vc2rbntyl@pengutronix.de>
 <20250912141158.GA1330389-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141158.GA1330389-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-09-12, Rob Herring wrote:
> On Fri, Sep 12, 2025 at 10:51:56AM +0200, Marco Felsch wrote:
> > On 25-09-11, Rob Herring (Arm) wrote:
> > > 
> > > On Thu, 11 Sep 2025 22:22:45 +0200, Marco Felsch wrote:
> > > > Add an usb hub vbus-supply example to make it easier for users to
> > > > understand the binding, after the usb-device.yaml gained the support for
> > > > it.
> > > > 
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/microchip,usb2514.example.dtb: ethernet@2 (usbb95,772b): 'vbus-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > > 	from schema $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#
> > 
> > Well this is just an example on how to use it, we can drop this patch of
> > course.
> 
> Yes, but how's it going to work for an actual user?

What do you mean? It's working as you requested:

  hub@1 {
  	compatible = "..";
	reg = <1>;

	device@1 {
		compatible = "..";
		reg = <1>;
		
		vbus-supply = <&vbus_supply_port1>;
	};

	device@4 {
		compatible = "..";
		reg = <4>;
		
		vbus-supply = <&vbus_supply_port4>;
	};
  };

> 
> Rob
> 

