Return-Path: <linux-kernel+bounces-789743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E90EB399D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7667C51ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261730DD3B;
	Thu, 28 Aug 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9+wJUjC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED830BBA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376795; cv=none; b=C9VyC1KYm9mybDeOKQ/VfZmAhqw71o9yOh4YdMrUjOAIwtQvXYKS6Fad7azsEWS0YsqMZOTLvU3LkiTRfmqa34Fd6izJ9lB8yyqb+bQV6ybos66Y9MgC5o7ZSSNwHCLbWQ8J+1IoXUQfjN9Wi6c9ZUT4FaSik+e4r8dxoaDHjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376795; c=relaxed/simple;
	bh=sh2LcQ6Lxm7TMsk0fKFwAED7+3qWa4eQO4kONfe0irc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f88Z7juRjorneRuV364FQfEAU2giQzddkfKY4PHIVVl94x9BMBxQC6PsXhPuTqESNSkFJeCtyhA2VoY9vGI1fkqd7lVHev95uOK9RTarIlhgxT3Qk/ZCf9MzVdMRm7+83bj/dgMsgYbGheXb9qnkeAEonMUsA/B6vRk9geOkJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9+wJUjC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KriyZgiAZRJDnfHsymUHd3lqzo8k4QI+bEtwKwBmcAI=;
	b=I9+wJUjCWMWKsXEC8F0EIYeIfWv3MLvtWOehQANpiV3rfgilBWYciEDh/NcXFnRoor32Gw
	nGDUcHZhjMs1Jcg5yi+kEPeKhhI7duPWQRGTINrf6CLrWzwUWPeBB4mDAHrN+mMcPa2Xty
	XkJMZff2Kf5DgofQ0HUTmYwZwqiantI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-tO5Qo2ufO16bLXgnqqOpDg-1; Thu, 28 Aug 2025 06:26:31 -0400
X-MC-Unique: tO5Qo2ufO16bLXgnqqOpDg-1
X-Mimecast-MFC-AGG-ID: tO5Qo2ufO16bLXgnqqOpDg_1756376791
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so4931885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376790; x=1756981590;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KriyZgiAZRJDnfHsymUHd3lqzo8k4QI+bEtwKwBmcAI=;
        b=BPNZ4kBz8YGbZPq3hLHQFVZyKgONNHomesxRPY1VdHBMmlpw4EGf9bM/lXFHiiF2/T
         PhqUWMXbQGCAhi4TfHkoMFdvIqiJKOjSKbEDUzOlTya54ZBOc7n8+dds7kxeUgosZrO8
         nNGweEvyOVYwvxgJpk8T+80DuCryqYCR5ai4sdpeYvmXC2b49X9j+Cg4Dh3/g86k5Exj
         /7vLn16oXF2smZpuf7BbL0imngAcFV22hO4yYjPZkSxZa2ueV1twMberO4Oci47ORbdh
         3SEblRcPxBR3Lon0XzyPeKymOesZojURqCUCWJ8h3VbLL9hmq/nzASrw7JrXJsyPd/kK
         Nijg==
X-Forwarded-Encrypted: i=1; AJvYcCUnDyAKmL14JnT0/4qvza9He9pNqtFy8Gd/mdtwlcn/ocF99tgSKrH8udQlwaZ8xXAY80D404iE93PFk2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplxDhr4WB0yQslyhh1m8iLCr0E4AxurlPWL5hcVrA7YY4bcMF
	IOSpGhKMNBtejCO4BW6T6YlX9f5C+jJh3wutScwtGU9nitYGypQ3mlaSHDLoXSp0dE+dmvQqjo/
	poKaK2w6syEwDAVh3SGVucgV7pf0imgRUH/RRaeYSO3EnBiNYLX35diV00gKDbqYKuQ==
X-Gm-Gg: ASbGncsvhrekTbKeFb+I5+TdAUMJtb0vHDG6mZBkVWyk4L6muOf2B10IMowamzwuvos
	Ic6mGAeTTfWx2fPbWP/MVXiVvQw/OOXyVDvp6jZ7unOEZB11p0KJT2ElCCGq8Vsi+NcVmmq2m4x
	/CqAo43KKnQTtoTGJU2tESQC2GxP7Gca6xUL4aT6+gYAlmhQ9G0bGOyLHSxCAzNW71rewV9cgQr
	T85mpGv0pus4DM7Tnugauyz1xqmSzAscA2GM2RCz6f8UzePd2sUzgcqi1iiOhS0Dzk/55bE6OUB
	xANHaRCnDnvbgbRQRgdGls/WT3Ve4EbeWPHR7+mLKv1mmv5/50AafUMAhfwhVV4RezntPP9SDN9
	td5jdVPCa5bR9HZrELb4Y6x4VYglPGlhqowfwdrbGuiWsi8ZZfbsNENdoGHVpSpx6wY8=
X-Received: by 2002:a05:600c:4f4d:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45b62586a5dmr114585705e9.23.1756376790555;
        Thu, 28 Aug 2025 03:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtFlmG2bk+e9nYytQDuLDUJ8uuAXsdALOuDZVwchnxhUM2yFRl9mv4ZYrhg+X+WjfZRuMlZg==
X-Received: by 2002:a05:600c:4f4d:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45b62586a5dmr114585345e9.23.1756376790087;
        Thu, 28 Aug 2025 03:26:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f31d083sm67062965e9.24.2025.08.28.03.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:26:29 -0700 (PDT)
Message-ID: <093db25e-12d7-4372-873b-72f189117936@redhat.com>
Date: Thu, 28 Aug 2025 12:26:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] KVM: selftests: cover
 GUEST_MEMFD_FLAG_NO_DIRECT_MAP in guest_memfd_test.c
To: "Roy, Patrick" <roypat@amazon.co.uk>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "tabba@google.com" <tabba@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek"
 <derekmn@amazon.com>
References: <20250828093902.2719-1-roypat@amazon.co.uk>
 <20250828093902.2719-12-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828093902.2719-12-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 11:39, Roy, Patrick wrote:
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---

WARNING: Missing commit description - Add an appropriate one
WARNING: From:/Signed-off-by: email name mismatch: 'From: "Roy, Patrick" 
<roypat@amazon.co.uk>' != 'Signed-off-by: Patrick Roy <roypat@amazon.co.uk>'

-- 
Cheers

David / dhildenb


