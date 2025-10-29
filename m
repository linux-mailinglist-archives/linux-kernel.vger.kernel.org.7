Return-Path: <linux-kernel+bounces-876270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC515C1B3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657D06E0093
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE162DAFCA;
	Wed, 29 Oct 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mEBS/OCd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F792D8780
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745628; cv=none; b=DVdJXUrpGApa9z91r0rPYfXqFAdQxUpHa59ih0nQAW8q/FWEy74hwCG379G1SmSb5Pwp6OGihA4kwO/9dlHCXgy7/tsqHu2+MHroYoVod+C/HhLdB0uJ2J5/uNIyTzTe8mehLcsprar+lG/yDdcuAX5g088vdqjYXEbYutTBW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745628; c=relaxed/simple;
	bh=FtGL6BrEe7pDieRhJuh9tsTJUGfEYnMY7qjoVKYV4Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oW+1XcDvKYwEb6yKUtrZNKUXtELxJqHU+j7tbNFjym2xOAX5YjU8or0DHkHyxaxeGfk09BKqrZ3scuS4JjUkPnfMcRa3IbjIMB3zMV8+KyWzEVUa/xjM8cRUT1ZVUuWovfcC1GY0WWJDDlZloqK4jMy9GTeoTk+aXYrbzRIxZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mEBS/OCd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761745622;
	bh=FtGL6BrEe7pDieRhJuh9tsTJUGfEYnMY7qjoVKYV4Xs=;
	h=From:Date:Subject:To:Cc:From;
	b=mEBS/OCd6+czSbU6MfkLaxnvg5HB/ZP8tfOySjoSQRx7oW/DrF8RKppXelv6vvwzL
	 oNde605UdshGGj3IMvONoZI0Ux/7Z16qZtZcdSklRmd1ABCwkQtJhJISOZQ5R9oTgB
	 bexGd9auLlTo6wZerFq4fJdbBHEnCvnEKfp6Hc3d4meeFt1nn7Q+bqUWzrpd1hk3U+
	 c6TfkQjqrQeIu6NeKiIPdUCid2dbyIsVySNfEEwBVvNr/r6tKxsrKXtjU/vQW+hgVG
	 iy/LvlSAWGywDTLneKSar/kNqcKRe3dwJNCAko1wEraVvV+lwgjoY6dI4IGk+yzV6b
	 786rOvlU5Hkdg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3179817E12D5;
	Wed, 29 Oct 2025 14:47:02 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Oct 2025 14:46:43 +0100
Subject: [PATCH] soc: mediatek: mtk-socinfo: Add entry for MT8391AV/AZA
 Genio 720
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-mtk-socinfo-mt8391-v1-1-61412dcd9938@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMIaAmkC/zWMQQrDIBBFryKz7oBaIjVXKVlYM7ZDUVs1JRBy9
 0pDd/99eG+DSoWpwig2KPThyjl1UCcB/uHSnZDnzqClHpTUFmN7Ys2eU8h9X85WoTbSkfXeBKO
 gi69Cgddf9DodXOi99HY7Tri5SuhzjNxGkWht+O/DtO9flhuDxZUAAAA=
X-Change-ID: 20251029-mtk-socinfo-mt8391-260ae9cc6f61
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761745622; l=1281;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=FtGL6BrEe7pDieRhJuh9tsTJUGfEYnMY7qjoVKYV4Xs=;
 b=zvrumaYasVrWd2Rjr0Owt3Swl5wyMzZhnnRllIfhdZGv6sG/Lm651b6aOn6iMJYDWvcHnyhZ9
 PNZkjFi2CNsDL63RZYuvBwK3tjZ2NNJ3jD21Hb/x/g9qGz6r9viLaHP
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add an entry for the MT8391 SoC with commercial name Genio 720.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index c697a0398d917c0944661a75667824369373ba2c..44a21e91d159b93ed1540b5754f5512d2d9c3fc0 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -58,6 +58,7 @@ static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EHZA", "Kompanio 1380", 0x81950404, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8370", "MT8370AV/AZA", "Genio 510", 0x83700000, 0x00000081),
 	MTK_SOCINFO_ENTRY("MT8390", "MT8390AV/AZA", "Genio 700", 0x83900000, 0x00000080),
+	MTK_SOCINFO_ENTRY("MT8391", "MT8391AV/AZA", "Genio 720", 0x83910000, 0x00000080),
 	MTK_SOCINFO_ENTRY("MT8395", "MT8395AV/ZA", "Genio 1200", 0x83950100, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8395", "MT8395AV/ZA", "Genio 1200", 0x83950800, CELL_NOT_USED),
 };

---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20251029-mtk-socinfo-mt8391-260ae9cc6f61

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


