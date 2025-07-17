Return-Path: <linux-kernel+bounces-734996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD70B0893E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA887AB579
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEDA289E1D;
	Thu, 17 Jul 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1FgyYsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003C289356
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744329; cv=none; b=Fq2f/RnJcbo1Xcyg24cyFJODSiyzGPdP6Og1iOvceYxL/1izeGZiuc6Kf1fch+dVEMOOmNgzsJskNJtGvd4FLr9SCs8psmV72gKUYLfVpHhvAhV0hYEfhzklB/2BB8bAjOk9rGvbav/oWmhJeCn7Pk+LoFpcwGP0Sge5upUnkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744329; c=relaxed/simple;
	bh=ihTiDkt+TvI2NETJi4pl7z1XW8Im22JbrlopYk5azTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqFEllx7kvXXIev7pMFLSWxaR+FN/szlBcQL4V/1/8Jvr3uh0J6TtkI3lSX80+TTODg+N4bseJvUr8opJ7oRj7/jZA0mKX63e+3p0ove8fNcc2vA6RMOdFOeZkQp6UBsyJbbPMEazXWrjKLF7iL9r2J0RrzEfCJMz++LIFSUmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1FgyYsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E9ev3yrD+ML0m+nGXZuixbaX7IjF/q9l8W1aFJb/xy0=;
	b=B1FgyYsYgN4iPzFlW3sj8FD/l8yPiZQ0f5kZO/jVFTkJOR1QhA073BcH3yl62abW6BobVX
	k0m+BB3P5DPJgk/qPSSNCOA/NY3iTCzipiw6Ss+vNeSAMDu+uu8KqvB/eoY6h/fAasykiP
	LkGvz/tgzhQi9J1jIdn0NU56vJXoCW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-S0zgBR1OOOOY-jPcL9E5Fw-1; Thu, 17 Jul 2025 05:25:23 -0400
X-MC-Unique: S0zgBR1OOOOY-jPcL9E5Fw-1
X-Mimecast-MFC-AGG-ID: S0zgBR1OOOOY-jPcL9E5Fw_1752744323
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so3696155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744322; x=1753349122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9ev3yrD+ML0m+nGXZuixbaX7IjF/q9l8W1aFJb/xy0=;
        b=VFlR0k+j2ot/h8XGksnHXs6qCj+eIGBCQb3qzkhJVWcDw0dWqYa8XvuQqM8wEBhKwA
         d62tZhV0ad3jWuKULT1vmoBrKaL+h5o8aghvqwMmndruU5zariQ6hYHlSBVwYKVkSV0P
         gWtDBS5zQfcaJ9hRqwDzxbr7oqu6H3AGDr0MtAQTMgIcPm/MTtuNnqKUhNsTErBl9uTP
         53xU/LfZXB5YCJBO9H3r+GIBg530tnMOSZ/Nk9DiY4ldOiAfXL7b00FG/74DPpeKdSTD
         URTjJb6eJ0Tyx7aHPEQLeW7US1iKwUTRKFdT1sIfoSgCDh5G20MpmvnemBQufwPMmXwI
         fTKw==
X-Forwarded-Encrypted: i=1; AJvYcCVGVcvJSj1JLGROFdh1aQ6LZHWLmqUZaZNc4VCNDiAO4qioQ70vNRpMhTtNoFakrifc8yb5ow7Lbwr6r1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNtutWW9FzGGiV+BHroa/BuCSsxb9jBZz5sPvQoMyY9NIBnAl
	dfonqXpeisFEn+V40Yx8oQqYAn9bLOYIKNi42pm8FQYE8ZPwbWOPYBu2sf8l7gLWLarNiwzHoHF
	zsAghOHVM2iXnPsZbymfOhnogo4SbYmSG2P7B3RgNl/liFtDPda3GCQIqYiCqTxHHHg==
X-Gm-Gg: ASbGnct6iL0/9UmgrkoEJlS2D0+CnvNFXM0smy3ioFDVLHpT8w1s5/HamWm2AQ6qOrR
	JYMAWnVVf05NmSd2fqK5ikhDbXobw5NlfxW/2tzA8ZYnszPiiNO91Ymeq277uWwXrjlz9WXGyW9
	iO0sdpKzYb/WkYbCEfbSDLZPvbi6bSchQZ9+oE0TI7w9eApKWIxm+CioKlHByJqyx0JHnDJ8EMW
	fJd4wgBGEXItZw0toK3uIDsmvoqa9mela5mavyt6iphMJ3UYtQcuZPsGoGNTaT4Ve/JUYyglERd
	7+1u7s7kWWWY4OMlnD+jgzNJUStnRaBFehTp8qb1xVMxmRi5LdFZtaK+BLIHeNE4/XA4qqncPdf
	OfBD7AAGBMbIir+7QsNenQ3Hm6M5S6caEK+YLpSban7HHYr9nv8DzuIP2SosUW7zy
X-Received: by 2002:a05:600c:3b19:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-4562e38aafcmr51128155e9.20.1752744322453;
        Thu, 17 Jul 2025 02:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRSNBai7Gozzz1k2MwVuqNIicrKF5gocm+tYkQxzjnOpt9HcWWJO7+Azmck5VG0LoPpzvd2Q==
X-Received: by 2002:a05:600c:3b19:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-4562e38aafcmr51127815e9.20.1752744321966;
        Thu, 17 Jul 2025 02:25:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562eb63551sm44492755e9.24.2025.07.17.02.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:25:21 -0700 (PDT)
Message-ID: <a967118d-ee79-4486-b6ad-c0ecb173e2ea@redhat.com>
Date: Thu, 17 Jul 2025 11:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
 <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
 <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
 <a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com>
 <2513a63d-b11a-48fc-922a-288785817df4@redhat.com>
 <048c8d4d-5e5b-472f-850b-6392b8f4d2a5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <048c8d4d-5e5b-472f-850b-6392b8f4d2a5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 11:20, Lorenzo Stoakes wrote:
> On Thu, Jul 17, 2025 at 10:22:47AM +0200, David Hildenbrand wrote:
>> I recall [1]. But that would, of course, only affect the RSS of a program
>> and not the actual memory consumption (the large folio resides in memory
>> ...).
>>
>> The comments in the code spells that out: "inflating the RSS of the
>> process."
> 
> RSS is a pretty sucky measure though, as covered in depth by Vlastimil in
> his KR 2024 talk [2]. So maybe we don't need to worry _so_ much about this
> :)

Well, I pointed an an actual issue where people *did* worry about ;)

I also think that it's probably fine, but some apps/environments 
apparently don't enjoy suddenly seeing spikes in RSS. Maybe these are so 
specific that only distributions like in the report have to worry about 
that (good luck once the toggles are gone, lol).

-- 
Cheers,

David / dhildenb


