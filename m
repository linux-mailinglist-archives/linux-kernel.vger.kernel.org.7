Return-Path: <linux-kernel+bounces-807136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A611B4A08F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974767AB701
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA02DAFD7;
	Tue,  9 Sep 2025 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjHshiue"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E923F405
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391440; cv=none; b=p96u/NQIbr3K9XyN8kkGVC5KQHddcKgVBfXwu3UHjUNsG1cf1BXWrfvUyV6cB6HIUwE5TMlqXTKHXYP/xMptpZaifj9QSW0BkhXbNeGJ1XBYynJo/IjThChoYEtTubjCJe+h1m5WwJtM5arXwQhxsEzA6i4yyqfaSsu4SvvDuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391440; c=relaxed/simple;
	bh=WzfDYZ1/295BDSpNZdAsFTCdD4z1X2KS9R3h2y1gY2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5E+J+C3DWtMulLzHdsU7ZRS9H2UB0/UnaahZAUDDJzM0cJgW4M8RqMou18jGVTLYLY1EwdGwLtJXCz79SnEFZ02J/8AVlRQOHVgeXPQDtWbNAxsG1xgAH3Q3neyoZRmFOxIInF4mugPuKdZSCndwhiDB2gLUlnwGhZhjmlWy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjHshiue; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso3289585a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757391438; x=1757996238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez6ws/owLuMN5VyJ05mQBNBzD0cyX1jnOdsu5qx93Ps=;
        b=BjHshiueST4khVSI5H0dvjMaDjqDHRegeqt8Nqe4rCBsjrBNp3bd6kJl9D84aMACFu
         q1wuBwAWeFUqkl37wUmEEqi3S0/1mBqyrwz/hEIFImrkqtsCDWrd2bhjk9NBCTSmO43i
         r6RPYl7KHR1A2MxQmRFzq/Ud9OSkGAODK72oKH+29OAmU3qK69k9ZAJxcDyI/DZQGXrc
         3UIqpZ32dnB8/1twKzPglg+tyhq3OkegYzxE1xFCxC2215pBf5Ah+Vxvu+gJMgnN5Pb/
         Wgx4wBsMxUpxw518lUytjiLDa2CQNXpezpPeExrtn6UV1ChnxzhZURaPVXcoO5pvLVm6
         2IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391438; x=1757996238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez6ws/owLuMN5VyJ05mQBNBzD0cyX1jnOdsu5qx93Ps=;
        b=Z+MMLboVT5nvsZWlajt0Y+phr3W9y8SbtONNplWOisvU9a9RTWZ+HyOmXY47gVc/SS
         FZTqdhJWJzSY5p95ZrqsSosHANChvS9TX60rvcrfFm/g4cNSqGZ/S8yrdaIi1wHHeO50
         LaUS/jGgwQJE4k6SVXb0RiBWW5m/j/8V6xTsLtmQ450KLqHgBId23gtiNUixftrzjYL3
         iAtWN1TCCoURm/UIaf27ik2va/P7s0XDj+hjbpuKPWA8UvHSZ0pSxosiJJVAEFCkrt2+
         urrruqA5LWzUYamwe4P0qHuravGkUC3mLGWZvHPY7T9cC+JIJKJL0wxdtbQBqYGZm0RV
         odmg==
X-Forwarded-Encrypted: i=1; AJvYcCV1kxMRdgF0aJ5qopQUfc6Jtj8BbNbe0o7PZ+Z36hIsprxGRh3xnPTEIBumLu4MozGIWG7H/LzGGiiSbmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoT6VaocsH938Uu2lCKinj0OJ0NK/Nn37zvNpjMsac4E2FuYxb
	0VOG8UieX1idpxg6dnt5JkEbJGDWLiD3wQGmAygsdnJoef2vJ37kbW5J1279n/wCgNs=
X-Gm-Gg: ASbGncvLf8hBhH0aZqE6ezydfb79yF3kxwMxftcm6Qawb1lD8+MxK8/gM8cmK3101d2
	NGWLTq2EVH/2dB0OTdYTn+v0c1ZTdv+0+tKjpj8wvUQe05df7ech+D2P7MqAB4RC+NNc6yNNdLb
	2JhMCetGwb6SeK4ydLhsECQ5Udk3LyiE3I50a7o+FPCqq2xxWAAapy9yNFvKhL0mMlc5U2pa2s8
	zKI8SdSA+SO64rmqEHdvQGK/5POZorOyZcjEaJTWPymU/x9met92vwLj+cHfi3qdWVkYPahjzw2
	LHIkE/2ChaaIcR6+/J7QyFOZt0CxOGBoPzhJHVisjvtk+CqUZCEKdeDzpxyK4KaLTUwkknHPLro
	GojAbWIAetsXYrYcdlRgUY4MOj4sxDOaUDrMnL+R2
X-Google-Smtp-Source: AGHT+IGzK1092pVJREpJAKVPiRzEhUau1GpXgrcz1XiLkQShk6Jw+e+QnC7Tw1XkjiDyvKNRr8g40A==
X-Received: by 2002:a17:90b:3904:b0:32b:6132:5f94 with SMTP id 98e67ed59e1d1-32d43f95d02mr14142423a91.21.1757391437861;
        Mon, 08 Sep 2025 21:17:17 -0700 (PDT)
Received: from localhost ([2409:408d:3e07:67a0:20a1:b9c9:f581:f3be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e488esm562919b3a.2.2025.09.08.21.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:17:17 -0700 (PDT)
From: Gopi <ggopijeganathan@gmail.com>
To: 
Cc: ggopijeganathan@gmail.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Declare processor directive as CONFIG_TNT4882
Date: Tue,  9 Sep 2025 09:46:54 +0530
Message-Id: <20250909041707.3001-1-ggopijeganathan@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warning massage found by checkpatch.pl script.

Signed-off-by: Gopi <ggopijeganathan@gmail.com>
---
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index a17b69e34986..918a4cebbc6c 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1369,7 +1369,7 @@ static struct pci_driver tnt4882_pci_driver = {
 	.probe = &tnt4882_pci_probe
 };
 
-#if 0
+#ifdef CONFIG_TNT4882
 /* unused, will be needed when the driver is turned into a pnp_driver */
 static const struct pnp_device_id tnt4882_pnp_table[] = {
 	{.id = "NICC601"},
-- 
2.25.1


