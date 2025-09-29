Return-Path: <linux-kernel+bounces-836010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D609BBA892A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AF5188D22A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194342868A7;
	Mon, 29 Sep 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghLjkkzB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679426CE34
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137459; cv=none; b=WIowqi5Sn92UvKDjuzA50B5qV8mYIS9hLQpPD4Sgh12hpinMQCSoLl26UJedZTbhrlgPq8adXfJO5dow8sT+Cq0ft3QIRVTZGMySeDarHYtx/7rGhYg2oFV2OYyy58TbboRoboa6HDDZe56wKgd++4vTEEvy0uonSCiTYWrXfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137459; c=relaxed/simple;
	bh=AEKmXlzqnRXKtFhrKZjYt9Nz8CNoTLV8a+jAIEQEWJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2glLt3/NjQHLQgz39ZVKldeFYPM6U5xb0LZv94Uvn2rjvbnS2t4JArsCzjSXkVEjNTNxwf61hi7KhMX7sQQFY4Jz+F1i00fGP0hh8j6TJiBBQBaEkViZR8nMXWX6bhU4EaYvCDhAL/v2FikmIFW+EG94OAvbyXNeNTUWmZCbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghLjkkzB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759137456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yirsZdfRpO7otxNMqYHFHsd8rv2y5Q2HXTbsU7+Tu6M=;
	b=ghLjkkzBBSAb/eVHG2X6wY0XXwPo8++3N+hEKqlCWy5iWctdkcofqbjILP+SJs6KwxmenS
	Kv3QWmbpRsYL+qZjL+iJEro2eMTYzoZEfeDZYrJkD4uESF4hdETWxziAY/vfpIP5LI32ma
	nJ0kBfgC1HhdREKrVGUDvo6GIXdFl5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rml97pPQM1-Xo35bZxnaYw-1; Mon, 29 Sep 2025 05:17:34 -0400
X-MC-Unique: rml97pPQM1-Xo35bZxnaYw-1
X-Mimecast-MFC-AGG-ID: rml97pPQM1-Xo35bZxnaYw_1759137453
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3dcb36a1so20435265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137453; x=1759742253;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yirsZdfRpO7otxNMqYHFHsd8rv2y5Q2HXTbsU7+Tu6M=;
        b=OLDmt8TC5nslZ7epOET/fUv3CxGw8Pd+d+LTFCFFLOPgLQ8it7j6qdXd6e0OSOXEIq
         M3ULpHbB9ms0ga7znZAQjlfq1RecO2nweUrdJed2YAoePo4qlPBTHvftjj04/ZkL3KGB
         aYpEzJBXSs4O2PHX5gPwqoJSc91NbENNTkK+7FY98dceNuoVwO8TUO+iEjIDbg0OZWkF
         MMCmtUc7cYNK2upifYPr/xyHWrowlCEyHEqwuOSiG2mg7FImmbn3ZZyu+jFaFoA4nW5R
         djEhbddLmPylSV0d1GSkMgMDTurNx785TjDOzfk+ZXv/ByJczLXw5lTIz9gkHhm7bNu9
         Q1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxHeLRwhieG4F2yG31UYDE1WsHrBYsaO6ZJtPny/WDwjfk1BcmNJL2aLY4DCcbRTgcnUolCc3UDJmZqFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3HJaHmmXwv6wXBdiNXFaNsR3bRqNi7RVSyA9TEKwzP6xxtcI
	xWPrKXP5MlEqkVJYhHyoU4GURcTFYpLhugGucD5u0H2AsQvqxlOiYKPCLF2pACvijARIrLxfwzX
	jqMgYnhMt1bo4556IOOnmYWNsTWEUOoMNYQosmu2meOe6uPlyBp1ZPdeAC3h06jcz2Q==
X-Gm-Gg: ASbGnctgvZjT3zPJFFD3uV2/xduxBXTPPSfuyxDtcH9kE28oWRkmVUNTaGItVQYiQCf
	k2VGVIZ0tI6nnev9w7t5yyeK4Yn+tgy602jmt8FOwa2kJMHbb70HmWu+YAM5W7rOWA4TgHCojL9
	fANGzJvnoYDY7XPyd3XOXYxyqQZoWLS6EwPgwWUAK+N6FV56DWEiux8IDHh5s5EFowIHmD2xQWD
	MG7rcyenH6Ej0iNAhVfm1dU4c17geOKz3j4eJqwmWwfOuKP1BTxMZ7yqTGIiRtzGwwh9btgo5yG
	J9AZDWBacZJnMzE0RjXayYaDdXx4NBPq7wJ4XuZ/qrHOzlqz4B2XVCWRCNxQ+eH7+v5G1w3CxSI
	jTC0z1cgXiIioUI1vFjZE8JPiIXTV16UaxASZaunjiYRYO4y11onDCFakIys12hXMOA==
X-Received: by 2002:a05:600c:4511:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46e32a54d21mr142727615e9.34.1759137453408;
        Mon, 29 Sep 2025 02:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Y9osOQveMMPpE1LUVYfGQ3xu2SHSNygP5Qn6MRLfg6MCgJmll3A0HA+SRU7hQaBJuTHQLQ==
X-Received: by 2002:a05:600c:4511:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46e32a54d21mr142727165e9.34.1759137452954;
        Mon, 29 Sep 2025 02:17:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e42eee0b6sm106927035e9.10.2025.09.29.02.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:17:32 -0700 (PDT)
Message-ID: <9f467155-cd6c-4d14-8cc6-357ffdd423bb@redhat.com>
Date: Mon, 29 Sep 2025 11:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] KVM: selftests: Stash the host page size in a global
 in the guest_memfd test
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20250926163114.2626257-1-seanjc@google.com>
 <20250926163114.2626257-3-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926163114.2626257-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 18:31, Sean Christopherson wrote:
> Use a global variable to track the host page size in the guest_memfd test
> so that the information doesn't need to be constantly passed around.  The
> state is purely a reflection of the underlying system, i.e. can't be set
> by the test and is constant for a given invocation of the test, and thus
> explicitly passing the host page size to individual testcases adds no
> value, e.g. doesn't allow testing different combinations.
> 
> Making page_size a global will simplify an upcoming change to create a new
> guest_memfd instance per testcase.
> 
> No functional change intended.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


