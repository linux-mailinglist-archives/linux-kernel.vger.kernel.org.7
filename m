Return-Path: <linux-kernel+bounces-836050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B4BA89DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29DA1881EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED21FF1A1;
	Mon, 29 Sep 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALNZfKad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97221578F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138140; cv=none; b=K003ui8i57nsuSWcRds1cQuz3ktSRD0PEsNq6hsmJbBarHinI3lg2uCFv4gqdjL4uaE/iKovTZhFgq983yAykxJUun4OzBGs/4yHxELhzqfe5MJOj8cWqXmRt4tXFDv2D7jaEoGRcWqAiyYIeSYZLEGZ4THx/cl9yRllEi2qizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138140; c=relaxed/simple;
	bh=9Iv/YKi4vWmW1Ixln+NK3vRNp+MgtI2uqSJRCvisxvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir0JExfn+TpyPjxokfC4fzJLQZWhsVq1PcL+gOIVrurPKWRfsWBVn6wOV04RXfSzOIReLRwRgE9N/+SKDrXdBYrbrntdnic4g3ND1mpTWIaBjP9toB69fchNSKEjv0Yr7BeHgRZwFm2TawDABqemGg2a3e0UV0m3OErVQZGq2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALNZfKad; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759138138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uFkqt0GKSONCdD0Ht/pmTUQIhyf3zin58Hn7YjIOo84=;
	b=ALNZfKadijhd7Nl5aP5YITR+XPE+mMwh2RJ1iUyweWg9dymL6UJ+m1V9r1LlZhromCwDe3
	FhA7R5W5IO/jj1qu829WnCV0mK0LUTpEX93aHGWipCBwdJ98oxmuuH3iDrKxI7hhFoK/e4
	30C9fqWbxaEEntNV7tzsmctfiLXl9WU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-2ljB1uJQO7Wzn2u9SvIgSQ-1; Mon, 29 Sep 2025 05:28:56 -0400
X-MC-Unique: 2ljB1uJQO7Wzn2u9SvIgSQ-1
X-Mimecast-MFC-AGG-ID: 2ljB1uJQO7Wzn2u9SvIgSQ_1759138135
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so2324672f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138135; x=1759742935;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFkqt0GKSONCdD0Ht/pmTUQIhyf3zin58Hn7YjIOo84=;
        b=Xu7DVUXnl9arAtzb7jVkgmLj43OHCzyWHB9VgPj8uytyCiGZsv26aA8IP0xMiqESzP
         8RaY9p6inZgyj3hSdaCJ+oPINakXXWX11wWOOWuT6jWxy5FVTs6ybPG7eNI3br+oZZP8
         qMiP8TTumzTpgkAXzsMw49zahKNqGlJwqbVxee8WidtP97m117F7xa3pGbIQTtyiGluY
         B3atgzBsIj3/bDR5LSzRjrSlxD5S3dInjTAKlGMBOuwU9kKOWVIhlz/aQI7mQ1gIJBqH
         vHAao3u+FXaZVruc5Gx5CO/+2Uv6o9BKbt1UxHjsvzXCQzYq3fk10mtHu8AFl8pOwdP4
         49Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW7QrPWetaVWoDzVMU2qWAeWbHjt2jQEoJyPTRA0WpkUxFBjenzrUK7HwTOqkxdorurd+ptLnffX9xxp30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TePZJdoYLEd4QATAFxcnICR9kMx1vyg6n5x7X2ATOeCtbXt6
	K694vX/usMzTAQGSYCr+6lVTIbiMpxLZZ+hVUnrTvmliisjNlFeSz6+ZswHAk4PVknIMe76lsiK
	hUQS+4POXfvvS4oyVnsF6vYUIkmha8Fzp2iCTvOjLuT6+ZZ/YVtecZOoM6wNS8S3Xtw==
X-Gm-Gg: ASbGncsj54TXpm74gXGqhuy9WSZOvxbIR7JjMBne9QT1Zih1dB80w01KsYpIRBovMkS
	mrBjfxFk8VgWwAKKPUim0rj5ShrSAjSoKMdmiCTsdgN4JWY54a8qE6s/ljlzz/q1vcGQs43sxjq
	fAbeQEVfDgtcZ8GCNTY2F1XsRxfwA1A+1svnppGhApx+zt6KQEaVxNoTg/ZGt5RngzIw7DLEM6c
	xoxZpaFKXsN6ENlYe3krjlRyH81azae7AKt4JMmFTWe+WkPSdNsA/0lEpqWul8mG1Inlm/LqOqh
	dEf/BnPtIzklhLAoEGH9nbQIcKdif1nDIufWoZdGzA8Ov2RlHBMS5a+qs3Oae+mT4QDSlgtpf/F
	9WByDdufbzW4ZdpoJ+m7ZG/NdQtqzoGwTpHAYn1Dgy24Yd4iw35JhyMTDL2UYxct9cw==
X-Received: by 2002:a05:6000:310e:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-418006e9436mr7736208f8f.10.1759138135481;
        Mon, 29 Sep 2025 02:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhj92keFT9kI7se9rXn87mbCWcrzPoba9ngrzHqfBYVZUSwQh/f7s1gufI5z/APklWGCpBjg==
X-Received: by 2002:a05:6000:310e:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-418006e9436mr7736181f8f.10.1759138135076;
        Mon, 29 Sep 2025 02:28:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f536a3sm6047565e9.8.2025.09.29.02.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:28:54 -0700 (PDT)
Message-ID: <69695cae-3b1b-4d5f-8616-6de1c804b6f1@redhat.com>
Date: Mon, 29 Sep 2025 11:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] KVM: selftests: Verify that faulting in private
 guest_memfd memory fails
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20250926163114.2626257-1-seanjc@google.com>
 <20250926163114.2626257-7-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926163114.2626257-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 18:31, Sean Christopherson wrote:
> Add a guest_memfd testcase to verify that faulting in private memory gets
> a SIGBUS.  For now, test only the case where memory is private by default
> since KVM doesn't yet support in-place conversion.
> 
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


