Return-Path: <linux-kernel+bounces-846832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378FBC9287
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A23E21CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CFB2E228D;
	Thu,  9 Oct 2025 13:00:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3834BA3A;
	Thu,  9 Oct 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014852; cv=none; b=Viv58H9hW+5tsQ1jpJeiy7sPuw4oqrd2HgUuu2RoxOvM66c9RJiC45P2cVk4y4qwg/aLFlvgp46WLXeX6X2IW6o3WW0TvqaJ+Fqux3ObjhFvEYvM1EhACIAFBCAx/+BX4w/KF1Lmu8wVEXCd7BbWaGh8pwP32q/h+VbbnLIGjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014852; c=relaxed/simple;
	bh=2gf6pqNjzmoPeyJUzHKtZEz8WXFWsv+O++Fdle7Chcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epudcZIqNwXzD9yqcmaauXKKVPP88rxATQ7PGgTaqp4xm5Tk4GtVRUsv2ZJGvnXLJ9EoIZaAKJZ29am0TbyVL1BEg97cE88ruijeMSvydeOXITiHMXaaSFA111IzjwM4x4RnDW7xEQVowFl0bX9JItsrZFCbO3N7s+4kMDtHmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB6F176A;
	Thu,  9 Oct 2025 06:00:41 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23F373F59E;
	Thu,  9 Oct 2025 06:00:44 -0700 (PDT)
Message-ID: <7c3b219f-f504-4c4c-a13a-6a25a0eda277@arm.com>
Date: Thu, 9 Oct 2025 14:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall: make mali-supply
 optional
To: Rain Yang <jiyu.yang@oss.nxp.com>, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.co, simona@ffwll.ch, marek.vasut@mailbox.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Rain Yang <jiyu.yang@nxp.com>
References: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Series applied to drm-misc-next.

Thanks,
Steve

On 28/09/2025 10:03, Rain Yang wrote:
> From: Rain Yang <jiyu.yang@nxp.com>
> 
> Not all platforms require the mali-supply regulator. This change removes
> it from the required list in the binding schema, and make mali-supply
> required for rk3588 only.
> 
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index b220cbd5362f..ef9791d8ed95 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -92,7 +92,6 @@ required:
>    - interrupts
>    - interrupt-names
>    - clocks
> -  - mali-supply
>  
>  additionalProperties: false
>  
> @@ -109,6 +108,8 @@ allOf:
>          power-domains:
>            maxItems: 1
>          power-domain-names: false
> +      required:
> +        - mali-supply
>  
>  examples:
>    - |


