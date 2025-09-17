Return-Path: <linux-kernel+bounces-820769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23045B7F29E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9471890F84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AB33C76F;
	Wed, 17 Sep 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1senO4c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00B33C761
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114529; cv=none; b=nPEZYbyRhIJeF/at/HL9cM5DZC7z6ho5QpR4Yhi4EnlPTgOY70ka0JVyXEPai5IvMEawaqVqwnLu6aOD4Hur1lFkzx8GygehiWVl68OliyMB/Ozu0jMj2yEVsncQlqR7b5F4f+/LrmHOfQqXiW6BbmGwwSdEV7bYiQZh7bF50fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114529; c=relaxed/simple;
	bh=i572I/5t61zMlC3zm0YIVNIQ1+sDL42ZcU0vhKEKzMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GagreeuEZvEI6CfWpQ7IkVcVgYmJDrQ2P3Qh+MK7Gfs6EUZSjn/4VJ0u5tHiIRb4/BVPz7MxgLeRIEOo6jMTj3urMEeTQqE2Q3krSujSgXDYdrj66wNcpQF5CgQ/TmZCZTTyrjKDw+UqQ3eUoPuD2W5Su9bbcgFUIgQmQnixAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1senO4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzfWfGht8au98LeWA8/zuY175JB8QmmK7SOvZDIdVlY=;
	b=G1senO4cgJ6tt99cuC94L88j+9vCuz8VDI1oxiDnmHacS9IX6S/smVMoe3ivQ03HlyI00U
	xgahpajDyVsLV3geAF8ma7jXP2r7QypA89Wn7ivYjgMQmho/dctzF8P6U5R2/JcdoGfPNQ
	9ZWV/HSu5UCrgmJ8YyjJHFzRXMZYcyU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-oYk-cQS7Pya54V-4eVKsTw-1; Wed, 17 Sep 2025 09:08:44 -0400
X-MC-Unique: oYk-cQS7Pya54V-4eVKsTw-1
X-Mimecast-MFC-AGG-ID: oYk-cQS7Pya54V-4eVKsTw_1758114524
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ec06900004so1696619f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114523; x=1758719323;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzfWfGht8au98LeWA8/zuY175JB8QmmK7SOvZDIdVlY=;
        b=GUoZsyIYzxib4MSQtFtyPlXRYDhHs/Ooj6MMFR84Ns9eV6579buTWb2fDDQ4CBAbY7
         oqSDMspPgQHByZLnT/X4kx9QZ2fRoTo59Hi77aZWkhoX4rSa6K4lIXL9POBMoiD19H9X
         mUFLtOUUSXBCMGDOspdcvkUHd4rdFMoCbAOJHeCZwdob25CgACQZ/D+d16eDLX8fu6j5
         /ki6ppf0M3rW5Z/uPz7u/CIBmR1Ph3/7A3HeNS7AkRnagjuO8GHyYtO5vRSalWn3zHTp
         +qIqtNrlwUPwLIvuRSFI+LM4inLVeZIclC4CWBUJnR9SEily+XdikFrTc/oSYbJ6hDpM
         lOGg==
X-Forwarded-Encrypted: i=1; AJvYcCUDwEb/U5Go/U0AIVQZbEXhSvPX9XQnOctJFZSsifXO3stRPt6oQ8i49tYKBbD0rh9PF9d3vIhOPNzPuiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3y87eWQSMin8Oj7u4cYUbAzDLIfLk/PyxqT8l22dgz40MDfw
	cz97u6I3+q4FQnL7LkXnQKj8OeGV0PN9VJ28uHMdqKND30EbO5CU85+b3sY0cD7DS0v9pwKHMzO
	SG4YuD6fkhktEnvJTW7kVYpIyiqzqwqUtxiWE9eiNQI19aLXGcaWaGZ/7RKumPoFUFA==
X-Gm-Gg: ASbGncvQjvc9M7WBtjK6nn9OYf2kP+ci3FzX6jV+W//MjpeflST3wXGTxrFujD0IJYs
	RpR4fSq3iBSPseSYz4Fc/XAhy8AXyg6SLLzFIvISphLpcKBJIVgxeO6mQaacJWaaQjUf/oFMJEJ
	f9MBSjNdDs1BW2KpYji9t+veJSV6I/3kxiZ0ml8kfOgCC4nNKC6arkyWfpi7Bh5jREH9nO6skdQ
	SWKobBuJG+ciUWJndUTgDZjHLQzF+mfWvKZfG6944/W9JqmFR276OuZLP57/vzcUnRxuOW2M4cY
	k8va0pSbaVLC3HnNdapROyu+VLS+aWF3MZpNs+BtBjAh2Yd9xLI0eE12P8Om/7He/W+bV+nj2C8
	J0uC54oN6eAtkOLwVvZUa8bKGYoOyx/680tGYlyd2ox7uzLYFm9Tk8EkjMPv5ERsu
X-Received: by 2002:a5d:5d0d:0:b0:3df:c5e3:55f4 with SMTP id ffacd0b85a97d-3ecdf9af23amr2124898f8f.6.1758114523502;
        Wed, 17 Sep 2025 06:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESsV8oIC9/D3nBGOX8FOAc3Rt8Xs0bAaprYwXzUAhqjLbNmBfCuTBu4PnllnnmUxZ07rs/UA==
X-Received: by 2002:a5d:5d0d:0:b0:3df:c5e3:55f4 with SMTP id ffacd0b85a97d-3ecdf9af23amr2124841f8f.6.1758114522780;
        Wed, 17 Sep 2025 06:08:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece0d4a5ddsm1768484f8f.33.2025.09.17.06.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:08:42 -0700 (PDT)
Message-ID: <ada1b1f9-bd2b-4164-ae8c-80264d4f6dc0@redhat.com>
Date: Wed, 17 Sep 2025 15:08:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250917122750.36608-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917122750.36608-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 14:27, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The madv_populate and soft-dirty kselftests currently fail on systems where
> CONFIG_MEM_SOFT_DIRTY is disabled.
> 
> Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
> tests are properly skipped when the feature is not enabled.
> 
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

[...]

> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 56e9bd541edd..ac41d10454a5 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -449,6 +449,25 @@ bool check_vmflag_pfnmap(void *addr)
>   	return check_vmflag(addr, "pf");
>   }
>   
> +bool softdirty_supported(void)
> +{
> +	char *addr;
> +	bool supported = false;
> +	const size_t pagesize = getpagesize();
> +
> +	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
> +	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
> +		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +	if (!addr)
> +		ksft_exit_fail_msg("mmap failed\n");
> +
> +	if (check_vmflag(addr, "sd"))
> +		supported = true;

Reading the code again, this could just be

supported = check_vmflag(addr, "sd");


LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


