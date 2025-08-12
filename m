Return-Path: <linux-kernel+bounces-765301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78462B22E55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E54016AC47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9A2FA0DC;
	Tue, 12 Aug 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8HjUILw"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333E2C3242
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017495; cv=none; b=ahlcEOhsa1juj/WCxqn/24DInKvCyAvBHP9f7sB9cA8unPQ0NkDx2q2AcdgXp8NRdQoeEX+GIT0VG/W6EnwISKizF+2N3rHoGRsLl7MvFybAe7smYFGm7dwIuhURNJFyV/aJYzXWJoFi4HUlED7PMiGCitXIqf7oPAru77bqi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017495; c=relaxed/simple;
	bh=DXxIPISlajUjid7Jsn0uzN+YGdBZBe+YR/pnm4BwPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDQLQnUCX/4489bbZY88pchStX7ZbNgC77a8xQylF198n5vD30LFoMLsJISIVyBMCPBDMQ4lnnuH6hdPfyx1kcECTO2ZEXBlaFeyt31IrABfB2ICg4m/xPPTmHk8+jf9VEnbXS1+eri50RnVVf7Q71WULlXiAFzF1uDh2put3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8HjUILw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bdea88e12so4908299b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017494; x=1755622294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YS+tADS+Y9dBYS6yonUcn0V/SQCDR8BayYW3dFBYTW8=;
        b=i8HjUILwughK5BnT1t87P+ViiOa7mOPryXiX2rC6/JdE3hEfknhclIPkj84azBhSvW
         4POWVKVrkJqoR2TCZvpMgjLeGPwhRlkfgIy+X1bg2cd/vEOM7Tf/SK/8tDIGbn101/2e
         mPKONZzGkrxgCUnxgS3iNnFAibp8KDjt7egevnuPmckl90Cs9kQ/44Wxq95/nLhVJ9pr
         1eL407sab6BtbFKvSQk6Au/NuFWWX1swBRxXj9E/00GcrxTibbovogV46820CsRGiP1Q
         Qlv3ucYGH49oAAUxG01R1oYGpqEjuhm00kqlXVXyuPVBV+lXtJ3TS33SkG54HFgHkpOY
         IV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017494; x=1755622294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS+tADS+Y9dBYS6yonUcn0V/SQCDR8BayYW3dFBYTW8=;
        b=YDNy//HJ9w39VAV3G4ZVCGsYLcgYi7J+lVJcpxTR/205CF4VcQHMuGO/vgK09NnNwY
         8W5ZZmYZrm3LcPn0oQhP8sHI5FYJkvEiAID748KPf7+2UgfskwJVdPBK//NQgrWJ/U+I
         KVGLhNyKpsuR/Ps4KqtcCnRjUuQybB/AUAlQKDOdNAJeocPhoYgzzyZOc0D8cEO4DbVv
         Ad5ZxOqDxcqBeZSuYbF47RxIjMpVKP3cp2Dz6nc/JXdB+K/Ga1s91qlK5LKU6Et+lZUk
         66TgsALXKTl1S9RwCSizIGC1TS4bjcbh3Hmytgb2MJ4DyQ5U2HoGYmRTt6i+BF9rpFWY
         fvFA==
X-Gm-Message-State: AOJu0YzVBQ1VEAjDrCiORBgfF8B/NWl+i+qzdyS7RKBfZ5jljhpOZsym
	2SBoy264TB/8e7KPnRTTYJ0w752u60WssaGfpwQGkUfIgaq0bZpJ7XWu
X-Gm-Gg: ASbGncspZTc5HZMOOWezz2i5SQGH77Jb0ecw3Q0TtjQR6AtW1LygV/lq0kT/DTUPblJ
	bEbgZxGv1zqopxfJi2GOy5veJedCd3A1o7VivLypA/obzAnPG+P+wsBfggDUrRb8Sh28kC0EXYE
	3Q0CV61UCPwfjKPW6W5qB6m5y7U9z/K8LiwMP4AErcGCZQKDZBLKdkJLc3n4ejldE9zdYMjbDrR
	EFiuVT1kYoiM//jeV+ukGYQLZZDD66naQcSx2ub36kN7X3gkTcxaC6AFdGH+v8XSyy3aWX8aU+5
	NNpjWVhQwbnFUSLYHtYyr6Cd6PrK4gQC3fZVW+66+L+g4GuyNe2b2+EBzcOHNuQFT57HdfQ98qh
	z8ptfIy1uf2ALWXfBo21/Ii4LYf0=
X-Google-Smtp-Source: AGHT+IE+zosnw//qbvCqqQMTJtZm3iSUPSCe6LwO8uneWw47WTrsg8DMLvCCttOXXD0r1zK5rSt8lQ==
X-Received: by 2002:a05:6a20:7351:b0:23d:e568:e5ad with SMTP id adf61e73a8af0-240a8733be8mr37327637.28.1755017493792;
        Tue, 12 Aug 2025 09:51:33 -0700 (PDT)
Received: from vincentserver.. ([110.224.248.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa1bsm30088712b3a.48.2025.08.12.09.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:51:33 -0700 (PDT)
From: Johan-liebert <i.roseoriana@gmail.com>
X-Google-Original-From: Johan-liebert <i.liebert@proton.me>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Johan-liebert <i.liebert@proton.me>
Subject: [PATCH] Documentation : Fixed definition lists ends without a blank line:506
Date: Tue, 12 Aug 2025 16:51:25 +0000
Message-ID: <20250812165126.6324-1-i.liebert@proton.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Documentation/gpu/drm-mm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index d55751cad67c..044a888282b7 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -483,6 +483,7 @@ Split and Merge
 .. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Split and Merge
 
+
 .. _drm_gpuvm_locking:
 
 Locking
@@ -496,6 +497,7 @@ Examples
 
 .. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Examples
+   
 
 DRM GPUVM Function References
 -----------------------------
-- 
2.43.0


