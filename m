Return-Path: <linux-kernel+bounces-731111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F72B04F32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00EB4A4A22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957582D0C97;
	Tue, 15 Jul 2025 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrK6YWYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117940856;
	Tue, 15 Jul 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550749; cv=none; b=dJhjbeQkS1p8qXMU5CHIH5EHYaTcc5yKQY361+4C9t90h0v5pRYRk3kDcZWEe09mwyPzh7qEKwKzCODONKS7ijstYzcF6Rt4F72qdPIfvqbPB1PwR8zddypLBpnUxAWAKapAMKPylB94rF5OrzPWIv5jlSznFI1bwRGSD1t1CUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550749; c=relaxed/simple;
	bh=pg10ZRkdYeFnXEcWEcbRD3J1Z6ySQm+62tlViyEQr5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtqWiR16Y7XWxT8hZS/kAOfp6kioOi8b98sUMszh5Tk8UwGQ+ZbGThz2NjuHXXLlqNwXokaw+yIEmm2r3MIxBKhJczI2SWxugyFWm9qgZAP10mc4IAJzAdQwbt68UyJTndRlcXbBsYa8hE+GDtqTPClycKkKZj4NXeEGp4SXIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrK6YWYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEECC4CEE3;
	Tue, 15 Jul 2025 03:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550748;
	bh=pg10ZRkdYeFnXEcWEcbRD3J1Z6ySQm+62tlViyEQr5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrK6YWYHM7y0MorMV5i/x+xFVHVEhtPLGf//HVYZn11oPkoFPafLs0jagWYUvenc8
	 j9SjLcIGnZaB3NhQAw6CSCcrYRXLEMlImsy3mGvZBnXzjAGUXi0d6k3/TCLyoiCyvV
	 7zIS63H8DGDQd6s1kbswsmeEWZ6OnKwxBfeEpVPE0ll2tWSYUQFi+WP+Zh20fKiLWi
	 kFm1DAyweGqo1mhJWwLQNxO39IZL70ozUMMx9t2cPDYrZLa3PIQeYMIi4umYfHjl2m
	 vBabltEniOHle/HiTiCH1zpIBeNM/O924bbQl5fq8fRQ9bj3YH252Lpd/FDFs/1fqf
	 kl7q0lCdRuJ+A==
Date: Mon, 14 Jul 2025 22:39:07 -0500
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: display: sitronix,st7571: add optional
 inverted property
Message-ID: <20250715033907.GA4184449-robh@kernel.org>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>

On Mon, Jul 14, 2025 at 10:04:00AM +0200, Marcus Folkesson wrote:
> Depending on which display that is connected to the controller, an "1"
> means either a black or a white pixel.
> 
> The supported formats (R1/R2/XRGB8888) expects the pixels
> to map against (4bit):
> 00 => Black
> 01 => Dark Gray
> 10 => Light Gray
> 11 => White
> 
> If this is not what the display map against, the controller has support
> to invert these values.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/sitronix,st7571.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
> index 4fea782fccd701f5095a08290c13722a12a58b52..065d61b718dc92e04419056b1e2d73fd0b2cb345 100644
> --- a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
> +++ b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
> @@ -28,6 +28,11 @@ properties:
>      description:
>        Display supports 4-level grayscale.
>  
> +  sitronix,inverted:
> +    type: boolean
> +    description: |

Don't need '|'.

> +      Display pixels are inverted, i.e. 0 is white and 1 is black.
> +
>    reset-gpios: true
>    width-mm: true
>    height-mm: true
> 
> -- 
> 2.49.0
> 

