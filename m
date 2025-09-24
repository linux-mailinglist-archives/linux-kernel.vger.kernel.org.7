Return-Path: <linux-kernel+bounces-831198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F7B9BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A2938088A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4524A044;
	Wed, 24 Sep 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TdtAsioL"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE002153E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745052; cv=none; b=AJpa0Z1QYEbIUMANyW22ZnJB7RiPxZ2MNaMNRTepKLrhtOFdtV4b6NQQ6mOo/Tl9hSKodHiMleFgsEKbIkl2LZJLLTOuAJPlq5wnq6OURu0+6ciX85fQf4AV9SHv3FP9hE45dwAgDMvOcYDn+N5ZRwL5j9g/Lq2NI9TZYzcprF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745052; c=relaxed/simple;
	bh=11LSxohVQLtgYPqV705IwGyhWZ5zTC5qes4PC/XU5NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dktzVDxqoyiQUEwwhoABibJa3cZwYD0cXJwWwBIJsHNVwQl8MszYycdRLnv6Q/ZLvR/ntlFZ54ySggmlR4kZpUubzjk8HFSrOF7lO75SjLRePswPj4kvEe1c35qNwEaBWA4h0Iizy53ktbLnaqEGlSS4PujvZ2iDJg3EBmWtYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TdtAsioL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso2638457a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758745048; x=1759349848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxL1IkdhPFqi7CXmsjucqEYlGYsVkwBpOGWKm6mx5yk=;
        b=TdtAsioLFIvvZ4aD55iuZbLfLlQZ6W4tQTsSymUPQM4a8e5z9/LCH3w6UmgjE87dL/
         7TVp+wsHsEf72FTTaQY699p2GGlsyZWXbUjGVEIJy7wnREtnDnyWor9BNLdfIr5cwWZE
         1DfNfOIKzbER8eiWaRJpg9l9kAtb7/rcVvXms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745048; x=1759349848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxL1IkdhPFqi7CXmsjucqEYlGYsVkwBpOGWKm6mx5yk=;
        b=fNIZjNybbIuVb9Uu5s3cGS0iiA3UCbMyIMOk7WYszRSsdBnjYtWrPUm9hA//G8DkFy
         e5+dm6uBlDhUa3EKIQ5gZgtgvt5YJpqRwVTLuFo6IFD26+UxjgSBxbi2JVV20O0Ta+Z/
         GGd3JXTtYEkFQhemSsMoxJgaRay8QlTwL9HIUNR45KyJkW6Bf+Kn/W6JI2CcqHDjqJyz
         RG4CrZ5Q1udPIiATFYFJtww0C9498782aVzf+MFKF964VdHpWEkaQPYPiVjGwzSNpxHp
         rJbmvvrzNvCcij8nSbrDVbQkqTQ72nsOWKeXoVDPj8wQlqC70n0h6AhUyOiBZM4AQTA7
         ASAg==
X-Forwarded-Encrypted: i=1; AJvYcCU0X52iGqH0rE+hrKUeo//yF2Rplg6Umncfo4YnMjFtaTsOBuaND5uFCcW8sjEqcxnoKYAEbxMni5uwqhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO97UeQjZL431ZVrZnIIrP7H2KmWmVoh9slebhJA+Le4i+1+5B
	OEc0Ww08n4KwXcUtKbfKXtycWIcvDQ4Lh+P0LL3bWKI5QOrH5mH72iOzeLtGfwFs6yctGpPT1ZY
	JYs+y7oA=
X-Gm-Gg: ASbGncufniVWcIjiqHcXlJL4FjNCNEtDS7+u+4RdAW4dSMTzAZbOyFcglVgJ+6mWZ1j
	909liSJtmYPXA2lwu11LMdznb0LDAiVv2yezV4Tcu41l60tgw+lRAKtiNOhzhgAuYpujaoFE/gN
	pdiQH9nuSFci8S8RJdwGX5HyOy6SHSjJwedYpi4AYRk4wmXys6A5qV+NPhgNViOSutoa8sGHoZE
	zbNyTx8aH6gpQ9HUZd1T4GD0NSqmav1KI3GTOIO9q3sJZZdGAZlyxFM8842K88LGIjKhii6Euoi
	7PMPd8X8LcruJ9Kjjblqb2RfExDTwfI83MOjhphzRJI/+vcy+UrPwI2/aRlPrhQSp40GOIVex6O
	YtGclu8z2dtQ9QWTE+1n7jxD4LpOxjuACSdj//qte7fMiTug3swMv3IfzhnNQNsjmkf206VNW
X-Google-Smtp-Source: AGHT+IGfy9L4S0QNYR+NkJ0eo3K/3QF5DiFihWnTH/5BA4woL6xC3Zr5XK3z26aOpieaoqy5sBbiGg==
X-Received: by 2002:a17:906:608:b0:b33:821f:156e with SMTP id a640c23a62f3a-b35498c1749mr10064866b.12.1758745048016;
        Wed, 24 Sep 2025 13:17:28 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f6904sm8267666b.66.2025.09.24.13.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 13:17:27 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07e3a77b72so225307066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:17:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4zgloVXm/9qOnyZLoXMB3wQm2ZzGmADPFDSEAW7Eog5j29QjZaqBtUllNjQd0aZV7g1yxj4CoAymaxDU=@vger.kernel.org
X-Received: by 2002:a17:907:7e8e:b0:b07:d815:296a with SMTP id
 a640c23a62f3a-b354ae9a113mr13555466b.12.1758745046911; Wed, 24 Sep 2025
 13:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924192641.850903-1-ebiggers@kernel.org> <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
 <20250924201347.GA4511@quark>
In-Reply-To: <20250924201347.GA4511@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 13:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk5rMWnVt6K_3BSQ=_uEKNaYBs=FZH_fMLKqp9E4G8kg@mail.gmail.com>
X-Gm-Features: AS18NWB-TOLqbEIGYHOdjx4mWxKWbwYfZ2s88AY8lnF0tIKXxGgu95ZpuJakE_Y
Message-ID: <CAHk-=wjk5rMWnVt6K_3BSQ=_uEKNaYBs=FZH_fMLKqp9E4G8kg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:13, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I do think the idea of trying to re-pack the structure as part of a bug
> fix is a bit misguided, though.

Well, now it's done, so let's not change it even *more*, when a
one-liner should fix it.

I do agree that clearly the original fix was clearly buggy, but unless
it's reverted entirely I'd rather go for "minimal one-liner fix on top
of buggy fix", particularly since the end result is then better...

             Linus

