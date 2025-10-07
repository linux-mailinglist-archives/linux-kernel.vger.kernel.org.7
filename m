Return-Path: <linux-kernel+bounces-843658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B166BBFEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 831674F272B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFAE1DF254;
	Tue,  7 Oct 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmHTqhIE"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38651B5EB5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800203; cv=none; b=uv7y83fZAQt2+eb8Sfdx4AcKZW/Oh+fRQqTq2gXR1cAyr6HP7O9eh+VeX16+cl5G8+bSrW5pGp2zFVcf2Hl8zw7fqGGnfhsyFhulgilzrhjbsSG/0EQZyubyjZZSERZoL7TU6nYErfz6gEDmf8FtF5q64yLrhaEIsLGgxW9A6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800203; c=relaxed/simple;
	bh=Zkg/4/M1W90opEFaeUqTox6cu1LMdIBOwiPvGzQMLZs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KNhaEKrhq9UvIf2Bt2drWcE7V2wvAeEMYGxYsFOIEfRSiUXwl1K6OJlB7yj5ZKtUxWJoUlIBMIRrdJgNrZhTJ6pBT3qy9o+wmPLKI5CUsvU2OKXjgeOz8aYVcwlZYFQgwYu5mReaIUypczrYTwHtVW70igDOllYLJ7SHQJ1xb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmHTqhIE; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759800198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13Tbayb7LRIEib3J/XQk5H3VZSA57m10o5ojkPGrK3o=;
	b=pmHTqhIEGN3RBY0xaKXnEMnzDn+4FR6eZxGeDbWQZsJQCSBpyEgFtNVmktSdMmSG32xqD5
	dlLKCjv5QcAhlX4tCf8v5RNVwd9TOmabzc5TnfkxrXONxgk+F8HvjMQOyIpm89lgAWiVm0
	PysZy4YQ4N2oTlWsgJG7Vi5hofPOUi4=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
Date: Tue,  7 Oct 2025 09:22:32 +0800
Message-ID: <20251007012235.755853-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid RCU context warning when unpinning
htab with internal structs (timer, workqueue, or task_work).

v2:
  - rename bpf_free_inode() to bpf_destroy_inode() (Andrii)

v1:
 https://lore.kernel.org/all/20251003084528.502518-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Avoid RCU context warning when unpinning htab with internal
    structs
  selftests/bpf: Add test for unpinning htab with internal timer struct

 kernel/bpf/inode.c                            |  4 +-
 .../selftests/bpf/prog_tests/pinning_htab.c   | 37 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

-- 
2.43.0


