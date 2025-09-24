Return-Path: <linux-kernel+bounces-830422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED60B999DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4CD2A67C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A82FE052;
	Wed, 24 Sep 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpu/SJNS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA22F658E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713924; cv=none; b=gPWMD1Bo+kwwLU9pa9GT71+CC3bQLjt4oMaA0gWAaOutfabuKlfY8tevg/wLcCDV4m9GnQfx7uHqXzROxaL50GyvDxWlU+NY6BW9jgxo57CxVan40KF+ffNosX5kpVlbIie5ezIaGN/No5+kiIdmN7QF3nOCxXKJHvhm8iTvQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713924; c=relaxed/simple;
	bh=J3v5IQ691nfacZ0K5sXI9VNSI1lEh/iGp6qiQq7RHIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTPi6M/lxCg/bpKD4gA12k9nvnE91Xe7zs6DLqFc74i4Hzs5x7UbkvTgVyQWGeLbBBiMOssbx8/2xGoAIlDSvUWQGyt0oP20mmtETtxU0qqBuxPDJGFOcUEHeuxfCggP9MtEmEuY8j9RRKa1iNIzVfMXCmM16uUDBCCFzWD4Jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpu/SJNS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758713916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+nr7Ue+Q8mDfosTulm3J5UwQG5E9B4yAzAZ8LnR/jDs=;
	b=Dpu/SJNS/aGZtJtVPXgfzNuKL3nKNJt4P+c9jqEzuDtpUSjCyJi18a2Zh2+1F4k6LjoWwU
	X8dF+0FheDlu/nzRbaruhmZQLnsXghpF3ncuA7nMuN/5Qd6je/q4MgwTxm5NStcWBZCI3H
	ypRxxMBMdAGA7hU0rJidHuU8TIcFds0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-isWeBBiBPhya9nLiD86Nkg-1; Wed, 24 Sep 2025 07:38:35 -0400
X-MC-Unique: isWeBBiBPhya9nLiD86Nkg-1
X-Mimecast-MFC-AGG-ID: isWeBBiBPhya9nLiD86Nkg_1758713914
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso39773225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713914; x=1759318714;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nr7Ue+Q8mDfosTulm3J5UwQG5E9B4yAzAZ8LnR/jDs=;
        b=t2QgRXt1LrZSe1BclpyrgBuCw03oRoqWaDontLK/8AdEry7PR+lD1t0u0+yCMB1YN8
         5um9gmCc6eYxpiaCxvlUm7sTgDa9UAHN7/Vf1BCu3rdGa7rlPQ8w0qoZQlDuJ0MKWHEj
         6WMZSMZGT04SrvaK7g0NT3DSQxFXM5Q15qI5zgTH7EVRVGlBJqxX+I9sWM32eRXgQQHj
         F+28d8KN/4qMJUeGoQCZ+pWVVxAG8ADhmc7G7ZonlHbrDPknIlXs5nfMVcPGeh+n+Dq5
         +dsMiUTZRgitPcd5Q5ebEU4JIJpXrIZv/n60Oq8CDRA+7ZNm87g2y06ai0vvmZfM2gmH
         FxYw==
X-Gm-Message-State: AOJu0YyK9ziPE4e6NAuE2ebEegKWI+h8xDMTq5dYfm94K0BbwIPG5b5L
	dKF/ZY+ZTdgc7WHlW7zknwU8WQEWecE2ZTr907G9aedHnU3eQnuf5WHNpx0R/jY+mAHtHXxzAEU
	GIYQMoeyoQ0qtWVjUjmnwFioyWeB2OxtelmZ7SUb+pUT2i4mggGz5P/9g816681P15g==
X-Gm-Gg: ASbGnctv9lp11inKJRG1ZqCwKhdTWSp1tmJM8Rs0UYNwtPugmpI9hzr8eu0iaPDqL1m
	laybrOQ5hnhvLbpmICPH1tg/JApa09JLU3hSY3cPg7BYth+B6G08a9+U/eey0vyElFpskVy9ZgK
	Mzly9LVQWXqybn8Bx4wXxEVCzRUf9oQnknVqPtuZ+WfucjzTtNW0mAmREn2oRycoJTVPc2i8dzg
	w1ejOp7zyNoaUNYmNKjuLJSXuDqqp2ZDYDqIBrO3OFACEtEhqVY5kadIMAoZZNmHTtAaiwLqNJo
	5cLvaJvX3MFSdC4dO69kNClQ3rDZbZq+JnM3dDqJzIGaPbL9pqYM2ahsvrJd35cGWsL1Z4awM3a
	hCRIhdZGbYbt/dibwo5LklIzaPLx8YETH8PNX1xTJjIpqNSsgCPicuf2neLSgCn1kQg==
X-Received: by 2002:a05:600c:1f8e:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-46e1d98dfefmr81427405e9.16.1758713914074;
        Wed, 24 Sep 2025 04:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDyoQr1XMCzLogNb5hrirQ5E/He80PBLPI4tToWKtH2OlAXQ+KTAg/KFfVKjMR/pGFLjp+xw==
X-Received: by 2002:a05:600c:1f8e:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-46e1d98dfefmr81427215e9.16.1758713913699;
        Wed, 24 Sep 2025 04:38:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aadf5c9sm28867015e9.19.2025.09.24.04.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:38:33 -0700 (PDT)
Message-ID: <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
Date: Wed, 24 Sep 2025 13:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>,
 kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250923170545.GA509965@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Two more points:
>>
>> 1) Security lockdown. Security lockdown transforms multikernel from
>> "0-day means total compromise" to "0-day means single workload
>> compromise with rapid recovery." This is still a significant improvement
>> over containers where a single kernel 0-day compromises everything
>> simultaneously.
> 
> I don't follow. My understanding is that multikernel currently does not
> prevent spawned kernels from affecting each other, so a kernel 0-day in
> multikernel still compromises everything?

I would assume that if there is no enforced isolation by the hardware 
(e.g., virtualization, including partitioning hypervisors like 
jailhouse, pkvm etc) nothing would stop a kernel A to access memory 
assigned to kernel B.

And of course, memory is just one of the resources that would not be 
properly isolated.

Not sure if encrypting memory per kernel would really allow to not let 
other kernels still damage such kernels.

Also, what stops a kernel to just reboot the whole machine? Happy to 
learn how that will be handled such that there is proper isolation.

-- 
Cheers

David / dhildenb


