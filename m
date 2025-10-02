Return-Path: <linux-kernel+bounces-840807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A255BBB576F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3019E5428
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13032264CD;
	Thu,  2 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z3yOlx5S"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067E2F2D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440433; cv=none; b=oNklaON6CQA14l4LT2c9ehT3Uh402LyenbgwiYiia+wROK9iLsWDmL0sDlExL8lQ8gYVvw2+2x7RYDiKcCLQ7jis7DN4GDPUeAFwU1EayzXHc+4Zua6vdZWlfySQv4TrOLNP9gIiNSTa5t4rHkmzmW6PRKjJuntq3Gkk6yRUwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440433; c=relaxed/simple;
	bh=KmY2Xi1NF6SDwK564ejY9ttxqcQo9DMaKBxSnm8s1Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt5MeR6ZTHZdLetgKGXITcBoSaFejhuInoY4UEaDDJEqjfw4l/zaq9RfKQELLocLSMdKorU+2xuwgxMw8g1IL7HDZ+TAvkcl8T7ticbVLr8cRy7kLV8zlW6BD53wy5WFpA1dw7hkx1Mfl3iP15HumC6XJhTkTEbjQANpTApuR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z3yOlx5S; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42592472031so4824785ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440429; x=1760045229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+0Omx3Aw6Oe9Sj7rxnSGR619M3i1DKj3Yy9f6zCKUQ=;
        b=z3yOlx5S34ab2E0UNSC7JO/FkuZre/J0c7kyxDGPVx35hMcIdeZqC+JxOs0fLsjTth
         +IHRehInFZJi61kOobfVQbIR8h9924aDAXNbsZribOrJlVBxZHCEdd2TA6uUMmiXOhY7
         5BmZ/tVTxtsFc2Om7QDl2L6G5O2NPshaNDUFxHIw/9mFcT9ndJLGI4+4A6Lw+F9lQXJD
         itUYYpVHEEbTLET7LrTKfbv1SU+4F4BY201B9MCiP9phZ1JTRs/j9bqEbOFWNPDfkCWR
         HKGg1joqNI8Tq69ig7aNlBQ3cDPGxwqdbMztp442zhNhgdMtRocnpH8fTmAGyTlzICG/
         aq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440429; x=1760045229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+0Omx3Aw6Oe9Sj7rxnSGR619M3i1DKj3Yy9f6zCKUQ=;
        b=xETP1Fj+gosOQj9r6piUXaMvX7suq1UYYn23BQqDipewie8UpddOux+JAiCcC0CSe5
         pVHiBGl/uBPEfLPM1p0+lVEknlQD2cHyOVzkpD5YbMJeDcVIgxjxr0HNdwhO7WutLwlW
         wwuLlcUf6UTbvnOtcGNO9hoOejXhfLtgRhAh5ENOMcKC2yOOV4Dthph8gH1sbC1YZQXn
         K59ya8KEtHkwYjV2T9ShVq66tnPgiTPtVA23YqQ2qS+pMYMQUlTO9d9pi2XE0QL7ZGDk
         2693ExWiCWWd7pa+F0LeeGklKt1U6smkJyq6U1MxS5FMOsVh4yBR1x08Tg54ipCBbvF/
         o/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXzGQCPZPmor7hKUHJ5iOVlchCeppwbEFuy18qETH1ac7xfuICBzQu2dQnzv6EWVabu0OlaWoOGZXmF784=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPRiEn96F65C0Qbci5+GfdKhVER4SbGEFjbNL4gzHM+jygdpu
	XC48KHFuDJy8fTKpbv/gUzuC9yKRLIVCJcGsrfMA/fK8TycmA87194xxVohzqbVT/J+vKmsd2R3
	fROA6t8Q=
X-Gm-Gg: ASbGnctevbeM1KWUmz09oFdd/Ed00Wh/Pat/xpyms/uADp8siG7YFYYNdHexJI8SC4M
	bskqY4ol7KVJ2OdYZkgv/gYRzR5EUIe24ge8mUMIw1TDUeYrOoLm1FIA3SqxRxqTTKKoLNr9ByH
	C33kfeGO+j4If0w09AIqnr1Vp3zXYwlSY8kk6ohZ4Rb0A4LcQRr/HT+qBqqtXandrCGTTS1IB2P
	sMO48QyK5z72hTL08eo4aludf1hPO32GW266iFOTZ2LUrJqJpA8wV/Sd6PRMRmeEDIXESPizIzS
	D3SvdiA4NI31utE4wHGQZXL7Z5Ir0wMHC6GsfR8kuF5SigD8vh+OqiJKvkhJkz5QT5k/DgdaIre
	Jj+VCstjba6VgzkBzRFK/SXvLNFWfdYHfauNBq7IExvH/
X-Google-Smtp-Source: AGHT+IGhqd6Z53c32AZqu1NEKDE2nlxWfrpFbaZI+/ZfB1uxj7scJTwTPcWlWpTCix7Xy2FOBx6deQ==
X-Received: by 2002:a05:6e02:3a04:b0:42d:84ec:b5da with SMTP id e9e14a558f8ab-42e7ad16f9cmr10307325ab.10.1759440429017;
        Thu, 02 Oct 2025 14:27:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea31448sm1215916173.29.2025.10.02.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:27:08 -0700 (PDT)
Message-ID: <ad0f4a85-d7cc-4f47-b469-6903168c062a@kernel.dk>
Date: Thu, 2 Oct 2025 15:27:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block/mq-deadline: adjust the timeout period of
 the per_prio->dispatch
To: chengkaitao <pilgrimtao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>, Damien Le Moal <dlemoal@kernel.org>
References: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 8:38 PM, chengkaitao wrote:
> From: chengkaitao <chengkaitao@kylinos.cn>
> 
> Reference function started_after()
> Before modification:
> 	Timeout for dispatch{read}: 9.5s
> 	started_after - 0.5s < latest_start - 10s
> 	9.5s < latest_start - started_after
> 
> 	Timeout for dispatch{write}: 5s
> 	started_after - 5s < latest_start - 10s
> 	5s < latest_start - started_after
> 
> At this point, write requests have higher priority than read requests.
> 
> After modification:
> 	Timeout for dispatch{read/write}: 5s
> 	prio_aging_expire / 2 < latest_start - started_after
> 
> Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
> ---
>  block/mq-deadline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b9b7cdf1d3c9..f311168f8dfe 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
> +				- dd->prio_aging_expire / 2;
>  	} else {
>  		deadline_add_rq_rb(per_prio, rq);
>  

Adding Damien as he's worked on mq-deadline the most recently.

-- 
Jens Axboe


