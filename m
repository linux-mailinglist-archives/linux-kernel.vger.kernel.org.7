Return-Path: <linux-kernel+bounces-747859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C8B13934
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569B93B82DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45B22D4C5;
	Mon, 28 Jul 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qxlf7sMz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A61FECD4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699683; cv=none; b=LajpeYIhrGGJLDiDQKvLEY4V8hUCExoqliRfBaEukvOWOx+p8kHVfk1olBj9wWS7OJ1s4PtNLTC64aT1UUpKp3fPO4+vIVyv0GOVVqA6prfeq3umDxoL2wX3DhNwP6ph3VAjisnohx7ul/bM1isAs9KFFJZwWIZ1AyD1NHSFBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699683; c=relaxed/simple;
	bh=z0GLawByPTffgMB7davdlXOFTvSc7eRtTsfylma/s2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1zww3V+tJ1N8/Th99hlUCWP6HdGr5tFesvCxfYwc96MmxJXJW2uK6h+PXr7Oolug04f9DprlBAMe0e/B8IrdzcOUl3aM3KqyD7lVCFgBqhHWPZlNqCGb7WnbbWFYkvk0yjmkYInvkPRRoY+pFeLHtZgN1ECTua/V6G7WyCAzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qxlf7sMz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753699680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wGgLEUzhCfQ33/UxK58XR8TwLzqryp1OVfYZsE74bDc=;
	b=Qxlf7sMzYmxauWEgXbd2LF6AAIvQE1imK2b9FARkL7ikE6mdxavamF+Dq/OKXi1kiB6Ay3
	cqBAYDVqrSIoug4R7yrylkMkrmP6QwOO8Ah4MRU29p/hPwysDd9rGONvbrnmtCnxToBdcV
	yh2xDEFAxZibk0ntPUTTh+Rt/JFII44=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-WY-vl9N_OBe4gzPlIfNqbA-1; Mon, 28 Jul 2025 06:47:58 -0400
X-MC-Unique: WY-vl9N_OBe4gzPlIfNqbA-1
X-Mimecast-MFC-AGG-ID: WY-vl9N_OBe4gzPlIfNqbA_1753699678
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so27391175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753699678; x=1754304478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGgLEUzhCfQ33/UxK58XR8TwLzqryp1OVfYZsE74bDc=;
        b=lScQkiiyptIX9HjUy5Gwzgw3Y6Qb5NAwfI22iJooPE3c2NuqPUSliyVJJ95DxQo1N+
         fRZWe+274Owyasmr63EcimKKTLXI3Y+vsPtsm64nK0D+EhMRL6l+GmxcRNeuEHvzjeLO
         dEG7T94rPOQdX+XFQCv/HGbX7IfCTwfDDRFRX9e49C4cERgfbNdokw3cA7isTEoLITKN
         k27Szwh2H8ADXCLj21x4aKHREaoOCoBkwaPJfn/jT55xR++vhk9PHBSA9KSj0FyxJX+9
         t8ITcdgAEC8ZWpFCGpDU/v/cZ5gexZ88qjCVDvFAspfeh7ZA54JzN7HMpvxRTBBSWyKz
         p0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUALJcuouG8BmJ60vHwApQOODzGzC2XU4Sh2NN4lVRFfkDUWEaBtpjotjhC1uN7KwDtrbj6/t506NAd/6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDqHLtrzFPnON4uPM0iOTwaOzQAOzmMXsFPAGR+GxFDusAT0c
	5ky3DFUZddHoA+08DMXmVXhw0vcUtwwJrzeZIrUfXuJ7h9dg3Xf08Xyiy2g9+QWPit62fviTwOu
	QRiR1udaxW6C14SiDuvWqfmFdwvWT+eNJI4eIUBRJEdufJiElHixvA8XXTdSJyuLPeA==
X-Gm-Gg: ASbGnct2vyzk9+Y0nCaW7YoS25KImzjlEB5YgbkJKqwPML52ClVs7CU35EGJS8C0t2t
	rsbORoN8ZERwWDm2f9knvvYDwDOA8yyhzYJd4hnWj2b8TgLAJR4dbazfSLp5ua8jfRdCjbPD7fz
	Sf6lNJh91NRaJb8ND8AzibQAtXUvobzc1tM9v7+zlzXIcph0F7DEC/8pS0y3hsy5y0pL/zuXsgM
	KfPcja/n+zmeMFcK71Gm1Ak7hWjYM1ApGvbaPw5w4JpdoAdjPpK4iIKldzi5/Prg55ODiJLAV9s
	LbG257XQ95wvY+ISZj/FPodon7HMY0OQZNvJGQx0xtTAu2cGuqgAbxH7zHJCfP9l+yobb39ZPz1
	1NvKw8dgq7CDNKSX3WmzSsj9XsQNinnBze22RSQOPcePAKAIxNu/5FbTWmW4togB75w8=
X-Received: by 2002:a05:600c:614a:b0:456:18ca:68db with SMTP id 5b1f17b1804b1-4587630d8femr93068415e9.8.1753699677595;
        Mon, 28 Jul 2025 03:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ50PB9dgZ4xP9VjklRd2e7i2NCSV2a6Z62Kb4eGiWaZo3Faj4BUItITIL+0likdgswRRY4w==
X-Received: by 2002:a05:600c:614a:b0:456:18ca:68db with SMTP id 5b1f17b1804b1-4587630d8femr93068135e9.8.1753699677081;
        Mon, 28 Jul 2025 03:47:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc2804sm93619965e9.5.2025.07.28.03.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 03:47:56 -0700 (PDT)
Message-ID: <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
Date: Mon, 28 Jul 2025 12:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sasha Levin <sashal@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2025072832-enrich-pampers-54b9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 12:37, Greg KH wrote:
> On Mon, Jul 28, 2025 at 11:27:48AM +0200, David Hildenbrand wrote:
>> This must not be the new mechanism to DoS kernel maintainers with AI slop.
> 
> I will note that we are already getting this kind of "slop" today, with
> the numbers going up on a weekly basis.  Be lucky if you haven't seen it
> in your subsystem yet...

It's getting more (but in core-mm not too bad for now), and I hope that 
there will be a reasonable "use of AI" policy for the kernel soon.

At some point I even assumed Sasha was AI-slopping us [1].

We cannot keep complaining about maintainer overload and, at the same 
time, encourage people to bombard us with even more of that stuff.

Clearly flagging stuff as AI-generated can maybe help. But really, what 
we need is a proper AI policy. I think QEMU did a good job (again, maybe 
too strict, not sure).

I'll note one interesting thing in the QEMU commit I linked:

"Thus far though, this is has not been matched by a broadly
accepted legal interpretation of the licensing implications for code
generator outputs. While the vendors may claim there is no problem and
a free choice of license is possible, they have an inherent conflict
of interest in promoting this interpretation."

[1] 
https://lkml.kernel.org/r/a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com

-- 
Cheers,

David / dhildenb


