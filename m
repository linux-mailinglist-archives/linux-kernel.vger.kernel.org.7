Return-Path: <linux-kernel+bounces-708966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6AAED781
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDFF188ED51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAB2459C0;
	Mon, 30 Jun 2025 08:38:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D384242D9B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272727; cv=none; b=QAOrWAYdc+SvYMOnlQgIKWXjFIvk7gYTVmyFo421ioULIon6nqcPQgaNW5jnPXWP4BDYgcN+f+jeAsxYoJwNe+0kTNU6FFbHtATCvLnhl/tY+vli11CtHupycNK5tml79WFeu6D5PbXXZ9tDMf6pWzf+mhIsljc/g4aqGZxLSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272727; c=relaxed/simple;
	bh=GWGc5XkXW057UkUoas7KcMmCELtNfEXEicrspHRhoKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZrc7dz4NSTDP7LXpb+DtRSAl9VyKTkEubTd6fiaKEfy0RvqZzTkdt19biw9FWM0C6QJapVe0yUWGNjv7s/Kwcdgd5Ib8S0q74XJtm/jCYJ/oa9eTBtc4Rw8sY54rNRxDCLtZ3gWAsRyI7fxzQ9/LwaHcBjpqkbaS0pwK5/j8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uWA1w-00011j-R3; Mon, 30 Jun 2025 10:38:24 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uWA1t-0064Zw-1S;
	Mon, 30 Jun 2025 10:38:21 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uWA1t-0007Gn-14;
	Mon, 30 Jun 2025 10:38:21 +0200
Message-ID: <5d4cf5bff7733421c8a031493742ba6a21e98583.camel@pengutronix.de>
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,  Jonathan Corbet
 <corbet@lwn.net>, Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Date: Mon, 30 Jun 2025 10:38:21 +0200
In-Reply-To: <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
References: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
	 <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
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

On Mo, 2025-06-23 at 11:27 +0200, Cl=C3=A9ment Le Goffic wrote:
> Introduce the driver for the DDR Performance Monitor available on
> STM32MPU SoC.
>=20
> On STM32MP2 platforms, the DDRPERFM allows to monitor up to 8 DDR events
> that come from the DDR Controller such as read or write events.
>=20
> On STM32MP1 platforms, the DDRPERFM cannot monitor any event on any
> counter, there is a notion of set of events.
> Events from different sets cannot be monitored at the same time.
> The first chosen event selects the set.
> The set is coded in the first two bytes of the config value which is on 4
> bytes.
>=20
> On STM32MP25x series, the DDRPERFM clock is shared with the DDR controlle=
r
> and may be secured by bootloaders.
> Access controllers allow to check access to a resource. Use the access
> controller defined in the devicetree to know about the access to the
> DDRPERFM clock.
>=20
> Signed-off-by: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
> ---
>  drivers/perf/Kconfig         |  11 +
>  drivers/perf/Makefile        |   1 +
>  drivers/perf/stm32_ddr_pmu.c | 893 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 905 insertions(+)
>=20
[...]
> diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
> new file mode 100644
> index 000000000000..c0bce1f446a0
> --- /dev/null
> +++ b/drivers/perf/stm32_ddr_pmu.c
> @@ -0,0 +1,893 @@
[...]
> +	if (of_property_present(pdev->dev.of_node, "resets")) {
> +		rst =3D devm_reset_control_get(&pdev->dev, NULL);

Use devm_reset_control_get_optional_exclusive() instead. It returns
NULL if the device tree doesn't contain a resets property.

> +		if (IS_ERR(rst)) {
> +			dev_err(&pdev->dev, "Failed to get reset\n");

Please consider using dev_err_probe() instead.

> +			ret =3D PTR_ERR(rst);
> +			goto err_clk;
> +		}
> +		reset_control_assert(rst);
> +		reset_control_deassert(rst);

These can be done unconditionally, as they are no-ops for rst =3D=3D NULL.=
=20

regards
Philipp

