Return-Path: <linux-kernel+bounces-759860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13670B1E3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B701FA014B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8212512D8;
	Fri,  8 Aug 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2StPAMa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233024A067
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638599; cv=none; b=uOLGf1th1XYdiiBiW6z2pij7zLu/IyzlxYfIozRodGSIJ+wvT4HGaRff6BEEjd5cG6rB0+rV12y2fF2sETkMxH9FsGj2TevIcRo41HZ3ucvOZ/G2OY2nyKWWzi6aULZ2seeBscMcujn67z0pLyz34xwpM3kuN8dyHYlO8uyvuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638599; c=relaxed/simple;
	bh=myV+ze9aEL8T99IxIxdkVHEPXBXH6P4O/JFpjIkDH8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljaHtWvaFXEbzcD86FWYl/u/xHSfmRJu8pfE+z/VIbbe6tB16OpBs5tiQeIriyFVu8qXhnHItDSIVOzN0uZEkJnUb8hGLDV95eazqVai4kknMJZc5t3443sPInD8qY8pvd60F1NkMk6/5REjKtS0gH3uzpNQEGuQPMCpbD/jCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2StPAMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754638595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aGUp02ljgDkColao+b89/BR39VWVDPN8zzvjr1NWowo=;
	b=a2StPAMahE+ndN/+0c02+Hz5JHrtbpxEOtWgb86JTMNig9pR2468b0BL13MwFSvpdx7CXk
	F9YuemxPyeskricqeUqGdzM11Naw9QGO1qAA3cKtzou9iC0IW7hv7KeToXj+8ds0Ugbb5k
	R/vTeTP5LypJv8z+4wcvMduRkURe+74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-hrcZrbEAP7aaWlZt8zl8EQ-1; Fri, 08 Aug 2025 03:35:23 -0400
X-MC-Unique: hrcZrbEAP7aaWlZt8zl8EQ-1
X-Mimecast-MFC-AGG-ID: hrcZrbEAP7aaWlZt8zl8EQ_1754638522
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b8d612996cso1189094f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638522; x=1755243322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGUp02ljgDkColao+b89/BR39VWVDPN8zzvjr1NWowo=;
        b=iAcTqBJS079cIeA/4dxu5klk2Kac+9VOkvZa66e2T2bgs2e0Ehe9ZJekWBK1QAZx4w
         Iu2z7wiYBhQqU0v8Gr6StQZZwgUmhhpQZ/m6yDJD/RJkvQoIPMMk+joqeIGgWY0zXxBJ
         EAMLOQ9olrAu0m9mk96DclkX4nF1mDs17mrRjm9ElcpgADUS4iQ2fDivagqXmatp5OWa
         9M+rIMfy0Z7gvUXO9Z6zTrc80MwQWcuw4XKSq1n1DafSemieLCTbafDIXbcsG4sjnGQJ
         7DfrDpQtkbdKsqzE9aIwMhQf9mgruLvd7JwXnpb6u7XIT9RjwoWRSOFS1yiiTuwPvhv0
         JY0A==
X-Forwarded-Encrypted: i=1; AJvYcCWIoXiqAvfKoyLm/a6ZWUudksoaMsTiAT4RZp5RO9ru6dk2I+zEg2QbOl05S6+uV1yeNVlp16ESKXFyv+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstPY8KdmQJxtMU3F5PPxBED6SnfH+su4KQkpS6e+DQqXSRzv4
	DS94QB7YQyWkqRJnWX9E/V11GIRQX2kPTjOEVJBeY9xGki1roJo7dodZi0bZPmwA2bzC4Vne7Mn
	WvnNf8kSudoMPdjPB1IjvjL/X7kfguDkEJX34h+lztMV2nRaL9mgrHUprrkI9/jZBbw==
X-Gm-Gg: ASbGncu0sL50tynolKVgu30yOInOUEqNekYpHwBfJjpst1AXMlB5g5ykuaD4yzFihlT
	J4g79ZgsORpikdPFZQfrb58c7DKL8SqrlRynxEPDfrKH54NHgkE8Xul9KGgk8RVMcCRGB6SjxeO
	Otdx6vfECbwwnJxBCpt8XnNzMnOgHV+12lHjhXZCj0GraTyazAFxqkEMN5DssuCkG4dtuMJMk8O
	ca8YFs5vrq3Subt0a/XSunob06eJ91mUDtp1QP9Q5S+IMrXvNW1JW1BGnz7cI4wJgY5xO0ufznZ
	NHlc4nkE8HhJEr0THJwJoXdIk42Pm7aIhCR6+ZX9aGOH32rEebIxBsnxAa0xq33GXoS76HQ=
X-Received: by 2002:a05:6000:420a:b0:3b7:942c:5447 with SMTP id ffacd0b85a97d-3b900b80ffcmr1589213f8f.55.1754638521940;
        Fri, 08 Aug 2025 00:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUob1TxDp76fFmSgnDhx3VPz8XsypW4lOhMZeFT8ap01Q6k+aSGDNiJmcvI1+jkiC80gkcQg==
X-Received: by 2002:a05:6000:420a:b0:3b7:942c:5447 with SMTP id ffacd0b85a97d-3b900b80ffcmr1589178f8f.55.1754638521452;
        Fri, 08 Aug 2025 00:35:21 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a580.dip0.t-ipconnect.de. [87.161.165.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf93dsm29343830f8f.27.2025.08.08.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 00:35:21 -0700 (PDT)
Message-ID: <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
Date: Fri, 8 Aug 2025 09:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
To: Qingshuang Fu <fffsqian@163.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20250808072106.153449-1-fffsqian@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250808072106.153449-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.25 09:21, Qingshuang Fu wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Subject should probably be

"mm/vmscan: fix build bug in read_ctrl_pos"

> 
> Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
> is int,but MAX_CR_TIERS is an unsigned type, directly using
> the min function for comparison will result in an error:
> from mm/vmscan.c:15:
> mm/vmscan.c: In function ‘read_ctrl_pos’:
> ./include/linux/build_bug.h:78:41: error: static assertion failed:
> "min(tier, 4U - 1) signedness error, fix types or
> consider umin() before min_t()"
> And MAX_CR_TIERS is a macro definition defined as 4U,
> so min_t can be used to convert it to int type before
> performing the minimum value operation.
> 

Please use empty lines to make the description easier to read. Also, I 
think you can simplify this heavily.

We should add

Fixes: 37a260870f2c ("mm/mglru: rework type selection")

BUT

this commit is more than half a year old. How come no built bot 
complained about that?

IOW, what compiler are you using and why are only you able to trigger this>

> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
> ---
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7de11524a936..f991196fd8e5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3194,7 +3194,7 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
>   	pos->gain = gain;
>   	pos->refaulted = pos->total = 0;
>   
> -	for (i = tier % MAX_NR_TIERS; i <= min(tier, MAX_NR_TIERS - 1); i++) {
> +	for (i = tier % MAX_NR_TIERS; i <= min_t(int, tier, MAX_NR_TIERS - 1); i++) {
>   		pos->refaulted += lrugen->avg_refaulted[type][i] +
>   				  atomic_long_read(&lrugen->refaulted[hist][type][i]);
>   		pos->total += lrugen->avg_total[type][i] +


-- 
Cheers,

David / dhildenb


