Return-Path: <linux-kernel+bounces-847453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57EBCAE07
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405664EEE73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B9328000F;
	Thu,  9 Oct 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yc2S5kdr"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF668272E41
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044084; cv=none; b=UeE0jwidnEOykj8P68a04JI0VYrlDk+vf8NvIzCx8YiVh7yQQMtvU+iyNriRHuukubXbW5lMcDRXWc6gMEjsSdBibILEKEM8hOAUvIanfGwch9UYpGTmpMdHXKpOhBPJUH+nGwuoMPOYnKhuam7i5dFGBUz9hTaPS5gNG4ec1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044084; c=relaxed/simple;
	bh=OV+I+IGp1YV8FAiM6+jyoDdlbVuoNoNGaY5rFMMy5Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bktFdh9Bm5S2NwZGjI86UWhd8ZeTXt4R0LX/7DM0baY8k7Hs0O2g0Q16j+4jL2MhMHlvoFIj6eGqgT7KbIQPXWXYiMUqJF9ujeMdmjEGIHI4FBBlrne6MZZ714/1pHfahhthgGIOG0OC2CTkYDBkDVsHmYfxZYSAbKeIvUdafys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yc2S5kdr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so2393321a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760044082; x=1760648882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8yL7yrEAZqRgLh743AzR/f5Z0OSynWI9v8HtFYQ07Y=;
        b=Yc2S5kdr4RiCLnQnxio+hQKw7tL6k47SnvL/c8WxgfAMLFSvW4ZK90Jyf3PGkhEqnd
         rBVGxkefYrCHHTYswquOrONPHJkbUIPlm8Dgw1d8mwg+HHYm37CQCUthe7JuES5yj9l1
         +abi9d2sAnjH8WuEryZCbq5EeHPOs9yPCjWtkG6l0+s5GmPcniT3tOfUyAfQZMHIu5CH
         xyEJmkfzb8aJMINGszt8gxXuqq4VBGXfqLaGUt2QPB7guchxsenwI/GVR0aGWTP/IaW0
         NuMvRfotnNamVUKW/suTOku0W01dFECJSgP3sicq1lxs0LlgmUeFbgD9VYjWZ7elvnRY
         Lntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044082; x=1760648882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8yL7yrEAZqRgLh743AzR/f5Z0OSynWI9v8HtFYQ07Y=;
        b=HMi1xovv7XtoVQYH+3bkPdm22mahFswZTvzQt6DOg5oxFLUGb4sxuhmLm2Qs4g256D
         Y8JZEpUqmS5RyBb4phE4ZbXKG4Vbfb+qz+ImHCq1evjnAkYDfW/9zx5Yu+pMWSaSr0Lj
         dfByu8mKySijzmFzZUXNYBbKw9dVR0nNsM45c0QnX/warvIhXNcTgB+EfNeyDYTGYP1H
         gus3CMXKuAPn3Dmdo9TcbPn/XEyXAccocm6yQq1nRxJwfffdY5mkyXM3af5Ekca5MBgf
         t6ipxPMQKvR/zeOkuS9LMilSuPdCqTvaySCfLRF6rkggCWw6bu2T3fR697ou/f+ScqzU
         UYHw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHx5iFQcejBj751+y7UllsdUr/PXSYWNR1y893GR4qQ1e3kjFt0Nanu/a5Gxy3RjCDWbWUO6xr+CiLJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZodDm5csipqUSLrngh0QDV1G62v8poNW52LDEsXCIHCqe/tP
	maC8nQlZp1MS/KhUUvzpUXkZLuI5975Ol+Om8zZ08NC9m/g/UzCPM/M6mk+3LO+tq3Q7Bo1ZPia
	WHOqQIqetPU3I0vi69797OeRHRQ==
X-Google-Smtp-Source: AGHT+IFa7bhAUExVtejbjYxKsPiltNShSzZ9oTvDxsSQAjUcMKhU7xutFVMSZXzLhoi6fKx2krGDUJN50iFC9VUElg==
X-Received: from pjyu10.prod.google.com ([2002:a17:90a:e00a:b0:32b:50cb:b92f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b89:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-33b513cedd3mr12577415a91.30.1760044082181;
 Thu, 09 Oct 2025 14:08:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 14:08:00 -0700
In-Reply-To: <dd948073-0839-4f75-8cec-1f3041231ed7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com> <20251007221420.344669-2-seanjc@google.com>
 <dd948073-0839-4f75-8cec-1f3041231ed7@amd.com>
Message-ID: <diqz347riy1b.fsf@google.com>
Subject: Re: [PATCH v12 01/12] KVM: guest_memfd: Rename "struct kvm_gmem" to
 "struct gmem_file"
From: Ackerley Tng <ackerleytng@google.com>
To: "Garg, Shivank" <shivankg@amd.com>, Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

"Garg, Shivank" <shivankg@amd.com> writes:

> On 10/8/2025 3:44 AM, Sean Christopherson wrote:
>> 
>> [...snip...]
>> 
>> @@ -659,18 +667,18 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>>  					pgoff_t index, kvm_pfn_t *pfn,
>>  					bool *is_prepared, int *max_order)
>>  {
>> -	struct file *gmem_file = READ_ONCE(slot->gmem.file);
>> -	struct kvm_gmem *gmem = file->private_data;
>> +	struct file *slot_file = READ_ONCE(slot->gmem.file);
>> +	struct gmem_file *f = file->private_data;
> 			^^^
>>  	struct folio *folio;
>>  
>> -	if (file != gmem_file) {
>> -		WARN_ON_ONCE(gmem_file);
>> +	if (file != slot_file) {
>> +		WARN_ON_ONCE(slot_file);
>>  		return ERR_PTR(-EFAULT);
>>  	}
>>  
>> -	gmem = file->private_data;
>> -	if (xa_load(&gmem->bindings, index) != slot) {
>> -		WARN_ON_ONCE(xa_load(&gmem->bindings, index));
>> +	f = file->private_data;
>
> This redundant initialization can be dropped.
>
> I sent a cleanup patch including this change a few weeks ago:

Agree, and probably good to opportunistically drop this line in this
patch than to combine cleanups in Shivank's other patch.

>
> https://lore.kernel.org/kvm/20250902080307.153171-2-shivankg@amd.com
>
> Could you please review it?
>
> Everything else looks good to me!
>
> Reviewed-by: Shivank Garg <shivankg@amd.com>
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

>> +	if (xa_load(&f->bindings, index) != slot) {
>> +		WARN_ON_ONCE(xa_load(&f->bindings, index));
>>  		return ERR_PTR(-EIO);
>>  	}
>>  
>
> Thanks,
> Shivank

