Return-Path: <linux-kernel+bounces-859952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00038BEF081
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA5E1898D85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CED1C5F13;
	Mon, 20 Oct 2025 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fZGPYHTB"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB242049;
	Mon, 20 Oct 2025 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924701; cv=none; b=sT8rlWlI63t3heI6HdU6JEX33XagpnfbG5VvtK85Q7j52rwUjfTuKnFuK4cebUmvzJJIUThY5SUYMneZmtraVo/jWlpFFnA7oJntFe1lTAdsEDa8tUxBwRpACq/AxgMQDVUV5K8jpoe38k2mrg3jU65rdwILHDByedRMOxgX4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924701; c=relaxed/simple;
	bh=OVwQpJxh4eukkhyN/hVdjBrC/3d5Yp+K/ztW6WxS/cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwSFctx967DgXpakUJ+O2EG9p+HqNogiBhZBcPyLf4pcK7SysOoTqxd56yudxeM3ivav+EBD2IgefBdHDrkzcjbzOA4o+bjdgWPOKnb0IcdgMhzY5YBLwbuTuIbU09hkHPMED9hpInopzScd8aqn6UWBnrF5ed6eWpk6jMoh+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fZGPYHTB; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760924689; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6xwabBodM9fCJvLt8UUcakCPv5h3/iUrNZfgFKUHoxc=;
	b=fZGPYHTB4D8qLMdahkywHSSkZ0TcfrVIw9BZIcQ+vt600IFUMb5TWjYER/k67KlRAxfN/vw1Xe3pcsyD0xCSGzPW2qQnFoveNm31X86SdgsHxwgHUP8rqyl6e9D0UIptmm9dn+10T0SgdVz5zjdui4XFIA35BIhoiWA1aIOhfRs=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WqVOAId_1760924682 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 09:44:48 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: nicolas.ferre@microchip.com
Cc: claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] net: macb: Remove duplicate linux/inetdevice.h header
Date: Mon, 20 Oct 2025 09:44:41 +0800
Message-ID: <20251020014441.2070356-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/net/ethernet/cadence/macb_main.c: linux/inetdevice.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26474
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 214f543af3b8..39673f5c3337 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -14,7 +14,6 @@
 #include <linux/etherdevice.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/inetdevice.h>
-#include <linux/inetdevice.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.43.5


