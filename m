Return-Path: <linux-kernel+bounces-595675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02FA8218B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 12:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37D53A8AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94725D8EA;
	Wed,  9 Apr 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtGFn0PB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C225D54A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192679; cv=none; b=ZQAigkig/vXPNR3ScfvExUVbZzgAEHJ7dJ/LyWLhzIRfAEvlbpIa1dB52Kocnx0msvLTK8qjDZSRWmh3ZYM25FqUBrL0P5PTEPB+3McqiKVJpxqXCDhSDXr27Jjy1xut1NMYDyGTVP3WflpmQBWmsCZEUa8PlmN6KexisddDZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192679; c=relaxed/simple;
	bh=4hWovn7DCnSCa3SymVXUIVr4LS9s1sqvJ0JjN2D1DCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ56wnpq7JFzg8uJv6yRqnt62uvLl4zL8wH4M6H2ZuCWP971PsmUJTND/IngjoLqAX5+XGPFROpNzRzQ4RwalEoDNo+nZgfWrFQGU9rB438QTqw/alL3px0vrR/GCZyiXHcsLBz28ofZxEwRZQ/k+Odiyd42UbxvT1EEgKXfaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtGFn0PB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744192676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+L1Lnd+PcedYee10bRY6lZSgXHVSmYPHtTKJdqkx5c8=;
	b=BtGFn0PBmw0Q4EqKok8pBSMjlCUBhe5t/9gLxuuBOv8Y3Bd4aJ/l+IviXopwYZltJh1XSx
	2bKFNJ4ZUG13Wjdi60aC4kD29DFyIqVCi7U9rhhL5sLubomPbj02TThTiy7E0Fc/5a1RBY
	osTJA2auZvu1jik3/U4EQST95R9/XeM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-JaoInpwCPKaRyf05CyR_Dg-1; Wed, 09 Apr 2025 05:57:54 -0400
X-MC-Unique: JaoInpwCPKaRyf05CyR_Dg-1
X-Mimecast-MFC-AGG-ID: JaoInpwCPKaRyf05CyR_Dg_1744192674
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32b08so3558360f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 02:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744192673; x=1744797473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+L1Lnd+PcedYee10bRY6lZSgXHVSmYPHtTKJdqkx5c8=;
        b=g3HFVAChu4bttAw8V53TLRbUkhjcBZtHtW6fJ6NZSCV3cMZPCiulhEEmzXf7FS2p8G
         nm/QTVYQOc1MrUhA+3o9s2jI4p2Nl/NArqNdyFVPXFvxkReF0BEzhb5sT2OC/XQ8gVDx
         +k4aMV+w1hvlORVMep9aNmbr8FY5iKGIzvo3avM5zFRG4twzfrL2DP6ODyOmmO7jYRiK
         5MRwkOncYE8OM6EvlRThIo8o/NJZ1C+/p80UGKTCl1kGSpzeqQgzseaEw0lZAARmje8P
         KO7hVq05FMYnpMArFmctpV/jmTf6qOnB0bb5IVlwMf/hvgzuUX03gT0rAy65pw7IjkoO
         RApQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUW+5aEQgdi/4mCcfMVLOsJFQwK5/b189DjKXSYd5rcb5cecEYvwOZEGGffgLu0OyaplIGuinStlLu6VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mGgDut11c7szzW1TxBpAOQgHR5yYYKgnZSJTfeRZ7/1mUthe
	OOdvn3AQm7M7OErRsTMD4G3gqiYyUj+w5HGX7Yl2wk+g7KQdxwcWJqwopV160+/BXtGq3u2Ucli
	1txPNlfX/FlY9PGietwnjhUZWDco97EBS6uyYhEE2WVIHd3oLKr+pqmTwXIxwEWykUdCDq3CR
X-Gm-Gg: ASbGnctRcS2OmfMaNGknIa0Nqr2zPRBptULKn6DofdEdaLi/dscW4QhtYyLH+QTLFfH
	knUn+tccKwv1KpWm9IJPWyQhopOHpXEY5j18PoWhv54V7VJoqbZ2N5yeWIbP1LoxenFJjWpD0b5
	gLj247aSuaMr6+uEEXQ0t46hb1rOC51BCJUtACkRRYiRuay7PCpC6zlZocs9WRHnYMbzSAlVyds
	YClkd0tYSXbTs/ZBIfGX0/z2YH4V2h+RFKseAsYAnTcHZ/i71AgR7ocjD6rU3CjQzeXpbMYzt2C
	gsIOL1cFcYjfurHs92ROooJSKao67TeB6BN79/4DJN3++7dHkuDLIyUyI0B41OdqzC89nhHmjQw
	K8ZtXwAOUwBZCnOn8iDNgQDm82XfQUG9dkQ==
X-Received: by 2002:a05:6000:2508:b0:39c:1404:3748 with SMTP id ffacd0b85a97d-39d87aa80edmr2163221f8f.16.1744192673599;
        Wed, 09 Apr 2025 02:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfJJjXQVACsDObppdCDBuWzUkg8k622JfKmLVPltfHoDeLfRD/0IZh3fvzW79lsgT4GXzBUA==
X-Received: by 2002:a05:6000:2508:b0:39c:1404:3748 with SMTP id ffacd0b85a97d-39d87aa80edmr2163204f8f.16.1744192673298;
        Wed, 09 Apr 2025 02:57:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a4dasm1137183f8f.48.2025.04.09.02.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 02:57:52 -0700 (PDT)
Message-ID: <9da46633-e9c1-42a7-b52b-16cf89836abc@redhat.com>
Date: Wed, 9 Apr 2025 11:57:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix compiler -Wmaybe-uninitialized warning
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409095006.1422620-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250409095006.1422620-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.25 11:50, Anshuman Khandual wrote:
> Following build warning comes up for cow test as 'transferred' variable has
> not been initialized. Fix the warning via zero init for the variable.
> 
>    CC       cow
> cow.c: In function ‘do_test_vmsplice_in_parent’:
> cow.c:365:61: warning: ‘transferred’ may be used uninitialized [-Wmaybe-uninitialized]
>    365 |                 cur = read(fds[0], new + total, transferred - total);
>        |                                                 ~~~~~~~~~~~~^~~~~~~
> cow.c:296:29: note: ‘transferred’ was declared here
>    296 |         ssize_t cur, total, transferred;
>        |                             ^~~~~~~~~~~
>    CC       compaction_test
>    CC       gup_longterm
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   tools/testing/selftests/mm/cow.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index f0cb14ea8608..b6cfe0a4b7df 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -293,7 +293,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   		.iov_base = mem,
>   		.iov_len = size,
>   	};
> -	ssize_t cur, total, transferred;
> +	ssize_t cur, total, transferred = 0;
>   	struct comm_pipes comm_pipes;
>   	char *old, *new;
>   	int ret, fds[2];


if (before_fork) {
	transferred = vmsplice(fds[1], &iov, 1, 0);
...

if (!before_fork) {
	transferred = vmsplice(fds[1], &iov, 1, 0);
...

for (total = 0; total < transferred; total += cur) {
...


And I don't see any jump label that could jump to code that would ve 
using transferred.

What am I missing?

-- 
Cheers,

David / dhildenb


