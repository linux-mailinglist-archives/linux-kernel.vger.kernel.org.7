Return-Path: <linux-kernel+bounces-842455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1858BBCC2A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A4E1895828
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EDA1FBE9E;
	Sun,  5 Oct 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="I13tSTBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="brOnScoF"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29851F4E34
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698342; cv=pass; b=QFqcejzkGvR/r5+zdsrJFSKVtm/LUS2GpzO72Wv425ZzYOyCuTSdsKlWrGIuv4oLuSXbMEInoqgaQgpGrOOXctPiEQ/XgelcA5skBqUIj5y5umnuLdJXfm5PAQyj/Y0Re1KuX/ZS/w0BvNqSwcChOw/3JlQvmX5pQuChd+8Zvls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698342; c=relaxed/simple;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7ccVT3vIjO+DgT18h89EupoPRSSffoyyw2ToSi4kkhCa/VIyFvj5IBzDuCoQAneFh6vErRdUiBanZwpPsmhxmMDhDGkKqMmJJWsRLP/hpCNbTF5f0bzUjyn4FXjVieXQnML/vpKkmli4eyXWZi7z8ujgJ0MgWz3hqPMI4VM7dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=I13tSTBV; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=brOnScoF; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759698341;
	 b=E+Pym4jeX+gb5pOK8TT3yfvzYpNgO77ssMhOMjAd9ya3qf0YlKyNsBKryz+D31Icq6P+HqjGnl
	  k28v1DG+zVQRKSq8x4O1gNAb5EWj29iGFqwqPbqRGfTakQtTon31LJl/Lm74sUuhNj6iJMHB4D
	  9s9G38ZedXyNH9F4Jq+F4BdjpXs/VlRoSKNNFleP6laTrIce4tM9gZbXbJCmnL/Q1FNTQRr/mF
	  I2YX0jGSPdCnrIY2YUvwHunpnrtMflkodqBZD7Hm0JB9dfEbVUYomUCGy73VAvR2AfR9rHxs75
	  OGbMFDF+YH7bk1tSLw7lzLbeEX0VWx9hHIQHgwU66ZsdNg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759698341;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=rYGBhxCOtUsrsTOQeHCS5casy3bnnyrnq5WVVcMgi0Ryc4DH9HP44HH1f+ANPJnJjvFh+gZ6d8
	  XgLH5lY8edrn2TSXZOPzRJURDLqh3YlUyaW1Cs13GWLlvL77DM5AnCqyFCd0GnjUf4gcgqTlt+
	  WGkYbyLBSSdqs29lzLx/CrzAxFESKOhFwwtUfC68Iwb4DnrH5bM9Q4N9X5utDlqJkhUJeWvGo/
	  /Oac+UNXWKwNPCfp6e5HdxgB343bvu+FY2IB/ehG+Gt1SkqmKddLrHSEMfQVGfMcQ6poufhgd5
	  rLh+QpzhDhJtJBD5wXr0Ag/TN4STwDFuReBNe4bDxGdDOQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=kdy+0w++K99irbhKozpIsd52YcoplzuImJedZzCCHOA=; b=I13tSTBVgcOD/yrZdcT56fMkVh
	lg4tIiRqQ5lcq+JW7YDGD98WEBHRBP5n8dPky7nMUzyZCOE4KIiZo+iJ03ig7/tN4BObCmeraY2TV
	OTvumvdaNBc7lIXzO+PNPs+pNnnWuA6huMTIs4ZvoM9N4HkQJvePJtR3llwnoKyEATog=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nf36.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VF3-00000008IlU-3lzy
	for linux-kernel@vger.kernel.org;
	Sun, 05 Oct 2025 20:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=kdy+0w++K99irbhKozpIsd52YcoplzuImJedZzCCHOA=; b=brOnScoFUOdb5rfvddxtf6dIzJ
	QHcTzeakvVQYLUxz/aozGCByYNUlSmwYcGNrBEPBwWTVl747lsY0UqnsCF9bL4zP01z00z+BoKYYm
	jcbWemFa9JSI/loZJEGm9J2CmQglfzgg56OW+PWTr7smY/sRT8QLpB5jTxfCMbYFL4DQ=;
Received: from [87.16.13.60] (port=64461 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VEw-000000001im-3ajW;
	Sun, 05 Oct 2025 20:21:54 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 05 Oct 2025 22:21:36 +0200
Subject: [PATCH 3/3] drm/log: avoid WARN when checking format support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-drm_draw_conv_check-v1-3-9c814d9362f6@valla.it>
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
X-SGantispam-id: 2c942ea9770ae9de52d512dd8c6454c1
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v5VF3-00000008IlU-3lzy-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Use drm_draw_can_convert_from_xrgb8888() instead of
drm_draw_color_from_xrgb8888() while checking if a color format is
usable. This avoids a WARN in case the first format is not usable.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1d6312fa142935fcf763381920ad889ca4cf4b27..4ba961e445e576d03cfb58953eead90d32b40151 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -785,7 +785,7 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 {
 	if (format->num_planes != 1)
 		return false;
-	return drm_draw_color_from_xrgb8888(0xffffff, format->format) != 0;
+	return drm_draw_can_convert_from_xrgb8888(format->format);
 }
 
 static void draw_panic_dispatch(struct drm_scanout_buffer *sb)

-- 
2.51.0


