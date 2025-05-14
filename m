Return-Path: <linux-kernel+bounces-648176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C68AB730B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263801BA02D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FA27CB2A;
	Wed, 14 May 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYNU7USg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0E27A137
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244493; cv=none; b=jiXCzY2HebHlIZpEx2I9JcGjhICJ/gtPXAmY14Kd3ZKPYEJW50Z0q9Ma0v/cWo48QdqEQLppVfgQttQ+Nyfk0J/6OHOWY+ye8G7bpArrFvOlCyMX3QqaPBdHmds9fKcXQQ9ErfQwEkjYVxTwPSEuJBylRMn0HjGfZ23Sm795fzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244493; c=relaxed/simple;
	bh=L1rDvMltVe/rL+hi/JDK/6Rj5CX6W7bMcfshUyhNYoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R00s76pnvitbsAlMc2kKUSKXMFojPUeyAWrp7kBO3zcDeVi8710aDOcI9eGnCRgANYjk7zPtRaTdkqmm9PItY9LP4YtzuRRVy/DjRPko6VAJOrVS/HA8tg4qfuqO6ZzE+uJdah6F8UUBhELFtDyAWEsvEMuepAai42ZZkMIU4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYNU7USg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747244491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=02aIA0KuNfQerpq4X01Z51ndiqtW9bAF5tXm8NSxOrQ=;
	b=cYNU7USgcF/ozzE2x491AA8CEkUUVn9GAslRm3xgAGFKUZ/6U8mDAD4avak7wLs/SAJCeJ
	ppjsKwcdsj9aO69ogZ62jprT2ZQZwYjRlkES95W0ABzdZYIiXcnEIAOqcHzIlHIenqLqYp
	wX3EucQAr5MZQuvM9P79o22bL1CVvww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-FEEtzQmtP5Cyw8d9qY36Jg-1; Wed, 14 May 2025 13:41:29 -0400
X-MC-Unique: FEEtzQmtP5Cyw8d9qY36Jg-1
X-Mimecast-MFC-AGG-ID: FEEtzQmtP5Cyw8d9qY36Jg_1747244488
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442d472cf84so398345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 10:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244488; x=1747849288;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02aIA0KuNfQerpq4X01Z51ndiqtW9bAF5tXm8NSxOrQ=;
        b=WDdksAbgEVOf9putrIcHu4Ugzq5uHl1vxoUuDXoHwvCXP+HC3wcNhxr76U7wK67lb3
         1/l3cNzDDmCUcgqan8ONTY+eLIU9/M9QmQX3slC/dy5f5jIYIkI94X7/PnTXApUUpmCr
         /rYtQxrZT6geuxcB4Ccfy0UrHWIldXg90NTpMAa3BpmJgFBpEit2i6K3qWM724TgFMlk
         LaOdveF0JQu/QI0DETSZ0Wyoh3Az8OrYDVypKlnEZUnlFVnucEFfHDQ2+KdxlljcF+Cs
         lr2vWbXtLTISjhiuaBAbjLDh8LZm+6t0ZpllDt/1/e6g08i06ytPfQH9zDhBYOMBNAi9
         UT7g==
X-Forwarded-Encrypted: i=1; AJvYcCWWk3+B7rKwbvLTeR3HlfmPwi1ob6zcRFUEw0O13eNFTcG8yKpRLoFxVMV9caYztiFeC7ANZsgDyC/k4LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZ9HDnbHjqe0NL5cYQB9YUsGn4G29Fg2c3QbMtWx+HJL75RlZ
	gRGM15fi/kasSbaxFS8mosIN7WfgLIBERF/xUnXVloP732SQEUgoZ/xZMPdYr+e7VB56iYj1YKO
	6xhVdUnLP4J9FZJ+Hp0N8kMw/JpGchgJ6tdHwnql62vi4Jo5+QEFnfkbRZ6h5Gw==
X-Gm-Gg: ASbGncuGgwqyYIwE6H9h3O6bA950pWS2Tdqix2ZG2aR5wW3hzb39IFqeWTsgO2DB9s6
	hPPfHE+J8IN2ErbXl3Kfgaj1VOg+BMaCelpQYQ2I2y0i6N5hAccedFbILRgNK1HLSjj0OjzdqJ5
	/YTFYOBkO0KpdnOMaz2XmPwgJk3QLSlNTUybukLel+SYo9WeAv8IWqGTaeJlK9TnYM9TTm9oxcm
	dY/Yf6rOvNEXZm3qoPuTqr5giMF/1GgufxwDpZHOwUMeqziEOB4mf/7AvUbpQHJwlY9K2SOUA1r
	aiHxTGB+nWUmnEQ8aO7omPRbMrnoeNR5e9nKKHJwtvqIwqF6LCpOINa256xGlO7JwS6Wl9dPokq
	mAnY4BWEYloawfvwFYBzEkh845dBDaDkGvVRASgY=
X-Received: by 2002:a05:600c:3c8e:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-442f2177992mr33353995e9.32.1747244488510;
        Wed, 14 May 2025 10:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF24Iec0BUULMvSIRozDIEqkHPc+d/0u2Qxbs3I1QqfBAUeUyJaYgIVgQS02b1VaqseQBXPHA==
X-Received: by 2002:a05:600c:3c8e:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-442f2177992mr33353765e9.32.1747244488087;
        Wed, 14 May 2025 10:41:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm20094627f8f.21.2025.05.14.10.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:41:27 -0700 (PDT)
Message-ID: <50b9d974-77a8-4062-88b8-ca7d312a67cf@redhat.com>
Date: Wed, 14 May 2025 19:41:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] KVM: s390: some cleanup and small fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 borntraeger@de.ibm.com, seiden@linux.ibm.com, nsg@linux.ibm.com,
 nrb@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gor@linux.ibm.com
References: <20250514163855.124471-1-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514163855.124471-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 18:38, Claudio Imbrenda wrote:
> This series has some cleanups and small fixes in preparation of the
> upcoming series that will finally completely move all guest page table
> handling into kvm. The cleaups and fixes in this series are good enough
> on their own, hence why they are being sent now.
> 
> Claudio Imbrenda (5):
>    s390: remove unneeded includes
>    KVM: s390: remove unneeded srcu lock
>    KVM: s390: refactor some functions in priv.c
>    KVM: s390: refactor and split some gmap helpers
>    KVM: s390: simplify and move pv code
> 
>   MAINTAINERS                          |   2 +
>   arch/s390/include/asm/gmap_helpers.h |  18 ++
>   arch/s390/include/asm/tlb.h          |   1 +
>   arch/s390/include/asm/uv.h           |   1 -
>   arch/s390/kernel/uv.c                |  12 +-
>   arch/s390/kvm/Makefile               |   2 +-
>   arch/s390/kvm/diag.c                 |  11 +-
>   arch/s390/kvm/gaccess.c              |   3 +-
>   arch/s390/kvm/gmap-vsie.c            |   1 -
>   arch/s390/kvm/gmap.c                 | 121 -----------
>   arch/s390/kvm/gmap.h                 |  39 ----
>   arch/s390/kvm/intercept.c            |  10 +-
>   arch/s390/kvm/kvm-s390.c             |   8 +-
>   arch/s390/kvm/kvm-s390.h             |  57 ++++++
>   arch/s390/kvm/priv.c                 | 292 ++++++++++++---------------
>   arch/s390/kvm/pv.c                   |  61 +++++-
>   arch/s390/kvm/vsie.c                 |  19 +-
>   arch/s390/mm/Makefile                |   2 +
>   arch/s390/mm/fault.c                 |   1 -
>   arch/s390/mm/gmap.c                  |  47 +----
>   arch/s390/mm/gmap_helpers.c          | 266 ++++++++++++++++++++++++
>   arch/s390/mm/init.c                  |   1 -
>   arch/s390/mm/pgalloc.c               |   2 -
>   arch/s390/mm/pgtable.c               |   1 -
>   24 files changed, 590 insertions(+), 388 deletions(-)

Hehe, that's not what I expected from a cleanup. I assume it's mostly 
the "factor out stuff" and new file that adds these LOC?

-- 
Cheers,

David / dhildenb


