Return-Path: <linux-kernel+bounces-767452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988FB2547D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F32A618B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD942D836A;
	Wed, 13 Aug 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nD6lOj/K"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30912FD7AD;
	Wed, 13 Aug 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116687; cv=none; b=g9iMgfs2yZ+7qKh5xvD5sfyxlHA4whm2isetGCm2aOytyeWSb8M3EaAzzHbMknr1hukTM0ordCiblF3/PXKtTqj4jjLttc6iOgnyWskaarYtJnfaeUjA0UE9EqtbGlEANT8wB2CRDKTIuplRGDWX/SAgMfpxScU3FIiuoH472sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116687; c=relaxed/simple;
	bh=WoiaUzISSM+mbdNp3aZkM22wMVSN+AyQ/HZ7yyxmqvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVuBz2bOboqNuKlKOQulARumRGcUB/Xy8mFWe2cAmdEVbX9LyD6Ip31Pa3kMEE6LRrEuYeJMOiO1V6PckQWCjJfSS/SUT1ZM7JSRXfEfw4I38oZC0C86LBBGe6ax+dRUFm+Wk0/LPpljRcr9kG/3GEvWeRPrUBjDyXpII1ZTvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nD6lOj/K; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DKOY7I2151908;
	Wed, 13 Aug 2025 15:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755116674;
	bh=blSyGf2qTEmaa6tvJvPYehinH7UoKZNENIW1ywwYV/4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nD6lOj/K6byJgAM1e8g6SgCOh/0s1PNxOCYo+dyio05hr0+FtxqM8GHOm7rFNUfGu
	 aBfnaiZwuJAZPa0T96AkIEtE7eSmd54+5Js5i+wG163PVDC3CR3a7HWo+8p7usD+GJ
	 aAbM/iibJaqr6HPRpdr766dEU2c59A96/5e8K/6M=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DKOYAg1320685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 15:24:34 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 15:24:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 15:24:33 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DKOX2k2530974;
	Wed, 13 Aug 2025 15:24:33 -0500
Date: Wed, 13 Aug 2025 15:24:33 -0500
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
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 0/2] drm/bridge: it66121: Add it66122 support
Message-ID: <20250813202433.lsfiggziuzqjtfsq@passover>
References: <20250813190835.344563-1-nm@ti.com>
 <4c6a7db0-dc75-4ed1-aeae-418fa004ea53@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c6a7db0-dc75-4ed1-aeae-418fa004ea53@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:32-20250813, Andrew Davis wrote:
> On 8/13/25 2:08 PM, Nishanth Menon wrote:
> > Hi,
> > 
> > Add support for IT66122, which for all practical purposes is
> > drop in replacement for IT66121 except for the ID register
> > definition.
> > 
> > BeagleY-AI uses this new part as the old part is no longer in production
> > as far as I understand.
> > 
> > Now, BeaglePlay uses it66121 at the moment, but at some point, it might
> > end up flipping over to the new part.
> > 
> > An alternate implementation could be to drop the revision check or make
> > it66121 check include alternate ID check.. but that seems a little
> > non-standard.. Anyways, I suppose mediatek platforms will face this
> > problem as well at some point.
> > 
> 
> Hmmm, since these boards will probably have to switch parts mid-production
> it would cause us to need to have a new DT with the updated compatible
> just for a otherwise transparent revision. Might be better to just
> loosen the PID check so the alternative part work just the same.

I think we can get both world.. respinning this up in v2

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

