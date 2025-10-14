Return-Path: <linux-kernel+bounces-853981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02419BDD34E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20A074F72F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C17314B7C;
	Wed, 15 Oct 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="zepJoI7h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="RGmrBKkv"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E93148DF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514731; cv=pass; b=iURx7fTPcToU1nd22F/v7cuHGN0jaEPRaP27IktngU+Ba1XQDdxXL8tuu+opX9DvBnPcOKgvKjp3ng2XhULNnY893ikLzsZ2s7PApaJZCJgjme6gOXuwUO+CL9qlQkjdwVBAOiCx06es3I/UPvZh0TiUpdavmKrhsTIo8m0t43U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514731; c=relaxed/simple;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW4+Ioiwb9/3b5dsEi+9qDAbtLNJn+PjpZmq2c/59zn2JUxgZ9emmyCkLK7PbQgvqh+eNbGmGVcL083/N8z+AOX/Si+bx0W38yQr3ThdSVdjohKgWMsftzDozKCwjOR1nHtq1L2u3dDiDP0abhTnuHZvjkEZpm8N/z7LkBIhnPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=zepJoI7h; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=RGmrBKkv; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-61nr.prod.antispam.mailspamprotection.com; s=arckey; t=1760514729;
	 b=rFz6m+6P+Hs70SIimoTjffaxK7KkkGY1Wk5cR7mEo1y8DpxR+vGaw1Ul+SPFgjsri0yBY2mZ0I
	  SaD5vJDWf/TcjrKES3bkfxBT3soQWNeE1iPAkZMnlwVj/gst2/MBp8Qy+T5KERoik8dih9BNWw
	  sDVEIUTHa67S9gq5BVISy5139/OwCWQ61OZbgaoGxj5f7h2omV3Lap0UW7MOEzTtV5J3U1+SVQ
	  WZXi8R4fGcJkkPO5EW9N8FTatjf4C+/EzCweLo8yQYs88LI5abrpux95YMYTv0OJr68+1iT/A+
	  k7Y+I7HRVDLBx4OWo3qlCH0lgrwb5SS9PXrSS5y72Lh5gw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-61nr.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-61nr.prod.antispam.mailspamprotection.com; s=arckey; t=1760514729;
	bh=DRH7iMOTbuY1/iWEix7sZhqd6n/2Tw1ybJZR6DrwRcU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=hv8IetHalDO3QOAs1GNmuVaVp2nX0XYN+jyxgmlKc6NDjv94AyhZjiBPyTSPQF2VZbqdhopqy4
	  6qPaDRY7/iMlAxdgvQdxcYH9iMXK/NhmfB5VD6FjTlDl5qP5hDx7kkwomQlLE/rALLAGe/dVdD
	  oKjCExqnJN2GrtbifRiuy//DIQOqybmqDlRmzntH/BO1fCxH+HMqC15nIjv5MDgAv4PLhsMmdI
	  mlol2DgqGurEptDjOxinEA3vL53Y6hLkIAQ3YhSKhzOekGqgTYgOlv00SS20DK1/3hQE4bCb/a
	  EiSNu6S8RhLggA7wkoKshWSDNXg7kq6+tqbpKaBCF83DJg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=kdy+0w++K99irbhKozpIsd52YcoplzuImJedZzCCHOA=; b=zepJoI7hQJ2/eINEgF+I4hPbs+
	H+O2aANqqa2L+fNErdytYU5S13TkJF/Y0+lpAmnh0VifZKfe243GE/5aQLhi6s9SasqUIM/eiWoEv
	kbf3v5tm+hQZr8u7PcCGo/fTtVeSaP7L5AlER61/GibtlREXmzmabo7D10X6Pgo8lli8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-61nr.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJy-00000002yJv-318u
	for linux-kernel@vger.kernel.org;
	Tue, 14 Oct 2025 20:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=kdy+0w++K99irbhKozpIsd52YcoplzuImJedZzCCHOA=; b=RGmrBKkvWCWAenzMbjO3HDgGK5
	CTfPntjK5yx0X/djbDQ2g1/47OESLQiGjrNdjRkeAB+mwd2KvOZbYCPQ/XITegvdvPLVdX73qQVO2
	ntYr5cUCf89yXjbSwdzTyxkJMyk9NC2YfRaIM/HHdjdFzIMHrPp+OIzwkUkVwrzeHKYw=;
Received: from [87.16.13.60] (port=64127 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJs-00000000E00-22Lx;
	Tue, 14 Oct 2025 20:08:28 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 14 Oct 2025 22:08:14 +0200
Subject: [PATCH v2 3/3] drm/panic: avoid WARN when checking format support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-drm_draw_conv_check-v2-3-05bef3eb06fb@valla.it>
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
X-SGantispam-id: 58b95179e40f133486e8c7aed2e284b9
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8lJy-00000002yJv-318u-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-61nr.prod.antispam.mailspamprotection.com;
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


