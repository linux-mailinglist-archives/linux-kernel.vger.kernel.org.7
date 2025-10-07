Return-Path: <linux-kernel+bounces-844117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8205EBC10B7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897FA3BE58F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B422D7DE0;
	Tue,  7 Oct 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0ze6s0L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2B2D7DD2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833973; cv=none; b=b12hgCUhg8J7EDpA9GiXwaSNZveOlhD150VZvPlujRbstQXhrC44+QHQKchfshEWDHCmIb+qUjboxbcQEC3dawHZgm3kEXy84dTMR6NSj1OWnB4tqsgIPKt1VwUrRWJ7V7Fd6fO6xWzhd7oHxWbR7u+1ZHCDcA0IrH2oAH8YJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833973; c=relaxed/simple;
	bh=Y0k0amP3nuDhEI8J1gHNZ81t5g8iY/ZgH1kXTCtwBZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHalFIvBIxXgaBVnKk+lYmSmS3UdjCQ079aguDHAH4Cu8v6Y3Nxp1zJk8VanKAuuk+mscMtCHnfs42oTq9p7ca+LCmy4297ZlAc4/W8hIZ6bmBV5LeW5UVPKYo/3AX5/cHJn7bcNfJ7fYMEgVrfQLMgfvIUaju4et9aj7kW5b9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0ze6s0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759833969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9VU+jqnwVitkeTtQ8eX0acgMofsePeWo2o0ZHkAt40=;
	b=B0ze6s0LFB+82cgHKqbbGxUhGQkdcCkmnHp6cUUwk4gYIv42VgiAM0OsES4GmKDs2+w4eO
	sSMvNaO6a71q921/f9lqz+YYwnZ+jkamp3eDazeSSWVTxkH/MlXKc1JAeyJYcOf64lGjto
	iSso2y9HMCFrUr62yALWskABwzv9rnQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-h2jXfJGFOQedtUcET-1awg-1; Tue, 07 Oct 2025 06:46:05 -0400
X-MC-Unique: h2jXfJGFOQedtUcET-1awg-1
X-Mimecast-MFC-AGG-ID: h2jXfJGFOQedtUcET-1awg_1759833964
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4256fae4b46so1916139f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759833964; x=1760438764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9VU+jqnwVitkeTtQ8eX0acgMofsePeWo2o0ZHkAt40=;
        b=e7wHt3pSeS5SD2e6MdBFAX1d8CIYB9diUM4T/Gtpo4adDVkV86w7EbNt7EO2p8p4yZ
         GNlRcb8aSgrFb/ZtPSM7a+3i6hLsE7LX3rKdcADmxSckdPy/kWj/fVq40nRdDCYLnDrR
         aEzrGU6H5/Ydh7OOuo8aTh05Kkg/pyL7Q7KzFVsM6mj4tBmixShKNNtHoZcJ9YhukEPE
         FlKLS6SsmG6/KOGvYM+tfxRTemu3VjgndFkY3Q9RfumnCCEoh3LtEZkFClKGkq4YtWuH
         r1MF13pqox1KB5zXtQpvXXmE4uHPXUD93fmU0DOvQVuFvTNMAlpMtAadqxy+NMdlgdjU
         a43g==
X-Forwarded-Encrypted: i=1; AJvYcCX3p6H2PxXgSeWasvyJPyEaecMNA8ut7lY3oYSQmQVwLg8WgCcX+iRhzAv7Bi/T4p4U9FTj89ETiZcspbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynICZLxhUcJ2qE4Z08MEdwTITODj8zSx+BpLJu4k6OA5G59ukt
	uab6hecWO5cfN2EbMGzL1Fm8frepox0BOp19ZPHBck58cQvW72o5ZeE7MOGt71GpzkI064xvtqF
	fGj9LUOPejptsLToEbiyI8C9N3W384azLW/fHXOYBiiDi0L8XeHDy8tAPF65Ab9mxMA==
X-Gm-Gg: ASbGncvEYDbXQf5Ye+sGi09nDMUhuyZ2Nhae2yuZ3rPOAMwj6i4ascsBRhstRK+9iZM
	9UkhZK2WDVLj3iCe5ksVyZKTILXnmqS0g7PM8L33BtsEybik5lDWIJZum4wWK9Wsf2lzr7zKDs8
	OzCvFkKVNXIa0U6fV8lp1sWmhQuhuHRBgMcIsEGwYxCeWL+1/f1DIuCZsyl8Gd+1mu60k2Sen7K
	cRFQUJj821fxTKPJw37CnVRIymRrB6zAf6mWm5JCwZvu+12s/av+q46UtK4CDeBqf/dtVP+RsJj
	6435q9pdtsi8pvGvn8vW0ui6SRgKSM1V4AIhQo4Fm7bQqxCPSttb0v+U5bwd8ZZZ2yRfvEKzGpO
	o6bcU9aZxiOddQ1bZNA==
X-Received: by 2002:a05:6000:22ca:b0:425:8462:b72e with SMTP id ffacd0b85a97d-4258462bbfdmr1377573f8f.3.1759833964476;
        Tue, 07 Oct 2025 03:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBvJuFM0sqIDpEJ2XvBbC5K5crNEII49Po+HSOIfY3+6fboEgfBtuEHBtoVUPTDo55dxcAXg==
X-Received: by 2002:a05:6000:22ca:b0:425:8462:b72e with SMTP id ffacd0b85a97d-4258462bbfdmr1377552f8f.3.1759833964096;
        Tue, 07 Oct 2025 03:46:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm301706355e9.14.2025.10.07.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:46:03 -0700 (PDT)
Message-ID: <71dda358-c1f7-46ab-a241-dffc3c1c065d@redhat.com>
Date: Tue, 7 Oct 2025 12:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, khc@pm.waw.pl,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
 <m3o6qotrxi.fsf@t19.piap.pl>
 <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
 <d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
 <m37bx7t604.fsf@t19.piap.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <m37bx7t604.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/25 11:28 AM, Krzysztof Hałasa wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>> If v2 is not ready yet, I think it would be better returning "unknown"
>> instead of "LCP" when the protocol id is actually unknown.
>>
>> In the current code base, such case is unexpected/impossible, but the
>> compiler force us to handle it anyway. I think we should avoid hiding
>> the unexpected event.
>>
>> Assuming all the code paths calling proto_name() ensure the pid is a
>> valid one, you should possibly add a WARN_ONCE() on the default case.
> 
> Look, this is really simple code. Do we need additional bloat
> everywhere?
> 
> The compiler doesn't force us to anything. We define that, as far as
> get_proto() is concerned, PID_IPCP is "IPCP", PID_IPV6CP is "IPV6CP",
> and all other values mean "LCP". Then we construct the switch statement
> accordingly. Well, it seems I failed it slightly originally, most
> probably due to copy & paste from get_proto(). Now Kriish has noticed it
> and agreed to make it perfect.
> 
> Do you really think we should now change semantics of this 20 years old
> code (most probably never working incorrectly), adding some "unknown"
> (yet impossible) case, and WARNing about a condition which is excluded
> at the start of the whole RX parser?

Note that the suggested change is not going to change any semantic, just
make it clear for future changes that such case is not really expected.

And that in turn is my point. If someone else is going to touch this
code in the (not so near) future, such person will not have to read all
the possible code paths leading to proto_name() to understand the
assumption in the current code base.

Cheers,

Paolo


