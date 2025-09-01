Return-Path: <linux-kernel+bounces-794971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D635B3EB1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260FB7A9D96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E742D595B;
	Mon,  1 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="X19rsRFz"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572992D5939
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741276; cv=none; b=XiaxIMVpxG79kJ9gIc1voqPozVl87iOSzauezlKHel28bPABIUNuZLQTk6u+Ch3eQ5m0qJmAnmP8gGd2VyOBaOKrv1DM/F+cZPhD3nAg0XdotsGpP1JvHTGZ1kF/nbcbAAN2r3e91Ab7TGNi6maqatloQ1kIunDRiOMay+lXlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741276; c=relaxed/simple;
	bh=7kFVcfD+IxNCst6vSp3QY/q+xJYIwtMvDsluFn4y28E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBym497XWZUYU2J/lbnxUi4isb4SYwTwa/DJPU2g/uI/U+jOSR+M+ntNjz//3tItofKfULtqDzrffvF7wRnh9K0Fzvl9HACXxaBh3ceMZuaPtpoIJ6zt1p3DkrpZdsAVb5D7QfJNQ22GPFSEi9JQkxnPYiqmiCOzVnTl0STC2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=X19rsRFz; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96eb999262so3293158276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1756741273; x=1757346073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHKEov60ZzmVR4/OSBANPJk+KzVHprHoCBj7JSL3kNI=;
        b=X19rsRFzHQvkLQ6cD7CL9FiR5rxmWhVIkJojGCWaNq6pHe2OxqKj+lT45O4i6r94De
         yGo94gFFo4KhdF7Fgvfu9xVojEGoEwbDM7WeVu7YojDIZh/Ses3oFN4cmc2VfPBu3gRA
         Iic5xYUp7hDepbCcvfw2Qb2Wc6OY1qEko6LllzbSnc1MIppuTUrUTKLFugqv5ag2bNhk
         JIY2fRFKQ4tqPyMpSHGmrPWR8bTMbq6PyBLS61TCvE795IhBhYUvHQHJF7nTZKmd9ERP
         0yJ0vfrLhV/Uw3oFKwLki3hGaWmYcS9XHb54UQtrpO3DSZVGN22yvF1Abw62eYt61+Ni
         LU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741273; x=1757346073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHKEov60ZzmVR4/OSBANPJk+KzVHprHoCBj7JSL3kNI=;
        b=VGKSj4F5BxTotSI3Lc7hTIb1Phb9f8uLkIeEugDGVDaxZl6AY2mSYKL1c9hhmGjuYN
         oRD+Q7oSqiD/1Xbx2XRaAHjpRyMIOyJEsa8VJBItsQPqp+Cm7mywv4PRj262VpzIcExy
         KSaIeljAufr8BG4fWVaWfvJ/V/VF/CzUjDgoDP6VvOX27dWajMzg0my7In7obPm1yIoM
         I4n342q0cIaz3MYwwCmbHGv+hfN3IsqWH64kd52v1JPo6gB5V+KV6QdcXkjak9tr7sqG
         2NYqNed/vwP8Sc1fq0Hpf2Rt1clJgIJJx2Jii/mu8wnR11wvxBQjV0VRWsPSz6om34AI
         waXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgLauEHxSI7loKK9Q/Rup+GTaGQ2r6IM36YHVEYyMkxJlJ1X/ZPVStbX+NCYz27NemUWJM1EETuQNfkI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/7s4tNLgs2hhBE8iiBkh629vnhhHMPimFI4Z2nJdAQE63zXR
	NDxUJjGjnsZS1FGETXBPePgIvlDrGy5YgYhoO59uI8alE1VVgSK3y7eMQXSlVTSXMF6s+/pWl9B
	XJfCOG9Y=
X-Gm-Gg: ASbGncurTIO436HVu5BHmXVEX3NOWQ1BltpknOOtR3I8Ak1M/ByUEw+xADPKjC0jgWd
	CU8Xj7u4YIpL9w2Zsgp3OqjscqUiOLANi+Fcp77TL1t05HWm3/zMwz3aUxUttqm1/UeZNaiRNGb
	Ey1Zuby6oTZnxyNVRffe0HSQxaun6DyiRGan78fbBqebL65pRmEY8gl9pteqiL2J3OeAaE/tQcL
	Jye397M0rdScJ2BS7v8z/uxrav5ltH/fytH0TMFy//T9m7E3vtn8Sv9LnWkEOeXUvk6VnFk5ktR
	6XH+9rjEn6bBEHfwJfbWh9WjN4y6dDNxOqhlQ0vrs3iO7AXACke5OYYaqDTVfCJUJvme303ndQk
	089/7MdR0Z19TPnp9Jr4/0AcHrrjQdEUmU5wbyQfmD/rvakcvjEhHW4gpYj67YDUcEbwvEwCVFM
	wbUpW6hwqnjMA=
X-Google-Smtp-Source: AGHT+IHshmBrcDbRWHW+DIQgXjYuWEls4RUO7+NexTMMLQQCo/dX5rge0WSIMFgz93lRWnOjPAIL3Q==
X-Received: by 2002:a05:6902:2b12:b0:e95:1cac:6393 with SMTP id 3f1490d57ef6-e98a5759c26mr8458902276.11.1756741273205;
        Mon, 01 Sep 2025 08:41:13 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac5aae52sm2088280276.34.2025.09.01.08.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:41:12 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d605a70bdso27902587b3.3;
        Mon, 01 Sep 2025 08:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDSX0KE8GrTk67c6gHAkO0vJJX2wI41+DZZ+izaKDeVT4QpWiXCe9YTSnqxSejAJQpogmnEH0o+JngvJUh@vger.kernel.org, AJvYcCXhi1RE6QfnHFrrwG5uFqpuy2QOYPn73KpByKxb7id5Ih7/g+AaQx8JIiyYOOx4eI55xFghVZ9OunHrKTdxiog=@vger.kernel.org
X-Received: by 2002:a05:690c:dcd:b0:71f:f866:bba4 with SMTP id
 00721157ae682-72276399149mr77541167b3.17.1756741272503; Mon, 01 Sep 2025
 08:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKcRW6fsRP_o5C_y@stanley.mountain>
In-Reply-To: <aKcRW6fsRP_o5C_y@stanley.mountain>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 1 Sep 2025 17:41:01 +0200
X-Gmail-Original-Message-ID: <CAAObsKBCPMzXV=2F4M2PrsES1M+0OHA2ZJtmYTuQMPPd1u34Vw@mail.gmail.com>
X-Gm-Features: Ac12FXx7SKvTTtIn3H-UONdlJo2MpxhJozLfBtiot7SO0qywsKGbTt0HEy5Ygf4
Message-ID: <CAAObsKBCPMzXV=2F4M2PrsES1M+0OHA2ZJtmYTuQMPPd1u34Vw@mail.gmail.com>
Subject: Re: [PATCH next] accel/rocket: Fix some error checking in rocket_core_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:30=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The problem is that pm_runtime_get_sync() can return 1 on success so
> checking for zero doesn't work.  Use the pm_runtime_resume_and_get()
> function instead.  The pm_runtime_resume_and_get() function does
> additional cleanup as well so that's a bonus as well.
>
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/accel/rocket/rocket_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Dan, I have applied it to drm-misc-next.

Regards,

Tomeu

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index 72fb5e5798fa..abe7719c1db4 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -74,7 +74,7 @@ int rocket_core_init(struct rocket_core *core)
>
>         pm_runtime_enable(dev);
>
> -       err =3D pm_runtime_get_sync(dev);
> +       err =3D pm_runtime_resume_and_get(dev);
>         if (err) {
>                 rocket_job_fini(core);
>                 return err;
> --
> 2.47.2
>

