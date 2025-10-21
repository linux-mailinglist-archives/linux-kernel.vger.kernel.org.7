Return-Path: <linux-kernel+bounces-863264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA3BF76C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DC188737F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122F32E6A7;
	Tue, 21 Oct 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3Vt+tK4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85733355054
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061078; cv=none; b=g/b5JF8AQl7bofz9p3kMMkcrE8ppa26dEewauBNOaIvcCpGFV8kttfJ6e1YAKLEZO6E4sX707qqFkMGE3KdgCWEyHSCMRHwW7ZLesqISqCa6ehBbGNDks+nUpeaycSmlPXdKc1HCMHNHIrVku2jpPfWkAADz7DG+PZ1NyB2kQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061078; c=relaxed/simple;
	bh=8sJl3kVKaUChUtEmcByVQ+X5gAV5wcgI3nIvexX4qbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHC7HVml5YotwFh/knieT3dt7aAUnvuXLSTBGtnlz1J//ibOqPj/AmPXkyT7Qhf7qXVaspAAwdZkzKfWu0SaJyc9tLh1cN6XS8n3p2m4RbVhVE5QsS+ga8DLm+cDBOjLU9PI9LzOSqR7kLtYhqSQMs4XEMYPDWt9IZWqcd+FMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3Vt+tK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E/7c5A5jjBJdHFU5IeWULrzoKt5LxZ5pQlNBoEOn3xM=;
	b=V3Vt+tK4eIBZh7vQIztje4geFZtKhxZ/WLWMdNmbY7Px7jXumQafdveKF5xRBWy+1Cgy72
	mp/WyEmujxO3LsPh2q0ANr7kibPNoTrD2Aps0ahD0E8e+ygC1mgI/4N+1AflkNhgquGKNH
	BBIXzZBK6h2E5ZjklyOn2BuLObAcPew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-BVeKYsm8MeO-e6KBwJqcNQ-1; Tue, 21 Oct 2025 11:37:51 -0400
X-MC-Unique: BVeKYsm8MeO-e6KBwJqcNQ-1
X-Mimecast-MFC-AGG-ID: BVeKYsm8MeO-e6KBwJqcNQ_1761061070
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2991964f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061070; x=1761665870;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/7c5A5jjBJdHFU5IeWULrzoKt5LxZ5pQlNBoEOn3xM=;
        b=p5Kb4GrJ5X2Q46Pupn2PyZ5P7rCg1p1gJgdGvRDo22CtsgfBEe1ZGnEokrEMOta8w0
         1UcuFGO126WgzWsETdO7xbVReqpktxH+TmpMJUb92mLe38h0ufkIeg2UHpvvsqVPWoZJ
         q5g8q6XXk+x4d2AHxBKhdd3Zx5H+n+gkM77oLC7VGHgqxITZqQBgkGzmsr6/TT0AFk1k
         ZsUGHX/UO5HA0EZwoGMqtMvqmDsCnVBcAMYxoFx0C5cFHM2TnKGStQMEMyBbYIuBdXTb
         M7Y3l10aC6drXNk2N6MXBDW4VJDwfmOTGErswGGfujgKjsr1A7+jugZMZrW1czLT7Avj
         x+yg==
X-Gm-Message-State: AOJu0YwEeGkiWkCzx2t9uWeBIaymbJuJL5L3tojN7p+smGTqpvEd1MO3
	ouK8+hokzWVlc8sbTHHQxySBpt1y4onIOC/5nWNKYtLp+Km02uZUt3OtDSUeybtuU25gjWVVplH
	DQ80Lts4hkzCWz8JTrVgjFsM4kkM6fvMsD/X9JKsCEKU5KvzaxsAAgCfWj3CFzb8fsQ==
X-Gm-Gg: ASbGncuAXPQEYGKLPZWhx5s9yTOn5txTieJkwp3b60V07/M8vxe1gHxwlZmbHWGR9M0
	Xf4emMCE4V2ivfE0DVO5zNuDzRkPK6D6tmlvMn8ZqJOOnvughLoTDxvsLeqvH8UCCCnVkCGT0pf
	6ngV5eLikS10rvVEJvHhckmrJsGPKAvnFVuZeViPwpCTLvvytgP3PXDA0Aah3yJB45nc7s9vgkp
	uhfT5/ifMgTMQ3RF64F4rsiQqaygPZnE1GrXDa3mosA8vFAKztRq05sty6QjM+nAWoE0xcs+Fwx
	8ctyBelKy+khhzY6fuNSOnOGleQO9LSar6SPcp3brNk7x9hiAs0u23mjyThKSZv6S3oHP6Tg145
	n3jEa98ZqXMURuaMNlYsQqKVvDXTQZPJeLWbSXC5eBhdVZjCjq5f1ABgXy+TPn5kCXNGxT0S3CL
	CafHTbDBJ5QI0BzNee2kv5VSl+GJM=
X-Received: by 2002:a05:6000:2dc7:b0:428:4354:aa36 with SMTP id ffacd0b85a97d-4284354abd1mr6785969f8f.58.1761061069823;
        Tue, 21 Oct 2025 08:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8Htnc2zerYOltHWq7nqPdBH+VgpCEEL3l5nIU7iiXfnT5bpNfFWhrGmLn4T4UZuxhmt8jQ==
X-Received: by 2002:a05:6000:2dc7:b0:428:4354:aa36 with SMTP id ffacd0b85a97d-4284354abd1mr6785942f8f.58.1761061069356;
        Tue, 21 Oct 2025 08:37:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm21478704f8f.28.2025.10.21.08.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:37:48 -0700 (PDT)
Message-ID: <79f01115-3c9e-4316-92d5-bd050eeb3b76@redhat.com>
Date: Tue, 21 Oct 2025 17:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/23] mm/balloon_compaction: move internal helpers to
 memory_compaction.c
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-15-david@redhat.com>
 <C2893E27-CA03-4416-9444-62929A740691@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <C2893E27-CA03-4416-9444-62929A740691@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 17:36, Zi Yan wrote:
> On 21 Oct 2025, at 8:59, David Hildenbrand wrote:
> 
>> Let's move the helpers that are not required by drivers anymore.
>>
>> While at it, drop the doc of balloon_page_device() as it is trivial.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/balloon_compaction.h | 44 ------------------------------
>>   mm/balloon_compaction.c            | 38 ++++++++++++++++++++++++++
>>   2 files changed, 38 insertions(+), 44 deletions(-)
>>
> 
> In the email subject, s/memory_compaction/balloon_compaction/

Indeed, thanks!

-- 
Cheers

David / dhildenb


