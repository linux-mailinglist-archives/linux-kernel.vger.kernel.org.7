Return-Path: <linux-kernel+bounces-823044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96596B8561A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E642F7AD778
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A32FE05B;
	Thu, 18 Sep 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IevnTVrc"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FED23E35B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207386; cv=none; b=LYC1iWa5Y2uiiHFb5E4d4sk2Qf9CMxlSjr4EbBX5wLM4RwSzzuLtza/dgFJiy7lU6PyAEtiTFPNU0AivWiy2tWiuCak0BjSwt44sxCTk0A0CMun6tJAV9QooJiHvNp01o4elLsC8gxeEyvzc5LhxHRzbRpCVQbq0vQFZZ2gjM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207386; c=relaxed/simple;
	bh=jTiG3p8/5Cyirt9ZDa6kAq1XBKr/rkPV5hXs+/DtJQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kl/3cj8Ia3CrW9Xf4hHVg0s5tPgZ8PM9DcA0RlW5DqNchPASpmmzNrH1S9rDPq5EWH9XmbdloDOTkwWAbysMRWOmjkRLOzaIh6wS0ltbxh48Wmm5Fy9o6NubdgOaog7/K6gPANodTDbiqvNUQi+fA9ppZylWYhzbi6UHfFiRlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IevnTVrc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5796051ee6aso88726e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207382; x=1758812182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLEbb9OTjmJAYJqu6c3MO0OPmYmXMj1PKVs4wdeVOFI=;
        b=IevnTVrcUYJmAI84AkE7sU9vZjJ7AcuWEytQsQlXZfW2SRsqYFYN8YYGl7/pEMqKrW
         5Ffe0YjAjmKFUzSHAxYSJxFWqOV+EWnk5RZUsf21aSaeYB6G62joK2XUoemT7+eNWk3A
         KJWjyLe/yI5AxImjLtExJyF7Y14GnKGNYTQ9c9BsWlyo/b+LOR1N7KO4Z9mj5LhdueWC
         0m2iKHilZP8Wimm+LaeAWLiYB+RlfU81sT1vvayywaCLGdJMJCY/GQg4lRznUA+HdUGN
         vmFctaYkYCH4dfJbQjJ9ZwJiUJ4j1EMG2ucTc2oLQzIo00UIjSFexxX1nOUkjV2tkMbj
         htpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207382; x=1758812182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLEbb9OTjmJAYJqu6c3MO0OPmYmXMj1PKVs4wdeVOFI=;
        b=Eto0NT14xb5s5DjsrLgPbZyfZuw2oZIlIINGrtPq7pfbxJW6tqdCq9JGscspEsPf60
         GFWP7RvL0sbhZojATBpy722bpYAme//W0V6uE63w8RfsH5qD58x0nowWyvLaaM0tYf6u
         2rfXu4CUOmSSRTsopP6LvAmiIRjDKl39i/pLt/xbASaon0Hx+sQPghRVpMGvhr86ceqe
         TuWoc1yCtRVsBdTFNmFGBHoDL9HdU/U22LyKQJfFd8CmQnl28/9+ta8KnPTeNZm5+n/R
         kQCrO5bfeu3UWE8cTtxjKbIouFhL8O8eMmsKMSIjBGTRR5veP58S4I5zJQf+RV+RKcCh
         P1gw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/GDnU5JeDJSUf3kIIjOM3aJm1ZgiDI1zLmX16KAU9VNjl+lGl0m7JXlx2UptcwaqMNzSOk7HxT7KJnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEedQ3Q5g8skCOxbJJME0NXPQwqv906tK4W8YW/ZA8io7XGsc
	xCfX/v+TRTfshj5oU5zYoxB/MhATy8taSCpTc2lgDoO/hHpxcvNi1DSsJcfCbtsVbRQ=
X-Gm-Gg: ASbGncsmAMdwvJqFPG3qI1SIwSYveLBgvSt+jm4KfQHct5WU+Lhz+bMeyzE53jXvzhj
	NhZt1jkH5RbPB0/Ei/uumx2gfU75p6/oyirhEZUw0bwJfQ8/lrbwyqq1S0KtODac/6nIkP5dzTP
	uD4QJU4ObDE56WNJO2C+Dstv7TxBL7gMT6GB71RN0ONyTQDNseWRmW+QhnE33Hc+lFJn/Fr52vY
	g5hTFjIbWyEvxjNNVso7hAlAUlpRB7+YqUkTnFXh86uB3022dzzF00dO75LqT/Y2Rk5MzVbeVUZ
	kFeOFWXTOofeLQ6MX3to7+nK2d+a/L+Sax+6gETedYl+5swVwjPUXNCO2kSL9nGovHuAuP11P3t
	ktcb6N9n1/Bjsaya7u1tO7xJiLcJd7y4DqLdxJtd85leJsuo=
X-Google-Smtp-Source: AGHT+IHfZ2BjCuVmOoSpDFI8qqduhH1E7JcHcsprZIxJGhRTVJCv1s/wP2yHnysogR8uwGSR2KbJIw==
X-Received: by 2002:ac2:5e7c:0:b0:578:113c:acdf with SMTP id 2adb3069b0e04-578113cb00dmr609184e87.10.1758207382331;
        Thu, 18 Sep 2025 07:56:22 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a994fb14sm705444e87.113.2025.09.18.07.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:56:20 -0700 (PDT)
Message-ID: <a012baae-d206-45de-a390-cddb78a5d379@gmail.com>
Date: Thu, 18 Sep 2025 16:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] mm/kasan: Support non-blocking GFP in
 kasan_populate_vmalloc()
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-8-urezki@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250915134041.151462-8-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 3:40 PM, Uladzislau Rezki (Sony) wrote:
> A "gfp_mask" is already passed to kasan_populate_vmalloc() as
> an argument to respect GFPs from callers and KASAN uses it for
> its internal allocations.
> 
> But apply_to_page_range() function ignores GFP flags due to a
> hard-coded mask.
> 
> Wrap the call with memalloc_apply_gfp_scope()/memalloc_restore_scope()
> so that non-blocking GFP flags(GFP_ATOMIC, GFP_NOWAIT) are respected.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>


