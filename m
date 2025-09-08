Return-Path: <linux-kernel+bounces-805679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467A3B48C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035D23B964C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6022FE15;
	Mon,  8 Sep 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYe1RXZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473722FDE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331134; cv=none; b=aCgIBfnE2Dubj0tX6hiIOaEQVXsgH6HZv0OgIIvCHBqjqF8Ky6o71UrVxhnbz5UyXv+5GFWqCCF75sLc8Wr7SKvRYQ9mD/NNeeM3rchkiDfULeC9R0Pc7J/2WCK++Twcb76fW/Gt2MrazKhR5yn10uPHyih20jz5dnmBN5kv1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331134; c=relaxed/simple;
	bh=LnQQYMf2rwXs2z9syH6/UkYtWw8tWoewpzKRVV1XqEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhNDzBNaGYnaXW1GiOgBf3N7rXctIxbuXeMZCfIyWlrxGiy5irOt2Hv1QBMgrd5QTOuXPMx+uJlTIF+p50R3GUjtWq8C2SdlXzuHkqjZj+sRau5yjUBM432ALUOZqhSTjYgyhth7pMF7UDQTONUkDOAEAQuEPOB8sQoVI8rrgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYe1RXZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757331130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RYeX7k5oRCR16YPZ+uV5QGYD9PnDjnkG4tjflkns4Go=;
	b=cYe1RXZrhMFPLcgAq7bhQogw4J1YxOnObNgCca5J8kBSEnPotzZ78Rd0ABYTr5JpXjMtTy
	OyhifihtMMKY3/wnXmmNnQ8v4Gv2z4WDfqcLUUjE+GszsZYs37r0QRwezgp/ZFCJnicxyG
	IRTIY8A/oVauo9rjKxkeJybhssRqCz8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-0syynVYcOQKR6bO8HveS_g-1; Mon, 08 Sep 2025 07:32:09 -0400
X-MC-Unique: 0syynVYcOQKR6bO8HveS_g-1
X-Mimecast-MFC-AGG-ID: 0syynVYcOQKR6bO8HveS_g_1757331128
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso2669455f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331127; x=1757935927;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYeX7k5oRCR16YPZ+uV5QGYD9PnDjnkG4tjflkns4Go=;
        b=YPTLn+3uD38yWDgJjTRteO2zaW+kwxVhv7Oev8eKPCym0wBtlVcXKW8mnc16z+2+I0
         3QwvZL8+LcnH6BuNhnlkVA+XhbrtHP5zfKe5602tQwW5HqS99TkW9kmezsZyoBcHMLUL
         fg8ohmOnufCKxl1wzRS2MkovKrZW7mmWEXoT7VjQe3p9Odgk+xDcoBY+wTYUgB21YmvL
         1yjfVlOk2l8pfVrxMEWRDCXXdb+PacsALrIc07nYcvViUD9rCaYFYQR0CeBmmizNAazJ
         e/lVkmqxeRq4zEv1Zddkzj3w9Scv4eHIQFtwRezlpwhuKe6Jn1vM0ZaE9h3/0Wghqkkh
         GQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyli3KValT3j5hTjhY0ORVi3PuvLLU/7UX11MZN7nPfaQTFz0t5W4hiG7i6ePEPhGa3DdNz4MLDoAEOHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzYv53dAN7T6AVQVM9YaXwjMX/8ztBIsW+NGsoBChgrWiJ5pM
	lmolhMKlXHg3dpQHuNkTnogQFeJ0Cs8mftBcP+WU/lv1ZBihxvjbsit8tFUrdjVwQoqN/bnhqSa
	OIBRdLW/6H03B0KeYAybYs9RahxsIb8x4uy3xi1QDbV+1bKtxQJjEaVoTfCADcUwJ5w==
X-Gm-Gg: ASbGncuPl8UVOso7rbS5Nh67Xwcu3XPSekUinuWXGaymaAteP6TwUvv9StscHIXP3yL
	91RwR4EhOi2DimZ3XL4TQHKkD3NOSg5K//ICR9HIhpURUXvD1j076ilBiHlKkfKEiUFjvxux5/m
	kcrtyUr3G4X8BnDiSwPKL+WbT6siVrNFThzj/qlDH4micViNCwFs3fY9E5BaCZPCCqts6GawICu
	3rfCkYfksFpBdvq2kQfNMf7JrAR7HTPV5svgmbMKSqj962mKPGl3NwG4f97YuFgCMrIebuo0B5+
	IwU/jGI4OF8FnyLcxXpZtDHiga/N/bVUL02TBjsvzHzbpE4KXuYQffJnGDpiRZge+JErHVmHfaZ
	9eB22SH+DqggWPRH2qS4zPfg3ImNG5/Sb9o07qdcWgv9T6d4vj29IfjspXoxGrm3q
X-Received: by 2002:a5d:64c9:0:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e637370e00mr6117573f8f.19.1757331127574;
        Mon, 08 Sep 2025 04:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY+jANGJPz1N5JVRub3EJpf4jLmRvSxYXoqHXGGBahJ9/Jyo/gddwYQiuqVCMXaKAZtZzmog==
X-Received: by 2002:a5d:64c9:0:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e637370e00mr6117547f8f.19.1757331127112;
        Mon, 08 Sep 2025 04:32:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9cebsm41095491f8f.46.2025.09.08.04.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:32:06 -0700 (PDT)
Message-ID: <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>
Date: Mon, 8 Sep 2025 13:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
To: Kiryl Shutsemau <kirill@shutemov.name>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 12:38, Kiryl Shutsemau wrote:
> On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
>> it does not make sense to try to detect whether it is underused, because
>> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
>> actually replace any zeroed pages by the shared zeropage.
> 
> It makes me think, does KSM follows the same logic as
> try_to_map_unused_to_zeropage()?
> 
> I cannot immediately find what prevents KSM from replacing zeroed mlocked
> folio with ZERO_PAGE().
> 
> Hm?

I assume if you're using mlock and at the same time enable KSM for a 
process/VMA, you're doing something wrong.

In contrast, THP is supposed to be transparent (yeah, I know ...).

-- 
Cheers

David / dhildenb


