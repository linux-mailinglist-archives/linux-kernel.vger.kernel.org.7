Return-Path: <linux-kernel+bounces-890455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82519C40181
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2346742376A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054672DCF5D;
	Fri,  7 Nov 2025 13:25:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3E2D7DDA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521942; cv=none; b=u33yWlxWjGr6gJXSyp+UyfOonqW+sDjMQfFWDuCNdq5V+vLCFi0x09S9gBF6X3EHa3gXDP0JtM1Nd+WpvM2qiiV2gluy52ELRodD9+L5Ql0qiCFxUAOUYmrPUnyuwVh1t6zKM140tw4GS7PZPNzNaCq7LH/nhMoDHa54GJ84Jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521942; c=relaxed/simple;
	bh=l/skyXq5y5A8hckZbTNRqPDFHhKZkUpF38SVk2lzWOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rApAOZIckrVYPuYFWT5f3I+qHIbNGF8lYXlZTf5rGN4lRR6foCSBYbpCzfGa/qDA5oC10HCQdVEwsXTHK48jF2ZUQxW76Vcz0Ts909cEZKt+fSgF+2QtYKSsJHPqRNOM5d4fE8NznB/nrss2X4tSB+yf2R3xdWdW0l4SV5tP50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMSu-0003tF-Mg; Fri, 07 Nov 2025 14:25:20 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMSu-007XJl-1d;
	Fri, 07 Nov 2025 14:25:20 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHMSp-000000007QK-1nKx;
	Fri, 07 Nov 2025 14:25:15 +0100
Message-ID: <2841ae5f1f4ccafcbed6c70866d0237b9abdc338.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: reset: add sky1 reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Gary Yang <gary.yang@cixtech.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cix-kernel-upstream@cixtech.com
Date: Fri, 07 Nov 2025 14:25:15 +0100
In-Reply-To: <20251107033819.587712-2-gary.yang@cixtech.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
	 <20251107033819.587712-2-gary.yang@cixtech.com>
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

On Fr, 2025-11-07 at 11:38 +0800, Gary Yang wrote:
> There are two reset controllers on Cix sky1 Soc.
> One is located in S0 domain, and the other is located
> in S5 domain.
>=20
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> ---
>  .../bindings/reset/cix,sky1-rst.yaml          |  48 +++++
>  include/dt-bindings/reset/cix,sky1-rst-fch.h  |  45 +++++
>  include/dt-bindings/reset/cix,sky1-rst.h      | 167 ++++++++++++++++++
>  3 files changed, 260 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/cix,sky1-rst.=
yaml
>  create mode 100644 include/dt-bindings/reset/cix,sky1-rst-fch.h
>  create mode 100644 include/dt-bindings/reset/cix,sky1-rst.h
>=20
> diff --git a/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml b/=
Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
> new file mode 100644
> index 000000000000..72de480b064c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/cix,sky1-rst.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CIX Sky1 Reset Controller
> +
> +maintainers:
> +  - Gary Yang <gary.yang@cixtech.com>
> +
> +description: |
> +  CIX Sky1 reset controller can be used to reset various set of peripher=
als.
> +  There are two reset controllers, one is located in S0 domain, the othe=
r
> +  is located in S5 domain.
> +
> +  See also:
> +  - dt-bindings/reset/cix,sky1-rst.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - cix,sky1-rst
> +          - cix,sky1-rst-fch
> +      - const: syscon

Why is this syscon? Is there anything besides reset controls in the
register space?

regards
Philipp

