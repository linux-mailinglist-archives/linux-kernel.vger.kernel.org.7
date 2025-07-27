Return-Path: <linux-kernel+bounces-746963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD1B12DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520C93BDEB2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB718E20;
	Sun, 27 Jul 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggRn0vRw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F2189905
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583534; cv=none; b=civjJsa2VQ4tuP+Kt/6athHeVfiXPr8np9ZV3ogfoy41bZBQSxX+gG2X6KfSdb0LPmYPVgwmQZ7Fhc4UKtXzeJbNv5wvXoYdILtbRT6gC3deL6MdKy13Yy0JLwykQaan/nXJeU2uRkqFj1SGcz/zXW/KEvOnwRiEqfkZ6WkK/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583534; c=relaxed/simple;
	bh=K4FcsDyIKYbmn/is6OyqRKV4gxZbltwFjVZoU2OMHs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6N/WO41XP9lDG+U29Qanwr44XQ+8M5/REuammSj6/lCuJVLz3P5LYXDfMOmSE51zfq6KBwgWe3V0KD0IBnXCrusl4lyNYg0p8+Ug9nkrsdAigfz6b/IBo01ggYjDtbYukxq/+0W7KOQRLp3bI+p3JWldbEMuKv6bK4pjfuPVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggRn0vRw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7490acf57b9so2284592b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583532; x=1754188332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axnjAEEkHqBoK0YkqHjBQGwweDoF+0cncozqNOETcis=;
        b=ggRn0vRw5M3QoWbnA5Nwp0Bxcqn0ec/Yrhx6XPjxvN8O6aLhFMcXsxHdYrfYxt7fAS
         mpnYpdonI4hPwQD2qdNvApZFQoEgRlQlup6AB/xRm0HMy4t+RNHtVv4cHIR09aCz9qJD
         DCUiAxWzq0wVicrIuf2bxUi9SrSPpUbXJaVt2OHEr+/s+AlY4sabTE3luaAH1nURlf0b
         atQ7oxmiwZew6rd5mzBnjdKnKWe21dEs9vLOZ/pok7wOI35UYEFMjT9UDsIT7lgdkPIq
         b3tkfeuzBcXwKBTl0L1Qp2y4O9PQqUg9wg2Il2mvpawEh/jjTGdJ6s/STjwbJ4gvdMir
         mTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583532; x=1754188332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axnjAEEkHqBoK0YkqHjBQGwweDoF+0cncozqNOETcis=;
        b=RBsXi4gpvNbr4TnaBg85ZDhXbfwjITWV7R79YMyUv/k1ypFmJXeH9J7ghFBdeqChCf
         7EaCyiadCLXT3YD4b+QLzGD4p4moTKl0fv6+p6va7KiSTkiWsYxJLR8YzO5/Yh1xp3kk
         8Ox/nc93f+Lo/7i+QoqG70ETWoKsRl72VQdub0oeY3RB8Hqs87pRviN6tYhTQzhR5PtN
         Oz7ASgu79hI9Ng9AOk6XvJ5Zf4n5JlOpwVobdFoQU3q2gnjZMQG9BjveC4GMZD3cQpZs
         T+u8LPmQyPrxyJOVgHrGODZzw+8I6n+LS+/iixZYdqUyu1PDgqQEjyKVgFc8ni3f1Rn/
         jlYw==
X-Gm-Message-State: AOJu0Yxnaiz8XmxUw7DhIa3qYJ+bw9BumUDhzfdjIQaCFeepTVf8JAoA
	u14NRNE05DmmWWBHeJDray0nSbbMVx3ywjpt5O2o8VMmoQ/QyRh7zadzJLNfCLw1
X-Gm-Gg: ASbGncsadXyEdWTR7ZudcPU98RBTLnHNHeL/iCBm5RW44i6TQ40jwmfLDqzTmNLRWmA
	qbdE2+HqIQpdIM96GlmvxqzEzHfHn3JF5CQ3q9BAxDVs6GhZcfefeZWY25mgmYJgUnbb7mKoQ7X
	q73lyWtIoIBfu7AX+KhmDmDana/Ck7Onk1qxqBrZKUT2EeDmeMXnPP45ASEetS090Fw0vQZrfl+
	ppl4h8wETPTOXVKj34HNViHVr7+QdLHM0GbR0wHhx78n/dNMOE4owkS/qf87JMoHt419JBXRlGx
	GXheu0lQ4HVGVWOsYMrW/4vGwS4D0eox7kZdr7GML23tDqZlTaCyL6/a61G9KQ3weyY2p20r3XZ
	zkmIqwLQMzyneWROBLZPqO3uy10BAN0dAhq/75MS+v3e/S+0ad1uvAB68AHOHpQGcsuQ=
X-Google-Smtp-Source: AGHT+IF96Y1o7Pw98/pg9Jz5Uq9BsaqZhxuPdxY+3ejaohDxzL+58sW/rAQ/P+UimYKS3jMRI5bTmQ==
X-Received: by 2002:a05:6a00:8c6:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-763384cc3cfmr10283775b3a.23.1753583531892;
        Sat, 26 Jul 2025 19:32:11 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02706sm2627579b3a.39.2025.07.26.19.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:11 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/net/wireless: Fix typo 'recieved' -> 'received'
Date: Sat, 26 Jul 2025 22:32:16 -0400
Message-ID: <20250727023216.82709-1-ignacio.pena87@gmail.com>
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
 drivers/net/wireless/realtek/rtlwifi/regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 0bc4afa4f..fd967006b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -206,7 +206,7 @@ static void _rtl_reg_apply_active_scan_flags(struct wiphy *wiphy,
 	}
 
 	/*
-	 *If a country IE has been recieved check its rule for this
+	 *If a country IE has been received check its rule for this
 	 *channel first before enabling active scan. The passive scan
 	 *would have been enforced by the initial processing of our
 	 *custom regulatory domain.
-- 
2.50.1


