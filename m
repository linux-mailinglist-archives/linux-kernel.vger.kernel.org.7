Return-Path: <linux-kernel+bounces-842451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53113BBCC18
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3565B188E501
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC98264A92;
	Sun,  5 Oct 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="I13tSTBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="brOnScoF"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19513257859
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697590; cv=pass; b=mmVr7BKfoYUvsjJACrEtpkmnUmMnqdgqRwhJKvwMUMtsgiKiCrtZ7Os46loRAoqvlWPivOsLAQXvCagVvgmhzXBXnnBZZTECW6O6uB9TtoqDVi21ZOoW4bZNBhvHIO0ESQbBCkFBDzvxzUIZxeLDw1neUZVf2IZ55SrJmoNr6FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697590; c=relaxed/simple;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoTaWY5z/MgAQBut4ANDdZ62NECgkKYj1nkPV8WsLtMt12rKutHqINEWRN9/REIillnK3esahkZjDTiP+bppmFG02gJ/cRT8fAYxxDpkBaU5BNbdq+ohDY/7MMR21asCdE/yP1rL9Bcvq1meF/ELsAy0awXw2NlJoHFl8XRrPOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=I13tSTBV; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=brOnScoF; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759697589;
	 b=UnSJUkzmZ9x/s2ubVjhjvvoNklrtlo3DoRLWmMrGt1fvfGEbvEkRbBO4PysgGkwNcn1BTDl1bC
	  HNtqfVQPHD80bkaZ+pmBXa6cid1uAP5dfPfOy88ao3G40zql0+oKsmPRDbJsolCRwLZHzos0RD
	  kvWQpxn3ca74yorEQ35h9+Mb/CRYu8DfgSTyL2BYTGirBCKu1DtGbtjEoe/yPRwFt9fih4Dydi
	  v19Q1uOj8TtKN7g20dsA6wpYYAQxfa3YYMdLpa4pwRsXcFy+gCiT+UmKnkn0vUmLhD+axs/1FT
	  4UM+H80pSp7M6G1ucrAcKjs0GC1NAdNRC2Vpdyvxztir1g==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759697589;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=AlNO/adCv1ONCEHPkFaZc4xbQe+J7wGh5h/nkGYXpaaJm392otqD1ylC5wY7gzZacCf+CpoOqP
	  qeDcwJGoz2D5OyCfG4TT8Aplp0ygYoxUJlAYWNDI3xWS7v+06EO/iK7yxtObBLLCg9StmvCY/+
	  Zqtoec5/Qpz2pcfUyG2Z9CbcJRrnw1A5j9ccN/LDsFRLIxao1q1evgVoXhgGFKUxJ2uIitMViq
	  K4WhM4PmOwt4soi9tMy3c7VzYDpdb8aSKm3FM8Rt5iov5rRBCy4LyPY65gZRd8WeGlc6pC7Uxj
	  VcbRgP3ShsfpfHxi4BeWSyiznapy39v75c2WiAnwLAy3yQ==;
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


