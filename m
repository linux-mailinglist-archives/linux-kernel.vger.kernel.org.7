Return-Path: <linux-kernel+bounces-795911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CACB3F94B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF5748685D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11662E8DE5;
	Tue,  2 Sep 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="cxY734an"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCB32F77A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803528; cv=none; b=NBdz57pVxjRCQFzZx8Vd3noy4vmjkxGEpZikIIXxnKBj70XtS/y0O60XA34YGcLgy/ZGp6BV7fvvmWOP6vG3Rm4fmT4XtG8hWpMy6D78455czWriPbMAmQNQgW+zhFZ9t/WVMPjonh0rtRuQdieAAQgae8tZ/nuyWz4WN2MSxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803528; c=relaxed/simple;
	bh=QIoh5jTL1PVJKZRG+Lb+CALSh7Ks8nnumJanccDk1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKCBqHzQnXIkPJUEb79aRoEUpNZmL5bpJPZo8rEe3vgqt1ooAs4SwH3p0tmfRyM2jr9pbB/ew2uroydHAWSVf89wLHNSqpOk0/QU/LTAdcKw141kD/7D8roi1se0gmXxIc0dFcL//icRRGdjc3gmBYHJk3C4dJIIu+ycP7JUN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=cxY734an; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ce4ed7a73fso2614289f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756803524; x=1757408324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdTnKkYv89qYmuDrHKQiKv7a5BMqopZQ28l888CmXYk=;
        b=cxY734anSnfb+oITa5tBkrwf/MssBjaCjCuGgtx8MUq+PyNHK5KGdllBqgNSLmHZd5
         ZMdNVG52RkIwTfZgUpcZ50OT7nqEw7TI7QuTJYcxNMYcfMuJqdfMiAIgcjZu28qt+gvL
         C3t4uolDC8e/My5Qlb84S25VvHl4Fg+bgoS0AaS3GFJisiJxg5znIJ/njRSsHfAzsIPk
         uaFJGj/QhqabSxZVzfaHFQbuVjgq7DJiSbQogGuKvF4CA8bdwQ/afPSL//bdQgy2aQI5
         /otauF1xKaUFFfDk3bQcqtXYyUJXki2y/xYj2dH1O9X20OpHNFf6X2XdYXK6Os+Z556z
         qd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803524; x=1757408324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdTnKkYv89qYmuDrHKQiKv7a5BMqopZQ28l888CmXYk=;
        b=QG/fAvvg+X1C6CvYfsaUG6eBK1ti9MyPfq4fvqxPXaAcZQORxNL4gD0qkF+gya9kSr
         9YoVVKR/GkLe6OtCb1esW3uQtLlm8Zsamgb8LpyOhhDdhtunaLKdAK4ELoDn9R9mS9AH
         k/ZPFcjZMRV4PPL/udR0WvB3BwR96Zpaww3pzMbjxDxzM3lONicM8cYBfSEazLl+kL/9
         SSovDYakhdZ3fitZy2dpy+wtRwJ9Mi/qaO5MEepL37xD+s86uzgU6MvFggCCG16+T8lE
         0hqJsrMMZmuqH4w8XJ3ziaEIAqrog8XJd/m4N78AU17XP2Xb1fZL0aZ3QWK/ZcK+sK1i
         AoTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJWFpnalkpuNuj3oSPodu1csoQoKq+nlosdcRMYdlDYshn5BwuK7FEFJAmhA0cfTFWmPGNaRsGXJY0Hws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38xAh4Jz/KP0qMSYzrYTLhD33iFjW7Zn8POkmFjRvvKP/WW84
	uN6F9Xad1Il7rXdVbDEeF433DArMCd9zPecE9CRVHb6ES3N+oG3CExuUCcbxx8WIclg=
X-Gm-Gg: ASbGncu580H1K0SXSHJ4KRVwkbAgxXqb7o8DfkIgIMQohOyDOD20mYbIS9kRLT4CFu8
	D00s6RzHAdvO002N8x0OOMquJKzniyzOgYpz4CnUkcLkIEwForpv7TDo3n6v1h7TM1106JuFgWW
	mihoNDou1hErX0Fm89mdSs1VG8UqwePTabLVmYyD9QgNtL9h3WnRnhn7ymwbQU5DYAn9lT5sMEE
	KIliUISxZJHZMXB+zhETLPxNSwE7voe33EBIkgXM/Tey05fM8TLddzKT7QLScX9YRCl6l6jghY6
	kbjvDDQzamCB8E3JZ09WAGO8V4iwvGHfHg7Cmf3KlRlk8I14ZSjpn4ze7MiukeGU9uOKy4Z+mHx
	FA//QRfKf6KaWo3Q8a7ui9/VEdHexOKVJhk4=
X-Google-Smtp-Source: AGHT+IHcFsAfK5WIhq+S9Y1CY3ZPTu/1Q3IzKtJHTb6xFETccQcxq0O80x8z8t2LLzPK76tz+CxMCA==
X-Received: by 2002:a5d:5d8a:0:b0:3ce:a06e:f248 with SMTP id ffacd0b85a97d-3d1dddf374dmr6988087f8f.17.1756803523951;
        Tue, 02 Sep 2025 01:58:43 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d3a7492001sm13361996f8f.42.2025.09.02.01.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:58:43 -0700 (PDT)
Message-ID: <5f6c7541-93ca-4b67-b4e4-33ff60e99c7d@ursulin.net>
Date: Tue, 2 Sep 2025 09:58:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Replace kmalloc() + copy_from_user() with
 memdup_user()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nitin Gote <nitin.r.gote@intel.com>,
 =?UTF-8?Q?Miko=C5=82aj_Wasiak?= <mikolaj.wasiak@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902081046.35463-2-thorsten.blum@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250902081046.35463-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/09/2025 09:10, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify set_context_image(), and to silence the following
> Coccinelle/coccicheck warning reported by memdup_user.cocci:
> 
>    WARNING opportunity for memdup_user
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Resending this (with updated patch subject and description) because the
> CI logs [1] from my first submission [2] about a year ago are no longer
> available.
> 
> [1] https://patchwork.freedesktop.org/series/139319/
> [2] https://lore.kernel.org/lkml/20240925141750.51198-1-thorsten.blum@linux.dev/
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 15835952352e..ed6599694835 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -2158,18 +2158,12 @@ static int set_context_image(struct i915_gem_context *ctx,
>   		goto out_ce;
>   	}
>   
> -	state = kmalloc(ce->engine->context_size, GFP_KERNEL);
> -	if (!state) {
> -		ret = -ENOMEM;
> +	state = memdup_user(u64_to_user_ptr(user.image), ce->engine->context_size);
> +	if (IS_ERR(state)) {
> +		ret = PTR_ERR(state);
>   		goto out_ce;
>   	}
>   
> -	if (copy_from_user(state, u64_to_user_ptr(user.image),
> -			   ce->engine->context_size)) {
> -		ret = -EFAULT;
> -		goto out_state;
> -	}
> -
>   	shmem_state = shmem_create_from_data(ce->engine->name,
>   					     state, ce->engine->context_size);
>   	if (IS_ERR(shmem_state)) {

LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Note however that CI is not picking up external patches these days, so I 
will need to re-send it for you. Once it passes I will merge it but if I 
forget feel free to ping.

Regards,

Tvrtko


