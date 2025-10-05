Return-Path: <linux-kernel+bounces-842454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F3BBCC27
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2FF1892BD6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5C1F462C;
	Sun,  5 Oct 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ySCY/pNn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="eIo8APPw"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564F146D45
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698338; cv=pass; b=EWPg5DlC1Xj+u0NiJQyB0+lXiUhExK4JXm+ZiBFtafn7+PhfDijbEWAN1jsVsEbczV1P3jyNEs/2/pEzGqCMJU5CmmYeDq2g1NNhdh4sLsUGiICMYj+bNwMaEbmAErMsmndH/1C/412auP4dI5fnKHmM+EEoLd5LAFaTlVSnsK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698338; c=relaxed/simple;
	bh=47IvIiXfgXszMY+cAV0lSu8Ko5qTBff2hny8UxJ0ZUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qj/UIpw+OuTAsT4eVZYxpM5HNE90TRRyp9J2zP+HALZ2zLXQCt/Oq7dO2fReo1CFYH5qHaBZsbEIbQeTUdPVkw+HHNN0mZTiW8N413s5vVMGiCDTXZ5dNEhmqb1isX0N8xkzVXRl/AzAzPpHKXd7kEmjTN5+HbbD91GW9bFJahw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=ySCY/pNn; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=eIo8APPw; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759698336;
	 b=WMiPP0wyzzYvhAMhgudrraQiKWK/Co/6lLgupY4D/OcAkkm8qJsdIsSh/gLdtLIpCyiV1lK5QB
	  EuhOFLJRSr9tWL48yl/ZrvFTxFLITcJhOtT2HcxqLmtpRMm1kPbAoFsS6lH+Gic3MlT9S2GtNh
	  3mW5raGfpIC1AzWiAJ4rSoJ0SygGpA8cr5Kd3329v7RTFtHbfwc4ZPooA9BIl9Z8N9PZsCWTEz
	  q7DXMBUWhmur8Ve+jXG6FXw29nLG8WrWhGRY3cf7BH1+mBfZ+/VX+CC8zKziVK5Cv0VeLp5H3V
	  5nQqIyKHidgnyvH4+vcXau+DKY8xeXSGIecGb1Vtjt/p2g==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759698336;
	bh=47IvIiXfgXszMY+cAV0lSu8Ko5qTBff2hny8UxJ0ZUw=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=wxyhPRXPJoXNvaoqrr+fiPGbX0/k2a79upbK1khgBKJLJ/gYgVCw/PBlZh/hS1JMO54OAMp2E3
	  sZ0xzVcCQftfJiCBLw6Ew5p5+goOzFjx892aPOk1pz56/ZgqeZRsk6mvG9ssG0LkQK/iunpWgj
	  aJmAYG56Uxp+TSb9qnFclEEq+bqpQEQnlp9cc3Ed91aIZCrgKqhD732KRxrTSFcFwfcbLmCxSu
	  49rpF6E03qyOuKZ8AJCX30vA0r3oavao0aFE/Op4mc4+sBaQhJhoqYsyss1/cuROcv4yT1uNb4
	  Szg2kiWeCPugNm93duGmA+RuvqjMvq5MDgvTQuRWFg4jIg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=bXAG6V6q0Gu2P/Y5b57UaRwcg3Y2X9SQRXNhHXSl2EQ=; b=ySCY/pNntYuD3l1Ja41jOY3x/I
	tbzx+Rh6FmKgduSYPieTl2sjSmnQ6kNJSPDZ1XaH9sU2m2M7DgaJuZQUwDOeOJlheYyW1CTr/0mmq
	MhWZyk5+X19Ni1zxMyU5cbfn1Pe5WbDoZhW8gqBxl83nuYtLJOtuICunySZ6XrGZ8k10=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nf36.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VF3-00000008Ijs-084U
	for linux-kernel@vger.kernel.org;
	Sun, 05 Oct 2025 20:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=bXAG6V6q0Gu2P/Y5b57UaRwcg3Y2X9SQRXNhHXSl2EQ=; b=eIo8APPwUd+a7hb0bvMXEmvfQn
	iQOBNyA6XEjTKlNNZS68j1e8HF9DZtPNjYe41LAnF3CTzli4Nu4XX9oYfy+d2CINvDWeou26PxawU
	eTMnX6ev6uGoZ6KyJUIG8AOJQ48qQPs+nuAG8eGOuMB8lp5c1s0y0JxGO6wcJOsEvatA=;
Received: from [87.16.13.60] (port=64461 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VEv-000000001im-3olJ;
	Sun, 05 Oct 2025 20:21:53 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 05 Oct 2025 22:21:35 +0200
Subject: [PATCH 2/3] drm/log: avoid WARN when searching for usable format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-drm_draw_conv_check-v1-2-9c814d9362f6@valla.it>
References: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
In-Reply-To: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
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
X-SGantispam-id: c60f707575d8b7054020355cf62fab3d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v5VF3-00000008Ijs-084U-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com;
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


