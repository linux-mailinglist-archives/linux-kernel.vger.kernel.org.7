Return-Path: <linux-kernel+bounces-790641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE458B3AB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BCE5648A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1D283FE6;
	Thu, 28 Aug 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR0At5W3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEA2777E8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411331; cv=none; b=NxMd4p+UvISGrO3Js+ZpVzPtvICh51luxXownWcoxYs1Hqvw08Iq2kzcpXyrUhDMm7hj84VCfCrrIwyao5p7ZLy3JGAPSqkKM9XL5wyUysRx92/ejvkJ3khoKdKc2Dnq2KqA5UKXeUtTO8Aj6byfn40ghwrF1f+s5UYQuqGT+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411331; c=relaxed/simple;
	bh=2KpL/YbmEXnHuFTvSMBKGQC8nuR4dgX0UfBNcS0nW2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsQGz5s4HBrhGS+sRP8s5EmNULEedx3UUIMjjpuVn4umK32tKI7L+k2TLIVDAb40gmIkLfOw7GSu8dSv2dQrXCbIF9O2pEnF5aH+o5le1It++g+9pnn9Jg8i3VMnQFbHFz4L/sJjsGE8AFnhOp5eDlxYfnU6rSUplCxWq7y7y4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HR0At5W3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756411328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHCGitpqD+5wH/FOTflpYSjcwP5kCCQ1zm861x/hElE=;
	b=HR0At5W3BQvB8xPvMXfyBa78lVwIyYbfmY+Lkp4yp5GcWG1jVI8X/ImEcxdGoRFYR5c8dO
	692lLh0SssRKbHlxM89i9SxzDj+BBt5+SkNz+Nm3I2KibFTynvwIKnXrt711LVlxumoicE
	LeGAJXV9Rfj7cynRQ5s91SgnZGEN2cE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-YIbrZ2eLPQKa5x8uzbzN1g-1; Thu, 28 Aug 2025 16:02:07 -0400
X-MC-Unique: YIbrZ2eLPQKa5x8uzbzN1g-1
X-Mimecast-MFC-AGG-ID: YIbrZ2eLPQKa5x8uzbzN1g_1756411321
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cc3765679fso524394f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411321; x=1757016121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHCGitpqD+5wH/FOTflpYSjcwP5kCCQ1zm861x/hElE=;
        b=hkBqKrhCmPLslH1VIVk5DFRCzGsHRJclT5g5LLFMhQGy+7eOQ+nG4uJgH3UCXk1ZxH
         H+3YIIFN5jqKbYBNeAnDl0nR+qc+Ol5mQqms/4zHKuQ4/v2/Vh61BsGp7131L0iH/nQI
         39fCyqyS6LwpTPAyi941869Hy65uJqNo/E99eAgT0S5oGayJ9aKyvH9z2JA6ZdOPfBNi
         zeWFHUJLkw5qKLYi9q2IO/DwUOctmvBnbnojwyzrVe0cKayo6XajrbsiA2lFdlyP1hoT
         Reka9jkT1veLlfi9XnpUAsPAumo7+TEfj4H4oyFyccQHdGi1wma9pJ6jQI9yOXJ/+Hpc
         b65g==
X-Forwarded-Encrypted: i=1; AJvYcCWw4TZHPh6vWbRWSqX3wpctpoj0PRREdLqaxHoz/ByBeUNirXYosEaJC6tKXv5ZgHrehePTqUF6KO8mql4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhlvWThCVDaf9u7e6ORhcSYn4AF2AeM2fzTVpFak0RIdQ/W+r
	IDIbu+QzUK6ImnJ6gr/1xqETkLvF+7UspDcc57wYfHRA8VCx9kK71tfB1FkJvSmk3rKiR1E1g9G
	eBOmI0b2IV7vKc17xnNo0cxpeJN95n5yXQiJAlWKUplm9l1UA7hwrJsYO9wnlRsOrwz8/sGZNbw
	==
X-Gm-Gg: ASbGncvYQJk9wdXKrsSS18zVukDL1/IGYlcz+sgaaoinqBERxnCSYMk97+dQOadvdeF
	D9ZJKjsscZc9E+62Oe3GUXgkvUiX60s0USrVOpkUW851WU4x/55uMxSgr+d8RQuAeQsqirTlW1u
	ic054ikj4mfEbI/0ZSWcgpcB/vmEFFLIx8mkERRQou0uoW9k/sOZqRLATqaloXKWM/gGf9qB1QQ
	u29bJk+D5sOGwbO9yMjcik9udWtfuJvWTuXG3SRfIMIU1gNgPNcO6iy6rmT8vc0vbpeS4Qku7lk
	bEcJoTl3ETEQq2+dqvSzJAXuV1mys7IxVIBwBDQgX7AufSfhyYmehP3vIdgAPl1ufK30jGTZtYV
	pplUDBJhCT1385hr3uJM82rZaY/JKiJZqgySrXsSEHMV8D/+f8Od4hWpjbmTwHQIKxlw=
X-Received: by 2002:a05:6000:2203:b0:3c9:9b3b:53c9 with SMTP id ffacd0b85a97d-3c99b3b586fmr13112446f8f.44.1756411320643;
        Thu, 28 Aug 2025 13:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfxknfutCFzm6P/qKfs5UtdmvpY/7sBFiB6PROkHg4xXnNZaYtYUH5wqWfppKoahFU7sb6A==
X-Received: by 2002:a05:6000:2203:b0:3c9:9b3b:53c9 with SMTP id ffacd0b85a97d-3c99b3b586fmr13112421f8f.44.1756411320141;
        Thu, 28 Aug 2025 13:02:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73cf86f4sm67580865e9.6.2025.08.28.13.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:01:59 -0700 (PDT)
Message-ID: <d58425d4-8e4f-4b70-915f-322658e9878e@redhat.com>
Date: Thu, 28 Aug 2025 22:01:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "shuah@kernel.org" <shuah@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael.day@amd.com" <michael.day@amd.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
 <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250828153049.3922-1-kalyazin@amazon.com>
 <20250828153049.3922-2-kalyazin@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828153049.3922-2-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:31, Kalyazin, Nikita wrote:
> write syscall populates guest_memfd with user-supplied data in a generic
> way, ie no vendor-specific preparation is performed.  This is supposed
> to be used in non-CoCo setups where guest memory is not
> hardware-encrypted.
> 
> The following behaviour is implemented:
>   - only page-aligned count and offset are allowed
>   - if the memory is already allocated, the call will successfully
>     populate it
>   - if the memory is not allocated, the call will both allocate and
>     populate
>   - if the memory is already populated, the call will not repopulate it
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---

Just nothing that checkpatch complains about

a) Usage of "unsigned" instead of "unsigned int"

b) The From doesn't completely match the SOB: "Kalyazin, Nikita" vs 
"Nikita Kalyazin"

-- 
Cheers

David / dhildenb


