Return-Path: <linux-kernel+bounces-845519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E4FBC53BA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60B514E3346
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CB285C84;
	Wed,  8 Oct 2025 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dywjDn0h"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5521B185
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930536; cv=none; b=sLPA0Zr915Hy8x5GBQcM6dTunhQJ6yM28pye5U1keliGnsgNHRZoZnBDevZEL5Bf4EXA1uZAa6reWieZmZ3LTqrs22oq5124xvxtegPjMOt57h886VYb6ip3qCfCz3qO+8L3HYvCG0ubWPtGnGD//YrU8W+cTkPkLUBssWztiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930536; c=relaxed/simple;
	bh=7vGH8N/m6PE6lnr/uLWOIY85RQ6MjHgDYrjIeFb+YNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDGTF6RCbSZrJ0Imaa1rOPzMsMSxRcORu0xzosbUFoE8q/EJ/dNLLfKQP90bT4vFOuJBkQMyvVS4OvgBc/kMIFPG/4ab0IE7VkXQzfQTaHXQ6xQGnE8CU58VGXiQbFgr8cwf8JomLpDNixbjocDQxmEGiV6NhPOU+qqsWWl8UgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dywjDn0h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e504975dbso45386045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759930532; x=1760535332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=dywjDn0hZVcYnCqsGOJwB9zIwhAuPBx6/MnaRssTC2JfxFetIhJNqVQHO9Glfw/Mzl
         jdCKVnXimtkCw+nFxD3dFnOx4hTdnFv3SbJ5xkAh87EiDw6ziOab7IrwKFiDG1dvfCNd
         zBYEFhKO89Acm6ztRue/IbFMpeXzKHV5zH5R+BhNi/y0az0Q0aLDXYMhdJKVuVLQsclY
         yZcjxPi+91EiGK8WBuDigRSxaFesJlkjC1nKNfND+ejLHMimqJvAFU/kRvEiRA7THLqA
         odnmDDe3Drz2vcYt5g/ZyOvD3MWFevAngP95s6KBpFuSxrjXluGXf9FpghAzLon+0V8D
         T86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930532; x=1760535332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=WD3irnp1+m7sO2tUQm9X5Em8yTAbDouKDYl6GpyHMKIpF1Y3H2SpF38UiErKMNaIcd
         nn1nIr0W4vcUCqjG9QrWlohKGlCoigZyfcJ7RjIW1SdNL3BBYvbz0QJqU70wvtXbnYBA
         Dj1cpQQOn7xMSpYhFuipg26zk0m+E2jlUBSKzv7hh1eO11Ij51WKPogX5kQtsjXFt87g
         5CoLOamxrjL+UHWzBN8hORclaiPEtfgfDofifr2opA0/xLthUVzrPsyEpt+4lIAkCnwR
         H3sd3p8OdJkAz4ikWiV078wUIQC1KopL+crvQTEkY3lxgsEz1ajU+SDd0V+h7usK69Qk
         2YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz4IHDJDqd7qIl7ZN+0ecvubu5yU8UXzMltLpKiE/0m9lP9JWchttwPakcTXgJLTLnnghaavKn+qgS7/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPH0JsmbFD/7bSmQMVPHw2qgRw7e3oOt+0ZZYa1PtGq4k5ozN
	G3CaNaKdnGGjLhgr63DH6z1ks6d8hknbKLaIKH4iFBvJl1/eTcAOZ7m7RSCbxfhIeRU=
X-Gm-Gg: ASbGncv1QGOdxlkbyto9AGtCoUKVQk/UUgRPtmD2Pv9ytgQhqrm/GFKdSB6ZXiNgm2a
	zA5b6Dl+fYBUI1MgbZs9MgCJz5/4cJjlTg4wCWWaq40/JmAk1H9Upmgq1Vdgf0cepbNP7vzJ3R/
	JM4EM/un7dso5R8RST0E/rp7RPnNrHb5SjIiV9gC5G5ei528Fdt7JEtSfmrAPwmkpZLKPtjRWtq
	pu82WKSWhWR55nXlYFvVC6eGkRf5fLXy9WUUgt6cVhNxg8hrNavH2NfVxq4g4RXoW+d1GYpfyFY
	/IMzJM6PVtIIzSfpTSttV6F4epeVnRD3n9s/bCZwIHURsrYeWItCewc74I1MKM6QPuDYwyl9JaS
	nqZX2m0N6zocYv6JOQSHy6Yt+KhU+HeTIrCNJMzJIlz+zWfV2VpF9GV3/23l7Tq4V
X-Google-Smtp-Source: AGHT+IEXN1OK+uUWcZYHcu8mGQCE4xlOe4D5UqEffJSE6zNfCHiuL17ImKFC3KKJ16P8hPWOZxwfnw==
X-Received: by 2002:a05:600c:4f92:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-46fa9a96588mr24061795e9.12.1759930531814;
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm30365608f8f.38.2025.10.08.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Message-ID: <6e057525-ca8d-4f96-bb52-cca6cafbe835@suse.com>
Date: Wed, 8 Oct 2025 15:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] modpost: add symbol import protection flag to
 kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-10-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-10-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> When the unused exports whitelist is provided, the symbol protection bit
> is set for symbols not present in the unused exports whitelist.
> 
> The flag will be used in the following commit to prevent unsigned
> modules from the using symbols other than those explicitly declared by
> the such modules ahead of time.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
> index 574609aced99..96fe3f4d7424 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,8 +3,9 @@
>  #define _LINUX_MODULE_SYMBOL_H
>  
>  /* Kernel symbol flags bitset. */
> -enum ksym_flags {
> +enum symbol_flags {
>  	KSYM_FLAG_GPL_ONLY	= 1 << 0,
> +	KSYM_FLAG_PROTECTED	= 1 << 1,
>  };
>  

Nit: The ksym_flags enum is added in patch #1. If you prefer a different
name, you can change it in that patch.

-- 
Thanks,
Petr

