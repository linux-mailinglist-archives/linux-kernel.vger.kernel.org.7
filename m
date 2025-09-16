Return-Path: <linux-kernel+bounces-819612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA453B5A3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021711BC81C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C087279788;
	Tue, 16 Sep 2025 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPkBZrZX"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A32F9D8B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056921; cv=none; b=nbN5NF9YaOuTE0Kd8EoO0FBQHe6VZmK+P7f+NBYg+OOZoZUjRHcFwuKadxIGot690lMImj6iBxSy67j3b6llDIU+7aNOXKtwkYyoVHtOrhwK8sB9CiDYIB/3z6gTYhuBy/GN15+Yc2IrXwxsgXyBM9JMlviv+jUxIIvalEBtY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056921; c=relaxed/simple;
	bh=g8r+ks54v9dybf2ViYkv2fAzghPaF8NZFWnTAX2RxJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwDF1J40lb8o0CWgJKj+uh41Gr8CPfPSZ2ReltYO23fc0iFbYGvO3p2mm5Jyu0bTWqJ39UyKSYac+ZkFvvrUi+H7QSyBpIyswFji5WL6lKNrvABXAGNocajyGQRXlXF4etyydPL58XoN09EGR9sNSMviXpoozHL1zLxO37g9jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPkBZrZX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772627dd50aso269167b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056920; x=1758661720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/slzqlLJOnOVGiOw/1xh19ooiMbxqONBzW53uf/ZwU=;
        b=hPkBZrZXyENgVzm8JoO5E3Z0nE1GBJNcJbvsTKw2dZgBk0J5i/I4nlHKsrnpZ2d2x8
         o9oPTuSfctj1Z1Dgk7EnEA2gt8G4++0Prj2JVd5tWpYd8mNOuOvcHoj1aUn2ClrZS3I3
         oCjzkXzHZI9gn5iZQV9MkNCbgE0YrVn1f8gge6DarSYeoq2nzVseAC6KpP6eFkv8r6HH
         mGh8GICNMppU6LyEeIRfx9uaSidPQm+mW99dCztbwQ3HE/fsVLm9TCexNIk1bD5zojS5
         d7ry/4qPjHrd3sEpaA+3RPX2+Y14pAn+87ll9FR8qNkAiQp0+dDCygkNLOF9UXcooG7b
         RgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056920; x=1758661720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/slzqlLJOnOVGiOw/1xh19ooiMbxqONBzW53uf/ZwU=;
        b=ukak7Ens+blXX6Bk4eooSZK6ri8BNWLNQ4ABAn+aLq+I8u0NpiTxjp+24MNZ4H8fgQ
         zv7diBBibVp6fMOoOsXdh261OxgHDseHp227N7/iTCRrayWThmvhUWx926aT8N9dqB17
         2SGgv2Fc/sUO/640h9xQwuMMvHoDrBrMgJvTcpOCa/MiEPYp+y9Lyfx97l4InwlLtL3R
         Q2MGC745WEHjLzDNe1tmuRin4yXY5UmZxdFaqri3rYABmcbFX0tIxYH8FCiFN2HO/d6/
         eGlM4yNzEjSfTbCbFpAcnBitInMKtN/jf5oN9O/G+eP8oGZpbcrYY0To2UNlQmzVi86g
         FAJA==
X-Forwarded-Encrypted: i=1; AJvYcCXmagfS7dFq7thcsN+Nqrl+xv7AdjmTY39k/kV74wq8Lz9J1B7un6QITXVpJk4XQsjXm8R85gwjZgWj8LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHvesY3cB56qKhoxTzHTb6XsK997zgO8MhiGWu1AvYMrGJ74L
	4lCjeCeHY6LzXd9ICIGpT1IAQI3mumR+XBoy0yC45FuzxwqqH1O3tcPs
X-Gm-Gg: ASbGncvrsryzUIS6I7RmNMEVNUcAImy5lthih8692VUreikx+e8XZhIBFZibFJId6WX
	nDr1yf2fUVo/11yps1chhC4JkkS/Ubf8YBfx+KBVWmZe6GgtESB6TogOI+2rJsNwBe6nGI2BmFj
	JQX+0r2kr6hvPdAxrKpss2mGQLHvghDc6NeXga2n5QVI4LGs9iBrK8d49gZOwVEm2/C61oxT3IE
	U6Nnz4t3VBN/YYn/GF5h2nUwAE51ozehDNXiE5Mey9hFsiJehgiZg1oDETZW0uwq/7C+uNYqD2f
	GeTSb4IwrUMImjNoYOac1kjOeOJ4pJ8xFt/dh1d4Fai2LRRRYdGnauoocMWX4dPCSn8HVkpBmiS
	zU8BGgGYpqZcpVshnhez14njk87brkqLelWEYrDbfi9cNUQ6QRl2AnZuJKxcgq33316x+u7Rx3Y
	jRBqIRl3Remw==
X-Google-Smtp-Source: AGHT+IGaSqCXmkCvWntJfdqwVvWglhlmjBWBo1jmfj47qk487u4brk9LesJPyS4nP34oL129zDzRrg==
X-Received: by 2002:a05:6a20:7f83:b0:262:6310:3fd4 with SMTP id adf61e73a8af0-266f2877e86mr4416762637.22.1758056919730;
        Tue, 16 Sep 2025 14:08:39 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7760793b65dsm16607420b3a.9.2025.09.16.14.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:39 -0700 (PDT)
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
Subject: [PATCH 08/10] drm/panthor: improve error handling for mmu_hw_flush_caches
Date: Tue, 16 Sep 2025 14:08:21 -0700
Message-ID: <20250916210823.4033529-9-olvaffe@gmail.com>
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

Bail when the first mmu_hw_wait_ready call fails. Be sure to unlock the
region when panthor_gpu_flush_caches fails.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index c223e3fadf92e..436a54e30a36d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -653,16 +653,16 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	 */
 
 	ret = mmu_hw_wait_ready(ptdev, as_nr);
-	if (!ret)
-		mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
+	if (ret)
+		return ret;
+
+	mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
 
 	ret = mmu_hw_wait_ready(ptdev, as_nr);
 	if (ret)
 		return ret;
 
 	ret = panthor_gpu_flush_caches(ptdev, l2_flush_op, lsc_flush_op, 0);
-	if (ret)
-		return ret;
 
 	/*
 	 * Explicitly unlock the region as the AS is not unlocked automatically
@@ -671,7 +671,7 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	 */
 	mmu_hw_cmd_unlock(ptdev, as_nr);
 
-	return 0;
+	return ret;
 }
 
 static int mmu_hw_do_operation(struct panthor_vm *vm,
-- 
2.51.0.384.g4c02a37b29-goog


