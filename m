Return-Path: <linux-kernel+bounces-848320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48FBCD668
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0826E4FA318
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D42F549A;
	Fri, 10 Oct 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2wj237u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD42F39C8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105304; cv=none; b=J8S2S6wB3X1mFv/e3NTeR0YodLOj8vDWta3Wv0MwJ2f3m1YefdAQhCUAH17JH6wr62u6q76T2RZhHIS3iu66qWfDDQ5rv5tJXN6Ppi23pd0oc/J0wBb3oL7LDSnprtsqvjIhFzgSwo4woVoZtZ7zbOqiBw1vqKsnJLy/pO5SEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105304; c=relaxed/simple;
	bh=lL8xuqSu+d7lDRb0p7j++/rm9tvUYUilMwM1JJtICvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHVA3RBZEzLrdmr9GGpwWWpgD2/lVjB0smN8iMpR1tK68llOAGYUcuxkapdL11y0kzaGyl9eXyLBVmdXbkVH17xU9F/ydrXmWhu+JidXVz7XQ098zlkSL4egJ5tqYWLE/ePKgOxZ6BG9iwiht1HBI9yjHd4fYy8avFEfTAo/d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2wj237u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760105302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PYVEMHVdJ49+bxbOS3d3XXISG+vWJV0m5a54YxhfpOg=;
	b=f2wj237uiut5WnkHNiTg6G6jnWF5sFzKmiIU8HAYxD3gM/iK+MWrDb8e+bNg8RjA6d9zfU
	MZghd7HAfiUa7u6wHbw5SGghuBDwX2I1BKLAA7ZqIGZcIf01fMxM5K0vIbK2wGZY4LB0SN
	oSQZnkVPAGqSBO2FxRTu3Nqz8YKETQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-uYtGetHjPkqKFVjMYCWfbA-1; Fri, 10 Oct 2025 10:08:20 -0400
X-MC-Unique: uYtGetHjPkqKFVjMYCWfbA-1
X-Mimecast-MFC-AGG-ID: uYtGetHjPkqKFVjMYCWfbA_1760105300
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso13727955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105299; x=1760710099;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYVEMHVdJ49+bxbOS3d3XXISG+vWJV0m5a54YxhfpOg=;
        b=naWnnPspIRs/EyUtoWZfVRMD85ObnEN1csPKpSEJNqONresNLmskpQ9UxE2USCMoEz
         moCgKwsIyDq7AYIfFwzcHVERxQF77A6EIIMidcSHQEiOkHksfllob6ft2Eq7T4Bfiqdz
         /y+FqJwW5Y8o3/jA3l2IiJI4DgxOD/PnUIrfjPERcSWtaUp3heUZDcTqLF2wr0cnDcS0
         7GjgE6/w6zm6Y0YYTkQza8W4Pdb2Gs13X9YmOy3wnDGRitiVvjLmUEcbMnH8dTLkCvQ4
         QWnt8v2cI/MzNGoeHjMUlh50F25vyfkSuUGnH6lFhhX2e61jazEmavXc1REDLJCWZCJ+
         qycg==
X-Forwarded-Encrypted: i=1; AJvYcCUVbUB5nTJylvdo4PliyVwy/vsIExJSQlz2GxD9Ea3gd32qLq/sbmQENTeIUVpicF3Mn3bQ1lBSQLmshHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZque1pChluWIRVWLvg5w2A1qlMQhG36dMXThAphL2kx+dLnu
	27v5hM7sKc2GfNiDEQzL5ZtnlRFV6S4nqAyUv3RsEiQqrjFjHWYBMFfz84KH3/6ub7LErP+c9I2
	sJgpuMChMqIArMES5BEFOHzRCXlc3c9wefDNJ3Hc3iZZi5laRvre4lr5DSRzR0nKAHA==
X-Gm-Gg: ASbGncsLoaYTX8I/X9flkuBkX4Gqlv1bPc4ObIRyvA+g9bgApWebIfEDajziEL1tj+P
	9urcfRX/o/3gN532aCzqq4opwlTYqMe3KBKpeewRU8UlOIFmPzHIIvfCOM62ppewJwedS+d7B90
	ujo0OzoKES/WgaYYx7KvR2dsSnBfhDPZoietGtC984xMHmMhLlJgmFu2uaVyEokC8XtgIesmvIx
	Pl6YLil6c0Aj+KbNVAu8BtRIRR6jOMHSgnoIOyOd3MUtX2iV5POBimAIUPSXvtGftcEOwNceoP2
	WuGauZJ6eZ8OAm0VOcvOCI3YyVaGuyo2433mKXBw1z+HVt6A0n28whiLAkU8Oi6Cfy1J1Jd8sAn
	vTJE=
X-Received: by 2002:a05:600c:3d87:b0:46e:50ce:a353 with SMTP id 5b1f17b1804b1-46fa9aa1c5cmr83128205e9.14.1760105299513;
        Fri, 10 Oct 2025 07:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlIHObVAPABnAu5EcY0tKLPigJXyaX44aIR5uNy5jIyRCvW4JMawATPpYqyH9oEC6tab319A==
X-Received: by 2002:a05:600c:3d87:b0:46e:50ce:a353 with SMTP id 5b1f17b1804b1-46fa9aa1c5cmr83127975e9.14.1760105299037;
        Fri, 10 Oct 2025 07:08:19 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4989601sm46900725e9.9.2025.10.10.07.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:08:18 -0700 (PDT)
Message-ID: <06d4d0a5-5cc7-4554-b9bc-7d160bf7a50f@redhat.com>
Date: Fri, 10 Oct 2025 16:08:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] KVM: guest_memfd: Add INIT_SHARED flag, reject
 user page faults if not set
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-3-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003232606.4070510-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.10.25 01:25, Sean Christopherson wrote:
> Add a guest_memfd flag to allow userspace to state that the underlying
> memory should be configured to be initialized as shared, and reject user
> page faults if the guest_memfd instance's memory isn't shared.  Because
> KVM doesn't yet support in-place private<=>shared conversions, all
> guest_memfd memory effectively follows the initial state.
> 
> Alternatively, KVM could deduce the initial state based on MMAP, which for
> all intents and purposes is what KVM currently does.  However, implicitly
> deriving the default state based on MMAP will result in a messy ABI when
> support for in-place conversions is added.
> 
> For x86 CoCo VMs, which don't yet support MMAP, memory is currently private
> by default (otherwise the memory would be unusable).  If MMAP implies
> memory is shared by default, then the default state for CoCo VMs will vary
> based on MMAP, and from userspace's perspective, will change when in-place
> conversion support is added.  I.e. to maintain guest<=>host ABI, userspace
> would need to immediately convert all memory from shared=>private, which
> is both ugly and inefficient.  The inefficiency could be avoided by adding
> a flag to state that memory is _private_ by default, irrespective of MMAP,
> but that would lead to an equally messy and hard to document ABI.
> 
> Bite the bullet and immediately add a flag to control the default state so
> that the effective behavior is explicit and straightforward.
> 
> Fixes: 3d3a04fad25a ("KVM: Allow and advertise support for host mmap() on guest_memfd files")
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


