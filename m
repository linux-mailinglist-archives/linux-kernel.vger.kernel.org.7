Return-Path: <linux-kernel+bounces-768029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A213B25C16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274F25C562A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D025487A;
	Thu, 14 Aug 2025 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="MWFkXmyZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC18254855
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153885; cv=none; b=P9xECxirTqTXCDkdTMNxOCXRC0u4L86lA7pwG4QSV3u+/otXMf1HJQ2uGPLRlJgZTqoxt1EspJ7BSLMNzndAFZ3+A+hN4i23QUmBqlUCbad/ZIqsaAoW88Ronig1Y9TBEjHl/cUeP6CIQGbYGYsDN+OUgd3iCVBquERoffo9gw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153885; c=relaxed/simple;
	bh=K/qWVgfG9jQvY5YYR1eSycEvGJzaF0PPd6KpbLz+oKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXz2nX3AmJ31GCBsMkzmf5nvKtPU/NilNtC8mWLqqS7uHsXFe21hCiRNQQowZz/g1w8qAivVCLE73j56M3JYAPEsEvapVAvHYZQSA1WrGYOujZq0mFo4SJP9p5lA6jGDdfIDVnbrsf6gFmcEERbO29494qlNrlyykiLHKwI0Ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=MWFkXmyZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e41669d6so403531f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1755153882; x=1755758682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc498I+j1YOWceGut+z2RkLYjN1WkXnttkUY56LCj5U=;
        b=MWFkXmyZ6FzADei34HuRnnSjNYKhwkZpmiHfiEx1GzRTXZluc0C7Z84eyyxUiiV3Is
         6jh5CG0UxKHBeT/xNTQ7iapJOD4u5ysNZeKEi/ct/mlYXs96NTIzdN/4s/dTWMKzjdrb
         ys7CeAkHhSKs8PGSvfAnCPgq7umPgT2HGjHANzI0uyEj0oYTR6Aw7MVBHFyuc35W3SVv
         LveCqy1POY1whwdc1G9g294DpcmoacOQ8SpnTs1T+vBE2ndRG6LogB2CssE8t2lPj9+w
         Dk8ZTYXbBCsgr6B8Yw7Zs178D7aZ1MhMT9X8UD3g3xzc1ERR8lfNEG3TaGRnx6j1k6Nx
         yg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153882; x=1755758682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc498I+j1YOWceGut+z2RkLYjN1WkXnttkUY56LCj5U=;
        b=hywKCSD4Jg38efj0WZ/1pyqBbtIrB6lXslQAAecCB0ZXw/g29uqdtGKYfj86Us4neD
         jwE0vHtOMmmK9haqYUMkDTCNh9UqeeBR88M/mRmk7qBRTBZlbohgcE5aPxerj4GvCtuC
         FdLLL+DiFMbCIEISYHXMo11n+f7W1t8C55V11TiSbRCDk1MW67uPYuh0mFsYqYOZ3rD8
         qR09eyniFSD8z1ODCli5bCyrNyat7TK453KqpsZwZGNP5IPnUwfxasv/M8QAow7gjdB3
         MMkB5E+Tux2IeSc6eYrsQYQs0q+cpVtlI/KHb/KbW3MLJ44glQt4AUT3xsMUp0e8pdfo
         xZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlVK5BqoSs4ErHAfl6tPKd59CtCiXFbLuiOksXSmWomdpjeZSmbowLq2w/L7L5l39KuBTG+er3UEEyakE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYKZgMm33jDeUQIZVxt/aPo1oSgEkmOJ1gpfyA7mxfoAt37UX
	Px9c3Ju3Wu5U/RMrhVKtRah1a1KjD/cJ/FACJS1TRM9yr5ZJ1h6w+0elIHmVaKhbnW8=
X-Gm-Gg: ASbGncuTggdx4we+vEy3dX0sSxh7L20eHCjpYNpto8ywk1e52CPD5EXMe+eZkub4CiN
	fgwD9IW1Z19Nlf22o/uFThRTuyGHz5shOwmrPiIOGsV8yvKxfhRSvQPUou8FfcsA6giJ8bPBMXD
	TJVcb6S9bE29LcqadraNST2GWxrVY3FhskSt6c6AlaEMiIwNm0ipha+0fCdcu78NhDRydCRbIpv
	kqr62SIVRqg3fzCQ8JnoUSOcu1v/gLqwVa/m7WXt6q0Y6HvPNIJNwHL1LwG+wjYOg0+dGLmYgpH
	8EKP0LgRdc6qjPklOB+8rW/Qv9ZRChRmdT8cv7MtMvPROOQLNocAR86HR0sUsPEW0nrHauqK8RD
	ulnWZ7jvCgw6CqrjZLezpm5RpN1HfkORILL7VUtqYE78oVA==
X-Google-Smtp-Source: AGHT+IF8l0U9o5tnd3mzmSDQchRPhxwSlrS3PKFKAywoFUAe6DOgztRr7W+afUTUWc9q0QSWOk3RFg==
X-Received: by 2002:a05:6000:22c5:b0:3b6:b020:9956 with SMTP id ffacd0b85a97d-3b9edfe35dcmr1327501f8f.43.1755153881336;
        Wed, 13 Aug 2025 23:44:41 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8ff860acbsm23593149f8f.51.2025.08.13.23.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:44:40 -0700 (PDT)
Message-ID: <ceb80fde-dae5-478e-840c-9b949396d904@ursulin.net>
Date: Thu, 14 Aug 2025 07:44:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/active: Use try_cmpxchg64() in __active_lookup()
To: Uros Bizjak <ubizjak@gmail.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20250725072727.68486-1-ubizjak@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250725072727.68486-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 25/07/2025 08:26, Uros Bizjak wrote:
> Replace this pattern in __active_lookup():
> 
>      cmpxchg64(*ptr, old, new) == old
> 
> ... with the simpler and faster:
> 
>      try_cmpxchg64(*ptr, &old, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after the CMPXCHG.
> 
> The patch also improves the explanation of what the code really
> does. cmpxchg64() will *succeed* for the winner of the race and
> try_cmpxchg64() nicely documents this fact.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>   drivers/gpu/drm/i915/i915_active.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index 0dbc4e289300..6b0c1162505a 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -257,10 +257,9 @@ static struct active_node *__active_lookup(struct i915_active *ref, u64 idx)
>   		 * claimed the cache and we know that is does not match our
>   		 * idx. If, and only if, the timeline is currently zero is it
>   		 * worth competing to claim it atomically for ourselves (for
> -		 * only the winner of that race will cmpxchg return the old
> -		 * value of 0).
> +		 * only the winner of that race will cmpxchg succeed).
>   		 */
> -		if (!cached && !cmpxchg64(&it->timeline, 0, idx))
> +		if (!cached && try_cmpxchg64(&it->timeline, &cached, idx))
>   			return it;
>   	}
>   

Patch looks fine, thank you!

I've sent it for a CI pass (see 
https://patchwork.freedesktop.org/series/152185/) before merging.

Regards,

Tvrtko


