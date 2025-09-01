Return-Path: <linux-kernel+bounces-794223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D099EB3DE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E5C7A9DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752D30F540;
	Mon,  1 Sep 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQDJez3P"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6B248F66
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719019; cv=none; b=lD6/7Ni5bOqOGOYB3lt9OiohC+y3fcyxOqYppH9nuVt6XJQMYzLPQwvMVKh8qXT+5V3US/wdigyBrTFVtgWEnYBDUxRsTsekE7vNLCabtfno/dipUISAj/YerCfOG6VOWRcA5x6sOyGtrqAO2hKwK6i0yKOanfxOBEBbg4nj1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719019; c=relaxed/simple;
	bh=a0NDcR75d+O/mfjnpFO7rOU4DSlH61V/u19FiJLYD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=HD8uf/F00FCZtr+ILq257Ou+rUUVU1wJlPfapSTNGl3zYFxjifC/Ox5lTRZA831MkxTt1A//DL0Hg8jEUYA0eEEv7apRNvbTZETkBHd+62mbJkRTsryfIe1wqF+09X8p8qdrai/PDG9Mx1wXWtFTWYhxTafK5GtWbwN/KslqqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQDJez3P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b873a2092so13604045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756719012; x=1757323812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3O46In+nyvkhXwMUza5HjmWuLjmeqVrP/Df0WayjpU4=;
        b=KQDJez3P8MXsZNd7CIFUg3YNM3HXEhEomN7FQnIqo4JoKepCjpPJxT4wVa5Yh1n1gd
         3/gxTJR6VYiGEcsffnGgQsMaL71vLGQmFxYSf49LKVAzLlP7TjPTMRhSOTy9vX6gD499
         5gnDAqda7T0epqZgNmKo23CIR0qD2HMqF86zhs8VJ96h80nSY7NqNu9PKuFMV2Xbsv57
         TOQ7IykewhvTA7DAPLkjO3oKF6MatpgoPPymxgfHNneD2IJqWDFq/5UZKTOIUIpOJfxI
         rMWhGUtn2XvipeaJOd0t/J+qBe8lsV+BRL3BPEG3VvZHfkkHxY+62zSPmXGhXsw4a9xP
         k1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719012; x=1757323812;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O46In+nyvkhXwMUza5HjmWuLjmeqVrP/Df0WayjpU4=;
        b=Op1xI1MsANJtZ48kIvmCi2WMi/3qfPSDiODdPrz70JcIL3omaT9EXE8uZ6JTJ+IsLJ
         KDfkeRo7+rTQ8VnLsBXwkdWN/xmbDA/HgdSjxztEfu3xuUtTasfOzLuMPanHwJLRqCkX
         DZCLgtb+VTolPdoB6JYFz9pM9R/M0VtE9bzokrmNsLuFCTv2Q2AdZP7S34ZgZYdgPtkz
         Je850y3urAyQqJTtyd7VZHyKs4ado+JXAjKWmzmLMSfFnCnamXntURv158bKRFkoJbPB
         N/YokCdQ9LPBMLxOJpgKMWsBIucyEGj9nBxWioUWkQPJM+LaDeVVX4bm4triSpA+MW7l
         0iuA==
X-Forwarded-Encrypted: i=1; AJvYcCUHHovbZo9kjqQXteAk4BeUWTe7O84DuKNAu07dw8ImkUMGL7sZ1qAqS55rmzrDlsiCxZQiksjH19yLTBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwuPcaETg2+Q8xETF2uUqAd3IlEFRREW9n58wKML89Je8U4KE
	6NiE45Bno23eNiGZ1T92VwUvnaXWKeHc1FmBcddjbvQl02x7dnrknnIKSubE2fo7N5Y=
X-Gm-Gg: ASbGncumI7wtC8tYATz3C/Z3FNvTHqM6tXedLEtoX0mhxwlHkB4xrSX8t1e6REC7hts
	aD7nyQvtQV6hORoyujRJ4KgpxeItzHnkv03+l9X+4J31SjG4cU0QpZZw6K1zHrRtjDZdU+IKRHm
	UQDTbXeJPE3M2Pv5Ofjaccard+lyBQLGrhxu55APRn2pqBMh4B4uk41vwkUdVGsAtvmLQoE1TcF
	bsJx9qoSstWTdLox0nLcW5mn7+ym1ii4MeZ9lr24lFzKRZwD2M+oohIzVf3FS2C285W70KhSdGt
	Qm61AtTUjuIg7gCVth0ggy6QrdPwUWnzz0ZqgI03NO4Dwc5knaA4NySU38WcYzr5RmwqueCKzY3
	+X9JdAXkOJl/KrPYNUZitouBn3px5ZpMTAtSudproz32GUPTSfB/O1Q==
X-Google-Smtp-Source: AGHT+IHbfldmXalTHs74Qjn+LCgHIRtognchtI6YU5kylx/Aeh4PMN+YtrSztzHAM0TUn6JS1ozS9A==
X-Received: by 2002:a05:600c:3543:b0:45b:8822:d683 with SMTP id 5b1f17b1804b1-45b88321c6dmr44024635e9.4.1756719012076;
        Mon, 01 Sep 2025 02:30:12 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73cf86f4sm207103535e9.6.2025.09.01.02.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:30:11 -0700 (PDT)
Message-ID: <5ac979fd-7a84-4633-a53a-55be955faed4@suse.com>
Date: Mon, 1 Sep 2025 11:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] module: centralize no-versions force load check
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-4-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-4-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Move try_to_force_load() call from check_version() to
> check_modstruct_version() to handle "no versions" case only once before
> other version checks.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/version.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 2beefeba82d9..7a458c681049 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>  		return 1;
>  	}
>  
> -	/* No versions at all?  modprobe --force does this. */
> +	/* No versions? Ok, already tainted in check_modstruct_version(). */
>  	if (versindex == 0)
> -		return try_to_force_load(mod, symname) == 0;
> +		return 1;
>  
>  	versions = (void *)sechdrs[versindex].sh_addr;
>  	num_versions = sechdrs[versindex].sh_size
> @@ -80,6 +80,7 @@ int check_modstruct_version(const struct load_info *info,
>  		.gplok	= true,
>  	};
>  	bool have_symbol;
> +	char *reason;
>  
>  	/*
>  	 * Since this should be found in kernel (which can't be removed), no
> @@ -90,6 +91,11 @@ int check_modstruct_version(const struct load_info *info,
>  		have_symbol = find_symbol(&fsa);
>  	BUG_ON(!have_symbol);
>  
> +	/* No versions at all?  modprobe --force does this. */
> +	if (!info->index.vers && !info->index.vers_ext_crc) {
> +		reason = "no versions for imported symbols";
> +		return try_to_force_load(mod, reason) == 0;
> +	}
>  	return check_version(info, "module_layout", mod, fsa.crc);
>  }
>  

Nit: I would prefer this to be formatted as:

+	/* No versions at all?  modprobe --force does this. */
+	if (!info->index.vers && !info->index.vers_ext_crc)
+		return try_to_force_load(
+			       mod, "no versions for imported symbols") == 0;
+

Nonetheless, it looks ok to me functionality-wise.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

