Return-Path: <linux-kernel+bounces-833833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DEBA32D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A344A64A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E92C0323;
	Fri, 26 Sep 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCtYvl9i"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C42BDC19
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879297; cv=none; b=r2KSnOsukiKV+1Z1wRBjJpouzJjBF7BvL2xGamULt9yqZHlSxKnEGIkdxBJ0TfbDGWZpHboTAL4TNj3IzmYhsm33FKnmcxtQ5KpxEqnze8Zs7/quP+sEGKw7ykqhU9ABf+CeTzKD5CTXQeV7yGdK0VrAYiqUj3MESIARAOYQdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879297; c=relaxed/simple;
	bh=/PMdDC4FDfpJHwrfvPwAn92Vwj5QW0m0NvTBiXm9L2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2NMIBXBqEhN4Bu3EqWkLARLdd98QCmX7kw9k6F7kKi0r0snXtb3A50wxPiCv/RLOP86g8YD1iYjLp/wWhozHfDrbhuogvF3GCECkL7DTVp1d9ortaXLuTzzzmgnJKjsAR+Xcshe84qDOJnxTNWdaXaIwmmq+giFRGOWfsJvJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCtYvl9i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-279e2554b5fso16903355ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879295; x=1759484095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=ZCtYvl9ikGi0ehtdQzWeMnMzEojSZ6FTITmWcAXduTITfYKK65sIhl6Nmon9yJV4sb
         ymURvhbIT7bwm/FO44u9OJe/hGFOqmpFOrrj//Q/sXkL+OSVFF0q3F/F9zFDmtxwu233
         QCxSmln2MvlFQjEDUw9qUDj3HBJQjs92knQR3yPTKQJ+MzxqbHkp/SUrbI4IIUD+i9GM
         SI7nLgnxRURhVF4aXTgT4xniTfCK45ADYePZDnYFIMFEEtEVYlPDD/5z2orUH0HM/jLA
         B1v819hx4+t8Til25dUtRiLIXTIlevSx66iO2h1mL0AhSBxrpgT7gBv459oMF7WzgtA9
         LDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879295; x=1759484095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=f16uf8hH1NOJccTdeME8IEvZwdewZcgrTP8a4D0mrGaP4qUDu+UCmfX7ISjAV9Ak+b
         0idc9GKY3yq5vCDsmjDV8kcmIRLZ8B2x9LYF41ocBdlZbzJM5W9Bf7biigVJLpwTnhNG
         z8S4ASV2pXDTv/y6tcMDXAEbrjGwgfie5id+7EEpeNxZTjXPoEAkUCEqQxaMRw1UxqxT
         bV5PXgLEnUyXUdE/StMtw5D6/D012KG6/PvniElZNJwxqOifUFQx9aU+DXNYnmAvStpc
         ST3NYtEudl/qh4xdabKQCtvWA65nLNA9TL9tdR5kxSbGOFU/f1mY0yJDwwUbSTKdTDT3
         X+hA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4LiXYtoxUWpjAOn/GJOAD5Xyp0Np9v952SkRNnP7F0JgR47aaij+8ye2JRw5I1wSaeJKJCbMI8OPVCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9nrWtb23laTd15863r2VpCMEEd+gbO0nrtV9sXPicWAi/Jrm
	+d2WGHOHMrhlCs9wzuWnEE4D1Q4S2Jp/kxzJbrKQ2XKajIIqFoo7s2P9
X-Gm-Gg: ASbGnctEoD5uBG5asoXlOgm1VXzZW7zArg+hcWfOx5C3mRUakjKaFAwWLmK7eMsiXmo
	5okEpSbVOUmR69rXp+F3t8BiWK0WNsWCwTaNqtVESJR+rjbHVjbf6n1Z0h3YT4JebsHxvN1ODN5
	8HkG0+7ld58j9GONfZNYCtJz1M1fx+mux+7R5bHu8NJOAmgwg4mo1B9ht0pytBYAjcECMDVTy8r
	G3Ake5vmQlcwMDEk6Ot/Jn1lrJtV/OYyPbKIXL7zSDiuynkBn9EYvehlU09/rUW39tT4BInm/XF
	629N6K4cykC/i9UBy7QE3Pz2VuL70DqMgMP/1zc+VaKoXua/67gwcrF2TuI71OhNH2u6NiEAwsx
	EJ4/2fAzkT+YNs6+Eq/0rbev3erUlHyLR39zdDxUQ7iOtJeuhUXRFhQO7XY/a7v6pUb91ArwyI5
	8gfPUqg7dUzb88
X-Google-Smtp-Source: AGHT+IHrdjXmU7uWxKIA6T2fxuFhYbTSMB1I+H7KjcACH1uB/bPjPmFTLzfvYSiunLXewY8lMi00xQ==
X-Received: by 2002:a17:902:db11:b0:27c:3690:2c5d with SMTP id d9443c01a7336-27ed6780b92mr76951455ad.0.1758879295495;
        Fri, 26 Sep 2025 02:34:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:54 -0700 (PDT)
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
Subject: [PATCH v8 mm-new 08/12] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Fri, 26 Sep 2025 17:33:39 +0800
Message-Id: <20250926093343.1000-9-laoar.shao@gmail.com>
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


