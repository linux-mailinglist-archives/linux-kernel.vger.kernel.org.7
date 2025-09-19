Return-Path: <linux-kernel+bounces-825109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCBB8B002
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CABA0194A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AA262FD7;
	Fri, 19 Sep 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U0+4PGeA"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7026E16E;
	Fri, 19 Sep 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307867; cv=none; b=uufQHd81uMYacmqG/u3LmfokCAHsuLdN8WF/JAeLzxkgIRPZ1rxQQEPQ7yncSx8HbF5C5o/ZGDTq8UzGR1cXIAZEZieN4Vi3NXxVKbPLib4E7tN/ShQrgCYm4f4uQhnX1apt9R4MhxRkm1XLBeCrv+YMXGa3TPO911rGaEsnHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307867; c=relaxed/simple;
	bh=x6gy2G+xa01YQQzTPQSurz4mJFhVMxRZroZa5+IK4hc=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=EXgpnFkOg/sUWLYiq7Nfp6UawOBptxEIdhNgT9tpFSQz4tQBGUQfhY5TKgr3OchXWhEFW7CcagOl8nuG63svFY8Q89h5qyjzhdM5qZI/aJE7tm1QhflTr3o9i7HcrtX4J/eAqTmYFBNDGc0tfB8K9vgOVI1XwRAXSgj2hD38pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U0+4PGeA; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58JIoWrV768216;
	Fri, 19 Sep 2025 13:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758307832;
	bh=7UTiup6Y10g60KAI/PbYDXjLaW+SFyw7bFx/SuweNw4=;
	h=Date:CC:Subject:From:To:References:In-Reply-To;
	b=U0+4PGeA5mwPBObl6NurDgnyeuC0OPvJ8HWzOzVgfUGu87uVHgwmTEcxA8gRCZCDG
	 MQ+5aB+3twSC55m0qDpgyYTwWMTSkDxBnAm7m700WFdfA9ce9p1diWjyQdzLkwV7Cg
	 MTTs6BxKdzedEtmONjJ8sY7JnIAYtrXgKmJoMmEI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58JIoV2U2537318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 19 Sep 2025 13:50:32 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 19
 Sep 2025 13:50:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 13:50:31 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58JIoVGn2754111;
	Fri, 19 Sep 2025 13:50:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Sep 2025 13:50:31 -0500
Message-ID: <DCX03UL17R3K.1MRUGNR4PUIDL@ti.com>
CC: Andrew Davis <afd@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
From: Randolph Sapp <rs@ti.com>
To: Michael Walle <mwalle@kernel.org>, Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "Maarten Lankhorst"
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael
 Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org>
In-Reply-To: <20250915143440.2362812-3-mwalle@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon Sep 15, 2025 at 9:34 AM CDT, Michael Walle wrote:
> The TISCI firmware will return 0 if the clock or consumer is not
> enabled although there is a stored value in the firmware. IOW a call to
> set rate will work but at get rate will always return 0 if the clock is
> disabled.
> The clk framework will try to cache the clock rate when it's requested
> by a consumer. If the clock or consumer is not enabled at that point,
> the cached value is 0, which is wrong. Thus, disable the cache
> altogether.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I guess to make it work correctly with the caching of the linux
> subsystem a new flag to query the real clock rate is needed. That
> way, one could also query the default value without having to turn
> the clock and consumer on first. That can be retrofitted later and
> the driver could query the firmware capabilities.
>
> Regarding a Fixes: tag. I didn't include one because it might have a
> slight performance impact because the firmware has to be queried
> every time now and it doesn't have been a problem for now. OTOH I've
> enabled tracing during boot and there were just a handful
> clock_{get/set}_rate() calls.
> ---
>  drivers/clk/keystone/sci-clk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-cl=
k.c
> index c5894fc9395e..d73858b5ca7a 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -333,6 +333,14 @@ static int _sci_clk_build(struct sci_clk_provider *p=
rovider,
> =20
>  	init.ops =3D &sci_clk_ops;
>  	init.num_parents =3D sci_clk->num_parents;
> +
> +	/*
> +	 * A clock rate query to the SCI firmware will return 0 if either the
> +	 * clock itself is disabled or the attached device/consumer is disabled=
.
> +	 * This makes it inherently unsuitable for the caching of the clk
> +	 * framework.
> +	 */
> +	init.flags =3D CLK_GET_RATE_NOCACHE;
>  	sci_clk->hw.init =3D &init;
> =20
>  	ret =3D devm_clk_hw_register(provider->dev, &sci_clk->hw);


Thanks for looking into this Michael. I'm still convinced that it's unusual=
 to
report 0 for a clock rate when the device is powered down. In most cases it=
's
not actually 0 and is actually just in bypass mode.

I was told it's a way to indicate clock status and probably won't be changi=
ng
any time soon though. Ignore the fact that we also already have a separate =
way
to query clock status. :)

This series looks good, but won't quite result in a functional GPU without =
the
following patch: https://lore.kernel.org/all/20250808232522.1296240-1-rs@ti=
.com/

I suppose I'll submit that again on it's own.

Reviewed-by: Randolph Sapp <rs@ti.com>

