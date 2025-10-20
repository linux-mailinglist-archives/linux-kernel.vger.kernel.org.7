Return-Path: <linux-kernel+bounces-860037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDDBEF2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5DD0347291
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BAC2BDC3F;
	Mon, 20 Oct 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWJj+lxc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586642BD031
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930269; cv=none; b=vAA2JgPPkgYlsdOE9bHw34R/9MXCk3Y9WhGz1rODeIDMYOe4sMxfM/+CafZX2+LizCFLpWs37xKfvyhOfCHFSRTDK8wXIfLRxlOo3ZFacZXGT4hi9VXhAug+M8DVaWfSd+nKtm9svpTPQVuFkPhg1lRXH2uwgd6leawiGLUM4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930269; c=relaxed/simple;
	bh=AZhf0bN3dMzYRxemSSdBnaN8exURAvP50px9ndo8GmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+YmgMZylpo0xEewJ5KRk3yXNdN1JYyk+DzrGwwKE9aHUQPlO9apIxDzocNHhgp2ROVO6QCv1pvSp548cOaKOywQULpg1MiwxwTR3aaBfAYRRw36sxuRqwbnDvPbQsTRInMlAsjPrz11X3S7Q7xaC2J2QBcF7i4MA58lPs1sYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWJj+lxc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26d0fbe238bso28620195ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930267; x=1761535067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4o89aqQquJfXg8DHNFFwhPZpHBrXkamiWZUkDvNw/U=;
        b=FWJj+lxc3T/WTeJc1ZW+YCdw7vbgZp7sk/+v+TZotkj8OxceDn238FSLapKwjRi/Jw
         WzF4V1IMN2ByL0d3d+z+g4jOKEHvBuFqL2TEdem7Z3rsGz6MRZnU/XJ72ldp2umiDvM/
         TOUlUeEPmvqbl5x2vL3gge1rKndPPWUnePX128mHfzX250id1uyIaMWP5cHutoWj/NNH
         3s7zVHiG9GvESXUC0k+DVahIb2akCyyOZJwRnZar2zTB5Nghg+9cmw4yaOV99oIgm4yb
         Qw8Lg9pzhsbyQ/vBgHwAL0nwsuDDPB6Kfh2ZBBMvpmqEU42huDbeyXX3LHJ9p1PoX6W2
         r4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930267; x=1761535067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4o89aqQquJfXg8DHNFFwhPZpHBrXkamiWZUkDvNw/U=;
        b=ZBAXio+++pWIHN50gWWtui405z+1g8DyE8s6UxLWmSqec5FVogZ3xVJIT7a9I0+NqM
         DId8hsiI6MHWktVqoelmfBjoP/iG0j6HxQnl3L7lZCmsV6p4fhQ0rgYO+ZIjGQVmMwOa
         aFWWIwcCahUNDxssCjKY1b+YdIfhQK3RdhX8a7yFkHxedgDcw7FgdAxdihjqoqifRXsL
         jiXeYDnYa1KmCH5CLYXhw/HdhDzGsm/+7uf5i1QsSHGgn+FE6F5HIZO5bX9VFHczb9Sm
         ZtxOBFgbU9utHVlABVxC0Vbo7U56cAFE59WFEK09V96CXyLWT9BzvOwILwbzSn1SjKIi
         8Otw==
X-Forwarded-Encrypted: i=1; AJvYcCX0D0zQJ6iaieVOh1piWK57zSbMHEQRAjbkmj8dSsNs6PV586s43yE4FXy5kQEnQRm3hAus6kw6/W9w7jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiFl8DELVVZjdg316cXUXJNuMi01mHpnjC/uwAOxxlEcqYUi4
	Xyqg4HSfPESSgnbrcEcPgepK+1v7cRuS6HKsZ3sQg+1MpwYmq5xqyI9S
X-Gm-Gg: ASbGncueDyE7QUbhb+fzAoYT57/fb2TvnUQNA+Cw+OTO4IT5kLtepqnlea5cRGPZpRH
	Inuqmdr2ipTD9PhnlkXvsr0QMDsPu6v4rk8XUsdE28gnv7eVoVkRstiWdPMfSmiqdUcNWvooT8J
	fkeX5C3Vih1W0bimRG1BLoq/E9QKNLpLViap4n1QHostAxApryGwOVTNFzBXMx/ujeJmvuoBkw4
	DN+YCIvw2l/XxvJVyGudEjG6YMeCBGLiWJtWidkJbzVt4TmWc2ia5aOnUKFIAkwchcejrr3T0D/
	nC395aWlOeHaP+Fyy+HEqCp9wfCpQ8LJQkmRqc06mtuw1ltHAKd9wmi75t3ZFnQOC/Jvf07Cr/d
	sxF4cXhny8hxmjqscDO+0dJ0NJCVBVabnAwgLTvkvKd0LzGDe3HueR99xG7mFH9Pb2ShaP8+c15
	z12mmNdl6TArRSh6wrc1RR3E86D2AaGKU10WuEYnqZeTXrXA==
X-Google-Smtp-Source: AGHT+IGalCyWkc7C8LmPCGO9urIs1Pwdm8eNflQX/0Ho3b+S9hSSF1w5msjDxjkD1RQDifOCduychw==
X-Received: by 2002:a17:902:d50f:b0:27d:69cc:990 with SMTP id d9443c01a7336-290cb27e0bfmr152822005ad.49.1760930266552;
        Sun, 19 Oct 2025 20:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:46 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
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
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 09/10] selftests/bpf: add test case to update THP policy
Date: Mon, 20 Oct 2025 11:16:54 +0800
Message-Id: <20251020031655.1093-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031655.1093-1-laoar.shao@gmail.com>
References: <20251020031655.1093-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case exercises the BPF THP update mechanism by modifying an
existing policy. The behavior confirms that:
- EBUSY error occurs when attempting to install a BPF program on a process
  that already has an active BPF program
- Updates to currently running programs are successfully processed
- Local prog can't be updated by a global prog
- Global prog can't be updated by a local prog
- Global prog can be attached even if there's a local prog
- Local prog can't be attached if there's a global prog

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 79 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 29 +++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 2b23e2d08092..0d570cee9006 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -194,6 +194,79 @@ static void subtest_thp_eligible(void)
 	bpf_link__destroy(ops_link);
 }
 
+static void subtest_thp_policy_update(void)
+{
+	struct bpf_link *old_link, *new_link;
+	int elighble, err, pid;
+	char *ptr;
+
+	pid = getpid();
+	ptr = thp_alloc();
+
+	old_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(old_link, "attach_old_link"))
+		goto free;
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THPeligible");
+
+	/* Attach multi BPF-THP to a single process is rejected. */
+	new_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops2);
+	if (!ASSERT_NULL(new_link, "attach_new_link"))
+		goto destory_old;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THPeligible");
+
+	err = bpf_link__update_map(old_link, skel->maps.thp_eligible_ops2);
+	ASSERT_EQ(err, 0, "update_old_link");
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 1, "THPeligible");
+
+	/* Per process prog can't be update by a global prog */
+	err = bpf_link__update_map(old_link, skel->maps.swap_ops);
+	ASSERT_EQ(err, -EINVAL, "update_old_link");
+
+destory_old:
+	bpf_link__destroy(old_link);
+free:
+	thp_free(ptr);
+}
+
+static void subtest_thp_global_policy(void)
+{
+	struct bpf_link *local_link, *global_link;
+	int err;
+
+	local_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(local_link, "attach_local_link"))
+		return;
+
+	/* global prog can be attached even if there is a local prog */
+	global_link = bpf_map__attach_struct_ops(skel->maps.swap_ops);
+	if (!ASSERT_OK_PTR(global_link, "attach_global_link")) {
+		bpf_link__destroy(local_link);
+		return;
+	}
+
+	bpf_link__destroy(local_link);
+
+	/* local prog can't be attaached if there is a global prog */
+	local_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_NULL(local_link, "attach_new_link"))
+		goto destory_global;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	/* global prog can't be updated by a local prog */
+	err = bpf_link__update_map(global_link, skel->maps.thp_eligible_ops);
+	ASSERT_EQ(err, -EINVAL, "update_old_link");
+
+destory_global:
+	bpf_link__destroy(global_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err = -1, pmd_order;
@@ -214,6 +287,8 @@ static int thp_adjust_setup(void)
 
 	skel->bss->pmd_order = pmd_order;
 	skel->struct_ops.thp_eligible_ops->pid = getpid();
+	skel->struct_ops.thp_eligible_ops2->pid = getpid();
+	/* swap_ops is a global prog since its pid is not set. */
 
 	err = test_thp_adjust__load(skel);
 	if (!ASSERT_OK(err, "load"))
@@ -240,6 +315,10 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("thp_eligible"))
 		subtest_thp_eligible();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
+	if (test__start_subtest("global_policy"))
+		subtest_thp_global_policy();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index b180a7f9b923..44648326819a 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -22,3 +22,32 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops thp_eligible_ops = {
 	.thp_get_order = (void *)thp_not_eligible,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(thp_eligible, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	/* THPeligible in /proc/pid/smaps is 1 */
+	if (type == TVA_SMAPS)
+		return pmd_order;
+	return pmd_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_eligible_ops2 = {
+	.thp_get_order = (void *)thp_eligible,
+};
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_not_in_swap, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	if (type == TVA_SWAP_PAGEFAULT)
+		return 0;
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops swap_ops = {
+	.thp_get_order = (void *)alloc_not_in_swap,
+};
-- 
2.47.3


