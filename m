Return-Path: <linux-kernel+bounces-807154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07994B4A0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5A01BC1E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05412F0689;
	Tue,  9 Sep 2025 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xf2hMHBl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A72EDD75
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393114; cv=none; b=tCchcXaqyajw2vbswnVaqY6Wq6QGbPMIiZzlvFqsJisp68wzO+F28gSeOxYAsbr7gaB8uBiYbSaXR0QtCvvVG2HzJ903+cqowwITJ6aH15EJuLxJ+/vMgpRmCOo6eoRUbZKvnXpsoL6dkpTHF0TgVT/KD3AFA/sRodO4NXnwx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393114; c=relaxed/simple;
	bh=h2zLb98Re6+TqRKu8El0vTIE3NVBQlmVT7tAxCoi1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acdmvzzT36DzUpTGkOOKwHG2haJa3OX/TPHUh8GjaTotSXZ2h8EnAWXwDYDY2hLaGFbB/8WDREyifsaKbLImwgE1a+fG/wlttdnF89jzhTb7XQ8aNbbCM4DKtAraoVLmuUrSlyML2vSfTBiBdQoiE6RKrAKLCfNSKJ5I4iJapZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xf2hMHBl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77269d19280so4693396b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757393112; x=1757997912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=Xf2hMHBl+UXL8Lp3bTw79IOd9pGlCaUUfYkJFA3vr/qq3N5kaKV9YNd4RoikmNY0xx
         h7WJmVSu4g7UWkRy/EVdL3FtOwr6y56r9QQ+7a7cPOIIa2CEMsNTuZ45ZKRlN0F4OQaG
         e3ZukZasF7Crsx1jKp2oxpk0DOJ1SC0J0snt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393112; x=1757997912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=THITlGC5vdVOHccSQghtqtx++VUfUssQJp+p/5crXeYI2NPrksull1bS9cqnogAK+y
         y13mOLlHHygy8UN635egLWgowS0Ejh77bU2mrKrR8WIedP5k74GUM8uC+sOLY3Ayofs6
         OHCW43qhixouvssCuWwzImjHuBG3/GJOAFBEsMu6oQleN8EYJssckiAkEk26rE64IxJQ
         dmMHZh9rcTF2GxFlDKux4iu1CsB6qD3C2fkMZ3udCmc2Nc2+KsjzGCWKjAK00loh2Jln
         NFLJquuueKlgyEs+Top12CV7QiiqekwADl7q9HKZRuf3KqzvfFWXtt7O8MM0RGpq/Vq4
         j9JA==
X-Forwarded-Encrypted: i=1; AJvYcCX72W/h6q8+Lu1PnLsZ7ZwV6eVMvkPsUKpZ+RATBsEjlXB15SZiat0H0YUj84UWBmPECa9wr5h19TTHym0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlemYh51inXrvAAhZ8b4GFbs4URqStB2VJqWITMFjUxXwWQHXt
	5jDP4q61t9SuTLZm9ZepbtE3rKzyOr5sRd0jBPdyERML7JU6vuqxX3bGOrv1Q74d9w==
X-Gm-Gg: ASbGncufI0ab8VzIIFe5wyw+CQ7/T3N1fhi/1ksv8hzB1XMDgK+xoCpBRx9OKiuoYPR
	IhrCvyhTIW/0OgOyvVSdKQQxQSTm86ojcCIrotuoeHwUFIU5hmdyA1vAhPSfQJWy26zQXjjelE6
	+N2socq2uFkx18s1NeBx7Lj4ed9KWKnGgOmPQW/UVD1BWc/uweV/tGD/OCngT1o24zxBYFx7wUo
	raVibTs9lIutFKV3sH2VS8iU8a2H5jdPA8kyoV//aMy36EHxYp31PKDojgTu1snNoZgKPP+QOQ5
	vnacqhgZ8PEJQuvvH68vtmUjUG/j6kPFd9aDlBGKKBFXZ9ej7e/ebf3owPMQWpLTJGz6f6wM6SH
	fZ5U2fu8FV9np1/+ZRMFnEiLupgpKbwPk0/oK
X-Google-Smtp-Source: AGHT+IGCqtZZ46cDNSS0o0PTPi1cbO52ZNRmi+3GMrDkXr5MYMYXI/v2R/W4TFVfMyFz8piB9a3T8Q==
X-Received: by 2002:a05:6a20:2588:b0:243:a2fa:e526 with SMTP id adf61e73a8af0-25340b1a86bmr17101612637.25.1757393112270;
        Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm27816286a12.23.2025.09.08.21.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:45:11 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:45:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Changhui Zhong <czhong@redhat.com>, Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix slot write race condition
Message-ID: <hpzh3r5ie2lc6abtaefhmijoxwem3f3myjixjzup2npcgd4hfh@vmqtdxtoeu6c>
References: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
 <20250909043110.627435-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909043110.627435-1-senozhatsky@chromium.org>

On (25/09/09 13:30), Sergey Senozhatsky wrote:
> @@ -1848,11 +1851,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	unsigned long element;
>  	bool same_filled;
>  
> -	/* First, free memory allocated to this slot (if any) */
> -	zram_slot_lock(zram, index);
> -	zram_free_page(zram, index);
> -	zram_slot_unlock(zram, index);
> -
>  	mem = kmap_local_page(page);
>  	same_filled = page_same_filled(mem, &element);
>  	kunmap_local(mem);
> @@ -1890,10 +1888,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		return -ENOMEM;
>  	}
>  
> +	zram_slot_lock(zram, index);
> +	zram_free_page(zram, index);
>  	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
>  	zcomp_stream_put(zstrm);
>  
> -	zram_slot_lock(zram, index);
>  	zram_set_handle(zram, index, handle);
>  	zram_set_obj_size(zram, index, comp_len);
>  	zram_slot_unlock(zram, index);

Let me send v2 shortly.  I don't think I like overlapping of
slot-lock and stream-lock scopes.

