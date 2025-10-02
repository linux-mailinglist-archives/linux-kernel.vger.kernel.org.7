Return-Path: <linux-kernel+bounces-839925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FEBB2BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FB719C32A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B872D238D;
	Thu,  2 Oct 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/r4OwOe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DE2D1936
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391702; cv=none; b=TA8Dwgd48kxEYcKS2WNbIcfVEhKhPOOthkJAa0qVKQFSzTaVSqEt3Oah8wwHMHTuxJJogBQxROduQUD0+7bq9PV9j158w5XU1QWSJrem2H5qkq9eQanZXIMSNZ90/ixcVLV6hHbw/1gR+dkK4D57VyhJ+mjlDj5YZfhTDGTe/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391702; c=relaxed/simple;
	bh=nb9SLyTaxwx10+zZr/x8CleDAMeEWEvApjntTON8H7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFU3ciWZGTKMwfxqVVsCR1qM/SCGHqZwd4WqVTJXRJInz+c/h1hK9a4hQpf6BC9FVE1I/LO9v4Cv7YM5O1TaqUP0NOosMbQm4MpmNFNdgt40LEcobnnyvUm8bNzvdbvT2k5jW9wNFdN6D+XphuA3asEpcLAkOLJKZJWj/hpPYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/r4OwOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vikbvMujRxH5+j8MHPapMlTJNADuVwLSxX8Ctdq/Fn4=;
	b=Z/r4OwOess7EcSQJql7uoMPLtlo+QbxeRHfhws+qgdu/kIvmHJg6cFUR4Rb91WgpojeuSE
	FTxf67wBFXfdEI2KwEvYtZM8DbMs9/sAq4VjQfbJ5hRt79RBGbSVdSCv9Fs91D9ONNJ8k5
	kXxkyLHmxOdhDHDKrKYZLC63HzT6bfE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7uZu0uurMF21d8lbvNZZvQ-1; Thu, 02 Oct 2025 03:54:57 -0400
X-MC-Unique: 7uZu0uurMF21d8lbvNZZvQ-1
X-Mimecast-MFC-AGG-ID: 7uZu0uurMF21d8lbvNZZvQ_1759391696
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso276266f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391696; x=1759996496;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vikbvMujRxH5+j8MHPapMlTJNADuVwLSxX8Ctdq/Fn4=;
        b=Z/781tUDu4mMhM0AHT/nxjqjmHA7l1znQP2CMyoQ8ERVDXZir8bpkBj5eadddqd5et
         koOjBxYPg9k1YYdC2kgIS0XDqLn9rfblr41Xn/SGUKFW/+mmxTxnWH0H4ADd6136v+Hu
         KcWdTkpdx4Peczr7WwosYwXjE6k/97IPSQf8wNjkJVAAA4m3Bfwe77qMdhbqqoA6qwvY
         Nrm5t1lnD3hSTNMx60s6RMKisczAyvD4qoAnAvo17WCRN7zGnYsMZ8xPQUs+9yLZ2Bn4
         j1+s3QAEJwrD/kimNoEwpSQj4/o5OYKkVDYBSYGNIK8YQSfnQu0CiyCLt5uHQuQn/b36
         F7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWsbL6gyNevORkpRPDXazBNhPoWln56QgPdumpfdLmeZy2GDqxLuCUWbFbfeS1mFuWcE6Z6ynuME0HqlO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRaZ5XAVGXAfZHqrxil/dMDr+oHS2G01T0LNjb/f4TXZBVMYl
	WGkwB283wNZSv1GYf8czfE96vbQLYDep5JumCg59kP/iFfrBcOBUrmx5nQE62/BIgl8bZqXNnp5
	wVO8LFqn0yv2ZqE82UQN456IaUNEE/5h1Tpmtrq9V3BmqDl/n/9a+fxfoUrvB2A2/7Q==
X-Gm-Gg: ASbGnctQ8wuwCdH8FCLlcego1ppQ1szS/uTnTevzyYSGrhNWwbE28ifSWnJriO21vkH
	WV7TzKA6jkwYiLlm/6DOBo9+zU8sm0ebkY9PVBsYE9TNqPFeWapjJZv+NVo0VlTrELHa4m1HSi+
	M4mbza62nMmhDa8805Y6Biby95hRfVPLqkMW/ae++tSBxtuJKbD5F0LitQZmL/JernZzdje1JKb
	IK8rpz+dwDnvsNaj11caPQVxXKlBcQIZ8ykP3eeJUSE5kBRhZiqyBY/+/UASu8Em5eNK2e1inpU
	0e+y7aMj2rjp1cFdJUgQbVeXp1uxO3RE8VCFoxztBGfB0qaezHZpEIuwt668b0QQrFYar6kwqej
	Y0lzqnBJJ
X-Received: by 2002:a05:6000:420a:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-425577f1b33mr4696226f8f.14.1759391696265;
        Thu, 02 Oct 2025 00:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ucs9qEAt4KkjYeplUmqpl78kNlA5Io8C5XuP/RQbkK+tZkwKR1bmiFsNk+oZQa0IXEyYPA==
X-Received: by 2002:a05:6000:420a:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-425577f1b33mr4696203f8f.14.1759391695720;
        Thu, 02 Oct 2025 00:54:55 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4b71sm2383313f8f.57.2025.10.02.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:54:55 -0700 (PDT)
Message-ID: <7b7028f7-8225-475f-bf74-a0e6d3fa90e7@redhat.com>
Date: Thu, 2 Oct 2025 09:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: redefine VM_* flag constants with BIT()
To: Jakub Acs <acsjakub@amazon.de>, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251002075202.11306-1-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002075202.11306-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 09:52, Jakub Acs wrote:
> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro.
> 
> We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> follow-up to make all the VM_* flag constant definitions consistent, as
> suggested by David in [1].
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---

LGTM now, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


