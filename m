Return-Path: <linux-kernel+bounces-844136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4814BC11A1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FC3F4F39C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1062D94BB;
	Tue,  7 Oct 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfbOpB3J"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FAE55A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835532; cv=none; b=Z47BHBNJK/WryGO+k2FEwedFtBC9cW4sl8+iUQIzFGA2HbDaGYU0fVjqIPnUzRplSXRhLzEkYaJodk9XQhnVq5OqAUF2S1cj+Zo7p6hOxP4QNAG9x6k8X5P/46+6I5QlzUtreZbiELnIm/ItsqCfTLU46UvR9naCX22r6+L3EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835532; c=relaxed/simple;
	bh=0tRTQVIxs/q5Q+Hy3g5FmzBunJcJwAq3/m8TJlQzte4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skgspsgycZaPbcsS14EQ6wVcI2mVZaHetGSXkN0ChNb9ab2heYilBOFT4UcbKYgAFJ5PqUWvD0aW5bMZjeTB/vJNZJvDVI4AGK3Aex8M1SRZdCHcOPMoIrX/ATsdzxq3so0330Lyg6wicG6HEJ0D3jfrAnQEuzOwKQAvXM+pqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfbOpB3J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4583786f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835529; x=1760440329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocYnZTYhvxaa0KoO8huddSXbdFmRkGMfcfmF/WCGuz0=;
        b=RfbOpB3JGA4TYkT3UFFvRFQqZ1wThfcWIci7RLeJH9mYX0kZAd8YhC/CjhZwC60+92
         SKmaKLO/+oncK6PbOh1pEZDEm99EmYFjUHhpLvYYrHFZtarJ8LwHeAG8gfOPNHDUG0fs
         sngMzwmrUMPuza9pTF6gYK/N0pJam3M1DV17SxxvC5CIaWbtzEF8W4fT0tJbYaVYc4+g
         Lho722Vugj4wxLGIkwjqESKR9Xkz4cU3P+cxe11Bf/YyK0EUfwPjjOERr5dy9BxeoX4m
         dNFk44JksVxR8nDTpnIHnitAcxeg7SvRzAAkglJY7Ejs+r7xJN6UFvA938JJg4G3jlVD
         NLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835529; x=1760440329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocYnZTYhvxaa0KoO8huddSXbdFmRkGMfcfmF/WCGuz0=;
        b=sv902RMxpB2/4I8UnsU5xhC23cUebrhXeDyPYjyoqT2GHC/FgwJyIrZHT1R731W4MJ
         laqk03mu2IauTweYquMB73rkClgWrIeNXhkwMGxUdSlMB2bWm71P6A29mkcpjDE7puUO
         NzUxYjpNLeVP47G1jzBYPT3rYV43i+qoO1cbCH20eB1hrqV6q/7MNfZcMJgejx3CjFok
         W9CTA0IfkHVui4YUKAGTLNyQ5KEb6bycKSi4vWjajeqhPYlK6/qetU33Xcdq86MUG2OK
         VZzPuhdRI5Jgp7Exv2reEuEMGqGi9OaazUEiEp42+Ke/pZTxQ+S21FfH7LsrHN2kBvV5
         izkw==
X-Forwarded-Encrypted: i=1; AJvYcCX1eGd1hBkjpaATcop/jEpywxi7nXsr32EiIYl0SoH98Y4qAUHiKk2TKOplcA+EOXIoFSkJdt25xXAtqeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdurARgbTHXIM5V8PTo6067+a42ZlHTePmaMr0htv69rN79YgO
	7GcyHV9tpTLNQGyxV41B1X+VWGU+K33R2BF/GRqY5BnXtWqvjH99NhPt
X-Gm-Gg: ASbGncv/8BZy6bRaHWpfE7kWrQ5T20EZbyW460Q4+26zVmkVJtPdjRSdepmcobz1XX/
	ZszKlONUixvRoeNVB+dAH4htY8Ma2xQJQkiVySSGCoiSkzuU62i+80XN4A7LFL0JNByj9zHb/gl
	qXSwPycU1mGAqIKsyERLGlutkpKxIE6vWLXKG9+ntEg/vD9CFmaMzED4u0lP25g2wlPB1E16QAd
	Hc0qNOrYm/PSRJZVqT32PI1kiyhim6bGqxTECfceprWmROVW0KMeC1F5w0SNMWchvxRXyYp7WUg
	rBmsz18iOLd2eezSsUaFL3Jgg9HvdgnrLzkpuoyMypuYwSLPq4UJqe+CLK/jLX42h1j4Fvd5Rq8
	RdOvxj+MFT0i0Gu5xP3RFowWBkE0oJ1gJSMDfjIkrVgoVgi2ImwUN7xMGFOOBvUEtnZO6oLHZsX
	MzLqzSaYz67VEOewRdS4PHdzqHvqe73Gfc
X-Google-Smtp-Source: AGHT+IGN+cc5ZZpnHcEXI8f0KHWUoIw898vV1d9Wme0Eh5+yRRXXdczmyz6c9IhuGVi+7ydolzC3Ng==
X-Received: by 2002:a5d:5005:0:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-42583349adamr1261124f8f.1.1759835528500;
        Tue, 07 Oct 2025 04:12:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm25122214f8f.2.2025.10.07.04.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:12:07 -0700 (PDT)
Message-ID: <584d69ee-512a-4940-8348-d67f8b57fce1@gmail.com>
Date: Tue, 7 Oct 2025 12:13:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/zcrx: use folio_nr_pages() instead of shift
 operation
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251004030733.49304-1-pedrodemargomes@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251004030733.49304-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/25 04:07, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.

Looks straightforward, I'll take it into a branch.

> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   io_uring/zcrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index e5ff49f3425e..97fda3d65919 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -172,7 +172,7 @@ static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pag
>   		if (folio == last_folio)
>   			continue;
>   		last_folio = folio;
> -		res += 1UL << folio_order(folio);
> +		res += folio_nr_pages(folio);
>   	}
>   	return res;
>   }

-- 
Pavel Begunkov


