Return-Path: <linux-kernel+bounces-858720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29178BEB92F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 175C74FA2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5773385B1;
	Fri, 17 Oct 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaDmE1Ui"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488413446CD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731997; cv=none; b=YoQf21jtT/jnDlHSYwj0V+vzRlXpgx3UcOaz8+0anx8acXGciyfMswXPvkys49RbhiQT59wx9NrXixakdtG7LsLAfY03R2UK3vSdmOqLiYG55R2I1zgiyDcOq8ouZPcwzJggUTu82g7utHRxCtWj9Dr6UNShI5KDq1ENTTLQGvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731997; c=relaxed/simple;
	bh=EVAkBrWYKSktzVzX4VzdkAz/5vr0/zLtk66b8tSjWR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKiKe82F/NaSQV4OlRik8O4mN7tZDPwcA4+diTkWz9JGCZFTyiXyXclAbdbROOU7FeAGB/2blhr+ZQh4sRBS5t3qp6zz1FbKCcXu3OsxuYRha8eZSHc4nKq3mom0LNLVFvB+mVUbQzX21cSkYnax5LbdW2yZqHzBorMvM68SJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaDmE1Ui; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7900f597d08so2230714b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731987; x=1761336787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zq46JIno/oLWpmCm/slZY48TlgDXZ3V4yLa6+9x6pNY=;
        b=xaDmE1UiXMtux7WVhVyo8NCkfTZIJbNTvJ4GjEDaMgl6yBznVZFKB9wkmFXcjEfIWa
         xllnf9c/fYL+bX/TiLNNp7QHtZu3kKOfg4atu+WCcTr35Yu0lzRZq1IFRz/EES978JQu
         LJz7hpSKtmw5uM8OJ6WaPTa8L0b42VuAU8hXisnZ3xJvTwPZrAVmaEKeBpaslSquUYap
         hslSMP2VRr650w4JY5/YSD60B1VzJOf3rpjfhKG5FgcvJYjQuMdNQmjPeMImmV3z8SBK
         40HEn8ULqOy7zykRHs7EMlsl2HPeDhNvb9dF0DacJbOhmth7nGz1iqIaregj3MUZ4XFG
         5uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731987; x=1761336787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq46JIno/oLWpmCm/slZY48TlgDXZ3V4yLa6+9x6pNY=;
        b=sQds9+KkNW3NhB+zKlwLToRvzgI48oaSulajO028fwcAHPMtLGqURh4dFD9F9XiJoC
         /OZZ8e1FIhzxHtlkaoV4t1Jbs9/9ET1W915mSLNVDiJTWe6vhJ+Hn/gQQHhF7QCqODSe
         257NYxvxWwI1C6LugStFUyQKwt1t9cZ3M2a6Un7MXEd4Qaj+B3tidaw8nZlcFUV4umJ2
         uaBHFHBqVFyDcCkB3NGwldEu6heJbCz0UanhcIGo++GeBVLtd9rH399f9kege3Ou+Nvh
         RRoivdfJOW0uoZD80IcO4BJCBaxmBWJ7iv0MlTiEOrYT8RqZPjrIm8TqmqqRY/p0+v20
         6Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8S1lc8DC1eDLkpH3fet7ZxAmspYNjhn8NgnJ2dr1HnyuG2uBOmRgc3a1575H7sfL2BMvWvjiCtC4evVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7FXZZt1J/5iB6tz544Aatx1SbFKxtlyUkNMevzT0eiGHUc3V
	cTCI+LdQhM3+y8wMYuNcESdMqFzOTak9QiqdaBVNmOaS4JVkGZ0/SHgFWg1IJPJuqoa6qItILcr
	LINNlj0THvTxRb0F2d0wenEiSeg==
X-Google-Smtp-Source: AGHT+IEZvVijCkEAJRKnUy7ymqg6G12dNVURbl0z8Gf3KQzAlruU3kdFR92+1c9LGnwkKpRrDoTHA28pQbr5qtGv5A==
X-Received: from pjbds19.prod.google.com ([2002:a17:90b:8d3:b0:33b:51fe:1a84])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158a:b0:2ff:3752:8388 with SMTP id adf61e73a8af0-334a86108f0mr6621028637.32.1760731986801;
 Fri, 17 Oct 2025 13:13:06 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:04 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <2b96afca4f21b82fdce307d6385a6978b78b31f7.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 23/37] KVM: selftests: guest_memfd: Convert with
 allocated folios in different layouts
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 3b222009227c3..b42b1b27cb727 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -277,6 +277,36 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
 	test_convert_to_shared(t, 0, 0, 'A', 'B');
 }
 
+/*
+ * Test that when some of the folios in the conversion range are allocated,
+ * conversion requests are handled correctly in guest_memfd.  Vary the ranges
+ * allocated before conversion, using test_page, to cover various layouts of
+ * contiguous allocated and unallocated regions.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
+{
+	const int second_page_to_fault = 4;
+	int i;
+
+	/*
+	 * Fault 2 of the pages to test filemap range operations except when
+	 * test_page == second_page_to_fault.
+	 */
+	host_do_rmw(t->mem, test_page, 0, 'A');
+	if (test_page != second_page_to_fault)
+		host_do_rmw(t->mem, second_page_to_fault, 0, 'A');
+
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+	for (i = 0; i < nr_pages; ++i) {
+		char expected = (i == test_page || i == second_page_to_fault) ? 'A' : 0;
+
+		test_private(t, i, expected, 'B');
+	}
+
+	for (i = 0; i < nr_pages; ++i)
+		test_convert_to_shared(t, i, 'B', 'C', 'D');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


