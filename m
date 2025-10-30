Return-Path: <linux-kernel+bounces-878530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2AFC20EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B01A669A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9836337C;
	Thu, 30 Oct 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="huPOTtWk"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0F36337A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837931; cv=none; b=JXoc2tTjOiJGt6/RAI3YJ2rLNbeha4X4LTHZLCWizEiQ1YJ3/zE82+WkQ3m7UnWtRpwVsdNf9I5OWealrlTMBUSiNho8MV6GY4B0HD0Q2gFl9ayOaKrRBEeK2hxqG1Ay5EIrs4CekAJPo+4W37x6SkJvA52oa4JxfA28z3WSquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837931; c=relaxed/simple;
	bh=Me7vbqKDPfCUEl9uOwEbXFhN7y1z8OPplh80PGtMN9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ethce7DrAcHPEc70QCUduj/hkHX/TvdomsN3tBh3CYVFcXUQm0Fe6dS8ctkzaeBx4vvMz04TBql7WXKUrZUZ1lb3ZJ0AZNoneYJ5Eq/SA8kiqhG5AyWSMn5EoVaH1KjzCiziwcHD9BenQ3ZxnfiQZuhoX4quSXtAZxux+7MzE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=huPOTtWk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZN3VhvADL3RotNT5kk7tKn1b8A+dl8RVEWaMrQxD5DE=;
	b=huPOTtWkq//K7tz8xCxSy8W0UcxxGNLpgyOQ/ZNeadOXKk0t+cQrLaKt2oo46+KVlKBmg7
	yBI3lEWEBtfCqfvZ8LkLtwtP3n52/sZqg5M//m+/GLcb8jRFXv5pkEqwbnkRKFk4G/FHAC
	5hIDfB+MbfhsXjvIOU8k7QY1IGKY7Ms=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 0/4] bpf: Free special fields when update hash and local storage maps
Date: Thu, 30 Oct 2025 23:24:47 +0800
Message-ID: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the discussion thread
"[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
it was pointed out that missing calls to bpf_obj_free_fields() could
lead to memory leaks.

A selftest was added to confirm that this is indeed a real issue - the
refcount of BPF_KPTR_REF field is not decremented when
bpf_obj_free_fields() is missing after copy_map_value[,_long]().

Further inspection of copy_map_value[,_long]() call sites revealed two
locations affected by this issue:

1. pcpu_copy_value()
2. htab_map_update_elem() when used with BPF_F_LOCK

Similar case happens when update local storage maps with BPF_F_LOCK.

This series fixes the issues by properly calling bpf_obj_free_fields()
(or check_and_free_fields()) after copy_map_value[,_long]() and adds
selftests to verify the fix.

Changes:
v3 -> v4:
* Target bpf-next tree.
* Address comments from Amery:
  * Drop 'bpf_obj_free_fields()' in the path of updating local storage
    maps without BPF_F_LOCK.
  * Drop the corresponding self test.
  * Respin the other test of local storage maps using syscall BPF
    programs.

v2 -> v3:
* Free special fields when update local storage maps without BPF_F_LOCK.
* Add test to verify decrementing refcount when update cgroup local
  storage maps without BPF_F_LOCK.
* Address review from AI bot:
  * Slow path with BPF_F_LOCK (around line 642-646) in
    'bpf_local_storage.c'.
* https://lore.kernel.org/bpf/20251020164608.20536-1-leon.hwang@linux.dev/

v1 -> v2:
* Add test to verify decrementing refcount when update cgroup local
  storage maps with BPF_F_LOCK.
* Address review from AI bot:
  * Fast path without bucket lock (around line 610) in
    'bpf_local_storage.c'.
* https://lore.kernel.org/bpf/20251016145801.47552-1-leon.hwang@linux.dev/

Leon Hwang (4):
  bpf: Free special fields when update [lru_,]percpu_hash maps
  bpf: Free special fields when update hash maps with BPF_F_LOCK
  bpf: Free special fields when update local storage maps with
    BPF_F_LOCK
  selftests/bpf: Add tests to verify freeing the special fields when
    update hash and local storage maps

 kernel/bpf/bpf_local_storage.c                |   2 +
 kernel/bpf/hashtab.c                          |   4 +
 .../bpf/prog_tests/refcounted_kptr.c          | 134 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 129 +++++++++++++++++
 4 files changed, 268 insertions(+), 1 deletion(-)

--
2.51.1


