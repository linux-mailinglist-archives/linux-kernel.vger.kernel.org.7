Return-Path: <linux-kernel+bounces-806025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8545B490F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F0D3BB031
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A530C621;
	Mon,  8 Sep 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="irSR+pZr"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284730BB9D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340799; cv=none; b=RTg2WJm3rLYeMivdqFli8/qiWpPgZfwgQ/YMpPmrwwyEuLEBUjpfLdO+YsckXkCXOO5BtD3pI6q7WsJNWbKi+Wg5M3kkdddEZmovy99KSP7TPcXp2914xZmak6lH+by+ThIOQqrci+3yYfk7FP0+s/JtGoe+Fii37B8H0LYROZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340799; c=relaxed/simple;
	bh=h0D0SEqPji3fHwIoVrp0jHPUatei55dk0QRkQqv/duw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKbxRz2/ZMM/pNEZnKWY8kQYmxm9JZLC5rCX3JqWiPo1XyQUiatRejqDxHaIrjQ143Qlg+Ty2xybIX5MHM26xVbBzxB+iujsJynD2+8142jbaPGDZ3VrcjpRPs2ntMp6QBHzowssjivc3RH+brCD3HTtnhWextp7guNjsBytY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=irSR+pZr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3830063b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757340796; x=1757945596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZF66cJNg0DGdhDsxeGBFMCJxYCrZerYg7Gnl/nvd78=;
        b=irSR+pZrOh6cTWRO+LIl2EooH4nGGi0dQwOOZha+0ZoTMFwTfA2G3ocqrH4P3+j5Mg
         rtp86fWI9r0pZj8j1ODng7l76NkaK9Pi9mTZibj+qZWa3WrMXF6Rq9Slz9p/E2VtzBcl
         OSFxKNNKoA4klxs2PLfWn9sQXcCzpHQQ/DjqI4LBKYZJHu/ktqazNRUEnQ123+i1NQMA
         hjMko+p+YJd9XYhRnwAFF/TJCb2wVuFAzKkYLQ/BQdtwpPYUn5mBK+0J+nRnLMDqCjMx
         GEQ1vBSZqbSj9J8Jqx3+y5hZD2DKKOMiEcwTASUoeVxPOY+PRH2K8wFj3Rsu3TkYJghk
         p7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340796; x=1757945596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZF66cJNg0DGdhDsxeGBFMCJxYCrZerYg7Gnl/nvd78=;
        b=fn+M8aRW/RE8KHGgOmvePoB8etlx4eCbwcAlw3z2UWViIvYNtUhA8WZNNNE5HTB5Ba
         EHwBeO3CCYaVE3c8Xee6hLND/suiHBhTr8yq0OrNoR43nDuUxCxHfoR+n1KIBUVOEmFj
         YLc1ew+LzQnDXcAWjl47vtFKm4CBO4f+Xn4svVM1SbwbgbwU8vCpb06KScLE0vt8ssmh
         UbxDKlCvIvRBtfxVggfClDPxBNHNarfAtrgJCyjDuDym7pBnP+CZV4FQ/wD0ImRZnyFc
         qJDP/Xp7ZtDr3fkLn42qZ6UVebNqAuwMmfOyrH3zM5/bGLESGeDI1GSTA4TX1cr7peWj
         Dz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpwfkpbXcH7YFg9OBn5X5L34syy9aqiyxnOy9SaQR1UdDdpXtXaczjLRDS9OLqT267A+uG0gHbPIah7ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhMQzccNQZbU1Qlj2ve1+yy6as+oC/yJBtDpLhJDsLkaoVIDk
	VAB27jTvxlIAl4Wcwp+emkG6SdY+qhEqrkv5TzY6iR475p/h4QJqX+yYe04m6YBYx/QRofNKKFO
	OrIvO
X-Gm-Gg: ASbGncsQ6aGPBl47KTQVFegQKkkfEtlTAIZQldptHhrKGCUX3QveSa9SRy/hPN2aF2B
	OKZ/T5OdmDOTrKOZJKEHn7m8ZqLWqXxgq4excmj/6YYERgMsLRwBe1FYxtEldgF4jXmY7vWhDCP
	r4/UdcslTUP4MfwlWfYIbwYr5Z4GfC4xo445PBzqJm3FQPVeVfJbKdbMVkV4OfWttUOgh7XnKkG
	cTn94HIeCeZb1F5nPnPQSXYMQkfhJRqlk6TfQi2l/LSeWpa5LmD24nHmFMNkh8ZxIqs3y2VNgsf
	vItX731vg25y/K4JeBJ5KmPm9B50yU3IJRbkWBWydhlRCrH2Bn0PEeJKdyGtga8pE9mcWjNTzKB
	bAU0GdCnwYkb15NRM8zKrtFSEmOY42r4=
X-Google-Smtp-Source: AGHT+IEsiSNhHutwk0RCJsT9JHAXZkKZX+8NOR4PeGFuw6oURb33W4QXf2+JENghOU4mdcLKN0AzOQ==
X-Received: by 2002:a05:6a21:6d99:b0:246:5be:ca90 with SMTP id adf61e73a8af0-253777539b7mr10169857637.10.1757340796130;
        Mon, 08 Sep 2025 07:13:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7724b62922dsm23941487b3a.27.2025.09.08.07.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:13:15 -0700 (PDT)
Message-ID: <07806298-f9d3-4ca6-8ce5-4088c9f0ea2c@kernel.dk>
Date: Mon, 8 Sep 2025 08:13:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for
 IORING_SETUP_SQPOLL
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904170902.2624135-1-csander@purestorage.com>
 <20250904170902.2624135-4-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250904170902.2624135-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 11:09 AM, Caleb Sander Mateos wrote:
> IORING_SETUP_SINGLE_ISSUER doesn't currently enable any optimizations,
> but it will soon be used to avoid taking io_ring_ctx's uring_lock when
> submitting from the single issuer task. If the IORING_SETUP_SQPOLL flag
> is set, the SQ thread is the sole task issuing SQEs. However, other
> tasks may make io_uring_register() syscalls, which must be synchronized
> with SQE submission. So it wouldn't be safe to skip the uring_lock
> around the SQ thread's submission even if IORING_SETUP_SINGLE_ISSUER is
> set. Therefore, clear IORING_SETUP_SINGLE_ISSUER from the io_ring_ctx
> flags if IORING_SETUP_SQPOLL is set.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  io_uring/io_uring.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 42f6bfbb99d3..c7af9dc3d95a 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3724,10 +3724,19 @@ static int io_uring_sanitise_params(struct io_uring_params *p)
>  	 */
>  	if ((flags & (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED)) ==
>  	    (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED))
>  		return -EINVAL;
>  
> +	/*
> +	 * If IORING_SETUP_SQPOLL is set, only the SQ thread issues SQEs,
> +	 * but other threads may call io_uring_register() concurrently.
> +	 * We still need uring_lock to synchronize these io_ring_ctx accesses,
> +	 * so disable the single issuer optimizations.
> +	 */
> +	if (flags & IORING_SETUP_SQPOLL)
> +		p->flags &= ~IORING_SETUP_SINGLE_ISSUER;
> +

As mentioned I think this is fine. Just for posterity, one solution
here would be to require that the task doing eg io_uring_register() on a
setup with SINGLE_ISSUER|SQPOLL would be required to park and unpark the
SQ thread before doing what it needs to do. That should get us most/all
of the way there to enabling it with SQPOLL as well.

-- 
Jens Axboe

