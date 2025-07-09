Return-Path: <linux-kernel+bounces-723130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70392AFE346
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D11C432EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8228504D;
	Wed,  9 Jul 2025 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m3hO8Z/H"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30634283FD5;
	Wed,  9 Jul 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051229; cv=none; b=f8bgg2ovmXvKugCNdMcSk4B5s2u6TGO1nsp+llcqMqQnJjnQ0LII7uL1PD2cyW3SYET9n256bwLW1f1SkcHdaZioxgpJP/VXVsQc0Ya4DegP98Pe6LIIgNDdjcmRmLPdYisz09CAMVB7cZM6CzateqNX7Mo68wuFvQcLRrA+Ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051229; c=relaxed/simple;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6SPlzMoSykr5Ye9CPQfkm1VdC3uRjJtXYQmjWBSVqPF1pNK5ruklkZIzlbNY1+edSe8K6ZYKvi7FOsm0YXHhwdwsa0zJ59ntCPV128k23fipdVKRL8jrwLR/wIkyKiFMq3o98ubsi+zycQrbbE95o0gyIkdKzuAOaKS68hHFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m3hO8Z/H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051225;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3hO8Z/Hm/WU0S2/37/px10JjlMVhXiD/fzyJW0SGXHoI8NvJNx04URZMYlnuna0q
	 4W7Jk3s0WDiWqE3t/HabB5kpht0mAhHhQE3FBsb40PNpaNyWLfpmxiRQMvVTr9+HRq
	 aJn3FnC1s3VbAraASXGMoNm9b6ATG8WZXnk3zs0+gRnlczo+7ykdEt+EzjE1WmfzRC
	 yzuXt08zNRT8Srax5ietcZ39lylFVwNwpxA98mlmA/WDU2vdGbbGHCarb/70Me85vv
	 JnpSwi2Kw62X7rfrcXp60jDfAXzv0M4q+Zb0sTZmdzvW40ca8Xsw6C3xB29aCY68Bx
	 Yy6b1u24sghSA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 41E4217E1110;
	Wed,  9 Jul 2025 10:53:45 +0200 (CEST)
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
Subject: [PATCH v5 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Wed,  9 Jul 2025 10:53:30 +0200
Message-ID: <20250709085337.53697-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
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
index 7e04a2905ce4..a639388298e7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0


