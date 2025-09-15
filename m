Return-Path: <linux-kernel+bounces-817136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C713B57E51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E746C18867C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7230B502;
	Mon, 15 Sep 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CfB0xS4N"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BE1D555;
	Mon, 15 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945046; cv=none; b=dEKdKI9BHSrnH69T3wsEoYdconauB5uYB44l3tMn8gtryHa6SczKAayz8qlisyIzurAmX+qnJCDG4129u8RZCnJwkaW8Den28s8IrKrCnNi1ESygRTRhy7Aor6xwH4mgWs/67b3GOtzsLdSawg9VGNxYXT8Fdyhp/U/QaK0hOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945046; c=relaxed/simple;
	bh=eWz6u+OLFMwxAjalHj6xAB1GU9qKMA/quAvqpVCVvms=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTvS+uqEm8woqwNin/qwXLC7hB7eXXDxMwwfFUHAGua89wrHtlKMR+bb0Ioucip6q7wWOlrA4dFi6xcmYd4k3sV1WNQxUroVQtnuXI/CkoVWfRaZKyD5b+Pyga/QF92WLY14TXIjDcwJ43Wn0aJ/sxHoCaSGwy31Pcyn2C1IJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CfB0xS4N; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58FE3qSi1571392;
	Mon, 15 Sep 2025 09:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757945032;
	bh=WUMySgV2UJ4R7LmsT8uOJ9FTH+QR5Hdqf3nlHKsvkFs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CfB0xS4NliV+IyRK04dpZeEDA08/QbK00on9GoEVIwTDyE3/ebGKFbwxXdPJxOBL6
	 QQr+5Xp9J4L73FD0eSA/UoSLPopdBvbOxCpddXQrbQps8Fgge+yB6HNK08p0SJyJBR
	 pZjwAqYVZy66UD0R4Zk46BfYJXgxSx6JGvL95xDg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58FE3qBs788298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 09:03:52 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 09:03:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 09:03:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58FE3plK3911393;
	Mon, 15 Sep 2025 09:03:51 -0500
Date: Mon, 15 Sep 2025 09:03:51 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
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
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH V5 0/5] drm/bridge: it66121: Add initial it66122 support
Message-ID: <20250915140351.cjegerbuvhezeapt@screen>
References: <20250827202354.2017972-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827202354.2017972-1-nm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:23-20250827, Nishanth Menon wrote:
> Hi,
> 
> Add initial support for IT66122, which seems to be compatible to it66121
> but probably has additional functionality.
> 
> BeagleY-AI uses this it66122 as the old part is no longer in production
> as far as I understand.
> 
> Now, BeaglePlay uses it66121 at the moment, but at some point, it might
> end up flipping over to the new part. Additionally, it also looks like
> Revision D of BeagleBone Black switched over to it66122 as well.
> 
> Series is based on next-20250827
> 
> Bootlog: BeaglePlay: https://gist.github.com/nmenon/65afb917ee1818979d338cf25732a920
> 
> Changes in V5:
> * Switched over to ARRAY_SIZE
> * Picked up Andrew's Reviewed-by
> 
> Changes in V4:
> * Added patch to sort the compatibles alpha-numerically
> * vid/pid lookup is done without using the match_data.
> * picked reviews
> 
> Changes in V3:
> Based on Tomi's and Devarsh's reviews, and searching online (and failing
> to find) for a public data sheet, I have refactored the series to:
> a) Detect the ID by matching vid/pid
> b) Introduce it66122 basic support which seems to work based on
>    empirical testing evidence on BeagleY-AI. This allows incremental
>    patches in the future by someone who might have access to the data
>    sheet to add additional features for the chip.
> c) Irritated by checkpatch --strict warnings, added a patch to fix
>    existing warnings as part of this series, but it could probably go
>    in independent of everything else.
> d) Stopped claiming it66122 is drop in replacement of it66121 :)
> 
> Changes in V2:
> * Picked up Krystoff's binding ack
> * Switched over to a vid/pid list
> 
> V4: https://lore.kernel.org/all/20250819130807.3322536-1-nm@ti.com/
> V3: https://lore.kernel.org/all/20250815034105.1276548-1-nm@ti.com/
> V2: https://lore.kernel.org/all/20250813204106.580141-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20250813190835.344563-1-nm@ti.com/
> 
> Nishanth Menon (5):
>   dt-bindings: display: bridge: it66121: Add compatible string for
>     IT66122
>   drm/bridge: it66121: Drop ftrace like dev_dbg() prints
>   drm/bridge: it66121: Sort the compatibles
>   drm/bridge: it66121: Use vid/pid to detect the type of chip
>   drm/bridge: it66121: Add minimal it66122 support
> 
>  .../bindings/display/bridge/ite,it66121.yaml  |  1 +
>  drivers/gpu/drm/bridge/ite-it66121.c          | 68 +++++++++----------
>  2 files changed, 34 insertions(+), 35 deletions(-)

Since it has been a while,

DRM maintainers: gentle ping. Hope we can roll this to drm-misc-next if
there are no further comments?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

