Return-Path: <linux-kernel+bounces-806642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC59B499CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D86F1BC791F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F13272813;
	Mon,  8 Sep 2025 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K0Q8b8bm"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234F266B40
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359233; cv=none; b=Lr73drkAnd6rzywLLrxUAOpqac08dv7RZ5/zMDLzIIRklrnrVq7u3S7LTN6EmRCs5kpC7qGZNmpS329HgEpSet+AmZexZfsSAPaDtNB1a44UByKzB16VvztQed0i5rb7xx/zxCsHezY1eKy7bsuQNHjLd3ZwAx2uqCbbpyZ9sM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359233; c=relaxed/simple;
	bh=vcRykPovzDO3rQ/3VtONWIdwIzbOk95su0xjh1pc+Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvp8b8zmwCKzfJhxiCO240JRMh/B4QyjHwtusYZdgWIMTwCOZsBWvPQuM/JqchK1xnbsK7gvWRPt+0f9NGI7igoN7WFG2PeA/rLe/uvlaSuxBNVtmnlP7UBne5Qaddt+Uhn7OGxD5p7npxh5jhcsNPrILLvVDXq/c7noivRqDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K0Q8b8bm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88432e60eebso137122139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757359230; x=1757964030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWzSj1FMOLdM2Nk4IZ+iJU6xUGBlgzdtZ6KrMbT+oRU=;
        b=K0Q8b8bmgYD4OQ4Mk8B9nyrCseXKo71n0dkRpkGa7tvqf/aoSj8ECJmOn2bKfamuEp
         sw8+T2mTByylldiaP4X1X1Q2yUVY8+7FwyvNkWepjxPGCX3IjJ4VMzQd1ZUjumXZx9LT
         o6636KSOBLVhxPkxyRbJamiBb7+vHVu4M08muaGmZI6H0JiS3DJtXJmXK+jwKcu4ki2+
         S4kUBj2+GG/062j3mPbzoEG3HLF7hGF+l//qsnCewvdlKT9om8w4qO6Fi8Ciiy6bzgUv
         +P0ZsX2qpr4qi1K78RR+oZy/GmbSEjsEfdDYof328Xo0weUFtoDeqwEa4otG0++lhsV4
         jeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359230; x=1757964030;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWzSj1FMOLdM2Nk4IZ+iJU6xUGBlgzdtZ6KrMbT+oRU=;
        b=s3c9MWPSyDw2FRewkx6z/4+FOocXqjSD4g1xAMU5gIHYfc9IQ713zZmEvsFiuxri2q
         2Okna7O5BNn3rct3QauiJ3d0q0gIH/BrZrWPuKLijj7lNfX180LYaXuHgeH3sTm74rFz
         UtLbDduNyvyNykIMxo+Br3ZFnelF2tanV58h+SkEmQIXCq/yUn9OvOngx4N9t/cwQ4pu
         G/RPxuhVXKZCCffYTxEtPfkXpkuCdN1gmiym+gl8Pq6fWFjMR4UxOBtPphrmW2lgfkaA
         5fbDguz4ElxUXnIJlv6ZPqV4mIiDycnb/psHEXOMpgVdY8/FOYWgzMd+AEdB2b3qEAph
         ApRA==
X-Forwarded-Encrypted: i=1; AJvYcCWfJdPqgQKM8HinjIpDw3IRYInuvgRkI36n1JpidQ7OeWQe6aZ2/524oUD/QmHPFLW0GWL3pXJSL+BsT+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVr301qgOtGBciuzOgezv35LHRrLB5AlCKwzabeNuR/m369LH1
	oTSb4wDe6dQV/M6Q8a6w2DFTRxj+5siLr2eKEJfMuGI/anJue5+4KqC75/+ybWLLA2k=
X-Gm-Gg: ASbGncs7MlKJp6MVeQM6Ggu7qSY+zkxk1nDhXDlZHW37cJm/gt7xPCet6/dewfxt0Kk
	qDnXic6mmIfPJ1j4Io698Qc8BKBGd0BboJ2SyIdC1YNdkm6PYt6yVtYOlVXGnc51mStkogcLHdJ
	wc06Sok/gQ1aH4n4ha3iXdErCRLZdMeVG6RLGUYLI/bDgvkPH7T32FMEkHZR8Tj3EqklFB8aYtO
	09ZsjZTpOesD7DJJhq2aC0AgRuk8Ic6mVqOlrXX0OlvDe9qdOZoPvIzFtnYYIWq7qoxKqPd8pZV
	RmmcWKKrKvMRyKE8FSmnE9WKKqoMw9kj3TeAciOgK3i4KYOt9p6V8LvVjSUsfKxMM/dIjr5JH1N
	nit/myMhjij9YV3ST+gc=
X-Google-Smtp-Source: AGHT+IHPERXnh35U5KLN0oB9XHU8r47sGlqZ6/yemRyGMlR8wQlND1vUeWOzfK2ZkSssVIRR5XPfbg==
X-Received: by 2002:a05:6602:1505:b0:887:118c:34fb with SMTP id ca18e2360f4ac-887773fb5ffmr1486323639f.0.1757359230130;
        Mon, 08 Sep 2025 12:20:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ece96399csm8341428173.20.2025.09.08.12.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 12:20:29 -0700 (PDT)
Message-ID: <4812e4b2-b7e0-45e6-b465-e160ac267939@kernel.dk>
Date: Mon, 8 Sep 2025 13:20:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] io_uring: avoid uring_lock for
 IORING_SETUP_SINGLE_ISSUER
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot@syzkaller.appspotmail.com
References: <20250904170902.2624135-1-csander@purestorage.com>
 <20250904170902.2624135-6-csander@purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250904170902.2624135-6-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 11:09 AM, Caleb Sander Mateos wrote:
> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
> index a0580a1bf6b5..7296b12b0897 100644
> --- a/io_uring/io_uring.h
> +++ b/io_uring/io_uring.h
> @@ -121,20 +121,34 @@ bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
>  
>  void io_activate_pollwq(struct io_ring_ctx *ctx);
>  
>  static inline void io_ring_ctx_lock(struct io_ring_ctx *ctx)
>  {
> +	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
> +		WARN_ON_ONCE(current != ctx->submitter_task);
> +		return;
> +	}
> +
>  	mutex_lock(&ctx->uring_lock);
>  }
>  
>  static inline void io_ring_ctx_unlock(struct io_ring_ctx *ctx)
>  {
> +	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
> +		WARN_ON_ONCE(current != ctx->submitter_task);
> +		return;
> +	}
> +
>  	mutex_unlock(&ctx->uring_lock);
>  }

I do want to get rid of these WARN_ON_ONCE() down the line, but it's
prudent to keep them there for now.

-- 
Jens Axboe

