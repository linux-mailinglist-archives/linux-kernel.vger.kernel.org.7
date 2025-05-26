Return-Path: <linux-kernel+bounces-662812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E2AC3FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 14:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35AC3BB84E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9A15E5DC;
	Mon, 26 May 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk39sru+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C220010C
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264245; cv=none; b=MWkX5SeTgGvGPHdkmFZeJbC3XC0r9jrANBE2qzU32Qbifab4ZtfiOWqPf7T69ukQ3V6wgJ26hj2QHKZYom+8j1k2B8kZpTp8/D9I1spz/bVhc1/NIUavz+usa4JB+38dxPvH1IgMLE3MbP0fQbmwHpA34dHWKlIf8SfeOjGZJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264245; c=relaxed/simple;
	bh=n4huyPMO4/X42xZu+9qZoHMd+IX7dk0uovDPy4AF9To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvbTDl3L/4mNgOui9KUku9YxM94Ue1NRF/SzKp8GkbGLeI2eCryZ3fQnBdfkwBWjAomHjKf9YOitU7jtlt/u4PSfMmgORlfmkHQZJjuAydhrZUybwUrNlBNHRcCLbc/A5Znx6ZS4dPcfmmolqvDjor9iqwiyKf8dTGr1Nn1JcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk39sru+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748264242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WL+ruCNUWwEKdiiLFkuRLW2VoKFDdxUqIK4QLCM8Sgg=;
	b=Mk39sru+yaa9oXrrKuhWMY/IrD8D3thG7Bru+Fy27jZTtZs/7p+of3QqHPF9XZ39ol9Kkt
	cdj3wTMwGbBfUiNvBpftx6P7fLWmYGMidDdeRdJJKdqE19xWGVWraedNv5fj9/IIAf5/gX
	zRY2UqkbrPnqUShlQ+1edelauyt8gy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--WToRrkQO-2sjHuuelOo2w-1; Mon, 26 May 2025 08:57:21 -0400
X-MC-Unique: -WToRrkQO-2sjHuuelOo2w-1
X-Mimecast-MFC-AGG-ID: -WToRrkQO-2sjHuuelOo2w_1748264240
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso16476245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 05:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264240; x=1748869040;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WL+ruCNUWwEKdiiLFkuRLW2VoKFDdxUqIK4QLCM8Sgg=;
        b=ZoZTw62SC9DtT2IacC8ukUnvs5JWQ6l/cJeS4NB9gUd4DDHRtxi1TSfxbzhAfhNjfJ
         K8r3F7sXKLB5e4Cw7yhZt0H6Cm752xyw7R1Z8lShHG79XB3+xjiwgeDu+9H6je4dB4Jp
         qLSHuJLquevyvSkBeaVFrVlcuFtAO3jbo0vqK/h4A4M+ltH5AowquUiwuH14SfIWoOKF
         FdOBULy1NPiY4lUtNnRseh0KG7+rpwZWmwkHlReOCGjyKVXtXAZVUA1zeabgkT/1vTu7
         p5MdgdpZ5UuSrReOnbhFL6klyLBiqAuZfOMjNjjTY8EcOesWhntDAcofS9VgHnNYVcpT
         p6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXjRg0fxRvRj+uTzky3qg58Ama1phswWNMliQudUlxIuWtPvWHAQDxrsk1OJgMVaTVoJtBkZ+M9YX2oQmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9Cvp+vNIpnfBI8ocQjygd1LSVIk+3RSC9zKsfUXSavJQdhBU
	B0eNxFX6/qrb6k+guDdmMIaaPqcxtSMGjtN/cZ2FH7aDEivqmbICuZ2kr5hkg16ZrKdoiugIIiy
	498SOPAbtntF3fNMS2GrZ3eDa7+gO8jWRhll08ARsI/nwXtdIspW1OeQPrhxrSjWKvg==
X-Gm-Gg: ASbGncvHtLGM6aI/BS0XKxbR7UEAM2zSmPq5306oQTfW1LvTzhhWQCNjraLC3uyIvV6
	1rit6dClKW69Zyi8x7y4anlj+5Y77ryyflwHVivInEeOnMsljUYPbRHavJwdCdHxuusfpfnaQPB
	SUKXclDtuPI2pfYKDYv12zLPgnhYeRHXKhzOX/BgHQPq6xBxM74htzXBPMOltMglr5+3r0VjhDv
	NlsT5HlSefIYhjZSEB6j9LeV88FX8EKrYQ0rsVCzlE6R40laz4e/jR9Ec7frt+lrqaCDr4Cypoe
	ijKv62AKaidMvgdsSlrsAqN6+m5KhTueQtsAveAcyYRIB8RkdqwoSmOO61WEE7MwP6Bm0K8E5VV
	Gupe7TUttAMy7Kjq+LWh7tvmaFzomofNHig029xA=
X-Received: by 2002:a05:600c:64c5:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-44c935dbb26mr88081775e9.30.1748264239761;
        Mon, 26 May 2025 05:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsj2yVg6GQyvPIsfBqR6TicSZOd6Jk+h3Evd8KqH3QryvnfOsfvZJ4MBvT1e9QXcVH65VfsQ==
X-Received: by 2002:a05:600c:64c5:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-44c935dbb26mr88081405e9.30.1748264239355;
        Mon, 26 May 2025 05:57:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78b2f19sm232109465e9.32.2025.05.26.05.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 05:57:18 -0700 (PDT)
Message-ID: <955fd396-10b1-48cb-977d-74f3e158b1cd@redhat.com>
Date: Mon, 26 May 2025 14:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>
References: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <e4d9dd63-5000-4939-b09c-c322d41a9d70@lucifer.local>
 <x6uzxhwrgamet2ftqtgzxcg7osnw62rcv4eym52nr4l6awsqgt@qivrdfpguaop>
 <9433c2d6-200c-4320-80f3-840ca5e66f64@redhat.com>
 <uhla5o5xqshcrihc5gpkqqyoplj7hxrbptp6prmwd2mh3ikw4m@m6apbkyfny6c>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <uhla5o5xqshcrihc5gpkqqyoplj7hxrbptp6prmwd2mh3ikw4m@m6apbkyfny6c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> To summarize my current view:
>>
>> 1) ebpf: most people are are not a fan of that, and I agree, at least
>>     for this purpose. If we were talking about making better *placement*
>>     decisions using epbf, it would be a different story.
> 
>  From placement decisions, do you mean placement between memory
> tiers/nodes or something else?

More like: which size to place, but it could be extended to other 
policies, maybe.

Assume we have a page fault and have to decide which size to place.

For a process that we really want to use THPs (VM_HUEPAGE?), we could 
use the largest free folio possible.

For a process that we don't want to spend valuable THPs on (VM_HUEPAGE 
not set?), we could use the smallest free folio possible.

Such a possibly might be encoded in an ebpf program I assume.

The hints (prioritize regions/processes, deprioritize 
regions/processes), such as VM_HUGEPAGE, inputs into such a program.
> 
>>
>> 2) prctl(): the unloved child, and I can understand why. Maybe now is
>>     the right time to stop adding new MM things that feel weird in there.
>>     Maybe we should already have done that with the KSM toggle (guess who
>>     was involved in that ;) ).
> 
> At the moment systemd is the user I know of and I think it would very
> easy to migrate it to whatever new thing we decide here.

Agreed.

> 
>>
>> 3) process_madvise(): I think it's an interesting extension, but
>>     probably we should just have something that applies to the whole
>>     address space naturally. At least my take for now.
>>
>> 4) new syscall: worth exploring how it would look. I'm especially
>>     interested in flag options (e.g., SET_DEFAULT_EXEC) and how we could
>>     make them only apply to selected controls.
> 
> Were there any previous discussion on SET_DEFAULT_EXEC? First time I am
> hearing about it.

I think it evolved in the discussion here from PMADV_SET_FORK_EXEC_DEFAULT.

> 
> Overall I agree with your assessment and thus I was requesting to at
> least discuss the new syscall option as well.

Yes.

I am still not sure if having a new "process" [1] mode would be a 
reasonable alternative to setting the VM_HUGEPAGE/VM_NOHUGEPAGE default. 
Assuming we would have a "process" mode, we could (a) set the policy 
per-process using the new syscall we discuss here, and options to (B) 
set the policy to use for the exec child and (c) maybe an option to seal 
the policy (depending on who is allowed to set the policy in the first 
place).

On the + side, we don't lose hints/instructions from the app 
(VM_HUGEPAGE/VM_NOHUGEPAGE) when changing the policy on an already 
running process.

The problem I see with the "process" policy is that people might want 
different "default" policies for processes, which means that we will 
have to add yet another toggle.


How I hate THP toggles. :)

[1] 
https://lore.kernel.org/all/CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com/

-- 
Cheers,

David / dhildenb


