Return-Path: <linux-kernel+bounces-611392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A627A9415A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 05:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EE2461118
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8F7082A;
	Sat, 19 Apr 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UD8N6BD3"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931753AC
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745032586; cv=none; b=OtLS8hICrbRRapyeVMlsEkjlh5MA3vbI6U951Qfddfo7smkqOzBCvatt9EJN6L0niOgFu/VRq1XKcS+OKo8VyIzrYBUlwREf2rRYmivO8FHVkijf7BiyJVVgdVRTHbMN8d8UJ5PUgnBalZxyDkSQxC62dUrssvXl8k0D36mGOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745032586; c=relaxed/simple;
	bh=1hgUWAApDZ5hyEuUg2aB23eXrAGf+Uo6jxH9Jr113xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r2Q+qlFpRoC1MGNx4i9IvyIVoQeSq1a5hzBGf9VRZ74O2xdZqltSVs3FsPl7sUHNZA3akqr+3zNQWwkbTgOYXgzNToPcJ3gpeP3equGLHIFNMFZp0cBqKrfpuYxRagiTnhGj/UD3yuQo5A0zQG8G+dZqYXaHNRmt54LMCYMl6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UD8N6BD3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745032569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HEB3Gu0mmtCLHoo7vWAwYwONR42w2RB1PSaApMMRgZ0=;
	b=UD8N6BD3tYDGzkmMJbDeZEkO8JXQY5pN24SwGdbUgaaIaUgiuZAwtjzpkfiVKXTqzoDVjl
	8ZJQ0OXXBIKd1g47WPLE+obP9bjFP1tERbEtDmJIaBHFvFVw+CvhGgSdKiCICYh0cGeHvc
	AokjfPoZ966kJE8y4FIVKnneZH4aFt0=
From: sunliming@linux.dev
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized symbol warning
Date: Sat, 19 Apr 2025 11:15:28 +0800
Message-Id: <20250419031528.2073892-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below smatch warnings:
drivers/net/wireless/mediatek/mt76/mt7996/main.c:952 mt7996_mac_sta_add_links()
error: uninitialized symbol 'err'.
drivers/net/wireless/mediatek/mt76/mt7996/main.c:1133 mt7996_set_rts_threshold()
error: uninitialized symbol 'ret'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202504101051.1ya4Z4va-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index cc6bb4544c2a..7c7c4b5a28b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -991,7 +991,7 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	unsigned int link_id;
-	int err;
+	int err = 0;
 
 	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf;
@@ -1248,7 +1248,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	int i, ret;
+	int i, ret = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
-- 
2.25.1


