Return-Path: <linux-kernel+bounces-733483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDAB07539
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3F97A6376
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9E2BE62B;
	Wed, 16 Jul 2025 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdXyvra"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A51FECB0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667227; cv=none; b=N3jqswP96UJC4xftLS7frMurDDOpMbfRLntw+hHc9meMK3n/AVyx+Y3E5+PrU3v3ILxViAtJVrQSVkyts/xcsXqr2KCYxDTAvAMFojr4D8IRsqYq7Piu8rXQQuhgeTVK5O82qF3tzfx2FJfenBmz3kNXpz/x5jsFPRYhNIwfx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667227; c=relaxed/simple;
	bh=ZdrK0uG3HSk1MLjmqaQld2aJ1Y2UR/DK/4xgytvIuSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAqPAvlSOVf4ia67zVPZJHF4ptibZEi8hJMGrzMyJGDIRMHWUT0PiQ3uQ/bHxKMUl+WuwJM6dyqNE6xFemzsgE6WGYRkmJl4FyrdX2/95wBXHBtCTpRalacidUZobaQZBDe8uMUmWeOXL2Z+rjGhTcdl8mgU91nj7zlA2WOnJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMdXyvra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752667224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NZGS509OAuS6DGi+VhKHSVscGHN/M85uWnIcfcik1BA=;
	b=iMdXyvraJDh1RgM0PnDj92qzXcGX4q4ofaQLI7BMRYXl5Zo+p95fGk9e4/ZVgOMToKO0KY
	Iybw/vKWcu/zYrCrmtB0YGlT0IK9kZO82SAQnrPZ4J4faW8JBro9a2M5feijhfE40byE2Z
	g0ax+r6F0dMARLqoXXEH3F0UvUWfOoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-0ONuUlknNMOKhUi0JG51yQ-1; Wed, 16 Jul 2025 08:00:21 -0400
X-MC-Unique: 0ONuUlknNMOKhUi0JG51yQ-1
X-Mimecast-MFC-AGG-ID: 0ONuUlknNMOKhUi0JG51yQ_1752667219
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso1626925f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667219; x=1753272019;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZGS509OAuS6DGi+VhKHSVscGHN/M85uWnIcfcik1BA=;
        b=k0Fjez0l5q4eSEee+ChndRlhbDJ2klbnqCitMwRb7U3dVC2aGth1PPY1v7kZP1pOua
         6fluv2ug7MnI7kP0mxj6aoSGkordQ9Xnkou6GrvzJQ5aFF4Kn1fooDGLK6g+0NDyl2MD
         I+R7HHJSxRZBwzYWWJ+FAgRgpTQweLspSDlkn9AIFSJP6SJPiXhasIvtZa+h79Z8+hfb
         zvzqRbn9zEHvvxJrmxnrkeLyiEx6N5HDRcpEfgCWBW8nQ3pRaxYNXz7LXsiAUnPi+R8C
         k1XsjQp5lrg1QlH/8gXJy07waEDkCN0L3qxsA8vAdNmZQk/7pTQLt8/VE6JX4m5L/MIp
         6bzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnD1YMHj4DXgqBwVanGTFEj4ApZzC/3yG/vJYBJKQ+2QGO+EMGGSSLorK1MRbT6gP6Cn58CE4nK8Fx4uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9aKRR76SmxsEfHj/OX/ZYjRbPXlJQ1IEI/0awcHoum9kcwxa
	6Kaa8aQjqHYLIT7jZXjjCXBQF9fCHVwUNZZXqwBGnr1cfXcpVGQi+3T6Lss116Z/FekFitkz7Am
	cAQ417aiAXOu/tRq197L//txuuW8LQXouIavPQ8XGiAW0liiI0REEHXXPn0jRxRxsVA==
X-Gm-Gg: ASbGncvF2CEluiGc8Nz1mTvgSAaDN5BAIvLC2Pi/BFjmLRH8kPcdXkHL8bBV6v++zLh
	qqZWKK+Kdm6ERP6pL28DnfAHdO6UboSNM5n0upyDAgTCmd6cpSHHiIAd2HOIGm3uWrDngHatiNU
	V31bD31SOBDKAftBquo9jssyclVA0uS2wDDxojX1wYbptWkyOLn29RttZrlRpBzuaT8KArC1nW8
	Dl4Kp56INU5E/TPatiaMmFtsPx9KnTpMsfhMixQ/WRDW6ECz0D/Qxn2l2udYdh+KfQNwvhr+Yza
	/yk4bbwG/katJ+K8u1d9XqzqGsTOGcJmyKGasiyiEGnXBU2FyffhnsTK8mmBnJF+YgX+5F7tMpY
	xuDzI
X-Received: by 2002:a5d:584e:0:b0:3a4:eb92:b5eb with SMTP id ffacd0b85a97d-3b60e523551mr1501673f8f.50.1752667218994;
        Wed, 16 Jul 2025 05:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHP0jjFAj0Zqi0r/or5ueHV4EclVJNHBN87ooqr8KpJs72tVFtqV3nbaN+iQJnw9K349aoew==
X-Received: by 2002:a5d:584e:0:b0:3a4:eb92:b5eb with SMTP id ffacd0b85a97d-3b60e523551mr1501641f8f.50.1752667218492;
        Wed, 16 Jul 2025 05:00:18 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net. [47.64.115.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d77asm18052863f8f.58.2025.07.16.05.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 05:00:17 -0700 (PDT)
Message-ID: <568bd74b-10a5-42cc-b71d-0c42a7b59297@redhat.com>
Date: Wed, 16 Jul 2025 14:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LICENSES: Replace the obsolete address of the FSF
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org
References: <20250711054548.195276-1-thuth@redhat.com>
 <2025071620-economy-unifier-b5aa@gregkh>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <2025071620-economy-unifier-b5aa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 13.38, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2025 at 07:45:48AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The FSF does not reside in the Franklin street anymore. Let's update
>> the address with the link to their website, as suggested in the latest
>> revisions of their licenses.
>> (See https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for example)
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   LICENSES/deprecated/GPL-1.0 |  6 +++---
>>   LICENSES/preferred/GPL-2.0  | 10 ++++------
>>   LICENSES/preferred/LGPL-2.0 |  5 ++---
>>   LICENSES/preferred/LGPL-2.1 |  8 ++++----
>>   4 files changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/LICENSES/deprecated/GPL-1.0 b/LICENSES/deprecated/GPL-1.0
>> index 3a4fa969e4c29..8d0a75431f06d 100644
>> --- a/LICENSES/deprecated/GPL-1.0
>> +++ b/LICENSES/deprecated/GPL-1.0
>> @@ -14,7 +14,8 @@ License-Text:
>>   	     Version 1, February 1989
>>   
>>    Copyright (C) 1989 Free Software Foundation, Inc.
>> -                    675 Mass Ave, Cambridge, MA 02139, USA
>> +                    <https://fsf.org/>
>> +
> 
> Nit, this change, differs from this one:
> 
>> --- a/LICENSES/preferred/GPL-2.0
>> +++ b/LICENSES/preferred/GPL-2.0
>> @@ -20,8 +20,8 @@ License-Text:
>>   		    GNU GENERAL PUBLIC LICENSE
>>   		       Version 2, June 1991
>>   
>> - Copyright (C) 1989, 1991 Free Software Foundation, Inc.
>> -                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
>> + <https://fsf.org/>
>>    Everyone is permitted to copy and distribute verbatim copies
>>    of this license document, but changing it is not allowed.
>>   
> 
> Ah, wait, that's what the FSF did on their site, ugh.
> 
> How about make this 4 patches, one for each file, include a link to
> where each of the changes came from (you only have one link in the
> changelog.)
> 
> Just to be explicit here.

Ok, can do.

  Thomas


