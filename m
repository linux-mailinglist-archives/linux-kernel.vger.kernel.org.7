Return-Path: <linux-kernel+bounces-721536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DDEAFCA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29571BC6042
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB82DC33B;
	Tue,  8 Jul 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R4BY5/bB"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5892DC32A;
	Tue,  8 Jul 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978331; cv=none; b=jXf030e1Nz9AGHYJ8MthtuAHNA8KNs5nhArFlPrHUfoVQFrmr1I3otcSNUakPfMhw59vRusZx3fmWGYbNy7Qs/u/oZO+XamKd9wF16FRuROStuy4FEf3JcltPKTSpzJvwSkuSjmWPAC6IecMYUYJNTiAb+IYuNlGRKWs2y4YPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978331; c=relaxed/simple;
	bh=m3NlFxR4LvIYaOU3+ffwQW1oW3SRd9n5Eh97mHzfb0s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1Etq5V9JSCZ8ZJF8SlCmJP4qVcFXX3E8EMRY8AbkgFzVVnfGFO0NL8T/igO8RqlnjXH46oj1dg8ZaD2Rl4E2fotqLqruirmogt4g5iz0RK5vuTypJcl43HmvInQwO0tgYcqJhuWt2tSFemWm2m3+FV0S0VQ0jGUYFPObBdsjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R4BY5/bB; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 568CcZhM1161031;
	Tue, 8 Jul 2025 07:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751978315;
	bh=hZcur9LFX7t+/N/sA1BFuyxXZXMoxqY/UWKGMT3WEt8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=R4BY5/bB1MYOCfb7nzslXKSv8ODwHpq33QV0VoFn8g9oYyskPhervTJfunEZt8bug
	 D92lj8zPjNv0sAItoB3NmTLbNHaw1UgbFA9XuIwdTfyv5Xx5lnKRKKWx3eioEzDCgd
	 DBDzJydxizX64l6/1vc/iBn+npstKWJULi98yo5o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 568CcZ2Q1450820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 07:38:35 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 07:38:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 07:38:35 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 568CcZnR1776084;
	Tue, 8 Jul 2025 07:38:35 -0500
Date: Tue, 8 Jul 2025 07:38:35 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 0/2] Add support for K3 BIST
Message-ID: <20250708123835.x6sedlift3xljzvh@scabbed>
References: <20250605063506.2005637-1-n-francis@ti.com>
 <2e397dbf-ac5c-49d3-8176-2022450bf0e2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e397dbf-ac5c-49d3-8176-2022450bf0e2@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 09:40-20250626, Vignesh Raghavendra wrote:
> 
> 
> On 05/06/25 12:05, Neha Malcom Francis wrote:
> > BIST (Built-In Self Test) is an IP responsible for triggering hardware
> > circuitry tests on both logic as well as memory blocks. This driver is
> > currently being upstreamed in U-Boot [1] (on hold till the dt-binding
> > is approved here) and triggers these tests on cores. This patch series
> > adds the dt-binding as well as a node for BIST on J784S4 and J742S2.
> > 
> > Changes since v3:
> > https://lore.kernel.org/all/20250514072056.639346-1-n-francis@ti.com/
> > - Udit
> > 	- add support for J742S2
> > 
> > Changes since v2:
> > https://lore.kernel.org/all/20250328111439.374748-1-n-francis@ti.com/
> > - Krzysztof
> > 	- use existing common definition (ti,sci-dev-id) for grabbing
> > 	  the device ID instead of redefining properties
> > 
> > Changes since v1:
> > https://lore.kernel.org/all/20241128140825.263216-1-n-francis@ti.com/
> > - Krzysztof
> > 	- move from misc/ to soc/ti/
> > 	- minor property changes
> > 	- drop ti,bist-instance and instead opt for ti,bist-under-test
> > 	- correct example dt
> > 
> > [1] https://lore.kernel.org/all/20250204123147.939917-1-n-francis@ti.com/
> > 
> > Neha Malcom Francis (2):
> >   dt-bindings: soc: ti: bist: Add BIST for K3 devices
> >   arm64: dts: ti: k3-j784s4-j742s2-main-common: Add PBIST_14 node
> > 
> >  .../bindings/soc/ti/ti,j784s4-bist.yaml       | 63 +++++++++++++++++++
> >  .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 11 ++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,j784s4-bist.yaml
> > 
> 
> 
> Nishanth,
> 
> Ok to take the dt-bindings via ti-k3-dts-next branch? Or would you
> prefer to queue bindings and DT changes separately?

The ti-k3-dts-next should be fine here. I dont seem to have anything to
queue on the soc driver this time around..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

