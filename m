Return-Path: <linux-kernel+bounces-827142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38739B906B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F01892FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77527A45C;
	Mon, 22 Sep 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHKyss4k"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F017993
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540873; cv=none; b=LwnHDXyG7bChP6Zh+fg+etbRt2zw/NUgp865TCQ5Cn3eNdHQFWQoAAkfhXGp5e2YeG2oRyP3ObLNIajypP4TvPkuhU71EUxsUlT0dq9UaCZq7l7WH4grg8R9zvbrFSPneu2IFp6NDsGKfyQVCoYKtjfRi8B4YlrfM+0apfQxhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540873; c=relaxed/simple;
	bh=msXmE3zjyyKL/JO4LZbH/7kQYOoCKL3LmWIrtPwyiEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A72p9aqL+4vdB8JdjV6qRmFFu3N4EXatJniHo7DJHlaGn349IZzqZInVB34cdrCoZXlxc4tJlcwFudpZSkLSVfmGS2YOIcujIRnsIZjnCunnPApHhHbRP7S+wE4DepSrHowZ0CqfWv47OGTKoByo5DsRCaoLwTmwzmHd6SmWwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHKyss4k; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2445806e03cso54002555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758540871; x=1759145671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svYyNKXIr0DnaiNfb2o2iM6sDl1E/t3sGUBrA5bPkCI=;
        b=GHKyss4k1a2P8NwGWG7I8LqCBOOXeusQLYNgiqtoa/91kuodK0Q/XgmMu6f9HebDRj
         h39q5kllNc+5Rb8tuJwhhElAlPF5F6L8xbtW688hl5M4pT8HPdjkcdRWRSXjjWi9voAf
         p87kWJNxJp611hQx7zYATHQLhsPzexbqpApo7aFb8N2cgOz8TwsvQVc81lJFcddkiXUM
         fxHyiE9k0VTu62pyQIBxFwBS7qIx8kEXMTtfugIf+OuvgL95eUxUwia+7okkuPQzkdJ0
         /d4Fc5AWv97RQtZpj+c23qHLiSyy2zXnVk7uv6GChLq/UZ0vSHHzqpbC9/1zs+JMji2/
         Tmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540871; x=1759145671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svYyNKXIr0DnaiNfb2o2iM6sDl1E/t3sGUBrA5bPkCI=;
        b=TidBOuJbfOkiva/K1WHTQ7EEPkqr6if7kNiJTvsRle7kbotfJqhMJaQwuXTKjxBfET
         rzaJYR+lgtOPOxxkoYWjznyMFIGvWZY3HkNKLTBxiItYjvDTxt2QLb+WVyUN1jB5CN4i
         V/Ol7JZBnQ5+zGXIlB43pBZgsvC2Te+m8NZRbVvLcFbY/QAeG7O6Gxa2pJyEve8vq5FO
         ZqoXo3Yz+KGbXAv5jQbzZYvkf96oHFbF8S8wVFgF20lhuwBBIV0F8yJv8yibLE/NonAc
         QENai9xXXAMdFuekLmBxNLeUYSAcylt3fscIQtrCeaaozSKzWSv+eQrZJI1BHkAkvVJO
         hLEw==
X-Forwarded-Encrypted: i=1; AJvYcCXmTubsHVBEEDIgTS/+xoeb0o4Nf8TkdgwNxXskZ5fKOq2zwonvEoVLUbDLMFYij4dn8xXEXZghs+uUCTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dG8AvpUVv33+jqc4Oip/cwE6dqGV0oykhyeJhYrig6hHknMK
	AR+qA5I5SWF9U9wF7IyI4KGB6zyZm1PjYOgjCun9OdQtiYyXgt5RT6wI
X-Gm-Gg: ASbGncup1qx18Zh680Cnl9t9grMTKWGACr8q34Hz8p2BFKVAbZFJF4D9CNtvyGEvuF9
	0vQvgNbNrKn8lS1ucksHs5Le7NguwIH/sSAXmKwzNuqPCRIgBO/csyAdPF9f/vbrv3aJH3Jy6fx
	pu5v2MzrmuccVRP/gO/XiuK290shWpLIIeQEUjA36eQdPc3hXcUZVIfgOlJy63jkP2acXqXYoOU
	ZWODeCZDNil0RcjyArrCuDafyR5C6W8+GK8BlRB8Wa0deTfE+xFy+8ZEDf+AT3i8YlhGT2f31/a
	1JXEU+RvbwMQmAUDUrx5mX2wJFxLHrBKZlw569JwqKDY0EpV4N6litTAlFfgu/fHJWRTcfzg92w
	hfmEOYlVqvNnW7J2Y+2iqHWwGidBYn1Q7UozWmyq4MHrG2PvbMP75VwsulmavOCnG8iB2cxBDEw
	Y=
X-Google-Smtp-Source: AGHT+IHBcLCGVUGtyxwtyhqZAki9tWxgJO2jHk+o03/MkjvxOjbvSXORV/Wh+Tb6IHqT1ZnIghX3dA==
X-Received: by 2002:a17:903:2342:b0:265:982a:d450 with SMTP id d9443c01a7336-269ba533c6cmr148636405ad.40.1758540871326;
        Mon, 22 Sep 2025 04:34:31 -0700 (PDT)
Received: from fedora ([2401:4900:1c27:f451:34c1:9461:5e32:1d72])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3322a4e13e1sm6152681a91.17.2025.09.22.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:34:30 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: frederic@kernel.org,
	linux-kernel@vger.kernel.org
Cc: chandna.linuxkernel@gmail.com
Subject: [PATCH] kallsyms: use kmalloc_array() instead of kmalloc()
Date: Mon, 22 Sep 2025 17:04:12 +0530
Message-ID: <20250922113412.3075935-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc(sizeof(*stat) * 2, GFP_KERNEL) with
kmalloc_array(2, sizeof(*stat), GFP_KERNEL) to prevent potential
overflow, as recommended in Documentation/process/deprecated.rst.
kallsyms: Replace kmalloc with kmalloc_array

Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 kernel/kallsyms_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index cf4af5728307..2b082a7e24a2 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -264,7 +264,7 @@ static int test_kallsyms_basic_function(void)
 	char namebuf[KSYM_NAME_LEN];
 	struct test_stat *stat, *stat2;
 
-	stat = kmalloc(sizeof(*stat) * 2, GFP_KERNEL);
+	stat = kmalloc_array(2, sizeof(*stat), GFP_KERNEL);
 	if (!stat)
 		return -ENOMEM;
 	stat2 = stat + 1;
-- 
2.51.0


