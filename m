Return-Path: <linux-kernel+bounces-828639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9461FB9511F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6696C2E0555
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6BD31DD91;
	Tue, 23 Sep 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DNIskspX"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707D31D362
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617456; cv=none; b=cP5z9Ap9y6tDSw8s4HlxnDccCHvEHtAAvUEVLwmUqfN7VPZ4FFnMbSG3PCgjPdgHQPtkxBK7fishsOijhzIPo0jIPN7Z6mFq51Tbaqled42xceb47rHGCab9Jnfnqub3CnNpeEcNY4Dvp4MMZUVkggPabElQVp4CjxDPxhqKEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617456; c=relaxed/simple;
	bh=REocMjmsu6AX81gp/uzAIKIwKXDw2DKeLsxi6s3GM3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3hFOERyROfmaGZ9Ll3oLU5QefZ/HDnvUPRQseSAPBpafdvAHpPqrarQan/9RP6GyEI4Ad/g0yXtxBa4hcr0nTJwTdy/kvvIWWw37yLxo++OFhNomNO17ZCIi+GLNbRn1Am03mAmPJv46kKVM6JZl4PX8oE58UBf3wyDAaigjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DNIskspX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55115148b4so3402466a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758617451; x=1759222251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TElWDiK48oXYCouZ3wAyzgEnzHydL1jtaDbh0rIsFlk=;
        b=DNIskspX3tvq0ZGDMZWlF/CocJWN4NaTQz02Bn2zW5ildekaTqAkgrA6EOYoq97K++
         PHdRyiscv9y4n1BFhrTj6opJkXNRzoN8NzlhigLzQaf6hSrecy3fB4E3EdR6nPjUd8TV
         3mwnsJH7LLifDcHtYkS64tH4fKMYgZ7ECkPeAhX25eYJmIg43hGSfEM0Bd+MTo/YXbGB
         OAjnPf0DghKKNx1ppNX7DgSbsnLvtKO9OoMQFWJokqf3vqVSFSLT0/2dzyGtdzZYouor
         8Go/o2eWGhnFBVYTwyDFPU+qTTEq6U0F5cHG7mX5lWVqjBFg7A2b9dPGMQgW8NlSUpoN
         q6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617451; x=1759222251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TElWDiK48oXYCouZ3wAyzgEnzHydL1jtaDbh0rIsFlk=;
        b=U42EMyq0CpE3x6kldGsRysQ1C1BMZM3iQd274yTZJzTznTzuO8TZ7FKmDYV5kScz4B
         1YoefXCDe7obwQvLqqZ1GIw3Zm/GFIXGhdsDiWp30BMsXQG5tbTgNQDKw/uGt1lTWnBu
         MYEOUWcoNdwGbNA4+iI6ho6cESnTsjk/EXR7LYcpImjjEU9kc8NvJ2sfTNq8W+hLL9iA
         aKt6Yds5io6e6paeJaYVnEo7wTTxNt27Tk8qEJ7Uu8t1jvmxVaXJU23WpL6jLV+LH7Yx
         G4ECUug0H5NzzpjmFwOc+fcwGpTUBZwf36TWCbTT9ZLobU6CT7H2gKeCjy8rHiMvgvxj
         1KQA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ail4FO2XfRKtQz7dbPmSwWIpXAWxUo526lIqMLQhR2gGkImQK1asZpVgY83A6n8J5a+bBk0dx74Y8l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2YQ8YUtF0dnJokq4r5bMozOx9T5WbMHFgSlvS2Gl930ENLH5
	cbb33Bdgh8YESEk5sGEiOOCNkS/fQgxrgji35YNjQ0kykU0KRPqepvo680PcZoU30Ac=
X-Gm-Gg: ASbGnct77K53TXF3JnvldP/VROiFmqSp823b7f75emFH5S3JgDfEhrb3s9ZhwWyvLIG
	cT6/4H2Pxly8Gu+pcM5lnFFeqcheEbuk1oRutvVZJlz3m3f0Di8qC1V2BQjcZEyoOhTdVamC1qZ
	TkThnylBBq37iVK9sHuUHY07BALw4GHz/4DzTx7qkcDe47pN4TKNEyIwwXCZ1wuMBQExTwzaVxW
	K7EiKgHioOVpVBTBXxRyiNecnqNG0jCzkBiG1Bdx4RhE7tQMEz0mKQRRY/XBc3Nu3Ka+WwgaN74
	6RnWVUYKzj6X1cdXRz+rheZKRSUZYxUmqTp7uqTxr77sS86xZkGNiZ7iT2Ot5S3PiFqajGPL4S/
	ge2ofwaAcpaQo6nOJTxZrqEWv9aMH7M0weH7a73hB0SogWMpjy8NAnnHE3rAEMOVj9g==
X-Google-Smtp-Source: AGHT+IFQOpul0tUxq1oXdL2Hhgnzczxm+Zls0iozp3haPh5dKFynoX8TDzhJyfVZuaTiPwkXybDupw==
X-Received: by 2002:a17:903:388d:b0:271:479d:3de2 with SMTP id d9443c01a7336-27cc1e1e758mr25738465ad.13.1758617450986;
        Tue, 23 Sep 2025 01:50:50 -0700 (PDT)
Received: from ?IPV6:2600:380:465e:7d48:c981:e35c:e96a:4ed1? ([2600:380:465e:7d48:c981:e35c:e96a:4ed1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053decsm155900555ad.11.2025.09.23.01.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:50:50 -0700 (PDT)
Message-ID: <b0b0db4c-ac91-482a-85a4-2acd2884e5ae@kernel.dk>
Date: Tue, 23 Sep 2025 02:50:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/rsrc: remove unnecessary check on resv2
To: clingfei <clf700383@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CADPKJ-7cb9fcPbP3gDNauc22nSbqmddhYzmKeVSiLpkc_u88KA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADPKJ-7cb9fcPbP3gDNauc22nSbqmddhYzmKeVSiLpkc_u88KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 2:41 AM, clingfei wrote:
> From b52509776e0f7f9ea703d0551ccaeeaa49ab6440 Mon Sep 17 00:00:00 2001
> From: clingfei <clf700383@gmail.com>
> Date: Tue, 23 Sep 2025 16:30:30 +0800
> Subject: [PATCH] io_uring/rsrc: remove unnecessary check on resv2
> 
> The memset sets the up.resv2 to be 0,
> and the copy_from_user does not touch it,
> thus up.resv2 will always be false.

Please wrap commit messages at around ~72 chars.

> Signed-off-by: clingfei <clf700383@gmail.com>
> ---
>  io_uring/rsrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index f75f5e43fa4a..7006b3ca5404 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -372,7 +372,7 @@ int io_register_files_update(struct io_ring_ctx
> *ctx, void __user *arg,
>     memset(&up, 0, sizeof(up));
>     if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
>         return -EFAULT;
> -   if (up.resv || up.resv2)
> +   if (up.resv)
>         return -EINVAL;
>     return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
>  }

White space damaged patch, but more importantly, I don't think this is
worth adding. Yes it'll never overwrite resv2 because of the different
sizes. Curious how you ran into this?

-- 
Jens Axboe

