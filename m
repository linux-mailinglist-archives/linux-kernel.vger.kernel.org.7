Return-Path: <linux-kernel+bounces-733246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF4B07214
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1700E5823C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1D2F2357;
	Wed, 16 Jul 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoLUj0gw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC82F2345
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659035; cv=none; b=tc2xDjwC+Qj3RQFcki8GNpC+HB/Bg+NvEeIJ+bJxElvVRE9HaTch4tJrj2cyj+8P9k9cXSPdZRZCUBmq0zJa7kpt2MRFhPYje6ZU1wfA9XdQt3ZCvvrcf6mHBnOlSuPkLeHul4cFJw5k079Ka/c0NYpw8mB0HTRMjKn26UV2TRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659035; c=relaxed/simple;
	bh=bVw/00jY1IFVypHwXv/bAlPTi7JlC4KfSTgGpLoY8dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DzXRBxl3NTJbnMrxT713PS7vwoyd6cmbgwK5phdu5hYY9ULu7GoWJf8zQiM6xyFEweUBr0gYT/sbbAh+iSEp8Vaa8zNVvLYTw/EDtZOSaC8ohdHUQ2dmn9/jXgb35BspxndRlnIm6Paf4lSxePokjcoGzbvdRa7nftf1IGpdix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoLUj0gw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752659028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/EZXRrxsf4hYE6kRrn8jWim6/VvZEve3WV0swLXkTVY=;
	b=LoLUj0gw5ODg9nJPaIgNyaHlkPmziiR4uOcBmtoJDezL3XHcSmmV2m+tB5eYerLDGt5mzg
	P7m9iNr7Zc+zG1hy98Gl5In8ASJy+MLpOvc7MruTCmW/0UubCAJR9+Fsfz9VzfWumB9dpE
	XmN5ct/Z/LeJv0ggxTl276Sl3LD0v7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-PIxteN6cNq-e136JFuK6QA-1; Wed, 16 Jul 2025 05:43:47 -0400
X-MC-Unique: PIxteN6cNq-e136JFuK6QA-1
X-Mimecast-MFC-AGG-ID: PIxteN6cNq-e136JFuK6QA_1752659026
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso23831775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659026; x=1753263826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EZXRrxsf4hYE6kRrn8jWim6/VvZEve3WV0swLXkTVY=;
        b=TcZCXrcpxfChLhO2uKUnLgR90dOWPPLbtqZi3t8jcT+2JeH116hlx7ZMZ/1r6EXM/D
         fAx1wFeuQYAJAT7fRpzHCs4si4+hRREYQydQrxJfnATB/JA2U74TkwMA3ArEI8JOCFCg
         dItf8bhImDHQyefLiRl4W2nlaHh5S6T4TJFr5DeXBXQh9WXm/7n0fUwKvg38VJAan2e9
         0Z4N/QIm5zShL/PuKYM9xkYHrHcTLpzvbE1QJ4xez6b4eRylyGZi0m/Nlk381kDLR2Z1
         Bjc7pBRtj7cb2nsvsU+xczgCgITaoVo9QHno1j39P6nZLqURsdm/kqad4yvZwXDqXV28
         wj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoJ0gZVRXEh2oHDBKbizznXk99F7xa2eqg46UjNLA1WEjUeVbaePoQXWF28EaNpJSrVeGOt3xIKsTxAqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aNmmlJtlF3jpR49BHG7Er2JMGDrKceHRiNXHMsO8Y4kdcwHj
	XT1fVltSVTGGDR790DuLCrLgNlntU0dkQHkx3lm6JBTY8rnlelBqd0vNqnXri7MVWYfDcRiQBll
	8dwyUI1ttOenj+CYg7Gqh2VDycRSzg0ul1JfdSW4Q+yJgmnmU7PgnyAXtyYTNkwZ7jQ==
X-Gm-Gg: ASbGncvdwKa1Fz7v1/INRwcVTjUp5XBqhdZ9zlW9lXOEISiJfAZpv0EciQNG2bF/r7c
	VsaEAuXfYQenDQsO+ILSH8xfc9J+t8S2s4jpLhHD+9yOdHTNndOVCWXY68VuT6M5x09x/aKIZm0
	lKxGQ1cp2aCSvvwikiFRC42CXHFwOfHCUKSiyFjy1VrKjURQB/QHih5R/LT/KDZMVREArNcNMsZ
	SfxDQgM9kxT1Vq9MmiGDq4vr1aWAqujQBxFWeoxMo6zWrVfmB17b+cIpveTSdhBGyrdWFlMF7EK
	0mTqfkAQwS5z1QoJ44RTyn1+fCJ3dHseLo6lu91q8BFqp+FZneQ7t+MwzxIIAJI63RA04l3V9bK
	5Vcc+EOgXXbvc5fOsvrQkg69P1zTIrdhtwINNSLc0NVHa6/dlHJFNRK084qG3DQQZXsE=
X-Received: by 2002:a05:600c:450f:b0:456:2981:2d6 with SMTP id 5b1f17b1804b1-4562e34dc2amr20719015e9.14.1752659026010;
        Wed, 16 Jul 2025 02:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOTvAkZYlnUiMKWPHkmso+B0Carde0PiVJl54H4YFpST7Qr1kk5OYhcs8Luh+rMMtmr1Qd2A==
X-Received: by 2002:a05:600c:450f:b0:456:2981:2d6 with SMTP id 5b1f17b1804b1-4562e34dc2amr20718615e9.14.1752659025580;
        Wed, 16 Jul 2025 02:43:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm17635386f8f.62.2025.07.16.02.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:43:45 -0700 (PDT)
Message-ID: <85b79e18-8c67-47d9-8520-0dfd31a5a6fd@redhat.com>
Date: Wed, 16 Jul 2025 11:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] "fork: reorder function qualifiers for
 copy_clone_args_from_user"
To: Dishank Jogi <dishank.jogi@siqol.com>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250716093525.449994-1-dishank.jogi@siqol.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716093525.449994-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 11:35, Dishank Jogi wrote:

"" in patch subject is weird

> Change the order of function qualifiers from 'noinline static' to 'static noinline'
> in copy_clone_args_from_user for consistency with kernel coding style.
> 
> This is a non-functional change intended to improve readability and maintain
> consistent ordering of qualifiers across the codebase.

Simplify to "No functional change intended." All the other stuff can be 
dropped from this sentence IMHO -- I'd even drop the whole sentence.

> 
> Signed-off-by: Dishank Jogi <dishank.jogi@siqol.com>
> ---
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38b..574ff0d983db 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2743,7 +2743,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>   }
>   #endif
>   
> -noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>   					      struct clone_args __user *uargs,
>   					      size_t usize)
>   {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


