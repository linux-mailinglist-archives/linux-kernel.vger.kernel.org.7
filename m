Return-Path: <linux-kernel+bounces-829112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD66B96510
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FE31629A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B6266B46;
	Tue, 23 Sep 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ce2sOG2J"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5951F1302;
	Tue, 23 Sep 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637910; cv=none; b=r5WAsnLKsvWqYBnLMhTD8/BZSFr3aXriiKVc5GLYamBDYywhbjKrGSrNAqKxWLgm5jRBa6Ot8SFIVLzyxGsBF5Kd+s82MqQT7QHKsd8tSZfdrtXPS1g4ixZFbLrI9TBoDC44IvNK3W8I7h+5H2l3/b7hslF0G2PzKEH/AeAouBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637910; c=relaxed/simple;
	bh=UIE9q5knFnkbWEcoDAhbnZcYbrZ6c1wOHFYsGRe+8KY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AF+dsz9vOKclTBme+9r/JvCcRuxFeUzOSQASdu5a32z7F6Xo1oaX2Zeo5YMjDKH25YMxxGGqvRtUSoO+CeBMReEgGsSQ1HKSOvnVrp3cghqmkANq2o4GL/+0TeOvJTQCBzWI8E7PMjRAbHNRsUI4QRNPq3islA726D1aWL8HPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ce2sOG2J; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EE06425DBC;
	Tue, 23 Sep 2025 16:31:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCFc-A-Ltmn4; Tue, 23 Sep 2025 16:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758637899; bh=UIE9q5knFnkbWEcoDAhbnZcYbrZ6c1wOHFYsGRe+8KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ce2sOG2Jc2x6MDAuw/bJRIMXtvmfP23c1X+i+vjgjLEN/bNAgz2o7U4/z2Em5XHNB
	 nDQOkVk2j8ey81idbXc+buqkLW9f3wI6jf2eKT6z8+wdt9LfMzLfdXCZlR0XPOai4c
	 T2kp/AtwIaEjyUIbdXBQlWLm1d8j0LRQuCakS4eKfcZtbzzFmj8veg6YELLaq28MuW
	 XgPAFVz3dQRm0o47IJ9VnT5056FAEuYVUulBRFeSTxipOftWblVAzBk7h+Qor6SGl2
	 yHqoMO/GAsWHQu42uoWeK/1EJjaFFWVW87X3K53DhnmNYTzmYcmPhqtKry/7suRJo/
	 N7LSX88stClLw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 14:31:38 +0000
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
In-Reply-To: <38e3a32db8402c1cbf3dc2fdf9f04ac3@disroot.org>
References: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
 <38e3a32db8402c1cbf3dc2fdf9f04ac3@disroot.org>
Message-ID: <a75c7a7aaac1d851d8943c5c20ac31ee@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-10 16:25, Kaustabh Chakraborty wrote:

It's been over a month without any movements, so another bump.

> Hi,
> 
> Bumping to collect some reviews on this series. Thanks!
> 
> On 2025-08-20 14:24, Kaustabh Chakraborty wrote:
>> Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
>> employs a single chip for both touchscreen and display capabilities.
>> Such designs reportedly help reducing costs and power consumption.
>> 
>> Although the touchscreens, which are powered by Synaptics'
>> Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
>> driver support in the kernel, the MIPI DSI display panels don't.
>> 
>> This series introduces a rudimentary driver for controlling said 
>> display
>> panels, which supports TD4101 and TD4300 panels.
>> 
>> [1] https://www.synaptics.com/technology/display-integration
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> Changes in v5:
>> - added missing Reviewed-by tag from Krzysztof in [v3 1/2]
>> - Link to v4: 
>> https://lore.kernel.org/r/20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org
>> 
>> Changes in v4:
>> - utilized drm_connector_helper_get_modes_fixed() (dmitry.baryshkov)
>> - constified backlight properties (dmitry.baryshkov)
>> - Link to v3: 
>> https://lore.kernel.org/r/20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org
>> 
>> Changes in v3:
>> - fixed various dt_binding_check errors (robh's bot)
>> - adjusted commit description of [v2 1/2] (robh)
>> - utilized devm_drm_panel_alloc() and devm_regulator_bulk_get_const()
>> - Link to v2: 
>> https://lore.kernel.org/r/20250625-panel-synaptics-tddi-v2-0-7a62ab1d13c7@disroot.org
>> 
>> Changes in v2:
>> - fixed various dt_binding_check errors (conor)
>> - did s/tddi_update_brightness/tddi_update_status
>> - added check for panel enable in tddi_update_status()
>> - used backlight_get_brightness() in appropriate places
>> - Link to v1: 
>> https://lore.kernel.org/r/20250612-panel-synaptics-tddi-v1-0-dfb8a425f76c@disroot.org
>> 
>> ---
>> Kaustabh Chakraborty (2):
>>       dt-bindings: display: panel: document Synaptics TDDI panel
>>       drm: panel: add support for Synaptics TDDI series DSI panels
>> 
>>  .../display/panel/synaptics,td4300-panel.yaml      |  89 +++++++
>>  drivers/gpu/drm/panel/Kconfig                      |  11 +
>>  drivers/gpu/drm/panel/Makefile                     |   1 +
>>  drivers/gpu/drm/panel/panel-synaptics-tddi.c       | 276 
>> +++++++++++++++++++++
>>  4 files changed, 377 insertions(+)
>> ---
>> base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
>> change-id: 20250523-panel-synaptics-tddi-0b0b3f07f814
>> 
>> Best regards,
>> --
>> Kaustabh Chakraborty <kauschluss@disroot.org>

