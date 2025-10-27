Return-Path: <linux-kernel+bounces-871868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EEBC0EA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D02D3B11CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BF625D546;
	Mon, 27 Oct 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="N30VL9c6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0522D7A5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576323; cv=pass; b=PzfNXHcN0JMbFJDWt/05g69eSoXXRNKu6v1pfYD1GriIjMhVYoSW5bMz/HSUwHcEFChrL3TwrYOSbR5uJMIN3mSuDhWyNrKl6BFlW15nA3UOiUY/fa7PzfNg3XDGMCuAi8KEZVfCCnJjfDSU87Ty28pkukq6XMx9j/jL9YlJ/cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576323; c=relaxed/simple;
	bh=xUTsy9NdCobCgLwR+2xt+UrazBZbG42Ld9SJG3JtqLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNXLvd/dBBQcGcXBHYxpNSph9Iuv6+fsW+J9xK2d0ZRYTfEno/Reksval7Ywweo+xLPSm7eRMRRCyvhAVarm6JLx0XwaxOudAmUm10PzE6/MVYu2VBxALsi1T12eZzGfSS/Nl+0ILjdEE+wYpcqknmaGb0Tk5+Sr2KdWdeXA18Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=N30VL9c6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761576285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lTdsw6N0xXzLaD7EGlrs5qL1gxQ9UlbOmXohNYZ3AC4eLnaugKEnyGo1TOnpCjCG86bUCp0eUf3BdyR5rjGWyvmMq7YriKxAUPztPE+wAyx+fMnNHr86Pjf2GWZ20hgHLFwAKwRfOsniymnVswG3vr49JxhvZ5ZajK2uKhLIn2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761576285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oZrYDMRouHneyMB8tCbVdocN1AD7BicDvh/8ht3WR5s=; 
	b=Lnr+Ef4UoyA4ERzapTmeBqzezUXDR3B2t5E7t98SCs8NMYgCpZbwAkT07XAzUhrpZtJrtqlL/yTJyo2R0z+XViCHDvjCTMa8mOYyoZOo70Ow6yvfGb1p7U7KtKyiaWij3wh8uzojttrkJ2FiPrJ3kR1Ow9tk6tPVUlxTi+uBSGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761576285;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=oZrYDMRouHneyMB8tCbVdocN1AD7BicDvh/8ht3WR5s=;
	b=N30VL9c61TjBWFtJhsGNPVwxmPGVzLfWFgwLLqwfVBxi7qKWkCPuX4j5zewqOCFR
	f7nZDE+KZvLLtnG9IMnVcRm3n6Ie80e4Z9957oSqiWS69rk0MuSFgGCnihbQD1O/c5a
	xOgFW3e1SfIUIbseUZPFo7MlAKJ+sgOBZmtPj22w=
Received: by mx.zohomail.com with SMTPS id 176157628274924.30349710427663;
	Mon, 27 Oct 2025 07:44:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject:
 Re: [PATCH v2 0/3] drm/display: bridge_connector: get/put the stored bridges:
 fix NULL pointer regression
Date: Mon, 27 Oct 2025 15:44:33 +0100
Message-ID: <5954683.DvuYhMxLoT@workhorse>
In-Reply-To:
 <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
References:
 <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 17 October 2025 18:15:03 Central European Standard Time Luca Ceresoli wrote:
> A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
> deref regression (reported here [2] and here [3]). Being in lack of a quick
> fix, I sent a revert proposal [4].
> 
> The revert proposal has no answers currenty, and in the meanwhile I have a
> patch that implements the original idea but without the same bug. So here's
> a v2 series with:
> 
>  - the same revert patch
>  - the original patch but rewritten without the same bug (and even simpler)
> 
> Also the re-written patch is now split in two for clarity because it was
> doing two somewhat different things.
> 
> [1] https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/
> [2] https://lore.kernel.org/lkml/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
> [3] https://lore.kernel.org/lkml/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com/
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v2:
> - No changes to the revert patch
> - Added the (corrected) patch introducing the same feature as the original
>   buggy patch, and also split it in two fir clarity
> - Link to v1: https://lore.kernel.org/r/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com
> 
> ---
> Luca Ceresoli (3):
>       Revert "drm/display: bridge_connector: get/put the stored bridges"
>       drm/display: bridge_connector: get/put the stored bridges
>       drm/display: bridge_connector: get/put the panel_bridge
> 
>  drivers/gpu/drm/display/drm_bridge_connector.c | 92 +++++++++++---------------
>  1 file changed, 39 insertions(+), 53 deletions(-)
> ---
> base-commit: 84a0a3f014cda68ff10b8517d09e9f0c1cd942a2
> change-id: 20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-9a429ddb48e2
> 
> Best regards,
> 

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Fixes a null pointer dereference on boot on my Radxa ROCK 5T
(RK3588) that's present in next-20251027.

Kind regards,
Nicolas Frattaroli



