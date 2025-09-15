Return-Path: <linux-kernel+bounces-817803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CBB586C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E7B17039B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A052C028E;
	Mon, 15 Sep 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyVEu7w8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B572283CB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971681; cv=none; b=GEK5ZRrFjCbZmYFRLlAf/k6tYRez8VnSOvVnvjgH82/emPLsdC6q6MFrnDvbLMeI+e+1aVbOEhphltTo3AjBzAL7N4Aq/6Y7ZC1Jglr1LyzV4WKR2K5eOxrdCiKRCqaKKQYogHhGEJPVJPA5CDgZa5UgjtczzLVWboyMRm5qMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971681; c=relaxed/simple;
	bh=g0TBZb/9cnqNPKP6ViGfWqZyU9npP0TJ4jEYTc6L1Ds=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c+dmXMJhjZKrFor5+6E8Q/eJ0T5OWFwOrNfvDe5Ky4MJCtI1IqOA7gDLhWpWyiwUMf4Y1hg2qTDpmqJJXTGKOgilP4cSAmhPo9d+ztt+CF3dWeyCcAVsLMMdUs+LgpiJwzjepk0PO5B2u/S1SAISoAnbuKBvjvbrtbekO/ZVyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyVEu7w8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2675d9ad876so15509615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757971680; x=1758576480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2QKU8X2OLNyvmPPoKyCMxJy3zsyaNlhag0ku2tl+L+w=;
        b=eyVEu7w8YjBHjxheXbWxgR3tm1MnBlEyeim8mtv6XE5YYzgLJLjmMFnH31ka3L2CdC
         jL+y5JYx/R1XRDUMiKu3KiQCYF3cvEADiWwiAShA3XNX5x8mlkVa05ugYvt17yK1c62m
         rcWhs6YRWEDZN54leLyJ1+JyTT7YUbNyT2FnWrzsPBt7GF1zflS/SGUM8RqpMZ2LTPEa
         6KRTh6AAtcR5Op74yMyth+YAz6my+6mB47gVit/7JU2v8YHirx2kcQFrNmldFxPyEmt3
         efN2BuJyUXYWwv3YxzF7T0te6x7OegRTD2lMTodA1QkXuPQRYtTzXIVIVwfack2Qhg4z
         OMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971680; x=1758576480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QKU8X2OLNyvmPPoKyCMxJy3zsyaNlhag0ku2tl+L+w=;
        b=SrSIgX2Tuxt4u6sd6eNCo1uVHHLN8AeVdHxVzs2C/iOmxvZMs2rjupCWpxg75PHUYL
         acUfJCYrQAUkbRxIi8gKvwSamjTisvDLA8EVhrltvxnWKq0kl9lrc/ne4vmrEh5cA6k0
         aL6h4BXNmGjrq1UhRoKqmv7xGPbDeRwP7FDqQhyvsx3wKqiJjtr8by/J13lVgToDmM1k
         8cKjPp40AtbArA9r6Fqyz5Xffsd0/8/hEb7JAlM/i3yWNj0qwTSfsshipzXkLdQSWbFM
         XZcxFwhZspAPkhViJVp6gJVYXf7bLEh1aH8eFdIFFLAG+0q5ZhcXcNapo+BFMX/VHXGN
         zrbw==
X-Forwarded-Encrypted: i=1; AJvYcCUQtNFEfIbZs5UZ9zAheUJ6UWDjk109rzjDlxNFuqiv9MAuhUvaxqcTt1hEA9sa51leK73s2kf+iFiiikY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu3x32To7Yc0jkiUtbE1eFRxqG6aIJ6B97jyxWSGx26AcJDt6
	cUr61kxf7cxNvGxvnNmtV497V0aRALrecP4ASSv0xZidxGgGpjdCXE4o3ffiLO7aJ0nbiNgkzuD
	UpDx7Pg==
X-Google-Smtp-Source: AGHT+IHkoD/lEawRNElFhxNEl/WOJq4C0zSRWelKBAr/ygp+ovcGulyXYz087TxgFrqbeQksPgPmGrTBe8U=
X-Received: from plbnb15.prod.google.com ([2002:a17:903:15cf:b0:24c:af07:f077])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ecf:b0:24f:5447:2197
 with SMTP id d9443c01a7336-25d2587d2c9mr148167205ad.14.1757971679741; Mon, 15
 Sep 2025 14:27:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:27:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915212756.3998938-1-surenb@google.com>
Subject: [PATCH v2 0/3] Minor fixes for memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Over the last couple months I gathered a few reports of minor issues
in memory allocation profiling which are addressed in this patchset.

Patchset is based on mm-new after reverting previous version.

Changes since v1 [1]:
- Use release_pages() in free_mod_tags_mem() in [1/3], per Usama Arif
- Add comment for proc_mem_profiling_handler() in [2/3], per Usama Arif
- Add Acked-by, per Shakeel Butt and Usama Arif
- Fixed a typo in [1/3] changelog

[1] https://lore.kernel.org/all/20250909233409.1013367-1-surenb@google.com/

Suren Baghdasaryan (3):
  alloc_tag: use release_pages() in the cleanup path
  alloc_tag: prevent enabling memory profiling if it was shut down
  alloc_tag: avoid warnings when freeing non-compound "tail" pages

 lib/alloc_tag.c | 26 ++++++++++++++++++++------
 mm/page_alloc.c |  9 ++++++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


