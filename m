Return-Path: <linux-kernel+bounces-889922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB047C3ED73
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FF03A30B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D230F544;
	Fri,  7 Nov 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9HYsZ+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58130EF81;
	Fri,  7 Nov 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502352; cv=none; b=eyFjVmbOVWt07v882r/e616x0dbd9+5UIaLm0HUpXJ5+xQyNSbzS4aZ8mnkA4c9v8htfLXMwLXh2OzEz6Yj6JPLW6qQFRqYNCxFvxNt65IgF68Has17pAyfmkQPwshiCqM5Dw7Bp4iJGs0ZQwtFoEe8TNkW8PaEFa16BQ1XjvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502352; c=relaxed/simple;
	bh=HXlBUhOYIBOJ9oilCjQB+f6cehxoQEttizxFn4B+Cto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhtKYGUMYNo9xX2bqrwt3QVzuGULu8ln9FTNSzkv0J/uhNbqfuya0VII+uSqNZvXjtPxqJrnWjxjEwpp3dr84CRy35yCcD6uc8MCz0q52hzo9GlU/9MVGcvqlNDfSdpvRv5iv+yk3XpnN4xXF5WzpXmZZocCE8faCrG84HGJuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9HYsZ+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259CC113D0;
	Fri,  7 Nov 2025 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502352;
	bh=HXlBUhOYIBOJ9oilCjQB+f6cehxoQEttizxFn4B+Cto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9HYsZ+Lmm9GfC3MxOV1sNLDbn4kenQ73MfZlxKJcIOTUMEYT1652SlE0hPM5aiws
	 aUqi7iyBBJbnaV3/3OHDsI0zF7X2XwRVmjLrNZdh9eNjRhhEvaYykNT3IMKbrkCew3
	 LmHUK1PGarhf+kvLN21wHGwGc2zoLEAmghvd4soPHrURl0RmJhIm+AYXIen1jTolmK
	 t0xhTz2N947fGcHxM+yHue9DvV8u7LY98eeHARZqP4fbnlEhPyDr80cPYMLwcqow+w
	 ydSP3MxnADjXtlQD+RoD07QouakaxyECnijWFoaoEGXDlwoGiwgYByBjH3G+/R4ZW6
	 YFrJizH1yXREg==
Date: Fri, 7 Nov 2025 08:59:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, louis.chauvet@bootlin.com, 
	aradhya.bhatia@linux.dev, devarsht@ti.com, praneeth@ti.com, h-shenoy@ti.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 5/5] drm/tidss: Fix sampling edge configuration
Message-ID: <20251107-sparkling-brown-bison-be7fca@kuoka>
References: <20251106141227.899054-1-s-jain1@ti.com>
 <20251106141227.899054-6-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106141227.899054-6-s-jain1@ti.com>

On Thu, Nov 06, 2025 at 07:42:27PM +0530, Swamil Jain wrote:
>  
>  void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
> @@ -3003,6 +3009,14 @@ int dispc_init(struct tidss_device *tidss)
>  
>  	dispc_init_errata(dispc);
>  
> +	dispc->clk_ctrl = syscon_regmap_lookup_by_phandle_optional(tidss->dev->of_node,
> +								   "ti,clk-ctrl");
> +	if (IS_ERR(dispc->clk_ctrl)) {
> +		r = dev_err_probe(dispc->dev, PTR_ERR(dispc->clk_ctrl),
> +				  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
> +		return r;

NAK. Read previous comments instead of silently ignoring them.

Best regards,
Krzysztof


