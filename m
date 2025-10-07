Return-Path: <linux-kernel+bounces-844658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6BBC2709
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122FE189ABB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143A2E974E;
	Tue,  7 Oct 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vBsOcaFY"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CB20E31C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863176; cv=none; b=N0I3umK3taQuPReaoyjk6anQzgLiDbjBfrsqHu4G5IYEeuTjNcH41AjWIJqMueNez/DbMYGNWMNRnBRm4Hi9u4X8PcG0p0UPF0eRdQnXJ3vCZo+qfSXQ61Q4bFKKMhtjlxnowOjIs+H2ba1DFu22UZX+FR64WmNQhMvGqRvDlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863176; c=relaxed/simple;
	bh=VjcQ9snlCIrom8Rz6k8Hv4oZY1ZBB5olqHrymGHJYPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2mlOhe2lxVLdG4FX2XSX65LoJjMfoOekmWTEp0AG/43gM7W9jBGrlETnQwpAJ+Xc62XmOPBNEDBzIzxo0RVDJ4YGXeCJbujLlxi81Z+EYZFtXXO+QoL5OBo9CyHVeqrlpBK/3xSi6hN2SdV0/O/v8qHDzHoDQhc6SZJV8uu6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vBsOcaFY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759863171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2chu4xPxUVESUFHAIrUBzbJKLu+9elYYBXUMSUiR5hA=;
	b=vBsOcaFY57uKxwfOW/zAKIX/TzlK/Tu0OhFSBdFyQqn+WiwhdRvMBWHlUO57DYtXRu5m97
	3fhk3qre+jfPIm1Tw6xAPNmt/kDjauCaHCwK+ieLlyImcw0Vkj11OClT6fHSpJ2w398IdS
	DdxQXFl4O9gruGfnEp33F2EpohQfNwA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id
Date: Tue,  7 Oct 2025 20:52:20 +0200
Message-ID: <20251007185220.234611-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use size_add() to prevent a potential integer overflow when adding the
binary blob lengths in asymmetric_key_generate_id(), which could cause a
buffer overflow when copying the data using memcpy().

Use struct_size() to calculate the number of bytes to allocate for the
new asymmetric key id.

No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/asymmetric_keys/asymmetric_type.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ba2d9d1ea235..aea925c88973 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -11,6 +11,7 @@
 #include <crypto/public_key.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <keys/system_keyring.h>
@@ -141,12 +142,13 @@ struct asymmetric_key_id *asymmetric_key_generate_id(const void *val_1,
 						     size_t len_2)
 {
 	struct asymmetric_key_id *kid;
+	size_t len;
 
-	kid = kmalloc(sizeof(struct asymmetric_key_id) + len_1 + len_2,
-		      GFP_KERNEL);
+	len = size_add(len_1, len_2);
+	kid = kmalloc(struct_size(kid, data, len), GFP_KERNEL);
 	if (!kid)
 		return ERR_PTR(-ENOMEM);
-	kid->len = len_1 + len_2;
+	kid->len = len;
 	memcpy(kid->data, val_1, len_1);
 	memcpy(kid->data + len_1, val_2, len_2);
 	return kid;
-- 
2.51.0


