Return-Path: <linux-kernel+bounces-856131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511CBE32FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33A8B4F3EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798231B800;
	Thu, 16 Oct 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="bREvLixJ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A82E36E9;
	Thu, 16 Oct 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615531; cv=pass; b=eKeRZ55fa/HznnvH6B1BxNC5oCLDnXi3L27L/qsUmHFoau2V87Qxp7zKXzQ+JeU2FFpOiJhXmK9y6drZGO/ie4agOo6/En8mFMofoCeebc3Z0z2xyzMAdCHzRaysSvJzJC23z7HbIp/PwFcM+9aJKbiLksHxyNOm1GAxECECJa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615531; c=relaxed/simple;
	bh=j66SJQar5QnOrEar4/L1Jfi7zP89uDDu8qt/3YJRtrY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aYVCq45Vst00SKEcbfcM2uw0umr5mQ3xWW74rSHm8eJt+5uI1Zcitf2ajifDZouXlwIacySpvYjE1lxy/N0eWpjBC9fjknxqeF3GvKh0AXQhqKqXG8/WnXf7KatWVbklyfDymZaMxOX1Z4QXkGUv4biwR0VuWWH3SX1esF2nv7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=bREvLixJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760615509; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kbUQO9XOk4YmvZgzkU0biflnf9kHyUt7JA6W8uNi4aZt5RXXs9laCNE4mTAUgmFQxbY9CjZ4A4+v/dcN6iDrSR9DuL2RhXWe9V6EYBXkVCUwe3Gfm4nOiE+GEbLDE/mXhcCKshRceftQWjKRdI9n2hlp2WlGzYiWY/NI5WSHmmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760615509; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yCzFxbn7GJVSCGZwCm5WpUYtn8vecoWWAu+Ddkx7Aoc=; 
	b=OZm2uPVUrcaAtJ7BALZXlKlLf+S1ZSzqLfCbjlLLiGFmE7aasX2Yzcdy++fiegpx5Xes+skEpsaOdofwN7CRf8kLdUshDAf4veDpPcTokkQUZkNNVmf6I6y17T8M/sGRsWLNmtEAHCGsyH5bdhINdCgDTauSn84scS2NWTtVX8c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760615509;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yCzFxbn7GJVSCGZwCm5WpUYtn8vecoWWAu+Ddkx7Aoc=;
	b=bREvLixJ7TS1jfVDhk/0b2WbKp/HbS/nHJbPgAohsKIrlKFOW3dOzGCGPDcwJ5Sg
	fy1YkekZzLwebvUiqg14IEkDJzvEbS3bynjEYylaVIaD8gUfnqx28rUrvOEoXyX/ALj
	RL8Nxt+KWW/HyF2d3ouk3XYIrTI2DQdFaTRcWJXY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1760615506978686.2189466745768; Thu, 16 Oct 2025 04:51:46 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:51:46 -0300
From: Gustavo Padovan <gus@collabora.com>
To: =?UTF-8?Q?=22Guido_G=C3=BCnther=22?= <agx@sigxcpu.org>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
	"Jessica Zhang" <jessica.zhang@oss.qualcomm.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"phone-devel" <phone-devel@vger.kernel.org>
Message-ID: <199ecdca3d9.3341649c978102.7928576754342044908@collabora.com>
In-Reply-To: <20251016-visionox-rm69299-bl-v1-1-d3b817ae5a26@sigxcpu.org>
References: <20251016-visionox-rm69299-bl-v1-1-d3b817ae5a26@sigxcpu.org>
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Depend on
 BACKLIGHT_CLASS_DEVICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

---- On Thu, 16 Oct 2025 08:41:27 -0300 Guido G=C3=BCnther <agx@sigxcpu.org=
> wrote ---

 > We handle backlight so need that dependency.=20
 > =20
 > Fixes: 49802972d116 ("drm/panel: visionox-rm69299: Add backlight support=
")=20
 > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>=20

Missing the KernelCI report tag:

Reported-by: kernelci.org bot <bot@kernelci.org>

 > ---=20
 >  drivers/gpu/drm/panel/Kconfig | 1 +=20
 >  1 file changed, 1 insertion(+)=20
 > =20
 > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconf=
ig=20
 > index 407c5f6a268b..59f5a31f3381 100644=20
 > --- a/drivers/gpu/drm/panel/Kconfig=20
 > +++ b/drivers/gpu/drm/panel/Kconfig=20
 > @@ -1112,6 +1112,7 @@ config DRM_PANEL_VISIONOX_RM69299=20
 >      tristate "Visionox RM69299"=20
 >      depends on OF=20
 >      depends on DRM_MIPI_DSI=20
 > +    depends on BACKLIGHT_CLASS_DEVICE=20
 >      help=20
 >        Say Y here if you want to enable support for Visionox=20
 >        RM69299  DSI Video Mode panel.=20
 > =20
 > ---=20
 > base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a=20
 > change-id: 20251016-visionox-rm69299-bl-7e6a2e30626d=20
 > =20
 > Best regards,=20
 > --=20
 > Guido G=C3=BCnther <agx@sigxcpu.org>=20
 > =20
 >=20


