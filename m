Return-Path: <linux-kernel+bounces-737980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0123B0B2D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF9217EDCC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B92F24;
	Sun, 20 Jul 2025 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqPZz6sM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695E173
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969723; cv=none; b=j7UrJBEHAlRLwL0wYF9IgAcagP+gkh9T90AAbcaNMtgbCwnYX6jIAxTXGzv8C8Y33RbvU8frscsbqr58JN3Rv7MYnSZidBocQZ8Zzs9xQuNdUdEWjlGlCbH9lR5UunEshxKL2eaHQQIK/PyotGSy7RDF58jeOnjRefMjDnQw358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969723; c=relaxed/simple;
	bh=4JSmB3S4k8FgwUd2v/lJJxXRMfkpSSzidCRgnuc4yN4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XVdiYN8L5+++69maYc/jIZF0qIL6rTwD/guKfg3wpH2RaNaot5d3PdjHSvK3AXePLQ7I3HCoGbCQOoI0fhheSJZpBm8vxLRTo8bSG2MsYbG5JJyXkL12HH2NM6YZeVIYVoMsEAYiXzNbjaNSPYbb112aU1GLApvFQvMGYNrNcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqPZz6sM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236377f00a1so26660075ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969721; x=1753574521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMXYFyLZ9LRVuoYvq7JlpXm9rj1HGO9gOfANGlZsnNU=;
        b=QqPZz6sMYrkQ9xkbNBY74yMcDGhh6t60cEHZU2nrikJKmeGG5ZpqjwoTwyruKBRjoj
         V69tdcHiNMPFNoNNnWgJydGpExa5o3q4Ba28MEQeG2tMjQ9cfPgnS3LSUEWc7QrHvo4M
         cJrC8qNWv45qUDPF9ST2khFLBBmHe1xYQdSPDgeW1kYd3Vk+L0BoRHCYDE2wWJF503zJ
         FpqNpayu1LhrkEI3Ja3SpUuvl6HAbzLWoN86jVbLcMeS2dps/9pkQIJuHfYnCtQAIPA7
         YP9KVminzRF3qacZ6xTtFCK3FoSLZSk3HL57khyOJIFqhU5UqEqWfdRTQQ6R/O4oFRBY
         zqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969721; x=1753574521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMXYFyLZ9LRVuoYvq7JlpXm9rj1HGO9gOfANGlZsnNU=;
        b=m7pxzohXG7GsnZtsHXnjsATdjAa4YsPPFAL2xfDg6t51ry3YgMNNY3biMK/BzmeZs7
         7VqeY7X4U8Qi5TUlAWiP/mZIs2PVdoEHPGWlgsjU8z7XW43tnLYIeAXdQGEGItliSDl3
         1zvAjUifzRYYNKL5TntzZgXM59HCn3JOB4YjvA0Ilr4qepeLLso+Je50NernUASD7CVS
         5DL+yB0GNniWSr2Ggzq3wfz4w5bEv7LizsZnW7+D522CR5wdhB6iDH9LyUpTf22zTc4+
         qaJiTrEUjGO4v4tfTAet9sRx5Hr8hEGhiDWy1Mzb3lfdXFZLG9nIDaA3F1IWc2Ghs6IL
         YtqA==
X-Forwarded-Encrypted: i=1; AJvYcCVs2u4H3v18m4Zzkz2uQKIXYafkjivbg9S+0DDNMdbnl4Yi/OlP8cimC0u9yi8tHY1EBvqAzznB0+tvps8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrII0dysF9O5jNkRpa90T8gZYIBbFPnJjJXMuPAvg1vJoSDdU
	At53ins/N3Nquvo5mMelg+EAb5Af15rps+YjX+7lc3rvSinDQ89xg4Fn
X-Gm-Gg: ASbGncsAmXZazePVwMelRbiqy1nTsSOr86h+mp1zFjx5V2jfyuWnOH88yT6Z4cLKQQX
	474O+h0CTal+XG9sGnJmSVzqBhiPe63t33yWhLpeD97C1sCQmUDYMwNJcoVBtUesJQSNtICi74i
	YsEO+bDveHNCWFYAMM2Yd0YqpdBhph+bwG4vcC9PD2TCWXjQM+/OY7OleAvkdirIzdtxFhBktb3
	u+vGQvtA7ozhEmio0ty+CcwakOsrhZiLN47A+lXD8bl20J3PsT81go8sANTfCANolQo0xWzKwkG
	yd+Wo7AQD0b/nghYnoH1abeE/ZfIhfeKffD7QTxCW2WATT3s2KkKzdhr9+6Q/0pLMUV53DitR63
	zdw4Q220w2kyC+aB/JccbZQkC3cVr3mjlAcVHyirCu4ChFlUjdK4u
X-Google-Smtp-Source: AGHT+IEWhzR2mm7DE1QL76lEZq9yVKIipYDARtaJz7Dl9K267KKRrQQk077MGORFZcrIgL6+UJPf9w==
X-Received: by 2002:a17:902:e804:b0:235:779:edea with SMTP id d9443c01a7336-23e24f56b2emr264152565ad.38.1752969721497;
        Sat, 19 Jul 2025 17:02:01 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6cfb89sm34023075ad.132.2025.07.19.17.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:01 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/9] drm/panthor: add devcoredump support
Date: Sat, 19 Jul 2025 17:01:37 -0700
Message-ID: <20250720000146.1405060-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds devcoredump support to panthor.

This is written from scratch and is not based on the prior work[1]. The
main differences are

 - coredump triggers on all faulty/fatal/timeout events
 - state capture and state process are two separated steps, with
   GFP_NOWAIT being used for state capture
 - state capture captures both sw states and hw regs that are
   potentially interesting
 - coredump data is in text format, similar to what msm and xe do

A sample devcoredump can be found at
https://gitlab.freedesktop.org/panfrost/linux/-/issues/44

[1] https://lore.kernel.org/lkml/20240821143826.3720-1-daniel.almeida@collabora.com/

Chia-I Wu (9):
  drm/panthor: add devcoredump support
  drm/panthor: capture GPU state for devcoredump
  drm/panthor: capture GLB state for devcoredump
  drm/panthor: capture CSG state for devcoredump
  drm/panthor: capture CS state for devcoredump
  drm/panthor: capture AS state for devcoredump
  drm/panthor: capture VMA state for devcoredump
  drm/panthor: check bo offset alignment in vm bind
  drm/panthor: add DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE

 drivers/gpu/drm/panthor/Makefile           |   2 +
 drivers/gpu/drm/panthor/panthor_coredump.c | 617 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 178 ++++++
 drivers/gpu/drm/panthor/panthor_device.h   |   6 +
 drivers/gpu/drm/panthor/panthor_drv.c      |   3 +-
 drivers/gpu/drm/panthor/panthor_mmu.c      |  54 +-
 drivers/gpu/drm/panthor/panthor_mmu.h      |   4 +
 drivers/gpu/drm/panthor/panthor_regs.h     |   6 +
 drivers/gpu/drm/panthor/panthor_sched.c    | 104 ++++
 drivers/gpu/drm/panthor/panthor_sched.h    |  14 +
 include/uapi/drm/panthor_drm.h             |   7 +
 11 files changed, 989 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_coredump.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_coredump.h

-- 
2.50.0.727.gbf7dc18ff4-goog


