Return-Path: <linux-kernel+bounces-866674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B53C0068F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3323AA58B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A42EB86F;
	Thu, 23 Oct 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8hhGXM+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A42FABE7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214444; cv=none; b=YglJw9pRAMl2+sM/YvtCvHTsOjMrGPdm8WxZ91lspaMg/JCWb1Z4TTdhXWW8RJAqrWv0RS3K0S5gOSkEZ/wzAkeBkp6Jh5jEW6awrtfUS3DQoPc1yvCXmqz6tATIrEFkAp9L0urnV/HbngKrCKWJp1E+GlKITX3m63McqFfPnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214444; c=relaxed/simple;
	bh=tve8HZw51DvsoiCMwHmOwj8VViL16ytCkRksFVwW1Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLQnZtPsCPJcZ5BjhYR3VBG9T/ZMqTv65YCXS/24mkopXF1JeZQQoSQJ3hPi8tabjv8tyjGxIroIkO46EkyKse8lmfIUoj65m80+mXf4yFWLsZw7tBPgHRYzkAiedP/0j54rcSCtfJHv5oDwXj3Ax6nP/vM2cz1dSLeygQqAEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8hhGXM+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761214441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FYRDFMsX7IhpWRX+3N1D8BCmUrjohjYlAA5w2Y8gVM8=;
	b=T8hhGXM+yFi5fgs3e3Qt77U2PuTb/Y8ne8Gr3Bou08M2FPB30kheIIHf1iSbhQ9pz42jo7
	e9OazDI8sjLtAh0AeYPlbPC7JXzEDDsYoBgy72SHUkvQSQWfyw+dgiehpzpPjZzn8kZycA
	jUMBqTlLrE2DOlTh+oRt63UWsr+xCak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-lTULJgfRMdm0zVZypcZoxA-1; Thu, 23 Oct 2025 06:14:00 -0400
X-MC-Unique: lTULJgfRMdm0zVZypcZoxA-1
X-Mimecast-MFC-AGG-ID: lTULJgfRMdm0zVZypcZoxA_1761214439
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so340863f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214439; x=1761819239;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYRDFMsX7IhpWRX+3N1D8BCmUrjohjYlAA5w2Y8gVM8=;
        b=ofIqAndc2x0yOodEl+xla0RM2I3xMx7nbtP5wr7/HQhqmXnb1t9AQsmbZbC9uGF2WU
         4cBxU7FJXSUYBtB5ewlkN3VP8A2rmQ28SqswSy0aCq6OobJYbb5wVUkN5ldbGE+KduYE
         FjZaYUAUz+limWuYeL1rX1mJ2zi7rdbcXlO67jlmyDoacSqe+FIMgNe+AeisaYAMqXXX
         bd5CtvlPPHj5bdeol8p9/USZWOv7Ft3EO84qP73LYSu57r1qRQWlnOlzTQbZFf3flCUs
         aHicmiGpr+YhIln2UiF0xznU9r+p+Wc5u/k8Uf714BoEkxPlqICwMfyXY3BSszrfs21t
         KFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrOGi+AEvKyN7UCrhdZZtSWZ0CmT/ttEBC2VN2SN7/iR3O9snKTWphoZk5J0Orr5pNnrm5KHObLhB3biQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05g/xPqplYKadzmWI/5iK8JeCxifNEePayIWKSjS1/sZObCE1
	0OR0F1Lct/jRKPakb6unsk2tGJqYKp8EKlARcfyUvs4Nt7AGY4RRSOFGIde2958wMOVuqTPooH8
	8w1BoNIgZH0I/GezyG+LDfnoxdhQUElkwnWmEFAAbw9OYA355Sxr7M6QvahxYjPljJw==
X-Gm-Gg: ASbGnctOYDXoZQlBehmGLHomDBKRV+u1ygsdr5E6uUWRJOyHisRIZe9B3X8y658XdRZ
	w1Yfd5ebbYDjfGQIyHFNHPmNlfQmuKF1VfcB2TbQKcuWxH+/obtlD26M7hs9uKj0TdwNA/DKDgI
	vhQVDCxd24vDpIcsblp7LxoVxH9DAvlbuH6FRhI1IJ9rquuMFfXRO63Tu7eCnI+7lN6W1OR2UCX
	ETJ/goyb3xfjUPNDDpCUutZ1v66XavWD8VQN5jOzmaI53Ur45qRwIAdv7wM5XsgjUYwoBwkF6Vp
	2v3g7sfgRA2l+hH/TEsjJO1chhYb7Vs6YoWor/dZlOzbZiKum+eE7/N1llua8Sqssha0JxND6FV
	TE2FhRYtHH7gqd5PVUSq6YBeHoBQFkVoTHGk3m4vqn/Z5I4pfE+mn/DUZbaAOt3sUaXfDG+k5SE
	5CV1zX0qA9Xrki1nc74DpPrIzYlcs=
X-Received: by 2002:a05:6000:2406:b0:427:9d7:870f with SMTP id ffacd0b85a97d-42709d78818mr15466058f8f.5.1761214439080;
        Thu, 23 Oct 2025 03:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2y9ddCN514f4jZlZAuanJWD21VLCxDfJQeDN3Ku52N38WwDLlzbHP04E/FyV2cjTALX+UKQ==
X-Received: by 2002:a05:6000:2406:b0:427:9d7:870f with SMTP id ffacd0b85a97d-42709d78818mr15466039f8f.5.1761214438691;
        Thu, 23 Oct 2025 03:13:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e76b8sm3377847f8f.1.2025.10.23.03.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:13:58 -0700 (PDT)
Message-ID: <33e299b9-8596-4ae2-b291-4b067dc32001@redhat.com>
Date: Thu, 23 Oct 2025 12:13:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: craftfever <craftfever@airmail.cc>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251023035841.41406-1-pedrodemargomes@gmail.com>
 <d06f4c9d-cf63-4bc4-859d-8256e16dd68d@airmail.cc>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d06f4c9d-cf63-4bc4-859d-8256e16dd68d@airmail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>    				break;
>>    
>> -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
>> -			if (folio) {
>> -				if (!folio_is_zone_device(folio) &&
>> -				     folio_test_anon(folio)) {
>> -					folio_get(folio);
>> -					tmp_page = fw.page;
>> -				}
>> -				folio_walk_end(&fw, vma);
>> +			int found;
>> +
>> +			found = walk_page_range_vma(vma, ksm_scan.address,
>> +						    vma->vm_end,
>> +						    &ksm_next_page_ops,
>> +						    &ksm_next_page_arg);
>> +
>> +			if (found > 0) {
>> +				folio = ksm_next_page_arg.folio;
>> +				tmp_page = ksm_next_page_arg.page;
>> +				ksm_scan.address = ksm_next_page_arg.addr;
>> +			} else {
>> +				VM_WARN_ON_ONCE(found < 0);
>> +				ksm_scan.address = vma->vm_end - PAGE_SIZE;
>>    			}
>>    
>>    			if (tmp_page) {
> 
> Thank you, it works magnificently, very pleasent. Very low CPU-consuming
> and effective, no crashes. Is this a final version?

If there is no further feedback, yes.

-- 
Cheers

David / dhildenb


