Return-Path: <linux-kernel+bounces-852786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91DCBD9EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27757543842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F86315D25;
	Tue, 14 Oct 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HINIdKOO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B62ECD05
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450891; cv=none; b=mgW/gMc1pLag5oDOFqSrGlqRW8u3ehSZ6yAMV7yI/LwTtmDy4XL2aFC92Go2Y/nf5hHZe6KQ3WYbP9NvPj+pTsuKpbN0xpyNwE/poq1IuBR1lUtcDMZvbEg4gJ6qvJeuoNlnS949DPTzgKodBeabFNpRcPcUTdjMXP7NAcDl7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450891; c=relaxed/simple;
	bh=n7R4IggRMS2QWBufKXlW4yIiJgS8ECJudvpdIBUSECc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRIp25/hrMdH2p9P/GSwV/R5DveAYPB+q8nuSjGIDpt69+fIoVsbQ98mAITvlAJ5JW0iNrOXSM2htEvt3oFO3PMrJ5vGkjW4hrUsgB9Fw/7sQMIXEIWJ05BeoYarK+9ZE39ojCgTbIXOkptmgh4TagzLSAixiDGpv9Yt0Iaxt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HINIdKOO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so10673225a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760450888; x=1761055688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxmeIWwCO+DcngB6umPUO6fAm2SQ1pPxfxXmVq4hIfA=;
        b=HINIdKOOY33PkiZDjSl6H+xlz2+rQ8lRBI6ACLxbWwv8/BrGmsmgQltebAMRhWpHGe
         KnSB/pbQZpbsIAF/1LD0+U4sRuFG644ku98PV5QBVYoDojHKLfk5Iku7kGTfkfk0JW4L
         DbmRLl+gN7S4lxs8iRtR6CDvJVriBBYod5omk2HHJ+zqD6aGcGwixhAPppH3TRM63wm3
         z5/GAN+fLXCD+fhpwUy0VkbkGhsGtumg9rMXQOR70H0RzIgyGL2tTHTT7O0tFPd+4CbY
         m3pHhmx7+atPkS0xuzddiXb9l0nE78yugEmvY5kWyuBsfw1rk4bgG6Do0z6cY8gA9iVL
         0y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450888; x=1761055688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxmeIWwCO+DcngB6umPUO6fAm2SQ1pPxfxXmVq4hIfA=;
        b=a60ts3IcRtIBIDJQcSdrWDKsnlyubfFK5VvKenFtEZE22J7YsASgCYFNpbUVxGt2u9
         d1yMp4vM/LP5e5DzCYvPqQEYWbYBTFoX1Ft/jqItAJbkAdXZoCGJAuLRbV3D//NeWboc
         F8sU5QdvaxSXWZ2CcKsCo5SBhjDMWKB6NeZT14DjgCpo9ZhZ5+qQWA5I8hVUHttZNWFt
         tQdLKxkqr6WCH12h1ORc3QWE2UpJoTNmXQR8nM7zbtKje1h5Y0BUdiGUcb+LRsAtbzKL
         QQxXzCv7y1D/htyGo2dE92eUrQgF0j3FhhjGhuXurSwuiCZvayWKXOiXTQI6lvYWx3Zc
         i63w==
X-Forwarded-Encrypted: i=1; AJvYcCWRHVI81RAp0P9CTXDXs3mVzG7jm5zWi6V63zWKEPiYFNYGw8a/1Ck59z8l6pmLnOVQx3pOsz4tGolmSoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ijnh9uYSKgbLd2uXuQjlp8zmgeYF9hQX36DzY2AWRLzsltDG
	i6ajZz5PUC87wxjGQ5v9MbyJpblW16XMV9DZ0OXRXzuralZgU30o8EpH
X-Gm-Gg: ASbGncuPiMcVNvgEXTEizE0QTU+ZW20sQzuMlGyGvThKHJWUVv5k76wHLt9Ioi2h74m
	u1wckCx+ieBCdWiChyqv3Le+4J0T7zhboT/WsLTNe6X6vQKpEpEF52/vLNRMyz1TGu41QzlGukj
	oBgy43048JOPDp0NTzkI4hEroBgk/LbSLnrJl9sW77imVXv6dmYu60TbcmJX1jT2KfOJ8jSkD6w
	4FoAYU0/cA1FQEN7/+Vjp8BlpOJ8xbOsFsyyuJsv1cTme44ruiBHCwE397sh3LTV5f4l10IbwhD
	hKNMOFt30w7at/fA5/yrWlw/eCWgVIAlnihEoRDwpLC0Vf8yejVyZd5L0GIkghaRDNBK8aUP7Tk
	x8hDpb+C8nnj4A8WNo9bBjCwLbqu2rJyRU4RWx+pE5QdKSPFwnO76MJw=
X-Google-Smtp-Source: AGHT+IEf3qv2wBAqdGd7LLNTogx5CIdl+mKJKNQg4yODTXzc7y9Gqv2epyMUaFIiqHtW+W3ofsjlrQ==
X-Received: by 2002:a17:907:96a7:b0:b40:b6a9:f6f9 with SMTP id a640c23a62f3a-b50aa8a847emr2748899766b.19.1760450887527;
        Tue, 14 Oct 2025 07:08:07 -0700 (PDT)
Received: from krava ([2a00:102a:5031:2444:abe8:833e:114a:fe50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5c78c15decsm7838366b.50.2025.10.14.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:08:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 16:08:03 +0200
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/1] bpf: test_run: fix ctx leak in
 bpf_prog_test_run_xdp error path
Message-ID: <aO5ZQ9Kgd35nWNod@krava>
References: <20251014120037.1981316-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120037.1981316-1-shardulsb08@gmail.com>

On Tue, Oct 14, 2025 at 05:30:37PM +0530, Shardul Bankar wrote:
> Fix a memory leak in bpf_prog_test_run_xdp() where the context buffer
> allocated by bpf_ctx_init() is not freed when the function returns early
> due to a data size check.
> 
> On the failing path:
>   ctx = bpf_ctx_init(...);
>   if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
>       return -EINVAL;
> 
> The early return bypasses the cleanup label that kfree()s ctx, leading to a
> leak detectable by kmemleak under fuzzing. Change the return to jump to the
> existing free_ctx label.
> 
> Fixes: fe9544ed1a2e ("bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN")
> Reported-by: BPF Runtime Fuzzer (BRF)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  net/bpf/test_run.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..1782e83de2cb 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1269,7 +1269,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		goto free_ctx;
>  
>  	if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
> -		return -EINVAL;
> +		goto free_ctx;
>  
>  	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
>  	if (IS_ERR(data)) {
> -- 
> 2.34.1
> 

