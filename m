Return-Path: <linux-kernel+bounces-847896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A273BCBF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50A1A63AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D45C246796;
	Fri, 10 Oct 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AwDD6hrl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF141EDA02
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082327; cv=none; b=hbKwmNFW17YN7lYArHsNP4U2bOjxlrEjohxDfQcOIi9CUSZJBDYUgCyUmDIe+Z3v1OzClI8wXTRyCLHo0/YpDdXrGnpRkpcAU+9aJ+69RGnPenouySs9cPKg0lSQt8gvMDuPVjk3j4hMB4V5MjeAfAFmIJo3tD4LA9Zaika5Zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082327; c=relaxed/simple;
	bh=hBEF0FWAokM9P0rqGsUh11kjOyb0zIwpQozrxsQMsAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9GI9vZ31CSQAOR6LycI9gkLY/wJzAXeMfi8Ye4FevlqmYtf5CLLneFHCey7qym+/65x6Rzst0jB0XgYcBJpwMHz0KZnRjXmNL8ObSkqJ/H9sgCxEjjV0UPkiVH1jYS20ZkfYhKTUpFQKTMiQSI8KxkfSNHZCOK6t5z+niHYg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AwDD6hrl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46f9d1b186dso1741315e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760082323; x=1760687123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLjqJv+QyyPTLNsZ8zbHcbBclNkfPTr01qnu368qCwE=;
        b=AwDD6hrlbyU3vFxg91S+cpO8lrTlI2V0lVojJi9atJYLbZ5BmqkDCUUPzxDy3og0Ki
         Nhy6WvMqSWB+Q1huFGZmMkHK8DHc0PfnzLsqndPXp74QWps9JGB6YfryYEEyOkvcIamD
         rZac0CPLnUnEvEBCdb6xG0KfKhy361meEZBaloKmVMkfhlgNO2v79e1RQ36vdAHD9TIk
         bUgZbPBSdhTvKu9jRLDnROWG/+sdY7J707uz9bP5Lvmd8NyKf6BofRgGAfm75cvJfusQ
         l/euJpVeF+W+zpz8wdtX+7GjK5rjlY8TinnRY+FLPOTjLL5mQg87v5+/0aGR514rvZ3h
         SQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082323; x=1760687123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLjqJv+QyyPTLNsZ8zbHcbBclNkfPTr01qnu368qCwE=;
        b=QiVF21LCSRfHqZsW4tPu98IPdLnv7Xv4rqG9aErmO880ovrUbx+FJGqZZBtwUIP9YW
         uugUDMqmqQzVTZkAsFYmjlf2gT7AgKLWj2Vmc6dVrdUrS3bmMfqyE5v9bam22h6hGFzX
         2g5CUQrviBVAzhMVM8O1FLGMtvvIAYVbL1NNhS92p1RHPQGmnfXQN004bXuPICRByvU6
         w4YZJ5xd3N7sRcmyEaPsRANpW3Y6GAD9uCqugMuiwrt6yZP7Ea6deXXlv2YPY71gYMTt
         3j0++fHRkiWUGVhKVyd3NUuAvaC8Vh+Kr4sLSfoYN918Dl0FiNyy7t1gJUwsfnsa5ZXb
         IYdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQzKgtdIHe9CDOHEGyXzP3kL0cZy+fIX3LNNmFFrWaoMaI3FqoHSTL+rUdKc5X37hULU/llKpLmiwgLPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2/WdwLtGx0vS9m7wYcfoGlZCmoQnKCKou+tiJhEhi0HdIYZ5
	TO77s5V1onVprK8ID8PjuGrQBH2ZAopHdJM1HJ8pRzx3ikgB+8LRVdpOBVDXkuEyrSE=
X-Gm-Gg: ASbGnctx0k+o4oFYIA+j9AC3DerXcouEKQ+PJZd3acOcGBAnjiFMdGiFhDSjo8L8yer
	3gG5lbIxyBCU0LMicTEcNdwLyRuAAxGNCdW3maGLrETuF6ECsstn5rKL5FrQ3x1L7ZCPj4dXBWS
	In5XLYMp2zgK2o0hDmHdXSINdS5oKRPeock9q5njkftFcu7WoPzr+Fj+eP6T7oqj1E1y3xmpK9J
	PblD42/dVE0ceDVaJE4Pa9TVOZg+JM9mBKSRe4z8ibrBjmMTd/XrWLNpAN3E0re9fs0ezTudRwN
	SLVHnD1/AkSZ+FiabUtJlFYRvx5ZeGLT5tRg9nnFZ/r3YyJdRj9gqBrVZRh7Iw3IdzYdYqENu/l
	9HEwCE/swPz0net+e3sVAP0i9fKizO89/yB6n+aE16iHmL2n8wtvBgihdyY0J5ZW7ELx2lBuJfq
	mwAXY9kpqfmZHLnAyF2Ev1a4c9m5P/xznBR3TS1mYk8SLG/0jrp67Mz0nF/A==
X-Google-Smtp-Source: AGHT+IFMVCmi3Q47jOI3pU6H/HdR1VM1sN75fjQ8Cr4d6PGLmkE2TxUhWmcNN+FrONdh6OiSevcSUA==
X-Received: by 2002:a05:600c:3b11:b0:46e:6042:4671 with SMTP id 5b1f17b1804b1-46fa9b19fcamr36344475e9.8.1760082322863;
        Fri, 10 Oct 2025 00:45:22 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm2911255f8f.23.2025.10.10.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:45:22 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:45:19 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter
 with early_param()
Message-ID: <20251010094519.3d845993@mordecai.tesarici.cz>
In-Reply-To: <20251010003345.dc6ybdhwoslyse5m@desk>
References: <cover.1758906115.git.ptesarik@suse.com>
	<63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
	<20251009185134.fb4evjrk76rwxv37@desk>
	<20251010003345.dc6ybdhwoslyse5m@desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 17:33:45 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Oct 09, 2025 at 11:51:40AM -0700, Pawan Gupta wrote:
> > On Fri, Sep 26, 2025 at 08:01:02PM +0200, Petr Tesarik wrote:  
> > > Use early_param() to get the value of the tsx= command line parameter.
> > > Although cmdline_find_option() works fine, the option is later reported
> > > as unknown and passed to user space. The latter is not a real issue, but
> > > the former is confusing and makes people wonder if the tsx= parameter had
> > > any effect and double-check for typos unnecessarily.  
> 
> If this is too much of an annoyance, I would suggest to move
> x86_get_tsx_auto_mode() from tsx_parse_cmdline() to tsx_init().
> 
> ---
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index 167dfd38b87a..805be8beb37a 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -20,6 +20,7 @@
>  #define pr_fmt(fmt) "tsx: " fmt
>  
>  enum tsx_ctrl_states {
> +	TSX_CTRL_AUTO,
>  	TSX_CTRL_ENABLE,
>  	TSX_CTRL_DISABLE,
>  	TSX_CTRL_RTM_ALWAYS_ABORT,
> @@ -27,7 +28,8 @@ enum tsx_ctrl_states {
>  };
>  
>  static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> -	TSX_CTRL_NOT_SUPPORTED;
> +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
> +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;

I like this approach, because it converts runtime initialization code
to a build-time initializer, based on build-time config options.

Can I add your Signed-off-by: for a v3?

Petr T



>  static void tsx_disable(void)
>  {
> @@ -164,11 +166,28 @@ static void tsx_dev_mode_disable(void)
>  	}
>  }
>  
> -void __init tsx_init(void)
> +static int __init tsx_parse_cmdline(char *str)
>  {
> -	char arg[5] = {};
> -	int ret;
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "on")) {
> +		tsx_ctrl_state = TSX_CTRL_ENABLE;
> +	} else if (!strcmp(str, "off")) {
> +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> +	} else if (!strcmp(str, "auto")) {
> +		tsx_ctrl_state = TSX_CTRL_AUTO;
> +	} else {
> +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> +		pr_err("invalid option, defaulting to off\n");
> +	}
> +
> +	return 0;
> +}
> +early_param("tsx", tsx_parse_cmdline);
>  
> +void __init tsx_init(void)
> +{
>  	tsx_dev_mode_disable();
>  
>  	/*
> @@ -202,27 +221,8 @@ void __init tsx_init(void)
>  		return;
>  	}
>  
> -	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
> -	if (ret >= 0) {
> -		if (!strcmp(arg, "on")) {
> -			tsx_ctrl_state = TSX_CTRL_ENABLE;
> -		} else if (!strcmp(arg, "off")) {
> -			tsx_ctrl_state = TSX_CTRL_DISABLE;
> -		} else if (!strcmp(arg, "auto")) {
> -			tsx_ctrl_state = x86_get_tsx_auto_mode();
> -		} else {
> -			tsx_ctrl_state = TSX_CTRL_DISABLE;
> -			pr_err("invalid option, defaulting to off\n");
> -		}
> -	} else {
> -		/* tsx= not provided */
> -		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
> -			tsx_ctrl_state = x86_get_tsx_auto_mode();
> -		else if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF))
> -			tsx_ctrl_state = TSX_CTRL_DISABLE;
> -		else
> -			tsx_ctrl_state = TSX_CTRL_ENABLE;
> -	}
> +	if (tsx_ctrl_state == TSX_CTRL_AUTO)
> +		tsx_ctrl_state = x86_get_tsx_auto_mode();
>  
>  	if (tsx_ctrl_state == TSX_CTRL_DISABLE) {
>  		tsx_disable();


