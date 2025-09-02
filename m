Return-Path: <linux-kernel+bounces-797119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD0B40C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BCD04E463C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850F343216;
	Tue,  2 Sep 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzTJ3i2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05162FE599;
	Tue,  2 Sep 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834193; cv=none; b=SI7NGBSLVolYQgpJCOiuxj2yllqQ3UaTJQoF3Ez4yGRkQxrlAlDS4Eo28waCeQpc6MgOiz+3gHMNhGU6T5Y68u7wYq7bJeDMXqRIkQbJ5iAWfwRTwcthMXmiRR9gxqGEqdKEkGLP9BCric8ZutRf61eA3vFFbjR51nfWubY7qVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834193; c=relaxed/simple;
	bh=QF6rJk+d+yRLqK+RoVOoN40zim7c43Q5kej5dXa9QoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNZBj3Rc5PZw7+rT2ZxcTKg/3pwOM1ZYOm41SitDGrp+dr4WFJj0fMfCW2A7xc122bkOQadgDyEHyMkfDZKFtFcJB9JKf1piXu1Lnta+kDWl0sA8jr11+B81+l6obRs1Q/DUF2OXjFQe6dqhubLnDbJBBkilzR2ISrlIVqmogow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzTJ3i2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4258C4CEED;
	Tue,  2 Sep 2025 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756834192;
	bh=QF6rJk+d+yRLqK+RoVOoN40zim7c43Q5kej5dXa9QoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzTJ3i2QQXTGUw+LwTXV6C0mU7snxe1Z6pJIjDyAbiEIijtpjboMwwpnPMhWLkgXn
	 xmueJgwRfEJ+Jfksjurb8MDmu4mhF6qEmsez7cQb4bwDq1rk6/YoTWhcCcCKfhyivV
	 nClsrvEZ2zAMfRVKBRlnWqKhgD/w112wpHA/H6dmjPUqIrwkfNsYClHo5ISO751MDK
	 s66oq0KyoDP0f+GJb8faogaGBFGFoVrd1ZRuor8BynKDtkUkb+ToQl3Lkny1Fkaudp
	 ez0eHzcbDioIrTIPVgebp2dERuj/GxnPi+4ZB86xjuRsOmIntpXBPFaY+E8copEnKx
	 r5cCM4r4AtJiQ==
Date: Tue, 2 Sep 2025 19:29:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <pml7rfbkerzkx5df26x7kxn3tk2o7oqrkqnx26tzikeg53djn5@islb4hlm4ks7>
References: <20250901142958.843678-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.edc18686-244f-441e-a6ac-0b62492b96c8@emailsignatures365.codetwo.com>
 <20250901142958.843678-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="en5n6wehjgdxg5aa"
Content-Disposition: inline
In-Reply-To: <20250901142958.843678-2-mike.looijmans@topic.nl>


--en5n6wehjgdxg5aa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 04:29:01PM +0200, Mike Looijmans wrote:
> +  ti,retimer-threshold-hz:
> +    minimum: 25000000
> +    maximum: 600000000
> +    default: 200000000
> +    description:
> +      Cross-over point. Up until this pixel clock frequency
> +      the chip remains in the low-power redriver mode. Above
> +      the threshold the chip should operate in retimer mode.

Why should anyone want to tune this at the firmware level?

> +  ti,dvi-mode:
> +    type: boolean
> +    description: Makes the DP159 chip operate in DVI mode.

Ditto. Both describe policy, not hardware.

> +  ti,slew-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    default: 3
> +    description: Set slew rate, 0 is slowest, 3 is fastest.
> +
> +  ti,disable-equalizer:
> +    type: boolean
> +    description: Disable the equalizer (to save power).

Why shouldn't we disable all the time then? Again, it looks like a
policy, and not something that should be set in stone in the firmware.

> +  ti,adaptive-equalizer:
> +    type: boolean
> +    description: Set the equalizer to adaptive mode.

Ditto.

Maxime

--en5n6wehjgdxg5aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLcpjAAKCRAnX84Zoj2+
du5lAYCVEKByvBzuxFqjgUSVXaGA3CZ+VD10s9iZr871K1qm5IlhwpjWlIzrTpUM
n3KXj/IBgLwh3Fikc4FJpI7Rs+Lexry9cSG/dGO+e1hzbPEVUfBONtOdTWvpqTED
QTwwoWD8Vg==
=LfXL
-----END PGP SIGNATURE-----

--en5n6wehjgdxg5aa--

