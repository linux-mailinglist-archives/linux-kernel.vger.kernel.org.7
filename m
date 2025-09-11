Return-Path: <linux-kernel+bounces-811578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB9B52B28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727787BFEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9C2D3ED1;
	Thu, 11 Sep 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0PtBuTx"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC62D238B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577731; cv=none; b=q9fBJ0jwvCKrb8dvxr1Q7EtLS3O9nItMUKvhNJ55itzc8Ka8vH0iXhX5ZKmrAJfq/ncuBLPkUVI8njQAi5TKzcSPBJnKEsawwPlGpzCOHp5A5uk8iqzQpD1ZfOfdwUbwHID+KjtLsxQtYkzx9Mrk9OemuTJY+/ELIWpn/ZEaATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577731; c=relaxed/simple;
	bh=hDQSlg1SLcKbY3HExQ+HLpGKBuVzQYr13qm+cEmDKSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA/gPM5AXWkgnZVeEuqpkuVi7CUlRO1C17gktGx5tGZHV44m7w+AoUYjca5ZZNnWYZ1KLWbH+iOQhLChLFiDkI8hu0XEE3a6hPIfwC2RcQfIrFvwaLLFqomtOSIVIIWabJlLru1lxgE+a1pYCee9ZcmVx/LCYehHbo7dB0P5s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0PtBuTx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bea50d14-2311-46ad-bb30-9d60a4c5e3a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757577725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K67vmxq2HZ39DJMkybahbBR4YyS9YEseE2GLLOUwTdM=;
	b=Y0PtBuTx+N3QMx+FF8DLSb4fH6nYGf2kr2PqAoRm4c7jqgwWBwoZ6vfRqM1KKMRtc2+k+m
	FcDJ6rQ1Nnb9wDJZXDEmsusCTI3p0t8ddE53Yzsx/oqgV3DznvL6osW9QGcAfreaN88Hqh
	KN4cTzns90E9GUvA22sBnM7mwPIelGU=
Date: Thu, 11 Sep 2025 09:01:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v13 3/4] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
To: Vicente Bergas <vicencb@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 alexander.sverdlin@siemens.com, andrzej.hajda@intel.com, devarsht@ti.com,
 dri-devel <dri-devel@lists.freedesktop.org>, jernej.skrabec@gmail.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lumag@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, nm@ti.com, rfoss@kernel.org, simona@ffwll.ch,
 tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, vigneshr@ti.com
References: <CAAMcf8BfxMJx+5ttEXx0kONP2OYWSLFqEYF6rfVBKoRg5TKZzQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <CAAMcf8BfxMJx+5ttEXx0kONP2OYWSLFqEYF6rfVBKoRg5TKZzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Vicente,

Thank you for the bisection and reporting the issue.

On 10/09/25 16:17, Vicente Bergas wrote:
> Hi,
> this patch causes a regression. It has been reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=220554
> 
> It affects the gru/kevin platform (arm64,RK3399) with the Panfrost DRM driver.

I believe the Panfrost DRM driver may only be for the GPU.

Based on the dts files in arm64/rockchip/, this is the pipeline of the
gru-kevin setup that I understand.

	rk3399-vop (Big/Lite) -> rk3399-edp -> sharp,lq123p (edp-panel)

The setup seems to be using the drm/rockchip drivers for the display
controller and for the bridge.

> 
> When it boots in console mode, the blinking of the cursor keeps the display on.
> If it is turned off via /sys/class/graphics/fbcon/cursor_blink, then
> the display briefly shows each key press presented on screen for less
> than one second and then powers off.
> 
> When starting the graphical mode (wayland), if there are no
> applications drawing on the screen, the only way to keep the display
> on is by continuously moving the mouse.
> 

Okay!

I will have a look through the drivers. In the meanwhile, please do
report back if you find any other observations.


-- 
Regards
Aradhya


