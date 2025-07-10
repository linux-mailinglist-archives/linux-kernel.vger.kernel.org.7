Return-Path: <linux-kernel+bounces-726553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC79B00E98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C2E1CA40B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3A28E59C;
	Thu, 10 Jul 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP3Hgnd6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F914884C;
	Thu, 10 Jul 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185745; cv=none; b=cC5o3cUVzuSW1feGfMYrrbyi6iiUh2S3DGADT84twF624EA6QAPYtBuD9JcnaLJuKet4XILI54G1w2Z+FlEuT0NVt5pphAItKj+wJniV8hqBbS5WplgfK9rnA/jyzcOKrpLV5ML5kl5GWSWE1LxfH5xxavI75162/fBOGDzFFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185745; c=relaxed/simple;
	bh=XimlN36y4mHX9POztPa8lYF1nw7bUqK+ofyTw7FTAA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s70nWZifcyX9zh70VZxEQulDbOiRF+PsdV4Z3XSJNe//a4zMgAs9EJxPppNxcEJGbZe7mnsskX2hKsUXwPzlt3lpJN6RWFGcqIjFo6DkRLsVeoCyW+xDoWWXqnaHxYKj+ZmSJ4erd6r1rUdLLK/d9JDtLjLLbjKoZc0D9Ynonjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP3Hgnd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EEEC4CEE3;
	Thu, 10 Jul 2025 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185745;
	bh=XimlN36y4mHX9POztPa8lYF1nw7bUqK+ofyTw7FTAA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP3Hgnd6XTz+S+bBceI/7rzVEZIoAyyHmW1pvnSA6JRnfCoYQinQH1oN6LeXm4JJO
	 JQhINTpMn/xhAyUrQQ0pxU2HaqMQ9M+uUWk2TFPHyxkm0IH/nEl5ORLSdLWN7nX+fy
	 o3+Uo5j4ujfy4R99yD6Rnqs+FH61cF4AUapWbf/7pUN2poOJbmI1psi2VfX8RB5YHI
	 IiVQZVKtCsyV7PT6JfLsL3WHwDxFzroem0Dd7NddFBUWfENLkNrEjJXxoVTP8rxYvg
	 tojvrd17IMNZkLbWZ34HquL5QHEyEqISQ2hDOR4cVCXJQEenailk2bdUruJE3i021I
	 IsWwZ13wYgOlQ==
Date: Thu, 10 Jul 2025 17:15:43 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: display: fsl,ldb: Add binding for i.MX94
Message-ID: <20250710221543.GA4115690-robh@kernel.org>
References: <20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com>
 <20250709122332.2874632-3-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709122332.2874632-3-laurentiu.palcu@oss.nxp.com>

On Wed, Jul 09, 2025 at 03:23:21PM +0300, Laurentiu Palcu wrote:
> i.MX94 LDB controller is compatible with i.MX93.

That's not what the schema says.

> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> index 07388bf2b90df..a54b8f1478049 100644
> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> @@ -20,6 +20,7 @@ properties:
>        - fsl,imx6sx-ldb
>        - fsl,imx8mp-ldb
>        - fsl,imx93-ldb
> +      - fsl,imx94-ldb
>  
>    clocks:
>      maxItems: 1
> @@ -68,6 +69,7 @@ allOf:
>              enum:
>                - fsl,imx6sx-ldb
>                - fsl,imx93-ldb
> +              - fsl,imx94-ldb
>      then:
>        properties:
>          ports:
> -- 
> 2.46.1
> 

