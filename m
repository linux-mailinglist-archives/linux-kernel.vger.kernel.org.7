Return-Path: <linux-kernel+bounces-774970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5598B2B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2ED7AA1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F92773F9;
	Tue, 19 Aug 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddbjIUdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EF26B09F;
	Tue, 19 Aug 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585866; cv=none; b=TM2pycuV5/FjaqEyjm5SD87SER3ov/3gGF5fn/sk1ZhpSWimVdcgH6cpvh2Y8XvaQLVnOzyJSZ+h75qbPo8giYcGRHIk6HEWxj4PU9yENlWmfECWOWLu/EKY6fRAvg5vKttaFouBxVPQBVtB2mhP0rKJQ118eLaufCQNqo8maJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585866; c=relaxed/simple;
	bh=gx003cAub2W7yI9noj/k+7+A81Ogp/xX+qJqdRrcU2s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Bhd/5Nv7NXXYUOqGFbnWmnoRKtEVnTNjgmdUcEcy971WqKgOycYeL/UUmS1/RI7g7q2p1OrsGTBuPY5IM6f/HSXdfgsAUOp2eVb9wX9LIEhedtKoHQLvFspNZ5opX9yUZ9YRCNLSeM5WEUFXSz9J+C5geNhkDneh5TLKsXTj7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddbjIUdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35178C4CEF4;
	Tue, 19 Aug 2025 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755585866;
	bh=gx003cAub2W7yI9noj/k+7+A81Ogp/xX+qJqdRrcU2s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ddbjIUdU2RFNdE2+pTkxES41YUlBnBeUFYbOrCxL84AHOJ2aaYAMWHvPMXiDKNVUv
	 jSOE/5ZyVxlO+oLZJ7WJaSlBHeq0pmTI8hz/RhwUry6FDC0S9IIiiIxzeSUgPJhPcR
	 Vggsfb0GR2HK/ClAzdLFJgCTn0PSoRsHNlHuGCc7dHSRb8ybKD7oeMvnF+8pWoid0N
	 21BrXg2F/PFV3bcOjW2xsxeXTeisnxuvZoQqdmLgsFY4rufe1cpW5lGvHHBeywHK7j
	 z2kEomYfChxO+Ve4MW9h+fZbmbkKTn+31IwzFyQzk1dj6hcqW1JMJzEYxVF4COL+wz
	 lpc+SJeu/5E/A==
Date: Tue, 19 Aug 2025 01:44:25 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
In-Reply-To: <20250819053205.9976-2-mike.looijmans@topic.nl>
References: <20250819053205.9976-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f1878466-8551-4b5d-bf2e-1706e377d436@emailsignatures365.codetwo.com>
 <20250819053205.9976-2-mike.looijmans@topic.nl>
Message-Id: <175558586542.3297343.1727329381357860993.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings


On Tue, 19 Aug 2025 07:31:14 +0200, Mike Looijmans wrote:
> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v2:
> Document driver specific bindings like slew-rate and threshold
> 
>  .../bindings/display/bridge/ti,tmds181.yaml   | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml: ti,slew-rate: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819053205.9976-2-mike.looijmans@topic.nl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


