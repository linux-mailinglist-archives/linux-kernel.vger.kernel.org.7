Return-Path: <linux-kernel+bounces-776604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65333B2CF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5065C526B02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870421ABC9;
	Tue, 19 Aug 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSusmXNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AA17E4;
	Tue, 19 Aug 2025 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643544; cv=none; b=F/aMLREKwIOh8UrXQg1T4hpjC0/9OW3IjQd1wbv47jxpXM93FwKXpEdrDnCl9E2zOjXjrjbs+bczv9Qv9V/rV8e6cQT6Joxk+rSTN1qqQKSqjH9sAs69OesCnenRSVcQuN7AKv5v/FUosXR1SEF/fkonBcVLYjIcz/PM91Pbds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643544; c=relaxed/simple;
	bh=X0+iUH3kcuJxsm3Ic7boKWg9aLiYyrT0rK3vfD8vqD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvvJAAGey8qO4Bpb9TecbPee61t3zQ7Rr35wDGZ/e5WgWkcTc/FIAOJtrKKGfnh/46U997jRjIu+ccR6na0l+0vWBkv93TIVUz63tOleNaR3yXqBuwUGs7I2o2Er0hwe8LmgO+eVkqprJL+45cWl80KYnVzM/fAzNJZe+pcpFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSusmXNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E2C4CEF1;
	Tue, 19 Aug 2025 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755643543;
	bh=X0+iUH3kcuJxsm3Ic7boKWg9aLiYyrT0rK3vfD8vqD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSusmXNBV2ZghQbDI4agfxaQ9TYHQYWiftWqYLlLpFJK66hQxbO9TrNJUyiX1mDKd
	 Y0Vz0xi73l5CMRDFNhaFu5eD/uI8R7DIJCEUz7TzLTUMj9vsWeZa5Dt7hZNEGmBC/g
	 eUj7nWCCCgxDnQpSmOwPPCgnmXjsaePwFGW6FXxrFR4D/GrLp/ScSaDnfQ+ZTGMRcJ
	 5iDKi+PoCCsdAz5MB+1dSLU8CQ1J6Paf3JI3YP+GVvmlUQ02ztElSdJ15M+GA8bDEW
	 l1u5pYqb0ypP7urNOwz9VSVzfMeQ4/cleS6SWDgxJdH2qFmXIsFH6GTrMR6Z9zXEd1
	 ILjCvfhNqXuZg==
Date: Tue, 19 Aug 2025 17:45:42 -0500
From: Rob Herring <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Support for Synaptics TDDI series panels
Message-ID: <20250819224542.GA1591380-robh@kernel.org>
References: <20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org>

On Tue, Aug 19, 2025 at 08:26:43PM +0530, Kaustabh Chakraborty wrote:
> Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
> employs a single chip for both touchscreen and display capabilities.
> Such designs reportedly help reducing costs and power consumption.
> 
> Although the touchscreens, which are powered by Synaptics'
> Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
> driver support in the kernel, the MIPI DSI display panels don't.
> 
> This series introduces a rudimentary driver for controlling said display
> panels, which supports TD4101 and TD4300 panels.
> 
> [1] https://www.synaptics.com/technology/display-integration
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v4:
> - utilized drm_connector_helper_get_modes_fixed() (dmitry.baryshkov)
> - constified backlight properties (dmitry.baryshkov)
> - Link to v3: https://lore.kernel.org/r/20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org

Where's Krzysztof's Reviewed-by?

> 
> Changes in v3:
> - fixed various dt_binding_check errors (robh's bot)
> - adjusted commit description of [v2 1/2] (robh)
> - utilized devm_drm_panel_alloc() and devm_regulator_bulk_get_const()
> - Link to v2: https://lore.kernel.org/r/20250625-panel-synaptics-tddi-v2-0-7a62ab1d13c7@disroot.org
> 
> Changes in v2:
> - fixed various dt_binding_check errors (conor)
> - did s/tddi_update_brightness/tddi_update_status
> - added check for panel enable in tddi_update_status()
> - used backlight_get_brightness() in appropriate places
> - Link to v1: https://lore.kernel.org/r/20250612-panel-synaptics-tddi-v1-0-dfb8a425f76c@disroot.org
> 
> ---
> Kaustabh Chakraborty (2):
>       dt-bindings: display: panel: document Synaptics TDDI panel
>       drm: panel: add support for Synaptics TDDI series DSI panels
> 
>  .../display/panel/synaptics,td4300-panel.yaml      |  89 +++++++
>  drivers/gpu/drm/panel/Kconfig                      |  11 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-synaptics-tddi.c       | 276 +++++++++++++++++++++
>  4 files changed, 377 insertions(+)
> ---
> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> change-id: 20250523-panel-synaptics-tddi-0b0b3f07f814
> 
> Best regards,
> -- 
> Kaustabh Chakraborty <kauschluss@disroot.org>
> 

