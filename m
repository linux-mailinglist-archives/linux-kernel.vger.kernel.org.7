Return-Path: <linux-kernel+bounces-692246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93756ADEEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B74E16897A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23E2ECD01;
	Wed, 18 Jun 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GOjyIbuK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4D2EAB6B;
	Wed, 18 Jun 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255780; cv=none; b=ur2qCX41KIFWzn9aoP8x+kUwf9oHILXoR1pK3Wh2j7iGSZxu5FYmMrqDCoJVrpFpMolOQ1h0ci9Ag6KzshgJZqvCyr1vqyNUa+h+l85Z/RcebUxsakKIjAOJppGZWKpHwfchmbKrr0x+vjk9zNN8MaNUzuKqbiFuidEWG/6tSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255780; c=relaxed/simple;
	bh=keF4qtNzrgMOTjYFNPm6e0DVoWKRm4eaIoCysbWwg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLTsa9yiblvjP1MlyNC96RshaeJ42T5jnRsgurOuyLUCJyKcMscjrrmOX9140m3BcqW/qqjJbuFWYbcFGyfe0Es1fYQI+eDS0rpBcCET8J3PN5/qYylB8pOptQyo2lbdcb6xAMNs6vLN4v5+KQBBFZfWrd8JSDUwV05FdYLjczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GOjyIbuK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750255776;
	bh=keF4qtNzrgMOTjYFNPm6e0DVoWKRm4eaIoCysbWwg0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOjyIbuKXih008ST9b1XsYdBxBz0K1uPl3kiY+oxxU6PHfh8w4xrLOCHpzxBkILTf
	 Nx+5e8gYQZDa6YkHn1z2dWmULH2JHeVtllgoM0/S+27EDnyIj6o8qILOhU0VnuSGx9
	 hyshYy4saA5/ak9Zcx5B7nCMIW7+hRf951YFEGCOAENenX4liiPl7hgTZPVmu5J4cK
	 ll6jDan2SwjZ0+3Qhs1X7Vur04fjIt0S9NY5yIu4vR+yh6XKbj2R5BtSeVw0do0xEV
	 FyDXIX8BeCFx9qymjJn4eW9j8QPxfuo9h8OZ7O08rUDlh6QXgDWHgwVYBQCjIO8CTm
	 ygQPL3A+Lyd7A==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:45c6:994a:f902:5c74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE43417E1580;
	Wed, 18 Jun 2025 16:09:35 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Wed, 18 Jun 2025 16:09:14 +0200
Message-ID: <20250618140923.97693-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Verisilicon IOMMU used by RK3588 AV1 hardware codec.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..ad1515f69b4f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0


