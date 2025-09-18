Return-Path: <linux-kernel+bounces-760212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD30B1E7F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDD7A4C33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BD275B17;
	Fri,  8 Aug 2025 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akUrPm7s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1E274644
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654659; cv=none; b=saCvI8abTjxPN4QI6Gb/399Tz0nAKuUTLM6bWno+dML2l4I1ujqV4JB1J9MgnvmevT60a3Fwok0qmNPoa8dnvoAeSI76nP7nGgQIypiADaYol1vkQqoNgh1VGWl5LJw5Xdi830azARZx8zSC89v7dSSCX/NVp3vZd0kpi6LNe4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654659; c=relaxed/simple;
	bh=2hUqHfAXwKZiKWo86nSIb3YgPmVYqFuxkDGtlWV+fcE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MBuO+eKfUvgv6CiqYJcKo9M0I1pLFqNX+lDO77CQ6X+t1yUnLh+YqDzqppFzwS//868odWO9ZGyugf/ldQjVzQiLfp8pY1Df9cEPiMGwDUpGYHvb/8fgN6a+lKSBXeshPDhFVvqcGILnKfCzCg3jRXJ/EJU4pwWuBYvmyIgz40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akUrPm7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754654654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zwu6G7Ii5QU8d8/PJEe2bFkrnM3wNVgvTkgXDIIA24U=;
	b=akUrPm7srZIHztpQSWzeTD/C0keAhnkrtJdaWEjcEOFYc3sp3YfsUGqFctl9bNI9zVnzHW
	c77BK7MQjxwjHVrlvqSja6fmjXYT3WU0to96pGO9UUGM8nAmCXiNI4qsqKv+hRPtfExa/N
	OFO1qELs17a/pkaKYFhlnw+AXbjPy7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-v0_SCo6sOiOEN44Q25fsBA-1; Fri, 08 Aug 2025 08:04:13 -0400
X-MC-Unique: v0_SCo6sOiOEN44Q25fsBA-1
X-Mimecast-MFC-AGG-ID: v0_SCo6sOiOEN44Q25fsBA_1754654651
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b8d612996cso1400634f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654651; x=1755259451;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zwu6G7Ii5QU8d8/PJEe2bFkrnM3wNVgvTkgXDIIA24U=;
        b=gMD0XFBa/UnMisUizSH91oE0tVHAi67urbe756/XhZxMJ186XPklyiWwimuGZsr00e
         yv/aLG9BxZK3ybeFLFMgAZSSooFpH7Ehftu1iik/8eVdw2dsZayJ45K2VUVI6bpmvYSD
         XscOO/nHvhSm9yPLhoE7ze0GK1vmXU3JU3nmg2GhL4I5+hAIoMRkQZKsqTknmwVnaJxC
         5Ze1yVkHpFkVLsQgJOIve4TGqH11+xZ48QqoBSBolhMBaU6FK3nzDu6scvaLWAW25bTG
         SDoWPQa7pUfoRF3HG7QEpz3kk76ioTnNrKDE7sl+ONwDgZ5I7LPcSTRyZR95UVLiJe1n
         M12w==
X-Forwarded-Encrypted: i=1; AJvYcCUf9tHePRsYC2yza2PLEeHUI06+ACqWul752QoEgrpiaGMZC5fQI+4lBgiLhF+DQchDYv0t+hezXQkvAW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhGvn1eMoJI5luUsqRuXqk5d1dZh9Mi6qyDeQrvWys57Q784x
	8CtAZLGKcksxHRZwu3ck6a+U2OnP/BP1/x2m/DhSXft3SDYe9vXrGpmUzfnJInoXgzehEkTUy7G
	00nnEM10z4l9E5e1yUcqZOpie8i48Jq431zRcb6hflXiHtYF3Niev3vqLRyNRn8xGcw==
X-Gm-Gg: ASbGncuhRCXtprYfQBc5/AxEcRj02z7d/lH7mNCk5dC6bt+aETqT55eHfnAkHVHwh/z
	wVEmwTMFL2dIvK09jftLbNTUZgnLQXqs2OvZDcX8AG+XvrkeNA5ckZsBl6xqCxQDzMxAZyX5Boc
	hWsd0+5ob57ve2EHFt3wMXgINa03VEFKaL/fgaAP+kHQL4xeHTlyMFYrYD6aghm6z74FqG5xCwF
	B5M9s+paP6cAue55LHwP162Keq+CacqjJg6lImGc4tIQU16VKCzD0K3QMxe4Eji0/BLs40uiA6c
	KAPQuyMSeY7EqReTkzvXLYAKZ5kQHI1tSDiGfwUMXYUdl6oYwF93EiVE6nHDrhpKwcS3oeZTEr/
	POnMpWwz9sgdeWDY8NEMr6sacAXlQs5PnMYFMSICOkHi4rXz9UlOh0VNg8n85gbcD
X-Received: by 2002:a5d:584c:0:b0:3ab:27f9:e51 with SMTP id ffacd0b85a97d-3b900b7372dmr2231295f8f.31.1754654651310;
        Fri, 08 Aug 2025 05:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqRYrS+0vMhQvwrqWQ1DB5e6E6G0Sh4yj3+7JQX/SujKga6eU3I3HwTB9e6wBtYZ/R8Wh/Ng==
X-Received: by 2002:a5d:584c:0:b0:3ab:27f9:e51 with SMTP id ffacd0b85a97d-3b900b7372dmr2231236f8f.31.1754654650483;
        Fri, 08 Aug 2025 05:04:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5ca8ab7sm9095974f8f.59.2025.08.08.05.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:04:10 -0700 (PDT)
Message-ID: <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
Date: Fri, 8 Aug 2025 14:04:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
From: David Hildenbrand <david@redhat.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.25 14:01, David Hildenbrand wrote:
> On 08.08.25 11:21, Charan Teja Kalla wrote:
>> It is possible to hit a zero entry while traversing the vmas in
>> unuse_mm(), called from the swapoff path. Not checking the zero entry
>> can result into operating on it as vma which leads into oops.
>>
>> The issue is manifested from the below race between the fork() on a
>> process and swapoff:
>> fork(dup_mmap())			swapoff(unuse_mm)
>> ---------------                         -----------------
>> 1) Identical mtree is built using
>>      __mt_dup().
>>
>> 2) copy_pte_range()-->
>> 	copy_nonpresent_pte():
>>          The dst mm is added into the
>>       mmlist to be visible to the
>>       swapoff operation.
>>
>> 3) Fatal signal is sent to the parent
>> process(which is the current during the
>> fork) thus skip the duplication of the
>> vmas and mark the vma range with
>> XA_ZERO_ENTRY as a marker for this process
>> that helps during exit_mmap().
>>
>> 				     4) swapoff is tried on the
>> 					'mm' added to the 'mmlist' as
>> 					part of the 2.
>>
>> 				     5) unuse_mm(), that iterates
>> 					through the vma's of this 'mm'
>> 					will hit the non-NULL zero entry
>> 					and operating on this zero entry
>> 					as a vma is resulting into the
>> 					oops.
>>
> 
> That looks like something Liam or Lorenzo could help with reviewing.
> I suspect a proper fix would be around not exposing this
> partially-valid tree to others when droping the mmap lock ...
> 
> While we dup the mm, the new process MM is write-locked -- see
> dup_mmap() -- and unuse_mm() will read-lock the mmap_lock. So
> in that period everything is fine.
> 
> I guess the culprit is in dup_mmap() when we do on error:
> 
> 	} else {
> 
> 		/*
> 		 * The entire maple tree has already been duplicated. If the
> 		 * mmap duplication fails, mark the failure point with
> 		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
> 		 * stop releasing VMAs that have not been duplicated after this
> 		 * point.
> 		 */
> 		if (mpnt) {
> 			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> 			mas_store(&vmi.mas, XA_ZERO_ENTRY);
> 			/* Avoid OOM iterating a broken tree */
> 			set_bit(MMF_OOM_SKIP, &mm->flags);
> 		}
> 		/*
> 		 * The mm_struct is going to exit, but the locks will be dropped
> 		 * first.  Set the mm_struct as unstable is advisable as it is
> 		 * not fully initialised.
> 		 */
> 		set_bit(MMF_UNSTABLE, &mm->flags);
> 	}
> 
> Shouldn't we just remove anything from the tree here that was not copied
> immediately?

Another fix would be to just check MMF_UNSTABLE in unuse_mm(). But 
having these MMF_UNSTABLE checks all over the place feels a bit like 
whack-a-mole.

Is there anything preventing us from just leaving a proper tree that 
reflects reality in place before we drop the write lock?

-- 
Cheers,

David / dhildenb


