Return-Path: <linux-kernel+bounces-841398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A404BB7329
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690A73B9C87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EE23D7FA;
	Fri,  3 Oct 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJOek665"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D41F582B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502174; cv=none; b=YUaQaQQEg+8tdnRx3mfr6EhqsqTl+aQmeBYFMIXkrSBglJ4YsSOYJdevcSmXLHpBvTirJcD0AOnFbjBf9Moa1ePcrIrR1KMEU7PMKl5MFJ3C57WaF2pK1aSZ8OTkqG/EVsiwtvwt+x5EA9N48P8uyiKpgwlsJiEAWvWyOBCZEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502174; c=relaxed/simple;
	bh=bYjSk8Ypc1n2s59RMVDs0A3Hzp1UgoVvvy3OgxJfz4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1Ihyr5a87G0a+6cddsbZAyWBV5079W25rknT8W2lJxCh/uwRp1YTXX7rKCx4oKzY+vvJk2by60RgagtSGo25SdHO1kYrgpoI/nJawusEVKSm/5hNqo5VtR/SKUIV1SpBuZo80N5/b8MX7bX0deDJFfNB9SFf9r62JKzBnlWOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJOek665; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso1399485f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759502171; x=1760106971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3bsilfe4P9JMaLp7V6K7RsRiPhrCocOZhdOz70gDbg=;
        b=EJOek665jLhl2W1vLQzrVqEvQF6um9zgfII0xqNdZBpxLvlQ9AvkxrbGzxgKsj85Ed
         UoYt5hFdQ2uaY75iEtQagMc2tP42i+04oA+473Tu+jaFv9lWIoRjsXbXXfZsPvtgQY6q
         vJrx6LpoxJk415Y15/flyjSxrdU7JHR/WXyVHWTnNTuv5EjelgwmfRV6EHoUGelnYdSh
         zW8qjn/ZC9RIFev89LwlHtzU5iqWAZ5aMgE0hv2LqkO/8zi6cCNpjVPYTB1hWFRne0k1
         26h8U/1fW7ZZicWMl5Ukq4aFVxGwt5NOtcWSHuSkMhLamqZid38MMw0RJFe3Z0koPaGp
         dyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759502171; x=1760106971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3bsilfe4P9JMaLp7V6K7RsRiPhrCocOZhdOz70gDbg=;
        b=TE+SUhqURu4WMzqf+5op8wydLTSbvUWZG9QGe5x7s0mvfGRc9KWy8aAufvpzkKx13b
         3V4YuL9PYS5RBplrhG1d8Jtp9DpwRtJBjIgzb444fLKo3Ux7iJu46fYJA1Na9h6O1Pls
         jSGL4h8XPP+FC0qoPr909nLuNvRs/8WEf7PtHDtcsjlPdd/PGKi8x+n85mNyi1YQnd0s
         avV2A7IRCOegIT7o+dtmzrzYkMhOH/JpCcm23smDIoC7dz1i9mRaGaFUbWGr8PU+fW9X
         Sy4Qt4/bQoaHV4uexmM0zW5a7ugP8Em55TNipzWhQhxg1SenqwP19f85dFI/+93if2ak
         JIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3XSgnomW67CXvD+YI71YphqgKLZrvhMs19qGOJmRdFJcun4+EUhsmlLmFrfMNtjme+8SqI2gwO9J2xzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjRlIn3n3z9xKRlpkIbygVVVbt9X1xbJQpQW31C7snU8nOqVe
	XxtLOCnbA+PdmSUaEXmQEYzHyo5WOL0pTcuSsp+YfiGj3OyEPD22vaYp
X-Gm-Gg: ASbGncs6gH1n37QTsBFVZDcQO6FDBKye2BnXlAdIMkoz0QGX3gARqlf2mHsMiK73E7a
	8KfVzoqba17Dkrq1ilEB4MZ44u+YaTkCOWsJir+f0ORL5zJCyh8xXDUzhBparrwpnFO4UQrsAxV
	z6mgZmWOKoP/SrlzeEVKdLX0JsVMPlMY4QXoLYM62COmNxK0x8VvGOLgtnM0Om/cMhOhzsWkT0O
	idtyv98hrgNPT6yxOb9GQxbPJk1KVwBfvvM+dTaoLS5/eRgl0XEEe7WczLvZh8PPX804OdK+STP
	CgHiO3ML8uvdieIxGEJWxhUHdpbeOtpu5SGQnzYq0QhMrfnZdRpznd3VF2+VVA0yEA+8hFsNwtS
	ljilR00YlbCmP/4gKQQpKMCiYENSQCjlM/8hJRaYiv8FGUyRqqE5U10eCjpmqQ1zMhw6U5u/CwB
	/B5K+8w+i+aWCHK46CLSK+5aKPB12AKdX3tZcx+HgCvwAlxivZ1Rkd
X-Google-Smtp-Source: AGHT+IEHT3U1d/GKQ/eYSM50OfGWitdYsfgfJV0bECxpi6CkX6MrtzWeGs8zaVLwyNg6i+5+M/ZOoQ==
X-Received: by 2002:a5d:588f:0:b0:3ee:14db:701c with SMTP id ffacd0b85a97d-425671c0f54mr1955781f8f.41.1759502170809;
        Fri, 03 Oct 2025 07:36:10 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b005dsm8102931f8f.25.2025.10.03.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 07:36:10 -0700 (PDT)
Message-ID: <550dd78f-bf85-41d6-9c3b-472784b2d94e@gmail.com>
Date: Fri, 3 Oct 2025 15:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: skip folio_activate() for mlocked folios
Content-Language: en-GB
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/10/2025 15:19, Dmitry Ilvokhin wrote:
> __mlock_folio() should update stats, when lruvec_add_folio() is called,
> but if folio_test_clear_lru() check failed, then __mlock_folio() gives

nit: s/failed/fails/
> up early. From the other hand, folio_mark_accessed() calls

nit: s/From/On/
> folio_activate() which also calls folio_test_clear_lru() down the line.
> When folio_activate() successfully removed folio from LRU,
> __mlock_folio() will not update any stats, which will lead to inaccurate
> values in /proc/meminfo as well as cgroup memory.stat.
> 
> To prevent this case from happening also check for folio_test_mlocked()
> in folio_mark_accessed(). If folio is not yet marked as unevictable, but
> already marked as mlocked, then skip folio_activate() call to allow
> __mlock_folio() to make all necessary updates.

Would it make sense to write over here that its safe to skip activating
an mlocked folio?
> 
> To observe the problem mmap() and mlock() big file and check Unevictable
> and Mlocked values from /proc/meminfo. On freshly booted system without
> any other mlocked memory we expect them to match or be quite close.
> 
> See below for more detailed reproduction steps. Source code of stat.c
> is available at [1].
> 
>   $ head -c 8G < /dev/urandom > /tmp/random.bin
> 
>   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
>   $ /tmp/stat
>   Unevictable:     8389668 kB
>   Mlocked:         8389700 kB
> 
>   Need to run binary twice. Problem does not reproduce on the first run,
>   but always reproduces on the second run.
> 
>   $ /tmp/stat
>   Unevictable:     5374676 kB
>   Mlocked:         8389332 kB
> 
> [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> 
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---


Thanks for the patch!

Personally I would just use the comment you have written below to create the commit message.
You probably dont really need to write all the function calls paths?

Also, I don't think you need () for all the functions in the commit message, although
thats my personal preference.

Apart from changes in the commit message, lgtm.

Feel free to add after commit message fixups.

Acked-by: Usama Arif <usamaarif642@gmail.com>


>  mm/swap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 2260dcd2775e..f682f070160b 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
>  		 * this list is never rotated or maintained, so marking an
>  		 * unevictable page accessed has no effect.
>  		 */
> +	} else if (folio_test_mlocked(folio)) {
> +		/*
> +		 * Pages that are mlocked, but not yet on unevictable LRU.
> +		 * They might be still in mlock_fbatch waiting to be processed
> +		 * and activating it here might interfere with
> +		 * mlock_folio_batch(). __mlock_folio() will fail
> +		 * folio_test_clear_lru() check and give up. It happens because
> +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> +		 * folio to activate batch.
> +		 */
>  	} else if (!folio_test_active(folio)) {
>  		/*
>  		 * If the folio is on the LRU, queue it for activation via


