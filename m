Return-Path: <linux-kernel+bounces-845502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A3BC52F2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56E84016BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF285284682;
	Wed,  8 Oct 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WA3uLfNt"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB23284893
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929881; cv=none; b=D72FVU64JRPV2CV/MhDX3Zd8hWy7OKhs5TqVSHuClI5al3Vv+YG7J2QWGNnYrgJrUvvq+40/iIoEMAxrTtRHSTEjLLByeS/14nQ75vcUGE7K5qvjl13A+NQIbffIZN30KLL588B8mmnRYtljLNSudg3Ul3aM/KMTYJg3J1U6AGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929881; c=relaxed/simple;
	bh=fHRL68xgbrs4S5d+Rk03mc7ClH8sihNkbqrGqaL31yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMxoCoUQ7dr33hNos8iDPzfkNS6dIu61SQKGRGDWom6JWzDhTrn2dxlh56Uv14oqZtM/KfH5CuJzyyWDsjEJB47nRz05Xu4hY24r8pPQ+z5uWSibD4kUSkblPlYbeMOUnH8nbgjgD/8wFGlZF35S7C2j8RXAzkP/SxmEW/pJ8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WA3uLfNt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42421b1514fso3526484f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929876; x=1760534676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=WA3uLfNtZKVV9l37I3e/ToYZya1MGuHLUToON1sDJ/mLNk46sz/nZGuPgKgrnftm0t
         HjTiJHGd+b8TbTp8eU2AQrbPTpifE+cM4okUjyzbzXtjNNkWm6TiDG2fgLsoUvQ/543K
         broEnKIROX30s0w4pdscVGlZYdYRs1ZSg0ALpZFhRbFMD5pBMpXgG2xDETEN3s9rO52P
         ayBhwuPWIMGvmWTxzTuBPYmkuQ2YObGPFr4YCWt9S8aNBtJidU7quF6COOIeSrPQJL+4
         GPMcCr1hYobFqLfwpJzqZgyj7dW9HM4M0VnjpYnYXk0fMfT7zTnKLKA8qQhdicB8t71T
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929876; x=1760534676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=t6wB81z4pPhA7Skun5zA2/aOfzSeMYStXk42YyYIHsnARVR51QTbUWZucV9nUofpLC
         xTxVDrLBJ3IixTPwa6sz+iLD5WkRTNrlDDgOjKa2DY1v7kDsqjDz2y9SsOhwTg4GfdVo
         FCpt4/zzcgffwJQ+l6Zs/EO+jF2ZMiFhPHLeUBtoJd9y7oSrdE7R5i43ZYK5g+7alGtY
         vxTWWDha1iEOk7kavNHsw3WWmOTytDhNIkQl4SBVjjjwLmQGCgeUJg3y1eLul2Etlli3
         sFs/cLgHYZ0cSLN9szBI7JF1DdfpkFF2iqPej7KWXZKnKfR9alsRDCrUSkQtw2SpH3bU
         QABw==
X-Forwarded-Encrypted: i=1; AJvYcCVwAgN9ng11wQJVQhPdV3VAR0m/eXQZMUituf1PgGvw/6FV45KzrAAxYIe1uNhNiIP6LMvEQqJjZRaalQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78sfngBc+HypAzgD6bmWWUJtI/XC2fwZL0kvb7SdvoI61dGzF
	Qer0/OdK9UZqak6v7gHZk6JmH/DoxdpXb8lHjxhnFFMq0IjRWS8dEzrt8CWQByCobQA=
X-Gm-Gg: ASbGncuKkV5qMSbP+xQ/TFZignyH4HQuse0Z7EQZSS83ycQW4OuCRRRwFH1FYnEiSAT
	mhwuykndDbu3mq5Z4XjnutJde8LLBmn8C7nKqPitZYVQKGaVWaaMUsWCglloRfIWy9wHp0JkfXi
	zOmQ6/2YIclqiAQpm3lAvqb8sk8YA4S30o+Hk/Y5LfcEgfwLglrPf5PHSHX7hLxwa8+a3795VBu
	H2hd7bWri+i608cjyQAsQrfKPi+2Zk6n9X9/9Sk5JSIPMUHjDtYWk54Uywjkh8gr/Ml0eELgeQZ
	x+N/mlj6fCZNiZcTCejtbDPTQC+pLCYdtf9GNwyHFdbfmgg8Do6MWylr9rjOd8IUytSRHqtbA/Y
	DFh+acdHMKIw7Blj+KaLL0L/IkwBrgT0x3Vs+Ir17jKSRgRUYhv71nVQK++bjOGPG
X-Google-Smtp-Source: AGHT+IHuhMKyjw9ZbS23OBrv8VA5JUlHXtFCz8Wrw4kfUqnmq3pfnc8RuPQ01+3mL+le3/TLouPIeg==
X-Received: by 2002:a05:6000:22c7:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-42666ab1b7fmr2477434f8f.11.1759929876072;
        Wed, 08 Oct 2025 06:24:36 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm29892836f8f.18.2025.10.08.06.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:24:35 -0700 (PDT)
Message-ID: <b394956c-5973-438b-9e43-f7081a89fa97@suse.com>
Date: Wed, 8 Oct 2025 15:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] remove references to *_gpl sections in
 documentation
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-9-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-9-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
>  Documentation/kbuild/modules.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
> index d0703605bfa4..f2022fa2342f 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -426,11 +426,11 @@ Symbols From the Kernel (vmlinux + modules)
>  Version Information Formats
>  ---------------------------
>  
> -	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
> -	sections. Symbol names and namespaces are stored in __ksymtab_strings,
> +	Exported symbols have information stored in the __ksymtab section.
> +	Symbol names and namespaces are stored in __ksymtab_strings section,
>  	using a format similar to the string table used for ELF. If
>  	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
> -	symbols will be added to the __kcrctab or __kcrctab_gpl.
> +	symbols will be added to the __kcrctab section.
>  
>  	If CONFIG_BASIC_MODVERSIONS is enabled (default with
>  	CONFIG_MODVERSIONS), imported symbols will have their symbol name and

Nit: I realize this part of the document primarily discusses sections
related to modversions, but I think it would be good to briefly mention
also the existence of the __kflagstab section. The first sentence could
say:

Exported symbols have information stored in the __ksymtab and
__kflagstab sections.

-- 
Thanks,
Petr

