Return-Path: <linux-kernel+bounces-817038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE9EB57CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41467AE446
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38B30FC31;
	Mon, 15 Sep 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4kggBLT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C82FC897
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942632; cv=none; b=Ly01Myqk7Aw5j/6bJ7mdJfV4TyC6m25fVKeeqgXlPiSzr6d2C9eKbHXQlCvi2tFht8FXhnBkwXfQcQEFKeGBkrARZ5wQfn7xKiIzGdE/RP+AS/q9Kuh3DgMl4IkcqBGN/txX0KmbF9DVSfHBJC5fIfPPDZdlVs18f+ay5zRPtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942632; c=relaxed/simple;
	bh=v61r9vHhGpVh3q1CdwNjFdNS4fFt0xIXY6ejwOujjpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZSaYBFowxC/tcIfK5hNE2ESrbOUKNJ04BRCX5ri0HPfBt7fZNGQb8eFSEY+oxYAHS+fKQGlCmmAHrB85xQEPEKTA4gVClj7Me73zryAmU+gSWIPkAWZ43ypBs1beenOZlkA6Sbk7/9FycnxuuhAEnNSlL3/uyl1itmiNrQbOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4kggBLT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-776df11e5d3so1845316b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757942630; x=1758547430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2TvYipap11Nwq0kRFNhZ3v3SKE4qJBU+nYeSgKSe5Y=;
        b=Z4kggBLTZEkP+tezc/oZNELx2/mDJudH9A28PEpqOUqLGXxC6vFy+2prdiIOM3t6nk
         u99kLSrXhb0JZ1MVQgLq67dALd5CQqa4QFL2toQSC31UG+CIbg3OKyLc/IlEStrp2E++
         JfC+bjAHGk3/3W9orKBLT37BoAR3p23X0zCch+QWmULSto3EURT83+d2BdsgMBde1TDZ
         oc2gmSL3qG2jY9l+UCYdPL2zdRuH04h61yMbD8vdp0MveaFEqOjsYuiywWDRkr0/uoVw
         qcpMwM1cApjYFzyCGerWlRmBtoAc/AFUgyhgvvp+LDqLiM9N02+/jPYRoL2HjA4RX7Tz
         32wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942630; x=1758547430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2TvYipap11Nwq0kRFNhZ3v3SKE4qJBU+nYeSgKSe5Y=;
        b=hyqUmUqVo45x+u89fxSX9rv7R6fuCWvK+eJZi/afvUz6/9llkyYV8upV0wQrv/b3YQ
         KHHCZzOAWQ3/xXKloU6pMBy/+7fT9+RNj9jhVtGaqe/MIsDDMbMoLoNfPZf6FUCjo1xm
         ju6f6MkxA1+gw8HHL7asOfSBRrTz+Ki5uJyPhSnhuJMpv1rPI2kkxjKwoyim1yFLcaxX
         rf/3NXazJPRz76bnj1GWHB7OMiRW8p/S4dVK4L3d2whewAs5rXMhy8gufS4Bc6NP9PqR
         7ozbr9ERQBxYr2q2Ie1fcYZKzFZB13f2urwNa81KUhvC6PtYnh3OmNZVrff6iPDlHiB9
         32sg==
X-Forwarded-Encrypted: i=1; AJvYcCWE/DnxcpLylIZgSQXOWvADi7Y6oe/Jtdu24iOVZiyfE5BObszNlqJ5jZQsfya1jOXWvrtNQ/WSNuYZWDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCvJpuY/Qt7Rs3AIQAY9q5Z4aOnp+uFkj0BEpRDRF78Ljhoa8
	0mel9VpWmW1+uIiAnY+sAxjbvXEL5jUrmiJxtsyW/gPbZLlgk+E8ZHMu
X-Gm-Gg: ASbGnctI2ZGR6R6bVPHhzX/davKGY1N7R6VS2E5rNA2rxSAZ0xMdpxnvMkR0WnmIboR
	Vd6lhDdZ2nKId7DnoJA5d6jBDmmcEQMSTCmA0Jqb7mi8Fp0h8Hov7sJytBvfBEkYeNU46ezGzI4
	n+op0l6Xex9G+YIX2onk0C06eqZSfrOTe1inCdy+ZinSpyZXtdXAaZFUbJicOYAPZoXVP5x9+Kr
	/q7AP/mmbzZ6w4CkjqDFs2gUaXne8U/+28oozFhJ/8CsUKrY/gs5toEmn8ZRvGOdIUYzItQOc1Q
	8wr6aASasqzQGYvxFhvieXQAENG6kseZeZV8wRO1GW33f0VhTqUXra+PrTRTXwwf4rG9Eg553Zp
	uwBLxNj/FA/W76AvgkyJ0KIi8VZo=
X-Google-Smtp-Source: AGHT+IFPvIRXD088t+oFYvznY8Gmu7AuJys7aItwGtTGBP/7g+Db+VBC9DwdYHlcnXJ05LR1RhAixg==
X-Received: by 2002:a05:6a00:10d1:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-7761217369cmr14330824b3a.19.1757942630315;
        Mon, 15 Sep 2025 06:23:50 -0700 (PDT)
Received: from vostro ([113.132.11.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c48f22sm13563411b3a.92.2025.09.15.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:23:49 -0700 (PDT)
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
Subject: [PATCH v2] drm/sched: struct member doc fix
Date: Mon, 15 Sep 2025 21:23:26 +0800
Message-ID: <20250915132327.6293-1-onion0709@gmail.com>
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

v2: use proper pattern for function cross-reference

Signed-off-by: Luc Ma <onion0709@gmail.com>
---
 include/drm/gpu_scheduler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 323a505e6e6a..fb88301b3c45 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -546,7 +546,7 @@ struct drm_sched_backend_ops {
  * @num_rqs: Number of run-queues. This is at most DRM_SCHED_PRIORITY_COUNT,
  *           as there's usually one run-queue per priority, but could be less.
  * @sched_rq: An allocated array of run-queues of size @num_rqs;
- * @job_scheduled: once @drm_sched_entity_do_release is called the scheduler
+ * @job_scheduled: once drm_sched_entity_flush() is called the scheduler
  *                 waits on this wait queue until all the scheduled jobs are
  *                 finished.
  * @job_id_count: used to assign unique id to the each job.
-- 
2.51.0


