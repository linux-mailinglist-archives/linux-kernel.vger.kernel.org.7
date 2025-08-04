Return-Path: <linux-kernel+bounces-755750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E543BB1AB50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CB3189A534
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82192290DBC;
	Mon,  4 Aug 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUOCTCL9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AA1DE8B5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349358; cv=none; b=PV44b8Jl9lR9xeuMyEwBpzmmQFzutYB3SBru1kT03wW6BK3d/UdAyFhxWRWSg+DkFRYfU+NfTzKbpuGnr3prheaWBLx1RHp89YaO8YuiZTjCRTzflVhhuYZXFQUZ2NDfiqfZgvkuYEIxb5nrTpdx3NNq89ltkyImIFHwbUXAq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349358; c=relaxed/simple;
	bh=aLD/mc6gQzsIeMbR4/fU38vrGMY6ASni5WoEO50oRKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bQmlXrfm/N5XlwgRNz2HV590RMSdKbL+hfYRf5Cb2J57KLbQS1DHxbOOsqhayRtba5eEy983S/SPuYapQv6nYubf+pP2i82AQNimMWZWmi4T8xLxnLjm5aVBwuCLT1KtVP38U7I8CY5HcS1+2YX4zRV5X+ZZ4oyT8EWDa9NaOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUOCTCL9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bf8e79828so3726434b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349356; x=1754954156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8NgMA0HX6GfrkP4AehXbgu9Qzh9g7nw7slgx4SS+9M=;
        b=jUOCTCL9cdlB88x2O5dDxoLZTx9JMu2tQcoRTsm+Z85wtpQoH/5W15Q1dbGrso6RhC
         aH970OhJdlNGCY5gJ3uRCL+iWImyAbs9qkzjerMOldzudBwIh26R3zf0O8vUZq1a7qKW
         D82/OwFCHBhBH2mYUXwUBbDok262nsjEyC3p7nx6bfRBf7kTeDVgfCbT38wt8G9xrc/C
         dq16kv7zNdHDm80y7Fnj7GbzPi1ARnFQSV4/GRxlp1FXPqqwjmWKoaEM+Kx8M818/7SJ
         Ob6rjzz+QxEy+i/f3UhGbd2qqxUYco4Lxd6PGIxNej3s3PeWkFK3pg5jp5c5mFYV7Eom
         ZEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349356; x=1754954156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8NgMA0HX6GfrkP4AehXbgu9Qzh9g7nw7slgx4SS+9M=;
        b=VCDXTVHUH463KEbaglBczNlYm1TwCt4+6GAgQW35G2IBBe4//yaxGtRiYOMEk3/oJg
         TeqeqpTrGBKUeuS2Jzg+lXadO2lfw5HCJcLOMx7RL5cYHKH78Mkzlok3SGgz2ZogKsim
         jgqzePB7GsiC3lLVO9kHrnEEHEjd14RlZr9RG92PSvFguB25vtUYkC1bjWcs1KbhPO+V
         eQEmKe7z5PTEgkDD4jS0MxAd1bhRxuGCAvcsccoHG3ePi6J0EzCfYNhWdMZfvrf0oX5p
         CjYtk6e9zXAgEWuQq2z+ZXmp4eC7/ia6+u5YyRCaNXbh1n730Z3NCvO0L/N7Q15PcJrH
         QlgA==
X-Forwarded-Encrypted: i=1; AJvYcCU10w2370Z4oUdbVmXMSTjWUKvVQSem3bTEFNmxEfM6ougQ6zN5y2krlvI8FYx5OpvfIRSP+xqfz4sPUxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbPrL9X1HGJQRn/Il/ESR9k/n792nBq8h8r6XSA6gLEj3Z/ZZ
	ibn6S9TTl7SEU1PGGBG4JD+2Ypn2qe3IcTQOy1lK/ldpQrgT3T+0NzIJeboEiLtoXOWNPsrgiGJ
	qdz7mFg==
X-Google-Smtp-Source: AGHT+IG2q4Q/icGmfZqa/AQL4Y/7ixWiXboOhyChxpBm5zefJHZYEBLAPMKg6t2vVqdvtV/Sahk/uwOkeqs=
X-Received: from pgan189.prod.google.com ([2002:a63:40c6:0:b0:b42:da4:ef4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9994:b0:23f:fd87:424b
 with SMTP id adf61e73a8af0-23ffd874f47mr10654460637.44.1754349355847; Mon, 04
 Aug 2025 16:15:55 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:15:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804231552.1217132-1-surenb@google.com>
Subject: [PATCH v2 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With /proc/pid/maps now being read under per-vma lock protection we can
reuse parts of that code to execute PROCMAP_QUERY ioctl also without
taking mmap_lock. The change is designed to reduce mmap_lock contention
and prevent PROCMAP_QUERY ioctl calls from blocking address space updates.

This patchset was split out of the original patchset [1] that introduced
per-vma lock usage for /proc/pid/maps reading. It contains PROCMAP_QUERY
tests, code refactoring patch to simplify the main change and the actual
transition to per-vma lock.

Changes since v1 [2]
- Added Tested-by and Acked-by, per SeongJae Park
- Fixed NOMMU case, per Vlastimil Babka
- Renamed proc_maps_query_data to proc_maps_locking_ctx,
per Vlastimil Babka

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250731220024.702621-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 149 ++++++++++++------
 fs/proc/task_nommu.c                          |  14 +-
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 4 files changed, 181 insertions(+), 62 deletions(-)


base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.565.gc32cd1483b-goog


