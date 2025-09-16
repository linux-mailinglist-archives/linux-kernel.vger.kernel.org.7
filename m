Return-Path: <linux-kernel+bounces-819613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC9B5A3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EFE188D20F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8231E8B2;
	Tue, 16 Sep 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is7gZpT6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B312F9DB4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056922; cv=none; b=BfUKMKuBWhTswl1YtvGCIXLD1ctXmZrv6SSnOXMpZnpwmZtkpdvOyGEvW9yLy5ckr09GqFKiz6BLtbuk5nxMvxh0ZA9saixgwODk/NotuHTegV8gqwpqOkz/UQNcOcBBSCgpwscwup0FgvX1EkcsqW6eZEeJUqBGI4cqBXHWx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056922; c=relaxed/simple;
	bh=SP2sHPp0DkDMUcw5AMcR0cHu5SZWLKKZ3sGqnoWbl8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMuQk6XQdq6ysZzpCbRQCbRn8LoLuySMfK/NsJfcN7RqM1Rz0TBu4hrOddpwljff8/5Wxhl/Fuyt5ZPQ9dXuCzK0VlDkCVyXx6yRJQFjRoz67EuyXTNbdNPPfb7Qi/QtJJzUn1ldPGzG5eYJfBQBvE+ZlzDwIzRZqxcSMfal2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is7gZpT6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5229007f31so4048376a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056921; x=1758661721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ajRjJ63Iy7rbFQ9znyyl9iKKEEIo81WL5RMkNMmqG0=;
        b=is7gZpT6RV9XY10M6B442yAqGaYbYunChwL+JsAW7euVPNhz8v1Bg60LDeZ5FRkzkk
         3GkxSpEYbx+KFvaeBPvJ2VHQnOL/PCJjsUkL04PmyfqVAk3dp0PvQ4RSD+30C0rvsF55
         107SFj965yX1HZifkbrLEenMpHWBLx7ZgwjeEyTFSwAAiDGN6whXk1t2pQ26SvL1rpze
         tPb7UbmyI345Si4oLRKmtoY/pwiGRNeNH2Mwl4wv/c6OU/NNXoY8klPv1Y9gSSekT2yF
         cTpTMZMhi96ri5TrxNR2ZziWaH7gkjRXDBHEfUk3MjMExZbT4m33jKTMCOTaCzq8hHvN
         5gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056921; x=1758661721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ajRjJ63Iy7rbFQ9znyyl9iKKEEIo81WL5RMkNMmqG0=;
        b=JoZKLUK0SzcSSKs9wX1uvL1WGir2wE9rboXW7qXst1j6uxXVmlunbgXlSE0mexHeCq
         J5y9HaiN8KDD0+M4BRiPsfbYG65t298D+pnFqedfDSD8o04RJP3eGfnprKWMVoPztdcb
         pfWX3g2JL4kWRE9Sy69YgU6qfYI0WnsnIYp4Oyi0LO1822UuJg1ZFEOcoLSXbRW+e+qQ
         O+pQ7yYhXRiFpEijhGp/Q0aNnjwuHD90vLZBvPbxKY53yCUAtx3fwsyGDMk6UPcfMZ/P
         /32YQ1aKnYYQIGvKKqC7Pv1A/c6nmlGjEopjVH1GCaKyW6pwcWk0hIv2Luxr8kiJCG69
         BbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1WEjMZ5cl3cSXcqIjrKl/qeGo2zfcWZw2h/+jsjj5/kpL3B7rpTHd+Sgwl8UZIbkSb8Rh3m8gChqExE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKv/xUjyL37LzhT2jQgnlhboc/01jQogkXM/0QYAeoncShxLRO
	GH2/SQrUc6ONojCmwG9Ylrj42a/rIg/SA9jjsRtBO9M3I8xVyZxY7SDS
X-Gm-Gg: ASbGnctri+fJNyyAA2NGhbGdU1IDB5s4MAoJxFsOsPAx/YaC8czae8MzGQ8jM6/Atfl
	GVRMH2rd6u7If/7otu3LwWVoGp4fVPyJZuBeJTF81Mt7cIsphyBwsac3d7lUjP0bD0scLEYrLNP
	ySqpxa5+Mw4u5q3b7qTHRUMZLToMlyFkRylhm+SfOhzREHBfL9QCcY6UHrSNCetnikZji8DOyLQ
	auHnRhaCm6SgrYROP7doM74W7M8m/KUOW4i0h2iC91WjdWxv4Hwt0BWTzvqkymfo8LNH8DgWKrg
	/SEKzyObvhZqZf0iM6vlCGB7nbovIzfjejXyx6HUZ8aEWaM7L+S3zrP9IAaiLJst0Ep1Xjw+yT+
	eDuNZlDaLBSGDMHETX8FVzE+7XX/HehOWm0lV0WpYeLSvDNkbM8gudnKpxah3rq4iLO2MqxpItG
	4tWOamEnhraQ==
X-Google-Smtp-Source: AGHT+IHhPDuS6+StVaolktNXBb79Xxy3Tz7vX4HDANHKZKnch8Zg/57u1MSLxGZamhZZWwIp1u8D3A==
X-Received: by 2002:a17:903:3585:b0:246:b46b:1b09 with SMTP id d9443c01a7336-25d2686604amr200001855ad.30.1758056920763;
        Tue, 16 Sep 2025 14:08:40 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed26876ffsm492508a91.3.2025.09.16.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:40 -0700 (PDT)
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
Subject: [PATCH 09/10] drm/panthor: move size check to mmu_hw_flush_caches
Date: Tue, 16 Sep 2025 14:08:22 -0700
Message-ID: <20250916210823.4033529-10-olvaffe@gmail.com>
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

We can early return from mmu_hw_flush_caches when size is 0.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 436a54e30a36d..743e9342eece7 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -570,9 +570,6 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
 	u64 region;
 	u64 region_end = region_start + size;
 
-	if (!size)
-		return;
-
 	/*
 	 * The locked region is a naturally aligned power of 2 block encoded as
 	 * log2 minus(1).
@@ -643,7 +640,7 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 		return -EINVAL;
 	}
 
-	if (as_nr < 0)
+	if (as_nr < 0 || !size)
 		return 0;
 
 	/*
-- 
2.51.0.384.g4c02a37b29-goog


