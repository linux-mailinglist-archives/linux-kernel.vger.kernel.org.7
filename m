Return-Path: <linux-kernel+bounces-870667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2AC0B6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BAA3B7F86
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E362FFF9B;
	Sun, 26 Oct 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Zg2YUXJw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="XxFpk6Kn"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F871FFC49;
	Sun, 26 Oct 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519830; cv=pass; b=QIFjxYwnh8ZRLvf4cpYfcGAlzMr+CX+S1fiS3l7xtnrO+WZiCVSPXmDn2KGxxgZRM2IWfgrTEDjd3rMHleOXsLAKZKgDCtLbm9Vhe2KCFY0dcUjrkZ5hb4A6bvEEqj7Mh150G2oNzFYNMP3qUK832heoDuWzsmxojzzppxQOHuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519830; c=relaxed/simple;
	bh=X85Z4DhxPeHwX9zmh4XP31D3/HzYWiFyWUzUtKstvdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+yFYeMKq3Gy2GtKNJHEXYg7fpFIpi85sQrQct8Lpad4tY61cAJFK3FScZqKRNTCi1aTm6okzhkOjWW1stzbvvvgxjonikh9V33S+v2d6si7A4rTgwdhzwLM4+37ZomZhUR/q3jsARbJvT6Jdt5FEVC6kepiNWzxVp9I4nmsiAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Zg2YUXJw; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=XxFpk6Kn; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519828;
	 b=KYKkKC/Bii56pqhCNUkm0nSELnxGh/bvupnGQ6PmwXMH2WtDzFnrojHlOXYJGiGLT5MbURl9t4
	  g+9KVsbi00Pu652HTTKnrRQ7RbcNTnKR+ZmLLZ9LWvtmOzLxfBVUnZo5ABtssBeSYtB6yosuhA
	  7Cf5P7VBm9215q/J6gWKCeWzQLWRSmNOauLmZudF54pyvh1SRptm7wZGJKRBkU+1vD8SgWkS6U
	  Cdc2kKAWyTebFqtm7rIRsItSt16/UcZ8j34gLliwMmGzbGxL7N8v/z1iw8MatN35ifW2YrSwzm
	  M/OPaZ3FCHlXC876nBl8Z0aHCwGfE5TewHrRpRfDmxFO6Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519828;
	bh=X85Z4DhxPeHwX9zmh4XP31D3/HzYWiFyWUzUtKstvdU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=uQRCl5mX2JS7Eq2kykJHfGv9Pk6rxiVfG+jWEjX6qrTOs4BWCB/+0tmh8MWn/UnPrOItVrpeDX
	  j2eI5qFZ3cJERMts/Tj77+NlpoQUfS1c9vuhIZTVo4OLe6lcOylZ+TYsJKacC7NZHJg3/pAIvT
	  oefpplgFB/xDMqYF7t3+kFaiaTkW06UxXAwBaCpeI+b2HCYFqsFH1R9G1VHz+4iy8w45AaDz36
	  uiL0L8VKJMy95YvGKJABJz8GPbp6eGzqppn6GkzlpuVirMZ1lYKaY+K7gOQI0Mw9uRIy1pmiZA
	  lscsFXS2SKl7LuVLQ2DFz0umjqFffp8r6dvdQzorzz1YIw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=9y3uMz1ds+GG7HsxTvljl2MUtAE+FKu5xxJF3oOFGCE=; b=Zg2YUXJwHjfvXHybSZA1bKjyKS
	9HNaLDZojLYSqDKFBwB3whzsrgwJ9Qpcb+aWRnvwaJJbr5nzQwa42x1NP3QiZ31i6zybVfAFmGYx4
	H+cqUtQ3MwXXMP1MszyciCJ4YAvul2rVzO+zKZ+cQthF4OW4rdXOWC+EG7bcfsaphC3Q=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4x87.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9lx-00000002wA9-43f2;
	Sun, 26 Oct 2025 23:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=9y3uMz1ds+GG7HsxTvljl2MUtAE+FKu5xxJF3oOFGCE=; b=XxFpk6Kneh75XeaOaazc0LK8i9
	dGxhpLI4WxmTA9hAjbjEJzFxdzy5JFZR/Zeq+tnwKW4nX5CW8WO+QwichOHs0NRgdrtFQhLeQQgXA
	u/HDY6pi4RoIbSJBYy23BDRfERUqA/yGgllGiPcFbUWqid2WAeJNNbYZ1QRwCnud0ZIw=;
Received: from [87.17.42.198] (port=63736 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9lr-00000000KNm-2ji4;
	Sun, 26 Oct 2025 23:03:31 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 27 Oct 2025 00:03:02 +0100
Subject: [PATCH RFC 2/3] MAINTAINERS: add entry for DRM splash client
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-drm_client_splash-v1-2-00698933b34a@valla.it>
References: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
In-Reply-To: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=francesco@valla.it;
 h=from:subject:message-id; bh=X85Z4DhxPeHwX9zmh4XP31D3/HzYWiFyWUzUtKstvdU=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDBn/Vhxk+pHU/d87/HulnfLb337npd7c6isK8fLyqTpxe
 9/0tZcOd5SyMIhxMciKKbKErLtxb89c829pGxgfwcxhZQIZwsDFKQAT+W/IyLD7y7EJr/U/qRw0
 ZPXTM/R+eflv3OfLr3ynTpt3/Pe5c0EOjAz7Dx9o2M5wPL34ZlBy3ZyaeIMjCeq2f3rO/W3UfJP
 51pQXAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 175d9e30c1866352aadcb781a5fda938
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vD9lx-00000002wA9-43f2-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add myself as maintainer for the DRM splash client.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b82b9de4143c1591a9b1d44d42194..b365a6199dd427b0c66452cbc419d1fc0618c502 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8643,6 +8643,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/drm_privacy_screen*
 F:	include/drm/drm_privacy_screen*
 
+DRM SPLASH
+M:	Francesco Valla <francesco@valla.it>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/clients/drm_splash.c
+
 DRM TTM SUBSYSTEM
 M:	Christian Koenig <christian.koenig@amd.com>
 M:	Huang Rui <ray.huang@amd.com>

-- 
2.51.0


