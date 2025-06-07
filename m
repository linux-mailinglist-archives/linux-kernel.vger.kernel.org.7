Return-Path: <linux-kernel+bounces-676399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADDAD0BD0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD987A702F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412171FC0F3;
	Sat,  7 Jun 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P64UyzzF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F41F4CB8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Jun 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749283162; cv=none; b=WOOWpBOMDE2Fw/1chOq/PCriQFMgw4pdOK6I33UcFKwAsKAtwciYsdTwbODKgsuDc4NjhzBhKInKdVzpOYRJO3goH6fIdiaz4+e1tuTyizcbRUUCrmLUDFFxuUxNIXDomI7VnHlgBQsGefBXYg7XHBryWQkSTvHT/XUVGEXCAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749283162; c=relaxed/simple;
	bh=S426OdF93Rt+a3p5ppklciDEvu/Hm2Jsj675w3tXrj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb/itDfBNDjrr+VmezfY/Yshpjq6glXn7LThL4rnkjmI0rK1Gm0Yi3cIs5lGYiqHH+ujBb603xNZK6ZoBkpshuKEBRYaAd8Ft7F9dtHUNRm83wTD+QDIyknR6VGuw3bsrhKnTG5ovrxnKF37T/JKf9jzniEcNT8glmcebXa+R8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P64UyzzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749283159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mMxMfTey5myO1nuvBBdoQ9yFV5viR/KDVxlFQagbxA0=;
	b=P64UyzzFeTmfJnBOM7eiHKZgr+2liEhkl3OQ3bBd3reCHEUZmz+vcs+sTJxcSvshVl3dLO
	wdl1VyaHNzHqdBgT8hOj4kdiUTKItgMSKtSQ8pUTWS5CO9Ars+BQnLdT88MMGzPpmlKaNB
	+SwpbCXI0cIJHrpvsjjIuvDTMyZ0bKc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-iNXA2ooIPG6Z3hZ9nhiGpA-1; Sat, 07 Jun 2025 03:59:18 -0400
X-MC-Unique: iNXA2ooIPG6Z3hZ9nhiGpA-1
X-Mimecast-MFC-AGG-ID: iNXA2ooIPG6Z3hZ9nhiGpA_1749283157
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450df53d461so22516835e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jun 2025 00:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749283157; x=1749887957;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMxMfTey5myO1nuvBBdoQ9yFV5viR/KDVxlFQagbxA0=;
        b=kMnp58F2gwd99iyUwMACVByOjKalMIQpXncVqR/817pORByUdpOiI+6l52UZDJsb5z
         RNYDBY0Apjhyvttb4IKHUt2FDt0/vmhj8H1GlNA1Y5ooktMQP6ln2pr/Bs61/U5cQqHw
         5/6rKfDrQ2fHNnvDmjsvuzIR74/5Uic6XjiTv592gEI2NPH3nOe4wIoLCRFv0NtkW4dW
         dN2YpHbUK2UKzPHsrADSJP0H3sBucPEio2xk2HB9MEYNKjD4ShMRGSb1Tl/ehLCvqXbn
         vsn/S6Udg3i2eVLIa1w3vNpnYmJBU2SJsZbCUklCMfXVXO4fp6pnqvUQ+i7pDgDMNDKj
         G25g==
X-Forwarded-Encrypted: i=1; AJvYcCWxD47nF67Pb9LfvzbhSEsB60z3PJkGjVVMRdUhaaB/7Ns9O3sODyikbD5yHpwi3ek/2nVnyTeIl28AbRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5deeqTgesoLjkakjMkCceaFTgrLnTzbALdJTJglgxR+5lArX
	5g7zgPg+veVMvtIFg+C+CFeSs/suGoNIaxpEfLOOpkK+3D4MymiiiG8NV9wwy5+nhsGQ/W0BANn
	/WU7BfzU4K6ZaDxA4XGEbR5c3w0x+eA0HZ76ZBkkBW2BJMG1QhVuq/wFL2vWqtsk2bQ==
X-Gm-Gg: ASbGncs0jzO16TBiOAs4V96mrVYveCjDkWC7Yg03/JiTvIwiSPCnqPGgabj8L9dIBIm
	YWOv8vJ3lx7fDdLWOz0ja7RazR/EiNWy/4eL7C1RA2JaRuO/SNOAMpMk1n40t5WLwvI+3wGuN/P
	jrzHEO/Rcf925a/G611d5LzbyY1rt8RYUFH+32x8X3bzdjvNQ4xzCU2VEVoARNpjX/E8tBnb115
	yaJ5PeTJHqU/TtKQuGXZTSQHF89If2anmAPU7STtqujtK+WCn3cfNhFJlB4PaGBxxGNOXj/3kpG
	avsiHhwvnXWVevHruJu5olPfd+Ff/Q3NhoTtpqjZgJVrc91Uh9O6Nq7RokhAiNFzICHRSTvguHl
	9Oe6BKZ2J0mmdLu43r9sE2z1Ab/1wKDwqpleophjJTyrh
X-Received: by 2002:adf:ee47:0:b0:3a5:3e47:8af5 with SMTP id ffacd0b85a97d-3a53e478c24mr619281f8f.27.1749283156670;
        Sat, 07 Jun 2025 00:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bv5kWgSFN85r7D/wN0KvIK63OuUy04i+18rhFiKPZifQa/vYSJOlOkDIDyNuoSqfS+4oTQ==
X-Received: by 2002:adf:ee47:0:b0:3a5:3e47:8af5 with SMTP id ffacd0b85a97d-3a53e478c24mr619263f8f.27.1749283156258;
        Sat, 07 Jun 2025 00:59:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:9f00:3bce:123:c78a:cc8? (p200300d82f4d9f003bce0123c78a0cc8.dip0.t-ipconnect.de. [2003:d8:2f4d:9f00:3bce:123:c78a:cc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c73b8sm46391245e9.29.2025.06.07.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 00:59:15 -0700 (PDT)
Message-ID: <2a768123-4423-4f52-a0ef-96fa69872949@redhat.com>
Date: Sat, 7 Jun 2025 09:59:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug: Use BUILD_BUG_ON_INVALID() for VIRTUAL_BUG_ON()
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250607-virtual_bug_on_invalid-v1-1-b792ac2b0920@columbia.edu>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250607-virtual_bug_on_invalid-v1-1-b792ac2b0920@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.25 09:09, Tal Zussman wrote:
> This allows the compiler to validate the condition even with
> CONFIG_DEBUG_VIRTUAL disabled, and aligns VIRTUAL_BUG_ON() with the
> other macros in mmdebug.h.
> 

In the light of recent discussions, I think we should get rid of 
VIRTUAL_BUG_ON completely.

There are only a hand full of callers, and I am preety sure for most of 
them VM_WARN_ON is a suitable replacement.

> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   include/linux/mmdebug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index a0a3894900ed..012aef40e7a9 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -129,7 +129,7 @@ void vma_iter_dump_tree(const struct vma_iterator *vmi);
>   #ifdef CONFIG_DEBUG_VIRTUAL
>   #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
>   #else
> -#define VIRTUAL_BUG_ON(cond) do { } while (0)
> +#define VIRTUAL_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
>   #endif
>   
>   #ifdef CONFIG_DEBUG_VM_PGFLAGS
> 
> ---
> base-commit: efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec
> change-id: 20250607-virtual_bug_on_invalid-81d24b276109
> 
> Best regards,


-- 
Cheers,

David / dhildenb


