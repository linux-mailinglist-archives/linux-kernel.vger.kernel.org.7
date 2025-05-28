Return-Path: <linux-kernel+bounces-664939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C45AC6269
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56454A1229
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A4243378;
	Wed, 28 May 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qi97K6Im"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F63A1BA
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415318; cv=none; b=VZVZzdAsZsBvDsQBUEV2rckJKY+4OIxyfS5+utinFaUCUynpkekxAk/o4mnolpdMB8lcc8wWuICto8mfUAho3GPklEqsOUMmki3XE6IKQKUBcwO54NJ92alg3qFYa53eSNUO+KVoNqoQdj0bIxrUuUKngSJGac7z4KyDyulPNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415318; c=relaxed/simple;
	bh=KApm7B2lU6A0X4XyJobCSbS/ALi/O7hpGFyTN7IgQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG6lyXj0TZYVytuQeHz5CFMbRVAVfe6pVh6WBOPspyCx8I2SE+lg/6ZKm/M5UC8N2lK04Hhh2itnBrAW+qXKbFK9OHFvO3519L4+M9uUGVT+m/hKxl4aW3i03lyGLShBL4kzloje1lxiHD5Nwz+sE6oQboKYu1SoN29/N4qU2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qi97K6Im; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b9dfb842so10218525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748415316; x=1749020116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6C+2QOW7/ZJEC4rlOPPzFqqXSyx5rUQG+Wyj+dRbRCg=;
        b=Qi97K6ImNTX8dDNEXUO0hcJ3ZkHZr94CcWPnXhpZztw3Po2w1Qzt74TqE+Q8HmhutI
         JK9tfWVLxgC6A961NIZ0xr8ZoDmb2nj5LGlLqBnoievnkEAlMLK4ObLqW4YD6xt82Zjx
         Fs4EaMVFJ+izZXUave0K1AK6xpyJR4lojAFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748415316; x=1749020116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6C+2QOW7/ZJEC4rlOPPzFqqXSyx5rUQG+Wyj+dRbRCg=;
        b=AlAlX1Mf7kvjtVbn0ndrYtHTOzEKmyIa2TM+tUu1g4gqY3VRtxBabkxb4l0CLYxalg
         kM6zZbSiS4VtRmBcv/1fO5steBSonB6GAMY6R7wLcCP3UGoJOXbjSoLAmDxPBto4S+Sm
         nw9JsTwm6FtoR+BWyLVi58qcJdPASM6b/a2p+zYLH0dIW8UYZl0wP5mCLzeqUS2/TBK5
         yTkbVWwHzvpAtLgRl1QbSaR4g/SDwUh2KFa+a+Q+/YOPJtgOusYzHWL3Ge2/YWRB0vg9
         uTIYQt07O+fUMHvwPt6CWglajbB3rh6+boUvaaUfcgYZLwxd2y9IFfAAW+/piGYIgzX2
         CIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumsmkrQrfSZNHeCjKhD7eSdhc5h4pulRAkWDBX2viKkuaWmbC3F17Gferf5t8qLT6SsJvDuvoSXcdpG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/mmMK4XwSUm937ufswmvn7zQ4Nhq38oLqfLZ66OzmMYoJoiP
	78IDwAXMlP260LKk5mFoUAxPK9NnZTxtM0UQD7zsObJnM7jBcuLs/7YncRE+ySVuu0i1WwuwXBA
	VAwA=
X-Gm-Gg: ASbGnctL1IzzKlzS0a6pwefsKR6I1V6g58ckzTKKAknB4OQgmISFtc+tyo2uoOsSivE
	bVEYPiuE89UGbb9pVFQ+18TUtYM66ATC6hSyJseO4v9j5FS8JMLiRnRi/zlNMphvm9ACRpnRpJ4
	yBXQQwWdH3EjsBR6pnjXPO9lA3B50cNiwIaf7d9CE3bs+lKUYEv0m1s+316Mdi0c5hmJ+T9paxg
	MAFOWSqciNdIzCIub3lrNEZ3+9TX0Z6WPRbZ3UAcNj6ApBGnQrmv7WBbLEckEloM/8ED3rMWneD
	ljvgc5Opmcvwxi2OxbZuldFHdyOIHt+5qS+XaF6eLuwdFXIbCdH1X7ZYWl6MnQyIqa1ACgAgfrU
	=
X-Google-Smtp-Source: AGHT+IE/QtR9qQUd+B8NC0qRL0iwl3NZ+QPWzLqIvwbbP5nfveyy0JEebh4jUyokCIMZHNZo9wpIvg==
X-Received: by 2002:a17:903:244a:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-23414f3343cmr230103605ad.9.1748415315890;
        Tue, 27 May 2025 23:55:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88fd:67f2:b90d:8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e3da5c37sm670902a91.24.2025.05.27.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:55:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] wifi: ath11k: mark reset srng lists as initialized
Date: Wed, 28 May 2025 15:54:27 +0900
Message-ID: <20250528065510.2790649-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath11k_hal_srng_deinit() frees rdp and wrp which are used
by srng lists.  Mark srng lists as not-initialized.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 8cb1505a5a0c..cab11a35f911 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
 void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
+	int i;
+
+	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
+		ab->hal.srng_list[i].initialized = 0;
 
 	ath11k_hal_unregister_srng_key(ab);
 	ath11k_hal_free_cont_rdp(ab);
-- 
2.49.0.1238.gf8c92423fb-goog


