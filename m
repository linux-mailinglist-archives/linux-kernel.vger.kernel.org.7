Return-Path: <linux-kernel+bounces-870668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F279FC0B6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F343B8A86
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD823002B3;
	Sun, 26 Oct 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="l0UefmQU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="bkyePVvY"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642423EABC;
	Sun, 26 Oct 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519831; cv=pass; b=j0XjVBnTi8sojlQL5xLAxi30Gqp1KYRVYM6xJh+ZI7HFQJBF6W1q2qDh+U1vLQWM5/NCPT5Seswfs/mMD1shFMC8q7ClbuZmoBv+VUGVsZzUECeyOK1/Vlmvhol0IkA8D4EFWhSNYUEYSj3FrcAM3mw9I+pXkTrGNaECIoIXo4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519831; c=relaxed/simple;
	bh=tSRixNkLhCUmU1E1Uy9yxAjJii9EPv9NuRcTEhUazSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXPa+3NT3YMOhIn5lH7dsYFQ7dtBsqYmyMUXW3cZ/n0vdLz2V1YxTm4ucwaTxqTR0YacpNMbJDU7jjUEJ66Q8dXcg73uD6jP19MOEi+kPAIFTVUdy0KmIWAKc4HW5rXagMj1YkR1Zx0ApJEFKZXyfljXUJyJQPZHGAsY26C9rmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=l0UefmQU; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=bkyePVvY; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519829;
	 b=yr+JFNhGBdFwQfakR0gIhpgbDR2DvAVaM1HjX0UDFHdcIqKPMMX7/aX0SwXrqqgkwuaH3bnHwE
	  YRhineQ/W8ApSEou4vh39OaoJse7YCIebssRgsmXgzTfAba7cBshAZdaAlCpFCGT4UJHjUAyV+
	  GvzzCAvqbCzQuiARLRNH1PYwRIVDHSdEFQ8379fQZWFS3uUjseQsNT0eH+CKSA7ckL5GqLGDkl
	  +qTJmHLblL8GSAUdtaKUoTbgdyQihDhLb1DndgMfA1KiLSOXL1LgBfa4+yW2ipR3AXt6oTrUZG
	  xPbTXxA3OByVB7NMuUKqbPX8aZmJq/Z48nRI0HcLStdU7Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519829;
	bh=tSRixNkLhCUmU1E1Uy9yxAjJii9EPv9NuRcTEhUazSM=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=FaB4tLwD8bWZltLZj9xcOaWk0Ap9/d9NOw/byzCAMfUMzME7Sp6M30I8DOQxXVsbqEyK8B8EHs
	  TJk7a9MUH0h13sqhGRuujMwCqNGB5TDyl69CH6Yn/g7dieC0CyyN5Ea31oXQNKPbFjq4N7iHJI
	  sgGS4x15JJdSNGvgG4GolP0cQkIbdlIkyAd7LxMRiVJABN9ZK4k7MeES6w+aQdhbvVS0HzIU7u
	  zR0skE1CcwZAsbnfpyAVlL8XZtZ8Nn7j06xW6N/9iOVT0NwuQHjrvNyyQ4hV5edjop6vCYeQJc
	  gm6yazzuLSDMl6tOcAmYrmPpXVXTkEVt9O8Qhtt/BYAeaQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=JWB6QTvpgPfu9uLg/5WttzxYcN0yMoWXBCd3a+bQgKo=; b=l0UefmQU7CUZr4Bsf5ZLmYyJvC
	93gDYsnkQ8sn8rzP2AoXYOxh3aC5PktcT0QG9GBnVZZaepnEO+FEiCIo85tUyqEXIHlqepOJLF2d+
	eTam5PPBuRG6KwZmVjLq8nr9ShdvUAfkP5zRWjZg7zwT+xariTCN1RgyV1RsRt2LDAxA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4x87.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9ly-00000002wBt-3K2Y;
	Sun, 26 Oct 2025 23:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=JWB6QTvpgPfu9uLg/5WttzxYcN0yMoWXBCd3a+bQgKo=; b=bkyePVvYy8jjGA4QRC03eqSlwN
	iUW+HaYTcxdxuWtbQEtjFhZLT0tNzzgtJQTH+i2D4EeVx+tFh2uNcoEGPR3d0doAS7AhEsDISrhr4
	xh2SReiC3JkiQPg/KW4EW9KAX+XCXMWL0/7tNpU4eY936Ndx6MD8+VsQ221PwyfJ/A+M=;
Received: from [87.17.42.198] (port=63736 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9ls-00000000KNm-1zj3;
	Sun, 26 Oct 2025 23:03:32 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 27 Oct 2025 00:03:03 +0100
Subject: [PATCH RFC 3/3] drm: docs: remove bootsplash from TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-drm_client_splash-v1-3-00698933b34a@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=francesco@valla.it;
 h=from:subject:message-id; bh=tSRixNkLhCUmU1E1Uy9yxAjJii9EPv9NuRcTEhUazSM=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDBn/VhxMPK7UHncreNrkNzMDXycvXXJ2zgyT+7sWcr07/
 H9Fuu2T+x2lLAxiXAyyYoosIetu3Nsz1/xb2gbGRzBzWJlAhjBwcQrARKI3MzIsyrd8U1UZxblQ
 1+jdmktOM9v2GMrpibOHMaeuuhq00TWe4Z/J7V+pv7f//V9tLj0xuc9M5PPfW5uYjtdeDOhYL7X
 iwHV+AA==
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
X-SGantispam-id: 6185ed05db714419c33ff6120ab25f26
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vD9ly-00000002wBt-3K2Y-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b5f58b4274b1d38e26b229b88a8b4f4ba3433179..b1a6d587c286f060d549a12cf8e771f753b712bc 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -717,23 +717,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 

-- 
2.51.0


