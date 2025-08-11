Return-Path: <linux-kernel+bounces-762423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DDB20656
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C59E17F853
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EECA27A123;
	Mon, 11 Aug 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTtqf853"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568B275B0D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909350; cv=none; b=q3ivYKPvZ84h46mStNbZnddhUCPHGeYFTdWNSjPF3hJhNzGC1KW73m68m1N7r7Kn0RVN0V2d4FH0hKHLtdl1lxh/GhkzdvPoxVjO+l8mM5JFX3giWmT00gwAZL+jWhCJnkd8RFcP5BJ9Rn2vTT9MehSTqEKLyFfva+kuUXcKkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909350; c=relaxed/simple;
	bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oSNCYSRAJKz6YY6enWrfTp2nDjb9+dIhksVBTNfggx49m8WVyQqpwgK2B/nZqDVT3u9cKgHGKoZwBja3nnygUG14jswqDnYhkEtZAriSQzmdPLO/Rfsy3xZRE+Q+Syl5QuvRA8yG5mu3Gs+LEtsjVZAzjY3/N37MqzhoE6b51Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTtqf853; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
	b=QTtqf853hViejxFS3XZykqNgPlCq4OxxNYRsCLJczfLvCkB2N2rk7hVZWR6vOw9IMPkZM+
	k8ZToJjJkjxuYPBanyHJElqYLdc+aBkRZpKfc25d3UegFKXfYVrYXm5DB3QJXDDJrXNGyR
	lOxlZvwHVM6lZGdxovvB+7voaUnuyNg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-pOCUtWi6NOefyzN-Wc71cA-1; Mon, 11 Aug 2025 06:49:06 -0400
X-MC-Unique: pOCUtWi6NOefyzN-Wc71cA-1
X-Mimecast-MFC-AGG-ID: pOCUtWi6NOefyzN-Wc71cA_1754909346
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af91ca00e41so256474866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909346; x=1755514146;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKObFWIHeQBicsruWNzn9xqhX0Zs8CeGMF19cPRqKow=;
        b=KfepdMyTceNtAHeQA/ryNYP+yPr5lktcmVHQVPjA/Fk4uRA9bCo3xO6HAWrwHAQzFM
         0WuVv6D2Bk+gYwSyu7CUsl40f8y/H954S96OwnkvSlO+ns1e9oVY47ggaYYUTgINC7tY
         93iRos8WX2IbNbpwpNbZMoEUKBVvUTSzHBKSh5pOxJtZS9hdDsIzp/31FeHZpz1119Ua
         wD02/H067sDDbq2S5YbKOhCukEsmk7z5Of5KcLHiPwp1X41s95H9j4JSHLhZUmkM2RYG
         9VB8FMd190srKY6B10jrZVWtlcudA8r9oNYV/cj6+Fck5mLPi2M3nXeYfXThwkcynJEm
         40yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUl+cGgZ826nDluKoB512zqD8SGabxDdfeBrHdZ44vLSJlsM1k1AN8LzwYqyYX3QcD5i6Y+KAyUFgYSDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzupdst4SbsVyjOnjG/jz/jPI6l/a7FYcmwEQaXFHx/nAB3lubK
	Dtz8ARiggGXsNokuo9Xp09xlY/2VYFFM35MM/gCQPZWjAqdp/02OT5YSfpjqjdCnpXjod9dRJeK
	dBAoupb5JVnQQSXdIZ4ZPmVUu74I6S05AlP42XexUYD0KfpaS1SWTiDST8fidKpV7hQ==
X-Gm-Gg: ASbGncskpkFv+l1DS+YsYX8I+93keRW//1Z0ipiapeVPRVFMqQ+AzQxL5QVWvTTpmH/
	H9z0oVNYCvyJkUHEGaJE4kZtW1vI2piaTD78cIO6LEx2Sm0GMugbOsnA3S9/WlAJwKegZipzT0u
	gmlLun3a+ZcGxEn3muHosdvCzgVNiihZKN4KKntvqmwco1BKKAW0HcphJwX5DhQR2jniGgCXQX+
	F37THaY7I7yZtM0xDdxnf7ntOKQWGfNhEgTXfi2mHUjfEVIrgXUaMpA7II/QIAdjjT7z785gcXk
	QxUmiziZWPYf2WdSGfe9xh1/jBUaY7RhT8OnNg==
X-Received: by 2002:a17:906:4796:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-af9c645b69bmr1064763166b.13.1754909345655;
        Mon, 11 Aug 2025 03:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZCDWpvyPfHXfxgwBBapGqgujydR1xLydnPbVqezT+c6mpdCVAhjCJgUFH79mw6d7KM9b5yQ==
X-Received: by 2002:a17:906:4796:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-af9c645b69bmr1064760066b.13.1754909345163;
        Mon, 11 Aug 2025 03:49:05 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a1251sm2006600066b.30.2025.08.11.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:49:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:49:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Message-ID: <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>
In-Reply-To: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
References: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] include/linux/rv.h: remove redundant include file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <30f0e085-b636-45be-960b-68bf6a136f59@redhat.com>

2025-08-09T06:36:58Z Akhilesh Patil <akhilesh@ee.iitb.ac.in>:

> Remove redundant include <linux/types.h> to clean up the code.
> Fix this redundancy introduced by commit [1].
>
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---

Thanks for the patch!
I'm really being picky here, but, since you're touching this, isn't it cleaner to keep all includes inside ifdef CONFIG_RV ?
When CONFIG_RV is not enabled, the header only defines constants so it doesn't need other includes.

This would mean you could remove the other #include <linux/types.h>, instead, and move the #include <linux/list.h> down.

I think you can keep the Fixes: tag and make clear the reason for cleanup in the commit message.

Thanks,
Gabriele

> include/linux/rv.h | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..8b968b8ed77b 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -15,7 +15,6 @@
>
> #ifdef CONFIG_RV
> #include <linux/bitops.h>
> -#include <linux/types.h>
> #include <linux/array_size.h>
>
> /*
> --
> 2.34.1


