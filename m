Return-Path: <linux-kernel+bounces-891956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5FC43E81
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342003AC542
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38C2F6933;
	Sun,  9 Nov 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsLEKn9R"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648EE2D595A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694727; cv=none; b=Ye9O1DcheXBMNLH+B2hoK8c5E0qkBJZbKGTL5jHXxwzrr8NKqlhaIMXLUi8MMZaxBo+/DbnOPv1A5B98B2HMYumfi2zqmSr5Dehu+FE1tUoYsnUJg/g1R4FKW3XLGk4v92cKuIBthLWlDn+h6/2Wqh3Md+uHzl8y0sxv6UnoTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694727; c=relaxed/simple;
	bh=a6Mm4Izv/l2Vj4Lk4uIhAUntZzlpFUu5dR42KJu4KxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3MB2y6Jm3uM8gkRSPsZqvgST/fZkaIQwMU/4E+2lA2p3tFCUv7DyVBU9cVLuFYE20joUafkdPhJvuVKz8OJIlwn75PVmw+ieT13Aig7E3TxnLeb46K2BXQjqpYX13E3EEQVfO+cyFwZYvklHVa9FzezzvfZUz6ZmKoLnwHpAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsLEKn9R; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762694712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+7YL1GuAIPNyLjQq6TclNsLYD8AzM0YeDoT6kWQUrj0=;
	b=nsLEKn9R5peSkPpKZVkQZX+lcRXX9jWPKMof1BYqA6YzTkGP8+pKrcwLVPmNh0HsDl3Cc3
	dTlTTVDelPepoWg7AD+iO4DOAAHG2f/xXf/8mqqK+36sCzakiaYDpkaAoI06TIXZ1HmvRB
	zO2p31ciLstdRmAoJ6d9KvuuwRSbKro=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/xattr: Annotate struct simple_xattr with __counted_by
Date: Sun,  9 Nov 2025 14:23:51 +0100
Message-ID: <20251109132356.473873-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'value' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 86b0d47984a1..2d0ccf99ee75 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -114,7 +114,7 @@ struct simple_xattr {
 	struct rb_node rb_node;
 	char *name;
 	size_t size;
-	char value[];
+	char value[] __counted_by(size);
 };
 
 void simple_xattrs_init(struct simple_xattrs *xattrs);
-- 
2.51.1


