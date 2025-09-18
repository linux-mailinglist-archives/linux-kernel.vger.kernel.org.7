Return-Path: <linux-kernel+bounces-823410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54BB86588
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376A6560509
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F22853F7;
	Thu, 18 Sep 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qypu9Aoy"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282127144E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218501; cv=none; b=Gfr30WRdoYw7Na3lNuny0Ykjl5d1mQdGdFpXo6MAU+oOHYEq8d+8nXQJ7JBDyfGk3XHRdNWyRLXWYngM0PDcDuE4NsLR0OmCDfEe1AbKOsIqWcUebab/e9CZMV2Co+XAOfvqpS7zGJ4GD30Q1YSGazsY9Ooiu/jiQXX2mAiO/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218501; c=relaxed/simple;
	bh=C1MZGhMDAty4en0TQUdA7UUtP4wMbfS91uN7qIdATBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sy8yUSvlAhQD59InVJdkXCfV4a6NOzb6qIfWJFDorkJuz8KeIWLj2MC1nN18KJzqs24LhYDCJK3lUYr2LABoTYCzOI9s7i4iwDpYHeVjFfYxzcBFIrYRjqNlMk9BcfR1lqbaZqNV/mCU/F0+IIQK1R+vxKZC58FwWdCb8F3fwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qypu9Aoy; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so7705415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758218498; x=1758823298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6AFtYNgzFlGUfnCDw9OHKWnsFrL+D8ATC1/qMSs/P0E=;
        b=qypu9AoyDZkcoZwo/z3qF3KfA3GMsZkoqeWRQ9AQ0v5Go3ru65squSCej7vy0GScyk
         2ZBB3c5OaaNC86wVInjQ1yWMTqTb0wAbEKTy99gJuVVP+YagxiUD2gw9YQFFmDU3gN8P
         Lac0IMlWtgFKJT27nEWP06hGLsprUXRiQYyoysex8vXxUcG5mjIk3UB3jXmQNj6Y1/Hj
         FiYXmrOQv+HmUKFUQGsF2K7Q8XpI2caHzzldc+iqq7e0yl60Txtk2kSRih8VjH9mBJ/4
         zSRdsMnu1LrZxwzPms0BdSag63Hb5MRgpjcqnuLAQMOoXBB/o+GUS5bOnaZw08Zr0aeE
         N1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218498; x=1758823298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AFtYNgzFlGUfnCDw9OHKWnsFrL+D8ATC1/qMSs/P0E=;
        b=SR+zYUsUOV4kahbcIrSHntu33k3g1JrBD5XW8DNFPNwY4Gj6sV05nZuR0HYuQ7Hcc7
         kLUMIFmvCdpLe82svwjc3Trv1R/mDtkRrYnJzSA5PBgUae3oHKV0EfIX5GFiKxR4RiDr
         GJ18+ZE87O0HsWNq4evCBke2Fkewo4G2EWKhVkrO2atTfYYawJHF9ZP0k810V7jLt7B6
         DG4rWcriJDS3s7IppN95ITbr4tlu+qBxXLXn/UoX+OcY/OjX0PAtg4gst1PZpdjN2Icr
         FhXLKDxX7q+VkqweiuhJ+MIZtgqpFCl7ZgDQuyofyvxtdVzC28FL2cUOgogzZ3OzuT7c
         Ej9g==
X-Forwarded-Encrypted: i=1; AJvYcCXa7QdtGh7UEiBJvuYM65MWJLZXQMGBhSOVBXXpkIzdHHYdHFdzwMoFRfKl0tCqmErZLdaL5ardq5FABYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVFXCmmINQXFg0AI0DsKpXytWoEoQ8SbSZSBo3EUcqRYildaf
	gqeOof59J0P6P5YVzSwDEmEhuyk+S0Y3cgWXhIqRvt9Fm587cG7+yDWKvvS88zfUsBk/b1y61hU
	DaPhebVrRqZ+6FqJ4k8WrWw==
X-Google-Smtp-Source: AGHT+IE0s3mgC68bYqXT2U/+o4HoYc6G5jDuhQVBgFNX5eIHGXZ+lKBwfO0ohqVmckXSTclutoo8kufdndZGfzQr
X-Received: from wmqd2.prod.google.com ([2002:a05:600c:34c2:b0:45f:29ca:4f27])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4451:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-467ead682c5mr1151005e9.20.1758218498702;
 Thu, 18 Sep 2025 11:01:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:00:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918180050.2000445-1-vdonnefort@google.com>
Subject: [PATCH] KVM: arm64: Validate input range for pKVM mem transitions
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, sebastianene@google.com, keirf@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

There's currently no verification for host issued ranges in most of the
pKVM memory transitions. The subsequent end boundary might therefore be
subject to overflow and could evade the later checks.

Close this loophole with an additional range_is_valid() check on a per
public function basis.

host_unshare_guest transition is already protected via
__check_host_shared_guest(), while assert_host_shared_guest() callers
are already ignoring host checks.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8957734d6183..b156fb0bad0f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -443,6 +443,11 @@ static bool range_is_memory(u64 start, u64 end)
 	return is_in_mem_range(end - 1, &r);
 }
 
+static bool range_is_valid(u64 start, u64 end)
+{
+	return start < end;
+}
+
 static inline int __host_stage2_idmap(u64 start, u64 end,
 				      enum kvm_pgtable_prot prot)
 {
@@ -776,6 +781,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	void *virt = __hyp_va(phys);
 	int ret;
 
+	if (!range_is_valid(phys, phys + size))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -804,6 +812,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 	u64 virt = (u64)__hyp_va(phys);
 	int ret;
 
+	if (!range_is_valid(phys, phys + size))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -887,6 +898,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
 	u64 size = PAGE_SIZE * nr_pages;
 	int ret;
 
+	if (!range_is_valid(phys, phys + size))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (!ret)
@@ -902,6 +916,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
 	u64 size = PAGE_SIZE * nr_pages;
 	int ret;
 
+	if (!range_is_valid(phys, phys + size))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (!ret)
@@ -949,6 +966,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 	if (ret)
 		return ret;
 
+	if (!range_is_valid(phys, phys + size))
+		return -EINVAL;
+
 	ret = check_range_allowed_memory(phys, phys + size);
 	if (ret)
 		return ret;

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
-- 
2.51.0.470.ga7dc726c21-goog


