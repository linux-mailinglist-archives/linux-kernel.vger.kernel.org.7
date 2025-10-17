Return-Path: <linux-kernel+bounces-858732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C9BEB9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CDD1AE326C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE0336EE2;
	Fri, 17 Oct 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL8IzmC5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C22338597
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732014; cv=none; b=MGHOOrRlkrCsyy4m+4FQcBMsiM38E6kSrj/ejGqsCjbHttX9vZH30rKHVKtqaja49SzV1AXFfJMDhKSPycaInX9xVauj4RLqg8oTg6KP6Fsk1DYTtMI1HFtE/OuowabH7zWmty965bOisbg2/6qZ8YxtPGEDVlckqqTjgej83JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732014; c=relaxed/simple;
	bh=30zQD4pjDiSn/+U/aldACY0mrFS2JuKzSnFZG7FjNQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1J/MEq1R54pPwVLFwzMegoYG26kARLQS4XpQi8kOfoQA5KVWxeFtoEKnmVSB53DPl073wfNx/nJoTIEpx1IsOOSzKuM2MUICicwLXrcrGhP7S1zQlwze5Pom5FjSCv/wwfXjqtnN+Mn5Htx77mTn+6jWn/1zjs0foqxAAHFSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL8IzmC5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so2009304a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732002; x=1761336802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=EL8IzmC5z4DTQUYvZCy3jKls8uL6JbJj8vXJCerWWlefkvzKo3EiyPvHEWDXtbvLeL
         ps9wFnbKHg7T67l5dHLlFW+c96db/77a4px1hqLuvOTAGCLCMF8wgXXDGuJchJenCGh+
         eoFgD/SbJ1HhQmEd0UNEeikNEsdmbbyf0KPuzEI2sY5TVYzGE/K1BvRBFrpKSEgBoYZj
         F2hWTGsF78bsFJKdW1WMwg10IwDuK4PBZUoDI3LE3f/njKyvBqMo1C++ioBKM4yvlVhp
         miBHevQlyRYoSLjSp9HMrP6kEZ6gNAzVvLtaUY+3Lvq4AkQHA78RNk/jkDyzgVPcdz8X
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732002; x=1761336802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=J2ncGdKVehZiRNAraczcZUeZcoRoSbATKg3QePBkD7ySZobh2pqDINF3iRF1qY8hsM
         8gGZCytytGsmEJ5Sb2aUnG1K6bzZP93wnotHOO32TcAnPL748OsxfE0Mz0n9c+lnLlUU
         gWXwSzFqGbBhVLgDZCpC9L4BpBMDTMw0Ws3jY98Fc6czOKBMxI1KPMyR4WV7s/gQMyP5
         ss3/fbrsJNxb9cT5NiHC+ywrzDK0Vd26Hx5oVr3208KIAI3fA2QN2sWxUcwFLdPndDHM
         mu7bdzuQ4KT0U3sAwFMVHsBm0zsTBHhVNMW1J71j4p0vqN9lDGbE4LLaS5S2OUK7vxpk
         iqCg==
X-Forwarded-Encrypted: i=1; AJvYcCXqPbn6TXs6mlzDGIjHBmBGUlWlH4IDYlfzNXIpA9/KpY1q7UQtFJYQe0l8VHwHToVA8ATMse2bICaHxwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRhWwCvA0slfGE7fNly+2pWb0kRyxUvJKvxxzw76/PW+xB3cn
	eSqM0MxeI0WSVbazaRwFLbK8brT1SFVrSCdlgjylHnrVhGyWhCm4rqD7yGoBlTY93yzt/Xf7jy5
	9IUz3FhC2TdIOtmKoPo457inpNg==
X-Google-Smtp-Source: AGHT+IHcO4NwxOJfZLNEBbx6WNz/S52BTLMchZETWWpFSftU3iw+fmFyD6t6Of9AgSIAzGHhdhWoKd+61TBtvxNmOQ==
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33bcf853679mr6444234a91.6.1760732001959;
 Fri, 17 Oct 2025 13:13:21 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:13 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <a3126618d7cb353faad7b231e70c2b732498f449.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 32/37] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
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

From: Sean Christopherson <seanjc@google.com>

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cb73566fdf153..8603bd5c705ed 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1057,6 +1057,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	mmap_offset = flags & KVM_MEM_GUEST_MEMFD ? gmem_offset : 0;
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
-- 
2.51.0.858.gf9c4a03a3a-goog


