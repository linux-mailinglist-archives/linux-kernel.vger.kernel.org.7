Return-Path: <linux-kernel+bounces-881904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77976C292FB
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14BA94E8206
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748E23C512;
	Sun,  2 Nov 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKQf2pza"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCF27FB3E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102674; cv=none; b=MLrtaBG8oOJDiA/oT9HzA/BUAPi228RD9WBig1Am3fjoKtwMA+DZ/iIW3shr4dB0OyMjJH0iV0knuzN4teQcmPYo99vxXUdbSHaPcQWKChqeALUug62kFcDXnz0RM5vTs2dTRi0pEI9BnTUDC1XZY4JEsqLouGR8rcyouSE9zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102674; c=relaxed/simple;
	bh=44gtkMW0Y5fHAxSuT7zx/bDNNWTD3TCb+siM2PYxxOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXkmkIkKbl37bjzZfScychqO8kwqCNDumz8IR1DX+oAhlRjufEqT5za9BzCwn8/OGLTWLH59ilwzEuohJ73T7mY8HlPGrNnz4l71EsMc9otHkft8BjeZinoiGxOkM2esv4bOOXyD7PKfhH1ziry0RskRPCgTpRNBAzZNV+u9QQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKQf2pza; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b50206773adso856411666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762102670; x=1762707470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D/2LxIRqPaEFpcJY4xTpfZFJoJ4QwYTL33/bGyG1rc=;
        b=XKQf2pza5NCpdHKRJMXLuqUN5FM26NkNtMwBC2Nyw215F+XU09YN+5HmGpcT+dA8hn
         OtnLjWGaUfZGqVHrv7Q2JTiqasUQ7Awjrr9aSlz2B+pR9bFlQ23YNncvPMh+ivPK+2nX
         /loWquituOdo/uanmvIWmJ4qSQXARIIuyzsGTmFeclXN7RGa/6y5P218nXJOlFUAMiMr
         ppJTJ5c9LdCBxoES03sTCyJh/wRWb83V3TbzIzW+9wSu1/Rqlk9G7kMebT7tOuhXvS9B
         VuRzK/7f0tzRGJaoni47BuyHATcPtzTqB0CzesoFdPpsloRkmz7qg76Hm1oAB46Nsw5U
         Cs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762102670; x=1762707470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D/2LxIRqPaEFpcJY4xTpfZFJoJ4QwYTL33/bGyG1rc=;
        b=a8st21ssYvS/iZesgG63Y0lrg+V4bS4buWpNQRT5buZrsvejIFE40nWiNHkDulteI7
         sCK+iqXKiRu9lMpH7bwRrV7HcQwaTnFCuHxU7yNW6vRIFSVaQmalvxSIGzZ9eNUjei5W
         hgIIDSVgAQjEGmTbd+NVu/Rv8cf2EVJe8Sv3MwQrDCTFcR5obXyTZqtCRmJtU0HRZs47
         HzPuNXvBD4GJeFT6U63FjnDrNxglozX6FwMk4NVJjWbg8utnfZsM9/xb60bf8+Vq52il
         t2snHOpVYOCrRPlbRSIkjxju/hgZniOg4SCdEaiVAMUYKjx089McaXte3fbX7rZG+tZR
         WHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk2KkPmyFMYDVDCwnP3msVN1cemrqV6NgzxGrMf6JS+4Vymqn/PrUk0oGDAu95ZtGyzmNkQNijLngYciw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEM39u0t1eMUREKlxgU+gam2Hc9p1TCyfE6Yy4jGFQTBd8XgtD
	c18QbdI8ndGfe9opsx/7xmk5JftPC4c9jOWZkjWH7KDKucaR66ThgNQ0BCCpSmBzC9/HzKmUDim
	8AeSQSWj5O+G99pmPBvDVzI8AhRs1gzg=
X-Gm-Gg: ASbGncvyJu61TMZVo5oDOXZZ2k5xe3qgV59Rk69WxOtlPuzdon7V1zIMfGOsUFOm7H0
	1+k+Zb6rqYAAHwg3r9TLBuXw9tkI8hIvPbuyKTU/2PBCbtvoWjtYS9TfrjCC08s88ZshojHxHFU
	0j0JQZAb2Js5QDYVYogOLGnPfdpP6UsoLQ3xhDiTDmOd/0N9XUy5QY4/GcNIH009MFZ27ypouYG
	T+LFsXHyToEvXN/H4+g5l35ZUWLtUwFKlG1f+CA6fDMSmis2ytCp7UYcQtA7D2F
X-Google-Smtp-Source: AGHT+IF6kTS+BPq+5g0QzVhd4H7jJGaDHe33YwK8YfXloE6tTgIk87zoSHroCKmGlQ8/BJmiGW2LNXgDUOPRTx4dCUw=
X-Received: by 2002:a17:907:3f89:b0:b6d:671d:8814 with SMTP id
 a640c23a62f3a-b706e5823f5mr1057229866b.27.1762102670334; Sun, 02 Nov 2025
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
In-Reply-To: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 3 Nov 2025 00:57:13 +0800
X-Gm-Features: AWmQ_bkaoXNCTN1n6otnUWB6pWjlguUIqX3xJfiZv2IxdZsnRJDYnUHIqQ415CA
Message-ID: <CAMgjq7AaPEAWF64qQ7mbcvoV18R2h19yuuw7AjWYyS6eWanw_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Chris and Kairui as the swap maintainer
To: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 11:39=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> We have been collaborating on a systematic effort to clean up and improve
> the Linux swap system, and might as well take responsibility for it.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2628431dcdfe..8b5af318a0c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16497,12 +16497,12 @@ F:    mm/secretmem.c
>
>  MEMORY MANAGEMENT - SWAP
>  M:     Andrew Morton <akpm@linux-foundation.org>
> +M:     Chris Li <chrisl@kernel.org>
> +M:     Kairui Song <kasong@tencent.com>
>  R:     Kemeng Shi <shikemeng@huaweicloud.com>
> -R:     Kairui Song <kasong@tencent.com>
>  R:     Nhat Pham <nphamcs@gmail.com>
>  R:     Baoquan He <bhe@redhat.com>
>  R:     Barry Song <baohua@kernel.org>
> -R:     Chris Li <chrisl@kernel.org>
>  L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     Documentation/mm/swap-table.rst

Chris has been very helpful and insightful, I'm glad we're working
together to improve SWAP.

Acked-by: Kairui Song <kasong@tencent.com>

