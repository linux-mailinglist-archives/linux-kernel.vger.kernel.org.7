Return-Path: <linux-kernel+bounces-728178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EAB02439
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BB6542733
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5992D3ED6;
	Fri, 11 Jul 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmDt2XwK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3651D8E07
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260599; cv=none; b=l9ppEk1q3EFlKvqFMqUMtaaJcow+lfr3Eom0NK8P1zIKhkpBLfUHNWYOrJJJhjXzREXDGbNpjazVsSFkryOa5fq1okNYMkq+L0L4GJ0DBbRs+o1jrLV9/HSBs/CLTrxBFvaYa9LnMB2Km1lNFaA2Ol9Jk1on25gkCuZiAZNptDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260599; c=relaxed/simple;
	bh=YtPJBSuNF/CMPLCRd5CVGiFXARpGpAf/wlPIPPEqRNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTVaua+z9zd4kdoMzyXoxwpCGBFIR/P3MEef3Xdf6ZCowV335oBqdWyqqr/PYn8i9HpUE8AeXm+mYKy7Ld4EEQXY/bidPZ3HVHxTsA4R9pizWDduUhaHD6DQcObtNpkVywn0i6DwDCBxXbUd1c7+rMl35oQpnF0E6yardBPndRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmDt2XwK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752260596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/lngge7cM1MpsUh2i1RV/CXO4O0gq48AADt8QP7yiyA=;
	b=NmDt2XwK3tJj4isivStG1DvbXOXdQHzudZ/saMXPRoVDsUv+akOKUPTGgOfBJAoIj5NKB5
	Nqv3ItHC8xzZ9yg2joi/mVjylj9EPkqYvUzBEHC3P2HeFfkzOjH6YKmDyjynpkGyqankkg
	gozWUtQwXCOsRoNg7CUinRXHbPmCB5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-gEyiVtBvPdyJBZuEuCBeHg-1; Fri, 11 Jul 2025 15:03:15 -0400
X-MC-Unique: gEyiVtBvPdyJBZuEuCBeHg-1
X-Mimecast-MFC-AGG-ID: gEyiVtBvPdyJBZuEuCBeHg_1752260594
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso22984f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752260594; x=1752865394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lngge7cM1MpsUh2i1RV/CXO4O0gq48AADt8QP7yiyA=;
        b=Tv+lkbeDivnRpfMOzRohEJDTM8AQa5/tMV4pBY1fo/DqoHmfDe4TNI5g+SYL/qQ3/s
         EKnvfufSp7vfw3vrmL5sZy7HzGgxb4Soz/PsvNmrQ/gVP+AjKnNrL0RddBRNed5voCqg
         agLySzvzH4QupGpd4ao16GPLQe17IcXkvXMdBPii+CwKtb9ZQKV4FJE9aaxNtb6BPiNH
         xMD8gr8jMKRjofcjZBnQV+Vhx2hxtNhNO2CzGinJhLrNZYvfL/ME7nMPpinktK2gqMDq
         DBY33jVnjIRVDfFsC0HaECJBRYtsKtRu2cutmFsPRG+aWA5iiKR/ZLhC76inWo2pzrRe
         RvNw==
X-Gm-Message-State: AOJu0Yx20aR2Qh4kRL3ABaF2wnjDDWYkje6WFUrXHkiyMECzQraUqYUX
	w5JAp1FuKqIBPv2vLSmDc1OZFg8Q7wwBIUrETLy1a+acqeQm0w3b5nY6JMhmWIxkxrnlCm2hux/
	VwngVphTb6DxJ7g7crBwp6rgUsuY8eTTnvE1a4Q9Vd7N9OVOs/QyGnnaPHHJt81hGYQ==
X-Gm-Gg: ASbGnct22jJCY234iBW/HzVEQdILCXUTha5xm7CjEcPwq8lrnyatOij7quQhf36sT27
	mUzMPq3HkaDjOpfGAF4S3mlv4LvY5Fc4HHQxANomt52XCRYWyRFoKHr3FukdkFBocEAZa7w+qUM
	Ex2khHm3eAm36lqU7oN2g5nfdScAh5DQXP3gnzAanbmPL3koDQstjhOe3lGRQpzx7SH7kSfeTN4
	cjZZ1I0R6+KQt9ArShHVRuX5DXlcrnHrmTT/ETyMNyrXj/UgQ2eGNSmZ3iodBOeVaLl2MY1etyn
	2x8dPJU6QwyJrQg0jhuejcVLyxGllHaKyUbEQS0xbsTLNe1jdY3RRed1Zl7AqhjI+ykCkjOp8fF
	BpnQ4fKHp5h9y16kracPUftr4hjzwVKXKW87nQcYDCIh2ky/QbdgRtmHvL4AneHcERBQ=
X-Received: by 2002:a05:6000:4402:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3b5f18dc96emr3257692f8f.33.1752260593785;
        Fri, 11 Jul 2025 12:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xDIEgx30kkknBrLV2LVIr52Wad/TmaqKJIxkhU6edDETOEFTCXyz+a0/g6zni08RX/ga6w==
X-Received: by 2002:a05:6000:4402:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3b5f18dc96emr3257648f8f.33.1752260593340;
        Fri, 11 Jul 2025 12:03:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c? (p200300d82f0a2e0089cbc7f082f2e43c.dip0.t-ipconnect.de. [2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1f4edsm5112095f8f.83.2025.07.11.12.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:03:12 -0700 (PDT)
Message-ID: <d258c487-29c5-4e1b-b5ec-911def6c850c@redhat.com>
Date: Fri, 11 Jul 2025 21:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] x86/mm: Simplify clear_page_*
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-11-ankur.a.arora@oracle.com>
 <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com> <874iviprkf.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <874iviprkf.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 19:26, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 10.07.25 02:59, Ankur Arora wrote:
>>> clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
>>> variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
>>> free when using RETHUNK speculative execution mitigations.)
>>> Fixup and rename clear_page_orig() to adapt to the changed calling
>>> convention.
>>> And, add a comment from Dave Hansen detailing various clearing mechanisms
>>> used in clear_page().
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    arch/x86/include/asm/page_32.h |  6 +++++
>>>    arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
>>>    arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
>>>    3 files changed, 46 insertions(+), 41 deletions(-)
>>> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
>>> index 0c623706cb7e..a8ff43bb9652 100644
>>> --- a/arch/x86/include/asm/page_32.h
>>> +++ b/arch/x86/include/asm/page_32.h
>>> @@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
>>>      #include <linux/string.h>
>>>    +/*
>>
>> /** if this was supposed to be kernel doc (which it looks like it is)
>>
>>> + * clear_page() - clear kernel page.
>>
>> "clear a kernel page"
>>
>> Although I am not sure what a "kernel page" is.
>>
>> Did you mean "clear a page using a kernel virtual address" ?
> 
> Thanks. Yes, this makes way more sense.

FWIW, most clear_user_page() will just call clear_page(). The ones that 
don't, have to deal with the dcache flushing, as the page might have 
cache alias from another (mm) address space.

So clear_page() is just about clearing page content using a kernel 
virtual address, and clear_user_page() is additionally taking care of 
any dcache aliases.

-- 
Cheers,

David / dhildenb


