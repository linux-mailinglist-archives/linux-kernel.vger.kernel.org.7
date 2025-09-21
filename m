Return-Path: <linux-kernel+bounces-826085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BFB8D7BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66C5165BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D823E325;
	Sun, 21 Sep 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NesjRj/g"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA851684A4;
	Sun, 21 Sep 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443870; cv=pass; b=YJlbt0tz2dsE+ak/v1QuPRoKoXRVGDBw88DD4Ba4denLb6u3fnWsRG6EVLTzKiYphAB9OxrpxARI/3pzdHfHRJ7eTrwf0KtjJsiArFDqBzhaN64t7+77uqcs5YAWfx6E4ArM4ySCsCpZCZP4wYPPBRxsUbB7r5X4xQfV4Tm1fc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443870; c=relaxed/simple;
	bh=5Nz/aipbqPUv+GhHEM/dv1l3XjiTL0M4qlO2ONrekqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+6NjbH8xuRHypzBwYUUE74rwXXa8G/YTf5Yh396E0WJEk1hDMJmvWA6+c9BwsFVDG83nO6e5+lYpzXp/A4pb8ff1SZ7TYGP4mkllFmYNBc0YtXBjdiolBkw5iAREg+/quEePUfk30aVe4Mqyp8eO4swYMv9hM1RS54zUn4Ic1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NesjRj/g; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758443829; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WurbZSMAucWJMG9KteVgGhWwjgsyMgg8B/RMRKCiOq4+ILUxejB4ENCxMgKzGGoRwVfoWdftOgYd0VI1RXqLbRMRUv3qJ6NbecpPzFCdusyihpMlysxPY58P5LP+1mPT9vsfGHF7XA29xkIijPeewvnLxVa0D5R7Krt4b7XQVWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758443829; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BISvAyyTH0h3AbD1RfOd4M5Y4uTH6JugxkSpXzZ0EJk=; 
	b=Gz9qkt6gLx3oicvXY8PaoTrk1u3+OW5VKy0fwj00pDFDKDSp54BEGZV2Zn3gV0rGMcULDZPkHN79ul9PQ7e6CN7dvn1T+ARbcO7uyYYBtASR4IZ6QR/pF3EcuP34/kgKzJ3tkujcL2xnn+Cxjz20xwnwhs+JtAjmwHpnbrEVA6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758443829;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BISvAyyTH0h3AbD1RfOd4M5Y4uTH6JugxkSpXzZ0EJk=;
	b=NesjRj/gNsGIUHJsHrhk9FMhNcV6WFDxKodILy/mkysSawpiQoHD0BcvUZFirAqj
	W1bkUEvwT6guxuK9RsNZwzlnvJMjS+WUJLqdAHgDgAZ4OSpxlF+/FmRkplGqFbPiQAU
	F83Qw+GcnLFTIAPvSBFltLi2bbhRm+7uyHlfC3bRv9Ukv00C3Cg+JtIjtKwAWsU+aqu
	moJUPBSOdhvVUIIKddh114MtxmRWBVgJHNMpoC8POj2xMhdNg8Eeq72ykyxzmC/BXgZ
	fDZdruXoXrh8qI85XZyRWceMW7KXt5y9LUTcy+/AFOKUBdVWjZ4nXTDQsZX3/IWU6lN
	VJepNihaqw==
Received: by mx.zohomail.com with SMTPS id 1758443826199803.7477831973885;
	Sun, 21 Sep 2025 01:37:06 -0700 (PDT)
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
Subject: [PATCH v2 8/8] MAINTAINERS: assign myself as maintainer for verisilicon DC driver
Date: Sun, 21 Sep 2025 16:34:46 +0800
Message-ID: <20250921083446.790374-9-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921083446.790374-1-uwu@icenowy.me>
References: <20250921083446.790374-1-uwu@icenowy.me>
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
No changes in v2.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98af9dd3664f5..348caaaa929a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8393,6 +8393,13 @@ F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
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
2.51.0


