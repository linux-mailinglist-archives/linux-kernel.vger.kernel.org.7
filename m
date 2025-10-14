Return-Path: <linux-kernel+bounces-853301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A3BDB296
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CA818A8103
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996A30594F;
	Tue, 14 Oct 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="QZKZ+fv0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="V6892QhT"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D574306496
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472527; cv=pass; b=nH1NpzhUwvn07iLDfNk/9vIwdIGUyNxvrzzkIz7HRFAwG+sibashlETWBSfvQWmMr/uTZHI4OE+lKc3slIyGRYtgH/1+QEQH8oSOUSNMwfyxAsqFBhFkiqAY1F2EkdVyfsSoG5xrVIMsLraBSzp8RlUcvXei4FnXz5/sTuGxRXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472527; c=relaxed/simple;
	bh=47IvIiXfgXszMY+cAV0lSu8Ko5qTBff2hny8UxJ0ZUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQlUgMj27IvcuXeXC8uBBfjd5pWpeFNj+b5ZzzCmZd3WymIXMSaPqmfW9LX8PAexHPVDBxVBycFL8iCcEBKQ18h+X6SnI81jv/lF5gQoVZghdvY+vEqj11ReJB3S1fevId9TV+zRcWBWHYJpdZJj7fwWv2Eb38ZkiN4YzpDkc9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=QZKZ+fv0; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=V6892QhT; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-mc9m.prod.antispam.mailspamprotection.com; s=arckey; t=1760472524;
	 b=dNA/Pz8+dYgLLqUsAOQMpsXzX7FXkEQejctU1QGFpvPQzvUd1sguADvRir9Qiq38KAnIKhOTiF
	  cLxPjR4n5q2yag+wwUzjtZS8o/HK/HtWu33taZLNzZxxVFw5teU8epC0h2SVmz20jmsBHe+0vG
	  m/pvuunOj/liet9x0/efSjAkyIyzcYPcUQVkQHimTn4wy15Wg8CITlEiCfoOOIx301yEgTZ61V
	  Pafzozq0l4eSjakQfkw+Ad3ogsXaM7skrLsXzji2MuOdvWzCsNnJx+W04HDRomW24Fg+kh90uN
	  IG73bhHlF8Da2ZqZ4Afk8qV2GP0ZGC8noMIA8+l/dFI2Gw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-mc9m.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-mc9m.prod.antispam.mailspamprotection.com; s=arckey; t=1760472524;
	bh=47IvIiXfgXszMY+cAV0lSu8Ko5qTBff2hny8UxJ0ZUw=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=gzesvvh2ygUEuvT1qgrNJ2SbU2IQMNmwx2O6X5kN3t/IdQShALVtaHhjmwEFvDAECSF9PyfV5c
	  07GMQnf+gDPI/zUMUVw83F7ffj6wK4Jlu/MMMeESnHOn0jwL6sCHUCfnX0EhT+OoJCqfgfCtQq
	  JDRwhuyzEDxQoRlaJvjj+qfhaYMfIYzUV47cQ+BzkdU45/HBfDd7vePmqilsAWAZOwos1Lv0qB
	  4arlgkfP+nvC0U9K/bDP+Eoz1x+Pf7KiL8eImHwKFYwirnUwBiRjPYTG/BNFqw8lFCDCFsZRAk
	  E9EIYFgdvYKs2iZLk3cZH7JlzfP81HSjfY5VyikOLWmmTw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=bXAG6V6q0Gu2P/Y5b57UaRwcg3Y2X9SQRXNhHXSl2EQ=; b=QZKZ+fv0IQtBBCoX0CKjGUdZGs
	GcFwO938xvtIvUXOOS7b6zvYqY79v38jJhgFQxVhvtO9riR+rRzL+41HiKvd4dcqbKP7jJ1v/3S3L
	aBmq119hw3WaXEI8nd0r3RAi54Vy+I45QoVt2fbVs1MLSqRz+NRrEvmbcvVO8jjrOUVw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-mc9m.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJx-00000001nGr-2vPO
	for linux-kernel@vger.kernel.org;
	Tue, 14 Oct 2025 20:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=bXAG6V6q0Gu2P/Y5b57UaRwcg3Y2X9SQRXNhHXSl2EQ=; b=V6892QhTTdQhHhDDoXiGrBBAZp
	Ea7auEnQac9Xh26Q0y0bmOh78arkoMN9SpvN/RRJJM+3DAmc/SkrPvt4FkmifrObM5Yx0nwW541Xt
	wEeikr9Tderq3CY74WyoRh/LkxsrQEhW4PCLXA9fFiMb4YiR9XneEAz+2bckFQov4XNY=;
Received: from [87.16.13.60] (port=64127 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJr-00000000E00-2EEV;
	Tue, 14 Oct 2025 20:08:27 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 14 Oct 2025 22:08:13 +0200
Subject: [PATCH v2 2/3] drm/log: avoid WARN when searching for usable
 format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-drm_draw_conv_check-v2-2-05bef3eb06fb@valla.it>
References: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
In-Reply-To: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
To: Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 7a943d5c2364b59527b71b88815c7a05
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8lJx-00000001nGr-2vPO-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-mc9m.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Use drm_draw_can_convert_from_xrgb8888() instead of
drm_draw_color_from_xrgb8888() while searching for a usable color
format. This avoids a WARN in case the first format is not usable.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/clients/drm_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index d239f1e3c456397ad64007b20dde716f5d3d0881..c0150f0c3b4b395e6e2126cf0d9660c967c182ec 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -182,7 +182,7 @@ static u32 drm_log_find_usable_format(struct drm_plane *plane)
 	int i;
 
 	for (i = 0; i < plane->format_count; i++)
-		if (drm_draw_color_from_xrgb8888(0xffffff, plane->format_types[i]) != 0)
+		if (drm_draw_can_convert_from_xrgb8888(plane->format_types[i]))
 			return plane->format_types[i];
 	return DRM_FORMAT_INVALID;
 }

-- 
2.51.0


