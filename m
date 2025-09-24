Return-Path: <linux-kernel+bounces-831207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA0B9BD85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C24E425998
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A0C328575;
	Wed, 24 Sep 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfPJE5UZ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508C322DBB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745271; cv=none; b=Ssk6YVR9jgX7k3KMqLSbcb0GALmYwu79sgL7vMcEoE6okNx3c0/qOlvgg94WlCzecOzzJ2T5C9edXnwDI14FCJu7SqZ4kvXjjrc/gaD2jV71k2RmJYKdy08U+S6oLgMjK/mO9XEtQYtb4kjfdm6PNhN8/8lvpeGBBX6ylhNNtq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745271; c=relaxed/simple;
	bh=i4tepmVLJF01K2/9GNZdWtMm6Bdzo/yVQxDSsWRN+Jg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qf46qxf2waud/h/d3T2hW4SE/uowjXLgbXWufu01VP7Di+O/w5SCw0q4bQidCkOyn6EqWILqgIQ8lBfnPFH68yPavoUlWHQaUlptjv9ZDdkYuioIMPy9QTJnhvIY0eloxjTnrho6U7+cnMfdHPx0kz1s8z0He0zaC1ynnN/w6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfPJE5UZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f15d5846dso1961156d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745269; x=1759350069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=CfPJE5UZ0/qSDB1EhduAsLKwdjWvTYSjaio8Opmyd18r/+jw0e697R+mz90h83AZjo
         SRLJtuFHbewoUXxeViJhRLmeA+NHziVTsr2ZQ+7Wai81y37sJUEvN7GRyHo2BhOHUWEs
         FgR4mBkMTUtvENcQCYI8pNQOYUjVKm3rUkK0O88URS5YzecZ9CFvMCIcuyBK9Z0F1gq1
         5MU+k2xXerYvD3rSZ6FynmeSL8vQqP4NhkIEVs/GWrsAdmxg9Pe9H7s6uTfKga9FdyTh
         CTnM3LoFed1pSb9McS94N3j8OW39LabAGRSILM9Z8c6koyJ0M3PByN20hUeq5ZhP1lB9
         P2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745269; x=1759350069;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=P01XmyfKQljeINjf7GeqHqRkG3tJPl16MyRV/BeRlUb9hpPaRdN3TinaSwcs2Ql8Sy
         pxPSWowClO7o8F9TzJCK95Q4Kf+awcaPXgYvEHmmaqELh1U0NKPgNgCbKRw2/Q4oAZhz
         eZz97pQlhOcAGKPuLgbUOBWgF7xB1knTzgiPQ5cB1D7oXxtjhrWOTfZmL9G1nzWn/EKd
         kMmJAlGryjlvSlJGBNaHio3X2vnBKUdpWnOEHtB6BJkm6uYi3eXL2NLC7fiQsFoo/5y9
         zUXKEZz7kGfuoDq6ungTuFNJbDoV1WdH4Kc6+158/d3bhOqmuyDn9MM1EzBfRkHWNc9G
         iKCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBkcgtRqZ7fI/Ksa0Impz5mhEMFqu181FrgDk/QvPPgM36IQtRRn/jP/whr43IwPTsQPx0jXpul5YN5xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycm2mtXvM+rluccw27JibDFcpu01sBHr1P+7+HpG71SrgRJP2N
	Wn/zFACpHzis/6uUhsr9eHKM+xRGPSsjpiiV+fmI/RirW6yD0GiifYr/
X-Gm-Gg: ASbGncs/NG1vvgd3JCpfdhwNZNcD8vFgJfsQnaX2Tr2W0DsS6mYQ0dRQvQfYk7l+tvz
	pJh4YPAQhcef0t8ZTKDVcFbVKTLT0DozrCfh/1Z3kY2dsrGhOu5c0fQ/fMUHY03gzKzR6MjbW3I
	szSGVO5kAqVlyl6GjjUkKprK+76cirX9UJPIYYhQZS1Q9IQkg+c1Y2s3GFV6r2H915uiPi915Mt
	nCrmXV2icIDGiG9OltOZh08EqP/MGPMBDfzfb2lby+vfKntCarw8JkcspA1T/d2lxzbG5S5eJed
	TeBX/zyNIzO/SDc+QIxMBsRRWN5A4H+NoDA8wY7NbXpKZFLO0VvzrVTMxQv8uSR/1U6Q4wYz6JC
	/VamEPUa0mjwMaEI+bpQbjQgMFsB1mBFAIsWKFSmFKbTbPCuOHAWRnBgRbk0JdMqoOrNMYGMQjm
	JCSdyv
X-Google-Smtp-Source: AGHT+IFibZxWZirLt9Olg9HUXAjXOqN7fGVG5ACXJFneXFmMLHtLcJNCl/n29OHLI2egwWYfcrXagw==
X-Received: by 2002:a05:6214:5295:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-7fc443d9de1mr18600436d6.63.1758745268685;
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-800fa5f6dd7sm733946d6.0.2025.09.24.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:21:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wake Liu <wakel@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, 
 Wake Liu <wakel@google.com>
Message-ID: <willemdebruijn.kernel.2b5618e3b2d34@gmail.com>
In-Reply-To: <20250924044142.540162-1-wakel@google.com>
References: <20250924044142.540162-1-wakel@google.com>
Subject: Re: [PATCH] Net: psock_tpacket: Fix null argument warning in walk_tx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net-next]

Wake Liu wrote:
> The sendto() call in walk_tx() was passing NULL as the buffer argument,
> which can trigger a -Wnonnull warning with some compilers.
> 
> Although the size is 0 and no data is actually sent, passing a null
> pointer is technically incorrect.
> 
> This commit changes NULL to an empty string literal ("") to satisfy the
> non-null argument requirement and fix the compiler warning.

Which library defines this argument as nonnull?

I'm not aware of this restriction in the POSIX standard.
This pattern is quite common.

> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  tools/testing/selftests/net/psock_tpacket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
> index 221270cee3ea..0c24adbb292e 100644
> --- a/tools/testing/selftests/net/psock_tpacket.c
> +++ b/tools/testing/selftests/net/psock_tpacket.c
> @@ -470,7 +470,7 @@ static void walk_tx(int sock, struct ring *ring)
>  
>  	bug_on(total_packets != 0);
>  
> -	ret = sendto(sock, NULL, 0, 0, NULL, 0);
> +	ret = sendto(sock, "", 0, 0, NULL, 0);
>  	if (ret == -1) {
>  		perror("sendto");
>  		exit(1);
> -- 
> 2.51.0.534.gc79095c0ca-goog
> 



