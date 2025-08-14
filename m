Return-Path: <linux-kernel+bounces-768395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353AB260A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F55C6FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CAD2E92B1;
	Thu, 14 Aug 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlUbxOPf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBD2D63F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162934; cv=none; b=tnhhcUSkFaviQr+mDIH8Ne1YJeV4LgqK4P6E3lGu4RKlCxhqi4HrW7tqm4DiYyWACLssQfQPbyz96fs8e3Lszf5o11VEHDSvYSl4NtscLZ6J+AjakH5Z2T6bKxZ/jA2yjS0QLM9WuFig/UqY9QEUgRsREQHbEh293qTcpbndBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162934; c=relaxed/simple;
	bh=bL+TQBZYuEU/KEjHngufkF6mA1QfPbqARU6KE/gAduQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jXYWzWSv4nnQ6bPgpwqt82nPi4Lg/8q0M+hlmj0OjBomC96ZTCZHKmXA6aNm808bjHsoDVxpoGPmb5XESMTgC++CpWCT7p0S35J0N1Gv+IxbF0P+56hF2zc2BqvGdl6XxgnFxV2F9ginplCSENhNJDxs/ly9H7PqL1tfuA38wNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlUbxOPf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755162932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pdq1zJqnP2uAEiZ7qSEJPdjozc60JgkfexDjAUfx3j0=;
	b=VlUbxOPf3iefE+5LTRCnko650f4uX/cdWOqS73P1I101Hx3dkVHBqvXbqFbbi7m1IlUdMb
	9fOApkYnfNwQsKDOR5YuMhVpRRfGdFCA/M4G/zoL1FzGFaxyHyEhRId2c+QBpL1h/WmcnM
	ymASOjYwQtG/CSnueacGZAoX1HN9asE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-gyhCkOqGNKWwKaK5rpcGfg-1; Thu, 14 Aug 2025 05:15:30 -0400
X-MC-Unique: gyhCkOqGNKWwKaK5rpcGfg-1
X-Mimecast-MFC-AGG-ID: gyhCkOqGNKWwKaK5rpcGfg_1755162929
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9dc5c2820so180370f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162929; x=1755767729;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdq1zJqnP2uAEiZ7qSEJPdjozc60JgkfexDjAUfx3j0=;
        b=ScqIfJvixoVkErA+U8U5igPWqoFCXjFNy2+z/yn5olwkMPgLNIuDM2yCAwxj3y7akN
         Skzs2JecSYFr3mpEc8DudStyn75Ruh2HBsDaeIgN4b1kAQmgF/Fy2v7i++6VNaX84VJg
         Vbr/udU0OrWZ6JFF0ttg3Dgm0oGz9DdlbY7E8jAj2FA3PLMIeRYGF56I+s2k+CLtWnQS
         SfRSERl3czYPtiUUB4kxsufSHUcGTNCE3ncgyYpMW7o1hx5Yy4nmFt/rE3alXKcTen9E
         krvLm8ogPEgNNaifS4lMvJtZ7wx8r+/5k2/mCYImSOMOFfa2FKns+s1nT5OCDzCb/r0D
         b7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXqSQhPJS03Ydqg1XS/4imTq8MvYJjKbxcoHGfSVqIetH7hsr4XOTJ2bZPG9PSxmgkCXmggC79XF7j4QNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ubxXoH+R27J3WwXRhs2g9kfg+dCBORDywSZQQvDtGhLG/AAC
	DirMfOKuEHqFUgt+YGku5rx8bUoU+c4p5zfSpfxexeR+H9lHzZSjkZ2dtcRr3WVLmokYYrGuYRw
	POqwUJsjD2CcNVFv4MKuZ3aaXgUMctGiLg7CQJ2dUEqMbqHVRFe6tpV7ycevBi8leHg==
X-Gm-Gg: ASbGncsVwuuA1TxB+3c8yMpD7sBZcLDN9GtLKG8K1O9Dz31/Pc9Ujw4fiLwkAf/wHQN
	FI1Gn/v6a9drmhasTUlzrNjTX3OlH0C1Nn15qj3UXUgzKKW6L+ehTiWnH5VDmUFooDz1L9U1Osb
	BnWQ993V2cPippc8Nbub6WaR64yRoJ+PGWINR1H5BSlpOpJP8N6pj9HO1UwM3QhCtcRaB8v1oMq
	9w19r9CpfkazAbACx3W5bRNi5WNYP/991IXHd/V0X3wvzadFNWuSdwIWlx+5ntQ8s8qDaabptoD
	JzylS+H9KTMIPKJuBeYfwb3u8Hk1GrAcNPIeEaWF1fu9SZIB6X/GEnXWIF2yLk8LCzi4ubkrXwM
	02e11f3xDFlHPudT1FrBDuJi2w5kniNbBgk2fHIo/94pX6Au/ccHHqLEZeEc5A55Qung=
X-Received: by 2002:a05:6000:2884:b0:3b7:99cb:16f6 with SMTP id ffacd0b85a97d-3b9fc35fe36mr1949804f8f.53.1755162929359;
        Thu, 14 Aug 2025 02:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcrX2+PzCY0XZvo29SUS3M4OEb/0+9x7J+b/dmSOc+iPiPpMRSSVKrKAMc+n8yaXSCp4+hKw==
X-Received: by 2002:a05:6000:2884:b0:3b7:99cb:16f6 with SMTP id ffacd0b85a97d-3b9fc35fe36mr1949782f8f.53.1755162928978;
        Thu, 14 Aug 2025 02:15:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3e00:9fca:7d89:a265:56f3? (p200300d82f443e009fca7d89a26556f3.dip0.t-ipconnect.de. [2003:d8:2f44:3e00:9fca:7d89:a265:56f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c71068csm13649375e9.29.2025.08.14.02.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:15:28 -0700 (PDT)
Message-ID: <7b8f4380-d74d-4498-9e14-b1302f1dec0b@redhat.com>
Date: Thu, 14 Aug 2025 11:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIG1tL2h1Z2V0bGI6?=
 =?UTF-8?Q?_early_exit_from_hugetlb=5Fpages=5Falloc=5Fboot=28=29_when_max=5F?=
 =?UTF-8?Q?huge=5Fpages=3D0?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "osalvador@suse.de" <osalvador@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250814082950.2888-1-lirongqing@baidu.com>
 <7e88d01a-10bb-4edb-9010-f9c0bca31a46@redhat.com>
 <8db5f7f3b66a40af8abf921290db42ab@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8db5f7f3b66a40af8abf921290db42ab@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 11:12, Li,Rongqing wrote:
>> On 14.08.25 10:29, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Optimize hugetlb_pages_alloc_boot() to return immediately when
>>> max_huge_pages is 0, saving cycles when hugepages aren't configured in
>>> the kernel command line.
>>
>> Do we really care?
>>
> 
> I find this when I see the boot log, I think this log is unnecessary if user did not configure hugetlbfs in kernel cmdline
> 
> kernel: HugeTLB: allocation took 0ms with hugepage_allocation_threads=32

That's valuable information to add to the patch description :)

-- 
Cheers

David / dhildenb


