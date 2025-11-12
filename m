Return-Path: <linux-kernel+bounces-896739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA428C5117C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778473B5AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7B2EF66E;
	Wed, 12 Nov 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM9vSWei"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B82D6E42
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935869; cv=none; b=OIIKfDcSJrGrgtS6b20UcJUdv9Cqu/3G6QImsuWCF25dytnALPAAQzqMJCmT+1lbAOWu6Crcz6lqWe25SyA4NR8nGixGbFwa3iOIcVRIp6exz6qZLnYzkE/qZvMeBgeA4FrUhWzdhCH81jiAh8MaMEPpt4g/XNdZ4bq5J2QI0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935869; c=relaxed/simple;
	bh=2hGy/y6GWB/3BVQmLh5g5L9C42SPXeblpDpl9ztl84E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRAUoN6BfFhmbgRTZoadf25WyHOZVkygzN8eQMk6clzQNvplGXrvB523AZLksLrlJ6qDf6Hs20nTqgb/5n4r7KLRCcSFrup+W05PAAVyyjWg7gXbtuUX/cEfpeM29acWQLG/y6QQBj88eHkKHgZAkvaU7Ja9IMpchoVkLMTELuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM9vSWei; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so461771a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762935866; x=1763540666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC0+9MNDnzyNqzZubxOrLmRyJcdQ84zI5Y3RJeI7EeU=;
        b=eM9vSWei4oqgOzZiSvBfpHCLKHwSzx3DPzOmx3fgnjwivuhHiTgvJzq9irC6mqjWsS
         ucWDb47qSccc8/eT+OU/rDId5/YqueFl7C9hvWNRnFUdSwiiPueRxiPvCbBV6UpdBomk
         DPnM2vJ+CFiCwp1asUScCI0vV2g98iA2DXRBi6VqusTSDpfdsV0RCSFn77j7Ysj9RadQ
         mVESYuQl+vypUNiBFAyUS4FppVI3PpLdrUeifKriADlzLwkskj9kwYRB7YmDQRn/agE4
         Hg3bD3KeMAe6OsE3y+gthEnoAh/+C3KAFoV2KY4VE0r8QvQwz4PHaOVnwiDvQCkA5e77
         3fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762935866; x=1763540666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eC0+9MNDnzyNqzZubxOrLmRyJcdQ84zI5Y3RJeI7EeU=;
        b=DukimaRgOBlL5/SNOMhBW1iRcYyahrzyBtIBpp4k6Si7ylOCRV+mfu9c4cNznqdQkC
         i4a2MOuy4HsmfLjUnxP+K5nVtPBVRmQEWAAXLSg4FlB3pBCw/0YzlCCk+PWXqcSsXp0V
         woh+vny3qnI5rR0Ib7JvCWq/uBcHV4ZCDVIs5dYXXGQ+b5d5JWadJllLvku9hyEUanN2
         WWCqXvHCdYcA/PXFNVfjeDmxhm6ggo+Hz1Sl2jMPnh+7Uik0sI24tBWL4sHa6mvY6cgH
         xHMxyVXYyQbMFsFVB9HXSyNrlWmU7KmLfNRoW/AojsQVLnl5aMvvuWeO0ND8Mxqy62ZY
         Cjug==
X-Forwarded-Encrypted: i=1; AJvYcCVWt73Hq/hS7DMUvEbOkJM49JDzQ2oZccfZHA9woulIgvZkU9Y4421sG94R91/fzQRhTz+X6xJLPQxPvnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//+0YUJgfbf3S/ufLuahIaqeioTkAlLKTn5DNd0B14BZ8M0fx
	2c62e+NhMhe2eRYc46fGtVyG60l0qkV19qr9xjSk0GH3G0V6oheRoivBkynApwbCZDyuYbBvTe5
	JPdwKpRlKtr4PUhUzPAGhFPm7G8KxHLk=
X-Gm-Gg: ASbGncuhyZhp9IGNt4v5jpMEr+niSN5Oxd8ssOAON2ueXSToZPpluTXizjHyEpKULJS
	PSu4OnvZy5gGL2IxnFrORSdO0dxdj1G4D7qYZD8zc8t9q92MV9qt/6mTQl8yELDHne7DmqSjwoL
	+dH6eFpT87aXER+12Co8kYFCrR+5mw86d+jBiMUQPQgZ9ZHsI1+Yee5ds3U8bQkEKfdAu99FlF0
	5NSiMfHTCqCtAQ3ok1JKxBethBXxNAfvDcOoytILyqDODKPu/tIseldYONWBJtbq+QHDK44vF3q
	bR9Afh6XwsspNQ==
X-Google-Smtp-Source: AGHT+IH7g8AFP4FtAEniY6ui43Str9+Uk6vm5CFl/wqcfSOCHCFtpi/5pcVqWUwvGBHrOQm3LUnrVrAR00nZm8WGYoI=
X-Received: by 2002:a05:6808:3098:b0:450:2db2:72b1 with SMTP id
 5614622812f47-450745ba573mr935265b6e.46.1762935866595; Wed, 12 Nov 2025
 00:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111121337.1063443-1-me@linux.beauty> <20251111121337.1063443-4-me@linux.beauty>
In-Reply-To: <20251111121337.1063443-4-me@linux.beauty>
From: Zheng Gu <cengku@gmail.com>
Date: Wed, 12 Nov 2025 16:24:14 +0800
X-Gm-Features: AWmQ_bn_tpjynKvZXxIV4vbHcHa64h6cS4Z1tKzR2jhZzSlOa4zu3oRwBeQfppM
Message-ID: <CADSj-VoEF63HPCp5Uip2u94OVgkjbH+SZP6DP-JpCo7tRa6jvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dm-pcache: zero cache_info before default init
To: Li Chen <me@linux.beauty>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dongsheng Yang <dongsheng.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 8:14=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
>
> From: Li Chen <chenl311@chinatelecom.cn>
>
> pcache_meta_find_latest() leaves whatever it last copied into the
> caller=E2=80=99s buffer even when it returns NULL. For cache_info_init(),
> that meant cache->cache_info could still contain CRC-bad garbage when
> no valid metadata exists, leading later initialization paths to read
> bogus flags.
>
> Explicitly memset cache->cache_info in cache_info_init_default()
> so new-cache paths start from a clean slate. The default sequence
> number assignment becomes redundant with this reset, so it drops out.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  drivers/md/dm-pcache/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
> index d516d4904227..698697a7a73c 100644
> --- a/drivers/md/dm-pcache/cache.c
> +++ b/drivers/md/dm-pcache/cache.c
> @@ -181,7 +181,7 @@ static void cache_info_init_default(struct pcache_cac=
he *cache)
>  {
>         struct pcache_cache_info *cache_info =3D &cache->cache_info;
>
> -       cache_info->header.seq =3D 0;
> +       memset(cache_info, 0, sizeof(*cache_info));
>         cache_info->n_segs =3D cache->cache_dev->seg_num;
>         cache_info_set_gc_percent(cache_info, PCACHE_CACHE_GC_PERCENT_DEF=
AULT);
>  }
> --
> 2.51.0
>
It looks good to me.

Reviewed-by:  Zheng Gu <cengku@gmail.com>

