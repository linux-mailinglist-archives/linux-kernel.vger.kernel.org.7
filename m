Return-Path: <linux-kernel+bounces-833835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0EBA32E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F14C7A31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CC2C1595;
	Fri, 26 Sep 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVora+UU"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30562BE021
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879312; cv=none; b=GdIac65S0g9VNfscFNb5MySxlc2EA8MSPyYzy8RFkL28vURN//uf1k6E1pzdZSH6jOmor58iINUGcWSZZlXfT/TEoPa+g9OlzxIr8HhrvX8QskTWABsT4rsxd2zOH96p0kHWFCpkSrLwCbOIGRQl9ejDhB/LWYmy1/elM19ktv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879312; c=relaxed/simple;
	bh=zrlWjexRS+e6cnuSCMRZ3/yt6yu9oHpAebCTZ9vSuDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itXIeGfdo7/zsAFDWe2m4Vbu//WovJuDMfuShB4hA6h94EzfltEv+ieo1J+3hXFso2zum4otMVamWpOlkRTHFHFvwapAeRUacoNpbENqqzf4bYpSXidCNW4pbOZslMBARETsrmGKlzn6ssfSNJK1fgWkrOvoOXYPuJQlbAaVq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVora+UU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681660d604so19269845ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879310; x=1759484110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw7WNnQLHMUa0Yn2DLPfVIa+t6BCCpmxXRHnFLCbq0M=;
        b=NVora+UUFXjQA9a6jq4f8i1ID4HKYlAjXIzCMjvNJ8PkLP//n0Iu0L9CK352sg9XbS
         Z8D4pBWGZKt1Kjhb9O6fBiBDHp0O/SYsRs6gdxO6R02mRnQ5m0lG5pDM4UChnH1+jUJw
         bzX5V9YiFycDZGiXZLyQG9KyPUERRKqDApjBr7kzmaAKVm9IPDTjxagBvV3nXRJW0k7t
         PTGCv5Bakkx1iG5DFsN8dKD8Bx144kY7iZf5VgOyShNTKYDJROav6usuYe3b/bQOnrmc
         b3TIsz0fsXFBsDjPaZzjV6Rw64+N+wgWNGo+n+gnBBDxAaeOgEga9bWJmKvfapWSzT/H
         HVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879310; x=1759484110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw7WNnQLHMUa0Yn2DLPfVIa+t6BCCpmxXRHnFLCbq0M=;
        b=SdgvWKNpkS5R63YfmlLvc77Y+eq/4dCAzKypA0vYPgqZD3Vksu+0EgfEkWvHN4iocD
         ZzVrCq1Sl1HHCtSlg/78fYzJWDkZeZjJgWl76A3RLScbyZLfRLAZrdIMrsZbQo9CPoMu
         W7099CECVHZqan3uxmNIozASxuMqWzC2vzcL0xiXprFi384hazYqlG3K5GqRunJnRIL/
         eblsw47TfX7cNyxs/G62fEfWrW27Ss+rWZ7XE4+mE+/Sh4/kSdt2v1WYtKTUMU9LeAQ6
         71wQ3gP8WkeWI40qlbtBhYc8HcCw7rSVXjeqEANHiYVUi2dx0DnMkYu6pMpCrd7AqSR5
         ctQg==
X-Forwarded-Encrypted: i=1; AJvYcCVN1laucPifj+QibWU1MstZTXUW8dE9YmZEGzD2exNLGaKJOS35ebuEDauUmF5mDFxQOEA0zKS/dUZvZzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6dZow0H3psHMH+4VLU2KKdSZHzHNdlHQLi2lWhG9SqOK+D1Q
	D/1aWl0nBLxWYv+UI/UwYLiflMm5uHbU3BxLaklXEetYaG2wvlyq/jeW
X-Gm-Gg: ASbGnct3Pf9Cqwz/fGb95x9kDTaM7RpGHye22QIkwseD2hdly9o/KJhxcE/4yBlSRuo
	bGZGknkInGb5xd579eMgfX3+BC/GsHp3ECHoGVEIZyTliOQ8ZWjQ6VIH+FzXnc3XCys9L4Q4oYO
	HxmfEFAJleyErUmAnDtCaQi7J+ZNKwxkoWFWL6xjE0KCMZ+VB/CYsjKw8ctAUDagipOLa8AVwxW
	Cg7ONmE/kFeJsfPcyKh6jxDJe7oXAGCeIxF7a6+FVWpsyNWsv7UUyu9BMsGof65HIAqHzRVr8ch
	nCuNEqcEu4qZgUo0gElyuLkkrlkMmPXuaKMWMT0K4e1EBG8ANxUQznu6rHK0cYMa21+nd/1E6QS
	yHLqD7fq/1RE7B2kdeYjrJfekrt5/ecRUOenJW+EmdqfxnwuAewlV6657E+v/cZv4l1iHksF0B2
	Vs+bjjdVQ70Jro
X-Google-Smtp-Source: AGHT+IEEuMzIy4jcfzpCO06+83GzrwWygKfi3d1uaHoYRS3Fbpuh2MpzvVbrFawoF8VwJAU/udjvNw==
X-Received: by 2002:a17:903:37ce:b0:278:f46b:d496 with SMTP id d9443c01a7336-27ed4a6085amr60657335ad.55.1758879310067;
        Fri, 26 Sep 2025 02:35:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:35:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 10/12] selftests/bpf: add test case to update THP policy
Date: Fri, 26 Sep 2025 17:33:41 +0800
Message-Id: <20250926093343.1000-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case exercises the BPF THP update mechanism by modifying an
existing policy. The behavior confirms that:
- EBUSY error occurs when attempting to install a new BPF program while
  another is active
- Updates to currently running programs are successfully processed

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 23 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 14 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index b14f57040654..72b2ec31025a 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -208,6 +208,27 @@ static void subtest_thp_eligible(void)
 	bpf_link__destroy(ops_link);
 }
 
+static void subtest_thp_policy_update(void)
+{
+	struct bpf_link *old_link, *new_link;
+	int err;
+
+	old_link = bpf_map__attach_struct_ops(skel->maps.swap_ops);
+	if (!ASSERT_OK_PTR(old_link, "attach_old_link"))
+		return;
+
+	new_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_NULL(new_link, "attach_new_link"))
+		goto destory_old;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	err = bpf_link__update_map(old_link, skel->maps.thp_eligible_ops);
+	ASSERT_EQ(err, 0, "update_old_link");
+
+destory_old:
+	bpf_link__destroy(old_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err = -1, pmd_order;
@@ -253,6 +274,8 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("thp_eligible"))
 		subtest_thp_eligible();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index ed8c510693a0..8f3bc4768edc 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -39,3 +39,17 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops thp_eligible_ops = {
 	.thp_get_order = (void *)thp_eligible,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_not_in_swap, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	if (tva_type == TVA_SWAP_PAGEFAULT)
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


