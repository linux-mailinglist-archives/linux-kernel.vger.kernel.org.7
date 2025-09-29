Return-Path: <linux-kernel+bounces-836049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23480BA89F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23B73C6E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641CC2BF015;
	Mon, 29 Sep 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbvRBREz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA52BEFE4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138089; cv=none; b=Vdwu9kSYI2sF5NR+MFATCBVokt04ceokCWurnfAN8X5/j/VFGTlpve3ATe46bsIRBXO0AtTd1NzNnTyry+9yKheX4/kxWLn2Gq93pOUYb8Hrz1ZhsFIMCwfa9DGbOwlnU1Fek60sDTFbKBDADVXXj6nBr4aEcz58HRyq3Jkdaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138089; c=relaxed/simple;
	bh=CzoqSQAtrHopHmh7+p28qve9d/KAPvjug+Gt5Zonb4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGX0bgTaGi7gYmBfnlxwTWHGkYkqffUhORFwgNbx3vJfsGVzkeu344UUau+hvU7Pza8A6hwSBmLVnG9B8vAwLEd9x7BgBZYdnwQcoGbJRvi2U3uRKQ8JNSuKq3Wjm5JEAKc7mw8ipqAYIH62DRWPAQ+H094w1Kczt8IZCRyydj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbvRBREz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759138086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yulkKep+6RVjT2oprrxgTzmD6j55rnQgjMoMG/WnDdQ=;
	b=HbvRBREzDpz3dqZIPbqzTTqPNKH58nDHJp4Zrza2ARNCuXnKRQfp8Edw08Jvtym+k0lvuu
	ogmkEGuduhX4wooxJfe/sK8wI8+UYdObqAVMOPz5CXY+kJ+yPFJXq2zJZhHEw1YZD6yqTz
	vKPi81YdTsQmncsfAxU5GCITUI09VpE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-mm20dhynNHmKbLF6CsYPqQ-1; Mon, 29 Sep 2025 05:28:05 -0400
X-MC-Unique: mm20dhynNHmKbLF6CsYPqQ-1
X-Mimecast-MFC-AGG-ID: mm20dhynNHmKbLF6CsYPqQ_1759138084
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe81959e5cso458983866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138084; x=1759742884;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yulkKep+6RVjT2oprrxgTzmD6j55rnQgjMoMG/WnDdQ=;
        b=gwYesCBWuC9koTiwvzbdrhwJ+6omqKRuW2vPfmf67Tawcop//zqR+5jum1TIqzM09G
         yJlVXHSDRbLOAQixDQQiVm3qEQhZDhUmYa7VlbIpl505hlALhhEnjCCK9wCAkmxmTN0k
         hOhslB4Pcr87jIrZP0i6XqZvfGQjraaWFR3EHdcgtFssNBe7ybxWOD2HGMBRXitEmL/u
         wUbF+YbAhCxpFxAx0kNsNdGy+hhYKKPQQ9oHBrOXYkvvhiwTbPI4jZr3C4zk4bdhW1at
         73Mqf6WciBcOvLZ8HLcaVfc8Hdz1dkHVx9szI/qHZjPF0u01U4WCDcDS3wwN89IcZaD4
         Zmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXBKgSQQks0wrQno+s0QWER0jUsqSyVHmSoLJH7ad4FfHrQrfQ9Tnfrsy6lt+XPnYCEDql30ouP0yZcc1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcnRWCdngACnIrMZgwzg/1SIKqXLCh9N7D00NYFoOU44K0VnT
	TpBwh/9qfWJieQt/hZTw00zI0gNlu2ypVnTWivyANWuPeOh4mkvG+CSIY9jud7HU6MkRLOT9W/r
	3yNNv6fPEkxCHpMn+VJxCA+5m6HAtAry25aKuxvXxb93PvigAnyDFtTuAuib9cwzmcQ==
X-Gm-Gg: ASbGnctrmJgtjVXJVZ1vq7VVFxOlZdGvbv7srdv80fw48Xl1vPYCrpf0M2ZB7w4BIRN
	1tuJGeXZwJGK7Ofp1IxdbGz6ppIFKWn4LYg2NW5wnUP+u43UQREzYz+8Av+v+RF+tw4NoIRilJV
	gPJAld3b9NUxRIvQUhp43RoFXGn3dZHvnxge7zVEEMVhsYVO2kp6UhwQ1dxF7IlIkycoR2JYsDq
	hjKunP/FbP68sAYIVN/esXZOas7dO5U8YAtPehavKzf2Rl0Ek1iuNl+M1QjLoxHHziIcWCtb6x1
	oZKOkP4PQVj1KIBEIfzaLoV/n/DhIZDbmbEwTHHaHp3yFjgVD0n+RTEMSGCGSA6YTX3QQX+HKNa
	RITIyAY+ESY47QDJXBm8MW7j3mTBdpFlk4aQaJitnxH4vY5fgOfC8SolvEGMlkPbM8A==
X-Received: by 2002:a17:907:970c:b0:b2d:e514:5348 with SMTP id a640c23a62f3a-b34bde10157mr1814948266b.33.1759138083821;
        Mon, 29 Sep 2025 02:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq0hztu3WTB87+2wyGseIxcgiuDab6+e5OPDrFvRNz3LhA7PBFZicfGkKq384OO32+ikAD2Q==
X-Received: by 2002:a17:907:970c:b0:b2d:e514:5348 with SMTP id a640c23a62f3a-b34bde10157mr1814946066b.33.1759138083358;
        Mon, 29 Sep 2025 02:28:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3539347676sm908088566b.0.2025.09.29.02.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:28:02 -0700 (PDT)
Message-ID: <07cb40d8-83ef-4f2f-b07c-550656d454ab@redhat.com>
Date: Mon, 29 Sep 2025 11:28:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] KVM: selftests: Add wrappers for mmap() and munmap()
 to assert success
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20250926163114.2626257-1-seanjc@google.com>
 <20250926163114.2626257-6-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926163114.2626257-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 18:31, Sean Christopherson wrote:
> Add and use wrappers for mmap() and munmap() that assert success to reduce
> a significant amount of boilerplate code, to ensure all tests assert on
> failure, and to provide consistent error messages on failure.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


