Return-Path: <linux-kernel+bounces-848361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C90BCD87D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7050C355BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738D23C4EA;
	Fri, 10 Oct 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXpCUjjH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763082836F;
	Fri, 10 Oct 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106720; cv=none; b=FqrtE9EOul1z6YH+QYPtUCVdQ/95j5m9AG3mhzDrV58SR8ZhxfUyvHQ4SBJHic2n2Wejv5DEU93I4ziumIfftW+EpKKWTTyAch4cBmNc/cGNsvbVzH21hk2h77vnHB+IIRGcrziJ5tFQQvJ/4vveqOp7xnwelsJ6hkWdt+d3gl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106720; c=relaxed/simple;
	bh=wEhFTZooq1SoHLK/XSZtmAYLO1RTIgJF4XL0BWpSf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCYmb8yhvaECAA+YMPwHBmD9LRjwUlKl1er48XMT+eTNcjZ0nevIMzGVy01wcNKOWsC31V8R0akvqy+TNkeCmpLIMGkTXf+HGNwPaw/lqJnlTi4tNK7u5mtvAGrXbuzzh4EcMhtHr7Qzag5vz2tVn9ilOHbUDXVeOprWzjTnLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXpCUjjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A4C4CEF1;
	Fri, 10 Oct 2025 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106719;
	bh=wEhFTZooq1SoHLK/XSZtmAYLO1RTIgJF4XL0BWpSf6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXpCUjjH9b/60w57JjvE1ZeBOKiZcpafsYdqPVv+0bN4+mCBf8fyZNgsOzG1MSJoT
	 P81HDDez/i6P/08T6m9e2/P5JQH3TEcTmzHeq5WLMQZj+o6mQhjpEt2rz3wzyj8X3Y
	 aIR5xPdCs3Zs//fY3zOCHI5xdoI2W7PBp99rvspB1EA9oWBODKnvMveUlLGnkZ+7EZ
	 iY1Ztt4jHYz/yxJ+Zh/7antlDGDH7v7sm8xIWGkwaB8l4NdZfiZ3qr4SmKa22Yjt1c
	 mYGuEwetaX1bykkHnzvHQ8/CdGZxgHtqL7kyyDGJWsMRTs2zbz0z7NhQDkAXdiwHTF
	 2+l8nLEhYJcvg==
Date: Fri, 10 Oct 2025 15:31:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: imx8mq-usb: add alternate
 reference clock
Message-ID: <20251010-eldest-padded-98f9852a1248@spud>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
 <20251010-usb-phy-alt-clk-support-v2-1-af4b78bb4ae8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReRyNSNdhTFV+Mx9"
Content-Disposition: inline
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-1-af4b78bb4ae8@nxp.com>


--ReRyNSNdhTFV+Mx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
--
pw-bot: not-applicable

--ReRyNSNdhTFV+Mx9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkY2QAKCRB4tDGHoIJi
0q3mAP9j5GE2F7HQWGUYyOU9k9MhsEyyX3rvlNH5Tnd6R2lBIAD+LQIwhk0KoqWh
PzUa4lYpWpc9tc/dr16rfSTrs9YE8wk=
=mQj2
-----END PGP SIGNATURE-----

--ReRyNSNdhTFV+Mx9--

