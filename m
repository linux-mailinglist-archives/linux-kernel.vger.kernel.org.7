Return-Path: <linux-kernel+bounces-771335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED3B2859D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798BDB66AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1930DEB9;
	Fri, 15 Aug 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3ThbT8n"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3583225A35
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281478; cv=none; b=YYGqTSbDKvAaV5vLzrBwRUcUKBBPZ5lKC3MpbQSkxwyXHqF/ztWpGAkXzSxQQ48+bG6Xp6uX5b5r7syTgpiZI36w7bd6n/cai3G/6JaIni9J5TIcHWJ0TRnVHRhFNxL1WKMajJdlp0683QT/1vwR800o2LSBQUg6AZau5YmcKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281478; c=relaxed/simple;
	bh=YUKUSbRQfcRJYGciznGAVEEc0k853SnsoMEbrdMrwcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYBqAqn+lzRFbu5a2vYEOFUmTS4nPjFLOkbo8UKxPkDzZml3U1edqzA2EObtHb4qo+6EfKc+3IgUL3I2s+7BUbnmoys0CN7E+Mp5IhH1NXX+/rzcLYR7H6s2E37IsVzDTGvRwHh2fcxkjUp3j0GevYteOciS97W0mgVObRS1Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3ThbT8n; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55cdfd57585so736e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755281474; x=1755886274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T68Dg6hVyJ441LRbZpLNy1OW7oXBwA3ETEmAc0Ulr0o=;
        b=Z3ThbT8nxFKAqRc68fmqDQtTOXQia7vTt+n3570y4ciOA5ZZeKgFSc1F5WvxpwTRLP
         CliQJtGIlnMuveAAjh38X/hh9J+e+/72HohYlkx0z0+Jasb+H6e7g9Ir9H6GSiM28i3Z
         kCbINnroWMb/TJWW7ka826CvfMtJ/5si5tLUrylQrAZbusLNa0WrQsleIeSx5LgtbDvE
         U/CJdQ99oiDULfgQAlcVQQS6BnWGlvmdkCSwxPpBnY7CMkMLQG+hcrsOXKKqy8yAqRAK
         fKpemKU3TpvZdBTnZvpANDVXyD9CwTNVQHUnJbcqczeHgWAWaSwxwljUKvgvgbVhi8oE
         Ad5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281474; x=1755886274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T68Dg6hVyJ441LRbZpLNy1OW7oXBwA3ETEmAc0Ulr0o=;
        b=WBjD+pe+ZqTxcRgw3K7rn4JLSKjCHnaYwwhpS7us5C084quek7F0XLGbxvI0dLs5MR
         e34kxlY4/qA5Q3ujOG1mZPopLGxS+RhCBHsSSnKMWhkVE/5gAgE04N1ZIYqTiiWbenLb
         Fw6Rg0dnEiPRqxhMtFZIKkwu6RJtVUzxYtS9CIwQTHHffELSt2QS3sTi+dWfXzPNxqij
         ILEnsQnBh8/+dA/zgTvNiNkD2Qs4euIYhnxYUO54I6JeUiLp1uD7fQ1fmuOtrRLQA12H
         Ivm3V8gRW0H4cpaOaZM6Ubxpx81kRsqLu1Z50WfhoWEr+doEWG5RZAyieGovt94SFN3f
         zZMg==
X-Forwarded-Encrypted: i=1; AJvYcCX85iqK0PnQqbMyqrkJnFWhv1+9VJOA9PNV4YbSaZLTKO+gQs7zZZHHdBwvGZMbtFO4jHrOtK6nVoaOfOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHbNSMP8Xt2lo00DYFEveGOf6Z4UBpxFGLQLtOGw0P5kI9f9E
	2OJspd4e91aPEx/j5qh3WSwFRJ4IeTXybVngzRvaRGTr0IZ2fviAxYXkJcVWq7MGxuMbJeQYYX4
	fY4VPEHyLYnunpPG+/ukYaZmBcpUxZa9ac4SaP0hi
X-Gm-Gg: ASbGncue91rIlg0HcypI20MjhcDlJAODoNbNjPvUDM7DgA+1YhDvQJZwwZEqnV91gAt
	VAX4tXTFgncpsoZEG9sgYkPWCVWpEpexkPd6ziInQvyQ19xXariyGUP9yggjGtcV9/bcjM2u9H/
	fW5MQYc5VM6v9nOfdl+b4bdKcF7X9J66mxRgyO7f/GWnd1fRVZRo+NnH4G3VnSgegVVFS6YbudK
	am8jiykdQanhuPkjRhXjb+I2ghGqh/iYzOL5s5gacbnqHPZr4sRdf8=
X-Google-Smtp-Source: AGHT+IFKSmNdib9JB61/Sk5lBJhAw12y8lbJAOgUf1Yma55YRjuud6QCO+Mmij3jccXJX6bX+I50uwE4rmdKjqjsuF0=
X-Received: by 2002:a05:6512:1356:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55cf2c27bc3mr19695e87.4.1755281473611; Fri, 15 Aug 2025
 11:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-3-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-3-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 15 Aug 2025 11:11:01 -0700
X-Gm-Features: Ac12FXwk5b4oDrlN4o9lHNf2J6UFW6GQVb9w9DkwAbXFitVbE53iDNwZghKWV4U
Message-ID: <CAHS8izMdevPuO4zFF9EFP2Q7tdAUk+w+bMOO-cz-=_N0q0V37Q@mail.gmail.com>
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> - Scalable Function netdevs [1] have the DMA device in the grandparent.
> - For Multi-PF netdevs [2] queues can be associated to different DMA
> devices.
>
> This patch introduces the a queue based interface for allowing drivers
> to expose a different DMA device for zerocopy.
>
> [1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switch=
dev.rst
> [2] Documentation/networking/multi-pf-netdev.rst
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  include/net/netdev_queues.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 6e835972abd1..d4d8c42b809f 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -127,6 +127,10 @@ void netdev_stat_queue_sum(struct net_device *netdev=
,
>   * @ndo_queue_stop:    Stop the RX queue at the specified index. The sto=
pped
>   *                     queue's memory is written at the specified addres=
s.
>   *
> + * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be=
 used

I'm wondering a bit why this dma-dev issue exists for memory providers
but not for the dma-dev used by the page_pool itself.

I'm guessing because the pp uses the dev in page_pool_params->dev
while I implemented the memory provider stuff to completely ignore
pp_params->dev and use its own device (sorry...).

We may want to extend your work so that the pp also ignores
pp_params.dev and uses the device returned by the queue API if it's
provided by the driver. But there is no upside to doing things this
way except for some consistency, so I think I'm complicating things
for no reason.

I think this looks good to me. With the helper moved to a .c file as
Jakub requested I can Reviewed-by.

--=20
Thanks,
Mina

