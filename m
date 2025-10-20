Return-Path: <linux-kernel+bounces-861491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C5CBF2DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F062A34B229
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619762BF007;
	Mon, 20 Oct 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZPpfwZc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2B11CBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983704; cv=none; b=qI6nkhuAy5Vs7oT8xnfgk85EqmkKavGMYYAvRwjkLZu7Vw0/XgIffFyR50ESDQQWSz7mP6T+Zya0/D2A1Rk/jfrmZzG7f6Z1xAQw99UCuDC/eM3mTkBhL1AsCusU5wYuWeOdrQeWdpKdzCrISc/zDQ654ikGJGdCE7JQQTFoLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983704; c=relaxed/simple;
	bh=OCIcPYbIo0M7URSy3N3xFA27e5zDTVMOf2eGtCxqTvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrYgxVhamNZCePWtc2u8UCrSv2b4zDughiwnWZzZB7ZfkiRBhqszG26C+9sw0FYm07kVHrNvZhsGBl9hzEV23AvbCvSwiVhqlT47RDYZSCGiDmitSTuUbqkgjZqqfdGyt8UgJIgch6hEmNSzz73w1eLxclWo7YEJabGexQRKV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZPpfwZc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6bbfc57b75so153132566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983701; x=1761588501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ4Q2OXtz5WWKrpfISo8iGefWj+LEQC/IYNXPaBkbCI=;
        b=mZPpfwZcXoF8EiLZ9UOWRZR98Orh6GXhWs0FInCrAOR530BCc9+jB0v6YvAOmLd7Ri
         swHbGc8ur9w+iySYXCZ2m4LoNqsmwMS2E0zMqRbJGX+PeCSREfXXQFUPgWd9V9xSSTuG
         6iDUPHNKsIvn6kT8v5NbyOLrTJCoMkxDMiYbV8bdobMmb95bPnjeTYSlK0kV+FZ32GMt
         QJ6C4sWSZP+VS74c1BK2/lo0mfZhI1oBR2OUOxNlBS3WTW7PRoF1D7PU63FA+z/aZZ4e
         T0vDQDyyCZNfKy6JHlYL8r+x27wAfyckx6WeX4yyWDCxG22o9Ng3QyqFwQ43XS+gBWzO
         n9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983701; x=1761588501;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ4Q2OXtz5WWKrpfISo8iGefWj+LEQC/IYNXPaBkbCI=;
        b=QxZj4xSeQ1jT8UOY3NB+XuG0mgEgIzHHmTUwautCPBSIKOrnwoVCItFuZs0bDR62wM
         MVy/bYjqgkPvV5YpH6TWe4PqGnkGh5RHey/xiHIQS9lRkN3Vyj/wZ+gOvDhk0rrgOFiy
         2l89anFoZf8gZatz4eyyI98jjNSooUlC1T3QjZqyhCpkSVx+ozWTS9VV4xhNuoLh9nqP
         wkbHni1f6dIcmQPm+QqfrRP4dMk7tmtEyT0FBcHw5AUlOxpxe/tC6aHeJMHbsxslpFGo
         kbNjrvCqdMsF4egidKUhwARrCMocIppqJbC8kRe/NiHy5AHOkHSKporDV/1lp47amM8w
         zZFw==
X-Gm-Message-State: AOJu0YzU8Tj7cu47jwFqkCzNDVbbF0hmV/yJm10DTjxkufssJ14OohCr
	45/KHwKrNK351M1G7RJYxe97hvSXItFK+dUSp0BVbm4Ps1eiortzRvig
X-Gm-Gg: ASbGncsNc/Q54s/IfQI32yKbmW06cjbJSwgIrf/XUzRsb4LhSo4yZoOncYpJHCeJcCR
	OjcilstBKqWvg+cDhA+8rWaP/9HpWfGSWZdq0TQnRdi6IFGuXmLQCj0tAWI/sCa/7ne+uSWImzN
	BAhgulBM5xZDi1RhUoJEN8a7VJby/EotQPENEqZDsnyVl5SijBlbtkqn/rFLm8N7NK/m26YFPek
	Am16JT2rGytdMtvlQOj5w9kqCji+2nN4JVk9pRnDDC3CPJ5ZTn6eX576qGBQjD1V6D4wGCNeG/M
	uIKEpy9gIWw3kO1OvKUb5o2Vh9UBKuXJ9/VtId4hTk8B/MSrd16MBeHH518U7TiTQ9FNSOOeLwb
	6dA8ayAE/e1W59v2Fl/K/sEtFPWoKg9C5er/vNB09DHqzRI+9q48W8j6KfAQfJdtIREWl/mHAj8
	93f/nuem9DqGtwIojbJiLJCPalWxkpFkiWp84Bm+2kXy8xHpj/QyU=
X-Google-Smtp-Source: AGHT+IFd89BFCO1yVfGGj/d7WwmJs4B0XWtk91ogl+pZD31LxvR6a/qjdmNRrk52I5Z/RtLbiGd/zA==
X-Received: by 2002:a17:907:7a86:b0:b57:2c75:cc8d with SMTP id a640c23a62f3a-b605249e429mr2075004666b.14.1760983701239;
        Mon, 20 Oct 2025 11:08:21 -0700 (PDT)
Received: from [192.168.0.100] ([188.27.132.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bed7sm7257134a12.35.2025.10.20.11.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:08:20 -0700 (PDT)
Message-ID: <0e8004c3-1d5a-47b8-99a3-76f690e69613@gmail.com>
Date: Mon, 20 Oct 2025 21:07:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Fix device table module aliases
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
 live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
 laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
 Marcos Paulo de Souza <mpdesouza@suse.com>, Weinan Liu <wnliu@google.com>,
 Fazla Mehrab <a.mehrab@bytedance.com>,
 Chen Zhongjin <chenzhongjin@huawei.com>, Puranjay Mohan
 <puranjay@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>
References: <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 8:53 PM, Josh Poimboeuf wrote:
> Commit 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from
> __KBUILD_MODNAME") inadvertently broke module alias generation for
> modules which rely on MODULE_DEVICE_TABLE().
> 
> It removed the "kmod_" prefix from __KBUILD_MODNAME, which caused
> MODULE_DEVICE_TABLE() to generate a symbol name which no longer matched
> the format expected by handle_moddevtable() in scripts/mod/file2alias.c.
> 
> As a result, modpost failed to find the device tables, leading to
> missing module aliases.
> 
> Fix this by explicitly adding the "kmod_" string within the
> MODULE_DEVICE_TABLE() macro itself, restoring the symbol name to the
> format expected by file2alias.c.
> 
> Fixes: 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Tested-by: Cosmin Tanislav <demonsingur@gmail.com>

> ---
>   include/linux/module.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index e135cc79aceea..d80c3ea574726 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -251,10 +251,11 @@ struct module_kobject *lookup_or_create_module_kobject(const char *name);
>    */
>   #define __mod_device_table(type, name)	\
>   	__PASTE(__mod_device_table__,	\
> +	__PASTE(kmod_,			\
>   	__PASTE(__KBUILD_MODNAME,	\
>   	__PASTE(__,			\
>   	__PASTE(type,			\
> -	__PASTE(__, name)))))
> +	__PASTE(__, name))))))
>   
>   /* Creates an alias so file2alias.c can find device table. */
>   #define MODULE_DEVICE_TABLE(type, name)					\


