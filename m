Return-Path: <linux-kernel+bounces-839418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9138BB1965
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EBE3B1B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF152D77EA;
	Wed,  1 Oct 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV1fa/53"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84A258EDF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346813; cv=none; b=fzQvNC8fFXUeeZT5Ok5+vrrJ3Drg3UOPw8PTTn4PmFlkcjG9P3hGPwlg9uBQq9ebENRS6OgNKllnTfqRjsUyI438/C0LGTo2sv0pvGNxQ2w4vytCUfuNtVEoS19H/OnyrU7g1ab7ctgGdcRnkYylPi7lsIknVWJSmmatXXdT2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346813; c=relaxed/simple;
	bh=KXYJQYxhvIsN17zfvvDTaWg+RloyW/18pyMC5QgADM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIHeNn1wk0K4kDlYFrNGvI+aelcRa4tmIT5Jpj5R0jwlKnUprRDw/wBGE6bv3DhY34Wmn9V0pxSIr6AWoK8MjjNprCbrKm6UTgyo8WHEMAHdABqOh5FFCBJEXDFXh+KHVwGS0/c3imRkS/GwC0g9KQKwFM93esqhVpQ979EkPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV1fa/53; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1969248e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346810; x=1759951610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoJH/lcolEp8wY4uBr8sDvnPy6/VHLzLkYAlVtJGuRo=;
        b=hV1fa/53Pz9ZBin5TvuXdBOC94jKUs+GzmC6VUFzCqOVF6G0kh4/EKE7b4BAh9J3BX
         7PqIK4yjs9vHfAuv9l51pphz5g1EDw7EK81Q6ft0RBqrySGTqhrGTaQPWGitFvukYsqy
         kWO0yRGiIWSDzSYbsMeFKm17OvCxS8gptob5AV7mWblYJOAkhNzMNIQ/AYeLJHBqkSnc
         pyjqdAriTFEIkguTOSqDCiYmtkvwaTG4C2e9zxMzt9iJ0BO6Tir7L81Ase/EvchmCbNO
         PJ+nLTGC16jGTgxaSI/id6/6UFanktjoJ6ZzZzoVqp+9hujPUw/IYfBI9h4m+SLQrOHl
         5soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346810; x=1759951610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoJH/lcolEp8wY4uBr8sDvnPy6/VHLzLkYAlVtJGuRo=;
        b=ZBCBiaQnvXQXngAfbreXNUL4ToDvkdcPyjbzyEUgOGfG9xFh/oFKgDNEhkC8hHOZwJ
         jY7K4tdCR/pww8P/w1xhqfCIvnCPesBypvVAvOrbrX+lwQUklkPtctpQMcIH0jmzAW7a
         gGjQhiH1npAx4Qyye+Ul4oiJEjdNLVpWTSCkVzS69CsdvrIN28mk/4fxsyYtIZB5/xxR
         D2IHQOUDRYe6RdFq8WxoRTkR52j2agGk8DFdFuwm1ZCn0Z7HMTesIOVgQwIYulV4DHAH
         3Yn8XLMNeraYjkw04m8vKnSit7H9EDDqUZ6SssJBD3axs3kF+94RVdRIf15EDwXhLulQ
         sFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtK+pFrpc45ge1TSIe4lD0wigRl6tlee1HccysGO2DtYqtComTFNGnK11Pg8SjN01HXUGpkURJyCBQS2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwo+xS0+B9qosEU+vLlQlYot5zrvIQxxIii0DVKmYO0b+YspGg
	dIx3k2+iUm95tPMxs6JmrMF/tlC30qaz32eG4Et+TumTaLFqseRkzZmf
X-Gm-Gg: ASbGncvcfLo84hfNk0dCzZPhy5yJ6viYHDheGGm7DmBj0j/662Dada0zmj7h7VBGY5a
	sb5u0UEUzIN1Bqi4kI0PoNC26VN3Bj39uOiR1GJ+2fGkUfBsdByVxWUHsMzGIWAGQScuad3TO1t
	CoTaxwiRM/pSS0mVrCQpieDqZJHNy0gy4OvHwFEvCLc/1ahO+i2oab7MGjHwI/id1KllS4LGvHf
	EQCpVKjLjyMlmrb/6lPUuLGu4aG5F+nrcII8air2GtqB68DpYH5r5wO1uTf0BOCzFo0HR0hPApB
	+LRb9Y2Dj0EdLvfL4opW6Sm24b/frX56SmY7pDrURkt9FdnfSvLg6es0AfBjBIQPyd7YSQ3rBcG
	0ANtYnx0XhD0ajPiNUgZGl88tgZvavRK75rauMMm1
X-Google-Smtp-Source: AGHT+IG7A2+HurTIogoizvlvVPmGXQemL/KztO8gW6gU2g/wKjfszWE/D2KeEK8JNoWJu1NyJQd3tw==
X-Received: by 2002:a05:6512:3995:b0:560:a641:6499 with SMTP id 2adb3069b0e04-58b00b5b4b1mr215972e87.9.1759346809174;
        Wed, 01 Oct 2025 12:26:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:48 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v3 00/10] __vmalloc()/kvmalloc() and no-block support(v3)
Date: Wed,  1 Oct 2025 21:26:36 +0200
Message-ID: <20251001192647.195204-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3. It is based on the next-20250929 branch.

https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
https://lkml.org/lkml/2025/8/7/332

v2 -> v3:
 - update documentation of __vmalloc_node_range();
 - update documentation of kvmalloc();
 - collected Acked-by/Reviewed-by tags.

Uladzislau Rezki (Sony) (10):
  lib/test_vmalloc: add no_block_alloc_test case
  lib/test_vmalloc: Remove xfail condition check
  mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
  mm/vmalloc: Defer freeing partly initialized vm_struct
  mm/vmalloc: Handle non-blocking GFP in __vmalloc_area_node()
  mm/kasan: Support non-blocking GFP in kasan_populate_vmalloc()
  kmsan: Remove hard-coded GFP_KERNEL flags
  mm: Skip might_alloc() warnings when PF_MEMALLOC is set
  mm/vmalloc: Update __vmalloc_node_range() documentation
  mm: kvmalloc: Add non-blocking support for vmalloc

 include/linux/kmsan.h    |   6 +-
 include/linux/sched/mm.h |   3 +
 include/linux/vmalloc.h  |   8 +-
 lib/test_vmalloc.c       |  28 ++++++-
 mm/internal.h            |   4 +-
 mm/kasan/shadow.c        |  12 +--
 mm/kmsan/shadow.c        |   6 +-
 mm/percpu-vm.c           |   2 +-
 mm/slub.c                |  19 +++--
 mm/vmalloc.c             | 153 ++++++++++++++++++++++++++++++---------
 10 files changed, 179 insertions(+), 62 deletions(-)

-- 
2.47.3


