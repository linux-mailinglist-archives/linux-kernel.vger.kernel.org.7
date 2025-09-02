Return-Path: <linux-kernel+bounces-797184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B1B40D16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044055E2185
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAE34AAED;
	Tue,  2 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSrDF7m1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C13469FB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837393; cv=none; b=vGod8YzaSDhZwczxgjzQSkCwZApEdxo8NeP3cECR37RzHAIzfh2rO1zCLMq6iyJ2xgzW6XKo5je1Y7/akpcMoK8miH6BQRpif+xIazW2fV/DNdxbi5w8517Q2s9Gkv3ZvxeuptK4IFtenuXHUrp1s8V81E/5/Ydilw+9Q4nXuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837393; c=relaxed/simple;
	bh=TLbZotnTG7DseDAu232CMzgI0SAtuc05VcgLJ29844Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCT8s3tUodqPFNY++SwWv5sfQEVaOUzWEND2xT4x8/cmGqPiTWX9xTjIXiUy+/uiqlnBPnESg15jzAsKxCB7nQ6EtnCksGIqrt/SrNq5GxvMkCupib61k+XBGK+gCFcySizgBspgFu4B3t+F6FmLgF4BURXNAJoCXGjo8czVN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSrDF7m1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E0pFh8FxqfM1XEDmmx2whmM7VQSC+oOKSVYCp7AUCP8=;
	b=gSrDF7m1DwpN4QI5HgqDbHnUF+VdZ5uXIzZB2HgivvkUFE6wm/IfjiAcQ3n2RTEApq5ORI
	A/5T/sZpvUEEfM4XEmQCHNWWbtWn9ybFqhdqxnbXoNbERTtxlXZ3bTQwCowAY3N0PnOfOh
	CBp1cEWgnsmZKtNlZKVMO0KYOCELdNg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-dQNGKaQ2Oiaj3cdSHMh-IQ-1; Tue, 02 Sep 2025 14:23:09 -0400
X-MC-Unique: dQNGKaQ2Oiaj3cdSHMh-IQ-1
X-Mimecast-MFC-AGG-ID: dQNGKaQ2Oiaj3cdSHMh-IQ_1756837388
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b85c93afdso11402995e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837388; x=1757442188;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0pFh8FxqfM1XEDmmx2whmM7VQSC+oOKSVYCp7AUCP8=;
        b=o3D2mDkIcMPE+57/qXMIyZJz5igezR9CsPewNRf95G4zjlFu9+MCXkRB/f2Mp27+Za
         DMVVn1hLWlNsjXp54R9NRcWwWYbX7hvI/nOKcOvAGw8ppKGPdvojUZ0nu4L/CS8M7/tl
         El5I+cPpCw0TsA93wA/fSUPYsH/2lve3A2mPFn2tF/Hf11Prn8l9l6dSv5kTjXDcc/HW
         OazyJUnl2Jdl46Lsn3u6+pTUlNsjJYvG9wzkRbFTWJoj6YoAol2W+ABRFs9AisNOS/nQ
         A7ldUKibDYn1+TSwIx6tIgixJqe86giAiJeHDIWo4cCLyzmXMRTMHDhYD2gXVny5GOrX
         jJMw==
X-Gm-Message-State: AOJu0Yz5aFp8DZLqgmn0m3wOQpWt3FAuI30PX9HRuBGuZOWDQQFxqgV5
	w85Fk8n5RutVggNpQmbKDkQ1K8uiAXFz/8O+juxuVAVecFVL7ZNIphKW+YFldxVClcNbtBSRIUY
	Zm0uAqeiKGQknx2J66/3RG5fO29Ym75vBGz8DzMBjvQRWnHgPCGL1hkmqmGMVRuhoEw==
X-Gm-Gg: ASbGncucZNe614VUi7PlmvuMPzb2O5kHVgW7TjeB0p6gPRIRdumS5/kaZdY0ps0an2Y
	h+PRbjIyX0k6V6Mk5XztUtA4l8Y+2ScdSVnERU6xiA4bVHAl345BPs6pLzDHHQPhCTc4Q/x6ZxY
	gXqcojO5wUBiA2APv+OrbNDQnuFV44qUtCjG2AG0F1GgGLmw0FV38KpYmP8g/x+J1V3vn8ton3g
	yKS4RJgYEMmd3XJPFHNhpeXmY/0vlZVsmC+/2xZcpePIEe+BTklxt8e06Ly6t3gvECZ3Ry8B84Y
	CRcqJYyhLe2jfiUMiYbKuTRkUxf7ZTVMC2B7/szRW3K6YuCq8fS2W+PP/OxSXAOR4rtLMUS3zQa
	qI9lZb+hOlVfW5xYvSCi2mzu3e1gZdZ18ZyO8vQBBb7rfOhUDDdrIh79E5DANjkZowFk=
X-Received: by 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id 5b1f17b1804b1-45b8559bd2fmr103371135e9.35.1756837388461;
        Tue, 02 Sep 2025 11:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhNRpJ3Pxny2+h5z4NitAUSkL1zdnUZ2TclN2kLQ0HXcCaFawRrAsucJHE1gydRQcN6r5Jwg==
X-Received: by 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id 5b1f17b1804b1-45b8559bd2fmr103370945e9.35.1756837388027;
        Tue, 02 Sep 2025 11:23:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm20237659f8f.5.2025.09.02.11.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:23:07 -0700 (PDT)
Message-ID: <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com>
Date: Tue, 2 Sep 2025 20:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902175903.1124555-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 19:59, Vishal Moola (Oracle) wrote:
> Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
> that were being used for the kernel stack.
> 
> There are 3 cases where kernel pages are allocated for kernel stacks:
> CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
> These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
> respectively.
> 
> In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
> than 0, and pages are tagged as expected. In the third case,
> THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
> This meant that in those configs, the stack tagging was a no-op, and led
> to smatch build warnings.
> 
> We definitely have at least 1 page we want tagged at this point, so fix
> it by using a do {} while loop instead of a for loop.
> 
> Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

You sent the patch on August 20 and I replied on August 21.

I did not receive any reply so far.

And now I realize that this patch is not upstream yet and the commit id 
not stable. So the Fixes/Closes etc. do not really apply.

My current opinion is that we don't want this. (see vmalloc reasoning 
and unclear use)

I'm happy to be convinced otherwise.

-- 
Cheers

David / dhildenb


