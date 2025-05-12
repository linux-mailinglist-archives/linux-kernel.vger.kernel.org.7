Return-Path: <linux-kernel+bounces-644267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBCFAB39AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65E118969ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C61D5ACF;
	Mon, 12 May 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evupK3vl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1271C3BF1
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057866; cv=none; b=Bbpt0Ip+k7t+L51/RWbwxC1E5u2Q3A1t9H3hrmJQBHLeBIEcqKxPX3vCJAzuZMyrhGv7nfkWBKwVHzQ927Vtu2DEDNJA+hc/KiHS16xpd9JVOWaUD2dmIBWVzyu5QWHtw3UlCiN9S/JvAQgToErgBw//RkkT81yVCYm1BA8Vvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057866; c=relaxed/simple;
	bh=M0qY9xASQl3sMPmGY+Z6Jq1lZYzU4PUno3mTkxevcas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBBo2G64Eb+buE+xr09MgIjlbM4tMjIdsrZDm75iN5i1t9UbJh7/oa9Ml2hxIwk9Djm4OGpeW1UCS5NDoqjoLgofytBCt+dAvCj4BZ6D2SxcZUjFHZDI1OgO3dVBU3UfGN63XRQI7b3SlQxV1kRUB2Enuk6Qvjy+HAJGIx/3jTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evupK3vl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad243b49ef1so349469066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747057862; x=1747662662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29eGmWMi3cXBalMuLxzLgCqk70S1I8r77vQCVbCu3NQ=;
        b=evupK3vl1fns5KUna4K5mk8+Eb3mLhey9y9dRy1lpEo1v9bkr8CTx0DyIkHpyAFyus
         ubl3Ys2BorahMQZGUSzoXDVxGeFyfFBqSSRx+FO4F3ufEf5AawSaEv/CDmFKq92+o4gJ
         ZUHjKlO7zLkWavduVoItnmPwT4Mih7yUiKXnRvvwdOf9YksBSRe7JUzN/W9lXVff41ES
         PdTK+JzArJej9NWe7GAM/dgbC81R9Ly9BCYe0Icq3Tf3N35u8YUTh14lPT+q2pw6c1OV
         H7+cIhhBs1ayr38oW7jguk0lBFePCKrtRRvg9JjcUIoE8NPnJKXmYZ7jPoY2PdC8fEu+
         0u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747057862; x=1747662662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29eGmWMi3cXBalMuLxzLgCqk70S1I8r77vQCVbCu3NQ=;
        b=kWLyFmemlLnUpZKHpKEpHeoIlb9EQ+jroyn06ryBHu8Gu7KeozCemsM3KPpWPARoY1
         1i0TsqpiEvEROLEUV4YpTayE6GMk/O4ogt/LDr06KH3jNVvNrqNxd6T6aB04RrWNWERn
         eHcc22bBcfFkqA610Z+4jg8zUF+osMITuOT44Ee0o6I/l2XSG+eKBwoBLBNlQQ/jU0Xx
         zSksEsiCQBWt5SeqWe/jYuYf4rEZiBWIGzJJK8uecZK5PAlB6AdUCWOWhnvULRc103/D
         OhptZGIp1CIrzbwBd+bV6PIVGDTfGR9WpUEewXxboZqLjttv3KHokC739uW4QpiNzB+X
         W3OA==
X-Gm-Message-State: AOJu0YxaqcK36ggZqCsbEWwMa4p8oNog6tTQ6YbMAZ22AWLDUg2LCbwb
	urb+EGeb2sIvnqi4oztXrBGWZ6W64xuilfy6T72XBb9s5zuYeh+S3g7t3hz4LKY=
X-Gm-Gg: ASbGncsrQQKsKQa07ANknx53K05JbDxWaeA7Nkt1x+5WBRy1PvEsqt0tDyFYMUTRJRI
	iCzWM0S0AMDpz3Bck/L5ksvBX5qYztIKrJyAXA9pmSAP+u16ONuJvBNLoxizCuzbqTVjnrxIxy4
	6gIuxwOpp3CPtq8WHTG7h43BBCyWY7Va25oP0lRKvBdAgzVVjSh/jVbhPL+rrFSC6F3l8Q77aLn
	51ckjcXaMZDDxA3ZJcs2JcYoUChFNWOP6+2ud5sCIzdHIyvzGppO+NwbTnE/v3EcNqUPXisNtvL
	ZE0R23ofcRdqNxGYuwqd7Kl84GJof5r3BvgOGXHi+gg9jXgRk3elVA==
X-Google-Smtp-Source: AGHT+IGxQPj5ISBYHxqt+HceKg1I62fXSPEHJam9X16oVLfXwLKnJ68H26ifn/2iMofAcnp7vupTZg==
X-Received: by 2002:a17:907:2da1:b0:ad2:3f21:a092 with SMTP id a640c23a62f3a-ad23f21b4f2mr801324866b.56.1747057861905;
        Mon, 12 May 2025 06:51:01 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197466adsm624739166b.92.2025.05.12.06.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:51:01 -0700 (PDT)
Message-ID: <84e82d74-312f-4c6c-b197-b44e59e9470c@suse.com>
Date: Mon, 12 May 2025 15:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: Add support for static keys
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org
References: <20250510210126.4032840-1-kent.overstreet@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250510210126.4032840-1-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/25 23:01, Kent Overstreet wrote:
> Static keys can now be a module parameter, e.g.
> 
> module_param_named(foo, foo.key, static_key_t, 0644)
> 
> bcachefs is now using this.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: linux-modules@vger.kernel.org

Please Cc also the "STATIC BRANCH/CALL" folks on the next version.

> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/jump_label.h  |  2 ++
>  include/linux/moduleparam.h |  6 ++++++
>  kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index fdb79dd1ebd8..0fc9b71db56f 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -107,6 +107,8 @@ struct static_key {
>  #endif	/* CONFIG_JUMP_LABEL */
>  };
>  
> +typedef struct static_key static_key_t;
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #ifdef CONFIG_JUMP_LABEL
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index bfb85fd13e1f..2494e7e67453 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h

The module_param() macro in this file has a kernel-doc that describes
all currently supported standard types:

 * Standard types are:
 *	byte, hexint, short, ushort, int, uint, long, ulong
 *	charp: a character pointer
 *	bool: a bool, values 0/1, y/n, Y/N.
 *	invbool: the above, only sense-reversed (N = true).

The static_key_t should be added to this list.

> @@ -488,6 +488,12 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
>  #define param_get_bint param_get_int
>  #define param_check_bint param_check_int
>  
> +/* A static key, which can only be set like a bool */
> +extern const struct kernel_param_ops param_ops_static_key_t;
> +extern int param_set_static_key_t(const char *val, const struct kernel_param *kp);
> +extern int param_get_static_key_t(char *buffer, const struct kernel_param *kp);
> +#define param_check_static_key_t(name, p) __param_check(name, p, struct static_key)
> +
>  /**
>   * module_param_array - a parameter which is an array of some type
>   * @name: the name of the array variable
> diff --git a/kernel/params.c b/kernel/params.c
> index 2509f216c9f3..991f49e138e7 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -14,6 +14,7 @@
>  #include <linux/overflow.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
> +#include <linux/static_key.h>
>  #include <linux/string.h>
>  
>  #ifdef CONFIG_SYSFS
> @@ -412,6 +413,40 @@ const struct kernel_param_ops param_ops_bint = {
>  };
>  EXPORT_SYMBOL(param_ops_bint);
>  
> +int param_set_static_key_t(const char *val, const struct kernel_param *kp)
> +{
> +	/* Match bool exactly, by re-using it. */
> +	struct kernel_param boolkp = *kp;
> +	bool v;
> +	int ret;
> +
> +	boolkp.arg = &v;
> +
> +	ret = param_set_bool(val, &boolkp);
> +	if (ret)
> +		return ret;
> +	if (v)
> +		static_key_enable(kp->arg);
> +	else
> +		static_key_disable(kp->arg);
> +	return 0;
> +}
> +EXPORT_SYMBOL(param_set_static_key_t);
> +
> +int param_get_static_key_t(char *buffer, const struct kernel_param *kp)
> +{
> +	struct static_key *key = kp->arg;
> +	return sprintf(buffer, "%c\n", static_key_enabled(key) ? 'N' : 'Y');

The 'N'/'Y' values are the other way around.

> +}
> +EXPORT_SYMBOL(param_get_static_key_t);
> +
> +const struct kernel_param_ops param_ops_static_key_t = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = param_set_static_key_t,
> +	.get = param_get_static_key_t,
> +};
> +EXPORT_SYMBOL(param_ops_static_key_t);
> +
>  /* We break the rule and mangle the string. */
>  static int param_array(struct module *mod,
>  		       const char *name,

-- 
Thanks
Petr

