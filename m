Return-Path: <linux-kernel+bounces-766993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B43B24D67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C75D7BC80D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119126AABE;
	Wed, 13 Aug 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2vzrFgK"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01238265284
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099040; cv=none; b=QhoRgH56W7Kxitk8ziXmWnaUBQ1M58+q8xMIUFbiLLNAClplhStHGRWYq/lXNOtIog3ep9A29/wANYZPsbZt6ykwE0g6cIwk932jPXKM4C8FhFsXDN5GLUy8T606onfVoNQbIkDhOwDRftBibQSy32+5fRb4tsqpeseIHOL0zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099040; c=relaxed/simple;
	bh=Lq/MnBJO7IgZrEMAWluUyyddXBO6L7dMH0/XYrmHcf0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PQ6XFlzrLiBAAjp510Yi5RSrJvCI5DuK1ICjSECV6Z31R9kXNSnFroCaaz8qivSnCiEWGrpNOgdhgMyC5B/5JaBtDljr28OSPa2TWlnFK6Ky/Zyf6gpGGUfr/OVktY3IkwmhYVrziQ7FdiavVFQOOSJKQmpzW6oQ2iBXVvKicLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2vzrFgK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755099025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbKIrg1u+aegCZtj1WAHU6eFnKOD0XbkWiMGluO5IUw=;
	b=h2vzrFgKPvgV0rds3aqAio70G3hP1AIFLxbOsX7gfavp3K0Ps4wuo0ukHltPOsxlMtr0ma
	vN6df2RLBi9JFUKnzUSOGWsoo2ri4zIDbS5A/7t3wmn/SqStunZAXuZXnzCRCFb6D8pi0W
	FqrddFnWclpXKZZ0Hc7Rj2ApLjZMFjk=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	mrpre@163.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Allow fall back to interpreter for programs with stack size <= 512
Date: Wed, 13 Aug 2025 23:29:56 +0800
Message-ID: <20250813152958.3107403-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This change restores interpreter fallback capability for BPF programs with
stack size <= 512 bytes when jit fails.
Add selftest for socket filter to test it.

changes:
v2:
- Addressed comments from Alexei
- Add selftest

v1:
 https://lore.kernel.org/all/20250805115513.4018532-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Allow fall back to interpreter for programs with stack size <=
    512
  selftests/bpf: Add socket filter attach test

 kernel/bpf/core.c                             |  16 ++-
 .../selftests/bpf/prog_tests/socket_filter.c  | 124 ++++++++++++++++++
 .../selftests/bpf/progs/socket_filter.c       |  16 +++
 3 files changed, 149 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_filter.c
 create mode 100644 tools/testing/selftests/bpf/progs/socket_filter.c

-- 
2.43.0


