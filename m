Return-Path: <linux-kernel+bounces-738375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B4B0B7A4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7D1897A59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8B222585;
	Sun, 20 Jul 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HRQHuVxZ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2D382
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036046; cv=none; b=T1xev6hD0iAHrCLEF56eVyoq5oswb3foO7DTFLIhfXtsqnJ7+J5C+GfIZAzifzOIoJaskUbUD5QpdnYZyt4D0JgYvFbBxz4IsxmmvKqpJul7jumTsLGQeVWxC95zMbq93iMEoPurFOdxVVggDzOGdsC22bjzqm6kyJM2rY6MP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036046; c=relaxed/simple;
	bh=X5xqs1ZP4P2RhnBgNzZid0V1n/QQZPwqie8VhCKeGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEn1JIfY6dYMGNGHc72JFgB1djnyd5C73i6dVI90M/3yqZ1V8LiJMi7OYYp359zFnB8GgH6LFNMfr1saVrt2URYeH9VE/aRX+QM4aByozCT9w5BW1BaaGfJVTwQs0pPyjumkXUCOYx1d2193nrifa8WYUlv9tRz3SqWYe1WavZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HRQHuVxZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753036040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEkcY99JjeRt6Kj8QpuGyp3e5YKfE6FffJwx4zakCNE=;
	b=HRQHuVxZJ56WcWGTQDyJKlDbffAoZe9YzaqooFMdD2Z/BI309pI8IDSWt33iIYpuG+ZWap
	zS5rbkQFryiv0uXYPmVlXVl5/o2n8xqGNYK53AHwIqkivygZRoWOe1AmXdBlUSqSPEoFbz
	ABQkYNbItNiko+dhI7z38xmnZjpF8sE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: keembay - Use min() to simplify ocs_create_linked_list_from_sg()
Date: Sun, 20 Jul 2025 20:26:05 +0200
Message-ID: <20250720182605.427375-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify ocs_create_linked_list_from_sg() and improve its
readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/intel/keembay/ocs-aes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/keembay/ocs-aes.c b/drivers/crypto/intel/keembay/ocs-aes.c
index be9f32fc8f42..b69e7bfce9cc 100644
--- a/drivers/crypto/intel/keembay/ocs-aes.c
+++ b/drivers/crypto/intel/keembay/ocs-aes.c
@@ -7,6 +7,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/minmax.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/swab.h>
@@ -1473,8 +1474,7 @@ int ocs_create_linked_list_from_sg(const struct ocs_aes_dev *aes_dev,
 	ll = dll_desc->vaddr;
 	for (i = 0; i < dma_nents; i++, sg = sg_next(sg)) {
 		ll[i].src_addr = sg_dma_address(sg) + data_offset;
-		ll[i].src_len = (sg_dma_len(sg) - data_offset) < data_size ?
-				(sg_dma_len(sg) - data_offset) : data_size;
+		ll[i].src_len = min(sg_dma_len(sg) - data_offset, data_size);
 		data_offset = 0;
 		data_size -= ll[i].src_len;
 		/* Current element points to the DMA address of the next one. */
-- 
2.50.1


