Return-Path: <linux-kernel+bounces-845671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B81BC5E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB87407353
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DA62FD1D0;
	Wed,  8 Oct 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gnF5NSC5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29127303A22
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937734; cv=none; b=KMK64wtthmB1lodvkr4md5FVKyQzLqzNBxb6zLsy5pvpbeAejPheHtyD+OieT7kusihfZG3qQGPPkQEjYhAD1keS/qY/Hb8NhYpT97mCF1Q47nWSCkJtT1f3ovhWnBNmWdr4F3dHWXNWDP6etpR4GMIkdJFJw0PwbGpeTwrfD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937734; c=relaxed/simple;
	bh=MeMMelM99YxAP2TiJ88uHut4Vgu4VVwfVNl7tmbTWec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLZGKfA4mf6UvcVqHA7OOOpVxNQq3rRLpwcfYMIMEIms0yl9NHsOy5nMtYE4q7R6f/k9oX/9x49oBUuA1cEnMwmph/6nKFODjnbbyTGgxFMRXteZ0KOhilt1AyfCSgEq+nE7X1S7hvm1FaKQ+1qVn6Iq4X4PCDcqJVRxgrQ1+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gnF5NSC5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f7469so49403435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759937730; x=1760542530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubNXaozyh7/Vs/XkTA5KuPjbCc9zS+vNuDnCIrZD13M=;
        b=gnF5NSC50KY8J07hJipP4oSUoycsnB5USbLkXj+IRUeEwb3bhLFIKuLsoO+gxroQqH
         hNZucazjbQHPSMYn+rF05W2Qm3NgXiO7yCF9cwfH9tWKSGGHfK4wkKRldds27153FYrR
         8UKbPPGXjJxFj3MrHOd8mQaIZPKcL6NWlyyyQ1ZZiS22z8O/vCA1h6d/le88excK+PFp
         Vo00gWI0eYa81mis8wk396h9ZHapvR1zw3LLf1tVJ3LsVduqBpxPIBGIToL6c1ssdr1o
         ImqpvGWiGv1rwoShyyRI1RY5uMErpIXY+BSvv2MHpNpxoy+OWIoFZzY+yMlrBFVfwYoj
         F3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937730; x=1760542530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubNXaozyh7/Vs/XkTA5KuPjbCc9zS+vNuDnCIrZD13M=;
        b=DOZ9F2oRID7ZeFGJtfJI+4mGRMwfiEJ8j1H169vlzpnqLvzKOUEJDyTIJcy3+NAjfv
         B7TkOGyxss1X3Qi/HeedF69eNyYRG7AFrcWNzs2J4GjsYGSTNNEsbNfGqy+Xt2oaL4op
         d9bCnL9q3QWDJSArosl7n/X0dS+6zlJbpOg15LESfCZQZnG3IcdQ72ZEjLRJWZ18y4E+
         H1O5CN3eDl5C1OJQz2XEqKGyftr0H8DjXXRRXnCjmSpINkW1sOgVrv3xHrGyz2zdip9h
         gS7GSg9E8iwIOIaC+BpOZKs86sTyesGCHSPbhOIVC5di54bUCVeMUFTMRFwm5KvVpL6h
         W0gw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXC9olNoNqppm+UVZaelpapkYG3zddaJfgJ1cV1Fi50GO/QrTxFcgmrl8NnRg30WZbk9LebUt4rU9cZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8rm9cQOA5Javr/ITVkzIL0yuUam2adNvLGwFrAqPmn1FuFyx
	DGKW/F7a94SC7qmDLViPWFKpyrJQtMZz83UdDAoVi9zKGwSCvHtVdWZvV6BDIGhdmAA=
X-Gm-Gg: ASbGnctWM7xRfgQFNoZJ7csasPxJw6VGyMcyChRcVmVtLTx5epVdqj18tfhUDcwKtMH
	6Ao1a7DwCYebSVgDvkFXGLb4FkOdBUvxiyuZ6BMgoVGqtMX29xpkf91K+W6xZEkHG90Kbu2PHXT
	MzNVzdDJaorw0oSZq/iKlz5tUCORN+N6Yjo5cV8/xNK4li94u87M5xpG4TOWQUTZfZrIPgQS5oW
	gJliQ3UM8L64WwUqcNnL2LIUqkqc0yh8J8zspJlxK/S2LH3rnxNBAHFntLJyolyirzuTOvZ2GPB
	nueuFDFqaQcZhvRfFrsygtvpoiCleXkNV+OTB0P/5No+4Bdb/rW1jyMHb5WQjiLqad/rzh/UKq5
	zYI9ZgAgk+T+5QCSHLOjRPcqw0k8YW5His9gKb7MKX0PuOroAsQ+9rOHGRJ99i9wG1KpnKkWext
	c=
X-Google-Smtp-Source: AGHT+IGq0oHp24srWcJJTjTppYJ2gdwL9MgZY8IY0dg2EY9BvDrG3QQbJW280mmxjX7I0sdyPXCadA==
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr27734775e9.19.1759937730499;
        Wed, 08 Oct 2025 08:35:30 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cc939sm16809025e9.1.2025.10.08.08.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:35:29 -0700 (PDT)
Message-ID: <75099eaa-4b51-4580-ac82-2c9f892f34b2@suse.com>
Date: Wed, 8 Oct 2025 17:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] module loader: enforce symbol import protection
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-11-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-11-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> The module loader will reject unsigned modules from loading if such a
> module attempts to import a symbol which has the import protection bit
> set in the kflagstab entry for the symbol.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 4437c2a451ea..ece074a6ba7b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -380,6 +380,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
>  	fsa->crc = symversion(syms->crcs, sym - syms->start);
>  	fsa->sym = sym;
>  	fsa->license = (sym_flags & KSYM_FLAG_GPL_ONLY) ? GPL_ONLY : NOT_GPL_ONLY;
> +	fsa->is_protected = sym_flags & KSYM_FLAG_PROTECTED;
>  
>  	return true;
>  }
> @@ -1273,6 +1274,11 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>  		goto getname;
>  	}
>  
> +	if (fsa.is_protected && !mod->sig_ok) {
> +		fsa.sym = ERR_PTR(-EACCES);
> +		goto getname;
> +	}
> +
>  getname:
>  	/* We must make copy under the lock if we failed to get ref. */
>  	strscpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);

The is_protected check should be moved before the ref_module() call.
Adding a reference to another module should be always the last step,
after all symbol checks have been performed.

> @@ -1550,8 +1556,12 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>  				break;
>  
>  			ret = PTR_ERR(ksym) ?: -ENOENT;
> -			pr_warn("%s: Unknown symbol %s (err %d)\n",
> -				mod->name, name, ret);
> +			if (ret == -EACCES)
> +				pr_warn("%s: Protected symbol %s (err %d)\n",
> +					mod->name, name, ret);
> +			else
> +				pr_warn("%s: Unknown symbol %s (err %d)\n",
> +					mod->name, name, ret);
>  			break;
>  
>  		default:

I suggest moving the error message about the symbol being protected down
into resolve_symbol(), at the point where this issue is detected. This
approach is generally used for other checks, such as the CRC or
namespace check. Additionally, I think it would make sense to change the
current "Unknown symbol" warning here to "Unresolved symbol" to be more
accurate.

-- 
Thanks,
Petr

