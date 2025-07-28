Return-Path: <linux-kernel+bounces-748294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D1B13F26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D44E160EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC71273D96;
	Mon, 28 Jul 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B41ugIq3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E12737F9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717601; cv=none; b=ED+L72voWlam2X1DkkCv5oDx/pOL4NseziQDcwXIkVImx4hv2BHmVxX+985RJDNRDdZUoTdykAR8mTPWaOt77UEdojjVVquZL30hFUu6uqtXyZu8vFAftR8c4vBhx1LzH70zoxgqR8OO4TpkiZjCNd0lUQc7PWGPxu/DJ6+raBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717601; c=relaxed/simple;
	bh=61vn1enfbazbBU97QrpkUJdiQOHm/6mlocOHaoQekHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDIJJHfT99GRJvUpKxkIUVcTjySDYg9rJfQ7mmuZO2kB7OgWftVXgd07hLHWLrCIeC6FDAVHEXxlOTZGlGPfGu6BObfpMhBRaYIl0PPU9s/ifMovpGS1PX116bFEG5gcpqw5Wd9hqg4bUxG32HK28X6gevyyNuqoQ6pCegc+otg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B41ugIq3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753717598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f7oic3FoXTqk2yfNwBYbh+AFvbYd6u94tqfvzWajS/Q=;
	b=B41ugIq3WPOfS5gBNz+6K7E9bsAWKUd9NnT/QaukcBCu8eSob1A0UXHvCJqBbYmtTKYwXQ
	u7wi0IhlqGas+VKDUDTjyQftmeasfT9wYvh6erpJ2IaXA1ogwbz1IKC+Q5PE0ldmv/hHsZ
	0I55YjH5zKqEiwx/a5zqPjeNO4WKKwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-hekTYTHDPjm5_SHtw7bsHQ-1; Mon, 28 Jul 2025 11:46:32 -0400
X-MC-Unique: hekTYTHDPjm5_SHtw7bsHQ-1
X-Mimecast-MFC-AGG-ID: hekTYTHDPjm5_SHtw7bsHQ_1753717591
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so21655405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717591; x=1754322391;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7oic3FoXTqk2yfNwBYbh+AFvbYd6u94tqfvzWajS/Q=;
        b=BzTqBQ6et3Pt+VAcnRtTH2ZoWlXj8Dwb3Lvb2ci8uXd9MPnWKW36sixMos95xtQzQL
         UpShTXAEENBuFXPTCy/kxrFhoxnxlJ8W+42e8Kt+XN37TDSiCqOMcRdPqGEAqDnejs7V
         OBYQ0sKqaJ2sTb3ojjxo+wYaKtl2+LBOIrI+YCfGA9QIP3o3hzVr+aN1Hppx0aQIGYO7
         YWtOEkHYggc2/ghkT+BPif6IMh0yzt/2a0GEP8XgtERueJK+KD9/UmfZ8kjG1OCtDVCk
         6FjdP82oYeKEyq7ILqkgpIUZmvWdHGCU/up5GJAzqzJwonxcR1UI7LV2RWJGQploVJgC
         d6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmkDeLQh5GaMKEZ3rwCifOs4G/viT52Ys4Q2mURAWTzm/y3i5Ljvxo2gmZy4rbu07OYLvIJIqHzHMk5LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEPxG4IBV9zecmm+ALy1flpVqH/q+LZ04mTDcIX8s2oo9Yl6W
	g9D0uH5u0s8GxDM/CvC2TlrkCXOKVLO/TyJoSoiYDy/seKtO9DRP6WvBy0aW6QuiIjpM81bIIjA
	3LIHCed0eUgVN2TeqKU2vUcK6UyMPB3GhAkLqU7ZpuEPFlVw9Fl+DaiA2aIo5g9c4Ag==
X-Gm-Gg: ASbGncv2UA7SeKWmbXUcCQqhDzexCTMU9eHhu6TGn7ie2o6fh5zJ6UKoM+bsTx7o7Zm
	YnPi/6WkBzPwzGKNEmLdyq1aHp7x2YDaoWPSgOGms5XNlVBUTHFpFPMMLKX43HO5gmg2kfhKfyt
	xW+ZuuliewNqRgt83RbKD8rMYXFsBhpUmXc25WHMYK2nWRYi1aXhBfiftSlGgVzjYpGvmRfWrZW
	GC3KTwoYplG4RNMajEcDPPeORXt9LPSNjCLRhYYUw/AGy71ujvg+HQ+JATmcbJXj5LZEPU7V3K7
	d49tLM3WcJK9+D6czzJWnjSxXWmJ9/HHWrDQvSYzANon7eeSMNHpYDY2C4i9yDjgA/PlWO1Zn7n
	cPuqi
X-Received: by 2002:a05:600c:821a:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45876449d73mr111224435e9.18.1753717591032;
        Mon, 28 Jul 2025 08:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmrsUao+mUw4BQB4gPUpkJyG+uDCqaGsCW0FsgdeXraTBq/babl0tGuvtigi2h6t7PYnkl1w==
X-Received: by 2002:a05:600c:821a:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45876449d73mr111224025e9.18.1753717590538;
        Mon, 28 Jul 2025 08:46:30 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-169.pools.arcor-ip.net. [47.64.113.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586eeb5f3asm108794855e9.2.2025.07.28.08.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:46:30 -0700 (PDT)
Message-ID: <5fb2159f-12cc-4395-ae53-b686d185be45@redhat.com>
Date: Mon, 28 Jul 2025 17:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/x86/kvm/ioapic: Remove license boilerplate with
 bad FSF address
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
References: <20250728152843.310260-1-thuth@redhat.com>
 <2025072819-bobcat-ragged-81a7@gregkh>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2025072819-bobcat-ragged-81a7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2025 17.36, Greg Kroah-Hartman wrote:
> On Mon, Jul 28, 2025 at 05:28:43PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The Free Software Foundation does not reside in "59 Temple Place"
>> anymore, so we should not mention that address in the source code here.
>> But instead of updating the address to their current location, let's
>> rather drop the license boilerplate text here and use a proper SPDX
>> license identifier instead. The text talks about the "GNU *Lesser*
>> General Public License" and "any later version", so LGPL-2.1+ is the
>> right choice here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Don't use the deprecated LGPL-2.1+ identifier
> 
> If you look at the LICENSES/preferred/LGPL-2.1 file, it says to use:
> 	SPDX-License-Identifier: LGPL-2.1+
> 
> as the kernel's SPDX level is older than you might think.

Ok, got it, then please ignore this v2 and use v1 instead.

> Also, doesn't the scripts/spdxcheck.pl tool object to the "or-later"
> when you run it on the tree with this change in it?

I used the scripts/checkpatch.pl which is also supposed to check SPDX tags, 
and it did not complain...

  Thomas


