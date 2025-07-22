Return-Path: <linux-kernel+bounces-741031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F67B0DF35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30181188E6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11742EAD1E;
	Tue, 22 Jul 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSPkwDY4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947A2EA74C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195243; cv=none; b=hzTmPOBiUr2kELKdWBPy34Z8JzsIykYFXg3WJivhM9jhBG+HAdKC+A2nOA68Tfnq0nlQqRCm0AD/MID24mko1Zd//JbMTL3c2cT/Q+Ss751kj8H/Z4LE4IidJXk/vthzv2CohwkzJNZlnZNmzTJUhdHrUVxtoWEHe8tZ3KatJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195243; c=relaxed/simple;
	bh=g6fr8aNxpMhPqjfbNdJAwT69KRiiao2VoPZhgIgVUdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hygJtFBSy1i17HD8XahIzVvGG63aS6hh1JQEppMh6DfAiNwJxQ0hw0ugO5w4pYX0pGH9IsoJ9TbOPihMcyN4fw849gM0OgkQaDxmP+En7eK+XC4afJdo7D+7Mlpalz0b2LAYxQDFV9B5x9wYnDxfWJcayUEXe0+GAdxvWpEMTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSPkwDY4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KLkgHc/8d7d4QDAstqhqEvMayi/3ZoWX1vWISlyZq0E=;
	b=VSPkwDY4lDteoB6sh54DWaUpV1QyJC6DL/cYF+bJ99PNM4QjqDBPaiY5vg6eJZk7CFhzCl
	5n4HjX60K+cjtIzxEwOq6RycNR3URO1T29oUObAMAnV3WusmcH9vqwUnBdBZXHQlqJ0lUu
	S/3z5b3DmgP0Q4bc5xi4kuaj2zTtlUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-PPEIxu5UPnivfZH0KwnIRw-1; Tue, 22 Jul 2025 10:40:37 -0400
X-MC-Unique: PPEIxu5UPnivfZH0KwnIRw-1
X-Mimecast-MFC-AGG-ID: PPEIxu5UPnivfZH0KwnIRw_1753195236
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so37539175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195236; x=1753800036;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KLkgHc/8d7d4QDAstqhqEvMayi/3ZoWX1vWISlyZq0E=;
        b=WBiVipqLpfcJ6OKyccDyY03Q/brl9UKZBR3MQ2PnL/P9yWyLkLuchJSEM0880igw1V
         kDf5/Sd/rLnmRnUeRnR2vYrd0YnGkIMnfmLvxtWrPk4XNRREvrIbzTkB3hBDGQ1fwx2k
         oXNfxYxQEORHY35TQ0ks2+O5qVvfsWMMhhZxcC5eoG2BOp8pp/wqU+QO+s8hCD2ghO13
         oNSanFP12X7niIG6iJRwiwZE8t86z1lmacoN7ywdbdn4zyTRlI6ZAl1PMXgBB+Jx7Ih6
         XXNKQAYN7beWM5lCqR3cL6SHfSaZzWh39Gei6UaOpCfI6Y1K45/B/8Bm23cHgEhWHyWh
         //CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8GjSncQNYoNbxDPOVJEUZIdf1IG/NR3dTBlHNi4dloU/6xu0K8DRzNux2Mm++dXTbqUlIan5NRq7dSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaSMdrY1JJ5YM6GNvmKzz6KmkUfJV+kB/DMUqCeyMKguHhgQz
	JCdr7KXkb/TkEGO3PU0/JGP0b2aJeizq4thyp6san8Nhl7tBM1H0WW+4j9Z26YvDk8Ub4Gu/jaE
	wpVA7QF6RJ7CtKc2KpXIye6l+p5TQdmE4BBPh4M6oIvQ4CcsIZAxI0QTQptzhEW0wmA==
X-Gm-Gg: ASbGncuZyT5jsGNtfEVKNgciypt4xF7PVePtiI2Mej6ZJ1ZO0jj5cBAjOzLOdlCGSFf
	yQCam2B/ZF1Y5yfxe99xGDEpVsXnCtEP+j0L/HdU5eL19p/8Yuu2owjuUczqzwCenC8NFogo6UM
	hFOP1P7PAF08H/XrvJCC7HnbY8F2HcqlnTvM6SoSN+jh/Zre4ZwIoArd35S2pGbUF67/jWD4ZT7
	QWPzvDyrkOtSBZql+LuWQSOB5sGpUSPXy9aNjG1xlkU7c2kQG6PSgsLjG9M5E5omz8oA3nz6l4m
	CgzXy3eZKwvw7isXdJacJf6IMfHDvzLIUjuf2vjNlj56PVzu+KphzhHQ0PYoxLGv0QLxxcAxuj+
	aezfgiDhQzGVV5LqyYZDQiHn1J8uQeikYkEXzKLP6pO41pjC4ps2ttiWzvRElBYRzunw=
X-Received: by 2002:a05:600c:3596:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4562e031df5mr212332675e9.5.1753195235944;
        Tue, 22 Jul 2025 07:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECMtNli8iBCH8Jdtpg8WMwaAxwFDlddcCQOBvhQ52M/6+c870zweXxX/J/td5+Uj+75e/P8Q==
X-Received: by 2002:a05:600c:3596:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4562e031df5mr212331795e9.5.1753195235265;
        Tue, 22 Jul 2025 07:40:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b73fa43sm131117765e9.21.2025.07.22.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:40:34 -0700 (PDT)
Message-ID: <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
Date: Tue, 22 Jul 2025 16:40:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250713174339.13981-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.25 19:43, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work that
> enabled host-mapping for guest_memfd memory [1].
> 
> == Background ==
> KVM's guest-memfd memory backend currently lacks support for NUMA policy
> enforcement, causing guest memory allocations to be distributed across host
> nodes  according to kernel's default behavior, irrespective of any policy
> specified by the VMM. This limitation arises because conventional userspace
> NUMA control mechanisms like mbind(2) don't work since the memory isn't
> directly mapped to userspace when allocations occur.
> Fuad's work [1] provides the necessary mmap capability, and this series
> leverages it to enable mbind(2).
> 
> == Implementation ==
> 
> This series implements proper NUMA policy support for guest-memfd by:
> 
> 1. Adding mempolicy-aware allocation APIs to the filemap layer.
> 2. Introducing custom inodes (via a dedicated slab-allocated inode cache,
>     kvm_gmem_inode_info) to store NUMA policy and metadata for guest memory.
> 3. Implementing get/set_policy vm_ops in guest_memfd to support NUMA
>     policy.
> 
> With these changes, VMMs can now control guest memory placement by mapping
> guest_memfd file descriptor and using mbind(2) to specify:
> - Policy modes: default, bind, interleave, or preferred
> - Host NUMA nodes: List of target nodes for memory allocation
> 
> These Policies affect only future allocations and do not migrate existing
> memory. This matches mbind(2)'s default behavior which affects only new
> allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL flags (Not
> supported for guest_memfd as it is unmovable by design).
> 
> == Upstream Plan ==
> Phased approach as per David's guest_memfd extension overview [2] and
> community calls [3]:
> 
> Phase 1 (this series):
> 1. Focuses on shared guest_memfd support (non-CoCo VMs).
> 2. Builds on Fuad's host-mapping work.

Just to clarify: this is based on Fuad's stage 1 and should probably still be
tagged "RFC" until stage-1 is finally upstream.

(I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
still feasible looking at the never-ending review)

I'm surprised to see that

commit cbe4134ea4bc493239786220bd69cb8a13493190
Author: Shivank Garg <shivankg@amd.com>
Date:   Fri Jun 20 07:03:30 2025 +0000

     fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
     
was merged with the kvm export

	EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");

I thought I commented that this is something to done separately and not really
"fix" material.

Anyhow, good for this series, no need to touch that.

-- 
Cheers,

David / dhildenb


