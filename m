Return-Path: <linux-kernel+bounces-837174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF5BAB9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EFF1925DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FC2853EF;
	Tue, 30 Sep 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKxAC9SS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E43222560
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212000; cv=none; b=E3ICepeGKfpQVT4gqBLY+dK9S6oozOLOq/dWbltaQUAr9T9G87qulmHkwnKrx2RxWOueTBw29UmezWPdSlnTOnvOfg2ZsgeL4Pp9fBEWZnptqDH8WHWIUTVjpzfMd63hf0e5sGy0NOAlgOqDEP5iH1OXltqDYgLd/kQ3Wjlzxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212000; c=relaxed/simple;
	bh=/PMdDC4FDfpJHwrfvPwAn92Vwj5QW0m0NvTBiXm9L2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/1PRSjA2OPatF+HiB0FYgMOoA1Ffz32+xUTlimb8+MfSW8GeHG0Ttg2nm5APSxIBLUcftUSp91jJUieFPUmj5KQnkmwe2YcCkUFUkNQnS+zqu4xiWFJV0/TJlMa+nLkYxxjWsi4q9K3WohCkEEKSbw2c2KfgoHAkXqCJjVQjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKxAC9SS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b57bf560703so4119986a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211998; x=1759816798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=jKxAC9SSr5PpQCU4NI4dYxin5h1Ru0bOlUGNViEBSnJ0FUuVExjzi+D5UWedLVjTnj
         hwcA1w6HPBtE3MZKT8Dc9L3NhRCDa8ykZYueCh8Y6hNvgxvX/iSOA/fcBKWkRE71EAmC
         fyhWXxE7vROkgCcpS8hjbUK+MWJzWZtYyzJpZSRQX2uFI2cbWD5+3it1QP/5lEDlPLEL
         rUHEInGsLfiPCu/g0RIFtOoSKL4CBqJ6IuR4+Nsyg6ujC2VEkrVMhJLkSdI3ZF3gJEPd
         Utr10XWiZXLhu4wfJMoY5d39u/LssMpcUtj8U+Zdqn1q7IEiobYyhd2DEJhWfrbzabUm
         TlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211998; x=1759816798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=hqZB99KsE6e9gZWH+BGD6O/rgMtNZd4R/sbib8GhcOsAYu+v/5GYP1iDX+GZRFLy6f
         9M/YmAxzRc1MKlHuJ4xCpXIo/bql/0S4WFbGM2iuA/s05VAiSgLzLVdfOy9vQ0LPwf8K
         LuPKMgWeE5B1zPDGx0ju/A0tU/ig7FQXJqNokmFQy7cpWzJcuAdE6QOrBP5nlbLuxNWK
         KnawHpbzIMz6xzi5LHa+lUmQEzuZUiqoi12J4GAoCigPPDZf/7PXkmrOYDJxuLzS/pHy
         JktYDN3jrGRCulgtrhEvRkBEz6fQ0dznb5z9KKnpUQoypV1ZnIGyCS2ElVQ2GhlaMDTj
         ov+g==
X-Forwarded-Encrypted: i=1; AJvYcCUPOsw1/fmsRpCORnAzuvcUiRc3fIOhxSCYnhBXn5+BxrgFeCtI181uR9l8NOd29NQOp2lnUZKZpwm0LCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKwJi8Vl04m6638tQXVvgvshPbMHUKXYrKNrwAmIO8Wm03q1G
	SmP5XGDI5DNPL/S39SB+u1XhXd+5hkBgCbpR1lTAeQboeJdSpxFUOHQN
X-Gm-Gg: ASbGncvqtKEOrRUaEOq2YY8ULhj+K7/wZppy4+gwtvZ+NyhamjieQSjsB6sWWq4pVG8
	j3X4WJJAw+53CpV6I6BmE1nj1ozcXodeSl0aI38Q9RU0KrX9OM5bgVetLDJAZ1FyRMGCMtv/xkf
	bcPyDVmFesp3QWS5nNDyzm7QIHZNjOgMFNVp9gwljQzwkDjGYxY1YxAVN/3XRmXtpJfxaKSFz2w
	IIIfmJZnQ9Zu95bXDPShnoIuJk66DMun7Aq38Q2CsTfDn0HX153ui3ayHhLish8Dm/n6dCSPeju
	td55VXPYx9jjY62hUaX7Jelr5LVi1p8igJw09VZl46TWYxZYWjOKEADLIgqsBxnAtLl0ilrwLgV
	Zn0YDM6ba7dC0DBa9/rIfHAab9hrc/KU1a2oX8hDIPhXUTg/amFyjK2BFwZIewfqf5Kpoqpbizr
	XYajouYYWAH6tThGLBGdkeOBij5rVhd862ER19Yw==
X-Google-Smtp-Source: AGHT+IE9k45OyD1zQ/sX5CO57YKwXTRytMKq5dOgl/BGR9iX74e3JrI32v11I5E6AD/8k/izN7MaGQ==
X-Received: by 2002:a17:903:13ce:b0:275:c2f:1b41 with SMTP id d9443c01a7336-27ed4ada760mr178958735ad.53.1759211998324;
        Mon, 29 Sep 2025 22:59:58 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:57 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 07/11] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Tue, 30 Sep 2025 13:58:22 +0800
Message-Id: <20250930055826.9810-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thus,
we can mark it as trusted_or_null. With this change, BPF helpers can safely
access vma->vm_mm to retrieve the associated mm_struct from the VMA.
Then we can make policy decision from the VMA.

The "trusted" annotation enables direct access to vma->vm_mm within kfuncs
marked with KF_TRUSTED_ARGS or KF_RCU, such as bpf_task_get_cgroup1() and
bpf_task_under_cgroup(). Conversely, "null" enforcement requires all
callsites using vma->vm_mm to perform NULL checks.

The lsm selftest must be modified because it directly accesses vma->vm_mm
without a NULL pointer check; otherwise it will break due to this
change.

For the VMA based THP policy, the use case is as follows,

  @mm = @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
  if (!@mm)
      return;
  bpf_rcu_read_lock(); // rcu lock must be held to dereference the owner
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
    goto out;
  @cgroup1 = bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);

  /* make the decision based on the @cgroup1 attribute */

  bpf_cgroup_release(@cgroup1); // release the associated cgroup
out:
  bpf_rcu_read_unlock();

PSI memory information can be obtained from the associated cgroup to inform
policy decisions. Since upstream PSI support is currently limited to cgroup
v2, the following example demonstrates cgroup v2 implementation:

  @owner = @mm->owner;
  if (@owner) {
      // @ancestor_cgid is user-configured
      @ancestor = bpf_cgroup_from_id(@ancestor_cgid);
      if (bpf_task_under_cgroup(@owner, @ancestor)) {
          @psi_group = @ancestor->psi;

          /* Extract PSI metrics from @psi_group and
           * implement policy logic based on the values
           */

      }
  }

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d400e18ee31e..b708b98f796c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7165,6 +7165,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
+	struct mm_struct *vm_mm;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7206,6 +7210,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 0c13b7409947..7de173daf27b 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -89,14 +89,16 @@ SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
 	     unsigned long reqprot, unsigned long prot, int ret)
 {
-	if (ret != 0)
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (ret != 0 || !mm)
 		return ret;
 
 	__s32 pid = bpf_get_current_pid_tgid() >> 32;
 	int is_stack = 0;
 
-	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
-		    vma->vm_end >= vma->vm_mm->start_stack);
+	is_stack = (vma->vm_start <= mm->start_stack &&
+		    vma->vm_end >= mm->start_stack);
 
 	if (is_stack && monitored_pid == pid) {
 		mprotect_count++;
-- 
2.47.3


