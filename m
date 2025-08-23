Return-Path: <linux-kernel+bounces-782859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A04B32620
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D704DA04835
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E6188596;
	Sat, 23 Aug 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcRogaia"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF41C68F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911601; cv=none; b=pKhwc8y6JRv7WbzlVolHQ7hsjB+Imm+9O3kfEF2/hiHwnHsEuso0+RBd1qD5TJpYT77y943164J/8L9KClPRAO04o5u9mJM4lSl381MjMmQYnPPKJxRTkipDTk0+PVy4aNS7Q31FxWinoq2/TaZVe1nwjEIUBPNFmLm6F5pBEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911601; c=relaxed/simple;
	bh=ciPiSBTwsteXUC8doN1n+P6C5tmIpwhAebQrT3ejA4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX/aSzAXKH0Am7hgM5maiKKr/27KWZdIxdoUc9MYChctE1D8/ZIZVgFSf9MBoYjNDd3VhUBAe5sU5cqzOnWcL4AXL17soFQapfFA71eIFLeQFmY0j+WvdIAZrC41hL/hPn9nkZhawm7z5b9+wyHg2mqmJwDEAwPGkSWz3qAdlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcRogaia; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso2122515a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911599; x=1756516399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQrWupHIhZiBrC7vPvIXiCCLepxxuc4JOY57pG7WfoA=;
        b=QcRogaiaKW75IQTjskyILsQrtc9RK70kWDuSClxw0pwGJDdztj2cXgKwJDspNrd5w/
         v1dbrR+cfEr0dbxXSnf6Xn9bMGnvYkguBoexIDDnjqTmjmWeC7CqTuOpYJgI4pqui6gs
         6QOCTVrf5pqqnvJbQEdDdjzncRykKoggQxYfAAkDDepSum/cpao/TQ4mGtASalsoRTDO
         +ByOaLzvREpRnsxxtur3m6kFecH8IkDUDCxD901K46VwdY7jUJOm1V9GbqMMJv2GK3be
         W5fN+eBd32W8xBQpUfKH4ab9Kpy8PkHPCcuqrjPmKQ0lKIp2WpBl1wdsylK4Nzx2BCsZ
         aA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911599; x=1756516399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQrWupHIhZiBrC7vPvIXiCCLepxxuc4JOY57pG7WfoA=;
        b=Vxjl43Cxh60ghPvcS2DVlQIvjR6QBcWix6dd8FrbY7WutEqXwA9CpM3z8tGm03B0K5
         5DqRVTz0+O9+tO2jOWHwaDqSE64fQ0o8fVX5k2O/J4M2JaPhtdkGevgk8rCyE9ZQKl3W
         8zvUgRvZKH2dKnM6ufDw+dI7jMxUQxOAp1dgP2RzN/oW/eI/xrfMPSWX1SVoMC48LqM5
         JJQywEYsu0PrV+P4FgB/0VsvRUoqPePfGM11BcO3OT7oVNTelxkJ4jBmZdHbENHx+lh/
         V/xPg/tnN51/LUCP6J8rz3WApR2sAytO6WAzWrg7RPe2ms+LZu/rNfw1vhyBUctPgBOJ
         RLvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8oHnAW5F1tDhwHi3IYCL0XQXZ3LLLVPkTBVd038soRE47UakxxZUlrXy0y0fNkxBF9TrOOX0Z91TR6as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2wOkYPcgR+48eheotQZcREIZMfkgYUjQ3VmX5ERJ5IW+FFJ+
	Z1ate1JS0J1MGoIVHFEGElk8PhWzdK0P0FOAYEprSya3N26kOd7jYmGO
X-Gm-Gg: ASbGncuZMSNUo2d+lOqEE5TbLh6/2CSmZzOUhRhZXOQaP/WM0Yr5Ps09MrtZI7o3njV
	4iWqh+P/5n2KaNVtstAS05RfQEWFYe30AnWT/P+wo9nHmyrbwzzx3LMOJSN6dGeFNmKLy3U6mvU
	3RKZlSXmx3aMjevclxAn3wbcgc6Qr9csSs2pKH1fvJdkDE4n707S0DLSD8pQJuW72MKM/jxxWM0
	/M/zk0I6dLTuqmW3QkBXwaVZ1HA+tWRnmiMmTC7vwQp3cEeo3z/0RFQlCmzpvH4VRHwj8Ar2D1E
	LA/Xjwhc2yhytEiP4pEQpGRx/wNvmn9StgJdUdFl9in6wdVMzShHaRh4azt3nsIXsWT4jTONuX4
	KR9DaNwdFhBJ6QiTrvOiKjIN7B+LYSQQAI8s=
X-Google-Smtp-Source: AGHT+IEbUyJYViHgEeQBQ0SdF3qeOozb/if/f4vOqfR0cciYjQ0K0dkP+huwbU4l5wSAj1hLqWitNw==
X-Received: by 2002:a17:90b:3b8d:b0:31f:30a6:56ff with SMTP id 98e67ed59e1d1-3251744d025mr7135837a91.19.1755911598976;
        Fri, 22 Aug 2025 18:13:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa63db2sm995862a91.23.2025.08.22.18.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:13:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:13:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 1/6] genirq/test: Select IRQ_DOMAIN
Message-ID: <706bfd19-b9b6-4f9f-8c25-21110cee69b9@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-2-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:02AM -0700, Brian Norris wrote:
> These tests use irq_domain_alloc_descs() and so require
> CONFIG_IRQ_DOMAIN.
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v1)
> 
>  kernel/irq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 1da5e9d9da71..08088b8e95ae 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
>  	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>  	depends on KUNIT=y
>  	default KUNIT_ALL_TESTS
> +	select IRQ_DOMAIN
>  	imply SMP
>  	help
>  	  This option enables KUnit tests for the IRQ subsystem API. These are
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

