Return-Path: <linux-kernel+bounces-782862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EEB32623
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F05D5C6F31
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06218DF8D;
	Sat, 23 Aug 2025 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJr6keXS"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC784191F92
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911628; cv=none; b=RHpZtAZ4BBGHdPT8wz1E3FV6i/Eq/ZJNFp6wGQlbqAG9QykQNd+HVgIHU+OFy2/jyrm/v+8HYr6eDWL0Sw1rrfQWFw+ukxW+CeXsGKGOWesMqR9qsSGGhl36P8dHB7mPfej0VbuuUyqY6f8etRofqJmZAIPxmnA9stBRoEhGVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911628; c=relaxed/simple;
	bh=68nutoI68EuXlE+sug4SqiafnF/QVwUOmzJeODa6aXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu5LJDIpMn/TXHa2jbYf00aw0IvPYz9ZegBP7oNbUL/u61MR6eik3ysjcHcjwrDxXxovQw4GVyKA/qKwpxA8IKJ7HRZ7XshwQKrnWsuPTLCJ8ueTsrr9r5yYyzYoALL5iI0QNLy590taX6NIlcvTHMrMVLjctN9GUnz0ehJMPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJr6keXS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b49cf1d4f6fso68796a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911626; x=1756516426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVtJ3Wuoru70wouQIB2YUT2TbNuJRW/ONsipDplqLho=;
        b=kJr6keXSzzVSuyKWgpjtjlc7b6vIJFaYibK3GIw33cCWiaFsDwJCSCFz/Vpoftbrze
         PtADTf2CNRrVbk2jTfHE/ozAHRkdW+qpzZLRqJcYxq4D2l06QFEDzKu95Lgd+VofOoku
         bC3wtsgh7/MY5G0pqOkibzkCEuq06yT6T+/V9QQPaLeP6FWAd0k+WRH+VlXmnWkGaj7z
         mXQFJ4ijWmyvqgMzvpy4DqU2Lw7qvPrssp4VSq7aijOldfg5jTjqEXuFdhOX1Rka7vga
         bpb+G9PMkzsuyKeHSpKPKBbyDw5vt9QnQPrDyJGT2Br9m88dhxO6/olHjjVP0+/uIUiv
         5+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911626; x=1756516426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVtJ3Wuoru70wouQIB2YUT2TbNuJRW/ONsipDplqLho=;
        b=SZ9dwa9vGZq8xZNNz+esVyM48pQQUowKvHytU4SCOYrbzNl3kkFzwwhBQA4tzWAbxK
         EO58Em4iCWTffqHaV9XTBj6/JnNxAbkRu9mQY10PaMrKqd0hK1xV2gq66FkAEcmWZM30
         ZjLXJUbtfGeuFokYjrEMjIcB0jhg+eg8LLD8LFaPRbh+I7Eavzlk34zvrjPafSvqb50Y
         vUBAkcvrHnkRdYI49ldNfqD6juMgv5ni0tlKiFKi27Bk7VFDjXN8BvLuwtBk2DIJxYvn
         2Ce91Xz9okzkru7rocIS08drrHjK01dmhXoCc8AF6l7kdr4a95XySqQSGuh8PlVwsd/f
         jkEA==
X-Forwarded-Encrypted: i=1; AJvYcCXVN7NoDtoIdTosCHP536OniPb7chl/e+9r5i4M5/HfQ9e2wVPSkuXug+U9AzAjYgqj04Y9MdY38GEB/lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhL3ABdZyd4Njx8zkqLLLmx1JjWxo8BVIEA3eMuKMBen9DtZ/
	raAcliAXa0tcLppyOVgOKW37YJDbCb01/bKjQH+le22LrV0VtUS04eLp
X-Gm-Gg: ASbGncuCN8esg7QzkXmsHSNu7jAX3eymXWKDwcxSiglbTH40svwymhtMKbxAtnwYm0C
	tVsRKQWI5E+YqGgjmBG3DyZo7L9xT5gNAM0GyFw0qJOgrMvGgIA6P+Lw6sqSkH/7n5CTORHNzUl
	lHujac8oi8Jt1SUXxDIzGRYKuiB+P/+Pfos+mpchU8mcXImCY07jXYor9XYbTM++NeHJ/Pdjrfh
	1C+Mm39G6TMs3t4giZmpkSmB7vnh0h23gcCTFeVpH+6qx8lR8hpWK5RnBLha6GLjNxysNA+usIR
	es4WDWy33reVKie8mxxIWXPoZZyJqZvhe1BdhqrRU2XP8PahYRTCtxNUzSsv6OQMQqv5832b7bG
	yhC/9e96pE2aXiVAsqwH6CkdNTQww7NMY5J/JgybS0aANrA==
X-Google-Smtp-Source: AGHT+IE+2pp0uW0H5gmVQzJ09mt6IBpz3GDp8SYPV/g7IbkpGMRv1op7WJ5Jp2X3u0P35pVtdbCCWw==
X-Received: by 2002:a17:903:38c4:b0:240:5bde:532d with SMTP id d9443c01a7336-2462ef4c8eemr62481685ad.38.1755911625886;
        Fri, 22 Aug 2025 18:13:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467d4030fesm722255ad.137.2025.08.22.18.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:13:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:13:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
Message-ID: <613a8f3a-826a-4a59-b90d-76cd50093d66@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-5-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-5-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:05AM -0700, Brian Norris wrote:
> Some architectures have a rather static IRQ layout, with a limited
> NR_IRQS. Without SPARSE_IRQ, we may not be able to allocate any new fake
> IRQs, and the test will fail. (This occurs on ARCH=m68k, for example.)
> 
> Additionally, managed-affinity is only supported with
> CONFIG_SPARSE_IRQ=y, so irq_shutdown_depth_test() and
> irq_cpuhotplug_test() would fail without it.
> 
> Add a 'SPARSE_IRQ' dependency to avoid these problems.
> 
> Many architectures 'select SPARSE_IRQ', so this is easy to miss.
> 
> Notably, this also excludes ARCH=um from running any of these tests,
> even though some of them might work.
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v2:
>  * Make all tests depend on SPARSE_IRQ, not just a few (resolves
>    ARCH=m68k issues)
> 
>  kernel/irq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 08088b8e95ae..a75df2bb9db6 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -147,6 +147,7 @@ config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>  config IRQ_KUNIT_TEST
>  	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>  	depends on KUNIT=y
> +	depends on SPARSE_IRQ
>  	default KUNIT_ALL_TESTS
>  	select IRQ_DOMAIN
>  	imply SMP
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

