Return-Path: <linux-kernel+bounces-698491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E5AE4590
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BF17B769
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2971255E53;
	Mon, 23 Jun 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCVi3yMB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F94253953
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686696; cv=none; b=VqkiiEzFnboiGOMst5ITzDSPzINOlJzpgg04qBokHgvXhu6TTcVlyovg5SO6Yttzub2PmzjUwZ2vS/eKByEduhgw6ZZO2iN1JLYR/yj5pvNuwfSZwuZCXAQ6Rwo1Fbk0mgwHB9qC+EqX5aR2fcht+gnjq4/s0fHimygWoO2JxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686696; c=relaxed/simple;
	bh=HJmFXLX/j3dETufjqwrf6ToA6QYlCLIoKTQ0NUDZnU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seVtbtwFO1aMNMu/Wcj6p204Te+1NZnSJpeT7OBy4ZV8/vKTH/amdT+0mBVZEFJ+eUuFZbPG+WiMy+KBeCI4D6CHHP60H6xoOd+FvLcGuWApfpTyeQ6T3dpWz85oHsvkO2kLqLEU5VXwzZC3piirzQEIgIVCBT8PN8SPJusx99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCVi3yMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aTMs4wV4SuVKhFSHjMzqgPgB1cu77va3GYx+Y9ijEiM=;
	b=YCVi3yMBtV1eitR2jmTdmMxizul893Zq0QV5b3OIXrDuDtMBARDTYTGkupU1FdSq3kUxQz
	eJ9T68/CercMZW30wIlXO1LAlJHEWtBI/FrUL8UqDI1wV7l0wKpP68tErmFf/r0rGZhBno
	35mbhYt2Zho68OfSaWF94lGPUPvzR0Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-aw2EFkReNEyd7SOkWfvqhg-1; Mon, 23 Jun 2025 09:51:32 -0400
X-MC-Unique: aw2EFkReNEyd7SOkWfvqhg-1
X-Mimecast-MFC-AGG-ID: aw2EFkReNEyd7SOkWfvqhg_1750686691
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532514dee8so32390025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686691; x=1751291491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTMs4wV4SuVKhFSHjMzqgPgB1cu77va3GYx+Y9ijEiM=;
        b=ng0M0oPqHApQqz1bd0ArNLSw4GzLXesa8qCyYa/Ilqs293ityzOTLZfvFXeVEkqBJk
         NYacDCGOiy+yDkaea2GR+ZeKyul3Xg+/cEyDbiULMNWrDrBeHVWuzlt/hn9BzKRXvsX2
         GKxueFYOChBy/BXavAI/OXCT4fAIwUckLRKYlbyygW1xi0pmchQZ0sMKBwLjelticWd3
         L/WtX4B9ELmhlnIcREeGMnhWsFdZVYhfZc2IkxSyLvXwiFXtL09zpYD9JYv9aHEyFNh1
         nr6nKOmGDCZihK0Vgx8GMJREsGo2jE4O9s888oo8IkZWx8m5VFnmgu1Ypn+4jaJGjR/5
         43Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVpdh+BYtxvO59KsRnCBH6kdShEKHRUy2v6j8xLl757+7iBrhaRrQqFohC1HxzGPitTPKBlZq5uODTJOOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZP5ajrtk8GcSLBHl8CeLV/ccRk078K+TEgklNzOvVkWB3sTs6
	VWliBekY3jFkqrCfgZF8nOGO9dsUCp21LFtsxMl0G2hgiaJx1/0/6uDnV7lIvrOeY4/TyYt1g6f
	/k2L4b/cQM983NZtqPI89XQ4IQWn8tL9YIfxTDXN8N4kJdkuTwnu93pidxfzAfgcQ4A==
X-Gm-Gg: ASbGncvYhpJFLdcjl/5Map0uDEZpjhUn5izatCCbeRicvFwvimCD9zC1JWCrUzDaJp8
	Yiwb0PLqcQtsX4k3aOvghY4ph8IIVoqnqDgN2KuwEJifrp2XNa5bu8uUN2XDYwBQOJez7SaiiVR
	ix2hcKnnUgyUt38FZrNT7UtxlxuQIP7I8ROIEBsLZNje0tBd0CEt4NMLg4fhqeEbu9NWT4rw4Mp
	Zzk6MVvt68LVqjAjfGZmf1Z1HeTNvsgDrMspPan2QhAagYo4DFkw2UDqqx90gUmrdL6y7xvRRPa
	M4fswzm8GRZbr014KHJEdu86L6e3DI8gOwHU0SG9EufuQ3JygqJPNv7XC6vyLJ3mvcFW0LjG6f0
	FXzhJ3qm0WpvVg2DGa0csEaYdGqiN34JI4xk1Usll1o/DhY7X0A==
X-Received: by 2002:a05:600c:3b1e:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-453659c0c47mr137895915e9.30.1750686690826;
        Mon, 23 Jun 2025 06:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3wPA2NDZGNU+tezB/9zWFnuVdchez0lrMy4aiZ6nmbAqIOhTpniZoMot4ic342DXsB/1krw==
X-Received: by 2002:a05:600c:3b1e:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-453659c0c47mr137895525e9.30.1750686690404;
        Mon, 23 Jun 2025 06:51:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eada7adsm147297065e9.35.2025.06.23.06.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:51:29 -0700 (PDT)
Message-ID: <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
Date: Mon, 23 Jun 2025 15:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 brauner@kernel.org, paul@paul-moore.com, rppt@kernel.org,
 viro@zeniv.linux.org.uk
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250620070328.803704-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 09:03, Shivank Garg wrote:
> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> anonymous inodes with proper security context. This replaces the current
> pattern of calling alloc_anon_inode() followed by
> inode_init_security_anon() for creating security context manually.
> 
> This change also fixes a security regression in secretmem where the
> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be bypassed for secretmem file descriptors.
> 
> As guest_memfd currently resides in the KVM module, we need to export this
> symbol for use outside the core kernel. In the future, guest_memfd might be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>


In general, LGTM, but I think the actual fix should be separated from 
exporting it for guest_memfd purposes?

Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does 
not exist yet ...

Leaving deciding about that to fs people.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


