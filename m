Return-Path: <linux-kernel+bounces-769307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D38B26CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A13AA2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422132FC89E;
	Thu, 14 Aug 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="fCW8G+nN"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAB2E2654;
	Thu, 14 Aug 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189729; cv=pass; b=YJBJbbdLUmpTPiZ/dcNgEzvT2D7/n7roS/ylorNHx9wYXWCAldLqbOWtAMf/bc5Hx98pSgLWfwMDF/8MSHvrGSd0TQZb9I4cn2tw5QNOwG2qbjxK8OmznqIN+/7kppiIXoP+GL/sN1N0xc/8DNAcQdP9X3qzLX4PMbFGWXxChP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189729; c=relaxed/simple;
	bh=fRsn/a3yISdqscoxJmPLfelaRLtxBuie3Y0lDKPeSvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0JSRVKwTQMmsG5uIh9I28XJNvqufWmpxJVLZnTYWWK1+UTnKFis9o5Ziv/0yUP49DsJN0xgPC0yczXP01/QTUQzgjr25g0p+A93wkv9nqopBo4zJ61VkzXdVgsXX9CWuopvoFCk9+dI0HLxT3cD92RTAPp/3QdRwJ98ghE7abE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=fCW8G+nN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189694; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X1ayUfJQ6DxKLvbCksPYrzsQ1oIm5hH5yDRN7Fzl2+xnSKb75olCwJxaA/yQ0aScftXy0n35mHg8yrTAqgYVd2VO5/L8jbHUxeq4fYvolC+AMRkoGcUaVnNrZ2nc/DQn8hA8SIJIL9RcZqzz0bCmd2v9WQT1LcH9UHlvcaPB3PM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189694; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AwlujCsaw8JXky+XOEnR5Sze+0NX6gB9xBd1ImD69wc=; 
	b=QztjuIkxQ+vcm9bl0gledOSkKyuDUK/Q1oD3jKYmAXCHh+AG+57kLcO6nDKNg16RKNt0Dv04QHvF5jzANIxx6z1jflYzervjhYko4Gl3qXXEvW3qlR8dpYu+7shPVj2uElYZeFJDEAFk4mhMJ6I0ANzW1bCmHcvD0UUHW7aQfNg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189694;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AwlujCsaw8JXky+XOEnR5Sze+0NX6gB9xBd1ImD69wc=;
	b=fCW8G+nNHHF9yikS2mp/9LCxUozS2xPJPLd+QFK+1CAu1C4LTGcpX0XbeqC8yLsV
	bI/0PUMiq1UpygIuJy2XsaUCBWwOuhNmU40Y7DNgmaw409yvLSNTVJ2VaO+sR72JQcx
	F4TjYwgULnZLhqb/BgpME4gat07t5Wqq3Pg3ge8hdyyL9NRb9o4okdBRxHtRvdy3Ilh
	YtkfSqmLGQbXtDiVGC+kX7rKBASL/kOYP8kVdyRmAhhdS7CLnnHSaLvJ7qX0nn0GAqt
	5MNEcwQL4rPpDHikfN+x/r5zGAnYJD3QcBM0SC35octLEmiUEpaR9u1EHKCyGvXOXGc
	KI1MFPVgXA==
Received: by mx.zohomail.com with SMTPS id 1755189691631781.4424820957234;
	Thu, 14 Aug 2025 09:41:31 -0700 (PDT)
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
Subject: [RFC PATCH 1/8] dt-bindings: vendor-prefixes: add verisilicon
Date: Fri, 15 Aug 2025 00:40:41 +0800
Message-ID: <20250814164048.2336043-2-uwu@icenowy.me>
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

VeriSilicon is a Silicon IP vendor, which is the current owner of
Vivante series video-related IPs and Hantro series video codec IPs.

Add a vendor prefix for this company.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f540..215c6b71b9717 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1654,6 +1654,8 @@ patternProperties:
     description: Variscite Ltd.
   "^vdl,.*":
     description: Van der Laan b.v.
+  "^verisilicon,.*":
+    description: VeriSilicon Microelectronics (Shanghai) Co., Ltd.
   "^vertexcom,.*":
     description: Vertexcom Technologies, Inc.
   "^via,.*":
-- 
2.50.1


