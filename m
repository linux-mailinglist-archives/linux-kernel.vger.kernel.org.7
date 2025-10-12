Return-Path: <linux-kernel+bounces-849732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A1BD0C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029E53BF02F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9750F23875D;
	Sun, 12 Oct 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ve1Cgubv"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836222F14C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760301553; cv=none; b=uHi5d1UWrKjZ1jONKm2cAm8ysPzCorNO9EWsLm/sWZEiW7M26X0fJHReqIbtN9i+0n7BgSBBma9PdnmgH75N0MbX4N1jy9VjS6hqA6FYo8MGkmaWZbCXl7exhgKX+BoKWYMPa4kW9hrxcmlqa+bALbBZr/RBxrqQ8AIjTQrYIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760301553; c=relaxed/simple;
	bh=YIkTgYn9i2yw0iFaIALqYXIa9CMh1bynZaoWnsC+ihU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IY+o3omlIkIHkxjcLs4KWzWpFS+NTG3DzNgDHrlYcUUsquvt8Qm6Oclgf0TzrUJExGcRrgmmmNFuJ+S5gYNg3/IE5fkj+NmyfUyL+s/h92Cjx68MiZpDzMFifTGbdEfJI72HxmtTbtBgm8L59WY88jj1vXWLwR8Lfq9AbGEmdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ve1Cgubv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760301538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FKhJ/WufXxLbU2grf7XLNEYhgrmN020loyUIXPWxv7U=;
	b=ve1Cgubv0YcbugdHFD/N9LGuipVUBqST1XmwsuU84PKVu2uM3x+m1bkJTcWy2AAarJi8+l
	c7hO7tTAUiGx2wGD4AH7FzxgTuboVUdpgh7uNLpfzF6T5/ZIpDTGqrojsT0uGVSiGDBRvD
	JCcCTaLZvjt7DEBEcWZn77cEA2mT55U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vivek Goyal <vgoyal@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id
Date: Sun, 12 Oct 2025 22:38:40 +0200
Message-ID: <20251012203841.60230-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use check_add_overflow() to guard against a potential integer overflow
when adding the binary blob lengths in asymmetric_key_generate_id() and
return -EOVERFLOW accordingly. This prevents a possible buffer overflow
when copying data from potentially malicious X.509 fields that can be
arbitrarily large, such as ASN.1 INTEGER serial numbers, issuer names,
etc.

Also use struct_size() to calculate the number of bytes to allocate for
the new asymmetric key id.

Cc: stable@vger.kernel.org
Fixes: 7901c1a8effb ("KEYS: Implement binary asymmetric key ID handling")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use check_add_overflow() and error out as suggested by Lukas
- Update patch description
- Add Fixes: tag and @stable for backporting
- Link to v1: https://lore.kernel.org/lkml/20251007185220.234611-2-thorsten.blum@linux.dev/
---
 crypto/asymmetric_keys/asymmetric_type.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ba2d9d1ea235..bd96f799757d 100644
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
@@ -141,12 +142,14 @@ struct asymmetric_key_id *asymmetric_key_generate_id(const void *val_1,
 						     size_t len_2)
 {
 	struct asymmetric_key_id *kid;
+	size_t len;
 
-	kid = kmalloc(sizeof(struct asymmetric_key_id) + len_1 + len_2,
-		      GFP_KERNEL);
+	if (check_add_overflow(len_1, len_2, &len))
+		return ERR_PTR(-EOVERFLOW);
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


