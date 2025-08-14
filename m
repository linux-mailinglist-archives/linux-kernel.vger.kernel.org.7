Return-Path: <linux-kernel+bounces-768661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F3B263DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A75A9E1F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1642F28EE;
	Thu, 14 Aug 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GXBZcrUX"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C222E1741;
	Thu, 14 Aug 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169587; cv=none; b=dWCKrbiPk4bY3jk5cnlnRlp9LyISyvGYdlZ6DQ3iD2iGW+9OtfTSgLE0wFPL0Cw4iMd06i43aPcXW5ViIQMsXUwKGWcBSAeGMRGz5OjGFTrTfSnX3VNcGaFQpHbky2DJoLqPMVIc/WiLx3t+A6U2PMhARp8WDbk449Rs7UvGEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169587; c=relaxed/simple;
	bh=rT8vpugLy20aEThSawYZskApeynAixeH8erAiCJiS8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX7Vo9By0uabN9VfHfHzPLVq9DmJbG9dThjYz9l6hn+zH0CqZOxifdwnFG806zMR1eNnLhlRVmmUBRS6gaMpIIQv4H2bh8XPyElxMRqTT5duEU49nhPtu/hCMi84r4sHSg7+x50NItUcp4RVzOpOiB+I+1CzLlKp+igX761C9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GXBZcrUX; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EB6ERR1866430;
	Thu, 14 Aug 2025 06:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755169575;
	bh=eXx4QX6GlD1ye8FFz2m4mlJAlk6n+EGxro0PcZGIkPw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GXBZcrUXGbzBJoBc6Y76HkE6W6wG2F8A4R4wVqO2nO8Z0pBUdThZ8Uj7nLXM3WilB
	 CnLYuzm/hs57jA1nA48D1u4WAfArhwZTD53LdimriHiaoWIL9k6qo/WmEzCuc9htvf
	 nbLRGP6IKsOt0NWly2fis7w1lcrynndCIdCyT3AU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EB6E541669453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 06:06:14 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 06:06:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 06:06:14 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EB6EsG3819943;
	Thu, 14 Aug 2025 06:06:14 -0500
Date: Thu, 14 Aug 2025 06:06:14 -0500
From: Nishanth Menon <nm@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@gmail.com>,
        Maxime
 Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>
Subject: Re: [PATCH V2 3/3] drm/bridge: it66121: Add it66122 support
Message-ID: <20250814110614.ziwsadnrxuoxknpk@oxidation>
References: <20250813204106.580141-1-nm@ti.com>
 <20250813204106.580141-4-nm@ti.com>
 <0c684542-aacb-4e8c-a1c0-7fc0da78c733@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c684542-aacb-4e8c-a1c0-7fc0da78c733@ideasonboard.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:32-20250814, Tomi Valkeinen wrote:

Thanks for looking at this closer, Tomi.

> 
> On 13/08/2025 23:41, Nishanth Menon wrote:
> > The IT66122 is a drop in replacement for the IT66122. The part is
                                                      ^^

Uggh.. I just realized I made a typo here -> should have stated: "
"The IT66122 is a drop in replacement for the IT66121."

> > register compatible with what we use of the IT66121. The only relevant
> 
> The intro letter said "practical purposes is drop in replacement for
> IT66121". Here you say "with what we use of the IT66121".
> 
> What does that mean? Are they identical, except the IDs? Or are they

The only difference we had been told at the time about is that they are
identical from operation perspective except for the ID register (I
understand it is some sort of manufacturing change or something that is
not visible to s/w - Robert/Jason could add more).

> different, but the features and registers this driver uses are
> identical? Or different, but only identical wrt. the driver's features
> TI uses?

Minor clarification: This is used on BeagleBoard.org foundation boards
BeagleY-AI to be specific and not on Texas Instruments EVMs/SK.

Personally, I have just looked at the features that BeagleY-AI platform
uses. Though, searching via llms tells me there may be additional
features, but I don't have the specific details to confirm beyond what
the BeagleY-AI platform does.

I am hoping BeagleBoard.org Foundation folks OR anyone on the list who
have contacts with ITE Tech. INC. could probably add information.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

