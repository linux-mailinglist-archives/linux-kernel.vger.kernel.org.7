Return-Path: <linux-kernel+bounces-814190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6CB55089
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FE57C79BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD43101AE;
	Fri, 12 Sep 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZg/tTeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378530FF26;
	Fri, 12 Sep 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686321; cv=none; b=lfAVoTOv+i9OF/hqLrQebq8zgCYht03fG1cBFVFXa2VHGVQcNHtwphZnKPOxp+ElRGTcvIRHLKf255PbICgk7J5XyAkbJeBMCfz3dyKnm7/6sWUEwOoKmqbVp3PV6P9gXufxRENg2IySXzxUYqVQM88WlRQgz2lSZA86o/T12HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686321; c=relaxed/simple;
	bh=LKtdVcB24TA6kT82dIILASuQfzu8Nt31tfoFx3rj/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5mw37O8rI8yQUJMs0pYiuvUzobNjhgd4bssfYTuKrRvilrdK6EsvkoiuLVzZcnEsCZMjbl9PneJ6jE7lZDvcgz0XDIdTPer1nFvRhfuKtGS5XTRu8CrPoBbyYJVKaf5jbec0HeBEHN86F47FtmJB54CBjaflqQH7zIxXYtFy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZg/tTeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D462C4CEF1;
	Fri, 12 Sep 2025 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686319;
	bh=LKtdVcB24TA6kT82dIILASuQfzu8Nt31tfoFx3rj/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZg/tTeqPJMheVhBk4O1oGKCISt2iMzLThJi9ISyIB8Wv3OniEGWPF24vUbwrMgNr
	 7Kh89CsHRNehjT/rjq89QVhDwujgj5COQJNRaQWc+s9Y1R5RtaCQe5o1QuEUmsKDN2
	 MTi/hRjm63tNdAtQJ/7uOTyk34JvRDeCRObtuY4CC2sPvjVfULVLelIGWwg6AlTz4j
	 GS+0k+/sTyo14DQfruH0E6qoJC+t6/4VdRChPXiVVXZtw+ar56QrT/1cKZ3Nxdmwnd
	 PsXWFFsRdwXZxSfXLJcJeFbQfN2Xp364KG9jW0PV1mPix8xszxJhL2jRiLOCMi4g0c
	 5nfDfUV9MOm6g==
Date: Fri, 12 Sep 2025 09:11:58 -0500
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
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
Message-ID: <20250912141158.GA1330389-robh@kernel.org>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
 <20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de>
 <175763620958.1187267.14091957840948870392.robh@kernel.org>
 <20250912085156.h4hhye5vc2rbntyl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085156.h4hhye5vc2rbntyl@pengutronix.de>

On Fri, Sep 12, 2025 at 10:51:56AM +0200, Marco Felsch wrote:
> On 25-09-11, Rob Herring (Arm) wrote:
> > 
> > On Thu, 11 Sep 2025 22:22:45 +0200, Marco Felsch wrote:
> > > Add an usb hub vbus-supply example to make it easier for users to
> > > understand the binding, after the usb-device.yaml gained the support for
> > > it.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/microchip,usb2514.example.dtb: ethernet@2 (usbb95,772b): 'vbus-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#
> 
> Well this is just an example on how to use it, we can drop this patch of
> course.

Yes, but how's it going to work for an actual user?

Rob

