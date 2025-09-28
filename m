Return-Path: <linux-kernel+bounces-835529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C65BA7621
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20F11892120
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919821E8320;
	Sun, 28 Sep 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa1StLip"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0138F54
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759084094; cv=none; b=guHp7iOIE+Hk8GtdeRWm+7cLolm4cHZonz1UXI2z+VRkQR1yREvPde/+1lz+3vKS90OElPRWVPNeflkOiLGm3JVjnRcnPm3mN6M8jNBpra0lsSHliLJp70CYGKuwHxo0N1D+42NDYHGFJ8YCEM4uutNUEiiMG3MkmNg0iZH4jrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759084094; c=relaxed/simple;
	bh=TeBpzck/c7OMPChD6RmJx4cqXDKvwDsYwcS3NXi78L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slpJoliLruz29wJiaerMqO9wiz28XtHYk2tewFUrw7kBzJ2SaJkye7uvPBrxoDINwpXD7VnJY7ot45cnSoUYd1Jb5HfpXgrjz32uNn+4GSy3g8QSLxXclRPFKfJa/gEiA8Rpu6HfmRjl6Kxha6obN4HiSHVM97SKl7FKED7wHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa1StLip; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e317bc647so24290925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759084091; x=1759688891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdKzRlhcATdj0vLPnh0uR+5zLTf4ork1cuaBafA3aLk=;
        b=Xa1StLips3gZRm9uoKOfkiUDDrvV1BN0i16Y4zCnzfEw2JxlFg0sa+6Lj51IGBReb8
         K88E8GXQp/RQmDu5N3Jq3u7Y+n61oc210wPmataYwEycxGQq6d5m/2Zj7Fa0icZAKmIY
         Z9fd40hGbcpoEhtq9wMbA8vjk3zgjigwUmhzCjOuVME8kuViLHlKkwhy5vEQzACzxnQq
         vyiMR/UPlwox1GZ73xAqCFLkWwPPzQ/PVublhOs8KGAElND1m1fKwMmBW/nIjlP7YQrw
         YESXOaK24i35fYup28VgiQa3yQq6sQt/IewX5SQ3GVWmAqpOIP5i2f4xVUg6JS4Fu2OQ
         qtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759084091; x=1759688891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdKzRlhcATdj0vLPnh0uR+5zLTf4ork1cuaBafA3aLk=;
        b=ZFxpqeyAIIjYB6ImoUxYXWc6URuK9el7yCf3/ppJsuwXDA3MC78VySKKXGyuWbbc8g
         AqlDIKWv3O9CrU37v4TvR81T3B7lQSH5IGJweSkU1TVh+CerV0ZOfBZzXdpZ67HO5+gt
         0RkPrGTTY9k/c43xTjQPblH81aqi1FAR64p2ODyhEu+9lxGcgbtwmnbjTwSaqMAzQKZ/
         IzhI0QVu4UE7ym1CHzs/r8xS7jgnTUf67yGlVUCwbO7hC8tgBpLTwoTCgm0eLvdWt4a+
         TehGAz8okBVkILC47aP6RFsWsbPkqMVVe0C9S2ZH7hV3F4rr9nLVzvw7UBUhQHnzG+/b
         dQNw==
X-Forwarded-Encrypted: i=1; AJvYcCV1pbjYq2K7J7jkC2prm2VpBNsqylzvQcGQHvJuzXw0Ekl2bKL//G9SrEVSV8xJ4hT6yx+FVZGDrqj7Tt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKUHiw99gp4mQYYf7JutBdwqxGcT2xlzenxwFLN1j2DaHVk6J
	J3rPIGUlS7tLcEoQvs8Th3vQV0KZr+T40RbVjEe/dc5wuDgak2E5AKm2
X-Gm-Gg: ASbGncuzTtbpJIheZTUX1/yDWRIb4fMD3NytDmMS4MaXgjueJiA2jlR+IShVB/PAxFn
	fPriFCewztydJY6KvkArt2DB0mlmsUy+x95423w1ir02aRxb0f6Ul1uHFZtp2IprSfshM+MGu0J
	PETzN2YbVlhG4i8jY/t1IDOtFDG0CjXlKDkzW8g4EHaCfSUUEmNUbK/vFIm2m6wvuUuN7qLcyr2
	t2AFeYdNhx2hMlCsQLqtiGEpFjf6bUgAvBzmGmautPccKT/aKO4FfXJPUlZ/i83Bzg/ThxtMmm7
	lnYpf+XmsEhGwnUQbRFalb2IAj2Q/Ft8TpD8C8zSfD0CHHsJaNN4eZG5ns+7NtvJy6ihl5mYYYa
	QYcG07firzPesTAfDPONBNsquc8hch7+f0TAaJQTsU3QWQQv47vi31eIyYnDCzBnRukZpdnOZ4l
	54xH2NHj/SjA==
X-Google-Smtp-Source: AGHT+IGgJXF55LKOLfygan1FdknY3MPOgSje7cnTfB9m7PtcORMGhQK7mNNBqRWtitLvFZ26Lo5ULg==
X-Received: by 2002:a05:600c:1d89:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-46e4925cb9dmr40017065e9.20.1759084090504;
        Sun, 28 Sep 2025 11:28:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996e2fsm212602475e9.2.2025.09.28.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:28:10 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:27:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in
 virtqueue_poll_split()
Message-ID: <20250928192719.7ea3a825@pumpkin>
In-Reply-To: <20250925103708.44589-13-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
	<20250925103708.44589-13-jasowang@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 18:37:01 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> spec.

If you care about performance you should pretty much never use 'u16' for
function parameters, return values or any arithmetic.
Just because the domain of the variable is [0..65535] doesn't mean that
'unsigned int' isn't the correct type.

>=20
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58c03a8aab85..4679a027dc53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>  }
> =20
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -				 unsigned int last_used_idx)
> +				 u16 last_used_idx)
>  {
>  	return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,

You can't want that (u16) cast now, I doubt it was ever needed.
Note that the compiler promotes the value to 'signed int',
so the LHS of the comparison is actually (int)(u16)last_used_idx.

	David

>  			vq->split.vring.used->idx);


