Return-Path: <linux-kernel+bounces-857999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229ABE8834
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9566D1AA3CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D172DC78A;
	Fri, 17 Oct 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8WEISlI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FD332EAC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702701; cv=none; b=EyF9yerVwKU8Teao4BY7xN+6nkkavxnibVpml/+qM2oKfKFpv8GPxxovz5K8mWRJKPwAJuhahSyr6Rr9noGry9IUTjIXpXWvrBCAXKK7Ih5D2Nf8290i4mnZL2QJ2YMC+xkWK0ULRXzsZ4Z8V0hy7AOA/4VtTnbPrO2z+bs3Puc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702701; c=relaxed/simple;
	bh=zxJeEPERBSwecyf1Dj4zrIfVzfgAX3Kmnnlh4mTeqXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=VwPUhFF7A5FOxW6DHlsjPwMsxtg/RoDyykQ+QaAdxKsNoGVF27ykc9YBQ9kyrMPY1DU2KGOZQLACxyMYEOiYYQAUXp/xxHK94wN8fNgzvU73Y22HSHhZoyMIYwoCizMRy7VP+K6xn0x7UNI4OssHo85Xm8uIdrurUoW2axCP7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A8WEISlI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so16979295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760702698; x=1761307498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZTjBl4diZiotg4HGvoRg3VptpOxC83MZHMSgyQDmPQ=;
        b=A8WEISlIbovZ6tG8QMcFTY4U2hkQ1301H8qJQMZbP2/xznDwFs390/usER8/CssPB1
         u9dp/KKeii5YwSA+Kf4bk/kod1P1zIxDB43Ja8n6cSUiyI+fghy4uOculPVXqU/WO1Hm
         /wtlzSua/wYGBj11q+RZmGESl7Bf3ilEZdY0tE5w0WI0JToOCIz9fITp7lFAKQ5hFoGG
         jbd57O2Zqva0Dp4M1FxJN4ymLhCisGENxyF0rR2hzgCfge2YabgN8MaWHTUWe5tRcJ3k
         ALddsU/O+hI7DW/VX62uC1Qm09P92KxPYh4WA5W4V4Z6bz9iGuMP1/1owRzWVN4QD7X6
         CU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702698; x=1761307498;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZTjBl4diZiotg4HGvoRg3VptpOxC83MZHMSgyQDmPQ=;
        b=XcHYT3GR7Vk5I9DoIoqo95CUwBTUBpUPsyKv2QLpqndop80N/11+3KnWhjmg5M/OV6
         Lzrsb7WcfsSFXWmwg5YSJaonY09QnLutWUrrsUR7UZsEjpdXA+BjRYsgAVdHp3H+q6e3
         BhlkPLAz8rKatEXFAyOveBWDbtO4EtscGuls3KUgji1Fbp+mvXoocby4JTdnSQ8AJeqj
         PH7pt3Q+c8WOMcNQJDSmnCd+8SexIXMQwZNr3yDEOmhmiqC0pQlDVSWhwCUKuXozpvXQ
         pSDsAdWdQypcMdq1Twmd1ddELdRrHjmtE2aQ0yTb7t31opEpF80RrP+0kLTMMM0cTb7D
         JpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUELxo6IjW4MA6VBkpbLwMZZEPQR4JQ7oVHAP14/523WzfI5/dfIQ7BxfUhNioRJPG1t3aqxnUckY4DZLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvSfXNo2mGWxoDqggIIucW6lMSwVcd+mcGX80791hNgsD/tPD
	alQG5gWVqTXgZs+NpvF0uDAt1sjXb6vTjPpW1ZHat/uqUXeEX46i1m1uH0Cgr4U+9PB+yXvSfAq
	Cif88
X-Gm-Gg: ASbGncuSqSyOf9CeBDkPTXHm1rL8UIY1jIpjcpFbZshHOsaFjRfS9zY9PXMDXKEjJdO
	GxheIa8e3ZkKS2ANJ34F1Wbdy88MdCcr1VuY9AqhmDMJr7yfUfU4AFQS3ePVXsWBbESA3V9+quh
	DbS6/1niNIpdrnXqIv/I26ylehC5jzhE6pe9pW1rRHGnEV/axy/aIrKnJwpGVa67sModAFsVcSh
	/WkDXuBTa3ai4aYFL9EMOutJ/LmqIKc7P3ELrBa4MIYGogPuBUjgdesINpPx5buAqnKWFqtGiOI
	z/oC4CXRD6HIdd+XRd7gV3ybqFY+shF8i1JyeAsd6mIA5f8m1Cyl3JBF57Nd1tEL009Vv/wvfzn
	+HVEhsJlLdehwGb1VloV4N9ImrBm7BszwxhUvBP6Hktb3gipSQqTEDMlP2yNlmrsj0nuFv7VnfJ
	UPRpyxznBgqV1WBo4R3Bmhw7hGgPKrxBw=
X-Google-Smtp-Source: AGHT+IE1Fi7czH22W1V/P5wbD0Ci5V+g/0c5ggrDBbguznUJ3ayVv+bCUogPL7mV/v2uhjxPJ6rRbQ==
X-Received: by 2002:a05:600c:8a16:10b0:46e:24a4:c247 with SMTP id 5b1f17b1804b1-471099254f6mr46174395e9.5.1760702698035;
        Fri, 17 Oct 2025 05:04:58 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47121ed98e9sm4493705e9.3.2025.10.17.05.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 05:04:57 -0700 (PDT)
Message-ID: <01ef4392-cfd4-4cf6-8af2-153b9e333d44@suse.com>
Date: Fri, 17 Oct 2025 14:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
To: Lucas De Marchi <lucas.demarchi@intel.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Language: en-US
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 6:26 PM, Lucas De Marchi wrote:
> The -EEXIST errno is reserved by the module loading functionality. When
> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
> module is already loaded in the kernel. If module_init() returns it,
> that is not true anymore.
> 
> Add a warning and override the return code to workaround modules
> currently returning the wrong code. It's expected that they eventually
> migrate to a better suited error.
> 
> Closes: https://lore.kernel.org/all/aKLzsAX14ybEjHfJ@orbyte.nwl.cc/
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  kernel/module/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362..74ff87b13c517 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>  	if (mod->init != NULL)
>  		ret = do_one_initcall(mod->init);
>  	if (ret < 0) {
> +		if (ret == -EEXIST) {
> +			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
> +				mod->name);
> +			ret = -EBUSY;
> +		}
>  		goto fail_free_freeinit;
>  	}
>  	if (ret > 0) {
> 

I assume you intentionally omitted the "(reserved for loaded modules)"
part from my previous suggestion [1] to keep the error message short.

Looks ok to me then.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

[1] https://lore.kernel.org/linux-modules/ce7f293c-d9f9-4137-bcad-8cc492d34773@suse.com/

-- 
Thanks,
Petr

