Return-Path: <linux-kernel+bounces-767416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD61B253F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DA4E141D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24715A87C;
	Wed, 13 Aug 2025 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1eTEko5"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60762F99B6;
	Wed, 13 Aug 2025 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113578; cv=none; b=l4CwzRYN2fsPcyIspHEzMoMVTi8FhaE4o9p+3Tudl4luEAVxEDBuQ7d91qbOGqXY85jrPKSLNCbD7ADK3D6aTFvOplv3ADzTyV/RjNzgHk+nw+yNAux8Hs/Elje6v24SSa13rL4+5BNyK07FLWtf+SyfgP+bEThQlo3j8Byc2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113578; c=relaxed/simple;
	bh=UoheP3ZVKVuzy/5xTOCBbET/5uwxVm9sgpUlK6W22Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=He4E6jG7H5y+50JIzXeaRmaHnMHfx0lgCyitW31OwkvLQtXzv3UwYdRi/HjV8BktOhI5g6EoWK6KF51EkD3lzXnWUzshhMoA/dBR0GTUodmlynKDEefQEPilFgPNxsuXDADwu+RWXlXMjzGFoaAvbh7Q4z7HGDtpa4x5skIC/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S1eTEko5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DJWmAU1716526;
	Wed, 13 Aug 2025 14:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755113568;
	bh=DP9g1YaqAXl0Ni9gsYFNtLPP9+dGOYc408wFaAfyNxk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=S1eTEko5c2sZbfSUg6KnuhOl17TYUJOCUJlWkOy0ytuw1KEQtzWIYVR/17Zm52U/Y
	 Z4XCh/E1/DuCFmzHizFEZYlEIELlYyR2Fssp6Tbb0E4rAFr6bja9ZlIIgAX3trhAeE
	 PXLDnKHbXe5AaAeWlOWwJID8gzemcIMIqp1SskWU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DJWlfB612929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 14:32:48 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 14:32:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 14:32:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DJWkYE2476900;
	Wed, 13 Aug 2025 14:32:46 -0500
Message-ID: <4c6a7db0-dc75-4ed1-aeae-418fa004ea53@ti.com>
Date: Wed, 13 Aug 2025 14:32:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/bridge: it66121: Add it66122 support
To: Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>
References: <20250813190835.344563-1-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250813190835.344563-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/13/25 2:08 PM, Nishanth Menon wrote:
> Hi,
> 
> Add support for IT66122, which for all practical purposes is
> drop in replacement for IT66121 except for the ID register
> definition.
> 
> BeagleY-AI uses this new part as the old part is no longer in production
> as far as I understand.
> 
> Now, BeaglePlay uses it66121 at the moment, but at some point, it might
> end up flipping over to the new part.
> 
> An alternate implementation could be to drop the revision check or make
> it66121 check include alternate ID check.. but that seems a little
> non-standard.. Anyways, I suppose mediatek platforms will face this
> problem as well at some point.
> 

Hmmm, since these boards will probably have to switch parts mid-production
it would cause us to need to have a new DT with the updated compatible
just for a otherwise transparent revision. Might be better to just
loosen the PID check so the alternative part work just the same.

Andrew

> Nishanth Menon (2):
>    dt-bindings: display: bridge: it66121: Add compatible string for
>      IT66122
>    drm/bridge: it66121: Add it66122 support
> 
>   .../devicetree/bindings/display/bridge/ite,it66121.yaml   | 1 +
>   drivers/gpu/drm/bridge/ite-it66121.c                      | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 


