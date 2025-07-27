Return-Path: <linux-kernel+bounces-746957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB8B12D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345337AEF91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94217376F1;
	Sun, 27 Jul 2025 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVU7MVZ0"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F1405F7
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583482; cv=none; b=c5tPBD0+YEZmugJNNhw+eHN8Ic84H8HbVk4yw4eDLuLyAZhRmL1MC9ULN0madGum8ncgVZDA9gi3xekq1RMEhC7ho+JMsODkNkULvLQUJ7HL8C65Y6b8AVIVL0squnTD3y61SmR66RVkJiMUsOb3WH1S+7Kv3CpBiP05aglD7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583482; c=relaxed/simple;
	bh=tnn2nroos66y+pt+fAcKyyAnw3FSgfgMBVP4or840QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgPupZKqC7PvCUZQsZGpMaVyKezbN3CoAX+sNLPI0cuPm0zZL8Vd5PsNBFn1qdxef5I4fz8mBVXB+vh11YgMM9gefHLbDW9ZhsrXdXvmX8/LBbBdCP3JLXSfyKJJ+N1W3LZtmKtN3Zmu9ArKKw9Athxv8kk6CWIJzHI8XBoqu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVU7MVZ0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso1862851a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583479; x=1754188279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4SWYJ4qjUquB32s9qM+uQa3+k3zdSDbpNk7y3W1uMFw=;
        b=GVU7MVZ0N747Iwf9m40kFv2z3q4aEfk7tdp7PMq71kIGMgm7wmEIPHluYuyTd3Oxxk
         fsE4E+cQKN3MN58/+0gSogcEJSbDr/sYt5CkNhlnCXfxroWMFLw+fyxD3tqXWavNcRYb
         ZHlaBvXR2vMK8HSn1swdGVmZ63cfWxP+ilsAqSdvRkQR4BnF5820TvqbfaR74dp8XajT
         kr7JVt/tFobB8fASq7z9rnBpIvdZNPGWSXFKCjzjAzs/hZ00tSyZBbdEWJkRGk/nNuc/
         flHRBysqAHSW0iTeT7alMsr8nUpkDTQbB5eOelIQ4fwucL66Y5wY2YX0YxKmLEsVsLYV
         uXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583479; x=1754188279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SWYJ4qjUquB32s9qM+uQa3+k3zdSDbpNk7y3W1uMFw=;
        b=dPSpktZ9LZB8knt8KkKoQlcEutP8iR1SSOaoxqKKwqKbuetcCZxZvkV0JANHJZ9WdV
         UkZkLq+z/nxEDT8XLGX6SiGFw38qyqW8bFMx33VNKxX7xzUY44FHd1DCIuYosIWUXK7U
         b7r5Deccc3+Uwj8grAbwgvSsU+3WVwfZTRKZqWqz7N0M/X7tWqBn6Ng1LAGwn2W8W8WH
         AKgu+RJuhSVLn/llGQay+zE3ggjne18L9Pk73knhm6qgCx9wtOv7zAGsmkycelvh7Tzu
         7ys1T7qkqtZaH3jVd/flHFPH80XLCvifYcq1RC7LRGzAep2nZs1Lg6z3SXz89c1Vnqwx
         uN2A==
X-Gm-Message-State: AOJu0YxCe6ty80q6F0n1RbEiqXWL2NcDXnqEWX3kIZcsSyVa5o2xiUAd
	DdwX7WngKGN88Ir3FrCyoKpkiTmX0a28qKERmWOZR+4PtfG39JpNCbBjL53RTMSf
X-Gm-Gg: ASbGncvxGDREoKZHfYrkP95Exuld9BDV/d2PA/v1U9VQ6Fa2XZmSpzn9Iv5KGXK2hQB
	4EkfHlODYtPMTXXwDlyZR92DP5P4VZifbdqBIc3JDnt0QHqJcqVt79NI0F/OUPv6m/hkUlHRWhy
	KHVwOmm7nJaMGYd5btEhX35p3gQTWJPkDT4mMULbzgkAVR9Mx9qO7kXh6EL8FanTm3HJAJJ0JTE
	sl5jc460T0/0r4ROHKpkNE6IbdBXEm2jUO3fiqdqmyAlsV1oiX44+Kfgjf0Jk3JVGb45ZWUFvIH
	J31GXXEI8Fm8jvv8tz068xJ+iuOX3c1h4+WxK2uKpp+N2suqbpo1MBlx8CDuKO8Igk61PVeAGzo
	252aKANoJMc08vh71r8/bQkaaG5dkh9/OTu8J4rxqRnMqo9f6x07nnIDBWkM57Z9l3JY=
X-Google-Smtp-Source: AGHT+IFlUumYMvSPwSX2IAlslEEquRDvOx/uF7kHRlvkKzslpqWOICEannUPd4JrNBFcyDne4NwHZg==
X-Received: by 2002:a17:90b:380d:b0:311:cc4e:516f with SMTP id 98e67ed59e1d1-31e77b1ad3cmr10107118a91.31.1753583478704;
        Sat, 26 Jul 2025 19:31:18 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f10esm6400806a91.21.2025.07.26.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:18 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/greybus/greybus_trace.h: Fix typo 'registerd' -> 'registered'
Date: Sat, 26 Jul 2025 22:31:23 -0400
Message-ID: <20250727023123.82496-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/greybus/greybus_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/greybus/greybus_trace.h b/drivers/greybus/greybus_trace.h
index 616a3bd61..d5263cbd7 100644
--- a/drivers/greybus/greybus_trace.h
+++ b/drivers/greybus/greybus_trace.h
@@ -339,12 +339,12 @@ DEFINE_INTERFACE_EVENT(gb_interface_create);
 DEFINE_INTERFACE_EVENT(gb_interface_release);
 
 /*
- * Occurs after an interface been registerd.
+ * Occurs after an interface been registered.
  */
 DEFINE_INTERFACE_EVENT(gb_interface_add);
 
 /*
- * Occurs when a registered interface gets deregisterd.
+ * Occurs when a registered interface gets deregistered.
  */
 DEFINE_INTERFACE_EVENT(gb_interface_del);
 
-- 
2.50.1


