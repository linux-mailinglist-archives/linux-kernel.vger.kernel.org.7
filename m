Return-Path: <linux-kernel+bounces-889912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A46C3ED0A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA001882F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53414309EE3;
	Fri,  7 Nov 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imw/8Vrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D7171C9;
	Fri,  7 Nov 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501845; cv=none; b=IFaGjkwtGwY59+WHQxgEaEzhQWrLtp+2kxdldW0MUWbFO5bXjQsnl3BTZ+ngs9AvuYPMZGgtavprH6q1Lvds6BzXZfDYDDuDnx+QJjqTY/uWIgdvRRKs32Y0h6D8WkEJQtm4xiiCEav5/242o6ZEF8OilWgy9NG5eaOgrH5W7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501845; c=relaxed/simple;
	bh=ZXzKa8ciq7q/j+7BGMdEknERpfHO5K+oFihg98YcdwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvv29ZNJ4vTgvb2270MqJs47Vm+UasRYaTkpVUjVofye7SWfl4Ve/7Mv/nNwfbnoyx3M105XpOoOmVcFj75V7gcBGV+XpUEDLp2WNvmoiM67sbydQrGwGnUgYqZLz08LAfASx7nbM3CCR7isbqJm9EAw9UD1ELMEiiwS6dVfxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imw/8Vrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3410C4CEF5;
	Fri,  7 Nov 2025 07:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762501845;
	bh=ZXzKa8ciq7q/j+7BGMdEknERpfHO5K+oFihg98YcdwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imw/8VrnU5YGb2Z8C1CEjEKTn4GkSaIhA7J8yV/eZA0dJRdpIux3cmE/ecgKoVBgU
	 CUfNPW/R2B/3WL+/Wvix8Jwvf28ryX9hpbt+zY2T0P3HkOMqVrfinGx7MJObmHCuEu
	 OE3y5C6iH6BNc3U/em1VvLF4O75Ph28WcDQ0nuyVkPf034qPlCUn+kDpdWVRN8u5GJ
	 pD1jV+oHOZ7PMrEfMPsuhui25OKYFQ0lGPgoajkdOy4yWhUZu8w05jRgdcxB79v41b
	 UyII87fQxMwE2M7tt49BGYWbw8RAFrYHl0s1DeYxYpHLUpdy+HxcOHXnSCk3bIGHiW
	 7nPCcLuLAhRMw==
Date: Fri, 7 Nov 2025 08:50:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, louis.chauvet@bootlin.com, 
	aradhya.bhatia@linux.dev, devarsht@ti.com, praneeth@ti.com, h-shenoy@ti.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/5] dt-bindings: mfd: syscon: Add
 ti,am625-dss-clk-ctrl
Message-ID: <20251107-ambrosial-soft-grebe-ebaa3b@kuoka>
References: <20251106141227.899054-1-s-jain1@ti.com>
 <20251106141227.899054-3-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106141227.899054-3-s-jain1@ti.com>

On Thu, Nov 06, 2025 at 07:42:24PM +0530, Swamil Jain wrote:
> From: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> The dt-bindings for the multi-function device (mfd) syscon need to include
> ti,am625-dss-clk-ctrl. On AM62X, AM62A and AM62P devicess, the display
> controller (tidss) has external registers to control certain clock
> properties. These registers are located in the device configuration
> registers, so they need to be declared using syscon. They will later be
> used with a phandle in the tidss node.
> 
> Fixes: ad2ac9dc9426 ("drm/tidss: Add support for AM625 DSS")
> Fixes: 5cc5ea7b6d7b ("drm/tidss: Add support for AM62A7 DSS")

Adding missing hardware is not a fix. Drop both.

> Cc: stable@vger.kernel.org

For sure not a stable commit. You just add new hardware.

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

With these fixed/dropped:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


