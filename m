Return-Path: <linux-kernel+bounces-771101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7445B282DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DCD1D013BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB822C15B6;
	Fri, 15 Aug 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X+xtf1O9"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169F29E0E8;
	Fri, 15 Aug 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271369; cv=none; b=BeHeDkbTeDo6rOpCKM2/zzuE1mt6anjrYA+2JHz0xNsL+BehblzujeLij7ZmEncTD0VZJvc4Jz3EiFyLJYZ+VKO2AGhFG/w9r0PgVc+r6f03SmlK/U3RVg9FzBXvu0Soz+CdLL49IiFoEKEsat7bIfAoNuGE/q0DirUiOPNLJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271369; c=relaxed/simple;
	bh=10mD2QBpMQ5cGdRHDIBtD/oFcyeohHxEMASeVY3hbMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYzYF+akJ5hKbOvwG11Uq2WjSY00a1P7oirMRNtUwk1JiZiYQeyvJazGeqcV7cQywOTt7CsG9hegaoRYGnqTj/tYcAbhz0kXPI7JeircRGVdWJnYWantfRnqgYK9tOBCUcb2UPjJKw7PdBoATJ2NPbVrzuSsT8B9Wtu5mVnMRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X+xtf1O9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FFMcII2181599;
	Fri, 15 Aug 2025 10:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755271358;
	bh=NP8j7nP6LkL9pUYPoGdT46SLIliAXWeDJDHxTfi5v7I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=X+xtf1O9/+5drBeANW5X6yVmTk05Lo/qM1qa8NLJKXBWajzefcCVQK4+bQti1A/gH
	 v9L+qKUYuiK2rdbPcHsPXwfWHDFtQHUQRP3Rj08jaNfaLM2E96mqWpnj7oelBX0WsT
	 3IaNdyjKEgHJ24smOwpwj3lfsaVNgkcI2TFr1LV4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FFMcJ01698106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 10:22:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 10:22:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 10:22:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FFMcNN1473281;
	Fri, 15 Aug 2025 10:22:38 -0500
Date: Fri, 15 Aug 2025 10:22:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert
 Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>
Subject: Re: [PATCH V3 3/4] drm/bridge: it66121: Use vid/pid to detect the
 type of chip
Message-ID: <20250815152238.culfazudi4le2ykt@gravy>
References: <20250815034105.1276548-1-nm@ti.com>
 <20250815034105.1276548-4-nm@ti.com>
 <e3416746-ee96-449d-8a17-28efcd391c55@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3416746-ee96-449d-8a17-28efcd391c55@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 08:52-20250815, Andrew Davis wrote:
> > This also allows for some future compatibility to be checked only
> > against a restricted set of vid/pid.

^^ See below

> >   static const struct of_device_id it66121_dt_match[] = {
> > -	{ .compatible = "ite,it66121", &it66121_chip_info },
> > -	{ .compatible = "ite,it6610", &it6610_chip_info },
> > +	{ .compatible = "ite,it66121", &it66xx_chip_info },
> > +	{ .compatible = "ite,it6610", &it66xx_chip_info },
> 
> If you will pass in the same data to all devices, just don't pass
> anything. Move the it66121_dt_match table up above probe, and just
> use it, no need for fetching it from i2c_get_match_data().

(rationale in commit messsage)
Yeah, I was going to do that, but this vendor has a bunch of devices and
I am not able to see all possible combinations.. so was thinking that
maybe some combination device will need different checks with a limited
vid/pid list.. just lack of public documentation makes me a bit
paranoid.

I am not tied to this that hard (it was a "meh"), so if folks feel this
can be thrown out, can respin.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

