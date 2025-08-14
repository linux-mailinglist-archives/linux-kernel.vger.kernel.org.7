Return-Path: <linux-kernel+bounces-768587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB47B262CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB7FB65BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F22D8364;
	Thu, 14 Aug 2025 10:32:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9B31812D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167565; cv=none; b=G9wFFLlXy6G7IUbtihC0ztsxA8HBjs0pBtHfOEY3XPBbvpJaP323ejqqJ1ryYY95bwIIu0Og8bw1SD/J5b17awFkNykIJgCslTrrRQGM4G+Z7QcRXaUbYi0WRXyq/eNsMRFqSsjIa6LPTlOhrAb2swu5PmpSvM7/07Ae4G4e+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167565; c=relaxed/simple;
	bh=IJ2ngFHMK6odzXZAC5T0LKD77jbBDIgceYrTtjwERts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cW3tCcOtMISG9BUhkv3zkZeDpoIqmLbZiL1NJiMmYoWODw8rLCkXOT02nIOxlaH5OPrJYOQ+cK7A0PcheaAtyzUMpMCbPHQDEnW5c/7paIm0SiwunWlo1lfEijbbk8HKzjc75E/vqcTTejoD9gfVoBNAFCQekMGyEzCPZtLpBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVG4-0007B6-E6; Thu, 14 Aug 2025 12:32:32 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVG3-000Er4-0J;
	Thu, 14 Aug 2025 12:32:31 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVG3-000GLn-03;
	Thu, 14 Aug 2025 12:32:31 +0200
Message-ID: <7939caa888e91270876c9f0616ce92b4651b4e9e.camel@pengutronix.de>
Subject: Re: [PATCH v5 1/2] dt-bindings: reset: eswin: Documentation for
 eic7700 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 14 Aug 2025 12:32:30 +0200
In-Reply-To: <20250725093400.724-1-dongxuyang@eswincomputing.com>
References: <20250725093249.669-1-dongxuyang@eswincomputing.com>
	 <20250725093400.724-1-dongxuyang@eswincomputing.com>
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

On Fr, 2025-07-25 at 17:34 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> Add device tree binding documentation and header file for the ESWIN
> eic7700 reset controller module.
>=20
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/reset/eswin,eic7700-reset.yaml   |  42 +++
>  .../dt-bindings/reset/eswin,eic7700-reset.h   | 298 ++++++++++++++++++
>  2 files changed, 340 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/eswin,eic7700=
-reset.yaml
>  create mode 100644 include/dt-bindings/reset/eswin,eic7700-reset.h
>=20
> diff --git a/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.=
yaml b/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
> new file mode 100644
> index 000000000000..d05a0531dce3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/eswin,eic7700-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESWIN EIC7700 SoC reset controller
> +
> +maintainers:
> +  - Yifeng Huang <huangyifeng@eswincomputing.com>
> +  - Xuyang Dong <dongxuyang@eswincomputing.com>
> +
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in ESWIN eic7700 SoC.
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-reset

Undeclared dependency on [1].

[1] https://lore.kernel.org/all/20250616112316.3833343-4-pinkesh.vaghela@ei=
nfochips.com/

regards
Philipp

