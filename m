Return-Path: <linux-kernel+bounces-794409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F2B3E143
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D43189F51A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50F310644;
	Mon,  1 Sep 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyIi2jrn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9EF313E2F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725315; cv=none; b=YIvRRI1WL1Mt+NPWYBj9rGEsyNVK1a4l9irtGYv5h9wwNay0Yc7Cz6nHya3muGBqjgaEaqx7T5nhyvmH2DSdS8NjTu0f4Q74wb5mkZlZpMT9HSwO0iZCSL6e5BcMkp+Qm/+20No8kH3F9HaEtSzxDqLl5sjUOG1pup6PJPtVkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725315; c=relaxed/simple;
	bh=SVO7Rx9aB1ZSZGzRvAg21U8fU2LXsUFJ4ZFhCg/yDrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt0yEkh8hNWPYK378YJx0EyIaVpSwb1ut4CcgNnrWdn6LzscocWC1UopfCWIbTYl9E5AjUgHdyIng+R+EQd6+nIDvxyiD7NlWk9V0GtcSTy7hEXyC2DMswdweGGUmO0ouRWo2epo1sQ1+2D1EZFWvTcLwrTl+PxcNwKmqSmuQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyIi2jrn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756725311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yi7Fwi/+6Xe6GmqjrFqnM9yl5saNfH6dnB6Y6Wd5wdM=;
	b=NyIi2jrn0+8ZnzDGUiWIMMUkx6aOElShL6jd23UE67bNQh4IEvZZZdL0ln9D16In5W7v4c
	cKpNGbTtgwidjCRjvo7urthR1z2mFaPi7AT15eljYEV+YsmPQt2yduZaFNfMkueAhr1Y/Q
	UnSMkNBsiilD2OmicwiwKU+fhRK8Mhs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Qo4lYk-UP4itYbcaUPNBMg-1; Mon, 01 Sep 2025 07:15:09 -0400
X-MC-Unique: Qo4lYk-UP4itYbcaUPNBMg-1
X-Mimecast-MFC-AGG-ID: Qo4lYk-UP4itYbcaUPNBMg_1756725307
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b85c93afdso4949945e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756725307; x=1757330107;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yi7Fwi/+6Xe6GmqjrFqnM9yl5saNfH6dnB6Y6Wd5wdM=;
        b=DLMAdeXWOOdLt+doqOGWtO0OIr12IggJ1c+mdO6ykr4o9zUF/YkVa/7Oq/f9LR/ee3
         2APHi/wEeTSqJaiEQmeOF7+TN7y5iiC005YDgabZqGutxqleazFNp8IGzWBZs3IeD4nN
         uDnbiG/fNLyIovibHwfHmXcyVUh1rtkXN77SrzRgHjR3tpp0xSa/HZjD4XY5y6W7LQS/
         s0Jdt4wPNRmzB6s4t4s+dC6Xg6ABy+U9s1WzM3K79zZBrIWSVkFXwjWsmYcNP/qc6wVO
         CC88FoECoT9Zi+Z3WSPLlvMQUGRLZ4sTD2lQqmfP9OB+6kxli7ewepU5wNDwJyJlMRTw
         yRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP+SYB6CGe5oYsJKiPaTh8iG38QMdMICrNln8RZVsOK75KDONSQtp5nlg6RZMrKWpy6Pi+unc378XXDCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3vfgy+R1XjGY7R6Dw6y8S5FvFD79lmbSQI2e3csDAuNpNKU+
	VeZiZVCjhuW63eALb1ukRSa6Q2cxFvZA5Ojac3z7L5TF9Chc++NGBMYLpuTT+wcUERsxHSAqvF0
	qlch8vk3OPCxop5jtCjJm2D2jvCryNXis5mZV4n0YnT3E0+ol6s0kwO0KKJaDmwfGCQ==
X-Gm-Gg: ASbGncvymrthqrymfWJyPKMECp4RwxNDIk+jS0ZGtP29ODFvXg6kXYOTpJIeefx9EhH
	kZmoeX+ov2bdPdT+3U6UHBlGt7MnBr7di0O+x+95xd5Oabqb1OxOylvlsL69w5Q2CJPTbklJjuA
	ZQ2Rx3tn7yvxnNGxtQPfXJYCeYPtWTng/sEU2jsjKMAVySQPkMPSNfIfPWscMfK+Thew0/gaarr
	kz3mrrQXkxYPRsZ5QIPTCGLnGRFIJQqdWvKuKTRdLu681dKLJBzhoOykngjtl0vYLUBcWREPm1a
	Tf8mBNtd5YMQsvhSjEMoUsTD7n04C6Hsgpk+v93ETB/BHX50fRhMNGoBI722HLaZgNBA5D0Ept1
	DnoGaSr6st4ct3U8auzb4oLT+kH/2H+3Oze9R+WwfZW8W3eHvFE6i16Jiieua4weYyGY=
X-Received: by 2002:a05:6000:2302:b0:3ca:6584:be1e with SMTP id ffacd0b85a97d-3d1df731ca0mr6960254f8f.63.1756725306776;
        Mon, 01 Sep 2025 04:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmpXAOfkbo/7ucu8U3sPdowTv1nqSV9h2Hc/DFrooZf0d2o9cUthDbRMo3GY3Vcoa9zmXMdQ==
X-Received: by 2002:a05:6000:2302:b0:3ca:6584:be1e with SMTP id ffacd0b85a97d-3d1df731ca0mr6960216f8f.63.1756725306264;
        Mon, 01 Sep 2025 04:15:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm15189382f8f.13.2025.09.01.04.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 04:15:05 -0700 (PDT)
Message-ID: <e42641a8-0f93-4441-9a96-7ed99f4d498d@redhat.com>
Date: Mon, 1 Sep 2025 13:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, conduct@kernel.org
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
 <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
 <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
 <CAKPOu+_jpCE3MuRwKQ7bOhvtNW8XBgV-ZZVd3Qv6J+ULg4GJkw@mail.gmail.com>
 <801c5eb7-33dc-448f-8742-256ac40f357e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <801c5eb7-33dc-448f-8742-256ac40f357e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 13:05, Lorenzo Stoakes wrote:
> On Mon, Sep 01, 2025 at 12:54:40PM +0200, Max Kellermann wrote:
>> On Mon, Sep 1, 2025 at 12:43 PM David Hildenbrand <david@redhat.com> wrote:
>>> Max, I think this series here is valuable, and you can see that from the
>>> engagement from reviewers (this is a *good* thing, I sometimes wish I
>>> would get feedback that would help me improve my submissions).
>>>
>>> So if you don't want to follow-up on this series to polish the patch
>>> descriptions etc,, let me now and I (or someone else around here) can
>>> drag it over the finishing line.
>>
>> Thanks David - I do want to finish this, if there is a constructive
>> path ahead. I know what you want, but I'm not so sure about the
>> others.
>>
>> I can swap all verbose patch messages with the one you suggested.
>> Would everybody agree that David's suggestion was enough text?
> 
> I'm fine with:
> 
> "constify shmem related test functions for improved const-correctness."
> 
> In the summary line, but, as I said on review, with a little more detail as
> to what you're doing in that specific file underneath.
> 
> You don't necessarily have to list every function, but just to give a sense of
> _why_ you chose those.
> 
> For instance:
> 
> 	mm: constify shmem related test functions for improved const-correctness
> 
> 	We select certain test functions which either invoke each other,
> 	functions that are already const-ified, or no further functions.
> 
> 	It is therefore relatively trivial to const-ify them, which
> 	provides a basis for further const-ification further up the call
> 	stack.

Yes, that covers the what/why/why okay. For me something shorter would 
be acceptable as well in this case (as explained, due to "test 
functions" semantics), but as long as we're not in the AI-slop range of 
text, all good with me.

-- 
Cheers

David / dhildenb


