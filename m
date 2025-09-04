Return-Path: <linux-kernel+bounces-801448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAFB44513
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC541753C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20097341AB6;
	Thu,  4 Sep 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lkwn5rHT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F21341ABA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009363; cv=none; b=lWRgwUqboyEuaSh0mWqqBHxPC2i2pNDtARFAgCP2svd5rvvizwyy2BVYPdqI+EwzH5bO6dIUIns54dTjSYS2BMoIdaPilYWJuV9S4mZ3oM0mtWIQ485x35O095Y1Mt+ky4Mq2Qs/UuXESEo4jR7z6BkbylZu7CZyB984sfPL6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009363; c=relaxed/simple;
	bh=Q2/sqo2WoFcIgK4EVR+SzLvrZPSrSSUwKZWja0V75dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc5SSPawYfJTK3lhcNjDuwiMobmGbxv5jWb7Zv7VWav13ZkfaAwNrOHaTeVtlf9ttbHJ4UXkdJvjkwT+zeLrnHcyLAcBOZLan/eqMSUGa6cfMyau1M/Gq5WVmmK17GDX3RW1bOCckW+23cM9AIdHqAObWDqfhI1y+ap7kNQisa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lkwn5rHT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <cc56d7ae-3db1-4a66-a37e-9f158f48fcc1@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c7bQ62LJgjsodas2YkaiakkM4FUOlpkIS38WMP95RY=;
	b=lkwn5rHTQUEiBEjeECfS7kOkJ/45tehiee9Ceh0NNCwq4tA+L7OjQw4baLu+fVxz3DEl/Z
	se2xwfHn/BtSybyQFP+VubAOmXk7QryCYPtGX7L0MoCJhKwdQPIG5xg9rBs2c/fOd8ZHAX
	sDF3KdqGkiZP/hz7ld9zI4sgNQQAOVFr3bApxM2YwKLCJbV67abXNzJXUOVq5IhSHtjlR4
	sU+tMExWHwwuoJO4nahLXzssWnEu7DNyGIr2VkUMfTqZ9pMtpmYMUlqtkYZK/7jIvR6qGy
	n7sv7EnwPoZCRj9ORJExL6RWQ7qdPSDd4w8VARZP0zDD+5w4uDjUjMFjOdhOLQ==
Date: Thu, 4 Sep 2025 20:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 08/10] drm: panel-orientation-quirks: Add GPD Win Max
 (2021)
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-9-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-9-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> Right side up, DSI-1, 800x1280 screen.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index e7a2c5b59d28..75a8c4532434 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -327,6 +327,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1619-01"),
>   		},
>   		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* GPD Win Max (2021) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1619-03"),
> +		},
> +		.driver_data = (void *)&lcd800x1280_rightside_up,
>   	}, {	/*
>   		 * GPD Pocket, note that the DMI data is less generic then
>   		 * it seems, devices with a board-vendor of "AMI Corporation"

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

