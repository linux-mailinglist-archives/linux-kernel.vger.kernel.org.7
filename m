Return-Path: <linux-kernel+bounces-730255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8382B041EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB861740AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBB125A65A;
	Mon, 14 Jul 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7SeytB4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4C2571BE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503858; cv=none; b=TtJJU445o1TvqzWPxeOoyVpwfueDuSlmYrkRG4m4CcMS2+F2We2r/1Z2cHbtw5Xy+u/JsWmwmt1G25z3eS/EkZF9VHEUJ1/PEpYLyNdgV2SYSMtFgGiTJmNqVzd3a9KzpHhdVaNIJo/qtkti2avP+cCBCat4OnEoiPj7kX/wvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503858; c=relaxed/simple;
	bh=RjGx9P5kC6mARBJP6775NozU85TUMgTGi0IZUOQB1j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhZ3mPvEVz0Kpt1BiU9SaHSJVgjj5JMy+k4G/q4YJJXVp3dARTyZVYeJKmd277LDP0cZ8m4ydFMqF4KA3nabgeMS8Qq+7KYuiGrMrfkCjdUan91+2R4+OBl2owdfJaukRwbYB0gn47wkKA8RRZ2vzFzenvGVRj2r2m5kAc6Sqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7SeytB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g+pcFOcxgDZoR5yPrN9tuAezacA6xxzq/+I6doDGUU=;
	b=C7SeytB489MR4vF+Dwf2LWWThSYqBB94uG/S4l3eGznlp41r7Zff1u4EjdVgtBT6mSaMpD
	yQA3I45fOJIGRgYTEIl14qS6fef0xmh/0p0mYGseb5NVrPmPRPLQe/JDDuTiS1uI9WH+EB
	k+ZBhbjZcN3GB8onijT7YK6XMRoP/gE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-DI4PuR94PemDBKMZPYT_XQ-1; Mon, 14 Jul 2025 10:37:33 -0400
X-MC-Unique: DI4PuR94PemDBKMZPYT_XQ-1
X-Mimecast-MFC-AGG-ID: DI4PuR94PemDBKMZPYT_XQ_1752503853
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so27125225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503853; x=1753108653;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5g+pcFOcxgDZoR5yPrN9tuAezacA6xxzq/+I6doDGUU=;
        b=r/yJj/llh2B0ssHq069etPtsb+3JHCx2XEFvC3Fq+9nNIy5qx4kq7LcLcuUYUolAa9
         +NtSCq6S2f60QvJFCISj381NvhsVHa/NxM5RTR2jb0Om44uVPIoeUrSgo+nIQhgd44h5
         ICkeX6pemuG7h3XwJZK81uA+RF9PujDsfUxxwg4FuMVCUa7B/woMu/UcydavA46ZRFry
         Uhqki17P1844aRsUlfW/qQ/2u9QS8jsFP9GG6zv5Dsk2LL6TyC3m8yT0mKqwlbWZOz6S
         Vd1P45pT8VC/DL6dlNSOE/+eXCWBbjJlHbXuBYiIHjMYqGpqFLbghnPimLmREsLGKppb
         yI5g==
X-Forwarded-Encrypted: i=1; AJvYcCVipGtwcEMNgC9CprJouZ8SCFHp0j7WejBGJEV9WZ9H+fIwxgRFbsBFQEOAUiq92ieTOygFBSPO+CVvmsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1lQPXwVuECrdktXovET/Q/XMSSEmd2LMUSO1f07KKz6MUHtt
	jm81LVTN+6ZMRRewnji5PoAVVGcFzEVBzqY+6KlTeJWRgkFhHpjPPx9zJhgB/ANFpUDpZSs+Wm0
	GdP/s0/4UZqea3U2Ryz4TOPHqmGSjLa74UmPTFpt129v8Tmhhi+iVFjOlcyG90VnPTNkP5e26Eh
	vU
X-Gm-Gg: ASbGnctJ2YC4MuvcLx/h0aq7x4JOixYzJUupOkPtCbalU6IhpUSp1Sk3nRtZZRnJ1HK
	G9TAK/D+D6IUP+hYLJNXCMzcCXepjo2gAQttE45kkAvVbah2IwHVW4rwxxlezbDbxCK/SsGxUHz
	UYkoaoUH2iS+LzOITReQjz1LKbDQr5pOtO1sSZvZV78bgZwc8nn6Uvd7jKDk6eHh1QzTyxxk703
	tyvLoOxDSGRMDB90DKQyzjKZnAfjYSrHFPRuYaa417tIsufoI1H9ZHJ88E+VVVth3MgBXZWdBJv
	9mGoUQ22eIBAQs6X1GqqCy1Z5VQM4PNcyB6JpdAKtFwuzcTSwAVVX2bmUXS1YEXA8GHOVhG6MrP
	bK0z4Zlm7jXQrEmYPjcCiMan80m26pmIhxpV2E7r9fPjoKOV7sniEb0h5tBhoFKwp
X-Received: by 2002:a05:600c:1c9a:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4561608ca40mr47116385e9.26.1752503852572;
        Mon, 14 Jul 2025 07:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTvnEcDMapbCXWP3qDegKpdCdyuaTjkUqgqccpswwEq+6DQh1O4IMK7Ozrf7oErXapdbaEbg==
X-Received: by 2002:a05:600c:1c9a:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4561608ca40mr47116125e9.26.1752503852095;
        Mon, 14 Jul 2025 07:37:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm171298475e9.33.2025.07.14.07.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:37:31 -0700 (PDT)
Message-ID: <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
Date: Mon, 14 Jul 2025 16:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:00, Lorenzo Stoakes wrote:
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
> be located in mm/madvise.c.
> 
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
> 
> Put a static function in mm/madvise.c instead - can_madvise_modify() - that
> spells out exactly what's happening. Also explicitly check for an anon VMA.
> 
> Additionally add commentary to explain what's going on.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/madvise.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   mm/mseal.c   | 49 -----------------------------------------
>   mm/vma.h     |  7 ------
>   3 files changed, 61 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9de9b7c797c6..75757ba418a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -19,6 +19,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/mm.h>
>   #include <linux/mm_inline.h>
> +#include <linux/mmu_context.h>
>   #include <linux/string.h>
>   #include <linux/uio.h>
>   #include <linux/ksm.h>
> @@ -1256,6 +1257,65 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
>   			       &guard_remove_walk_ops, NULL);
>   }
> 
> +#ifdef CONFIG_64BIT

It's consistent with mm/Makefile etc. but having a simple

config MSEAL
	def_bool y if 64BIT

or sth like that would surely clean that up further.

> +/* Does the madvise operation result in discarding of mapped data? */
> +static bool is_discard(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_FREE:
> +	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> +	case MADV_REMOVE:
> +	case MADV_DONTFORK:
> +	case MADV_WIPEONFORK:
> +	case MADV_GUARD_INSTALL:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
> + * circumstances - discarding of data from read-only anonymous SEALED mappings.
> + *
> + * This is because users cannot trivally discard data from these VMAs, and may

s/trivally/trivially/

> + * only do so via an appropriate madvise() call.
> + */
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +	struct vm_area_struct *vma = madv_behavior->vma;
> +
> +	/* If the operation won't discard, we're good. */
> +	if (!is_discard(madv_behavior->behavior))
> +		return true;


Conceptually, I would do this first and then handle all the discard 
cases / exceptions.

> +
> +	/* If the VMA isn't sealed we're also good. */
> +	if (can_modify_vma(vma))
> +		return true;
 > +> +	/* File-backed mappings don't lose data on discard. */
> +	if (!vma_is_anonymous(vma))
> +		return true;
> +
> +	/*
> +	 * If the VMA is writable and the architecture permits write access,
> +	 * then discarding is fine.
> +	 */
> +	if ((vma->vm_flags & VM_WRITE) &&
> +	    arch_vma_access_permitted(vma, /* write= */ true,
> +			/* execute= */ false, /* foreign= */ false))
> +		return true;
> +
> +	return false;
> +}
> +#else
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +	return true;
> +}
> +#endif
> +
>   /*

LGTM

-- 
Cheers,

David / dhildenb


