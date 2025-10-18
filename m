Return-Path: <linux-kernel+bounces-859449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 094F2BEDB04
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6734EE450
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01F283151;
	Sat, 18 Oct 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVtbKs4i"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FA284693
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816871; cv=none; b=NUPOYsAmTHV5CZ33MyA+GieDnNAwlxCMR9xZgfo81W9T1ebZXt3kooZTxuwKDq8SHIGX+A3J3J96vTsdLcSu4WCKv+niUGiPk+UiubAFzb9bYBSAQOPIQwIXXloA3WlBN+mV0f3u91etcAWzs0EdSzZleOU+UBfsXmfXzTqYWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816871; c=relaxed/simple;
	bh=Cfl4Z2FbFTuUkk0lsxnRbzkKFuArme+w8C49aQPGsGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lk5VqflyglqHsfpkwdTiF3sbDzqbTWF7uThC7Jq0LCHKcy/1VwJpwMLp+voQkq0qlvhn8N4XmXfNkcLlRpfOpmfLUIxYjcZnfz2YNTuwAWrzC80vG271/Xf7z4LJ6LUzoUFBXQxscnkvPcJxZ3GXs9LCltEyNZG+gLeqc80cX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVtbKs4i; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso4197388b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760816867; x=1761421667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5yV3R8MF8NT84u8F8kj/y6IDmqDUWQnCYW6rOFqRXs=;
        b=OVtbKs4i3gdew5Dzshx8rQa2MnfVZwA7eBX7XkHQ4JQi6r1IwbGocH7ZG3sA3CMZ7f
         BxusPmuqA1FokPkhHUX8D31XDMYMjhEF2GSGZUX72Hs0kmPmZ6H0H0pf0gf5UNJGIpzR
         H0DjBgs/oBshTxmNJzRf68iOo/7iJAzYprajnEO2y11IaaV6acXBg0mvDiA0QVJa8CUC
         TVW7yHQOv66Z8VZ5ETl2rxouEMF8y5NN8dUiinboWZWApthKqfJH+a15NKkO/dWIko/Z
         ksy4OG88o2BYY1obSY86ABqA/Vwd/k7w3KHa9LSW2jRg8Iz30aKx7Zy2VMHm3WC6Y7Dh
         EyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760816867; x=1761421667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5yV3R8MF8NT84u8F8kj/y6IDmqDUWQnCYW6rOFqRXs=;
        b=WOXedZna3AHUPQyq5Sjtoa9QR+22ScPt1ksbtB6BKNNnyu/sgG2v/LfzUJ2Yg8Ib4J
         n2hSVgEQHHmnDKjoFYlK6QmJuEQ2o5ZYkEpJUYVUZkFZmCxhHaNRGR7gA1uQ8EyAYQ1N
         Xkg8lYRZ/GU6DKaaOrfsejKY74UnWRyPIavH56ydAdytXQnwhRifmih9P4akh+8QT8Rt
         5fPSFQgfXM2BttW3OdANkSM90ck+fsPqJbSWXDiwuY7VrjxEMfc4JFsEN/HO5nQ3k482
         O97rZ+PeVl4xAiqr805mHwrKkPv7MMgk6hAXKdSXOohrINg1G6TgDIrNrBwLMGVdLfyT
         qgNg==
X-Forwarded-Encrypted: i=1; AJvYcCVvn7HCvTyMg9KYIv0UkHBKg9SRcZHZLh6Qy1Nr/3TxxyJCfcCeUE/PZ/sHl8GAgmrnXUV7+xPfGZn9NyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLFu9CsO7SiBXyu4KBk4XI4ChwMbMQhEpPkgz/v1boogeVbZ5
	ppgRhBxj90qxBlQ4MHwHjnlVWgHvfMLHB73zKerNTxtQBSm8IewYI9iV
X-Gm-Gg: ASbGncsZ6cC8xomJLhJah7068Qq/qxeBsyZ83EQcEeduGr515oZuN4Ii5fZDNhfPWmR
	lVJfQhKQs3LcIHsQSBd2mwgV5KQn5jk9TYq05LtCuyn/4pQtR0A94pms++fIog305bqxdBpgxO5
	eoiV20JhX6aTelbFa3H56IG0LpprQFhrTcvIyvtjaa7QA2+0Scy1dXLOWvyowlmr3jHLKo1+mfj
	YykEx8+4YK1vUmt3zj1ioL8oWXl51AFbFiu3UxrS7htBjkRWp3Qod2lnHUYG24Ue+WOGMVB79as
	vR8Ani6Ow9XkDDnvIqLgbK97tCCGC7OvBLbx4w7s8W7ClNah+AdhtLcCo9iV9HTx0ICi5aLcBsy
	Ch3aOmap9bzjq/QoWcS+Uvlt+8Y4sjlJySDSvNhs5v323WE237msyHBiKniQc0WZnWMYM2Z66vx
	2Ze2MlcV6GMWFTtixPQIVsKUTlM0MJ
X-Google-Smtp-Source: AGHT+IG1Pua+a+sQ0qZ4QW/DYh0Y01qkTB8IAIZS/QdD7Qby73bidnVcHrczxog/3EXRJO12bNVf0w==
X-Received: by 2002:a05:6a20:12cb:b0:2ff:eee8:abb5 with SMTP id adf61e73a8af0-334a85fdc5dmr10873862637.60.1760816866916;
        Sat, 18 Oct 2025 12:47:46 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f25b0sm3502738b3a.49.2025.10.18.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 12:47:46 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] xfs: use kmalloc_array() instead of kmalloc() for map allocation
Date: Sat, 18 Oct 2025 19:45:28 +0000
Message-Id: <20251018194528.1871298-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using kmalloc_array() better reflects the intent to allocate an array of
map entries, and improves consistency with similar allocations across the
kernel.

No functional change intended.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/xfs/xfs_qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 23ba84ec919a..34ec61e455ff 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1218,7 +1218,7 @@ xfs_qm_reset_dqcounts_buf(
 	if (qip->i_nblocks == 0)
 		return 0;
 
-	map = kmalloc(XFS_DQITER_MAP_SIZE * sizeof(*map),
+	map = kmalloc_array(XFS_DQITER_MAP_SIZE, sizeof(*map),
 			GFP_KERNEL | __GFP_NOFAIL);
 
 	lblkno = 0;
-- 
2.34.1


