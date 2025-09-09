Return-Path: <linux-kernel+bounces-808608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEEB5023F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473531C24212
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6026F467;
	Tue,  9 Sep 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUnu1vUb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF572472B5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434524; cv=none; b=E0QHbhh0JZAfc2RJGQnwu5Pn6neYPH9r+Sd+Yr9o8rsI9EnIknrj8ENw7XwO4KWQ6TpEpfM8QRqaKlt7GlMafTOPcDgGHsYEWYuP/Fdf8m6+9Bxm97hhLFxiEFwVQTtn7G25L6eYX6fCnfYN5T6AikB95JVPoON6oeR28TJVr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434524; c=relaxed/simple;
	bh=m9AB27XZ/atvim+ruNB3CQcDElk2EdEWb3pHFJ51K4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnAq6raK1FLJJbiHJGpoKjIE396v69QZIdIBQKJSuIYKarl6dziI2iysUGpd2uoWIosFrmOFQydDzERZnpMyy7fc+e1LdzYPDprDpK64SqqvzqJRZcgT/4xDgrHaa9k8mTxUxyU1K64steylP3AyjVvaHwc+z2AASC97fq4Y4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUnu1vUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757434522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DULaN8FQ4FQ8+JpWrIkbkq8ORxl+FvcAutXuAs4Q8P0=;
	b=eUnu1vUbcl/hPH3h8ADNOaIkVgIS3sBgShJrF4CZUbf1EaKTg0axyqDHVpu7iKwi3Tjo1G
	+0RdutpUTyYCsCWn0FjG0H7wr9Fx0gt2zpb67fy5vGtW9PqsG+jDcLMrFspGN37DHemjPm
	s6G1jMpnU0ZZQMcoIchjbtfXuVNiyn0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-UvSe75BWNKCtA3ZTHt7EqA-1; Tue, 09 Sep 2025 12:15:21 -0400
X-MC-Unique: UvSe75BWNKCtA3ZTHt7EqA-1
X-Mimecast-MFC-AGG-ID: UvSe75BWNKCtA3ZTHt7EqA_1757434520
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e1e7752208so2838923f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434520; x=1758039320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DULaN8FQ4FQ8+JpWrIkbkq8ORxl+FvcAutXuAs4Q8P0=;
        b=awXuGrGsYwdXZ/Psrcop6uCBvjEMbJdHXSXWIoE6zz0uGART7VseO3AqQii5phA+v2
         JqwynruLTltbGeZeu2JgzO+ah1/PspCsAR1pmX+zyU7HdcV4BEiKmqLWiR+UzFV+ESx4
         oi9FcHjUeACzAUkGI4RR64T53EQ4Vx340qSdx1bp6zk8KK/BFk1CnP+Qz8UNukhL3eTq
         rM6YFIpfE/TJtuytjZfoeVLFP7YjEO5D4G0/O7KFKHG80wr4VNFUPbjq5Z0MKt9kboHP
         6W4dSKFdUYng4h3fXBABG5UwHZtjZDSm5rlQ83caXV+uPx28yvtqYeZW95AjloC1Jrr4
         ce8A==
X-Gm-Message-State: AOJu0Yyu1z5D4uOwbR8BodD5+rUow5zd+rbu+b8DaT6ZLuEQM6MU6VBa
	+4Ayn0UcJ2mhmB9R9XIEp72knPtJbgdPwj3Qk2CCBNaR/T4btqke5TeIoa27enEGw5JhW1EXgou
	1aw2eyzAcJdrUg0HKYGcI03y8geG66sGr3Tqj94ZLClP6AZa4XRpWheHLIL9odA2zFQ==
X-Gm-Gg: ASbGncs4+Wo9IsHAUwOnzjTu5c5PbnhET6BptbTRTcFpp1Z0zFvdSjC499tafzLH2rD
	Mpj6cv/sVHqdYRnI455HgI8qsjU25TU0W0P9q8pXoO1xHvfoVHlIKWpOHNxTOgL8/i0RZyzOiyO
	IlMHV4jlqJ6jx2NsB2EhcVlUlXiBRUDPginpUh+OCaG7mjCy14sP27k03QZTRSUZaejlHyWSqbR
	dgDyJNKbp62gCr6JyW9y1e0SQyhij+sdtz/UWROYYns67qoDvJN0tKA+TvxfkLDrj/V6JP/uE1h
	Ox0kcL5e2CqW7Yh1yt0AOhlmsQAGFsGWIII8KwwmhcZTtfj2cOYIfVXeU03PgsQKLTfFL4TCUe7
	vKY+5vupDd0x8vpmctYGINQxmxDMSXj6kk0Ong4l4CrTXOus1LDN77LY6oSgepIecvLA=
X-Received: by 2002:a05:6000:4410:b0:3e6:f91e:fa51 with SMTP id ffacd0b85a97d-3e6f91efeecmr4995399f8f.8.1757434519697;
        Tue, 09 Sep 2025 09:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9InWvJAwy9lkxysPqm4Le0o1CsvWdRiHnZwm16w1dhVKD+GnoSIETjUZea0fauM3ALyDmAQ==
X-Received: by 2002:a05:6000:4410:b0:3e6:f91e:fa51 with SMTP id ffacd0b85a97d-3e6f91efeecmr4995382f8f.8.1757434519270;
        Tue, 09 Sep 2025 09:15:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238755sm3139523f8f.32.2025.09.09.09.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:15:18 -0700 (PDT)
Message-ID: <1228a0a7-660e-4993-887d-66bc2c37b8f4@redhat.com>
Date: Tue, 9 Sep 2025 18:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/gup: fix handling of errors from
 arch_make_folio_accessible() in follow_page_pte()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20250908094517.303409-1-david@redhat.com>
 <20250909180757.1114d727@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909180757.1114d727@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 18:07, Claudio Imbrenda wrote:
> On Mon,  8 Sep 2025 11:45:17 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> In case we call arch_make_folio_accessible() and it fails, we would
>> incorrectly return a value that is "!= 0" to the caller, indicating that
>> we pinned all requested pages and that the caller can keep going.
>>
>> follow_page_pte() is not supposed to return error values, but instead
>> "0" on failure and "1" on success -- we'll clean that up separately.
>>
>> In case we return "!= 0", the caller will just keep going pinning
>> more pages. If we happen to pin a page afterwards, we're in trouble,
>> because we essentially skipped some pages in the requested range.
>>
>> Staring at the arch_make_folio_accessible() implementation on s390x, I
>> assume it should actually never really fail unless something unexpected
>> happens (BUG?). So let's not CC stable and just fix common code to do
>> the right thing.
>>
>> Clean up the code a bit now that there is no reason to store the
>> return value of arch_make_folio_accessible().
>>
>> Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")
> 
> Ooops!
> 
> thanks for finding and fixing this

Thanks! Is my assumption correct that this is not stable material?

-- 
Cheers

David / dhildenb


