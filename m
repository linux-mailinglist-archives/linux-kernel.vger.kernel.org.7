Return-Path: <linux-kernel+bounces-769317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E339EB26CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C66716645E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A272FFDF8;
	Thu, 14 Aug 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="FFckGQ8P"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE232143E;
	Thu, 14 Aug 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189824; cv=pass; b=LIGmtdRU64qlGrOHUIhF5WYYaDKiDT5P4PmnJRMvUKaCjT46rztzyOvC+39okOM6WhIm+sKyW+CUZxtO/MHime42PtwQ6Nm4gd7nj8FYzzShsuzlBTQTat6S2Xt7j9KbFe4NdCYr2jafL5MDDN1T7YHoOsnArPIn8oeAT6sZhs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189824; c=relaxed/simple;
	bh=ZHrY4409379PJa7TUi8R2itKbkXUYAoWpgm40KcK/Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpEn6wHLRH2DQNSnyjJd81FQFWNBgAtFhgiIHNQ7Efsciivbswr8f6+rUrByqBlsq5oxNiC6xVxQNWvMW8dzQm/Qtl6/u3YNkwC7Q9fPT1wPasKqqScZEqz/5xBMZAG0Rd3EvO29BT1IRFUTJ/9NY7lzLtsjzpHfL5ZB2TwhIpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=FFckGQ8P; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZFVoaYb0BqXsCSXiY7Nt3GjCO/emmFJtWURWBkSKPzSG28oW6RH69rPSaZLEPwsBdDAqQrR0Up7jwRCAmiMl+2tU25UZAbWkoZdbAf0d1YLJZ/dxy+w/gDQxMmGe1fllk+bsh5aAJFEGM7RR4HHlOQpOztflo8BjSwxpEryCudc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189791; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1/iclKhHRrvz1RndiLfggvb+V2P6DE4+wzZACrQdYXQ=; 
	b=PR74O+iTV635aQ+9dTX6kbR3SQUxshF5pVxH2ZoRFmXbNFB/f5F4ryJxgoNSNUuHCe8UvVCrIrrNeWtKFG3ME/3dZR/ojgkpaK+E6ego3V7Tv+0Ciri7O2ri8nz81hi9Kt+EmO8yYixXcGvsy/VznJrHqXgZ3lQgBgKPM8EyWvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189791;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1/iclKhHRrvz1RndiLfggvb+V2P6DE4+wzZACrQdYXQ=;
	b=FFckGQ8PrNiZ2CQY/GtDz7o2T+13e1b9kz3693PfFhJTAf1Scpp2WQqKMew0Gwh0
	Zx6zCs4lzMXSy35XGn++MTl5eWVl8H+NIMf6+rmvyreNA9xoEwy8XTgVK1OvuBOFiWT
	9vVZvGYqDNNvREeFxtxaqTyfNBLC0mUCgw0XQawDjTFpPyrUMIUxN8Twe9JR6sznWQE
	p4tD4Its+W4UyqIF4G7S8nSGBcDQD0q2xzrEH6BctKxO4nZn/HI3r7Z1QsMgdo1wTNf
	uj8NdBewPIsFR35vmaBgiXKZtxRsg7QmiU+l/Usvf3MwCFMPpOYZ6EGX/MaLeUFu0GI
	X+5kxT5bpQ==
Received: by mx.zohomail.com with SMTPS id 1755189789177857.0751333859133;
	Thu, 14 Aug 2025 09:43:09 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 8/8] MAINTAINERS: assign myself as maintainer for verislicon DC driver
Date: Fri, 15 Aug 2025 00:40:48 +0800
Message-ID: <20250814164048.2336043-9-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814164048.2336043-1-uwu@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As I am the author of this rewritten driver, it makes sense for me to be
the maintainer.

Confirm this in MAINTAINERS file.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb84e36ded6d5..8c604de979680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,13 @@ F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
 F:	drivers/gpu/drm/vc4/
 F:	include/uapi/drm/vc4_drm.h
 
+DRM DRIVERS FOR VERISILICON DISPLAY CONTROLLER IP
+M:	Icenowy Zheng <uwu@icenowy.me>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+F:	drivers/gpu/drm/verisilicon/
+
 DRM DRIVERS FOR VIVANTE GPU IP
 M:	Lucas Stach <l.stach@pengutronix.de>
 R:	Russell King <linux+etnaviv@armlinux.org.uk>
-- 
2.50.1


