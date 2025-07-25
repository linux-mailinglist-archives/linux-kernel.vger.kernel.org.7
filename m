Return-Path: <linux-kernel+bounces-746283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD3B124E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623CB1CE173E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31A24DCEA;
	Fri, 25 Jul 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVbjN1qY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EA1E766F;
	Fri, 25 Jul 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472977; cv=none; b=X9b3EHdZJsrHfZkvAAXW8puJQGG2xuWVEd8slGfnsJjyTffa+Gm4aUY2lvGL913+7WHaciz/KHIaUcT4kYMqDayf2WQ0i6LoR3Rc+6qZFLoLSwh+H0LXiv2VKRm4y5h2Vcxn4DCOG98+NIRnV+kV2BF3+J9NteDCdXriiu/kMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472977; c=relaxed/simple;
	bh=iiaOefTh/5OENt0FAUBnlV/H3u7UFzargnPQcIltk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHsaIstXn4CRJQ1MgLN4ZqjI4TxK8S+7VBf8rS1kSf5khkL/2CBWe6tPzxAFeAs/kUF9QrKdy59V4/7gAwyUDi3qDtRhQ4/X7sNrVNDF8U0rBU9Gm9x27OcBsUPbSJ70tMiSFOULfGUtH/mG4pcmk+zFqwVK2kLc0a1RJ2VKqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVbjN1qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F26AC4CEE7;
	Fri, 25 Jul 2025 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472977;
	bh=iiaOefTh/5OENt0FAUBnlV/H3u7UFzargnPQcIltk/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVbjN1qYQpdx3muILzzWjaJ8epF/zocVS+xHte3uc11rXp0UKOfQutx6pCwd6k2jI
	 /ceFETJ6jinjHpzAxRShzd4C0pxj9cz0+JdBmf2iF40aVE00Y6uZZeOOxnXwE6qgEs
	 ShCPUz35FvGv07QPUXcPPFdZrjMujnYb+oUK392w90+TIDy9S+Pw5IeDxDV1lo9Loc
	 5FU/ZkWx7NaCjHsiDPK+Qy65LlLqzZPVf6QMNq4yh/+CV7d8F+AG5FTIdfmybeCxFd
	 Q3A1VUbas9Jam1TmzFl1qbAH6vmdMDYSlNZJY8L/7JAgPyDDDPkp5U7/iSmNTn/XEt
	 zMDmFpZeJ3WIA==
Date: Fri, 25 Jul 2025 14:49:36 -0500
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: display: st: add new compatible to
 LTDC device
Message-ID: <20250725194936.GA1731993-robh@kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com>

On Fri, Jul 25, 2025 at 12:03:53PM +0200, Raphael Gallais-Pou wrote:
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> it is incompatible with existing IPs.
> 
> Add the new name to the list of compatible string.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 37 +++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> index d6ea4d62a2cfae26353c9f20a326a4329fed3a2f..546f57cb7a402b82e868aa05f874c65b8da19444 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -12,7 +12,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: st,stm32-ltdc
> +    enum:
> +      - st,stm32-ltdc
> +      - st,stm32mp25-ltdc
>  
>    reg:
>      maxItems: 1
> @@ -24,11 +26,12 @@ properties:
>      minItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: lcd
> +    minItems: 1
> +    maxItems: 4
>  
>    resets:
>      maxItems: 1
> @@ -51,6 +54,32 @@ required:
>    - resets
>    - port
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - st,stm32-ltdc
> +then:
> +  properties:
> +    clocks:
> +      maxItems: 1
> +    clock-names:
> +      maxItems: 1
> +      items:
> +        - const: lcd
> +else:
> +  properties:
> +    clocks:
> +      maxItems: 4
> +    clock-names:
> +      maxItems: 4
> +      items:
> +      - const: bus
> +      - const: lcd

Why can't 'lcd' be 1st so you aren't changing positions? Keep the items 
list at the top level and just use minItems/maxItems in the if/then 
schemas.

> +      - const: ref
> +      - const: lvds
> +
>  additionalProperties: false
>  
>  examples:
> 
> -- 
> 2.25.1
> 

