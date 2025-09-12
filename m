Return-Path: <linux-kernel+bounces-814147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EBB54FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D96171003
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0730EF66;
	Fri, 12 Sep 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gptMPdrq"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF82FD1C3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684702; cv=none; b=rLgldLh3j8tlklC7umCs8zSLdVRSwINFbJSb5a9qddx2wM0bdectz1Cnlqf3qGQ63MFqAAC1lnESCUPzzkz+O6RoeoJIIm1+PsuMhK7hHKqvmYam7ulvCFRuMclwft8qdwcrIxo1QbvuTi74m2KJpYun5lQHa3UFGmtW9W+AePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684702; c=relaxed/simple;
	bh=cb10gITMfGHe68tF0kEqwVbIdWaJh28KK65pw1iBgj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8yqIirzonwCab0XRdwWJ2elJsxhkquV+ghr9RYOMK0cuj/YzncoC+A233TirixehKGVJwDP8GkB4AsEBwTOT3sTUjg8542RxSR1GcdhmQFTq/IH2CUvriuU/AmdLYKe9KM9HLpVzYcrfAsRYP6BE/aoiuut0hbiQBNes+ERQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gptMPdrq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77264a94031so1504431b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757684700; x=1758289500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDQVS0oN98gtOxGh4UkJ37N+aDlWZS/uJKzs0i7u/6M=;
        b=gptMPdrqPWvMz6Z29QR3S4YqHEBOTP33R293/TNCqYRiYcceOHCtmyIMYJ6Emn2vh4
         UyEzO3y/ArXy1RcnaVtASg/rfRsL+83JeDia5wqLHL0NGs1ObkgviJCzseapPT6K74nA
         9gUisMdcOTxzJiGLsjBkpTIaGDGVKshH1A/KvSmKd9Wu138ThBqG4et0YnrKlZXLYeXK
         ahk0fejL3ImgUitvock38xSUoTNQ/vyHNzuIcE+ThmWJUGmPRJKJzkkrPGvGo9m5u4Ym
         9bkNoQtbts3a24m1KYm9eS5wNwcIpLagu3kQaP+KqDU2+84MtvHkyzTStAsDHXnXoHK+
         f6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684700; x=1758289500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDQVS0oN98gtOxGh4UkJ37N+aDlWZS/uJKzs0i7u/6M=;
        b=He7vm4lMfBc4as6be9PsyUoT57CTbCYcWZhAWpLzcpa7cLseAAWmsq5d3EzyQ0tKsK
         4QX/LlzOh4O09CzFtxwiglww1tsdKXOYdlwvUQ6pTNKvxDplEylwkqKxjoggmMGNi8rG
         4e81oSVHCG6Dhwsc/tvEH2JvmYQP03y19rMsVfiBj5WEqHVCxzbzy3tfM/hzghKg7Cy9
         KJdJQc9Tb1Qm1+9a6mMb0j00yWpbRyPwF4BqzQbvFuMSDXll6UMY6N2Y8C/k7VlleqUm
         bDVpiKFaBw5QR63yWSIc3Wd0MhgoCAJUP4og224OUnjtfxdeRjYaxrfeXCZZ/kIIZNUv
         08qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5j2uY/txa43HMx2W6lR6XI+AlZYM+cG78ITIPRhfALZmL6Z+8qHUomt+3FP9W9I6PtUkXeC+02Yth2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/yy0FfdA3t9XurjuFyXczAjAcHBYhQLJPwpYAV/yd193Gdmr
	H8SKBJwyoGCBy9zXygbKx0nQ+zuNhm+DWal9B6Si38A8zTcTiDNEm143
X-Gm-Gg: ASbGnctaRxl97hqLrEC6tL3jXBGS7cnQNNKoPtULaP/ff0zN8sTFdII1TDdp959ynPz
	pjYmCPl+9gdDQJVDKqpTawaJUZrJM3rH8CJoeR5rt+q/zhnqGJeJbpqKtHUCu+Itdg4JSH+/4yM
	s9bToigcVTIx6p/FvOT1QefSS98zQ/rVWxw3GXqu41STDMuYVbufgdA9Pwj8iVqVlt73g/vQL7Q
	ZL/WYAleGCQOgSJMbwqhomR+MNCvYuQXK5OP8yaBKOkTmuU1KILImYEaxJD9fIcALJQ6Sw0MIUz
	Cxl0sx++x3AnFevvRskgjZDDYSqp1MPWS5aMcBSS/v8hbFqxxVliyNUOLEqX7QwmVDHojGUoSbn
	vREDTh1eCdZJjO3iqbFx9Zj2uoGo=
X-Google-Smtp-Source: AGHT+IEI/yWZoWRDsD/sO/L7HND76jgnTXIrLo1qA2nfeIPD2quPMlWWHT6V0FurKrHF0qLWQEp8eA==
X-Received: by 2002:a05:6a00:21cb:b0:771:fbc3:f151 with SMTP id d2e1a72fcca58-77612163666mr4136197b3a.15.1757684700373;
        Fri, 12 Sep 2025 06:45:00 -0700 (PDT)
Received: from vostro ([117.36.116.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77613e4308csm2641444b3a.73.2025.09.12.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:44:59 -0700 (PDT)
From: Luc Ma <onion0709@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: onion0709@gmail.com,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: struct member doc fix
Date: Fri, 12 Sep 2025 21:44:05 +0800
Message-ID: <20250912134406.221443-1-onion0709@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mentioned function has been renamed since commit 180fc134d712
("drm/scheduler: Rename cleanup functions v2."), so let it refer to
the current one.

Signed-off-by: Luc Ma <onion0709@gmail.com>
---
 include/drm/gpu_scheduler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 323a505e6e6a..6c4d0563e3d7 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -546,7 +546,7 @@ struct drm_sched_backend_ops {
  * @num_rqs: Number of run-queues. This is at most DRM_SCHED_PRIORITY_COUNT,
  *           as there's usually one run-queue per priority, but could be less.
  * @sched_rq: An allocated array of run-queues of size @num_rqs;
- * @job_scheduled: once @drm_sched_entity_do_release is called the scheduler
+ * @job_scheduled: once @drm_sched_entity_flush is called the scheduler
  *                 waits on this wait queue until all the scheduled jobs are
  *                 finished.
  * @job_id_count: used to assign unique id to the each job.
-- 
2.51.0


