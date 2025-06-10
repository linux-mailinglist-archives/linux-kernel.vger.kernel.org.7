Return-Path: <linux-kernel+bounces-678803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A8AD2E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A881893156
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039DD27AC56;
	Tue, 10 Jun 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQx0O5Vi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA53279354
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539133; cv=none; b=g7Xx0foex7hPh39X1po31UnX89nn7DqW/2DYrxyPQxwtZd758W98EnKf4RTvC6nI/Yx7DTcZia6P2MKE/SxzjwTbrxTY+HwpDZzSTf2xHowhQ9yqyM0WMEiSFwhw3aNH0Y5PKI2xfY+q7Br0q1h3XdDEm1RSlUIfhvWriwArjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539133; c=relaxed/simple;
	bh=+BVmPMYo6tXe5jLgYA9bBLt98rJDRk/RsCsffrkmwtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr4r932/HiHgnder7anoPtPJUdvQWqJ66A1HbPSgtiiyByPdaLLJt+NStCb6lyMpMkAz7HLbxCNtZZj7y+n7l2zQdlRwAttRlLM5z+QjDX/6sYa5Wd5ArKVOus+1TRg7o17ITJuYohCj8Q7m34ZPk7020cmC1c3q5HEkpbsq/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQx0O5Vi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749539130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4uGayi3wE9vU8k3pYd0gZMMeUhuTj20TdyE6+hjuf10=;
	b=AQx0O5Vi8A9WB0Kh0uPnMX7ZnWfO9k1u+5JZyLFjhZjDcfTI7J+oMwgtdP2/Bq2xwvNGP6
	10MPJe3ExR15yThVKLG2gbUlvq8Kn6jdEAreAn+uxYKMEnkUVOzNdL3aMMT+e9gte2JOA5
	v45taJ4F6yfnSsf4c7vDM9ujpyytxyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-tA4vtuwNNeqP4FZV6PpXJg-1; Tue, 10 Jun 2025 03:05:29 -0400
X-MC-Unique: tA4vtuwNNeqP4FZV6PpXJg-1
X-Mimecast-MFC-AGG-ID: tA4vtuwNNeqP4FZV6PpXJg_1749539128
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2085577f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749539128; x=1750143928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uGayi3wE9vU8k3pYd0gZMMeUhuTj20TdyE6+hjuf10=;
        b=Zrz+NSN4+WJHjfF2l1jG7FQRNuozDJZ8D2vkRBfnFUUJh5syz4J9Os/MFJQAr0AkRP
         yvH4FkqNrqa9AL6r+UA9tnBMU3jRwyRqp0yajxgXsb0M4X/PoQxEoiOZq9lhQqYzp1Yl
         N2pcb7P+5u35JNYFJX0cK0yz5qB2OJTGEEhr8mWatJDFQSpb6KgrpgZz22ocDUM8Re8q
         oA9PPVXFRw5tV4SVR2+Ug9bjSzbnYR395QKbLsJtxmotGPPUf2pYdCdfIQZ13qpM/s+k
         pVKMYynJvLJoFvcos2culHz3RM1k+do50UKMB9y53KmdI1+TpLNXSIgYtexFANQEk0zc
         gHvA==
X-Forwarded-Encrypted: i=1; AJvYcCX5QyOWTTtckNEGqD9MPocI0pW1w3Kk3MSgYZ0hqUEBTRiXh7Jt/WhYQlKR26T5Tel6Oo+G2xYjqLnbYmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsH1rxmAVNEyi7QdcY2PQxAZCR4JTrsKe/abK/sj3nDBW57XRK
	rtWgvv7OPnNJy8VfUwxLuBzu3N+i5BFfXU+ZoW32fEXI18CS0O7f90fOtovh6OexiPNfrd2t0oB
	ioHR0hrndlu+5N0JxDe1kQTNfyW3BYX9DpkrzaWVtTW6+DW/7xykSpkyVuMbHxAbhWQ==
X-Gm-Gg: ASbGncvtgqzTJZ+QCR2k7kVxs6fdCC5oGoD+6t1Bhwmbb+kVzOsna1brYi/zcob3o1i
	jeVV8wKgrD9WeS7AUxs3PQX2ZzwyAcxzROKLz0reMROmf7XEXwB3e///+YdFVhufftV+1DiKtFi
	FibO8BdU3Uf46yPfFdkTIe5Yx4I0RnLD0dkWPoItEGq4nznhctKjKPNJQy5Db7HklSbHyqYOM2n
	ramm1DAw0NDXTU73M4IhAacc9VLoIhCtk/WHpTd6XQfYNvBZJj/WubxQjGIB5sHkKziNGwvQ7sQ
	CKZC1cmun9WWTbI1fwqqUY74N0RVQeqRP2XWAvwvJwXxXiZtRuL3z+c=
X-Received: by 2002:a05:6000:1447:b0:3a4:e002:5f97 with SMTP id ffacd0b85a97d-3a5522674d1mr997598f8f.1.1749539128047;
        Tue, 10 Jun 2025 00:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHChnADTfaieweRBHvUp3WTN9uAJLomdiqgSBhu5JtbJEpBVcl3obpq3MkMSLVwf70BjgKN+w==
X-Received: by 2002:a05:6000:1447:b0:3a4:e002:5f97 with SMTP id ffacd0b85a97d-3a5522674d1mr997569f8f.1.1749539127681;
        Tue, 10 Jun 2025 00:05:27 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e1595d4sm127883385e9.16.2025.06.10.00.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 00:05:26 -0700 (PDT)
Message-ID: <c2f52065-9758-4ce0-9c15-ef040bebd37e@redhat.com>
Date: Tue, 10 Jun 2025 09:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Shivank Garg <shivankg@amd.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
 <aEc0MNj9JNXbLHmw@casper.infradead.org>
 <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
 <aEc7JG-OL2fp075j@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aEc7JG-OL2fp075j@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 21:51, Matthew Wilcox wrote:
> On Mon, Jun 09, 2025 at 03:31:40PM -0400, Steven Rostedt wrote:
>>
>>
>> On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead.org> wrote:
>>> On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
>>>> Replace open-coded folio reference count calculations with the
>>>> folio_expected_ref_count() helper to improve code maintainability
>>>> and reduce duplication.
>>>
>>> If it needs this much additional commentary, perhaps it's not actually
>>> clearer?
>>
>> I don't know. I tend to over explain as I rather make it totally obvious what is happening. I wouldn't say excessive commentary is necessarily a sign that it's not clearer.
> 
> That was a Socratic question, not for you to answer.
> 
> My opinion is that the extra commentary is obfuscatory and should be
> removed.

+1

-- 
Cheers,

David / dhildenb


