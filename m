Return-Path: <linux-kernel+bounces-811570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D45B52B02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F69584F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CB2D238B;
	Thu, 11 Sep 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc6lnnJ4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD2D0618;
	Thu, 11 Sep 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577578; cv=none; b=Q26jiNhNHoUW5yPp6iVck7yfqMcDzvGKpYEfjdzixmBZT0oXnkhhhkvaIsAG0x5L4WS4W96saLLhVVWiAHuqeGe+4k1bYnIufobBjxXs7U6VZDor6AOHXbFR1ilnuNbNQfxPuIzhId74WvcO7gHAB3bkiFFK3EXMGbzzWNqWg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577578; c=relaxed/simple;
	bh=at6W0Sk6OHxTFRWnRkghHWR3Ehx4+dN0M2Zy5oaFRk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrgthQo5ldLJk5sjgCBFdL643ZJ7acwkm/FxHvHA9IcOX+DQghEk75kFUpIPHp48kNDxVD9Tw+PBA5gi8zqTk9QtBWsoXiuLHjtJx2OhLnmXaOIB45w9BDfxdVLNHgFNadKPQTVwXnTPIVmKyL6lNsVRslh2KHKxjQg1Q9SEEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc6lnnJ4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so410030e87.1;
        Thu, 11 Sep 2025 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757577575; x=1758182375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7er97Y3OYMOo2yGE9gkvezpwQR54iFaPqu7weYqFQw=;
        b=Pc6lnnJ4JmzTbog6kPPztJH/Di+mCzzSKAiuRkvZ3Q+BS/Atz2tc0ujdL/D8HhujZm
         IZsTppGZoppBRJzQ5PADeLbxZjfHMoQ+/BQdNuJnJlCNmd2Sd2Cd1kEX/7bY6YCBxTsa
         IVBmAHWwKqHvMZJ/yEpQ+wISqUdtnuxu5kLkuacnTjxukdGY8KT7S7393Vh6qiLfUzJs
         KCO/5XZ/4QrD2dpXsFqCOipy6Jzt/SSWsn6FpMfccJH5vgcrh2Eal0/qDzsIc6RYd1T8
         ur13EtLHGLlrd/T/BJDsSD0cu+KopnGS+6T8Ux+/WTGWZrFwB/wtmick7GGoLfL1lyCE
         krsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577575; x=1758182375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7er97Y3OYMOo2yGE9gkvezpwQR54iFaPqu7weYqFQw=;
        b=kl8Fx3bSAB8ZU4Jj3pYCX1mIUdrUNBJcEW3V5rp4LztJYY4IlKgIzal79WFWd/XZHF
         Dog3UpM+UcBFL5+U7sg7tfGI78uCyffXbhyCZfgJtGBDFoc1MmbkeLZsvciRZfxSv5Cq
         34397iRgx/tf+IwZIu4Mg8pIUYdExC+WRCbfkSbPyUe7ITKxlNtdq8M8OsEdBRzzdXXR
         DlnmLHA31QdRFiQ5BTXxIJKgNrf2y1ta4tKsKCETeQ4DeeA6RTP/dFXp6f6kBVngB8lG
         DnPGh3T8YeJS60lBQCXJUkDFVJB7kHt4Fa+QNAQSdWBkWJesTsm3wzmrjqq7GYQ3PR+j
         G6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUb4XLky5rg/Rm9S40ju9Uyct3H8aoBkl1OtfeLiEooFsD9gGn6MO0KDfJf6JxMvwRAZZcc+z7MEBi6BrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxDuzhhGUepcsbIwQOpIcwLiIM4ueQp2ctwIZaIV3AgBQQHYO
	muqmY9tnIDIOWb7NQWs+jpaCh67KLjCU1SWNRGZ2hJYg241UCY+Am9H6
X-Gm-Gg: ASbGncvi5pHPjEPFlXYQfKqZs64ln13xd+XgVPcpnzT+xPWV0aMMPHVCRa7eQ6zV0pF
	Mp5vrgBN4O6+qpjGqQfW0vvuG9t9vjYKL6Af+A+NRo+/Q1Kn+aADtTOls6xcgWWtraYqdZG7Lgx
	fR9RHy7AiYdvJAgMTEYiGWaAhZOvUu/r34b+2AF+trlo1gmIaqX95/SzlMdxpa3BlY3Aa5FRoJs
	DpogSSOjfUA3+T15sgYuRzJ2uPb+zRsJ34ygo/3YcDtuYn2RXZ4cu8echU6cBQrPbbxTf0FFGi7
	SzrqXXLE8Nnx7sZQaWcJHADaJUK/Al30OMbPU5Ajh7DOzUXfwBce3055wCd2inAJmFkAj5zJVS8
	e3m54RKdcGGxWvdUQugUN5LMlMcdmMj+92JLG9wOXhBPMhGOsFSJQHYPqEhpb7aotW5AOPmZyyI
	lhq5Vn/p1dqw==
X-Google-Smtp-Source: AGHT+IEcRHX/jzK33oWfXHXRgPLTQYsSGVS5W8ACzX4aqsC9MRQ7GpT2EtFP5AMmXk4iQRXy9bWsZg==
X-Received: by 2002:ac2:568c:0:b0:55b:8afb:e638 with SMTP id 2adb3069b0e04-562637cbf2amr6849841e87.28.1757577574652;
        Thu, 11 Sep 2025 00:59:34 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64dbbf7bsm241402e87.118.2025.09.11.00.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:59:34 -0700 (PDT)
Message-ID: <3c7e9c24-5190-4ea6-a1de-472cf4c13742@gmail.com>
Date: Thu, 11 Sep 2025 10:59:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update the DMA Rust entry
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, daniel.almeida@collabora.com, robin.murphy@arm.com,
 a.hindborg@kernel.org, ojeda@kernel.org
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910094015.11551-1-dakr@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20250910094015.11551-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 12:40, Danilo Krummrich wrote:
> Update the DMA Rust maintainers entry in the following two aspects:
> 
>    (1) Change Abdiel's entry to 'Reviewer'.
> 
>    (2) Take patches through the driver-core tree.
> 
> Abdiel won't do any more maintainer work on the DMA (or scatterlist)
> infrastructure, but he'd like to be kept in the loop, hence change is
> entry to 'R:'.
> 
> Analogous to [1], the DMA (and scatterlist) helpers are closely coupled
> with the core device infrastructure and the device lifecycle, hence take
> patches through the driver-core tree by default.
> 
> Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Link: https://lore.kernel.org/r/20250725202840.2251768-1-ojeda@kernel.org [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fed6cd812d79..281149d9b821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7239,15 +7239,15 @@ F:	include/linux/swiotlb.h
>   F:	kernel/dma/
>   
>   DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
> -M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
>   M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
>   R:	Daniel Almeida <daniel.almeida@collabora.com>
>   R:	Robin Murphy <robin.murphy@arm.com>
>   R:	Andreas Hindborg <a.hindborg@kernel.org>
>   L:	rust-for-linux@vger.kernel.org
>   S:	Supported
>   W:	https://rust-for-linux.com
> -T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
>   F:	rust/helpers/dma.c
>   F:	rust/kernel/dma.rs
>   F:	samples/rust/rust_dma.rs
> 
> base-commit: 3c9ba2777d6c86025e1ba4186dc5cd930e40ec5f

Acked-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>


