Return-Path: <linux-kernel+bounces-882821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECDC2B968
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22ABE4E2F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48F305E04;
	Mon,  3 Nov 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVuMnV+n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4J4QuAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965C151991
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172167; cv=none; b=YaElYWDEtcO36P54kDGtHRjbFQKJ3ieIg0Z03UvN+y+3uKbcDtnzaPwTLl2SizJdrwiXW+RVF3E7zq21N/rPIpZC3x6137QsXCfitDE76dRMImlc1iyRDkLkaaeWkOJLNQ7J/5sMHGF4XV7O0ylFvmUI3nShhHVRtzpolJU/T6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172167; c=relaxed/simple;
	bh=/nhHmYY4DwG4OUbjbLLRvwUDlHogICBXhctaOEpPmEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfLED6bZwKa9z3WInqJFnkkwiZA1Ql8l7NGWHz/D5gnKhiV/RyDUc8KWgq62ZVRXGY2fWYTzWaAgajntgeQgO3ZDL0MGGRi8w4dZicj2i7dAtAZX0dG0zOImTY9XENk/G4G5IVZLzof7qvSH0xfCZ2zyrOewk7xRpNrCrIZeOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVuMnV+n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4J4QuAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
	b=EVuMnV+nLDwuAB75KbXsjGQK5U2GXx+f7Uo11UWt0b/SSWun2qAw5Mdxyzzo7w8UPZBT36
	7AvPV6Zb1s+8QshQp+ofCi4Nfs3jm62VHnYB8ftSwqoCqaUN3Qjrljh1qa9zRsnxiXTAln
	XjNtkiuBOYvPweEjp2EMlH2s21PvYn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-YTfnkLy1P8ai01my9LZBCw-1; Mon, 03 Nov 2025 07:16:02 -0500
X-MC-Unique: YTfnkLy1P8ai01my9LZBCw-1
X-Mimecast-MFC-AGG-ID: YTfnkLy1P8ai01my9LZBCw_1762172161
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c93a28ebso1510938f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172161; x=1762776961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
        b=D4J4QuAmWePBBLZcO03T1c+2ecsmNJeSI0fGcBINLqWCcPro3Xub4wxmP2Be2pK8kW
         Tmt/G3jus9w5woY7GphnZIwE0mya9uRHd6qt2UeTP/RaunZCvdis//H8yNk1POOOrNlc
         +s7cIMMDDkZfJfdV9WDZ+VxxB66/gJ+jY4jXgNVWdy3AD0pvA7C+EXGfkEJ2bu/JhguB
         MSlernLwoeG4gOeMLgBp92vPFb44AAD32rE1OPwGLK6ILS3NIp6o68c1J7lF5XNxNQaN
         4yOBVvmGE8Fw8dDFT+Vj003p8HMM9HZqPZRj4sc9WuAD+YQB56102BrS+FusDUL9QcXf
         kJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172161; x=1762776961;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
        b=NNV9D+kZ5V57IX+X/hKtU1Dck7QQTEaRzBqbA4q7EaEVYsJyDIObFEA0M1XNCoKvMd
         NlzeCDfj1exA1mraMnrjxdUx1smp6UBbdXg1JvdlIy8eriVvpnnD8BFpTbx6jy8Pn0HK
         w3OgfgPCAxAs7bpLwlZZdxWNYdMcWiYwLUKqlHdSBHYeWyqE2tniB/I+E/7Br7OyeXls
         lRpcS6SAOufIaSEfzhTpUUW7lCWPXqTj/0bLvU9g2xwEgO1nSaBDFVqJJhC18zwao69K
         +O8dWrdhPvRgvN25t+Zqbhq5m0w1S0E1ekQXAR1F+1svqZW8+4LfM4DNqxwnfaEpb+Cd
         S4WA==
X-Forwarded-Encrypted: i=1; AJvYcCVVIRfklRYn8/Wzs75v+Of+aW0iL/zZ7DXWCuUzVxUyUqcBRjk3Kp6cO0xWncD4FCsfTCD+/D4jC2AiTHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrKWv3Q0MuEIbPgIyzvFO13siPPID23bKI8zZCxlVN4VP3FN2
	crL/xGpx8TdAoH9wuvehhicFytF6+5W9FcpXhMMySWbs7rI+MLFzhUS652U74lUWFJQFBCxudTD
	mLvgkR+x4h20EjLAuiVdfbjyhyuSVsXymg5tbOlFAONViyN+xTR58mcaEFIgKenT1hA==
X-Gm-Gg: ASbGncu91F1ZyUZn2Ul1sgRhrC2ZyDH3+VtXkIjLFiyvfm4MLRCCPXbN+wx7Fmbsf1d
	jD/23/0R4c1+8Ghl2solabl8RvU7hnTg7hfVan0Y6mJQz+NBDV7DaOIWDa/KotTaO6cwYRRh/fS
	y6BzpvtOTQbjYtYmtowoeSLU+HlqREhvJpGAjMu2zeD1TuZpZBqBpChNUeJ0+P3O5oEZJl7wBwT
	0xy69YSOUDlZNCBQHE9OKI+PU8BgWTHOC8Bpl6C2dBhSH0bUiaNhIpaCA2+UaNzHVzt4Oo0aVxr
	oLHmxjeGL2Alt0qTSXNZObZVelGz9KPbKnKaDt6VzZ0zjEqibGBiTqY9Hfztvdp3SQeZXAhGlpD
	ORUyJy8lxugar+DUApITjHM9g1867Y9iovGoeNniRypbxT+xvTEuR/rpW/x0TTw+tzGrH3RzCRz
	8KwqFD2GGyTjfP4Tkef3JLkHzw61Y=
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429bd6ece4bmr12949797f8f.61.1762172161215;
        Mon, 03 Nov 2025 04:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJz3FBKsr18wkuyol1fzdxNXOP0NzjA4OuIx2R32uJMWanPs2oQny9N+V7osFONlxQu55C5Q==
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429bd6ece4bmr12949761f8f.61.1762172160704;
        Mon, 03 Nov 2025 04:16:00 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13eaee6sm19776225f8f.33.2025.11.03.04.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:16:00 -0800 (PST)
Message-ID: <341ff738-255f-41c7-8b23-48aac4cf51e3@redhat.com>
Date: Mon, 3 Nov 2025 13:15:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/memory-failure: remove the selection of RAS
To: Xie Yuanbin <xieyuanbin1@huawei.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 luto@kernel.org, peterz@infradead.org, tony.luck@intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org, will@kernel.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20251103033536.52234-1-xieyuanbin1@huawei.com>
 <20251103033536.52234-2-xieyuanbin1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251103033536.52234-2-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.11.25 04:35, Xie Yuanbin wrote:
> The commit 97f0b13452198290799f ("tracing: add trace event for
> memory-failure") introduces the selection of RAS in memory-failure.
> This commit is just a tracing feature; in reality, there is no dependency
> between memory-failure and RAS. RAS increases the size of the bzImage
> image by 8k, which is very valuable for embedded devices.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>   mm/Kconfig          | 1 -
>   mm/memory-failure.c | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5a90b169435..c3a8e0ba1ac1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -738,11 +738,10 @@ config ARCH_SUPPORTS_MEMORY_FAILURE
>   
>   config MEMORY_FAILURE
>   	depends on MMU
>   	depends on ARCH_SUPPORTS_MEMORY_FAILURE
>   	bool "Enable recovery from hardware memory errors"
> -	select RAS
>   	help
>   	  Enables code to recover from some memory failures on systems
>   	  with MCA recovery. This allows a system to continue running
>   	  even when some of its memory has uncorrected errors. This requires
>   	  special hardware support and typically ECC memory.
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..baf2bd79b2fb 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1276,11 +1276,13 @@ static void update_per_node_mf_stats(unsigned long pfn,
>    * setting PG_dirty outside page lock. See also comment above set_page_dirty().
>    */
>   static int action_result(unsigned long pfn, enum mf_action_page_type type,
>   			 enum mf_result result)
>   {
> +#ifdef CONFIG_RAS
>   	trace_memory_failure_event(pfn, type, result);
> +#endif
>   
>   	if (type != MF_MSG_ALREADY_POISONED) {
>   		num_poisoned_pages_inc(pfn);
>   		update_per_node_mf_stats(pfn, result);
>   	}

I rather wonder whether the memory-tracing code should live in a 
memory-failure.h instead.

-- 
Cheers

David / dhildenb


