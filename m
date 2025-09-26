Return-Path: <linux-kernel+bounces-833638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1CBA2857
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1B4C82C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB527AC37;
	Fri, 26 Sep 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH6p1cO1"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E57272E4E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867791; cv=none; b=bA4IjGR4z/ZOPeKRPO5CAX+IiWaeZn+YQCDj3sTIL7YnjpndC9fVzbpZuoQh4s+4xf0e0DceowlHjJ4huKLp3DdE64pYTbwirZQrd4sEg/oI8ArpQV1tNyfsjCNhSvnQX1LuJ+xDmpeNWXXOLZhF7mbvdbQlI+SK5az5s744j54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867791; c=relaxed/simple;
	bh=hl06/GejOj67dpIRfbyeehkpT5QyoISw3+NnPMbBMTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3XQtzO3MpjQdTmkXSmVj/siSW4Bqq0fhgM+Be3UcT4k8ari52BRqptSCQ/wC9Wp8KcuM0/GC4gVK29PSO036fdZ5Bg85LiJiIPetTtSWNw9rsU7PjFgEUKcYPjcGKSTvnmnxgPORtOzOZvFTu6DvpW4fJJqPPSOcydEAEs3lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH6p1cO1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-273a0aeed57so34813125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758867789; x=1759472589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXqzzN/wLuzy9B0JFPQF3WHk7WqttvDi0Eb7LF+6B7c=;
        b=nH6p1cO11+T4NZydvKj8cwzfKxzT8e+wI7x89o2N2JrhValECNNvISJPyF10E7kO9P
         h9OONwj1ZlFH+C9blSJhZdgQKKLLq/RoyLeiGfNI3IhcHWrX/xbfFtCaBEa7ULo4MO9g
         V5oFq5HitnVmiIjX+YOZWvZ9slMnnZaII8JNktod+d6R4tV9+MUe75r46HeMq3bvw/SU
         vuup4o5C5yHutySQFFwcmzGuSuQcsPbwnULJZW58q8gih5PBBSkOBawg3tvUaDAGkNCy
         AGg9pOi1jnEUa/Cl9ob1pu9dO3TKMBsu4n/U64j5cbRic8ZLtC3qykISch1lfJxWfC4B
         hp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758867790; x=1759472590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXqzzN/wLuzy9B0JFPQF3WHk7WqttvDi0Eb7LF+6B7c=;
        b=ML9svQyOkzvE17qulKWKl1Dl++e/nyZ5iRJWSrpbaolSJWoe5Ez4QRvCWmDBFzqOGQ
         LYwsNnchF+SZ05yVbei0N5+npdvbj/KABPaxQhM/HvZKY7SNypdrH4SZ/YINEMEkKh99
         vdhNSFDnl3VrR3zdo8YpKnfnjK85trZ2BMZwERSbQEeejvtsD8sLhb7dzkPDnfETyNYO
         BJSMRrASt7INqcBoe+xnL6lLy7iDufS+919ZL95OMxVl+3kFVpSvlqoTTp6bNTWCVaiR
         FUxQP7M2CiYoU/AdKuw6ggXhj3zaxA+AOqhQKVwm1rYKLclhOj/B27HMTPZk9Q/Vb7P7
         tGRw==
X-Gm-Message-State: AOJu0YzkigVu0iNJoUk4iK6SDsNM3dOryzOGPgruWOYog5c34FTRs/Z0
	B2APu3K4TylmFnVMbPWJUwBeJhs54FUeNMFmk+S7D6Ou2kBTPUg5cS6B
X-Gm-Gg: ASbGnctfcYoPI9MmXSo6vK9Vrm1rGyXbyC3PiOjFUt+1ZfD0lIjgoroRIKFpQSj6rm3
	sL/XjZ8uH36p8HOQBdjEBQ/W9Z7MUdeFM2Cj3vRP+95iUTfD3Mj49BC9bGHfKDaZGWr7NCLR6zr
	jxDegA+qN3WzaAhTslxQWVb+kPLnuiYOt+wJ+AnZT5oG9F0h/VayN2quj54mJAa7nGRjmPn4Sjl
	5kkMGztrCuiRTQk8dab7+dSQMnk5jmtclW2NAZwyBOSaIv++6NB+IuTHEntu47ogfagZ6KQDiuB
	i8FN31Hwci68N2quMK/2QAVRBtE4auKan6m622A0iuTsAg6uqQO246z5VKPy9qs9UwZIOTnyCW2
	hS2SbAo01nXjWd3p/9F3tasF9WTeJUJRIt2fsJcNuKXDuzvK2bDNS8eChwTMmxw==
X-Google-Smtp-Source: AGHT+IHqTuzXjAiBFyYqSkJdGGhp4EGsOELDx97gEtLNeZslxl71fQpI7u0DQXy0uKoMDX9VETSB4A==
X-Received: by 2002:a17:903:41ca:b0:265:e815:fcdf with SMTP id d9443c01a7336-27ed722bb4amr53324465ad.17.1758867789465;
        Thu, 25 Sep 2025 23:23:09 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac966fsm42356755ad.139.2025.09.25.23.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:23:09 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v3 0/2] selinux: speed up avc_search_node() with large number of avc nodes
Date: Fri, 26 Sep 2025 14:23:02 +0800
Message-ID: <cover.1758859391.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node() latency increase.

This patch series aims to expand AVC nodes without significantly increasing
avc_search_node() latency.

This is v3 of the patch series.
Changes since v2:
- update changelog and fix warnings for commit ("000bce8f11d0
  selinux: improve bucket distribution uniformity of avc_hash()")
Changes since v1:
- improve hash algorithm in avc_hash()
- define avc_cache_slots as a static variable

v1 discussion:
https://lore.kernel.org/selinux/20250905100454.685866-1-zhanghongru@xiaomi.com/
v2 discussion:
https://lore.kernel.org/selinux/cover.1758633723.git.zhanghongru@xiaomi.com/

Hongru Zhang (2):
  selinux: Make avc cache slot size configurable during boot
  selinux: improve bucket distribution uniformity of avc_hash()

 .../admin-guide/kernel-parameters.txt         |  4 +
 security/selinux/avc.c                        | 83 ++++++++++++++-----
 2 files changed, 65 insertions(+), 22 deletions(-)


base-commit: 68e1e908cb7682db9fb7f79907f9352435a81c0f
-- 
2.43.0


