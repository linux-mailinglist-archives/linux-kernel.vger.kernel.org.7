Return-Path: <linux-kernel+bounces-835937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6704BA8638
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ABC3A0707
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E03E26D4C1;
	Mon, 29 Sep 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjH5xHgU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D7335C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134311; cv=none; b=AgMJf1hKj/0bFMRq/ruYPw7qHR6jDhad5uTsAVscJRjdy45MzMb6kZhJP7ys/P2V1bNcGePcIgUCTggnXnHZjfkx7O2LWsLfzDCjFjpjqdq1oJEaYMtyf0JBLw4wfJCE9LukAThTKSlPLVc/piA7FJq+HHaMIEiwH5Ssail73mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134311; c=relaxed/simple;
	bh=VNpEpPmU974xq5w/WdAxo4MD8t3uecpoCS3rZQwaCpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVDZzc8l4C/DqLGlu3EXfeB/ZrIfmmkbC3Ey7GH2Nl57idvifexoSLZgqZEoKDqbEqLt/IhvZPnF8xRkAjp8rO7ARZ8qLOJ7dUUnG+99t57fw7nrvz8Qca+et48bbIIiTufN/wcTyHRSEzDgXge+y92PxV3zYNAHPHdXI9kA5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjH5xHgU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759134309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qftm91581EaAfNDOmtwxMDJauNlDbirPFRFWFFB7q6o=;
	b=ZjH5xHgUzXMSjjWt2tSHtXSvVMSuTQ/1L2yusSNU02ompGc20N8+Ea1ZOen55RDG5cv/Kp
	lM5IWkU1fWql5pcT8GvTnwi6WmjSaPUkFGPP6NqfsZIbmKR8oUQvaM2X0eEkxHSSkH5ims
	P+rVUJ9akeiwN/b6Lk5wFVfpTeOz09s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-n1cZFFgoOCKgVmX-wR9eMg-1; Mon, 29 Sep 2025 04:25:07 -0400
X-MC-Unique: n1cZFFgoOCKgVmX-wR9eMg-1
X-Mimecast-MFC-AGG-ID: n1cZFFgoOCKgVmX-wR9eMg_1759134306
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso2436858f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134306; x=1759739106;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qftm91581EaAfNDOmtwxMDJauNlDbirPFRFWFFB7q6o=;
        b=q6gVoaJMWxB1n9775+nTFrmtAuR59y/+UfmvwvOtFvooanISRbCv+mTHFlMjEl7d2b
         eCfsHyvbHu0zrmScCqM2K3zX5WyjG/MBXHDTqXJjM0QxeLKgFsMOY/JF7Hplv42P/HtT
         bWprHkslWZUPkUdlwcKMsS7hqBwVuwvncKxOBoFv3Br0y3YFYVcUrkgH4zZ+lxi1lgBm
         LRXWjKgHWSn5omQ/H4MY1CLkKnYwxVeFyJTm7aPVg87nhSMZ/9dTMiFXxB2W9xX5cqc+
         EsnZBGRrmQo9jkMpbqVdUYjeR2GggZbvz+oNSTUTIFVYF8N0flkmR2PwZ8OufbVbq4g3
         yjhw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZTb3uLRkwxlafGJ9z0dnNLLuHM1wQH9teJZPrTUdxTO4q9foueOspv8WkeKYRUMNYrNxsZAj1hG6FJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8yEYNYpOb7hm2LpqDFa1cQ8glAGeLhx8/e8t5KOEN7PKYfMZ
	sxuFHA0tah2V6vcArrpP3Cul+2ClEjwoaTVxP4q4GeD21y34tVDlZX5CaSJMkSsoZmO0ZmZ9T+M
	jlDhaD2LVRq72SgUjuXo9zKpG8QtMbhfY1OBiMqchVGWMwXtyRT2ZGIfUS/NuGt/MzQ==
X-Gm-Gg: ASbGnctkpNev9zj3r4L+tBJBPgGXEWlgp8AAAPuLWsdTGZk6yQ0aCuBh0epKgLoqqmI
	ULtiRSNePX6RaRLHYNpommXHfX+BzYzPwdTHj92F2A0J1EXY4tnP5ZigDNVfw+cU0kltcCpL5PQ
	jf2wfo/fNxvjRM2LmuzaFxqCKSRJBSwHukfDIj95hyP402h8Xtf283g0krNsXBqUntnEBejiirY
	Ycos8+5JViGxa9euOJNNhW9FISudo9Iqf6/RcethrAqYpFEEzk1FJeqoVztrrZdcKxvtD8w3qH4
	eR+SNTE+vBaxgxW03ug4ii1mbhJu2ksWR22HxJ2kvAxxEBemvuLlnqXCG8ivNBWI6Rro3j1JmOi
	KZ9djBiXdMv35/xgIfCmBI+OD3U65vuNQ13SeW/SiwIvafGLJjvJuEWy3bXlZ40zPOA==
X-Received: by 2002:a5d:64e4:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-40e44777213mr15960546f8f.10.1759134306213;
        Mon, 29 Sep 2025 01:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+vYzQqhrpkW89ERnZCpVU8TQtWK6HJfqpmqRxYWPjCycn7nAFgLLmckbyGJ/zKWnl9UC10w==
X-Received: by 2002:a5d:64e4:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-40e44777213mr15960526f8f.10.1759134305844;
        Mon, 29 Sep 2025 01:25:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm17612699f8f.13.2025.09.29.01.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:25:05 -0700 (PDT)
Message-ID: <e74ae9da-9dfb-4673-ae9f-c0b27b796cf0@redhat.com>
Date: Mon, 29 Sep 2025 10:25:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/ksm: fix spurious soft-dirty bit on zero-filled
 page merging
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: xu.xin16@zte.com.cn, chengming.zhou@linux.dev, ran.xiaokai@zte.com.cn,
 yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com
References: <20250928045207.78546-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250928045207.78546-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.09.25 06:52, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When KSM merges a zero-filled page with the shared zeropage, it uses
> pte_mkdirty() to mark the new PTE for internal accounting. However,
> pte_mkdirty() unconditionally sets both the hardware dirty bit and the
> soft-dirty bit.
> 

Right, that's one think we should clean up at one point.

> This behavior causes false positives in userspace tools like CRIU that
> rely on the soft-dirty mechanism for tracking memory changes.

IIRC, false positives are not a problem. We get them all of the time 
when merging VMAs etc.

So I am not sure if this here is really worth fixing. Soft-dirty is not, 
and never will be false-positive free.

-- 
Cheers

David / dhildenb


