Return-Path: <linux-kernel+bounces-898500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C7C556A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01FD54E1D56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F532F6927;
	Thu, 13 Nov 2025 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mSlQubCu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037A18D636
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000423; cv=none; b=FmlxkTJRuImBTXl3rlN4+98MtuA+WrKjcGexb+njUDuJ9xtuRUnA1JaomzojS9lGulJnZeUBpg8f8jY7xc+EfPTukJZVq17e3U8qkv8DspNijFTN4GgRksdXoL2GUoZLwlbbgt+22D7R0CXv4vp76w5UFcsH+fgtFW+M0K0h6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000423; c=relaxed/simple;
	bh=fCkzI0NP2q5JcJvxTPOpaNWnDEjnFQu9MkMV3EqXpMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AioGeF4b+WQ7rPRXw0IE9pW/52zQzGd5UYHro1kpcTt+p3FbMie1/3d2Um0QT9Z/ncEtI0n9tCBcDJVlIIAgMVUGiuBI8DHN8+nJ8QDXOZksXX5E0Mvabqp4odz1vMnyOAYLuh0yGU0ksUO+fjMbjxckpYK7ZipJLWEwJ4KBt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mSlQubCu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e982506fso3003755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763000421; x=1763605221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w2/PdviRdTlw070F73adAMmi8JBjtS57Q4Bt5NlWRI=;
        b=mSlQubCurCgAlCjkrJwBE8BO9AVRZTKeXRL0SP8GCUsP0/m8QYMdds9WgW+YpX9CfM
         rkPDkB5dVygBbneOM+ST0iRBhkSLjhM9G/WgeL6lnXMQrnkygWcttzeUf7BGi7KSLlUI
         WGVfVddNKRkwcApYQvf2q1pN3tTzYpauemJGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000421; x=1763605221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w2/PdviRdTlw070F73adAMmi8JBjtS57Q4Bt5NlWRI=;
        b=HxYPvknkqHtg9rtOQMjrEyhsntt4VeKVfCzqLh1UwAEPTDaWX0J9LQtWJeyymdKZ4+
         qIiODyDnnJsxBwR/hUQXGUiGA/G6aWr+1cuVmK4asK93616AdbrIayQX/GgJwUYosxJ+
         0SHvQiqzCyLNmmsn1ZXosknzA/o4Q+n1qGPTs4bNJBssEHFeO5Cfwjh5BcvleiSYSpDf
         MQxBlSkCfKG+Tb5HYzYwA9uy2RD9FFRwvEI6IE6yTk6GHeXrW3XAb85kMoKAzBcDkVLf
         Kq9k1GYHKqIx/U/tI8r+RmSmUsO4ABT9SqTS1mKui3zHmsJJyF4lHEiuuwLRNJa9Hty7
         6EAA==
X-Forwarded-Encrypted: i=1; AJvYcCVtrrZlKirV59grh00p1/oxCxDZ+EqunHUGbvtp4eJp/vbzWKie6jp91Q5UWcctHcO9UK3jf7xn6PNPvpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvvwO5fZfEB8tYg8Q387WmPu9F15EEifP10MWppQFnJO5O3Ow
	sDfZMC/FKF7RLArPOHG77sbIp+OwnRwy/5pHK23gQqXEgMb9b0rRJx5iL73haqmXIg==
X-Gm-Gg: ASbGncs8SwFeXTHVCy6GhlYsNBSZlE0ckIyuX0dJ2od7Zv75qXmyvrfrZ2fxL9Wb0ND
	dTLwbLWhKtRFYKniaW33ny0iJ5gIFcRovU4MBmDy5we1tWrCrM8M/wfBf2nv2BTe4bPJbkTrqoM
	iuarNq8Bzd2eexYHSohWUZep3G57eHhFeA5YPB2GmYr++GItPN70fiNC6MXJwncGyM093F8RgR/
	0LgdGDb1fko54U7jb3viI0wj8TU+SMfWWSyDqj8NIQOQXM5g/bhjXTQ1rkzLF4AoKDR+YqlPD6m
	OkM7rawkpwJpWUYrjkhGdQUo3GUMoXjgUhEIWVZrTs0wFwRI4bbsffdMHRYTj013taECX06OYoE
	mG2TnZP0SKyoseO8JLklL4Gr4UDF+xOAQx0HsuW8PVLHapgqdETZPi9KjR0F+9W02vBvbcVJlpW
	0g6pRs
X-Google-Smtp-Source: AGHT+IEEUGpj/C7xlJlOjaN9FHEmFsBqdEM3aCXQOZ4vqMNOSNOagKZXMJ3scVSlRlMs6U2ceqWAZg==
X-Received: by 2002:a17:902:da8b:b0:297:d939:393b with SMTP id d9443c01a7336-2984ee307f5mr53960045ad.58.1763000421049;
        Wed, 12 Nov 2025 18:20:21 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36fa02c42sm462699a12.16.2025.11.12.18.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:20:20 -0800 (PST)
Date: Thu, 13 Nov 2025 11:20:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
> +static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
> +	int pool_cnt, int *cnt_off)
> +{
> +	struct zram_wb_request *req = NULL;
> +	int i = 0;
> +
> +	for (i = *cnt_off; i < pool_cnt + *cnt_off; i++) {
> +		req = &pool[i % pool_cnt];
> +		if (!req->page) {
> +			/* This memory should be freed by the caller. */
> +			req->page = alloc_page(GFP_KERNEL);
> +			if (!req->page)
> +				continue;
> +		}
> +
> +		if (!test_and_set_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags)) {
> +			*cnt_off = (i + 1) % pool_cnt;
> +			return req;
> +		}
> +	}
> +	return NULL;
> +}

So I wonder if things will look simpler (is this the word I'm looking
for?) if you just have two lists for requests: one list for completed/idle
requests and one list for in-flight requests (and you move requests
around accordingly).  Then you don't need to iterate the pool and check
flags, you just can check list_empty(&idle_requests) and take the first
(front) element.

