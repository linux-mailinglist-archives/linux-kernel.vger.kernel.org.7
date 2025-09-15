Return-Path: <linux-kernel+bounces-817066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6980BB57D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2563B04EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EB31B11D;
	Mon, 15 Sep 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMN8Spft"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435F31987B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943647; cv=none; b=Ch3zk3ji/klXmUC11Ac2G8BL+Yxm2z/zVcn6cufntdLc/F3vztGDu32Cp8qsfNTtWFdkkte+2MRN/tt4z328HCXM2NchB7FDblrfRI/l3FezIbre2WC4d/inrVARC83JbimHFi5gT6l3DPhy0sDsG4ioeQeoCb2hfI2BmJc/DN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943647; c=relaxed/simple;
	bh=UcTraYfEEuE1LUCGuMk8a3HMNaM1uejNpWjeyqYNJCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIdmgsYz1jpgt/ls2Mfjhk+UzkUDhFeNy+I/UEln9csrfgUi/hdNzodD/WmZ/L9VBrJMOswDAktrNZHelJRBm7tyMKfLwjcNViFJY2iuT/4i0QJLYFAYRpgCssTHzSLFdDoYQnd/flRqbVNLXiS78Nuc93s5wo8rLV4eoF1v2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMN8Spft; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-570d0c280e4so3784164e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943643; x=1758548443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01E7nmRf8HztmOA44dUgiE9TwdkVxFx1dJ2O2VTJ3K8=;
        b=BMN8Spftn+yYJ2l1gNCDmgyZGsrOex7P4Vud1scy+bVkSE5P5jdU3uuCwNjh890XD3
         5X8IYYhEP5kGHj/6/977HNc33Yxmc2Cp1gREXk84F3nXrce6v/vG989leMxm99A/Y/ZN
         IgmmreDMNE/qR0s2NWip6xQilvrxvfnSBV8yH/8F2cG01FnW8GYOctjSAI/NBT760pb6
         4RyFU9ND5uYNcqckImoSyOYRrUxisKUz32eN5zdsEYcL+fWWrPK06bsPlv4LLfJ1la/M
         UOkrJTDo/QldGiYKWa67WWJAgUq8qeQ40RQzxRnXibr9THwh1CGKkE+RYrWRyUyqpA0Q
         x8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943643; x=1758548443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01E7nmRf8HztmOA44dUgiE9TwdkVxFx1dJ2O2VTJ3K8=;
        b=BNOTlvvz34oX+qYA9cdZOhRAVPPNo1v2P/Zy/TzybGRccFkFtCmcaLmRAtEUeaW6b4
         Y5qGV6od7cHt5i7uo8JOaWmIFC8qqMZyRx58ouc2kwOc7R/970wWuM1Pvs85qK2xIJil
         e88SnTBp0RoqbDlp3rcImOcaB1+/hhEEgoAgqdqrr3cq90Fj5yRDquPBVcU1i9PFb56m
         Xbxdri3rvbd5IAmo2AEVX5K54tNdueYfBWvy5k7HI+Cn1XAyAIfVJnASuqTebH6784Xf
         y+1FYhAZBiJ0YslBJ3PUdiZ3hDPC8AS3rDnANaH8ojjbj3mOLDhWJJM1VFMiRK/Xs1ec
         lMbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5p6E9SBY5Js4HGDWFxzKfyXFe2PJJFBsRgNuToR1UDqNRM8/Far2iq9Y7fAWb5pNR61hcUIlglp6eihU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6PE1JzkDR4EUi9FU9YqtddnI2xT3mDdszQfKBQRBBDWYxk1P
	KWUZRnDLHR0qUwXyB0Ffg1KQy9gvv1FEc7DvFY8WrX+EvYPnebrVViX2
X-Gm-Gg: ASbGnctLZGnPX4gG7di2Oy8fjyyTlPRdhO7/gIkXZvoBeKcC9RSjoYuSpdfIILrN8eM
	G8L9JYaxkuWlxpSbT7WnXf8vMpWVv/g8DgzDgCSxErtmcAvDeEKg//sqWfB/mI4yotYYVRY7Rz9
	HxmSocAZDsDAk4rBtjdtd7x/xnGc+DUiXkXt364/eV7aPingRdVQiO7JV7Y/tdtH4U+TGsvjFEW
	GrJJBdQ8oi38w6rClJoUAXj9ecR+pW9FX4oOfglBWwPHLEPczCAfIW8N+h9KiFcHrpahT7eChqM
	2qNTjLygz/vrmEqtJOJTb4HOE5CpYZWAldLx4ZX4AuaRNKihopNWtYjQljcn0DcdWWk5qmNotO5
	b4lB4w3GpJ7AKfP6I
X-Google-Smtp-Source: AGHT+IGwZ/j0Rorxt6Yp74VSt409JeQQkH2MPa8G2UTjzOAitflFcIZEoZX3Dx3EJaTBnMdbvTXPXQ==
X-Received: by 2002:a05:6512:2606:b0:572:7e6e:d311 with SMTP id 2adb3069b0e04-5727e6ed5f2mr1776305e87.1.1757943643203;
        Mon, 15 Sep 2025 06:40:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:42 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 00/10] __vmalloc() and no-block support(v2)
Date: Mon, 15 Sep 2025 15:40:30 +0200
Message-ID: <20250915134041.151462-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2, i do not count RFC version. It is based on Linux 6.17-rc6.

https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
https://lkml.org/lkml/2025/8/7/332

It makes __vmalloc() to support non-blocking flags such as GFP_ATOMIC
and GFP_NOWAIT, vmalloc_huge() is not supported yet.

v1 -> v2:
 - plumb gfp to KMSAN for its internal allocations;
 - update documentation of __vmalloc_node_range();
 - Instead if dropping direct reclaim flag, check PF_MEMALLOC in might_alloc();
 - dropped "mm/vmalloc: Remove cond_resched() in vm_area_alloc_pages()"
   patch and keep cond_resched() points. Need more investigation before
   dropping them.

Uladzislau Rezki (Sony) (10):
  lib/test_vmalloc: add no_block_alloc_test case
  lib/test_vmalloc: Remove xfail condition check
  mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
  mm/vmalloc: Avoid cond_resched() when blocking is not permitted
  mm/vmalloc: Defer freeing partly initialized vm_struct
  mm/vmalloc: Handle non-blocking GFP in __vmalloc_area_node()
  mm/kasan: Support non-blocking GFP in kasan_populate_vmalloc()
  kmsan: Remove hard-coded GFP_KERNEL flags
  mm: Skip might_alloc() warnings when PF_MEMALLOC is set
  mm/vmalloc: Update __vmalloc_node_range() documentation

 include/linux/kmsan.h    |   6 +-
 include/linux/sched/mm.h |   3 +-
 include/linux/vmalloc.h  |   8 +-
 lib/test_vmalloc.c       |  28 ++++++-
 mm/internal.h            |   4 +-
 mm/kasan/shadow.c        |  12 +--
 mm/kmsan/shadow.c        |   6 +-
 mm/percpu-vm.c           |   2 +-
 mm/vmalloc.c             | 158 ++++++++++++++++++++++++++++++---------
 9 files changed, 169 insertions(+), 58 deletions(-)

-- 
2.47.3


