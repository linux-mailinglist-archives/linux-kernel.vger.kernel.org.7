Return-Path: <linux-kernel+bounces-823400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BEB86536
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79D9545B92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB0283FE9;
	Thu, 18 Sep 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qal8okf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C514B06C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218035; cv=none; b=uH8hsgJg8mTctjmBRgmz7qO3yDGRuT7WGXTmMyHgBOZHdgeQmDdem/eM/HwC67zGdp8jk4npsKwVgpDADHXahE6DYmZWnuL55kQFX1I/f4rVO+kyfpf7jOqm/Rql/bUcbyxaqbLMNXM0eS9hp8PkMDpXvfARZi7yOLTU2jzAvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218035; c=relaxed/simple;
	bh=gnXD3M1w7+Bp7PPImCYngw5A2VusuYP3GUVqMzt11Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKk1kOwLBGftfHb67A5oVSPcAhhT+is6p1WcLTxwkt8fKMmqF0H6Zaxuf4U0fi3HUPDiE/q90IDs7VWDyZRGCa4MZ3z+sKjzMFtd4Ifxw+gRgiwD9fmkXgLJY2kq6qPHhS5LEXO9YROA0fAaOeagi8b2tQt/UW0d4GPTHbg9278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qal8okf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758218031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UOGyHUePXUSTkgL6T5C6Zo0wP3Y1TdpMhWHXKu9OKzo=;
	b=Qal8okf2dKOHtEaiZlV5ih9JsLUTpQBjUhCgIbdq9LsblfVgy87xNMv9VF1e5rpr/Zp3TM
	+HMa8wujHyuOr8X1smBU5DUXl4kAbujB8cbu956FNa8FOUPuaeVuJawAdS+0Ah2TxNJ+8n
	tsnctRvyxQ37hAB+VgczRhwhFsIsr70=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Zb0El-Q7Ng2ErHNXR7H1PA-1; Thu, 18 Sep 2025 13:53:50 -0400
X-MC-Unique: Zb0El-Q7Ng2ErHNXR7H1PA-1
X-Mimecast-MFC-AGG-ID: Zb0El-Q7Ng2ErHNXR7H1PA_1758218029
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso9610345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218029; x=1758822829;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOGyHUePXUSTkgL6T5C6Zo0wP3Y1TdpMhWHXKu9OKzo=;
        b=v1zXSdW9ocMxfeUYwTARtUNib5C7XaMAanVp7tR+fWEeGoJgyRh+eqxJWIiaKcTk+k
         61ODwPEhLf2AEgR58JMQJ2adAkDghswY8sqjJDCznUwSnGe1fYq4LFPCGQj7o2NUsAkX
         siNaidc/IzhwADRtnB6xcM9HF3AGipwgaY3C5RNm8CpstKKFGy8IuGHx5j2Tdm6tvkvv
         K9uBpDtHvULSa2lI2hiBXf5I4vKqKffLQeDYpPpsb9V1wP3h5Sk80/F8ovftxAwGP+1K
         YkYm6fFpauCDjJ6EJv1bTm0Eyu63UmEhV5q6zKr4HoPNrxgXYzo4dYoZeSPAk5T/2e68
         LoAw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FAG5tEvY2/BIo5ZbGwU9+NYQVVy5dTEGLpaGXx/9Dp3B7mAdFbLoNI4SAaRppsbC2WS2DtpbKw1RXIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbvdPExFJoJ0bO3AguGzNzU1dS6p1OYQVl+WiHqYCq/JfZcE2
	VUKQKQtmY0apzPYsGv2vvEtc/RngtoU3dqBfeEUY/QyL6ZEGg3fC02aDTUTvodAG4HoYeGNLyQl
	4PjowdfmqaqWe3uFDiJBnf5gGpI+zCvVGgVzAw89Z+GCq4mmTP27c96IF3grazNE+hA==
X-Gm-Gg: ASbGncvGelT+eOixJLyjQSuDM6zfNQkq+BvycBlnsu+7nKAMkPi/T51hayiEl2jhzdI
	U4edsV+VvdF4gvwYml0DZc8AtGq+CXA4Ju02Qs2G0daXN0Nq7TnEVk2vGzPOasYAjxGEREe8sKM
	dN4As2uoi/vnJIuLDTBMseYm2as0GxTQ3kau9zW9SIjBcfss38y0IndpTGwKXLjtlaEUh0htfm/
	YCJRnLbJj3SHEzEEzTfd3cmAuddk9AzJGjXjSduohDIpLVux6GyFhaZgaBVhKzlUSSCTPXhj8ti
	NdK+Hstuo5B6IIFysehP6Cr1zKr9eUrTA0Yn48YUnROYtmX2w7OGdXQN+seU5oUGmhk7a6sChwK
	1YFBycS4mOHwq+qI/itWTnDjL2m0BfivNlV0DKw/TeNAaODmwMJHurX/NL2ivhDPY2kFw
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-4652c9ee679mr34100145e9.9.1758218029199;
        Thu, 18 Sep 2025 10:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsPNevUVmagPBLbTVnqFKQoRMUe2XIHZTkFltgj83DMjpa85O1tzzT/oNH+xW/ayF49guR1g==
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-4652c9ee679mr34099935e9.9.1758218028737;
        Thu, 18 Sep 2025 10:53:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbefd5csm5098723f8f.51.2025.09.18.10.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:53:48 -0700 (PDT)
Message-ID: <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
Date: Thu, 18 Sep 2025 19:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nikita Kalyazin <kalyazin@amazon.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>
References: <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 19:45, Lorenzo Stoakes wrote:
> On Thu, Sep 18, 2025 at 06:15:41PM +0100, Nikita Kalyazin wrote:
>> The other patches it I was building on top were mmap support in guest_memfd
>> [4], which is currently merged in kvm/next, and also part of [3].
>>
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/tree/virt/kvm/guest_memfd.c?id=911634bac3107b237dcd8fdcb6ac91a22741cbe7#n347
>> [4] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com
> 
> Note that the mmap implementation is changing to mmap_prepare. It's the
> case in point example of where we exposed an internal mm object (VMA) and
> experienced significant issues including embargoed critical zero-day
> security reports as a result.
> 
> I took a quick look at [3] and it seems you're using it in a totally normal
> way which is completely fine, however, and it'll be very easily convertible
> to mmap_prepare.

Yes, we'll take care of that once it's (finally :D ) upstream!

Re Nikita: If we could just reuse fault() for userfaultfd purposes, that 
might actually be pretty nice.

-- 
Cheers

David / dhildenb


