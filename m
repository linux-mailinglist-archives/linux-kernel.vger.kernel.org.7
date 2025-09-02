Return-Path: <linux-kernel+bounces-797214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE4B40D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433FB168A11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7033CE93;
	Tue,  2 Sep 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQgZ5MsX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2F2DF6F4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839706; cv=none; b=uKONWfg5mD6mmpG0jK7fiPL/sSJA7Kvh4qyqYdBPWC+T/A53Y80aa0Hva44o0H1RIz8lR21eYIJkq+zQFy7V5AVmP+w0dCZkwgqmUnLvOsaAp3sTPSXM2V+TT9rOK9XZfqBBPQiw0lkMF80JEuLKG0xPBXUvfZJXwNqaDUvIeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839706; c=relaxed/simple;
	bh=iv5/ZFE+q4CVeEQWg/k3ZpT6vJ8ZQ/gkxGniX0opQ6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEsmzWctw85I/idQ3du3QGHRtah5fTsxctHAvJIY+LfkUMK86dl5IEmKjQE5kc2EFwjAkwIXwSN3vOb7OyCIyaFqXqm9boXhtjcZ50tbzA+bIwEpUiyG2pWoTWURIpKTHdAIO3jier1Q9KjsnfhBOLt4gS2l8PKf10uHx6LTea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQgZ5MsX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756839703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xG8SHV8fzAAYJPex5gyHGD1o+s1vP7RR3dhhmyQkukc=;
	b=aQgZ5MsXk0SoLEwMEU8gfeRle7qDfuz8wQta5NiCVmDtqbbmi4Kp5LkYUTdsMNPPkobiL8
	hgQBJp4Y+SbOome3BZrHle1FuGiYY+6tFJUsI1cMh+qzRRAuhjo2cHf42AGmo4n2JGlWTY
	SHF5NAYiD+VLT+mLxApTQgxZ1jUeeRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-bQx8vY94PkupWGFgsZn7xw-1; Tue, 02 Sep 2025 15:01:42 -0400
X-MC-Unique: bQx8vY94PkupWGFgsZn7xw-1
X-Mimecast-MFC-AGG-ID: bQx8vY94PkupWGFgsZn7xw_1756839701
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cf48ec9dcbso4643663f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839701; x=1757444501;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG8SHV8fzAAYJPex5gyHGD1o+s1vP7RR3dhhmyQkukc=;
        b=Lv2yHtYPsrNlHYtp8QWCF8wR2Hcy2c1pPZ5l6hAYj+8XXsm8nMXTgBwCBtJvrIIDMC
         X9h2fQt9q85t5RMRG5SnywZcyIRLK0lItNsq6bw0rYOP+IRqJJtKU1EmzEKK5VSKtCjp
         KonbVVHWJthfzthGI+QQnYx/WtX+k8ZMhGeUr/TWcBCo0oXOuM91zgyfEPElkpEqCgyx
         XhXxsuWpICqQDdpXu5DzKm3vxKyvEmLr7oqtGOBUP9IdueRRq0tuSFtWHN9USBqIo60Y
         xVliDXn8DYaAw+3VX08/swF6bKCzcvwEQbQhcJO0xQsaNIIfUKZtVhl82nLFhh1Q7W5h
         4UCw==
X-Forwarded-Encrypted: i=1; AJvYcCVQKURLz/IkP8w57eQzYJeFrqjnjFXPE5uwEa3Z/nluJPysetzceCgFkY5T5pgbvIouQmZoFPE+9BypfPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLwEB1SdupWIFxQISQT/A15cX+QiyqKye/Q8FZBg9L6cHRcUL
	lwUK/Sak1oyCIPC0vv094EAHLIOazOvKmyJQpbKsAa+RCJS01i1RDHF7398HhS9ah/iD3F9yC9r
	s5ZnK1w1+Vb7xr4pQROjhxQe6yOFLebipY6lA29laZDSNRcYqJFCQRpPy++zEDiInnQ==
X-Gm-Gg: ASbGncuzx61LKKgn+TLy2aVLJ5chcNNPFIVpEoz2nQ+B5HhtFUr5i/5rxZsTOMP69LN
	2SYSDjybZmMeJvZCOzYIfEsm3dMPrK4eCsOWNxiA3G6WTr91libnctNcqkPS/63vFEGu2k1+awi
	0QSVgfVVKzOv7ZNLxcD9ZqZ8rQW//dx0ZQskR9dfTczbPZrI7YovhNR2irCeknU77g7UgoxH6+C
	PlBwQ9bYMCT/m28FG/Xm55RFVbwJhSL6wrkceudBSmdZ9xUO4zR6eIXR5d+NuMN8J/887ltGEER
	iSpUmubXcaVNJH+VQLCwdbXx1Vxvu0PUQvaQs7lM5lVdVlWK0MNdy5Ent7OHDWM5CJmcNIayDUi
	nyvGD8fBSzDX0bqKKTHj515cYTLJEbarS1N0Kdx8DkNuKGkbrjV2wpCjt88HlimIwQXM=
X-Received: by 2002:a05:6000:2309:b0:3c7:516c:f664 with SMTP id ffacd0b85a97d-3d1dea8e3ddmr9433568f8f.50.1756839700797;
        Tue, 02 Sep 2025 12:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZuKmy5+kpBqtUCz7rFUogMWS9lJklSyblvxp1qoAtN7Sujp/LvaGOc8MXn3Bui6WUnliXSg==
X-Received: by 2002:a05:6000:2309:b0:3c7:516c:f664 with SMTP id ffacd0b85a97d-3d1dea8e3ddmr9433535f8f.50.1756839700348;
        Tue, 02 Sep 2025 12:01:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm35391745e9.21.2025.09.02.12.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 12:01:39 -0700 (PDT)
Message-ID: <d61b173f-ed58-4d60-b1a1-b93678371576@redhat.com>
Date: Tue, 2 Sep 2025 21:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lokesh Gidra <lokeshgidra@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, android-mm <android-mm@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
 <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
 <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
 <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com>
 <e6b12ef9-1808-45a3-9d64-5c7fd1904b5b@lucifer.local>
 <CA+EESO5FnraOUV=CzcD6t_e086pC7rDZuVv4w2ng==7KacA=Pg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CA+EESO5FnraOUV=CzcD6t_e086pC7rDZuVv4w2ng==7KacA=Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.25 20:59, Lokesh Gidra wrote:
> On Fri, Aug 29, 2025 at 2:04 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> On Fri, Aug 29, 2025 at 10:42:45AM +0200, David Hildenbrand wrote:
>>>>>
>>>>> I do wonder if we can identify this case and handle things differently.
>>>>>
>>>>> Perhaps even saying 'try and get the rmap lock, but if there's "too much"
>>>>> contention, grab the folio lock.
>>>>
>>>> Can you please elaborate what you mean? Where do you mean we can
>>>> possibly do something like this?
>>>>
>>>> UFFD move only works on PageAnonExclusive folios. So, would it help
>>>> (in terms of avoiding contention) if we were to change the condition:
>>>
>>> I think we shouldn't be using PAE here. Once could consider using
>>> folio_maybe_mapped_shared(), and assume contention on the folio lock if it
>>> is maybe mapped shared.
>>
>> Interesting!
>>
>>>
>>> But the real question is with whom we would be contending for the folio
>>> lock.
>>>
>>> Is it really other processes mapping that folio? I'm not so sure.
>>
>> Yeah, I might go off and do some research myself on this, actually. Nail down
>> wehre this might actually happen.
>>
>> Generally I'm softening on this and maybe we're good with the proposed change.
>>
>> But still want to be super careful here... :)
>>
> Anxiously waiting for your assessment. Fingers crossed :)

I'd suggest you prepare an RFC patch where you neatly summarize all we 
learned so far. :)

-- 
Cheers

David / dhildenb


