Return-Path: <linux-kernel+bounces-819607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C48B5A3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D698175A31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF92E613B;
	Tue, 16 Sep 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuBinTVG"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9529BDBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056916; cv=none; b=MDU0AjK6ABiyR1QuSFTdm4KHQPHVGFjhfiqv5rDhtc+FImvwRCYYDV+eZtyfMZDoZhF9j/pNxB+nuPMQpnGNdwilR94sYqlkK9Y1wgXgIVBf+ffxzBC2wNt051xdJjrcLQuFX6FH6xIWpSBGQ9B+FTf8+Cv1O5oJa2FPSskO3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056916; c=relaxed/simple;
	bh=i5GnbfqmVnxkYXcn6CYjj6fTv/8HIbej9YLPdSgDdGw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avv2Wdn267Ii5Hqi1IEm3YvTa1Wv8SFT7yUNGioVhhb1JGsCWT5fUIUaoaZ+aJ09zznUIboHfCvB7dzQyOc3CRFYASOeuTgI7icCRR6ZoaSaA2eZ+hRqsJub/6inmIuKO0YorJB+GEhc8WPSUGUjVaKkiPHRkXz6Xz6DAu5lqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuBinTVG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso3895401a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056914; x=1758661714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2+AVyP8cdYBqUaKkF99fDBOfCpjrDMFd2oAZFqPACM=;
        b=HuBinTVG90IMNcpKXgiLSo2OB2WK1eAD3fwKH6S6Wmlhyqe2M+grUhKuWqz6Pqf4qK
         1E6UwETSibQZ29DDTHs1vTqFkRAS1mblPo8ixAOYYar64s+XaL4oixD4qIWGwa7uOFts
         olj6Qgh0DZF5gYy+bNtNRghdGjFcD9M2grTi03tY6sc/iKYH/TKCa+MM0+OzUtAQ3w3F
         JMaRkaO6Wy2hwIknk1ruABaY+2D5LEkfJIwgFfhjVAiimLh367oei1JpN6qKGSURoYGM
         0Me+6zmhjbzjLlJfaxOcBmkMZ6mTq0bgg15ycZf8/oyGjqdFlOwmexStRxIztRr5fw6f
         cufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056914; x=1758661714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2+AVyP8cdYBqUaKkF99fDBOfCpjrDMFd2oAZFqPACM=;
        b=k14qqf2zMxMqorMooIHEX2HAVwgoQgTOOK/rojzCBFmIEN66WpqX2OHZYBV9iZdrF0
         AlskpGRn1Xt1RbzbiC9R0PV1yh8DCdSPI0aRpoCJkQrHdsJihU84ygc7ZkPMJ42D0k1U
         p9/FkiAAwukbdn/JyH4zw29mofjh02ZwM4Un0sc8bg1CDLrJmmR5zF43hlYFavL6HcR6
         gSagcWOkXjqqKPeBfYXjZCdrvNndZBevnsw15BCPrDrz9KRClw9VWBumwx/91qDhKDS1
         Gj3m5x5x/qTkb8p3RphtozOlmkSAkTaIhfs3OyMo9KyjmlL6RozNT9hJv2Gn8YfsS6FL
         bqMw==
X-Forwarded-Encrypted: i=1; AJvYcCUC6l6LqrIFIwz3/lQu1KbFsRppQTd0vAu1YqEJwJ5wC1h5joO/ec91MA0WkHwb7DkX7s/iDGmMsWALVRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEroKOY4vCUx3Dcrda9MEGNfKQnbyR4zdbbzHmfe3HuLvbXhA
	T9vpZ9OetSGElq62G8bYHVliYrftIYQJ7I1/TntwT+LyrrWYJq+wR2TG
X-Gm-Gg: ASbGncvnTimuO+Jt5B4jFQwFmHWpng0yA8TnmRD4y1GOlCN14EDACurJqEITGcvXQcX
	rsuB+UTa92I0xkNAkO1UZqv25sT5pCGQwhWwGOijykAihAof2t9/2nqps5TZjR6Wejb7Af7JX/h
	FeNj/mYuTM2Tk0nT4UbDineQU/rY6jImGaw5k5GFCkURp7ABApJE0CBlmuLkQDVQfig4GXGWMLF
	tOltW+A/mil5AshBMmhXuieHEpA/U/kIqGXJ0Br7PpWw7//01uoHY+0ZlMHU6FhK1rt5k4HZhgI
	csgi6Ep3qIsSsCO/5ijqmGuquK4z/5Ge8UYhRksYOo55madrx31YjMAyeWtf4/g364PXvKJ+es2
	nv91rbTYwJ0tErbiCW3BryihKhDLFiXtwkOCBXJKRMcEk2Ky5VLdAJoaMy4Qy4heZ+TVDpJxri/
	Jad0vcgoALyw==
X-Google-Smtp-Source: AGHT+IE30vWEscVxco130cSQzQXEWjfzODa+kIkYNIPjO8BENCWK1VbimiHaV06bj4bFJuwZm56sfQ==
X-Received: by 2002:a17:90b:1649:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-32e1b1cfc95mr15610484a91.26.1758056914499;
        Tue, 16 Sep 2025 14:08:34 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed2705f71sm475216a91.28.2025.09.16.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:34 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] drm/panthor: add mmu_hw_cmd_unlock
Date: Tue, 16 Sep 2025 14:08:16 -0700
Message-ID: <20250916210823.4033529-4-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
References: <20250916210823.4033529-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple helper for the UNLOCK command.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 8600d98842345..953348f9afdb8 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -588,6 +588,19 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
 	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
+/**
+ * mmu_hw_cmd_unlock() - Issue an UNLOCK command
+ * @ptdev: Device.
+ * @as_nr: AS to issue command to.
+ *
+ * Issue an UNLOCK command to unblock transactions for a locked region. The
+ * region is implied by the last mmu_hw_cmd_lock call.
+ */
+static void mmu_hw_cmd_unlock(struct panthor_device *ptdev, u32 as_nr)
+{
+	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
+}
+
 static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 				      u64 iova, u64 size, u32 op)
 {
@@ -633,7 +646,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	 * at the end of the GPU_CONTROL cache flush command, unlike
 	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
 	 */
-	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
+	mmu_hw_cmd_unlock(ptdev, as_nr);
 
 	/* Wait for the unlock command to complete */
 	return mmu_hw_wait_ready(ptdev, as_nr);
-- 
2.51.0.384.g4c02a37b29-goog


