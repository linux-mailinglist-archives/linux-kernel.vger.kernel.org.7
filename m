Return-Path: <linux-kernel+bounces-775168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302DB2BC20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0255630D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD081311C3C;
	Tue, 19 Aug 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l68YFLmT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0331195F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593055; cv=none; b=lZEaG1qINbdbx3DNaAL+/s7YsGaf98W8nh93YY9KmGx26+VaG3+9vbunZ6DatnxhxHC8EoNh+uVRbrwI/XHycyF6XO2JfJbvL5KWcu9w7Dta8GC+K9G66LZJeSwwBZedVcpjAGvrM8D2eu37e+XvIvpGFjR6v4xlNAZJYB6ncrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593055; c=relaxed/simple;
	bh=O6UgDnpyhMbdLXvaswNPUMuZHkfMxFRDhkfFM1xerXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSUbbqPK7+agqZKlqV8buqQpcZXuCwv0taUlgqfy0hbXvPTMYWz4NScJDPK/TCvcjjIr4V4PdkWetPibzxeE5AiR5jdPh00hpmdz7WFhKSooliGukhqK4YjZ6AB2NIkyVuQTZiW/z0AS5/oil4+tE9wD4vxsxyV0CdGMRy2FRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l68YFLmT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf3c8c2so373410f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755593052; x=1756197852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFC11YRDk3hLW4PFqQxAfzM0vOushhRghFk3Gc6p2xU=;
        b=l68YFLmT1sHLJBc7A7JmCQVrGMB20JH9PCRxx46alI5ZLO7TRJz7KClnpi/cOE8htM
         Z8gq53eIu4GDNL1PM3gIHOIfqVFegYVzhEO1+eTP6V3q5FQcFSQVntDfZ8UXoD78fFSI
         Mhi0FY5RKWYANITzmyMLcHCAA6wU18ZV9o/hkl8nZLu6LmFRLwElIO8a/BeN6NbMmF39
         lLmYlbT2DslLaZGzUbVwflBgj5sD++8P8V4knxN5H9IOt2My6+SmhnRih8VaNQhnAYA8
         Y8+lqp8sFc7OCj4ct8odWz60RO//twAPOnT27GbuMI1VJEYUoXj7yPL2ezMs9Rv5OaSI
         vv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593052; x=1756197852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFC11YRDk3hLW4PFqQxAfzM0vOushhRghFk3Gc6p2xU=;
        b=r7QdQVGGyeY3DHChl7ImpxIi1X5DINHBf4LfFd3Obrbbe8PfYvmGUMjiWJ50ymZYsZ
         FpqKszwoLii0Jj1IX7wOVOlbvJCUoKH00u/SV2UgktzVAdxhWfuJ4m91TyDRc6E+MWI8
         kA11SwCk2KDa5W3EdtWkTBuamgMyhIZc7IeQJS8NFIxMET3kfauUjETV7W7nFOiKGoqX
         Slbd99V7WsXYxloF0+neCeDiaiBMK+QLgtSEWClGa7pNQYaIb0qjJviv6jk4FkMs/dkt
         b6EXvZlAii0Qi/6jJX0nubpo/anYSG/slssyyW4tamuYfLPWTe++aJnRnZ7ycmHcJJfu
         rTEg==
X-Forwarded-Encrypted: i=1; AJvYcCWc0t1VvATZdsU0Xvn4YnSQzlzOqBov9ZblhGeAsPoHcyBB3qkmQK/F/TB3LDiq73QB9DIztAOhAQArldU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5ZlOhbgy8pVBcMVb07ISfp9jLCtSDuUqFVWxB6L+P0yaHRke
	WiaiQOKVP9tnCrtujtOy+DWMwBmu04spac4ma8Nq2a0NOZj8zsFwavuotXWSO+xOlWY=
X-Gm-Gg: ASbGnctOWt41x4kwwQfvIBZdvi259DI7stURHRamho46YttieQH4RU1VQb5RdFFNDTr
	JcRJtsA1XDDNOYMe5JKpcg0z8/ylHx3rovko1Q2UjV24rESr6uGUa++uihH/k9K5Kal3IkByhvK
	qQzq3vXpBmvGEJBeENsV/1RaAPGkQtsKlAV43ayUYyxL8t50Ov6rBlvatW6KlO2KoG0s/KxDjau
	578STHcldTmzKK6S4kBqnGZr2Lq3TWqP48qa/AoZhL3dwVZ2wIBqYMVVdll+1u6fd+zQzx7Ou3j
	ux3AOQGopApxu3AeDK/aT5QgqeD7sYCMMaz3zT86nOwJ9SG6C7IT3/YsqWvv+K5V0NXGKVayjNy
	AR0qT8uhG8X2zwFWN8DBDDvecl+fb7R7k4ZJnLtAYhWMsNLxV1u2m
X-Google-Smtp-Source: AGHT+IHofOdCeurN0rfQapxXw3T6dAf9uK8p0WB3BrcvzYJ1fUnpaHB4/Gv3aeR19imEmN6Xr0Vjbg==
X-Received: by 2002:a05:6000:2884:b0:3b7:78c8:f23e with SMTP id ffacd0b85a97d-3c0ebfa85b3mr546045f8f.7.1755593051742;
        Tue, 19 Aug 2025 01:44:11 -0700 (PDT)
Received: from [192.168.100.5] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43987sm2789350f8f.16.2025.08.19.01.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:44:11 -0700 (PDT)
Message-ID: <17e83e3c-1314-4198-82eb-ffc18454e344@gmail.com>
Date: Tue, 19 Aug 2025 12:44:09 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Update create_kpti_ng_temp_pgd() to handle
 pgtable_alloc failure
To: David Hildenbrand <david@redhat.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Joey Gouly <joey.gouly@arm.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
 <20250813145607.1612234-3-chaitanyas.prakash@arm.com>
 <4289fc02-8e09-4d33-a4a1-0e4b268b008c@redhat.com>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <4289fc02-8e09-4d33-a4a1-0e4b268b008c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Smart! BUG_ON() ends up in the generic “kernel bug” path, which on many 
distros is configured to continue after printing the back-trace (e.g. 
panic_on_oops=0).
Since a memory-allocation failure in early boot is unrecoverable , we 
must force a halt.

On 8/19/2025 11:41 AM, David Hildenbrand wrote:
> On 13.08.25 16:56, Chaitanya S Prakash wrote:
>> create_kpti_ng_temp_pgd() was created as an alias for void returning
>> __create_pgd_mapping_locked() and relied on pgtable_alloc() to BUG_ON()
>> if an allocation failure occurred. But as __create_pgd_mapping_locked()
>> has been updated as a part of the error propagation patch to return a
>> non-void value, update create_kpti_ng_temp_pgd() to act as a wrapper
>> around __create_pgd_mapping_locked() and BUG_ON() on ret being a non
>> zero value.
> 
> If  my memory serves me right, panic() is preferred in such unexpected 
> early-boot scenarios (BUG_ON is frowned upon), where you can actually 
> print what is going wrong.

