Return-Path: <linux-kernel+bounces-844231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A9BC1597
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEFB18811BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790582DC773;
	Tue,  7 Oct 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3HwCBC5"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A92D46C0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839642; cv=none; b=i59hles7N9sE86atUAD02WbwCEmo5OTP5H7l7y2suwocZfqz9uoKMqNz0f3M/5ze6bTmj2hLbLwg2yjG1boQF0XZqFb1Pa0IS+DVHMqRh5wmtVen7C9R/MgdvE64ErnUG1tgEUGQRC/0LOPcpYmKEwPIJfNZz/PARmsH3hAotKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839642; c=relaxed/simple;
	bh=P1sofnTWhS8lYQO3tj3pbRjhMZp8Gh8hiXweEljPnxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7H28IeeNGalzS7nTmqZid21/kN+V9mJly3iWMxjBTXr0eM92touyZLp3yXeNDOaN+BdJGueNQfgT3DqDg2/cgmUqJcV96sC8pygiRyLhu/G0kNCZDQRKIbGoeKDdlXxwyC76kvw0zJvOTec+plWbd75ICackjUo9md1pzeAXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3HwCBC5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e36125e8aso5708079e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839639; x=1760444439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFRKWTVlTuhPzrNfR0Xp0MHmBgacGLDW+osVwfP54fY=;
        b=J3HwCBC5S9eJyoygxrnD18Xab+71gUUMOCq/DmXJEOmAqLXYV559CHnAiva996vpKp
         vmIYVcJz5TDHQO0V3KfhRxt0Oaop+EDfFb8rcKAm4rP5CRLMCDP/XjNe8npEfSzMxvCJ
         lwJS6KpA9oPYU0CcjaiDey6iscvXFiwi3Y5TNLQBrnuV5RDTq7uKm+r2En48apzL7u/6
         HzJKF/yAHUdT6HNM6NkONxMyYqVskvbfaLBfnQQFOxZUOJ4zrDr6kFUBw5pXfAFbBxlE
         rLt8w/eSkubCRCGnK9xUDiRQuJupcV82RNOHOCgx0QLbpjgTOacxxR262a6GIo5dtrbL
         Zwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839639; x=1760444439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFRKWTVlTuhPzrNfR0Xp0MHmBgacGLDW+osVwfP54fY=;
        b=fQRgPwLRD//eoR3erY2qzVNaPXC0OvKLyEJ6XPhCjZW3q3Lq7GNW78JbAcS07cQmxN
         tyEabOs9NTVJ4lLkwSeWZwDG/CMopCsOnc8bjHx8/bJlCVjghfvj0yGeYP5CCaUwSwQF
         4IJlp9aglCPedaRMA2RhF9d69OiaKHH5CqFueB6z8aOJuPhuDHSWGMuynYTda3sO5HyL
         vSf0lKSEy2bt2ubcI6WdjxlrwjbfhFqPKCKTiwzvOV5UzUill0Dl0A/1wj7f8AjC1XHM
         RMpj5ogOu2f/a9zvkTR3/YVHjNM2P/OM89uiDHsR8ICJaQQa/JXX+41rJLXJuxRqsx6G
         A69w==
X-Forwarded-Encrypted: i=1; AJvYcCU3K6WpaWzaIILIl+8tyBCML0skziY451kl7m+U1Y3OIgjo8Z8xGxHFVoV1Dm5UdHQQDuIK2XF3vr00PzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjVOJKaH//8Wq8wugaPThUSbeBWCQI41dvj1rWhS4LEKA0L88
	R3LwK4rMDiAm4UYiuNuiCcPRdNIzojUk7kJFtKXPw9UvhkhepX+jZbJ1
X-Gm-Gg: ASbGncsBkkVyFysW3JfdEY6qK2v+Oc3oUn/wGloibLKB3YxRR8dB7rxQCqj8E9I7MGT
	8QhiPZii8e6xHKn+nE5mdlLhyMprocG9Bi/PLZNFyLkYUPCP4RjkAi7LBynJa5xuucqf2INRymx
	mmRscyuXghxI6J5Q9HoBgT73PeacPNSiXVDv8bURrpmWDEY8CMyBr6Tpm8R+Tuuah4FhJ/X9zwK
	3TodJU3J3K4gDqgQPqzLh9C1eN/41Ae2qngV/vSheZ5YKuiiBr+IeJQ7m34KmY9tsa9ABngwX8a
	T6kPz7dJQ/HrQLAjf6+xgPGDztzaKDHAvxF+jO8GP4aZijuYWUXZybfFchG/k/RH8BDCZwHzLnT
	A/hDxoMNMJ2t0TnjZLkNHCKT//Xbwo8NPFqnGmftG
X-Google-Smtp-Source: AGHT+IFwtSa+eQfehlnRS+uCd0yLNJFhqNO8SZB3I1D1kA7dISH062qlxuqUPKXkOnZ37xH5DrcuUw==
X-Received: by 2002:a05:6512:b29:b0:55f:486b:7e5b with SMTP id 2adb3069b0e04-58cbba02367mr5221127e87.41.1759839638991;
        Tue, 07 Oct 2025 05:20:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:37 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v4 00/10] __vmalloc()/kvmalloc() and no-block support(v4)
Date: Tue,  7 Oct 2025 14:20:25 +0200
Message-ID: <20251007122035.56347-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4. It is based on the next-20250929 branch. I am pretty done
with it, if no objections, appreciate if it is taken.

https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
https://lkml.org/lkml/2025/8/7/332
https://lore.kernel.org/all/20251001192647.195204-1-urezki@gmail.com/

v3 -> v4:
 - collected Acked-by/Reviewed-by tags;
 - Fixed "Warning: mm/vmalloc.c:3889 bad line:" reported by robot.

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


