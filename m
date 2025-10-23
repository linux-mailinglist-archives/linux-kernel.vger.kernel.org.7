Return-Path: <linux-kernel+bounces-867132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA452C019D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC319A00D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346932C957;
	Thu, 23 Oct 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvgvWu7l"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA932AAA8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228078; cv=none; b=F7L9LaFx5fMejnDOKJ/b8Te8Tf+JMHNn5ezBEZ+/PJI2fze62iLNd0mZR0zylmoI37dO/RTtSHQ3pJzgoiKTBF6js466AC6PwcYtTUmn79W22zukfqcQJzvkJlviPEDbrRh08OdByiP5Ox2tHffb2fX5s7P5QSuBAAnb4Bd43Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228078; c=relaxed/simple;
	bh=nf2ne/DcUThRcyjkcAtbjjiK8XPQU5PLVC7WSh7jfZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsmlktkvVed/rKcb9EL3dzKhRWRQU0kAfQB6fLewr7oz+l4IdI05I92sTRglZTE+YunF/X1jfRIRNJUbXn0xZpQMyoTZ7jqRFdMGNZlc35V5DQ3y5SIvLfWhdyY22DZj61LmQWdvf3dAXv+9NMU7oc9fN+4yam6ZCQ1fSc8bEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvgvWu7l; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60221fso1761566b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761228075; x=1761832875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inXfddpf6Feyogc8n8Jl5cqVWZOSr51ivnMHY9v0Ey4=;
        b=FvgvWu7lfkFsFHXEZtj4lw7glbTHzzUEGsEFkLBSyj5lOlrLDU1oghGofvy5n8eOsf
         hNVds9VXo38wQYB6NTIGzXHSQxJqYajWlPt7009pp2gIii3hh6WwEU9ZD/I4QT7d2bea
         WCWA56SQxCTKKATjTNzT+lP8oUtynF4+UfwgKPQjst0Xh/ycZHGg8SpB0lZqE/5jPJp6
         CFTvHYr2ydcrrce3Dm0itC9rIq2bP6EIsKxFqfTiJrJTlg+JsT7q3befgm83FU6T6yNe
         NI15GlfmkS+YcZs/EH0m47+UgRKGlt6IVvi766TFbKBUkqMBdAj7OK5mBSQiizp6e0mx
         bTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228075; x=1761832875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inXfddpf6Feyogc8n8Jl5cqVWZOSr51ivnMHY9v0Ey4=;
        b=wGm1ji8t0OA5Ry5F3qk+sqHlhFNB39AdGLc3yfYeJEk+2t0w054v2CkN6aqc6FT660
         Qd4i7sAi16MVCFwdJZybUh24eksXsSWlMMhys3sb98dBGMHYjgfdhTbBwAOHVIcqQLr/
         W4XMGFagn668498VARoTJeCsdYCaKS+Pn1kJmyODjuI8Bwtk64sV47l9kbHgELftfFam
         Sn8Qys8zG7g/HKUBb+pXGhd7f1wyA/SD+8ijein6q3Ge0vd/fHCntwoI2jM+sfrFVEI/
         66D5CSjPjLbfJomK7Evz5VLmkvYACimiO5DGVAFtaJjsF9rcGJHxcCEwqgjjl81XGTyn
         DO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBSJ+IWqLXyph01BqGIT+nMSqaX+bbgwLRHbOPekMt5Yj0d3GJqLiDnXxNbdzGW68GQvQu+Hs2pXy5tzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvy4mV7ZjSpH01BUj8qc6vgvSVXcg9bzIsT6ygEeKlbBlLM1Xu
	ThgvTbW8x2O4oJevebtYgEiZaICQxWk0ISDBdgXcDO+fpIfJDoEX05K6tndTU3EAFq7iAmo+x9J
	lKDwtnlpiDcZrEeyxV9dRRXP1gQ==
X-Google-Smtp-Source: AGHT+IFIN8uFRC6EtqcEGeMEkYd8inzutN6W/XJij2WhQjtYZx5ArSxhlm3XOqfP/3yjcqmWzVtyJ1fSE/ev6eLgRw==
X-Received: from pjnu4.prod.google.com ([2002:a17:90a:8904:b0:339:dc19:ae5d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3956:b0:334:91ab:f182 with SMTP id adf61e73a8af0-334a85286f8mr35842433637.10.1761228074886;
 Thu, 23 Oct 2025 07:01:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 07:01:13 -0700
In-Reply-To: <aPlpKbHGea90IebS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
Message-ID: <diqzv7k5emza.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 22, 2025, Ackerley Tng wrote:
>> Ackerley Tng <ackerleytng@google.com> writes:
>> 
>> Found another issue with KVM_CAP_MEMORY_ATTRIBUTES2.
>> 
>> KVM_CAP_MEMORY_ATTRIBUTES2 was defined to do the same thing as
>> KVM_CAP_MEMORY_ATTRIBUTES, but that's wrong since
>> KVM_CAP_MEMORY_ATTRIBUTES2 should indicate the presence of
>> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2.
>
> No?  If no attributes are supported, whether or not KVM_SET_MEMORY_ATTRIBUTES2
> exists is largely irrelevant.

That's true.

> We can even provide the same -ENOTTY errno by
> checking that _any_ attributes are supported, i.e. so that doing
> KVM_SET_MEMORY_ATTRIBUTES2 on KVM without any support whatsoever fails in the
> same way that KVM with code support but no attributes fails.
>

IIUC KVM_SET_MEMORY_ATTRIBUTES doesn't fail with -ENOTTY now when there
are no valid attributes.

Even if there's no valid attributes (as in
kvm_supported_mem_attributes() returns 0), it's possible to call
KVM_SET_MEMORY_ATTRIBUTES with .attributes set to 0, which will be a
no-op, but will return 0.

I think this is kind of correct behavior since .attributes = 0 is
actually a valid expression for "I want this range to be shared", and
for a VM that doesn't support private memory, it's a valid expression.


The other way that there are "no attributes" would be if there are no
/VM/ attributes, in which case KVM_SET_MEMORY_ATTRIBUTES, sent to as a
vm ioctl, will return -ENOTTY.

> In other words, I don't see why it can't do both.  Even if we can't massage the
> right errno, I would much rather KVM_SET_MEMORY_ATTRIBUTES2 enumerate the set of

Did you mean KVM_CAP_MEMORY_ATTRIBUTES2 in the line above?

> supported attributes than simply '1'.  E.g. we have no plans to support
> KVM_SET_MEMORY_ATTRIBUTES on guest_memfd, and so returning simply '1' creates an
> unwanted and unnecessary dependency.
>

Okay I'll switch this back to what it was.

>> @@ -1617,4 +1618,15 @@ struct kvm_pre_fault_memory {
>>  	__u64 padding[5];
>>  };
>>  
>> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES2 */
>> +#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd6, struct kvm_memory_attributes2)
>
> Please use the same literal number, 0xd2, as
>
>   #define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct kvm_memory_attributes)
>
> The "final" ioctl number that userspace sees incorporates the directionality and
> the size of the struct, i.e. KVM_SET_MEMORY_ATTRIBUTES and KVM_SET_MEMORY_ATTRIBUTES2
> are guaranteed to be distinct even if they both use 0xd2 as the "minor" number.
>

Will do.

>> +
>> +struct kvm_memory_attributes2 {
>> +	__u64 address;
>> +	__u64 size;
>> +	__u64 attributes;
>> +	__u64 flags;
>> +	__u64 reserved[4];
>
> Maybe be paranoid and reserve 12 u64s?

Will do.

