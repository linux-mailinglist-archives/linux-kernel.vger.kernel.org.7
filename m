Return-Path: <linux-kernel+bounces-790642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE5B3AB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAE1C23930
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEA26E6FF;
	Thu, 28 Aug 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYcS4YG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525511187
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411473; cv=none; b=i2W7a4ho4fUY0kp0P22J0ZbG8DVkEqqbwXKDoEn2O1BD40ooEcLqnBHHkOQt3d/2GqNcSDY5237z19U/e6tYLFsuCdMVPtj9cCA2QKOqdKy4i0n+96QAujvrKAG2DsdcdQC3UdKuyADLCUnlvwTsbaDXy2p7NuA+Dcn9L0gqzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411473; c=relaxed/simple;
	bh=lJJtbOn3uVfo2sZeGj6tKDlyaEBAGHI9cPnyCNgz7GE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o4O2wYbE5z7hV9eI73WXt9UdyA21oaFPzqOJEa8kgA2JCxsjE2iYZTV00G0SF+FUtqvhp4Kci/Ez/sdzO/lWmXgYWXI5dLAdhkTjRH7thog/wP7sHaXgaO7gnejMhFlDCj2LO+0jsCByL8qtccUQpm3UQOQRjSCE55h1zF2Dc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYcS4YG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7720f23123dso1373701b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756411471; x=1757016271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgBwgze5c2UdQqNkQjeB0hL6toTqJXIIsEOJ6SdZPhA=;
        b=WhYcS4YGlDsAosmPe2w7rBdmfaDowmWnL3+EWgMueTubABVt826s72OOqOymxp0ZXY
         CNEAhk0f+uKDIAFH6/jH/mzkqi2S/CHY6/6jirIFUDSSb5F/lC1+KJFqjP5SNk/iTRqX
         VC3/GjpcFfutQJI6P7+UKSOAszB1vaBLKTMB0cyO4tREDWlMxdLIQomeas+s67NeTwS/
         5v4Z6f5B+LDbkgk4RpeVB+yavKaIbkd7wxkB5VFnFkX9O+RQE7R/FdM/4IGiNdkh9Cu+
         PNzW47pzJnV6IDsStk/wX6BTMWtIGjxZbqyKaVJsDHgHvi5KMUvsqDlTAl6SWWlxLLZN
         v+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411471; x=1757016271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgBwgze5c2UdQqNkQjeB0hL6toTqJXIIsEOJ6SdZPhA=;
        b=qnaeK8EStrm2yhGU9t1hy0yXdhsYGhXT7zUgzsQKxkvxPdA0U10QqWNDJWqt7+NSbh
         Fry7DgVPIlrfmCLMLEIDhBnrHVFFiIbVlHI3HQHcCYfssa0+C7zfFOd+pq38Ovpl2LZA
         lnxQOwwn6ocbGCjXHMGCSyc2ltDEnm34SeyJOsXJpESRUGiJ+KyxZqsWlP13WP0wB5ZE
         jHdsseYykJv4aCnT0XoEuVaEYZ2pHrXXbqfgLpZ/P55SQ5A4EEGUF2D5gtgtAq5aGIEE
         sbfAPQQJg7l1ustcxjO6XM+Yh4buIaI4705GV/trVTI0iHM/G0995bzkVersVt6huDIS
         4PTw==
X-Forwarded-Encrypted: i=1; AJvYcCW6LnH0P1q2QlBLaMdaILEvgppxFOaW2uRKzSDuCk6beWjKhBldYzaJQQ6uKUfpeBxCWRIXj9SfcprqMk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtXXR5uYuJxSZ3tmT9za2OwKBkkDEYiEsqnMOyXOsg5N42RXc
	+LhhzL1fmv03/dSDqlaDhMd9p0Fjo1MkBePKO5bfZvoIcdQqZHAIyv13
X-Gm-Gg: ASbGnctnsOS/vau0rOSRiDWvekfNx4Qj31pwFT3+X7ZQOnJ8iZyzxQ19QxAV7FpVll2
	rRac8eB+iIY6eoGT1InfooemnuC/krh2sCsCnDlhIUyzCqRxiWdLwPXLJ9aYWHUyIUyxgD03Eu4
	xeBp9yqITDEGBhkLxUEFR43QMajEfpoGhav9SEh5A4TRAc0vkRDfWcGfL5ts4AUH8Z+ainkE6Ga
	MwXmBVJJc4fAKafHrmusAw3fQ2TRBsKfMq7ye1B78IZjlimW7oHcWsAiIMmh8KOD+4hq0k+qxbe
	8XwB/R02m5frf+IRTHy6QNrGnxnKzvmBj8SWENkxyYsS/btq/qzJqQJ3OmTAVH/Z6uxOI+n8xaw
	0CL/IMarEywBwv9DfAgLMaVz7perBpIcRfVkIKV2Y1n/K+tGS1Fa2+A==
X-Google-Smtp-Source: AGHT+IGmTwpUPPdaVGSqeg327GXXw0GgBhct6VPdgjMR7zW8CaSu9AGMI3nYDEAA9IljAAh/s23DZQ==
X-Received: by 2002:a05:6a00:18a9:b0:772:553:934b with SMTP id d2e1a72fcca58-77205539ac5mr10186281b3a.31.1756411471335;
        Thu, 28 Aug 2025 13:04:31 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a2b8097sm289868b3a.35.2025.08.28.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:04:30 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panthor: always set fence errors on CS_FAULT
Date: Thu, 28 Aug 2025 13:04:19 -0700
Message-ID: <20250828200419.3533393-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is unclear why fence errors were set only for CS_INHERIT_FAULT.
Downstream driver also does not treat CS_INHERIT_FAULT specially.
Remove the check.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

---
v2: add rb from Boris
---
 drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ba5dc3e443d9c..231f42c67f175 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1412,7 +1412,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 	fault = cs_iface->output->fault;
 	info = cs_iface->output->fault_info;
 
-	if (queue && CS_EXCEPTION_TYPE(fault) == DRM_PANTHOR_EXCEPTION_CS_INHERIT_FAULT) {
+	if (queue) {
 		u64 cs_extract = queue->iface.output->extract;
 		struct panthor_job *job;
 
-- 
2.51.0.318.gd7df087d1a-goog


