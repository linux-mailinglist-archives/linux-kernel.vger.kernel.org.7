Return-Path: <linux-kernel+bounces-756365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A7B1B321
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD11667A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E926FD87;
	Tue,  5 Aug 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3vlgZOf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C8242D99
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395924; cv=none; b=CCFUGljqsZF8wGPWnxvx3j0lXH4w8TSwremR+MgopfAmoV2cZz0/wl89wvXwD+fnuIvAFAO+OMaNMMxhVn/qZOHhZONPdIei9gAr7BmaueFjDWMvyzkQRzVrQy1m3Qb8LoQLEzwBhp4rUbneVswFup08XWDAsncdCrpVolyFYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395924; c=relaxed/simple;
	bh=PkN2XX7pLKcIUWqfRErxMi4SNlpWdneWn9/g4TS296g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqMhXQqn6UVdc884EMV2GYhUzT+l1Xg7/oyLMF6RHKxs6e6hGS0z1p+rEG7W2j05ZOc5u20t/QynNOewF4zinO/e18/WYY9Eot+CIG67sX9noe7+pRdc0h4ECQIpDOXrxFOqt4UXA0vzjIXc71THnZK8we7s37HblMgySyS84Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3vlgZOf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754395921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SILdafDIUq6T1vxmByNHoLz/yQ+KxKADC56XxDUmCig=;
	b=e3vlgZOfrho3yMxs/tt04e65k3T6GBxaRuNIfNrWjwaRJ3bLWJ2k6IGjCKs16txR2bBm7Z
	SZCMzlkyn28y/mfbMTVrG2CbYMDvE+xDQuXZbL6anSPEVtrMoHiqoAiWo9M3AhlPlUmyb8
	CzIHhO6BFET+mo44PbrcEEYypx80t/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-SB_FpHfcPiapXblA7DiHuA-1; Tue, 05 Aug 2025 08:12:00 -0400
X-MC-Unique: SB_FpHfcPiapXblA7DiHuA-1
X-Mimecast-MFC-AGG-ID: SB_FpHfcPiapXblA7DiHuA_1754395919
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d5f50a07so11784305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395919; x=1755000719;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SILdafDIUq6T1vxmByNHoLz/yQ+KxKADC56XxDUmCig=;
        b=bytLlQmnTnFXuCOsKjSZzEpnw4aFwbq9i9hCAsJqmlv0zStyRtZ6t75K7ITslzwPsB
         qw5ZkOB3W9QKdYjnl8ITbFPatjwb3dHtwJNT3SF+5nsm2ljeBxP04FQD+asHi+eNUTrB
         kpDjEkf2L7EBl734k+QOCL+Odl93TEWHjfUH7u3SSWZm/XTQB86inM4gSzdYSnYw19F+
         Lnfjkqtg+/9Xacf6kWdsbL0DyZ0U7loMpOD3pxq4rqPLaCwNX7DYmRxcycNUxHLoQTmc
         KllGnQ/slHF6a6qigPvdLg5+wDq3OR8WL1kM1lUU6dbCzP3FPs+MZGYIcUJD3YvleZHX
         Q2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXqPEaEuSDu79Er8faS/3bo5oFQbJYeHI9I8kQ/M5y6Pr0dag8M4MCo+0SDzvwFTDYqAv6N6rmZwNtHyC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ewu0RTonRT9DzSml9D2XmuD2cf6YJh6UEf+ZkwMRX10gNULh
	iIlcov85BgRlKcW5PZGlPmlCZqq9xzftA8B1bdZkJmENmqtQRayGnHxT5TeSfttES6nMuvi2A6S
	w5BhHBpkJHQiK8LjpC4gGlXtq106JtuzM4Mq36QqxIIYn5N2kcPCZj06aODzJALQaow==
X-Gm-Gg: ASbGncvOasRB20VNF2y1uuwZRTUaIfYPjZv4nng5sDXaVmEaKsX04g+ubAO4elHd3Gs
	ChzCNBIoGs58XRTObH+vbzDdef5DJuBdacIlGmGCuj8/knwDlUh/s54azhtWiPkCAMPvDItdlBK
	2+aUt0JT8jWWg6av0mv63T2H+nrDk0GegwgyEYPfhNo1b+cY5Gk0+CxwE84uZOrwI4c2Du1v7hU
	lj5JPi3ovLFCzGXNLg/KadTAtiyoLcqL7+H3sjakPeHSg4Gksi0LIwEpUgU7Tb9bIU7VB3CgnM1
	9S7J1zdmIb+kzPMykqCCdTF/ThKLT9LkYrHEpvXeV0A3FJSzv5v9dTCdighs4+M4L6sE/Xys9n0
	UV+9JuMCUW/saGS0wIYxBG12abyD3c5xzxmI8+zPzjGHr1QXhiI8A9V4uNd8nIpD0Gvw=
X-Received: by 2002:a05:600c:1d08:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-459db5ab3a2mr48234235e9.28.1754395918793;
        Tue, 05 Aug 2025 05:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxZPzHZOSJwMEcCot86poc9UZ/c44aOsLDwgU/vzU4XSjaGj8F0yKq7r0fWaYJ4jtRH1ng3A==
X-Received: by 2002:a05:600c:1d08:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-459db5ab3a2mr48233995e9.28.1754395918402;
        Tue, 05 Aug 2025 05:11:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm18618858f8f.33.2025.08.05.05.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:11:57 -0700 (PDT)
Message-ID: <0c778373-3805-4dd2-b8ac-97d5ce77235f@redhat.com>
Date: Tue, 5 Aug 2025 14:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, nrb@linux.ibm.com,
 schlameuss@linux.ibm.com, hca@linux.ibm.com, mhartmay@linux.ibm.com,
 borntraeger@de.ibm.com
References: <20250805111446.40937-1-imbrenda@linux.ibm.com>
 <20250805111446.40937-3-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805111446.40937-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:14, Claudio Imbrenda wrote:
> Pass the right type of flag to vcpu_dat_fault_handler(); it expects a
> FOLL_* flag (in particular FOLL_WRITE), but FAULT_FLAG_WRITE is passed
> instead.
> 
> This still works because they happen to have the same integer value,
> but it's a mistake, thus the fix.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 05066cafa925 ("s390/mm/fault: Handle guest-related program interrupts in KVM")
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


