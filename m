Return-Path: <linux-kernel+bounces-856633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FABE4A80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FCC3B3FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0C19F43A;
	Thu, 16 Oct 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQvYUgH7"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B332D0EF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633154; cv=none; b=dAVn3SfsXoLWFSFRn2T7rIQoKvUguRZE41BzvcXfMXvn0KQB1ux9usFDO5tRRjseBGRr0w0nnoTC1ZShrex4Z1A2mE/40+5tShGIADRuXdWIeWI45QN//xjwmxI0RpWwBT/L+uXBH5T9/gP+o9pCTT4+Iu3uIRcApd0ZMqOvkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633154; c=relaxed/simple;
	bh=Hm2zb7BbK6u0+sAv3frPUeGtmPDc9kHP8wj1uipzTww=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ua4T7nGfjTQKRZWj7b1kiGTzxkuwfU7KbggAXzTNJ+Mblj93bWOzIidGKwMiEhsbndft8WNr195ZJCm1gLC64YM34KqCu15L9sFLMyySd1ky9UxIR9gtysY/0XfQJmoV6VnixWsoHy4BR//ivae3fA5aBEzsZfhBuvU6TaXaSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQvYUgH7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-470fd49f185so9812775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760633151; x=1761237951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9SbmhQZwiusbuPbqM8RzBz4UGbORFM0qZTqA8aOS0k=;
        b=uQvYUgH7E+vdNTTpwHFpPa06RqlmmZajm1SMU19RNijC/yr15Ui+p8S1a+A8UMXd2m
         AO1galD3010ljyzKbPwipay4JC+bkTnS0xlnEHFkfzZqZlfZcW23ndb7jAWVzt4G1PAQ
         bDcUuDn8cNNgSWar1mruYxyaKtBwReMFT86w6J5pmboRLz+tENqhp21Oh7vcsY1f31eH
         Y4jyVmBDv9jhthc625pJ9M7//JmJEmCPBStHl7NyH5RUgiaZGmR5NIf9C5rj5C++RQjb
         Xdi8hxnGcalmEznJbOq51zM0jDIspk6uzQL/96IMfdMh+IH+oJUFnctP+9tjZVEF65hx
         JkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633151; x=1761237951;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9SbmhQZwiusbuPbqM8RzBz4UGbORFM0qZTqA8aOS0k=;
        b=mY5RYA8+TdUOb+aCemXpGIniIoyzs4hP5cKNsnjHI49Fwa+YnF/HpWpzbfgCl03XkI
         VxtfH4697wvENQqC9w7K1AxQOLGbW3UQ2s3oqr091rJExX1/+AXeGuQJnOyDCAXUX98Y
         CMmfjacMSM7x5K0p1HWpdS6nLyYT7vTiArJI9U0YrAoPIohU/DQEdztG+YtnAHJaCLY2
         ODSSh8rKmjF89hki3JPBmB0bDR6tjTtRsUTVU21iSWVVrvxbiWW1loGjCJFEoCx1exDu
         dmfnzDzmakPDv27bcm6Z7DCHRdcWGd/TEyjznIT5n/YfduQ2uiS8RLKRtYGGhm8mMJxC
         bkfw==
X-Forwarded-Encrypted: i=1; AJvYcCVAE3woFJHZYfqBzALvLyPGWnRtTyZEc5/ek41MyxBV1nEHSBUgYCkkxoyZqa7RL3zJYBk/YxWi3ESe4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31Kf9Zya5TNG8CUdkoadLLKxd7lfen0tanNtKuggn6WBp8Mnb
	z+gfJqDjBeawU5exslxT3fBT7LVzTFpxxjh7rdNghQ+0uOwE5SB9k7yLkOhBmZTWlFHeCv+gSSq
	HEK7Gmv8t+7+1/HtcxlQyCg==
X-Google-Smtp-Source: AGHT+IHO7bMt3ey0cBeCObbuEwgWLkRaJtIUMULZrT5bRJWCOB4Klpu3BVpGfBvD91ceBxusLc/jdHvwsQsn2up0
X-Received: from wmbh9.prod.google.com ([2002:a05:600c:a109:b0:46e:2121:d406])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b03:b0:471:6f4:602a with SMTP id 5b1f17b1804b1-471179068f6mr5540055e9.23.1760633151113;
 Thu, 16 Oct 2025 09:45:51 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251016164541.3771235-1-vdonnefort@google.com>
Subject: [PATCH v3] KVM: arm64: Check range args for pKVM mem transitions
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
pKVM memory transitions. The end boundary might therefore be subject to
overflow and later checks could be evaded.

Close this loophole with an additional pfn_range_is_valid() check on a
per public function basis. Once this check has passed, it is safe to
convert pfn and nr_pages into a phys_addr_t and a size.

host_unshare_guest transition is already protected via
__check_host_shared_guest(), while assert_host_shared_guest() callers
are already ignoring host checks.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

v2 -> v3: 
   * Test range against PA-range and make the func phys specific.

v1 -> v2:
   * Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
   * Rename to check_range_args().

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ddc8beb55eee..49db32f3ddf7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -367,6 +367,19 @@ static int host_stage2_unmap_dev_all(void)
 	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
 }
 
+/*
+ * Ensure the PFN range is contained within PA-range.
+ *
+ * This check is also robust to overflows and is therefore a requirement before
+ * using a pfn/nr_pages pair from an untrusted source.
+ */
+static bool pfn_range_is_valid(u64 pfn, u64 nr_pages)
+{
+	u64 limit = BIT(kvm_phys_shift(&host_mmu.arch.mmu) - PAGE_SHIFT);
+
+	return pfn < limit && ((limit - pfn) >= nr_pages);
+}
+
 struct kvm_mem_range {
 	u64 start;
 	u64 end;
@@ -776,6 +789,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	void *virt = __hyp_va(phys);
 	int ret;
 
+	if (!pfn_range_is_valid(pfn, nr_pages))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -804,6 +820,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 	u64 virt = (u64)__hyp_va(phys);
 	int ret;
 
+	if (!pfn_range_is_valid(pfn, nr_pages))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -887,6 +906,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
 	u64 size = PAGE_SIZE * nr_pages;
 	int ret;
 
+	if (!pfn_range_is_valid(pfn, nr_pages))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (!ret)
@@ -902,6 +924,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
 	u64 size = PAGE_SIZE * nr_pages;
 	int ret;
 
+	if (!pfn_range_is_valid(pfn, nr_pages))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (!ret)
@@ -945,6 +970,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 	if (prot & ~KVM_PGTABLE_PROT_RWX)
 		return -EINVAL;
 
+	if (!pfn_range_is_valid(pfn, nr_pages))
+		return -EINVAL;
+
 	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
 	if (ret)
 		return ret;

base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
-- 
2.51.0.869.ge66316f041-goog


