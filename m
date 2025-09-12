Return-Path: <linux-kernel+bounces-813347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD256B543F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC03189B9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939592C2AA5;
	Fri, 12 Sep 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOaei1ID"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6B261393
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662350; cv=none; b=rV1kTOqAaxnVEaiw20kqIdTijEGHMuJqI5tGaRYXBEaKHOCupmll+AV8g73dtHxTSaKU0l5/wYUnNmdTo4/YCZ0h31zvtiFi7EnVvKifx4XU8P3CxN08Q+E+xVUMdFlIuXseuEVj0gmZu8kmlO4W4Tko6kWE7VBHl15pa1kygWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662350; c=relaxed/simple;
	bh=TkaHB0/HgYwta3Zd8gabIdwGnIt2Q9nrzSgwWYkLv0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j8YPvCDvJEuyKa+UHfyiVAKadKBzD0BNC+lifXxSF/BjUCpIphq0itDOrc5R1EDia1H61rEhS+ADsFtoIg9vlunedeZ/AM2V91c9sbE48T9EpHzQpWrnr43UqCs2R1Y4RiI4i0kZTbrcax654RfhBbF7Gm+I7X3paXiXsYDii24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOaei1ID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757662348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=95M+ctN1eGHsC7Fsc60NySfMXccvZmx8uQ8XIqmO9d0=;
	b=AOaei1IDI2OOOb3KhArugtYerJfdNJwM4+IfJyJk5qbd5ANE335Lv37PTDSOAuiRZhNUJw
	igaeg+RBQ8r5uUHbwsfg33Me4H2uh66Iw3pF9Hjhe+OzBfCgoaIqyJmmLx18ZxVSOhs3rE
	hG4dla0p24zxaIo3/KU8vgsvg6V//pU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-aDNsPV1PMN-1UIIDmq3Dhg-1; Fri, 12 Sep 2025 03:32:26 -0400
X-MC-Unique: aDNsPV1PMN-1UIIDmq3Dhg-1
X-Mimecast-MFC-AGG-ID: aDNsPV1PMN-1UIIDmq3Dhg_1757662345
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso12644735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662345; x=1758267145;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95M+ctN1eGHsC7Fsc60NySfMXccvZmx8uQ8XIqmO9d0=;
        b=UYlIj+M+hF881QRf4zZYXZDkOC/gWHS6qf5RX3J3VStXyVQ431Rz3z1gJ4ZCKKNPFn
         HmZerp5uB/aWRkN6Lnp+QEggAQl1uB4019qQBN+aZvitTZzFafCKPQrv8kriWLlooFJz
         gdFCLpjZoln9UjYKiw0+OKNPwtbVZut4qErPkY6EpiQ29LSlv5aYJV2eY30xhrppfyRJ
         72QMC9lOZau6TXAj8WR73pWYmGg5Uy90Weq+x2iKmAZPONnHGQ9RW3+XkN+W7djFPRdv
         Af57xdmirf1awBD16wHKuUZsRMaC3+sF9myM06a2hWrKXCHDVHJBcmfIR3yB+fxT1eMr
         2rSg==
X-Forwarded-Encrypted: i=1; AJvYcCWyZDeAGdC8rCdTkpmn/+Nk9TUWoAprqzPioEMNbTlJ8ejmov5Ef9fE6iGh4cuNLUYmQ+Ln+Ql3YA9Znaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwON/zlQ4LcBUEsXIcYRonVZ0xhiUrYEtm3v1MPkAbZJBAH7AMn
	aDEskS7+d9BzeTicph3TE+a+5vM/CVA4INxHU80rMd1/EV+NeozVCchBKusnzFkcJDWUYTKeukn
	c2k0kd81UfWWeB/kh8a2BWBSjBjcMWPswss3gRUWKdMxpBXfhq/X4KBb+NpohEUxflQ==
X-Gm-Gg: ASbGnctVshJBKbyuN5GR2b1tTiCH6d/KpwFJK1ltO6M17vhBUrx7gKSJ6jgnA5eUorT
	U5ETmrU1E1quuqqHcbPJE01YOTM0ZOwhlEjKlj90C0gwy9CLrpv83Qp9O/UAQqw//+RCkV+plcc
	FGTybELLnJqzbCdzoQI05dH7QXmnaso+rZC3+gqU8kQ5z3Bxw75yURlK3WhX7OwD1MGlj/KvQWb
	UxdZYo0sMY+6TZxpUtQbuTeOehiWJMzrg72bON4qVCc7H0XI8b+mC/tSuhsmUUL3EuIMT/PskxL
	jxsiOoDqWfDUh67n68yHgZyTeAehqoQD+aiDU/7NV8Y5luEGb6cqng3WUvsDdHa5u88JvZpo+Id
	V/b10VSbTsfmSRRsklP07SiGRPGZlxpTvjok/gnijk2aouVX+FVcsJtL70NVAh/prChk=
X-Received: by 2002:a05:600c:3b23:b0:45d:d2d2:f095 with SMTP id 5b1f17b1804b1-45f211f708emr17024175e9.19.1757662345335;
        Fri, 12 Sep 2025 00:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE291A72hUcioW8Th7oBQOwDU40VMWQG7GX58xF3iUOfk0bITXHhgpL+U49NQSEOwl8XHibag==
X-Received: by 2002:a05:600c:3b23:b0:45d:d2d2:f095 with SMTP id 5b1f17b1804b1-45f211f708emr17023855e9.19.1757662344930;
        Fri, 12 Sep 2025 00:32:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760776bb8sm5665006f8f.3.2025.09.12.00.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 00:32:24 -0700 (PDT)
Message-ID: <b5bba27f-e26f-4efc-a7e0-92a6d82b9bbb@redhat.com>
Date: Fri, 12 Sep 2025 09:32:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: jane.chu@oracle.com, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250910192730.635688-1-jane.chu@oracle.com>
 <bfeb8af7-62d3-4dc6-903c-b6697c5ef795@redhat.com>
 <16fd43b6-930a-4a33-980d-c493f88747b2@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <16fd43b6-930a-4a33-980d-c493f88747b2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.09.25 21:58, jane.chu@oracle.com wrote:
> 
> 
> On 9/11/2025 1:17 AM, David Hildenbrand wrote:
> [..]
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 753f99b4c718..8ca5b4f7805f 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -5594,18 +5594,13 @@ int copy_hugetlb_page_range(struct mm_struct
>>> *dst, struct mm_struct *src,
>>>                break;
>>>            }
>>> -        /*
>>> -         * If the pagetables are shared don't copy or take references.
>>> -         *
>>> -         * dst_pte == src_pte is the common case of src/dest sharing.
>>> -         * However, src could have 'unshared' and dst shares with
>>> -         * another vma. So page_count of ptep page is checked instead
>>> -         * to reliably determine whether pte is shared.
>>> -         */
>>
>> I think you ignored my question to v1 regarding the change of comment.
>>
> 
> Sorry David, didn't mean disrespect, I missed your earlier comments.

No worries. Replied there about possibly simplifying the comment further.

BTW, I think the code would be even clearer if we would have

ptdesc_pmd_is_shared()

that is simply a wrapper around the ptdesc_pmd_pts_count() check.

-- 
Cheers

David / dhildenb


