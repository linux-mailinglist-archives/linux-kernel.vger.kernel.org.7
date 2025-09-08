Return-Path: <linux-kernel+bounces-805201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B9B4853B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE57717BD7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1F2E7F21;
	Mon,  8 Sep 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj1L94fI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE82E1F11;
	Mon,  8 Sep 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316594; cv=none; b=aX45Ou4577kkn5lJT7MnRxDLUN5osnui9C3Apd2exQryYtOOGUzhA+jtEp664BTm78xwWBHaCVLOmepu73v135jiPyqok7wQo0jRdFcF4sLX2z2HMooaCjxFDWDcioy0/yPJN/lj6Yw5sRyTgxMvfyEPadFsYA6NhpaCX5LWm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316594; c=relaxed/simple;
	bh=JKJZKG96bHSPUzS7MGEeMQmHm9d6eIOzuYNf3OQR2W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8imTfTYg4e63cXxWB4hJstJlP+DD2zyR1gssq68DOac28O9ScaDox9VgUd1F9sgUSkZhIM0NsIJAap9IlFTVj6XVrCIoGvdq4VPD0PyI66FXMLSzVeuhlTfMidnlpuxJOa9Cjxe1EAtnILKwajSK1IPuTht6lA4kQUKZXEMB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj1L94fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EC4C4CEF5;
	Mon,  8 Sep 2025 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757316594;
	bh=JKJZKG96bHSPUzS7MGEeMQmHm9d6eIOzuYNf3OQR2W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zj1L94fIB/aOlkMqqjv69Dam63SxLkk0C4DDwQglT/fPJle2FUaGfmMgZQia2bXDo
	 2I8e/CvsyB7aKr9XRbmmcHsenqLHKJyds+P0agPOmxMyX+MK3Qd9dj37iTzS5CcyKK
	 nxP0mEH0SfJUUUS9McY482YbVI/CKoe0QwZMZ08aJpGMlnnWIw+afE6LLBacBJTKuh
	 /hEqVQeOZfI+9kuxsrZMYqjPz2/bJoatSFjOOz9mie6qM0zKzqadkjSASj6gfK5FHR
	 Iy25ZyH6ePD4fSg3GlxX52CcNJPvzi5RHxtoH4pjl3yIHzPyrUC7MommJIvBjqgBg6
	 KNeevhZ+4q06A==
Date: Mon, 8 Sep 2025 09:29:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <20250908-azure-heron-of-experiment-9e4fcd@kuoka>
References: <20250908061605.76787-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.de794bf7-6833-4973-a353-90f9e4a06895@emailsignatures365.codetwo.com>
 <20250908061605.76787-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908061605.76787-2-mike.looijmans@topic.nl>

On Mon, Sep 08, 2025 at 08:15:57AM +0200, Mike Looijmans wrote:
> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
> 
> The two chips have similar register maps, but different applications
> (source vs. sink).
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> binding

This does not belong here.

> 
> ---
>

...

> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for HDMI output (panel or bridge)
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  ti,mode:

Conflicting type. There is already ti,mode as uint8. Anyway name is too
generic, so maybe ti,retimer-mode

Best regards,
Krzysztof


