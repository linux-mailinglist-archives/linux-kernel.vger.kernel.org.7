Return-Path: <linux-kernel+bounces-792482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B670CB3C496
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FEBA63511
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197227780D;
	Fri, 29 Aug 2025 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb8sf3yJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A87263F5E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504954; cv=none; b=XOzahJcke4NxXW7qVLbc8b6JdfVXJcAW2Ox3lBh4oqluhFgSs9yJQ4zqLfhOlVYlqsO7E8zsASrhueL/JbCWeguBTPlF5pzlKKQ3e8gaJ4grsdoD9U347Um2tWttE9ignE5VYuh6CYDG9U3NbQqDAEeAYlYoICRtJ1VNL4vbuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504954; c=relaxed/simple;
	bh=haUmgxIRXQDjwi4lb/BQlAFlSrzJql+P3a2fXt52+GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXxTAPfJEdoU3GgjYme+AKTFZUKbRMUOTGQv8jJTMDYJiruWPjPLEIxU6lCobowA/T+0kSA61NR99DMbPuVFufRcJw7CZG3xIvqeuuQNCdqtSeLS7TmjqEKEhsrGYdl76IlxKtHldB3G9Tlf/xjzENFRLW2A2ziD/BEr/QMVDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb8sf3yJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso862e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504951; x=1757109751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V5dKEndD7dSG0TB2Mn/htAOInJHnhi3k/ux0ccykDY=;
        b=Cb8sf3yJusihzKILyWNda1FiaafE9fPHpK6sbdO2YdNQ6hoDJuQ/IZeh/MWugX1L41
         OAgshKDiYQIaHlCIbXD22pPNjvo9KhH6BGw6PKJbBg9IbFg8LRe9bCfwCydqhA4R+gb3
         5+QlZt040bpsh95kVrfFe9BNjhd0rIH0RMnMcyG0pPv5qalcBzWkP3LOxoTJr3ZIcu4n
         y4VmG4hwsWgH8I1lQFxcUkDU/cN36kl92nPTVwvGtqlp3jw4alDbXCOiaf/4qVTEZ1mN
         KPp6a5KIolac/XZ+8YnaEtE+eGcyUKgYawxAl6zo+d09s5E8n+YLx1RwQpnZPy3ULVGg
         hzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504951; x=1757109751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V5dKEndD7dSG0TB2Mn/htAOInJHnhi3k/ux0ccykDY=;
        b=R6Jb8m6Cmc3CdlZInCl808tb3DjW2oCKb3zXo+SKU0XctHbbeFvAFfQsry/834qjYm
         NfmroFOFxi8iN2zd5QHspvA0+eYMrZTtYYVr0uUnTt26xa92pEybwS5Jz4D7tF57O79K
         faWgCyt9hPfRm6c0MjKCo5XAb4e5YuXL/FXYn4CVLcTtvr/nsVyhej+F8yziN2rm3c9L
         xrHqSVkXhLjIs7i4N4AfMn8Rv5pMDyrL9lV19Y0bVgJyUxKL/gZ1NaLo6ZXZUyoKlTnY
         toAB+k7fOY8a1bVhW1gPuO6xWzBY3YNICPd5jS4L7FNE46vq8JasaVNeSSE7Q4ivhb88
         Ls6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1mQXkXqcTwkT/0caqCNSu3yGXAfeGBjCGXZ0GCmJzim6G0raobLSmo2vj9YJWijtQSwA6okadr+KYggI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGp8c7KeUzcu8Ew86j3/oXoLnARu5PZBALfLlNcpw+tvuquqk
	b3inrwn4gqwh9cBE9uc1uRQbie0vn56qcAqhBL/O3/BGtIJh2eDyQSLuMfpe30zxMObQn732dtx
	RrgobS4XYcdRGfoQ90zqDzNOcR+KjGJ+KbUowRzBF
X-Gm-Gg: ASbGncuaWR3Dmo/JO026jBYqPcKOD7SW08cdnKyUmFZLx20RuhB/KVc9+lPWteX1BHo
	7oELRdoxI+vuQZmpSlDwFKTubDJ8s0cBIaP6cKF1+dbyNjlC2ErzFheUmARvEYiowdB4hAcqQFW
	Fjh//qmV3AiZIH9wIMHxNgFdMc1AJD5E60HDCUOA4yo8mlpJ36aV2nhQpGe80idPf8b489TMTkh
	FZnRTwvnRCy1BV/89UBgtbkZSQZtdWNpWDJI9JsDN2Y6iQ3dzyckjk=
X-Google-Smtp-Source: AGHT+IF/ezfpPN7uV7BetJDi6PD9ZdpyWvFHa8vLCm0qZeVN0l3vdYIaO47E0Iq0vbn+xNeruHLoZWVSPw3W8tR1xnU=
X-Received: by 2002:a05:6512:6519:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-55f6f5045d1mr74605e87.3.1756504950814; Fri, 29 Aug 2025
 15:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829220003.3310242-1-almasrymina@google.com>
In-Reply-To: <20250829220003.3310242-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 29 Aug 2025 15:02:18 -0700
X-Gm-Features: Ac12FXzqqc-si0CcOfJD45EHTkfXF7rFHi9T629g2PLxIwPue9SA_DPIQ3MXvZI
Message-ID: <CAHS8izMnwZkQ7pDpSyf2tviQrniWPv8nat6ucaZHsfqm6Er=gA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: devmem: NULL check netdev_nl_get_dma_dev
 return value
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missed ccing Dragos. Adding manually.

On Fri, Aug 29, 2025 at 3:00=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
> scenario that netdev->dev.parent is NULL, or all the calls to the
> ndo_queue_get_dma_dev return NULL from the driver.
>
> Current code doesn't NULL check the return value, so it may be passed to
> net_devmem_bind_dmabuf, which AFAICT will eventually hit
> WARN_ON(!dmabuf || !dev) in dma_buf_dynamic_attach and do a kernel
> splat. Avoid this scenario by using IS_ERR_OR_NULL in place of IS_ERR.
>
> Found by code inspection.
>
> Note that this was a problem even before the fixes patch, since we
> passed netdev->dev.parent to net_devmem_bind_dmabuf before NULL checking
> it anyway :( But that code got removed in the fixes patch (and retained
> the bug).
>
> Fixes: b8aab4bb9585 ("net: devmem: allow binding on rx queues with same D=
MA devices")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>  net/core/netdev-genl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 470fabbeacd9..779bcdb5653d 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1098,7 +1098,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE=
,
>                                          dmabuf_fd, priv, info->extack);
> -       if (IS_ERR(binding)) {
> +       if (IS_ERR_OR_NULL(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_unlock_netdev;
>         }
>
> base-commit: 4f54dff818d7b5b1d84becd5d90bc46e6233c0d7
> --
> 2.51.0.318.gd7df087d1a-goog
>


--=20
Thanks,
Mina

