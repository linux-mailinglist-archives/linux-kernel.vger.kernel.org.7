Return-Path: <linux-kernel+bounces-890306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B4C3FC25
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7141883903
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92630BB9A;
	Fri,  7 Nov 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF//1vcs"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBD31D749
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515696; cv=none; b=AfGIrsv3LH/sQ+uBtS1gfaUingvXPZIH3y6Za3pkeXlyeU9zLkNTX+OqoyKA79rM++TJvH1LDKO9uxOed3fwrv2MjUa/y+/lXQNUnSqUWVHQymzAb6+dpAaiDVu6X8vCRRVOsfQpHKMHarlyum3ZfNvK9LaASk3VWt2xucngn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515696; c=relaxed/simple;
	bh=67O0HM6LgZ57wI3RHX22DyqBmRYudasdbXg/4Zmqlvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtM9ag8K+wBg0kn8iZgXLJt8PtPYuC1LdhXjDU82/mS7Ipgag4BPEwvVn5HDKNgOlhcj1NbZbCgvhKjnEgb6PEl3HJl+3ZC/waLfyb+J45L0Wv0g8o0bnobtYyP4phVxPIqJCvqfc2kSpptOvy5vD/+W8QgcOmXzj5swKRutJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF//1vcs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775895d69cso3142845e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515690; x=1763120490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbIyLdjACXlDwnRSKcJQKOcA3uAX0B3KEyjgAmsMwwY=;
        b=DF//1vcs9RgkCYaYA1vmxFOfcxodUX7AgmJ4wMGQOMSzvi4ZJ+jrvoeiNPe1n+7OYv
         H0EoZ6CdRhOyFe1B5YaFLaArkP6CCVBWV4lrz6P8JDeXHS6FK+hSRRTl0cyk2LjLSDjv
         IyLwZE0ZbmWeg6Dqaf9xoHgPpfZm0yIQEVv5EnxjeIMqMcVDI3LOY3nWYURtI1OR3aga
         NSHzkopQXCN7YDuH2beZwAgEajlsqt1jF/nSQs1SgxMCrnKhWH1I+T+iXX4kh+XpsEbw
         zmCk6D9P8uvbGuPKk/TKPEnaufeXlMKUUDLDgnGKJgUpiAUffy9IUwWg9vt+Y4UcbFNp
         oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515690; x=1763120490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbIyLdjACXlDwnRSKcJQKOcA3uAX0B3KEyjgAmsMwwY=;
        b=ns7OXnwjOC8yScUK25LqGdxUDJaW9Z735tvY68nnnEG1A/MKh2biOIIik7fCHNy5MF
         jWl4h395q6AAmAMxF7Oz4iMiFpNR0QQW94R+M+vMdTPQY54TsoFO4hmrz9WRXBqLnBji
         RdR5hfaehBB30RJSJLTNdx1J5Kk1jpZKulubXxfXcovahnvsNqXzDWYs4sOzuD5RUpiz
         VZwZkpmagHkxAJgsIyrp/jnbQHmUAFPpu+aIDnAEqGUP4U1+y16sjDavgMton/y+XG9w
         UTprtUilJLExHyUFEINgZU4bR3Ny/f456Xp0+/eyss5IlFNqGlBmoEF+XlnsWBl0wZYm
         xGVA==
X-Forwarded-Encrypted: i=1; AJvYcCUzpRtzbOtN9T8wBYwTiZvHqa4naZZ+435o7Nj0VblYZa74027eo2CHJaGttR5o2lHu9RUBGp4+8jkMcOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vDEuupJeEvE4s5odWUmf4DZeK2nh4OHEaibvbZEW5LEQ2QSO
	L6NIMrgDsmiHlYfCiFk2nNVu+KSFf0uNuQa2yUTUYRwVKwipuVYT5bEt
X-Gm-Gg: ASbGncumS7Pa372zmC/4oWLVDVngZ+INQYjJCi0xmkTenqvHjPD/lMaavBvrvscSgHZ
	p7aRV6FDa1Tkp038tlW2VHYNG8GKoGE4WMPqzo7QLDaMe2zRXfzpVdgTH8CYawtAhKOx4zOShF4
	wppBs0nf/riVqeR1CUc8+0cahB/HOq1yyYr09jDkuS4HT/Lt9b4litTFJQfMFAw2p61J8FedwlW
	7Oovus+thpZ01XQR0xeZIcxH7Xkf4hjpHT+JTC+b+1zrIjBTUIyQpri83twYwsWzno3WhFiAC7u
	y5+HaLhjMUUaJy9ElImlVZ63rVIZG71hjDuDLYiR9//kcJ4+5x7IzpWHAtNq5O//C3zrp6YAC1h
	UIpc+0JslFUXnDYI81DpCRkb4itlvZoH8SpKD7v31DX+s0oKB3U96Xo49kg06c4AMNb+JBQKYrT
	/ualzfSxflNNkkFo3EwLC/FEJLYUv0lf8M4UD+qJ/JMQ==
X-Google-Smtp-Source: AGHT+IHUAgcMk8bKJDdOhQ/v5qGlnIq+otz2YbimDj6aAcoys0jfZs+7+hhNNkCF/JH+RDCpE4irYw==
X-Received: by 2002:a05:600c:1c9a:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4776bcbf80emr31516085e9.28.1762515689819;
        Fri, 07 Nov 2025 03:41:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcdd833sm43040705e9.9.2025.11.07.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:41:29 -0800 (PST)
Date: Fri, 7 Nov 2025 11:41:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-patches@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage
 calculation
Message-ID: <20251107114127.4e130fb2@pumpkin>
In-Reply-To: <20251107100310.61478-1-a.safin@rosa.ru>
References: <20251107100310.61478-1-a.safin@rosa.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 13:03:05 +0300
Alexei Safin <a.safin@rosa.ru> wrote:

> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

That code is insane.
The size being calculated looks like a kernel memory size.
You really don't want to be allocating single structures that exceed 4GB.

	David

> 
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
> v2: Promote value_size to u64 at declaration to avoid 32-bit overflow
> in all arithmetic using this variable (suggested by Yafang Shao)
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..1f0add26ba3f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2252,7 +2252,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>  static u64 htab_map_mem_usage(const struct bpf_map *map)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> -	u32 value_size = round_up(htab->map.value_size, 8);
> +	u64 value_size = round_up(htab->map.value_size, 8);
>  	bool prealloc = htab_is_prealloc(htab);
>  	bool percpu = htab_is_percpu(htab);
>  	bool lru = htab_is_lru(htab);


