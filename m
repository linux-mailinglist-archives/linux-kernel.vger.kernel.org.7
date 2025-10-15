Return-Path: <linux-kernel+bounces-854650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56ABBDEFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BC3485558
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315EB23D7D8;
	Wed, 15 Oct 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOnAbzrY"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A6252904
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537915; cv=none; b=R1inYiizP3o+fy0SLd7So+hhx1aXVjOf2EnteRFbncm+LuU/MNgGZRSwy5S7zF8V+ikX8D1hLgLleT4Q3kl95A31FWFnS4aju9kKuVL71WllirB8Too1GIokypbuExxTSNDsPWl+kTfru80GAXyvFR59BhKEmfwYHVLOUIpPOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537915; c=relaxed/simple;
	bh=/PMdDC4FDfpJHwrfvPwAn92Vwj5QW0m0NvTBiXm9L2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fy7GPgYIvukDPNznk+/2sfMy92LZconKfVlSStX33HzPAt8LB7pTe9GXi1neND0lIlC+JTCAmFQaG8d9AtWNFXrbGKMZ1e1tAs5kejhDpkwlmkcigcbmu1zb10Fkz9WeeQSePmPOk/SW5wf+ORdneiCrjzPm8DHWDAb2e71rXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOnAbzrY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso6435278b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537913; x=1761142713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=OOnAbzrY7BPyLQaqgLppZ+AP+1WZdU+iFY/+TUFUIS5tOawH3R4z9u2dVd4z0caTBU
         +NzrYq/sn+ct73JV5s+e51RuSDypDVAh/Gw7xMhmqM4gcPeSae7mLL7qvigeL/Jjt6PP
         o3jlcXVCHicJ9CzUjwKcX7/5ZAMnJFUqk6Rorr3uFdVvHhJEDTbNvrTbuFGnqx2Fln6A
         gmyXYI3PD+p7DtYfOltVLPwAkh2dM53kAZjSkwUM00MCKs18v9nnNdqfd7rEQ2c6hpv3
         JRio1Zo5X4A2CFprO/nS2DTzTmjKHemnmgYFwzNLcvk+Zr7e+naQFsKnD0OLmNMo9uFE
         hHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537913; x=1761142713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=ugXLojbH7lOUtccZZifnAeoTL5VII1TULQ+YxprVT2gOffNu4CnGpBKj04Qudwdtfj
         2AIayW4EvxeXUbMwr9Ygx6Lwg/5u8bIiqTFksAADdl7FleB5DFaHJfk+sARjONNwniX7
         5Am7fjXZhhf10uhf0U0QsDhqEZ5ZlDh3x87nQ3+QN8fiAP0X0li9b4URXP7ihKsL4U/K
         ptgS/iMEboCp8jykqpCaLMJOVFng6gw4xFPrMCkwhGOkMfDhd8YjACvfvND05UssGkh3
         PYNAnvxVJkzmwHETgohNtmJAhzap0HmtlqQ4mwiqVssvyt1dIBo5bjZGlbxyI65kQ2j+
         7a2g==
X-Forwarded-Encrypted: i=1; AJvYcCUak2l4Fq587xOobmlYj3dvVABSYd88fQ2/MBfrOmyDVCj8G7ivHDFR8VAuOcdAgnwrhuB6xhAlEQXq5i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHAJJQpctQMPaBoamaoc0ogjVhPiubY2np1QTNcvQb3sqK2QG
	O6/j3BNcNMn6AfVJOzmt3C2xK/FNAlKzq26zOtYnFK84hSnGkXYgHhLG
X-Gm-Gg: ASbGncugCpEYv7SvvL8zpudBve8x+gqpoVbxsQ/c38LzZKNts8wWT+0L9XthCcitW98
	wRaiUauulBRRkLv/RxjkwDXI0vJA1TTkDu7l3tpohbQsofiLjJYwkwlGrQJmpUt6MbmCIGwoszl
	aMXq9b+i4mRoXggBtqTFmbeO2+45KQ6Z4bbfzDPwSYpF2fqM2wGSYeVbtW0W9iRvrBc4pVyNwVO
	3ObUW62m19irdIB7QIp5YVIejo6X+dOPsphm4b0q9nbJJqKGXCEQ0apVHV4uTsOmVHNFXWklkz/
	lvFdEDLSYaM52/Ih1KZcV2AxrBeO7xVQpNMFYrFqHr6hdF8hiVNOU4eB5Hbg7NS6YaQjI4Ouhbg
	Xv1c+wQlABVhBeS8cBI+T2H3aPRhxsUyCHMy/+oDTHaiDJwjbzN5t4kFFb9onZ24V9I+A2aO/QV
	bmjX25Og==
X-Google-Smtp-Source: AGHT+IGMQRqzJHiHnVfuKEi8nOXVfKtRDNFlKQ6AKTG17G4aeKVlt5RMD53mTqVXNIbYrqDfmCyjHA==
X-Received: by 2002:a17:903:1b44:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2902741f6demr352102665ad.59.1760537912651;
        Wed, 15 Oct 2025 07:18:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.18.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:31 -0700 (PDT)
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
Subject: [RFC PATCH v10 mm-new 7/9] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Wed, 15 Oct 2025 22:17:14 +0800
Message-Id: <20251015141716.887-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
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


