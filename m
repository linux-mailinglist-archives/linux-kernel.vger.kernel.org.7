Return-Path: <linux-kernel+bounces-819588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525ACB5A370
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AAD3208F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D91B85F8;
	Tue, 16 Sep 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/9mhZwU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C631BCBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055684; cv=none; b=MG2D26Ou+7V1vhF4cZSzz7+oqmztDNmBDukqXpO8zZ7tvEwK2SLlDWuQG16bBm9tUqXikhg88vIHDI0p2vCqZfWJlsJIBc3uTpWgDy7CyfoE8rQn8qdfLbW3vpBcB7U4PtTn5YmgCDuKbAgHAVOPNAP52X3MDnlyagecTXgGyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055684; c=relaxed/simple;
	bh=+KL8rfCF8REg0hsyvWX6grF3wDtueBlcvpkD+pM3Zws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOoHq8QFFxnPgpurjNa2lyz7N7JKnrSflzz2pw6Q6yUjHIDfety43MDmz53v40F7pziRRS39wlUkZ9kOpzyMMKN/yAbL6FlNTSP3SS9NByXUEYGLWvX7TByy+agUE6FYGT3EhWdVit8UOjmGdTthzpVGhRUGUjiMx856UY32lzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/9mhZwU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e9042021faso2362054f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758055680; x=1758660480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnUpZJEnRBwm4SA8hacWkv0qxtpcVpis+ipIASBsxLg=;
        b=j/9mhZwUEMJ0QRXzJ3FW3ykL6JD9I+MALkgLEalDTL7Y/MfCMo+vQ6z8ecBB+oE//b
         Wl0N6lw/gGcc3bpirDiPkZoFnPwqVrxC93q5Y9K0MG62BWGOlVL2CQcj7GLkBXw2rH0o
         r50uEh6AD4KWO9sW3uGdycM4s9dGPNkIMv8NS1iPYAhbBHZQr2m+tdK383B/2e+xPKFf
         udEdvRPptcVQFkJHc7GTeqep0chHmukxbylTBvoUbtlYPide74lXHKmSaE0ptPc+Mi9E
         iRkLKTrdwhuzKQMN3rCe1aMFjNqsxhBRflzhUPeyvejo6aZU3zXNUeX/b0gdHxXPkEr3
         c4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055680; x=1758660480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnUpZJEnRBwm4SA8hacWkv0qxtpcVpis+ipIASBsxLg=;
        b=n2rJSK2iWRLVE+QskKQ64FOQ9Egh/04cUJXcWUuYggfvMfaG13nM7OmGiZ87B2d0So
         agMcW2ZMNZE4dATn0KoPrCjLfhwIUjrV+fm8/4WK5cwr2EadD7VBupDsZHwt9Vkp++bQ
         7MZ0VbuQfLMwFOIILt+BtWO5SD1wmc8j1OsXPAGH4bjdQUB/02sUnbgLhy6FGwMLfcPS
         /tHYWK7+3SnJJswNny6krhTapnnyAXIkCYnz+ekmy/QGvjAV4I6Uo3OaXjLrbkvOxdbJ
         8E3cJ7E4GXMztWFrMxf4Cyyva23HgHzswfP43dpQ1zr4BAa48dXsN45GSyrp71kZ0QNC
         DGBg==
X-Forwarded-Encrypted: i=1; AJvYcCXZpZtTAJOhUQ8UC1Kwb2seO6aINJwdT1EBBsmJ5ROkd4Bhb91t49U/Ob7L16zg0Pz07Vq1XfmO0cEnrzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznpl9k3qkePxEB/w62hmQe2BpX1cOa07pI0HMlEhpOVtE/WF09
	r3nGfFQoSGH4ZPVZ1aKaaAAklV57p47WjFw7PFnLbFNVtV6eVK+Ed+nT
X-Gm-Gg: ASbGncsjQYQRcbesXcDGuitd4a7FgZQWeCFgk43whCqnamz2Pv5/yS4m0ajJEXiHvui
	8GUecqxQHGg2QYyeDmIHDhXIccfY21QtkRhw6fBeyyTGh1mQpa1A5Ri5A3OsFIHSVt3virAQivp
	O41d07jRvVJZ5xOCe/P6EVJnEtrZFcQSNRWXkyL5HsNaC3NSCAx1N1rZfoTzAWFvC68BVkoRvnl
	mdBIvhch0y8f4DkE+vZunrmbgSA1TlIHIYEszWE7WqzxzEyAzaOG9Cp0KWQ+VUFpK2m84wslAFd
	xERQPtlrKiQLdHGZk8xfrBDG+mjZcXHA8xDhm+Lhelg1V7di2CvNyl3Bnv0UpGPAtSdLTOmAeSN
	H8YVITrXbUaXpVFbCWRAjoFZf1l2QHu6ravM190rbRS8qwRc+gnFDdDlmiOhTfddgJuGzrTl/v2
	hHxHSNHZoN1A6p3/vifQ==
X-Google-Smtp-Source: AGHT+IEkxcTio6GGFoM3muCkeaaC3BaAbrW6vbBnnuCs4pDQo46lP6f91xDpDnWdbW4d1+fTPKzarQ==
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id ffacd0b85a97d-3e765782b5fmr20202818f8f.5.1758055679917;
        Tue, 16 Sep 2025 13:47:59 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdb0a2752sm2366465f8f.56.2025.09.16.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:47:59 -0700 (PDT)
Message-ID: <4429cad8-5363-4bd0-8b7a-36396d322464@gmail.com>
Date: Tue, 16 Sep 2025 21:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] alloc_tag: avoid warnings when freeing
 non-compound "tail" pages
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250915212756.3998938-1-surenb@google.com>
 <20250915212756.3998938-4-surenb@google.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250915212756.3998938-4-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/09/2025 22:27, Suren Baghdasaryan wrote:
> When freeing "tail" pages of a non-compount high-order page, we properly
> subtract the allocation tag counters, however later when these pages are
> released, alloc_tag_sub() will issue warnings because tags for these pages
> are NULL.
> This issue was originally anticipated by Vlastimil in his review [1] and
> then recently reported by David.
> Prevent warnings by marking the tags empty.
> 
> [1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz/
> 
> Suggested-by: David Wang <00107082@163.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/page_alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>


