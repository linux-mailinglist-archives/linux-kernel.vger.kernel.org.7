Return-Path: <linux-kernel+bounces-848324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F7BCD692
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38D8E4FE647
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C42F5A2C;
	Fri, 10 Oct 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiAG3GN3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421212F548A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105438; cv=none; b=C11d+ehwddGpRqOI2kDe+bqEsX1Nc4nJRHueAqxPh9sVRs+Kq5qacgm5Hw+NLjiZC3gU4KrrcgNtVRw7lUrRtXAEC3jSO7GSM5mjCkxMjtcDqlHdDKoZtAAarGfQTBh1+8fIaz6mXlOGGaW8G0WuZUd2VNgcn9qOqJFP9C3L8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105438; c=relaxed/simple;
	bh=WnTmIG8sv2E9DFWrV1Hwbbd3JgLJq3uxzP2sJdAHZ+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRZr05nXa5DO1oWSZhl93zES7CIghF7Igp53N5mrjCnuENXAAAY5J9Gmier4Ii5ke190YKZmw+WyyiYhUzSIqaeAT9BKG/Ddlhb0EHTapg6OrTCbjPaECyCSMpyN+d2r2V+RbsQiatwbpAkTvAUE/RmVg44dk2lW1NZ12pPB9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiAG3GN3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760105435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UXNK1UFl6W0l26ln9nbDxXcrbpbOOX+5O3MHtvsZ0hY=;
	b=XiAG3GN3jK5Q8nEHqhQw2BtExiG2FDX3QJTqmSUqNs69UQ8WoIVJP1TInKYoYivtzpG5ot
	mhSZVbyI9xL79OQZ+3N8P+CV6LrwCamcjrwJhxvnsQGlcrHmjEKibo9aki4NnrcAnmYn9m
	/PDL5QSavi8PBriHMTeWwyxAAtIF9RA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Q9fHMijRP2W-dDGJGWj2PA-1; Fri, 10 Oct 2025 10:10:33 -0400
X-MC-Unique: Q9fHMijRP2W-dDGJGWj2PA-1
X-Mimecast-MFC-AGG-ID: Q9fHMijRP2W-dDGJGWj2PA_1760105431
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so1908656f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105431; x=1760710231;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXNK1UFl6W0l26ln9nbDxXcrbpbOOX+5O3MHtvsZ0hY=;
        b=h3jioTdLnuy4+NgoKxBkz4XDlByf/IlwP7Ug8unxFU8Hsy6/O7/VVOXI/3rIH13LTj
         5mxt5yaYdpme4ghVOOmu2RfsYdVnn0Fb2eHeYJq61HO9EUd+xcWiyODunn1Q3ap0Go2K
         kvqWfTilfOK5vsrPXtYE3pbWys7rz3ndAD2himPwx2nCUAd6pnQ9GceGKxB2UtjXp4/d
         ryGR1PTK7M3O6Rm2JNa9SbyKURWXToHtu4B/ioTxZdtw/WIgxRpXP3GhQ0g5rjwoFO6i
         fpX+SRXjg+W2qoqjZ5c/URAZ6as3LJkTyW97Kjkdum9YMn5ds6P+aJzUtl7Nj1DOkrab
         X1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCViKsoB7TjZ2UZ071AO1ViPFkb2bn8vtyly4tbCVeG7unP9NcGRDWk7GmrOe9kGad84kkbdRPRkrJZj7XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi63BK2qIOh+C2vmK5fdmQ13YTtOfRmRxloDQSoT0WWRjgZHmA
	xX8U43avEqMRdlVJ+dnv+hxiQaU+YgDJfY+387YjhQQ+dlvtjQAzoQ25Sj6CzIoChR8iGgF7Cni
	PQFBrO7sd7LtxkNw6tu/Q4NICcG6zyFfeY+nF4VcGjvIsjSn7KYzcguECWOiebSav2g==
X-Gm-Gg: ASbGncsjVM+3t7gtSYB15pR/0g7SKIy/JPQogXacv8JHjqhzgXksy4I8U1ud6vueyCM
	6zHD3RdmTCLba12QzKLK0wOcYgZfVy/iZ6l9vLgXOCeB3CrBSi4jQCO1496NZrL+aElyMtYJMqK
	+qWPOwZ0DlObEAkP1Mp8wvL4kIMa6cqjy/MOZKvDi4gQsR6CP12+kwbwqgXZm2bKfcp1BLiLXT4
	aym1IN1L8TdY1Lw/ZoCxes+EcnR3An07sf3NeGYNPmmT5V9UnKijD5cfenayDCLu7oIDAMCHuo1
	3dIhGbwyJ1qP7/6Sh/+hlStCrGRKqvh5oxb7IfPIszXJAR7ihNmhhNtSNHDMHlGZHyzP0ecWOSc
	0O1c=
X-Received: by 2002:a05:6000:2001:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-4266e8d8edfmr8204777f8f.47.1760105431000;
        Fri, 10 Oct 2025 07:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeDViCkv/zeiFQe+qhOSbnoB6Cx/cQORfdroTZVj8/gk9Wc8lB3fQGvcgICSDxiRBWO4gvKg==
X-Received: by 2002:a05:6000:2001:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-4266e8d8edfmr8204754f8f.47.1760105430562;
        Fri, 10 Oct 2025 07:10:30 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0987sm4329846f8f.38.2025.10.10.07.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:10:30 -0700 (PDT)
Message-ID: <1cb0a11a-e389-4be9-a51c-1b59de1356ff@redhat.com>
Date: Fri, 10 Oct 2025 16:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] KVM: Explicitly mark KVM_GUEST_MEMFD as
 depending on KVM_GENERIC_MMU_NOTIFIER
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-5-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003232606.4070510-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.10.25 01:25, Sean Christopherson wrote:
> Add KVM_GENERIC_MMU_NOTIFIER as a dependency for selecting KVM_GUEST_MEMFD,
> as guest_memfd relies on kvm_mmu_invalidate_{begin,end}(), which are
> defined if and only if the generic mmu_notifier implementation is enabled.
> 
> The missing dependency is currently benign as s390 is the only KVM arch
> that doesn't utilize the generic mmu_notifier infrastructure, and s390
> doesn't currently support guest_memfd.
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


