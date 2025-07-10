Return-Path: <linux-kernel+bounces-725369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C7AFFE1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E0B1C2745C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB529ACDE;
	Thu, 10 Jul 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgvOxpii"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770829615C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139761; cv=none; b=VcUQWs40TxmjDKhsew7nfwRVGVNq/+4s/Bco/mJ3wRqful1wF8yRkQoCVRV5Jb1u9H8fzAKDFSRhXX9dS5tk9W8vquggwOC24mNsyJ9pzkPq0d3djSEYR9yHgh+Y71Q9rX/uS194WNDr01W/1mdOic7xABTcV42f57xVsX22Ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139761; c=relaxed/simple;
	bh=Mj99t2+T5CZ3bj3evKUWmV1TWs6ZU+OLZkjlOnmUkbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsZVUKaX21Zcgmb0hGKkzBvXKvjMGS3sMOFKeROhG+A79R5uIRDxNhxZwYHBnRaznP6tuDi7R8AnwSL251RXwoS40rxkW1vDatrU/q1eskQQxVZccitDwTDHo+rkR5HuXNx72WdW0HO6wD5VIK3ITNshIFxKPGet8qvFAlVaS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgvOxpii; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752139757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4m236VTKUqnXMtDNLsgzoIjZNCKdFD8CALQosO/eFs=;
	b=IgvOxpiiV0Gt6jPSSWrpJzFayddHxntx4g1wF2YRyOpSUxCkDpbXtVzsOLS2ddiDYqI4hd
	0xlOZgvsztI94TfgDuc1E4mKcGJtQKcpFB5tBpvjPXrP/o8YPn5ur26+9xUYM4XyIQX53E
	GAQXBsyvCJm4dBDx82Iti2StmyTcNNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-NoYoMvbYMfKq8E2dq-Pw6Q-1; Thu, 10 Jul 2025 05:29:16 -0400
X-MC-Unique: NoYoMvbYMfKq8E2dq-Pw6Q-1
X-Mimecast-MFC-AGG-ID: NoYoMvbYMfKq8E2dq-Pw6Q_1752139755
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d1fso4829425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139755; x=1752744555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4m236VTKUqnXMtDNLsgzoIjZNCKdFD8CALQosO/eFs=;
        b=ZyTlCAKSWQN7orpvCRfxhi54m/ATMvpXBTsqFvuQu4VSmMV5NwLJsTVOpG26cqmNKE
         /NeoAyxa6uK+Cz+9kT57CPzp/LZ/hm+3zfE0ICxoUMX4LQFyo0M8eBSYaE7WOS2m2zsM
         xOh4mpqNFEV04uznIyoKBqVo4ggk1ag0OblXAA0Icajwdx6vRbAHAoFO5iycpNHtRbEA
         Wm2r/epSTHEGNdcBunFfm2bjOe2wAcylTBNkB8ay/y4gaUhVvIuY8JJ3T226FJlVP8O/
         GICB5kK+2EnGpcjdFlLCbiEnEchUMcS5lWpJCLPZHtAbP88wty4NVg44Ok13epkQi2j1
         MWAw==
X-Forwarded-Encrypted: i=1; AJvYcCW++E391un4Ew3OIbwUEeSgIxZuEls1aSp5DbWuf5EmRkQLnTzXi02rBR1pBHgSf0gIX1aq/NFeZVCuNHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5F00WJZW4JXFp7VjtrDcgCaQ+Qb893twpyZ5hME0zcW8T+LP
	Nu09sFNs1r/LwWyT9XBgHcc6nfc71E/RXPsLpxvJr1ag0vfL36JZzM4wxmeZGyIq0BeEp0nqFAi
	XPoQcxs4Z5z8yK9/lRZae/xdW/Vvo7ucOHDIVXm53lR7TWqxuK3l7iSb1YALsZvOWBw==
X-Gm-Gg: ASbGncsfWLa+i3yerXUZzj+0sHEryFaPHErOwr8BepmSCuIpEZqWYDJQ+j+KXCvn+ya
	HPN3dEl7NCtgf724YAaXhAT6hqBpGlfo4mcT7Spcdzx4eO/Gr7KoqQ4PKwfS47hqWrYb7xMR+Yc
	Ej37n16riMnguXtotp0spkYAA6dqDfI3KXFbTq5mx/UTj3QIlM1pw7GjN0lYigWE3yy5GhGYe72
	JcIZf1N9OAfO8M5wKJ4JAw9hterDrA+57HvRKGxpC8/L85mtN3uosPjp/fpg8YqfTNb/+ut2slT
	PdA7MA27wTjN4b7/4b7wkNbcJSF043nIQD41CKcRHM/96lBVk+/VlaTx5/xsUdqPkVbFtA==
X-Received: by 2002:a05:600c:3b0f:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-454dd2f1fffmr16819895e9.23.1752139755352;
        Thu, 10 Jul 2025 02:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeNP7uDlPMS6NgOJ1XCVdaAcNbvsnjWShUEJ83Ozrbbnu/dt4Dbj65YDVdrx36XLOJWleHxA==
X-Received: by 2002:a05:600c:3b0f:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-454dd2f1fffmr16819595e9.23.1752139754868;
        Thu, 10 Jul 2025 02:29:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50dcc84sm55548135e9.24.2025.07.10.02.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:29:14 -0700 (PDT)
Message-ID: <fe811639-7775-4666-b678-58f8a47b65ed@redhat.com>
Date: Thu, 10 Jul 2025 11:29:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] af_key: Add check for the return value of
 pfkey_sadb2xfrm_user_sec_ctx()
To: Haoxiang Li <haoxiang_li2024@163.com>, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707160503.2834390-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250707160503.2834390-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 6:05 PM, Haoxiang Li wrote:
> Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
> in pfkey_compile_policy(), and set proper error flag.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Set error flag '*dir' properly.
> - Hi, Steffen! I know that inside pfkey_sadb2xfrm_user_sec_ctx(), null
> value check has been done. This patch does the null value check after
> pfkey_sadb2xfrm_user_sec_ctx() being called in pfkey_compile_policy().
> Also, set proper error flag if pfkey_sadb2xfrm_user_sec_ctx() returns
> null. This patch code is similar to [1]. Thanks, Steffen!
> 
> [1]https://github.com/torvalds/linux/blob/master/net/key/af_key.c#L2404
> ---
>  net/key/af_key.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index efc2a91f4c48..9cd14a31a427 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3335,6 +3335,11 @@ static struct xfrm_policy *pfkey_compile_policy(struct sock *sk, int opt,
>  		if ((*dir = verify_sec_ctx_len(p)))
>  			goto out;
>  		uctx = pfkey_sadb2xfrm_user_sec_ctx(sec_ctx, GFP_ATOMIC);
> +		if (!uctx) {
> +			*dir = -ENOMEM;
> +			goto out;
> +		}
> +
>  		*dir = security_xfrm_policy_alloc(&xp->security, uctx, GFP_ATOMIC);

AFAICS security_xfrm_policy_alloc() handle safely 'uctx' arguments ...

>  		kfree(uctx);

... and kfree, too.

This patch looks not needed.

/P


