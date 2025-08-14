Return-Path: <linux-kernel+bounces-768706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5DB26467
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E2A01429
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9F2F3C24;
	Thu, 14 Aug 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GhXYMl81"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C292D46BC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171336; cv=none; b=fXiMTpukkg1fqRyrKM8pLdrl9dukj0r2Ua2NvBOpSJ6Y33MAtiaeM+SPbKD9LyvKkeo6i05zmZtaaS1u3cS/NdPyTHO7PPTK+X7I/SaWxQ65yk5XrJtd4jHSk4PW7JR6hGtKDM3DKAqaaDuCsJMoQQDj4THNTAFDw1sgfZHJqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171336; c=relaxed/simple;
	bh=gpewYC1aynL/3plWWHQnPjBngKCe/yxFIKKQ7sIJHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUZrEiMvBFuQNdHl1cKYSt6d/C+pmZwra35uo3nQmsTRbgdUtoHBB5UA8qa+rs26Wz3MI+aEvs8A685TsQOE6xJwoUHD36Z59oLmCdmkY1JtVNvBikhbSP4BZlCUjSnwqL7/6FYv3ckXCeQGJ5k7LIPaZdI7/zq7TMrIA7Oebqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GhXYMl81; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=h17YFkfTuCB8eF+5nF50XzxDOJoEYvolvGJ2ABR+gec=; b=GhXYMl81k8akaGISyLLNeZZWSO
	Oo7W3tx9a30VuJq18QJP2R+cu4XpjRSpNSW48RROO93J+kbPFZV0xIYndRBgoWruhlv9xQOIKUf3g
	LcbR7uxUZTuSq0r7dQ0NOv8LDZnSjXqt5tE4dDP7zeonAnE1YRVvF5bVm7GBlYQn9I/svnlFcsCj/
	EgoHCFxQbKmNfn1b9r5c/EbgTR4OzEgIWiiwBTFa2wsRnT3FeS0JjHfO4NtYFSfrjl7ZAhjjS7POW
	Wmx0NGYjixfynDQmJ80XGKW5rtirbqg93+JHGYyhXxUTCjXCVJ3odBxHWbbVc5H5B/NnpmaHHMJz1
	g/baw9hw==;
Received: from i53875b38.versanet.de ([83.135.91.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1umWEz-0003Km-AS; Thu, 14 Aug 2025 13:35:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 1/2] accel/rocket: Fix indentation of Kconfig entry
Date: Thu, 14 Aug 2025 13:35:18 +0200
Message-ID: <20250814113519.1551855-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814113519.1551855-1-heiko@sntech.de>
References: <20250814113519.1551855-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The general indentation for the Kconfig lines is one tab, so adapt the
lines accordingly.

The description is correctly indented (1 tab + 2 spaces) so doesn't need
changes.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/rocket/Kconfig b/drivers/accel/rocket/Kconfig
index 43d6cd98ec8e..af6cda273892 100644
--- a/drivers/accel/rocket/Kconfig
+++ b/drivers/accel/rocket/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config DRM_ACCEL_ROCKET
-       tristate "Rocket (support for Rockchip NPUs)"
-       depends on DRM
-       depends on (ARCH_ROCKCHIP && ARM64) || COMPILE_TEST
-       depends on ROCKCHIP_IOMMU || COMPILE_TEST
-       depends on MMU
-       select DRM_SCHED
-       select DRM_GEM_SHMEM_HELPER
-       help
+	tristate "Rocket (support for Rockchip NPUs)"
+	depends on DRM
+	depends on (ARCH_ROCKCHIP && ARM64) || COMPILE_TEST
+	depends on ROCKCHIP_IOMMU || COMPILE_TEST
+	depends on MMU
+	select DRM_SCHED
+	select DRM_GEM_SHMEM_HELPER
+	help
 	  Choose this option if you have a Rockchip SoC that contains a
 	  compatible Neural Processing Unit (NPU), such as the RK3588. Called by
 	  Rockchip either RKNN or RKNPU, it accelerates inference of neural
-- 
2.47.2


