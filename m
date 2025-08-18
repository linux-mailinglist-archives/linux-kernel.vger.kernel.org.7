Return-Path: <linux-kernel+bounces-774613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A867B2B502
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2254D188D27F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5D2737EA;
	Mon, 18 Aug 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHaXPjCm"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B25271A71
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560707; cv=none; b=SRx30S+sci2OERDGO2HOzPidxNOujxXjdzRD8d/E6WAA0stwKCIAwAJwDB8l1ccL6fPCE4PlCunR6xk8FMnYddoMgW3NvK2XYaERVW+mp9QV16c1OU0nqfEw6DANGxAGOIXA/J6vkrwl8aOIS7kvCk3xt2lyh26J8UzaUP7m59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560707; c=relaxed/simple;
	bh=20GbQYSlKyvlXvDnnjkkcG80NKWGMOYxQbD0qXNg3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGJLCLj1ijdooFS69Zxv3g6rU80F4XqnIAsEfnU3CyxtmqVyuZbV0nTTJNnpzX8ov1Ql1WKb3v0QfKt1n6Vu9+SjGHl3il2/aJBuGGip+H42JEatMbvssfGgSlpn7PiMMwwz/AGUq92UapXJnhRtswRijNxEMW6miaJboqY0ZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHaXPjCm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e56ffccadaso49471425ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560705; x=1756165505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr/+srRnInstoyTTTLvFCgnYoosQgmYpeHv/fgPsY8Q=;
        b=lHaXPjCmWqCSTJlzeQINh6keuNXZoDwfyrV4BmVDS2OgG4FoqW5wRPsaEVUVEh/0dA
         U0DPFCZ77P6Y2cwZvz+bwFYMvApZpqmLYVhUdilEG0B/uCDJFvlXzGP8mKqO0oTf9Iwj
         ygWP+fnrs+xNkB1+lJScsKHracnMmctTB7/srQTD3Hm71P8v/SdCOaQ4PKJ7jlJ1AdUv
         1qhLt6RPk2yAaRHTy2d6buZ4EUW1vuPTGRDXUaxRTJ5qUdgTsj5m+kqhOqn/ZfXPnrNh
         qFT8S1aWmBAOWmpnVxzjGYnl6U7i/SYC1VjTPH+kzlfW+R5m7ho3SPJf6U8I7hfUk980
         EHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560705; x=1756165505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr/+srRnInstoyTTTLvFCgnYoosQgmYpeHv/fgPsY8Q=;
        b=X02u4nc5+/C4GGC8fSY1nGkxhYDzHkiWR2Ui3lmYtRp1tZtElkveOHRnMgXnDgrqn8
         kT1TILEJGgInGbabNg4G/5z/5aYTNTDRHnY3BYwxYOQAq0Oq452wf9YpAdBsvHSsNovG
         QhlFdZQkRE51lKH3Wx1NlaQTSS6pPM9X1mDg7SrO5ZC4q0eg2OrxFnk1Is4GPJEjf7d2
         bJsLDmOJJl0JUuMfDSjyG0PBRidjKPkwrqCyn9HdlFoA8MG0Hoty/wcupkO5YXtDUIZ9
         pJOo+la9RFlHFZ0SvttZ5RhfEdNImZe3rllR1rk2edjqLr67Lj4HaVlJxeEh2y94FrBJ
         BmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK7N71QYieqFZ1xazqYr/30YWD5QDJFmOMrkQoKAjqpKLtqscTLx41BP15eK1IjXkUl2WDjbPvSAFS2CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+YG8/dnMruHlk8vo2hSkZ6DT58MkWC7eSYKmgq2ipISFiAcF
	IdxQ1XxAZr5mIayiFk3V3Xm3X0nl6ZpTottXJht2VP2mQC4PD38WLX4e82W7sGSDyw==
X-Gm-Gg: ASbGncvVIY5M4z6SI5vdUeWwKv3czXAdRx4JpWtT9lDj7cusQDl4e4y/++2IGyy+RI5
	HnZUKWMw8Ytb9VYSrXKNor6Vz5OHs3T0VGgkFQg+Oivgfrt8IU+j/GV/BIVhWDsKe3o421xUMHW
	UeTsZJzlWU/m4yMNMqOqMTJOEVmqTevII3ZBvmDUA8oAX6UHQY0HrxrG23J5jGeO8rqndf/OAwy
	TD/nKslooWFh7UKC6Lu/iw63pdVO1VSGfAAfQCbG0rGzr3U+Y2hz8wTug+2YQYqZ4bUOa3H0pqu
	Nm04hC3vfsd76MVf5rVVaF6se+CbbBGrPZTo/2Ub5eoB0nMdcNK2+DzH1Hb9XDWpD/T+YbhyYq6
	uJWfJ7gtsR5EuuggyyWjqL0jcJvBtebDPtXqKQeZ3ag7t+e9fSz6xTdV+azRObxY=
X-Google-Smtp-Source: AGHT+IFgrO8Ncrqq+4A/cmmyJGbffL5WUyP9hfiMe85kNg5r66Z0zlRCako1lOTHiPISU60//YjCvw==
X-Received: by 2002:a05:6e02:2782:b0:3e5:4da2:93ad with SMTP id e9e14a558f8ab-3e676639feemr10482265ab.11.1755560704218;
        Mon, 18 Aug 2025 16:45:04 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c57dsm38431015ab.4.2025.08.18.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:45:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:45:01 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] MIPS: sni: Replace deprecated strcpy() in
 sni_console_setup()
Message-ID: <2xo5aonnmv5wfyomeh3ju6x4m2x3akr2kcjwx3c25fxwgdgczm@v6m5gtp3apsf>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-3-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:13PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/mips/sni/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
> index 03cb69937258..fc7da12284f5 100644
> --- a/arch/mips/sni/setup.c
> +++ b/arch/mips/sni/setup.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
> +#include <linux/string.h>

This include isn't strictly necessary but I suppose it makes the
dependency explicit.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  
>  #ifdef CONFIG_FW_ARC
>  #include <asm/fw/arc/types.h>
> @@ -80,7 +81,7 @@ static void __init sni_console_setup(void)
>  			break;
>  		}
>  		if (baud)
> -			strcpy(options, baud);
> +			strscpy(options, baud);
>  		if (strncmp(cdev, "tty552", 6) == 0)
>  			add_preferred_console("ttyS", port,
>  					      baud ? options : NULL);
> -- 
> 2.50.1
> 
>

Thanks
Justin

