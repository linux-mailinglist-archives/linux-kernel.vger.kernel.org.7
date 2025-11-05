Return-Path: <linux-kernel+bounces-887369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B4C3800F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85144F9CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2F2DC339;
	Wed,  5 Nov 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLeCLTmr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6dTpDK0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403D190664
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377835; cv=none; b=Hb9F8P9+EFWOfwceq4hcSpxNG7zdCqFL4IYr7oGByavAiuLDIpe/Jh7ENmwn0kyP2XZ+P2VHnBDpp3B0xNN9wxvOUL1XzmDCn/Z914c7GgeXVt0V245+lkFDRv5XulWpFcK7M6K3xuTjZrfIhwrOUqPqS/CYOGPSAm++KX1rZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377835; c=relaxed/simple;
	bh=P2iTuuOyEwfG6AekrsfEcB5piZZBsfOQWBVDFyi8wfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZuxtZZDlyOxqe0lUZvUbvIqCDMmDn0KW65aXfaL6onhDrKkTj3U+lxpmnf9pjxoeF2mOs7SHTs7fdNW+Xe0nbZMlwccB92vPnHd85/1AzGNk1kztkCZLriXuNx/FXbNcA5Yra/O581VxD9y4VIwfnhxQd/YUkrilUJbo0XzQTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLeCLTmr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6dTpDK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762377832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irxlM+zajycQvptkFG0Ecggkg0FzwDEC2rGbASu0wKw=;
	b=FLeCLTmrDODnIxI/14BiqHSrlAnkCMTiDV7teqw6o2WdNBbIBJNcz/YYZb9ZnD/ULgjILT
	qNwVguTSFnv0zgFwrgn546wjS+ym0ne6Xv3FTkaEqVDFMiXVRVZbGwpZg9PPFxnlOgMNKE
	f0VMYkDSENYTJnWs/X71vCDMaiUGtEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-jDqcnVsiO1S6_3bSOunXBg-1; Wed, 05 Nov 2025 16:23:51 -0500
X-MC-Unique: jDqcnVsiO1S6_3bSOunXBg-1
X-Mimecast-MFC-AGG-ID: jDqcnVsiO1S6_3bSOunXBg_1762377830
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c17b29f3so225372f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762377830; x=1762982630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irxlM+zajycQvptkFG0Ecggkg0FzwDEC2rGbASu0wKw=;
        b=a6dTpDK0cJcfLR0DtN0g6KZOSPBC3R72JStX5mk+n8bWsCgyBgzAfSj7irNgdwCIdH
         kXDXOmoQvZU80nJBpZl1ehmwRdqUlvxSfudw+ZfP1ZveJqGSNqkyVO1wxkv4euDgipTt
         WUnrbewE/5dujFzV3hizh0Qcq2oTXpc2BnVzjHthXOTkEY6oNzIBv6VI2Y5nfjy0Gkp5
         D/hBpgkh0zkWZ4MjrkRfZcvEAlGMarCam1Wg6DGJJezZToxtJJSESiCAFXVxb0PsGGXC
         omu+YCYhpu/WZ7sZN8GPowgoiAiyXyMcJEBxH0K71ZWsPjkQzWzR8QGuIudBmT3ho8K8
         GxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377830; x=1762982630;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irxlM+zajycQvptkFG0Ecggkg0FzwDEC2rGbASu0wKw=;
        b=wbLdJEZKQzAjHifXf6DCAmq0SuMvVYjPuee3m8p+nuFnXCMWczIUpV8AxTP/gMfPDK
         fieDdrRDlRPhunyPDFN9dQchnTkhs0nxU2EwOGO7BjiLsDvY1KzYlxSbaKYASf4NbgwS
         eUG/P7Z5qHLKpfVETPkmkEVCrQEb3I0HQGitQhTMDBKv5HYbnvLHKAyvT24pN0V5KuTK
         tt9D0Ge4FexoI6EKcc0Vyth3DxheQTHE24jLxEC4CBh/gQ30sTYh8eQPhi68GUnHwSxx
         h9GBCBWxq8Nnr6NxOjctfTVDVeU2M7aMaEEKvc5hxH3C/eVEOblnVwegxyhuzyt/6jIG
         YMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA6RLQRgv1LAdrCSv6jvtik3DDI/8+rM3b1SQSC7tYxmowBKdHcB0cGPWiYXRG/MhJJRyySOn9Ap4wYvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbZGuaqntzEveg3eCbbV9+EKXMnpZtRSqLJHL6P+kb/1ofXf6
	os9ZA1KQz0kYnOAXJ+BcAnvkCtmb94n1J68ZiICixUtrrFOD4os/hFrmNQpt9ndikPszPiOxPBp
	SAUFO3Ba4tJjcN6qvKyamprOQ3IOb/3Z4/M6V2S2XrOGO2JHskQRIj+dB+brZFeDxmg==
X-Gm-Gg: ASbGncvpsGI7k5d6XT6eOI/GC4sqDeAyqvLbofi2CCM9/FMEwxEyVLpjn+oFY/74/8l
	nN5rdg1WY1gzbxVZV5mLDxY7vGPyVIqsT2z2J1xvCrof9oJnvbtxz+3XkNB2ELVt9ZVccDPedDD
	kUZgsPAzNVZ0Ggsdj5UWxR4eVW5qmq5bJDvI4fyvjSvKIToXzxpjsQ2dHuWs0NOH/Dzbsmo6klN
	ERDxzhTOC/KtLAPyR7lNElwyKsNHQQ2lGDjnj+15io2swswAAQNZhjIMkTWl362R+xjjYMZhQ2o
	3geZwYHkOkzKa/UgWv/b5D3WLq1q3i1rkqgOZRXzmmWYaxFOC0AjmLxMqr86MEKW0AGTLHII2B4
	8xIIHohedABI+8KuHw6EwufiQtyngKKcH3d8Awl24wrbyJiunh3uhz+AM2LdDyk4EbKj2O4xjLU
	nV8qRYrmag/pK5Z4ajh3/Nyrs=
X-Received: by 2002:a5d:5f45:0:b0:429:cbdc:86e with SMTP id ffacd0b85a97d-429e32e92f2mr4264267f8f.18.1762377829724;
        Wed, 05 Nov 2025 13:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFMBPGjUyAWRqYLdaePyzci1tJGP5cGEiWVS3z0azdKYFVcbbYYUKG6ZsLRBWt15fQxm1NIg==
X-Received: by 2002:a5d:5f45:0:b0:429:cbdc:86e with SMTP id ffacd0b85a97d-429e32e92f2mr4264238f8f.18.1762377829254;
        Wed, 05 Nov 2025 13:23:49 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm860677f8f.31.2025.11.05.13.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 13:23:48 -0800 (PST)
Message-ID: <78de3d64-ecbf-4a3d-9610-791c6241497b@redhat.com>
Date: Wed, 5 Nov 2025 22:23:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Peter Xu
 <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Nikita Kalyazin <kalyazin@amazon.com>, Vlastimil Babka <vbabka@suse.cz>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com> <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.25 18:13, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251021 12:28]:
> 
> ...
> 
>> Can you send some patches and show us the code, help everyone to support
>> guest-memfd minor fault, please?
> 
> Patches are here:
> 

Hi Liam,

thanks for showing us what userfaultfd could look like when refactored 
according to your idea. I think most of the userfaultfd core code is 
easier to get in your tree.

> https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> 
> This is actually modularized memory types.  That means there is no
> hugetlb.h or shmem.h included in mm/userfaultfd.c code.

Yeah, I think there is this confusion of "modulize memory types" and 
"support minor fault in guest_memfd".

So I see what you did here as trying to see how far we could go to 
remove any traces of shmem/hugetlb from userfaultd core.

So I'll comment based on that and rather see it as a bigger, more 
extreme rework.

> 
> uffd_flag_t has been removed.  This was turning into a middleware and
> it is not necessary.  Neither is supported_ioctls.

I assume you mean the entries that were proposed in Peters series, not 
something that is upstream.

> 
> hugetlb now uses the same functions as every other memory type,
> including anon memory.
> 
> Any memory type can change functionality without adding instructions or
> flags or anything to some other code.
> 
> This code passes uffd-unit-test and uffd-wp-mremap (skipped the swap
> tests).
> 
> guest-memfd can implement whatever it needs to (or use others
> implementations), like shmem_uffd_ops here:

There is obviously some downside to be had with this approach (some of 
which Mike raised), regarding the interface to "memory types" 
implementing this, but I'll discuss that later.

> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
>          .copy                   =       shmem_mfill_atomic_pte_copy,
>          .zeropage               =       shmem_mfill_atomic_pte_zeropage,
>          .cont                   =       shmem_mfill_atomic_pte_continue,
>          .poison                 =       mfill_atomic_pte_poison,
>          .writeprotect           =       uffd_writeprotect,
>          .is_dst_valid           =       shmem_is_dst_valid,
>          .increment              =       mfill_size,

See below, I wonder if that could be performed by the callbacks invoked 
as part of the prior calls to mfill_loop() etc.

>          .failed_do_unlock       =       uffd_failed_do_unlock,

That one is a bit unfortunate (read: ugly :) ).

failed_do_unlock() is only called from mfill_copy_loop(). Where we 
perform a prior info.uffd_ops->copy.


After calling err = info->op(info);

Couldn't that callback just deal with the -ENOENT case?

So in case of increment/failed_do_unlock, maybe we could find a way to 
just let the ->copy etc communicate/perform that directly.

>          .page_shift             =       uffd_page_shift,

Fortunately, this is not required. The only user in move_present_ptes() 
moves *real* PTEs, and nothing else (no hugetlb PTEs that are PMDs etc. 
in disguise).

>          .complete_register      =       uffd_complete_register,
> };
> 

So, the design is to callback into the memory-type handler, which will 
then use exported uffd functionality to get the job done.

This nicely abstracts hugetlb handling, but could mean that any code 
implementing this interface has to built up on exported uffd 
functionality (not judging, just saying).

As we're using the callbacks as an indication whether features are 
supported, we cannot easily leave them unset to fallback to the default 
handling.

Of course, we could use some placeholder, magic UFFD_DEFAULT_HANDLER 
keyword to just use the uffd_* stuff without exporting them.

So NULL would mean "not supported" and "UFFD_DEFAULT_HANDLER" would mean 
"no special handling needed".

Not sure how often that would be the case, though. For shmem it would 
probably only be the poison callback, for others, I am not sure.

> Where guest-memfd needs to write the one function:
> guest_memfd_pte_continue(), from what I understand.

It would be interesting to see how that one would look like.

I'd assume fairly similar to shmem_mfill_atomic_pte_continue()?

Interesting question would be, how to avoid the code duplication there.

(as a side note, I wonder if we would want to call most of these uffd 
helper uffd_*)


I'll have to think about some of this some more. In particular, 
alternatives to at least get all the shmem logic cleanly out of there 
and maybe only have a handful callback into hugetlb.

IOW, not completely make everything fit the "odd case" and rather focus 
on the "normal cases" when designing this vm_ops interface here.

Not sure if that makes sense, just wanted to raise it.

-- 
Cheers

David


