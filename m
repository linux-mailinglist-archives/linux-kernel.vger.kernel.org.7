Return-Path: <linux-kernel+bounces-799016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D11B425E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2593F54809B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365B286D72;
	Wed,  3 Sep 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnBI9Pgs"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DC286416
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914554; cv=none; b=IXmX8Gz8ctzoF8PJfb+yy7EiRmVionr+/fvsDmgANs5nZQfuwsN1CnbDIIciyqJMrRyyh5VH5QydK6AcvAkHkUwlAQt8dhywqgr3eQ61vueaRIRIhLaBa20MsBbuyDFSz8QQNURbJSGIPRJtjaH3adeeCFwV83gqs7lxXQiynmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914554; c=relaxed/simple;
	bh=fugj/zt+fEU/iFFoZk+PW13jWqLJMoHWLUOZBzwNPvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwCEP2yLk3UppV4OYF24G2NO8VNiZQAU924Y5flx/9hy7uSl2BDwp3H11bvpRM+tvh6QwyumISz81MBitgDvEB/k4Tp03ZaJO8nKtEslTuw9r2YcOhMwUTmNLPYg/TtYejKzjUYa+buxLqCA5JW/9lmsnw6MhWl13t3+cpup01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnBI9Pgs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d17f24d42fso92995f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756914551; x=1757519351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWM/Ee9c5tZH794jcWBxxK/ZiW23+RWkflZdSBvqMV4=;
        b=OnBI9PgsFuqY3Hk/gLWgDJpbGFxOdWI55mftwvoUtThDh83ZfCS+q20OSJ0Lnj2qet
         ExK7xMJ/4+QNFbAz18wsbOh846xRQOI8bn67BfnYBfTE3utaObfsIvaZoStkoxpqwW6a
         /c4UzIPrcbEhlpemGPEcZIKWKbCNF1GVF5/Pzmf5z/XLgzSRforzYCLyCMVnpRLB81/s
         MupWueO89y/9/ggTrO+mtr44vrMQ2zcOK/IbP+985N3VWUrE7MOCQAa6DWQ9rmmkKaWp
         7dL7Qipb544WBIStJ4NfN0VaupevSzIz7kgxRxePbsVn7s32FWh041hWmICyEIMcO4Cw
         qdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914551; x=1757519351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWM/Ee9c5tZH794jcWBxxK/ZiW23+RWkflZdSBvqMV4=;
        b=KyFTqtXpU20WkIdHrsU9uKKJk1Jc05oOqlXJP4gd3evFhMQLS+KBPr5XrS4VpJv4N2
         gJe2LO8fZBATWGm4+5RJ+AHeA1BZtgSIHvlz0O2U+ikG8/Fpapxdc+lNqXx1JIKPlTY1
         GZO3Qs9LDuEoUOQ0ttQJQXSJ4jK6oUszRVm66+oJyTNFoNT989USuja+1OOMUqJ3zkWL
         pIuBGtAP7Uavwpje1l8pO2ZZscNRcol07yR+/bBaijlk7jVyztScdfbxSU8qsQIszjgC
         wkgAGVxow54vO9b4JSr7vk9zW9Zxib0o5LLFd9KRUGtG6pv2FrsILD7HqSaMEo2TlRWJ
         7tTg==
X-Forwarded-Encrypted: i=1; AJvYcCUTKHSdaADjr4wsonXX7sqlwNDBR9RRAk3y+V29APe3Yge5TV7ioSTpqpLyhp8aj3PqwjXZD1eSUNJdDa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws40gJUSCPHyOz8dRuswWKr4rWDk3m3sJ6vuitcTRLZwDro0BV
	Dy1mCWs2f5jlKgyI8rnrpadyy2FNH4gwOOgMrvE4V3+UpYXvIq/jdbCB
X-Gm-Gg: ASbGncvQ+WDKSUgiOOQuRmA4KzwVNgBN20L3N+r1QgwDS+lmkmBYZYi7AFgsuzGyP4p
	tAR6IXDnpVWsQNqvr85YPa6bf3LAJE9nqCZshHiScqNn861XTF71da+pwkxSEr95vLL2UTNKgO7
	42DXFMT6g5GT8Zv1Mk2usvVERMJ29FCznxCwRMRNXMt+QHCG2dGzGUoZKtFPdulYGkjOT/CP+wv
	iS0/wyHZN96Jjgs4n56rgzQw/bqekWNMVRu2RjfAOPdL/qopM06Ovr7Ocl3z6WXMAhkU7yjQdx8
	SY2e/15ha6AP56B3zI6I+L8XgGzqo7XWn1RVR/vn5jhwUojSaOLUQnWIzizU4qSwC4VM7W8kBOY
	9nP8LQMFTSAtEdWkPZBCqt/R9hxLfr3axTsDEqPmtINdPkFD4gsqdQwcEjpkSNYC5JW1kDHO49U
	o5
X-Google-Smtp-Source: AGHT+IFt8LtX9m01F0TUuz2lfDDhzFr0dtBjRXexiZOo1zqUyYUKfasS8UrB0/k8solqEJWkCmlVAg==
X-Received: by 2002:a05:6000:24c3:b0:3dc:364d:8de6 with SMTP id ffacd0b85a97d-3dc364d903dmr3386228f8f.54.1756914551407;
        Wed, 03 Sep 2025 08:49:11 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::5:3267])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm24120485f8f.47.2025.09.03.08.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:49:10 -0700 (PDT)
Message-ID: <c222c848-6636-46ef-9249-707d18046297@gmail.com>
Date: Wed, 3 Sep 2025 16:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling before printing
Content-Language: en-GB
To: Yueyang Pan <pyyjason@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Vishal Moola <vishal.moola@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <cover.1756897825.git.pyyjason@gmail.com>
 <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/09/2025 12:16, Yueyang Pan wrote:
> This patch prints the status of the memory allocation profiling
> before __show_mem actually prints the detailed allocation info.
> This way will let us know the `0B` we saw in allocation info is
> because the profiling is disabled or the allocation is actually
> 0B.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Acked-by: Usama Arif <usamaarif642@gmail.com>

> ---
>  mm/show_mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index ecf20a93ea54..fd85a028a926 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -427,7 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  
>  		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
>  		if (nr) {
> -			pr_notice("Memory allocations:\n");
> +			pr_notice("Memory allocations (profiling is currently turned %s):\n",
> +				mem_alloc_profiling_enabled() ? "on" : "off");
>  			for (i = 0; i < nr; i++) {
>  				struct codetag *ct = tags[i].ct;
>  				struct alloc_tag *tag = ct_to_alloc_tag(ct);


