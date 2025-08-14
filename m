Return-Path: <linux-kernel+bounces-767943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB9DB25AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B62567369
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3923220F4F;
	Thu, 14 Aug 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JlTkrJRH"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469E1E3DFE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149899; cv=none; b=eHvO5TPbfKGp3dHicC3OXwsft5d79euoG/NXcO6ylRkZTMZbdbjoDIyKq6DBI/ag1Hnf0vxHmEZPnQGZ3E53O5Doj1b5g3Gagwj7tgT7Y3VfMucHBRleGbMj9GGF9vdAlHj9q/W2wA+vvvh3SjhlxiSPLjyO794dxxjBWT/LR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149899; c=relaxed/simple;
	bh=v1/5B9YBtaMrDWrbe82y7467DpNwHxYLWT69qkL+sAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGXRUo45M1hxwxCKMHLgRzTOtWkCiPFKTGBKw3Et4HVFf8IEaELIsYfa/uzQijbIt3P62wGkXBSEMrL3uyglCSlQeztzK/VviYE7a6EgK+yU+/lc/eeI7nCXfuVQeLaPk0v0UN4bxGLVgnyHK9qLnLBba2SThMnRYLPyT5rwEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JlTkrJRH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nh
	v8WVKq3WU5Ll3+dcG7vTMSWNp5cpIVD8CJmKcyYZ4=; b=JlTkrJRHBacTOUhr0S
	/RvI2EjONdA+ENzPC2nq5eEuJI8Dd+thaGXYlssPWsQDDv2w0cT++nz9RRONZ1i3
	Ubx9Q0JxrByNv5KrM3w2p+CN4OQrT3XxFQeMMpQr/QLr+BNmh4ALh9kLequT97J1
	pvUi/rGngL/vFFUBkwYl/mg4s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAnOrQudp1ojstDBw--.33177S2;
	Thu, 14 Aug 2025 13:37:51 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] phy: use IS_ERR_OR_NULL() helper in of_phy_put()
Date: Thu, 14 Aug 2025 13:37:42 +0800
Message-Id: <20250814053742.2186419-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnOrQudp1ojstDBw--.33177S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw45JF1xAr1rKFyxuF4fAFb_yoWxZFc_Wr
	1xXrn3ArsakF47Wr17CFWSv34jgFykurWruan29rWfAa47Jr1SyF1UA34rtr97G393uFyD
	ta17ZF1ay34UAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnvdgtUUUUU==
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbBDgapkGidcheADwAAsu

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

The current check for `!phy || IS_ERR(phy)` can be simplified to
the standard helper macro IS_ERR_OR_NULL(). This improves code
readability and maintains consistency with kernel coding practices.

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 04a5a34e7a95..9248f2249849 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -677,7 +677,7 @@ EXPORT_SYMBOL_GPL(of_phy_get);
  */
 void of_phy_put(struct phy *phy)
 {
-	if (!phy || IS_ERR(phy))
+	if (IS_ERR_OR_NULL(phy))
 		return;
 
 	mutex_lock(&phy->mutex);
-- 
2.25.1


