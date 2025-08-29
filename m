Return-Path: <linux-kernel+bounces-791370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92259B3B60B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76B51C27571
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BC2874F5;
	Fri, 29 Aug 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NBtnlWZA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D2212577;
	Fri, 29 Aug 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456337; cv=none; b=Em2G7vIUvxKv/qUOVZqi+FA5rpZDAxSUeCGJ+MfIdIA5an3klgC7UsiLQKyxJPtplxbGx9JZQV9Nnw+JaLn01mr9j2W51VYvkLt8Sm30fUQLc1sfd02QOv7Us7JtX/opF6xpYE+bzjnDLvm70jocOIgaYlKxvAC048ZD9RQaQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456337; c=relaxed/simple;
	bh=D13BED59TY0YL/Ln9OiO8LUjI2j7bDBOhPSj9e11PN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG+Z7//Rp24pY27BMWH6Rso0o1hrwwj6BVx8bxMMUlp900+KAWSkcshRToxIT0anipAQdz00LMZb+PEEtm2mr5EJpN/MYZ2UdAS6OfykphBLl7Mb3ENayb2iW2EsFFAEookMseigoxx+Vl770VcI1TW+EY1y6jEq9R1DepDGKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NBtnlWZA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756456333;
	bh=D13BED59TY0YL/Ln9OiO8LUjI2j7bDBOhPSj9e11PN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NBtnlWZAdNEqgz32lvf0exRIFJItqZQ8torG3lcyTpnUe+mruwJrTov2yauNrnsRk
	 Y36RgdYOZSsXwmn48evOI0n/ikOpXw8vYtKbG2RFjYJFEP/+mJokTi9DDLXp4v91J7
	 r0h4QTBZtqjlI4NBVeLvl+42PyogSW7Qhunnu3vqHfNe15VQFA9GmMIae9itGQtVG2
	 /UlyCeB6NjsQSLnIHMjlJ2PfUCvghU4/rAg2Dlt8OrV0QAW/LDkzV9JfjinNuEONGF
	 dVAGXva+hij7tDuEWERPZHt0suEJb8b1I6+DSjnnBhtgrWVxIj6nr/q+os9kJNQYT2
	 p5CTySamlZ9ow==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6ECA17E0489;
	Fri, 29 Aug 2025 10:32:12 +0200 (CEST)
Date: Fri, 29 Aug 2025 10:32:08 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: add asn-hash
Message-ID: <20250829103208.7d849319@fedora>
In-Reply-To: <20250828201806.3541261-2-olvaffe@gmail.com>
References: <20250828201806.3541261-1-olvaffe@gmail.com>
	<20250828201806.3541261-2-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:18:05 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> The values are written to ASN_HASH[0..2] registers. The property is
> called "l2-hash-values" in the downstream driver.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index a5b4e00217587..258bcba66d1d1 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -85,6 +85,14 @@ properties:
>  
>    dma-coherent: true
>  
> +  asn-hash:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      The values are written to ASN_HASH[0..2] registers. They affect how
> +      physical addresses are mapped to L2 cache slices.

If this is per-SoC integration details, I would hide that behind the
compatible string and have some panthor_soc_data attached to the
of_device_id entries.

> +    minItems: 3
> +    maxItems: 3
> +
>  required:
>    - compatible
>    - reg


