Return-Path: <linux-kernel+bounces-810667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9BB51D95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD0B7AF8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C025C80E;
	Wed, 10 Sep 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QzkQ1Lc6"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5226B75C;
	Wed, 10 Sep 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521550; cv=none; b=KTx23R4RiaCLDAx/Za5M3yll8kRqMnq0HmILh1H4YdOsQxP+qdAw46QkqRHlPW/kfhdtfH6fnS67QQoihXyldUyBLZlYp2YHKXOoS8Rn3VS/OV+oOVmSOF/bwKdWgbnDy2e9u0SAw6sHGuok+gKkFYFGqjOc89vtWAx3OQHGcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521550; c=relaxed/simple;
	bh=yxsZly4e4NNU/BnRyZTfCx+kf32JMESOMXhbZsii9A8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J9MKZwnh0jYQ5+twJM9tgCFaeyMs6Q9WmDOvdmtoRFMpyvbTExkba/7CujIghw5jJ2nhWSgkD+7LiZiTnZYZq9XZ8HSGVc9IRljAbxtObmN75EDyhXDVAEuoPMemA3Uvr6jfdLLJ2yZmY0e4aasx+45xLSfTOoshfO9+bSSkc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QzkQ1Lc6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8CB6B25B19;
	Wed, 10 Sep 2025 18:25:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKyL2TSpdQ30; Wed, 10 Sep 2025 18:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757521544; bh=yxsZly4e4NNU/BnRyZTfCx+kf32JMESOMXhbZsii9A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QzkQ1Lc6ExLEV1/UmoYpaz5DQ71e9J9VxxTTkjjG8Qx3SduHlePv6WK4cb5E+o7cC
	 jqzp40ctssOgp1/HPhaadt3gm69iXskPEkhRD6rMCjXYi+X3rApjYV5av0mrUGeW8s
	 WyZ3c72njeDfFUs7x8NnbW24U8ze9Bp2kiEFXouA8av6Lk6cEdZcroVL5qqftbKchw
	 ZZKEI27gp5M4utH6NJgLSvjspwWc5gIVo7NOjJL4t3aC1rpNXQlrw7SF3yKY/0bcd8
	 9yYUJAaudozmVkfGdUQCpcLU2GgEVCHmjfkT5Ptg9Db3SD+bjfUFDCp5D/1CTDqr0K
	 N87zpNJJM+fuA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Sep 2025 16:25:40 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 0/2] Support for Synaptics TDDI series panels
In-Reply-To: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
References: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
Message-ID: <38e3a32db8402c1cbf3dc2fdf9f04ac3@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Bumping to collect some reviews on this series. Thanks!

On 2025-08-20 14:24, Kaustabh Chakraborty wrote:
> Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
> employs a single chip for both touchscreen and display capabilities.
> Such designs reportedly help reducing costs and power consumption.
> 
> Although the touchscreens, which are powered by Synaptics'
> Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
> driver support in the kernel, the MIPI DSI display panels don't.
> 
> This series introduces a rudimentary driver for controlling said 
> display
> panels, which supports TD4101 and TD4300 panels.
> 
> [1] https://www.synaptics.com/technology/display-integration
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v5:
> - added missing Reviewed-by tag from Krzysztof in [v3 1/2]
> - Link to v4: 
> https://lore.kernel.org/r/20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org
> 
> Changes in v4:
> - utilized drm_connector_helper_get_modes_fixed() (dmitry.baryshkov)
> - constified backlight properties (dmitry.baryshkov)
> - Link to v3: 
> https://lore.kernel.org/r/20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org
> 
> Changes in v3:
> - fixed various dt_binding_check errors (robh's bot)
> - adjusted commit description of [v2 1/2] (robh)
> - utilized devm_drm_panel_alloc() and devm_regulator_bulk_get_const()
> - Link to v2: 
> https://lore.kernel.org/r/20250625-panel-synaptics-tddi-v2-0-7a62ab1d13c7@disroot.org
> 
> Changes in v2:
> - fixed various dt_binding_check errors (conor)
> - did s/tddi_update_brightness/tddi_update_status
> - added check for panel enable in tddi_update_status()
> - used backlight_get_brightness() in appropriate places
> - Link to v1: 
> https://lore.kernel.org/r/20250612-panel-synaptics-tddi-v1-0-dfb8a425f76c@disroot.org
> 
> ---
> Kaustabh Chakraborty (2):
>       dt-bindings: display: panel: document Synaptics TDDI panel
>       drm: panel: add support for Synaptics TDDI series DSI panels
> 
>  .../display/panel/synaptics,td4300-panel.yaml      |  89 +++++++
>  drivers/gpu/drm/panel/Kconfig                      |  11 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-synaptics-tddi.c       | 276 
> +++++++++++++++++++++
>  4 files changed, 377 insertions(+)
> ---
> base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
> change-id: 20250523-panel-synaptics-tddi-0b0b3f07f814
> 
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>

