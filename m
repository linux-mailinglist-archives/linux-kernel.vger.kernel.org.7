Return-Path: <linux-kernel+bounces-844692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4EBC2844
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E41514E6F49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4638233D9C;
	Tue,  7 Oct 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSjAjZUG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFB22D4DC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865739; cv=none; b=ZHNXGoR0+7B/J+04GAq5z8Lq0/Xggfd53nxKdhKh9EzbXZx4AF5rZ/0hWwMAreYSt68V0OrSP3pvDPcrMsSL3OsQ+F32VUfjakwMBsBnyxTvAQfG3bIIwHXwu3GnUa6Ypvf2/FAwRfRJgrWECWv09cQwwd0fLGJjd85nmFH8Alw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865739; c=relaxed/simple;
	bh=uKIkhTM78wpKbUjie3b7/JDvt+bc3ZLFicExdAwdDPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ueb9F+XSIiMmcqU6j8tCbsR8zw6qfMIJUsHVPaFWGEOr6aU12+filebJ11QL0PpREHkrdBalE/y95/KBPwVYKZdOsxzSJqCBmU6RtkfRGbMxE9fgHcaeK4PJbdz5/plz2dFxAIH1fjqY9RUW9yJ1AxifZGHIwR/IqkAhtWX4zIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSjAjZUG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759865736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RAfzTxWuab53JE8Gy3AGdKtPMv/FNNv2702EcVDBDzo=;
	b=fSjAjZUGxKXA1zK95sIT4yG7hvHYuaVi9I6Yf0gxBdQgmzf+jqqLDa8tQPPGw3UIgkyjH8
	DTuwvyvd/XhW9i776n/qWpplOIPizzK60SGrTokF4X3RlutOPh/XekzzA4EHEqJ49Zj0+L
	vVOSUAF2z4SW1+9YVaZE10U0uc2GHtI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-29CyZnI_MgqP4BLbNJKBYw-1; Tue, 07 Oct 2025 15:35:35 -0400
X-MC-Unique: 29CyZnI_MgqP4BLbNJKBYw-1
X-Mimecast-MFC-AGG-ID: 29CyZnI_MgqP4BLbNJKBYw_1759865732
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3af78819so30195605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865732; x=1760470532;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAfzTxWuab53JE8Gy3AGdKtPMv/FNNv2702EcVDBDzo=;
        b=jOgfqwrd0uoma0Gizqxlcm9kmONBJAl0XuxqtzHZUcbq897e5HKmTT2nuD3Sy7VUMA
         7IqFnT+GDc47b4nULx8GmuWJizMuF3IRPEB91jh62ah4IBmVUSf5HNtKX43OO7FBiN9w
         6kAnOLrb/QhBiehvou0jk14FiXfzPcTVle8ACjnAbqq+ygasClLEuSM9w1akPR571BM5
         DwNYC4qR5QPbtRAty5g1hKCeJgHXRezVftGm+/NXWEQHUl9Y6Ix5/vbJ4ss9xLQxNuPt
         0xyTUj77kvE+cj37MKagMwX7zwX9UESJRrZiVWBcAGiz1Yx/11aHts4OlGA37vXLqvyQ
         DJWg==
X-Forwarded-Encrypted: i=1; AJvYcCXZMiZjmv18XNS3msjAMRtN5GfnxeIE49NEbh/wDNwsrhNGBQQYx437L46oGiQMRnPjKsyamxiXvXEia1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsAihZuNvI2u19fad+NplgGCcpzP3tCtL1MtobRlu8r1oBwKo
	CCYLHCkfTFkii2m5HwJ85sxR/h/fMoKMhzs59gthp0lwzD2+Q2H8KFJSdTo9IO4T4SSyAkio80w
	Wx3YiuAimKFe3f2wTSQZLcV0JKiPInuc7WCKKeBlyiZaf+9OWtIngbU7VYeWGPzZY/A==
X-Gm-Gg: ASbGncsp3yBSpyuA9rY4rY9/9iF4MD3czDKmsPRN+81HtufTnrN1elrLnlY1yim45cR
	e4vbMxRFQaiIc5uqkFlkDfpBdsri8yEXAn5C8xmpFYHMgArUKsFjteyD5pcLCZXwGmyMvh8Qs+v
	RYBBlUGhZ2OCmlYVGtB0CCJWmxpLvCjBALzVvOo098FRUcBMNV4+tfRVyFSSj3nprfbPo83SdVl
	2VofKxdl4q+jfSs0NrvF46Tp7CvMKl3xw511UkY146BqABcgBisP+Z+hoOzglpIfE9lvs1pH6Xf
	SxK2O8a/Q7vXySLSxZleqmVyqC237cc/LbFixy5hnLGxcSSoWLTaTOT622oz6+iz2Y/Zhzg00i5
	D4xHdEYNZ
X-Received: by 2002:a05:600c:1986:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46fa9aa4711mr6325745e9.11.1759865732186;
        Tue, 07 Oct 2025 12:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCN7DAOe0T4B7zFqJ7eZ3GMf7f3SbobsOoyW6DhHtRl7kGlkXWNnfp4MoPqJQerU+j3+Qa0Q==
X-Received: by 2002:a05:600c:1986:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46fa9aa4711mr6325625e9.11.1759865731749;
        Tue, 07 Oct 2025 12:35:31 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c2a39dsm7330825e9.18.2025.10.07.12.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 12:35:31 -0700 (PDT)
Message-ID: <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
Date: Tue, 7 Oct 2025 21:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.25 19:56, Sumanth Korikkar wrote:
>>> With the new interface, s390 will not add all possible hotplug memory in
>>> advance, like before, to make it visible in sysfs for online/offline
>>> actions. Instead, before memory block can be set online, it has to be
>>> configured via a new interface in /sys/firmware/memory/memoryX/config,
>>> which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
>>> controlled by the user instead of adding it at boottime.
>>
>> Before I dig into the details, will onlining/offling still trigger
>> hypervisor action, or does that now really happen when memory is
>> added/removed?
>>
>> That would be really nice, because it would remove the whole need for
>> "standby" memory, and having to treat hotplugged memory differently under
>> LPAR/z/VM than anywhere else (-> keep it offline).
> 
> With this approach, hypervisor actions are triggered only when memory is
> actually added or removed.
> 
> Online and offline operations are common code memory hotplug actions and
> the s390 memory notifier actions are none/minimal.

Very nice.

> 
>>> s390 kernel sysfs interface to configure/deconfigure memory with
>>> memmap_on_memory (with upcoming lsmem changes):
>>> * Initial memory layout:
>>> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
>>> RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
>>> 0x00000000-0x7fffffff   2G  online 0-15  yes        no
>>> 0x80000000-0xffffffff   2G offline 16-31 no         yes
>>
>> Could we instead modify "STATE" to reflect that it is "not added" / "not
>> configured" / "disabled" etc?
>>
>> Like
>>
>> lsmem -o RANGE,SIZE,STATE,BLOCK,MEMMAP_ON_MEMORY
>> RANGE                 SIZE    STATE BLOCK
>> 0x00000000-0x7fffffff   2G   online 0-15
>> 0x80000000-0xffffffff   2G disabled 16-31
>>
>> Or is that an attempt to maintain backwards compatibility?
> 
> Mostly. Also, similar to lscpu output, where CPU status shows
> CONFIGURED/STATE column.

Care to share an example output? I only have a s390x VM with 2 CPUs and 
no way to configure/deconfigure.

> 
> Also, older scripts to get list of offline memory typically use:
> lsmem | grep offline
> 
> and
> 
> chmem -e <SIZE> would work as usual, where <SIZE> specifies amount of
> memory to set online.
> 
> chmem changes would look like:
> chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
> chmem -g 128M : deconfigure memory

I wonder if the above two are really required. I would expect most/all 
users to simply keep using -e / -d.

Sure, there might be some corner cases, but I would assume most people 
to not want to care about memmap-on-memory with the new model.

> chmem -e 128M : optionally configure (if supported by architecture) and
> 		always online memory
> chmem -d 128M : offline and optionally deconfigure memory (if supported
> 		by architecture)

-- 
Cheers

David / dhildenb


