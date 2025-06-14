Return-Path: <linux-kernel+bounces-687000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096DAD9ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB94B1771F3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F092E92A1;
	Sat, 14 Jun 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rNxhmXun"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E82E88BA
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924563; cv=none; b=XOTy1mqW7s3U5Y2NQMTh5fFDDphR2DYduhN/BCvwVet98M+LZ8E8Ch5c9rxinYLJ4CR0GYUIpS6LH5AJSCMcp/Ds1ItdkM5l6evCOZ7vKUCBqxerPpqvmBZ2ZQobx8pvjBswOmXzlsJlE6ygMGMFXZSVpWWSELK0jcaRXG8BkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924563; c=relaxed/simple;
	bh=+FCGWdAtwyli9hmDGM/DZkGvYRIHHdirgtTtklQpQFE=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=laxPVn4QXuGLtHmoINvloShWZTmCtxh5GUZNfWfA2DLE3ze1eSrew1JOmL+8nSYHGeeXt2DJS+cRmY9xr6pBLZ8lnRrdn0MzH+iZ+bJkZ3gcDhoWcVSxuiAKFtE/Vx+K2jqV5KNsJM8mvDaupCv3neAEPZZDZeS4JeODMHc9UGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rNxhmXun; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250614180917euoutp02ac256e20a6ec3d79f4c4d49a2e1ebfc8~I_x0LqdAe0357903579euoutp02c
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 18:09:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250614180917euoutp02ac256e20a6ec3d79f4c4d49a2e1ebfc8~I_x0LqdAe0357903579euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749924557;
	bh=hjL1qzi8D7La8kSdLlE+umaAk+GjyLvHnJK5f6ac4FQ=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=rNxhmXunDy3tyMaGIEJvg/elwWMNnxQdcHr7tbU7pmGA5SZ2idbAyDYEPF93myeqI
	 Ok3zIW3rIuZrlbE5GiAmtOG5OMu8eElIxrFjB5eANL6scLi1AYmfbp5uUV2aBwa1JO
	 vLpeVJvmV5XBdyMY/IF0zXxoyAECekDQIkBss9rI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250614180916eucas1p1ee5f075be14d88aa828ec4e55c26bae9~I_xy87uAa2846328463eucas1p1D;
	Sat, 14 Jun 2025 18:09:16 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250614180914eusmtip11a36fd21833595591f4f509910fb1977~I_xx41LnK2797327973eusmtip1e;
	Sat, 14 Jun 2025 18:09:14 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 14 Jun 2025 20:06:14 +0200
Subject: [PATCH v4 8/8] drm/imagination: Enable PowerVR driver for RISC-V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250614-apr_14_for_sending-v4-8-8e3945c819cd@samsung.com>
In-Reply-To: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250614180916eucas1p1ee5f075be14d88aa828ec4e55c26bae9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250614180916eucas1p1ee5f075be14d88aa828ec4e55c26bae9
X-EPHeader: CA
X-CMS-RootMailID: 20250614180916eucas1p1ee5f075be14d88aa828ec4e55c26bae9
References: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
	<CGME20250614180916eucas1p1ee5f075be14d88aa828ec4e55c26bae9@eucas1p1.samsung.com>

Several RISC-V boards feature Imagination GPUs that are compatible with
the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
4A board. This commit adjusts the driver's Kconfig dependencies to allow
the PowerVR driver to be compiled on the RISC-V architecture.

By enabling compilation on RISC-V, we expand support for these GPUs,
providing graphics acceleration capabilities and enhancing hardware
compatibility on RISC-V platforms.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 5f9fff43d6baadc42ebf48d91729bfbf27e06caa..d1e5a18e8e84dc57452cd4bf0fe89dfb90a7bb29 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,7 +3,7 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on ARM64
+	depends on (ARM64 || RISCV)
 	depends on DRM
 	depends on PM
 	select DRM_EXEC

-- 
2.34.1


