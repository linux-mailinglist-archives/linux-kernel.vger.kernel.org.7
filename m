Return-Path: <linux-kernel+bounces-862662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F16BF5DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D013B8D53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779B2EC57F;
	Tue, 21 Oct 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWqLQRTh"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078623D7FB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043662; cv=none; b=D+AFVZEquI86dwq31p9swoZqyf1TD/c0wQjdC1kEAjkSyDZDr/QICbdRrwfdaodr9Z6PD0lzvsCn0Niv4WoAGTC3cixq6SgM6kWK7KfB8ljCGYBc43sBZS76lN2guxEQcih7cZzxNmYcKeG4kxqJ+9PgqXjYBbTGog0JjRKsO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043662; c=relaxed/simple;
	bh=KY8k4nF64QEkqmy8wovcrxZNfcYQnDFhLdMboWwvqjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGoydqShj6Mjq5d8VkxmgIrXbVjAov3BwZh8CHugXjX7t9RvboSC1ADXfsRM6mK4cAgi9GsUGdv2RhOodolK5zL2sRiNPXcthMdv6GdS1KEpySCHeJHLT8M/7Inb0wmvs+03IboR6v7Glr+UCatT669hxwt28TxhSK1DEpzRsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWqLQRTh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so4612975137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761043659; x=1761648459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Xs/eUdQtWZwGGmABaXwPLNP+gh3Pns6jIW82WHCxmU=;
        b=VWqLQRTh3voCfdAX76sAVEwunYGgmbfB8xaI6uDcnyBci7jRsTmoWSZ8dD0+5bEthS
         0eIQUPPHKcnyKGI2qBhyGhOMsZNkJn83CpIt24COjehxE/fuMTVucHLDjt4ZJM4bK1Yq
         +eRayaWhfO8MmuBupZdaJ6AB+bqxM+1HfgynUkDoqXd3RuTDS2uXQ2pX2hm2+3onj0s2
         XLSixj0phHFR0wkjq/b9cU3kjDjOKdVuejoHjAdc6bDfymnmoYl7KaphK3hRKNNqzb5o
         9EkKPeTWP/L3783fpkNBOBw5vx1d6vXigvN7VSr9LhtJt+qsTxWciDe7Q4wU/blPozK+
         sHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043659; x=1761648459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Xs/eUdQtWZwGGmABaXwPLNP+gh3Pns6jIW82WHCxmU=;
        b=DNQ4XzycXLHT0jbqdLYE3fk620J2iS+XOebpGnaaSN97OoWUsK4EW6suyG/zQPOuTP
         6Cc6QKJ4EbQN/eU9pUu1iix7xg73SM5MXZBrZwkKEAgEwRt8VyW33ZJxxI36VNMArCf/
         aV/lLuOyKZAZ8opdvnsQX2hYSHNM3HdugJWg3UZA8RAQBtgWAbR0uS3XtKX+YRdx/w2K
         x6DkYArIm4+y2Wq5UdujgavQwHUeRsF+UNHnteCPSKvSAY6Xs6RjXAC6QWmDJoYdeovZ
         NMYeIcL08ySy4uNq9d6Kjyq0Cy11sA6kZJaEfLNzfpYxE+3M9m0terW2Q6ZmxMelDNe2
         KFxA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Rx6aUKbGp3VWo8g/6yHEew+EImxJteQufKPLTAf4mm7Vqu1hG5jMcnAy8O4EtcK9msCaij32CfMuWGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuBHJQCvc8SYXiLxu4wd7qXqlfspfrRWyiAIqmlmo8R63vUhn
	AHHHskOMqbLgLmoVITXSsgvt1MAb7ueHU2tqO9h1jE96o2+X03qIgfYh6lVE6JU+RiGlC1H4GQb
	S0ul3UZ8y02MAJj1scJWHJi3pJ8a7jw4=
X-Gm-Gg: ASbGncuYYxpV22AXA+AquVVe5i1ZmCmm5qKGGGsCN8IoVTGPEfVCDYofMnF+d1oADVK
	1Lh1z/pmCYOKP65lusDG7J4BgE9P4bFIxJzluxP8pNY5UxNByiinBnU+W/ByBZhH7s5fJWDVFwJ
	rR0RSMjg5j0pw0RpFcUTeuaxGZtnsER0Y19H3oBLQ4S8x9xenLx5LNKajXeQbb7Hokvq66MGogA
	CodgFmhDcjSJpxJS1j6lQdun86698oDKvaYJd77rSIHJu79tfZhCUOYzkS/kI20FyIbLRg/tH6H
	tTb7hKIFE02m+Qru278wemC3D3E3ZS6ECcXvEzJs991SszM=
X-Google-Smtp-Source: AGHT+IHjOFVe1O3tzFMP0gIYtx24HziWgzB3Gjmf9Kpo5gAt5z3gqUWF8osLugzeNby1AvQDK8RZVGBJJaUvMp2ukaM=
X-Received: by 2002:a05:6102:3e8e:b0:5ba:4f5c:874e with SMTP id
 ada2fe7eead31-5d7dd6d6684mr5462466137.31.1761043659295; Tue, 21 Oct 2025
 03:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015133642.3dede646.michal.pecio@gmail.com>
In-Reply-To: <20251015133642.3dede646.michal.pecio@gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 21 Oct 2025 12:47:23 +0200
X-Gm-Features: AS18NWBtKNtvNmDcTFIqNnPFoGF6drRttrc9akQyRbVQmrOOvK9ecsEJNzeSKcQ
Message-ID: <CAPybu_0O10SsPp4G8SfcsbCP5k1gXQJ5Hmhw4kMFTZguEZ7iBQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Return queued buffers on
 start_streaming() failure
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal

It seems that the device was disconnected while doing streamon. That
caused uvc_pm_get() to fail and exit without returning the buffers.

Your patch is not going to help to fix:
xhci_hcd 0000:09:00.0: HC died; cleaning up
usb 13-2: USB disconnect, device number 2

But it is fixing an issue. thanks :)

On Wed, Oct 15, 2025 at 1:36=E2=80=AFPM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
>
> Return buffers if streaming fails to start due to uvc_pm_get() error.
>
> This bug may be responsible for a warning I got running
>
>     while :; do yavta -c3 /dev/video0; done
>
> on an xHCI controller which failed under this workload.
> I had no luck reproducing this warning again to confirm.
>
> xhci_hcd 0000:09:00.0: HC died; cleaning up
> usb 13-2: USB disconnect, device number 2
> WARNING: CPU: 2 PID: 29386 at drivers/media/common/videobuf2/videobuf2-co=
re.c:1803 vb2_start_streaming+0xac/0x120
>
> Fixes: 7dd56c47784a ("media: uvcvideo: Remove stream->is_streaming field"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

> ---
>  drivers/media/usb/uvc/uvc_queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uv=
c_queue.c
> index 790184c9843d..f49c538618bc 100644
> --- a/drivers/media/usb/uvc/uvc_queue.c
> +++ b/drivers/media/usb/uvc/uvc_queue.c
> @@ -177,7 +177,7 @@ static int uvc_start_streaming_video(struct vb2_queue=
 *vq, unsigned int count)
>
>         ret =3D uvc_pm_get(stream->dev);
>         if (ret)
> -               return ret;
> +               goto return_buffers;
>
>         queue->buf_used =3D 0;
>
> @@ -187,6 +187,7 @@ static int uvc_start_streaming_video(struct vb2_queue=
 *vq, unsigned int count)
>
>         uvc_pm_put(stream->dev);
>
> +return_buffers:
>         uvc_queue_return_buffers(queue, UVC_BUF_STATE_QUEUED);
>
>         return ret;
> --
> 2.48.1
>


--
Ricardo Ribalda

