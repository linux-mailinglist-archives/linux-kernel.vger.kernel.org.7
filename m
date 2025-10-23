Return-Path: <linux-kernel+bounces-866753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B2C00918
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E195319A79DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75630ACF2;
	Thu, 23 Oct 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRObtd/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F829B8C7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216460; cv=none; b=FFirf6HOhNcbf4EO8c8hTOEoyXexA8bklBMax5abBYBsqaKI+dbNyKC9TeM8TVP8A/Gknl+mmiOfFP4QZE9S2ouEuv/JuyxDeu1chOPu9rzla0OjncIC8xWPLlizTk8nuQm0DhfbM6LzGFJn3Ok46y5ow87o1X+HDCKt5PjybUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216460; c=relaxed/simple;
	bh=5ifU/Wvg+kVhHnF9BQP9B3foPYA5Ik7jwpTbYYS73os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TABDzldih58yPfG4CjVX6XujrKTa0m2i2Q11lNQq1Non7u4KpotTTdjmd8GrwnvfW9ByzQoB9+DR02u3zVXaeD5xqj6SLLVFm7fn3izzcjSpGUXgXOQtRwQkj3/ZY7oNw/gD0G30tk34FHAv1AHeXkffq6zKOx7Bgut3zi8sIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRObtd/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
	b=IRObtd/0NbBCxcHYejm0YZe+YOvPASz/Mo/z5F1Uqq7hpZfLACWvhQ1NWPhOTPVOX5KAEp
	5BmPbtcrKhKsuuZ+UEL9BY2fsWBg5QMV2zjAdNm81RJ/Nxo+xJ42whdjFusNow6Gd8PVNi
	Q/wduR6HVHR6fCNbyIKK6H0rdHNHctw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-U9PgoCUSPbWYODGsRbSL2Q-1; Thu, 23 Oct 2025 06:47:35 -0400
X-MC-Unique: U9PgoCUSPbWYODGsRbSL2Q-1
X-Mimecast-MFC-AGG-ID: U9PgoCUSPbWYODGsRbSL2Q_1761216455
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710c04a403so5643135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216454; x=1761821254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
        b=wX7zGYEG+biaPoSJPEbh5pXiNiUYhaa+9Tie6DSn1OUOrLi29oRdn7pFpe2loU89bV
         NQ+oi/X7qCpwDJZwMvYF4r/X7ZTTscrf1I0HqLwWMol3ENPqUVETv+YRkL2BWaRkNnmd
         T1wwwtZyCDjqrqPZlMDA258+DxeNYwDNqSC9Ee7nOLMZccy+kb/4Ixdfdl22N7/7ktUO
         68wVk7sv01pA6pOWPFqV69Fvg4FQlDa70+fetoG3GzKr78L9T7CD6iDZ6nxWctGLovaB
         aLwgaOWNJxoV3UEaufr5DyIslMKHRBsciUJO9Qqbt3COtGQeORWw/CDJ2Dm8trj8YOb+
         qriQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4JIThMlVOy+hkC09MUuShyvzlxIobjmsThFW6hKzcDHYWWVtMZxT2irBNPTvNvNUrZxwWAhO+Ks8LBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeLnzATooe5WcuCeWIIgI8ds6VpLzgfNXYDDf5M/LK9XKHsXC
	TiivEWs194tNcw6di+DpI21EXM+xQ+mlm8RVgh7oy2ieVQsjI56eXhuu8KMjkOdLr9TkkX3sxJC
	SMNOYMW7ndpJk7QRxVtVhXR34Vwg6xpN0P7zdLuZ2fA1i7c79XdJo+F3tRxc/b6gJXA==
X-Gm-Gg: ASbGncsg+7+TskCH82vc+Def7cMioiE0rDW9CP19dt0ecrrBGazDQ1Lb3YFcDt93xeo
	NeKfRZQBk9cDvcmLEFrduSvIaCG5RAqn+o46cNMSXFi5H3B+ldY1llx6w+OoyP269l9rIOs9Gb3
	g9qYeMm7CKPKbNW7oBAIwXMPVnqB78TkNjq3yw1KeYPXMSnRdxafQ4rf1K5J7L5npkoQ08KeQaE
	ypalM2xf1nZU/HvXQvgnxAYjz7iTCB7fFL5vZy13mxOsrasrz1/BMrg8CtXCFVhuwHNxuAq4c5t
	IDBdXMy+0ZddwPzy6OkF4NbwScoLxuiRhGPoeZxfc6QNUtcfpu1nBkJrFkolwmrGl7qmUHhDaEB
	NczLyoWB/tJ0KewMacXMIzcs4sbqVu+2UXJ6KE7NKU9w2YDY=
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738665e9.27.1761216454581;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCjAG6BFqWGtyFJWnnSCkQuOtRF7p6tj9Xo7x9KfV4P2z7kmIFxIZPQ6J9DI6KJJoMB+iuQ==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738355e9.27.1761216454135;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm29122005e9.17.2025.10.23.03.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:47:33 -0700 (PDT)
Message-ID: <52c7bbac-da08-44d5-b1ec-315ce001b42a@redhat.com>
Date: Thu, 23 Oct 2025 12:47:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] net/l2tp: Add missing sa_family validation in
 pppol2tp_sockaddr_get_info
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-2-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> While reviewing the struct proto_ops connect() and bind() callback
> implementations, I noticed that there doesn't appear to be any
> validation that AF_PPPOX sockaddr structures actually have sa_family set
> to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
> sizes.
> 
> I don't see any way that this might actually cause problems as specific
> info fields are being populated, for which the existing size checks are
> correct, but it stood out as a missing address family check.
> 
> Add the check and return -EAFNOSUPPORT on mismatch.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  net/l2tp/l2tp_ppp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 5e12e7ce17d8..b7a9c224520f 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -535,6 +535,13 @@ struct l2tp_connect_info {
>  static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
>  				      struct l2tp_connect_info *info)
>  {
> +	const struct sockaddr_unspec *sockaddr = sa;
> +
> +	if (sa_len < offsetofend(struct sockaddr, sa_family))
> +		return -EINVAL;
> +	if (sockaddr->sa_family != AF_PPPOX)
> +		return -EAFNOSUPPORT;

I fear we can't introduce this check, as it could break existing
user-space application currently passing random data into sa_family but
still able to connect successfully.

/P


