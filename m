Return-Path: <linux-kernel+bounces-848317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43461BCD63B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFD2425ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133332F5A06;
	Fri, 10 Oct 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwgwWFYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C628466A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105242; cv=none; b=sjxI2XTU/lmg4tnajOwzFg32/5alS/mTXea+nBSKP04Z2HICrTtxVGeqyStz/tpQj21T8U0/YsgJBL0orIamnyelldN6wwxcDzGERzMImEhQuI7rHsWbse7OjlASgf0a6geVTXcG2V7hoxADdpbJdOYfqAC/Et6ONSLzCl7Hyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105242; c=relaxed/simple;
	bh=I+hiwjpbtW43Uvh23M2Z+GKRbGf3uDS6yxv6cAB9e38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfDaUb4az1C6A/55s2eou7OKCKbn1+tGeGa+OxIx3blJEHZLLG3DhqUoXezi/mOGVIltwTl4VAkG6ql2OtRk8/J40FY9j60HYN92hcBfhr3K/ExgKoW8zeS8KR62vqOlUiwfwkeCCbOnOGfyH9jSry6dGDLKqE4SZRD2z8zvP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwgwWFYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760105239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ED6/HA+TyMgLkFX4gwsj/LTU877hbKyovwZQ2SzsLE=;
	b=EwgwWFYZDD0y986CAZuw/7TwnxG5Fp4bkA/41y8CspvsHITXlX7Y/QCzYpYFx3dQVM7Nz/
	iKiaV7/XWHoL3dTI40wd0Qnt1SIFtwxPbfuBGDgbjw4lXQLjG4AZ5s567Ku9RC4zd2Bs7A
	5BdJKlJGfdD2yK347jGxGxrxfYDnTk8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-TQf-4uhqMTKY4oV5h97I8w-1; Fri, 10 Oct 2025 10:07:18 -0400
X-MC-Unique: TQf-4uhqMTKY4oV5h97I8w-1
X-Mimecast-MFC-AGG-ID: TQf-4uhqMTKY4oV5h97I8w_1760105237
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e46486972so11782865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105237; x=1760710037;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ED6/HA+TyMgLkFX4gwsj/LTU877hbKyovwZQ2SzsLE=;
        b=TQ8kTQVVkLUwidQTbRfHQn8RXE6kMmutsDCY/RveQHks7i6rtuvuoGjvbA5wXnO/Qs
         uWglOkrJb1zTl5iSVj1rT9c9DkD7KBLc+uY8LP5G5/DPXZC93Z9zkY6yx72AdoAF0v19
         du/WTraqeZhMeLy1EKIOkWLzOttmUOxx+lmgFV17oDt5oH4+YbQSrklM87chFCeYgMQm
         NXxmn5hCpvFBV48YCJzqiEFY0CCIVcFqEkOEgleqwmleTupyEMoITx3oUb8VuE+ZN67F
         mSVceT/JjaOV4p6GO8oCjUvVDXrZQVG8zII8IBeQr78v4s2/07/l36A0RszgpNeGyKtL
         IkhA==
X-Forwarded-Encrypted: i=1; AJvYcCV4e/0Pk2ConJbAgGAOtDU52cpvE9MyB5aqhjyNCrwrFqn4E7jvkBTUyvtOHzo+K3Xo+xiy+w9YfzI+R1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YySky7coCh+p6NLnxNzrOG/fOaXO6dCQoGaX4gHR+L1Gwo/W/Lq
	YUIbB3q+W415UIGNmji8UEC+cSGLENOM5zqEHYKDtvhD4pAlSRS+pFyIFLLB451SvzMrh3z+YsK
	WekEQ518qca6hmX0pfG80doaQckS5DStz0S4H6PmjIRPVFUJAneG0E6aOBycfNABQFg==
X-Gm-Gg: ASbGncuffqoc8PzkEgS8jY8foKXrjKvC7wSuB0NerNoSHiUYIVopXpRWTolWCfRGblu
	L7wYa+rtXtdWVZlw3/kH5gwIz0lFaqFgl82CkngWpe/Ddn1kyCXf1WmJS4C/dpOS4YwJfzLsyD9
	PAjUsRYoRGcNIVO8S4njrUFIf8kg+qpqwqfHrk10omEr9uSF3MH2nfZkEM3D53iRq9IEdxaOQzb
	3lLbTl3YOKszZ2eSx1NwB7pEX1k5shIjsyFjWwtDIpEKAYdQ/SwpEUDDlbhLUNY8l2kpTwTDEwm
	I6cs9TwCqq2UOYI/SmDySNAvDN8dUzqYnN1L/f2OTwi6hEs1vdtDjY95MGFYbqHP+JKFAScv8Pr
	Utrc=
X-Received: by 2002:a05:600c:4fc6:b0:46e:440f:144b with SMTP id 5b1f17b1804b1-46fa9a9f0cbmr81521965e9.14.1760105237253;
        Fri, 10 Oct 2025 07:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnO2f2DS3U2JD/GhWStrz63xIoMZ/YTWsJewr2A9DQhoZroZEuNwsuPO06v6JahblpZX9+5Q==
X-Received: by 2002:a05:600c:4fc6:b0:46e:440f:144b with SMTP id 5b1f17b1804b1-46fa9a9f0cbmr81521805e9.14.1760105236836;
        Fri, 10 Oct 2025 07:07:16 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm50758405e9.1.2025.10.10.07.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:07:16 -0700 (PDT)
Message-ID: <b6b002b2-8337-4f04-9f0c-db85aa7859fe@redhat.com>
Date: Fri, 10 Oct 2025 16:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into
 KVM_CAP_GUEST_MEMFD_FLAGS
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-2-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003232606.4070510-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.10.25 01:25, Sean Christopherson wrote:
> Rework the not-yet-released KVM_CAP_GUEST_MEMFD_MMAP into a more generic
> KVM_CAP_GUEST_MEMFD_FLAGS capability so that adding new flags doesn't
> require a new capability, and so that developers aren't tempted to bundle
> multiple flags into a single capability.
> 
> Note, kvm_vm_ioctl_check_extension_generic() can only return a 32-bit
> value, but that limitation can be easily circumvented by adding e.g.
> KVM_CAP_GUEST_MEMFD_FLAGS2 in the unlikely event guest_memfd supports more
> than 32 flags.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


