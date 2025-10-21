Return-Path: <linux-kernel+bounces-862224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D6BF4B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20FD3BEC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAC2652A6;
	Tue, 21 Oct 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7D6Jlbp"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F00261B75
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028604; cv=none; b=Zbce8CHsBcjZC55QiW4JfW5tqHoEiug2N7zcHadkbHUUKxErYhky/4b0fGxqbOgJnHJBr4jya4SQ6KlNZuv7p+7L2lwNMyJytnF0IYW7S8fFOqQfJ5aiC3mqms7QSpSQsaEaJxQ3ves3a91BnLPrWrDDXz54pitQV03gHiLk0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028604; c=relaxed/simple;
	bh=kyn5Rp4yw5ICXF4Z0X7FZa3aS64xyYbhduM6umMTNkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwDXIOuHbX4czo+0JpcO8IkaN2G+yZ2pNkBp9ZBXyo+CmfFQtTHJUBQZI0NUvu9ZXZLplVdrU51oGWK3Rho1BiR0JL3KvBZ/Ji31s8izNv8qjHqHLZDZ5VDyz9YAddtTS5hg2snngbxeyswvbHDZBL1drCTJhU8mlecwwkmgN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7D6Jlbp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-891667bcd82so632522685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761028600; x=1761633400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32O+l2vJqfD2ZGU0fjEWAcv15lSX5YSB0Dr4CeIrQc=;
        b=E7D6JlbpG2r/JuLNPs2IFArd5VptNHYhuPxRf72EICNY8iCA7fnND2uy19rLOKo9jj
         LKDyiPs3MqOJ2pdT2doKLlHAt/FRzaPtLUBcSw1Az/mvHgl1tPxYDpv79o4epxKAlvBp
         arLZawDDs7stPeUkPLY3IEkQKLo/EX2TEpdhIhDzd2MxNBLHS9naoq+k4oiFT1/p1NST
         6LECeKm7xAnZBJ5iZjHuqTfmUch/hw9bgj1mjDX5zZkJAWYLxey845w8RCn0YfZYNt6f
         U98Av9OkO6pDjiUXTXGAx/OwJAmDa30oGeAER5efgwkIk8FJ4KQgtbF2z+26mfXOONCI
         Iq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761028600; x=1761633400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W32O+l2vJqfD2ZGU0fjEWAcv15lSX5YSB0Dr4CeIrQc=;
        b=k6R2CRgEC9OoR8DTdlep7NJLE1eKBBxmvsaeHkFKlgLsoGbBs/aUhGfbgE6jhoZ0jR
         SIk4K8sPCw8PYuvGFC1aSKpwlyHw6ifNoiHcF1Slorc3TSqzFLbyfB2A2KuC8MEqhdAP
         rA4OlWz3+Pd1iqzV9LNGfQsIQzeYdVVSmVL6JUfcSVHfc4OFugmVM0Cqu2CVOd0TIpAD
         F01xV+8FBr2Z9w0/gkQRMXzsRM7ve8WMe+n8yw/IbKqDDI6ElPWt9ivVZq/obPKn179T
         nft0r3tCPJ0UyoKI7zYyv2fMsBKikojMF5lkPzbI1BTvdl7tZSAS219ieNXhysK2ZXq8
         oQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKRkyXjsxbK9+i0ViXcYOUPEE9S7iEdAyBHA+rpOoXppeBeeTvA+kF8uKC0AeFScfT2mGDbRpyaV0olw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nub4ZiWZxVdk5xTmEQa4qTmTBeUOaQeJh/c9qSP7g285s1ZT
	F6VOVtHArC2hbGsiFiZnKbwatgWE2Yoo7Rn/yncQ16uZSKzZzMQQ7x4WcUqmpnKvQA7cw6C+lx7
	QavyHZ4nlTZMJP0HEdZEDoe1UEq4ei/Q=
X-Gm-Gg: ASbGnctJv+gUw7OXNZtlzE8Rgfz4byMSr4YDx+ywD8X3WThLuc3Cj2paLzTPx/HSWDR
	48xXYBunLLn7VZ8WAc2pbX1nfQRHTE7SdTtsudW51tUJsUhVDPOv/xt0OOumvSnz4o94o2BJreO
	qzYnpoSPvaSB1IgLA/PsAurMfUE8fnw4wkuWNc3tRC/8nt/I6YJJzNOqDLFqhC8CYJeXKhUSOhX
	TDslY9onNw79ECH7IO+GvSjjUO7aAGIrsV8zelvybdABFMX5/wUZEZmyMkkljh4QUhGMc3zIlF7
	tDqTgDoQAg8BS2jO
X-Google-Smtp-Source: AGHT+IGzysMN13W7l6tDp3CqkRCbTJGxnZaOtAfyhWLgGVJ57Old/5X6WNw81B1AEtB9QSViEoK/DD74jQz8jOrAQ/Q=
X-Received: by 2002:a05:620a:410e:b0:80a:99c3:54b8 with SMTP id
 af79cd13be357-88f0ec96321mr2297072985a.5.1761028600335; Mon, 20 Oct 2025
 23:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021011739.1468912-1-xiaqinxin@huawei.com>
In-Reply-To: <20251021011739.1468912-1-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 21 Oct 2025 19:36:29 +1300
X-Gm-Features: AS18NWBbt7F4HSqISI2QR7NNxfDIXS6cv2LNC370TsgX5QNCg4E6bRiWg1kOZqU
Message-ID: <CAGsJ_4xJq209Mxp12Z4-V=hzA4AzvJCxfsOEiEwpJD1Dp8uTCQ@mail.gmail.com>
Subject: Re: [PATCH v3] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 62674c83bde4..c1bcb4b23398 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -6,26 +6,6 @@
>  #ifndef _KERNEL_DMA_BENCHMARK_H
>  #define _KERNEL_DMA_BENCHMARK_H
>
> -#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
> -#define DMA_MAP_MAX_THREADS     1024
> -#define DMA_MAP_MAX_SECONDS     300
> -#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
> +#include <uapi/linux/map_benchmark.h>
>

Since you=E2=80=99ve moved the header file to uapi, please remove
include/linux/map_benchmark.h as all other drivers.

Thanks
Barry

