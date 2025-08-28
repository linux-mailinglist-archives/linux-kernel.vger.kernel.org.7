Return-Path: <linux-kernel+bounces-789980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A415B39DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62646466D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E130FC19;
	Thu, 28 Aug 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vt6m9kFH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB630FC36
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385420; cv=none; b=dsv73zZ9ovgg+bFPSA9Yz6sjFr6TAEYWiyLsE8y/RcE7gWOftI+2oj7KI3H4po8RLJ5NOMTrwfBqd4FD8ZV+FXjAuG7PtFxmLko1IIrBj8p9MRapI4ChhhrsoN0oHYTO5OsKVvz03P5qOdIdocYBxlL1ZupJGw/KB+wWigpRIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385420; c=relaxed/simple;
	bh=F9B87foFu5ArbaO6Wj5uzuuQ1mnMFqS0rUW4rnQy1/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqsww+ABoiIF9kwXCK8ICkvg9f/tfiK9yK1ParlLTnC5XricCQ56paiGHtfoLaK/0hXaMmlO9ayAoReLLNPVVhFQ6AAJlEhxeSSgd6/xFSxPsMz2Df4kx16LeCIATi8W8LU8SLlKG/xiBT2I2axT9CuEkcr1XmMqufIGcfS+9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vt6m9kFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756385417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6iCBik3cJC1ZHjD5Ysxv05sd4NeodNwL7TaQOabYOc=;
	b=Vt6m9kFH+z+EGLo28YBOY5EhA3FDk55H1iE9UdkQZHsGW67JMihxV/6f7n0bHlK4Ct704S
	g3Is7kgQ0GhR1Z8eXfROo0D4PKtdB7wJASHk/R5rJf8QLqA41KrpUaCDcql4sHtDs7hgWe
	VWwONL+21ZzI5qj/ocolYe27NONu9Nw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-joZ6TGl7OSSkbRxirKjy0w-1; Thu, 28 Aug 2025 08:50:15 -0400
X-MC-Unique: joZ6TGl7OSSkbRxirKjy0w-1
X-Mimecast-MFC-AGG-ID: joZ6TGl7OSSkbRxirKjy0w_1756385414
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c7aa4cf187so636709f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385414; x=1756990214;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6iCBik3cJC1ZHjD5Ysxv05sd4NeodNwL7TaQOabYOc=;
        b=FlqiMvkjd3aUU1iDtYCEP8SXTtvdycpIh8+KWsFRcRbqeVRFMMu4hxEfFeks0m+bSM
         LDWnEX6E2cPGfLCxMhLGnzWQEJyaRaysqnt3lMP2zmlml7qiX4MYBGNKpg8x5idGVlzA
         ryLGSmfXlUFUYk6p3HTADs+Kq2Uo/o6eJJM4oTs+F32IKwiOHf4dlQa1NKd+UBxbrkWA
         c3XV0E0Ue4sJvDsE0eO5aRdUYjGK9mECkPPVQIY3IqvisdzE4TfNpoLR/LnUuIJ4/T82
         dIp1Yf4TSmOUTKRo9D97w8uco3iYL9tVhSuqsYrvE5fVl6iNFW433LHkwxbhHzcA1/Wl
         0gtg==
X-Forwarded-Encrypted: i=1; AJvYcCVTo1RY8+z2LjaBS/8htDVHR7GFsGrBCbdTBEw1tZf8AwpifRrip1pYpvc6774oedj4x1G7skBdn34ygg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0bCjNawuK9erCtibaZ2d+cnYqiirW72oYas5YC0X/5kyai9n
	0MRiA89lmX4omZOi11jyLDTWBKBNlvObcqsZK0Fe4nhxjtp/PLmTJhxmPJ8vEyxlRbkoe7PWHhu
	DnQRbVa7TZva+JTIDQYCPXq59uuLXGTJm3WfFe0rhA6VrsOTsUyHxCkfIRkt+fO1sCg==
X-Gm-Gg: ASbGncshwcZvXemn1aZOc4FJs6MLRB0QZ208ram3810jk0jhd4+p7fT/+NmkMJZt6MW
	IYJD79PfUssLCtSIh1yq2kr1lNUaw19Tyl7bd2wgfFEYqUZ7ZTduSZqWmQ9t11GmNDZhBBZ8wCs
	fqEFIX4bR/T+vakM53eWaOsI1fV2TU5iATnev1fNdGAvrGap5rU+UKwY2t2FjUcCBCj0p3xcoXL
	XfQmftSAKRyu0oNQvsvJthYF1yB3gcbVxM1GIG6Fc7VB8SSzJ7riNdQVHBAR9y6/nuEuLdwblJT
	WGb6WzvPq20pXQTFSiZ+zAjMBRJ8kQF9O6eV64S/tRvP08cjdnT7+6nCEXkZyIym87Qd5rozw2i
	JDJH3XR3mpsP79WKfXdkBUn//l4P1cNPiPHo+TVCWIkv8NomyN+sGD7Ghg+uTcKoY4Eo=
X-Received: by 2002:a5d:5d01:0:b0:3c7:36f3:c358 with SMTP id ffacd0b85a97d-3c736f3c59cmr13147592f8f.32.1756385414255;
        Thu, 28 Aug 2025 05:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2soHNJz3uNCh9kCpxwV5zoV5iezSYMFN+6bV3UPfCImuAc7IMpQupU9NYnIVeAMq/TCo6Vg==
X-Received: by 2002:a5d:5d01:0:b0:3c7:36f3:c358 with SMTP id ffacd0b85a97d-3c736f3c59cmr13147562f8f.32.1756385413775;
        Thu, 28 Aug 2025 05:50:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba44fsm24519526f8f.5.2025.08.28.05.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 05:50:13 -0700 (PDT)
Message-ID: <a777f88b-ea12-4aad-88da-2e7011e151b8@redhat.com>
Date: Thu, 28 Aug 2025 14:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] Direct Map Removal Support for guest_memfd
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828093902.2719-1-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 11:39, Roy, Patrick wrote:
> [ based on kvm/next ]
> 
> Unmapping virtual machine guest memory from the host kernel's direct map is a
> successful mitigation against Spectre-style transient execution issues: If the
> kernel page tables do not contain entries pointing to guest memory, then any
> attempted speculative read through the direct map will necessarily be blocked
> by the MMU before any observable microarchitectural side-effects happen. This
> means that Spectre-gadgets and similar cannot be used to target virtual machine
> memory. Roughly 60% of speculative execution issues fall into this category [1,
> Table 1].
> 

As discussed, I'll be maintaining a guestmemfd-preview branch where I 
just pile patch sets to see how it will all look together.

It's currently based on kvm/next where "stage 1" resides, and has "Add 
NUMA mempolicy support for KVM guest-memfdAdd NUMA mempolicy support for 
KVM guest-memfd" [1] applied.

There are some minor conflicts with [1] in the "KVM: guest_memfd: Add 
flag to remove from direct map" patch, I tried to resolve them, let's 
see if I messed up.

https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/log/?h=guestmemfd-preview

[1] https://lkml.kernel.org/r/20250827175247.83322-2-shivankg@amd.com

-- 
Cheers

David / dhildenb


