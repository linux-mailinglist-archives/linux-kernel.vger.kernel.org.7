Return-Path: <linux-kernel+bounces-769383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8AB26DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4D9B61C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6033002DC;
	Thu, 14 Aug 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkCYUApB"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA6221F11
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192219; cv=none; b=cZox6e6mEQbVDPeR8VlhbT+RddSR5sbyuNvgJANLUenmHeWW8JrzvaL0VaD/0e+y3dOXub87MLJNwXzye0oR2Vz80lWLxDhdgmUFi6HrYvZSzhgPpEsia/isEa7mCiDi8lXWRjWBXAUUDy2Qhxo5ts7CFdGIULLNk7VjXszqj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192219; c=relaxed/simple;
	bh=8T9hXYsslvnQ0x+M49u1H8Bp3TC/T9xUU6KTqJNKmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFM92vh/J+/p6WEqMWIMrRSHwvn+v0zBhx3B1VKBJ9d/P8pquG28v6XSE90eYn0bYPXILQUzy2lTm5KMaSPyYXRoveGG8HK14yHhC1tC/mTgeIsMj75UTwWzy3Fd69wPCUkyPSvOB4Ux4oxNJ7gdc1mkpf5+K6n6vqauWihWLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkCYUApB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755192214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wUIpu2gykwNNadNywpAPLikctcfGHY/K7iBfQRFKykc=;
	b=VkCYUApBXox3XdPftctuM2j4AL2QFxde0Cd0Ntp2U+hTVTt8l+cU/nkdyjICuqIGEvzJ6q
	TI3BLyCZZIvJJ8TbW5FEHCfjf7Jotj+KdQY1az4XEZ85fUOUvKqZSoLNGy+TQdEIAWHIBq
	BUviOXFRck8isunloIoclP87+yqOE0o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: pktgen: Use min() to simplify pktgen_finalize_skb()
Date: Thu, 14 Aug 2025 19:22:40 +0200
Message-ID: <20250814172242.231633-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify pktgen_finalize_skb() and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/core/pktgen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 0ebe5461d4d9..29ff079c0c36 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -114,6 +114,7 @@
 
 #include <linux/sys.h>
 #include <linux/types.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -2841,8 +2842,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 		}
 
 		i = 0;
-		frag_len = (datalen/frags) < PAGE_SIZE ?
-			   (datalen/frags) : PAGE_SIZE;
+		frag_len = min(datalen / frags, PAGE_SIZE);
 		while (datalen > 0) {
 			if (unlikely(!pkt_dev->page)) {
 				int node = numa_node_id();
@@ -2859,8 +2859,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 			if (i == (frags - 1))
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0,
-							(datalen < PAGE_SIZE ?
-							 datalen : PAGE_SIZE));
+							min(datalen, PAGE_SIZE));
 			else
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0, frag_len);
-- 
2.50.1


