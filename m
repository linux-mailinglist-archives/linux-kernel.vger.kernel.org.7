Return-Path: <linux-kernel+bounces-758784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D121B1D3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480FF7AFB38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53E24728E;
	Thu,  7 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhKomHvI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079A242D6E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553497; cv=none; b=M1ROUWJTydoBm4hxoJ/qGGrZ+hLA+y2YQPMb9nIbKZBH5e6Mh/yqDbAKPh2fC5MkkwXQiTyu924CI5A748C6lapJy1uEck4fMq861XPD2FciszshSSn2bMe9ozQF5kLbs06IYtpljQZWqmwS6JHk0jpYP5egmbsEklDo3MfdJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553497; c=relaxed/simple;
	bh=+7mbJhg5ogq/hLbv2t4xVJQET9QlZWMqFFlgC1XifPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2nTsmlSEXo1sQkUbaY2yGRgFf01/emW9TU3t+YH9kgBbDH6Oqjmf7ble3f7z28padj/6Orr6MsajrNBz89kbehnPW2MHxPTe0YX7zuhMkrpy10YCxF5i3Gu77a0mRfL5u9gzIfOChRMX6umU7KVbJB9xwTKFJgFu+XCWF23tDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhKomHvI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b85413019so859399e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553493; x=1755158293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lfFD0H26eQ3nJKq96zgfvg/HFsoB+3WUik64IcXqFw=;
        b=QhKomHvItU0BEJXFxk1DPm/X23PurWyj6W3N+WcUKojapzU2Sy1r/K30vT7taGh6/t
         BoTgaVZ/NMIqfWq0e9ONjlMEoWYsVdWFW9ERNr/2q2Shm/JWhZ67dwC7RKcZUdmhiEDc
         kOGPjjbt6hTUGdIzHWY/JaTnpfT7tAZUJrH9EQLmXk1mgX9e2DYLjVoKXNw6EvA0VUzJ
         A5jx2pPrhLTI0LiX0Ozvr5S8gjWupGiWiqN5kjPUA2V2A3LDlH6yUAlLrRPYv/ihe3y/
         6oI780H7wLRz15NueIWA2QdCX8FR1839gm++JUZneVl5E1tkyEqUgO3IE8yt8GJ+q8R2
         +Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553493; x=1755158293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lfFD0H26eQ3nJKq96zgfvg/HFsoB+3WUik64IcXqFw=;
        b=SVqU3ssE/aPpaSEP/+o880sjvrB89iZ6NoUm7RfLnHbpWLBIxRUtFRNHOy7Mqc+G/i
         LVlNEMR8zYC9rtliaBhC2ezV/eROt7mOdo6xRjAssayrRY8kAqmiQI1XEw+q/En4hp5g
         VszvFtm/Hhg+beC+RTMKg+22YBWzJBB2LZFlX+BHM3Uui6psEZif5FT6FYAsbojb0gN8
         +uYtJQVTTWGJRrf34bC/kQA9iMBGyq272p34do9TMsvJwB0VrjZF6NnaG09ujHv27Klh
         UweVnKTdiNFYgZD3Zu4nRvZeAvPFV1pXw6yer3+xrsnLWP8D58q/LMS183/5AKvaC0XN
         OSYg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8g6HqlPTBq84z3v7s6aeR8KbcX2osLCeQY+HionBj+MnelVmewngZizQUpgZP8X0G9VBBDpzQyv6nFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5KMSaRV1DiNjk3m7r9/s7MqFcC9Re8Ld0hDBkAGQuNmE0pwE
	lWdJfzLHB0omCxErq++BLyZ+mRGGLOf/UPTsnIYhYtR1YMf2YUJgYcqT
X-Gm-Gg: ASbGnctgSeCB1wzN6CD3YcMxN+6k2a/Nmu5cYfiBmh+RxkSvv/CpW6nnGLPsAXr8Ksc
	R2Tn0/UYjmWk+y48z+n3451DKA+8aBhgrhFcOuMhxVkn8pR5a10Xhd3MWaftWCik1/LZLMa9vBP
	ZMZ8HsH/ryZ2aEbUEeHT7m2fc/hY4HYaJtcZI/aSzf+TyEQla2qC23gxeTGs+8MP7EsjHmOAXWq
	FjRx3WdGUNoFo+YZMuF0/RObOVZvlJF3W+2N+3Ruu5gM6Nf8HfvIXUZgLBaTrJ+opEZG1F2ehtx
	OSQmvdgIUPf7coKte3s8B96xWnmz40bwbgUVo2XFemKx0aps72KZHJqSO2zDa3Pp6vKEhpsdAj/
	AhZcDouK2sH/+zmHYyg==
X-Google-Smtp-Source: AGHT+IFUFvl/B+gKgVfcI+251dgjRYmvDV+X9oeio2bie1Pk9xKH31TU+OhTXKzuYvbgizg2DGttpA==
X-Received: by 2002:a05:6512:230d:b0:55b:81c0:c22a with SMTP id 2adb3069b0e04-55caf2cf94amr1594035e87.2.1754553492794;
        Thu, 07 Aug 2025 00:58:12 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:12 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 0/8] __vmalloc() and no-block support
Date: Thu,  7 Aug 2025 09:58:02 +0200
Message-Id: <20250807075810.358714-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello.

This is a second series of making __vmalloc() to support GFP_ATOMIC and
GFP_NOWAIT flags. It tends to improve the non-blocking behaviour.

The first one can be found here:

https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/

that was an RFC. Using this series for testing i have not found more
places which can trigger: scheduling during atomic. Though there is
one which requires attention. I will explain in [1].

Please note, non-blocking gets improved in the __vmalloc() call only,
i.e. vmalloc_huge() still contains in its paths many cond_resched()
points and can not be used as non-blocking as of now.

[1] The vmap_pages_range_noflush() contains the kmsan_vmap_pages_range_noflush()
external implementation for KCSAN specifically which is hard coded to GFP_KERNEL.
The kernel should be built with CONFIG_KCSAN option. To me it looks like not
straight forward to run such kernel on my box, therefore i need more time to
investigate what is wrong with CONFIG_KCSAN and my env.

Uladzislau Rezki (Sony) (8):
  lib/test_vmalloc: add no_block_alloc_test case
  lib/test_vmalloc: Remove xfail condition check
  mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
  mm/vmalloc: Remove cond_resched() in vm_area_alloc_pages()
  mm/kasan, mm/vmalloc: Respect GFP flags in kasan_populate_vmalloc()
  mm/vmalloc: Defer freeing partly initialized vm_struct
  mm/vmalloc: Support non-blocking GFP flags in __vmalloc_area_node()
  mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is set

 include/linux/kasan.h    |  6 ++--
 include/linux/sched/mm.h |  7 +++-
 include/linux/vmalloc.h  |  6 +++-
 lib/test_vmalloc.c       | 28 ++++++++++++++-
 mm/kasan/shadow.c        | 22 ++++++++----
 mm/vmalloc.c             | 77 ++++++++++++++++++++++++++++++++--------
 6 files changed, 119 insertions(+), 27 deletions(-)

-- 
2.39.5


