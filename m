Return-Path: <linux-kernel+bounces-732954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888BB06E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325604A3C18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46501288505;
	Wed, 16 Jul 2025 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbnvmZBk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412310A1E;
	Wed, 16 Jul 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647982; cv=none; b=Zzrv7n4/1uD0gN/Dp5y8pmh5p9duJOAOHU43rmHm9INe8rtM22HMvVM96vr+rJlmDu1/IKXhcxGcgrfO49TJk6qRAqyfzFFq4SQ3yj33AqEyg4+R/jzmqRUWnZgPVGX7rMlnFK92kVXu2m5WJK+SeLih4q1aQw+ttNjfBOYMpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647982; c=relaxed/simple;
	bh=wVAl89vNB9bQpcPM0aETCscy7sJDvB/jsurR5jm9dw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjEJPn4+nqhr3Ir/SOaFrcrr7kwKt9B3mvgxkCVxJCnkSCQHP1/jMqH+lYrU2NtOd7Z+oIrI7Pq0/xeUnXCRJ57eQdpetR6VvonLTQat7UQaB3iAQuCeIc3HwSb21eAD4H/pvf7S1c2OPzAVGILP+HElj0qOfGLpXVDVCwr1apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbnvmZBk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so34465615e9.3;
        Tue, 15 Jul 2025 23:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647979; x=1753252779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vx/AMb1QPIvfX8nuyQWz8qCHUMZ5dzTF0SG+aBrBZnY=;
        b=kbnvmZBkG2Hj8JPoTn1B8SI950xlLkNSK49l+2cPpNTnIgi5qYaJOuCRm25zyzcxXe
         48glHuXM4+0FPSYZk1iHQAANkQIzsjfGQIhpycay/REDrHXEja5P0xN/7CeN4yamiT4r
         KrGL9U3zVuD7qvAOh1mY6K4q05GfR/NHlIUh1c/tF1hV2sm5vdFq02iIj9c/KqkEna5U
         6UX2ehTM6U6ucT8hGF/n3pbv8H9yvCXqL42pAGf2V6LClrVms4lITV97RRVx767MaecS
         QJLsVUaRRfXv4Nx8LxBRNrLEY22kubWRiiLuB3jTexKlHtitlrrWjITqXhUMo2xwu2c0
         2BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647979; x=1753252779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx/AMb1QPIvfX8nuyQWz8qCHUMZ5dzTF0SG+aBrBZnY=;
        b=Ltz5oHAp7wn83WWLC7KC0h4QwAHveXxwGt9uEK+ZfLtepdZvBO3d0sZD7T65bJ9Ynd
         WuxjqrWUeOa7XLDq3htogdMQnlJDj0JMJ1XTsU00FN0hvrI6WHwn1Bd0mBJjfThSDE/K
         r5EvJIVHE4gN5Iu/pldBeLLX+rzQCsu2iDr6hPNa0vmlCjr/2NJEE4k638GZACqooiaZ
         2lz5Rvas3RICB2C+M0zuISKTx+ZYVLSOzUJOsN6Ehg2hdu0zZ/bL4Hn17nmgboM1sKe0
         DON73tOU1tRj9AQuK9eaAB0Efx/5k6rOB/JgFbtD3dNwKD5JjR4nc7Iwy8NgVRuhpsAe
         7cfg==
X-Forwarded-Encrypted: i=1; AJvYcCX9bEsjapSUuKAUu3JfM4wSsRKNuv8tKVkSmrWy3Cin3+ghgYoTqDCYhLrjaNo3YRwBmxK1jH/t0URuvXQ=@vger.kernel.org, AJvYcCXLDGfrklS0dzr3jOqNkL2RGZXCqiT0xgtmQygKFSWc9i3VLILqVa/dalbRWQbG8DdzB3WNd2GiXYVYKlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj24O6LNclXsFy84zIa2EUNe8zvxDFkXOv1w9U/LYCur2hXglh
	u3yZBwa5jTiXD4jruqR3G394Dl0IBP89wonYUvC02eI3tpTUJnaCXbmV
X-Gm-Gg: ASbGncvpQ4sBujVwKmpxFlXChvoB3rhMN4OCDumkvyXsCgxpWWUKxdl8zlX8SPPKrAA
	t22I5EDzVP0+zJy65fJ8/vSdAFF4YY8MRLNzMqBcWNAtbrOdhnZRGRlekjDOD5RoSK/mDKaDt1Z
	TanL1i/58kSDYFT5W9HShHg+Tts/v2oKNljX3Gm5YiKEmbnUCbqKQ7W/lfKlW2gJ/J2D9zD0R5+
	WWYMD9AGghq2vfYS2HApJrhh19wSjEJ9ndQVKc8EsfMNwBVo4UUwijqynKWiM2msxGZprl2EM+9
	FmB/SCzj1yIL5iiWtp8sSwK/PeN1KM1n5/PDMnFJsG/ii3K+qyn71Wpt2Plk137aVZRrgQLKrRj
	wwLQi5nnYFdvCGVmnRfACrKPVnS7GSE7+8BIQv8umMrubkw==
X-Google-Smtp-Source: AGHT+IGUG1jgRIe6VaJNG8sGjMJZU+EMNXNjgLQG0ccDb2MUmEb0DV0HVwBFDTd7jE9GRr1Yw3j7ZA==
X-Received: by 2002:a05:600c:3f09:b0:456:d25:e416 with SMTP id 5b1f17b1804b1-4562e331640mr11432835e9.6.1752647978922;
        Tue, 15 Jul 2025 23:39:38 -0700 (PDT)
Received: from [192.168.100.21] ([41.220.242.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e832dfbsm11032085e9.29.2025.07.15.23.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:39:38 -0700 (PDT)
Message-ID: <4a7f48ff7c3a93afe4ec3847addaedf75f95ac03.camel@gmail.com>
Subject: Re: [PATCH] staging: sound: Adjust mutex unlock order
From: Erick Karanja <karanja99erick@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Date: Wed, 16 Jul 2025 09:39:34 +0300
In-Reply-To: <87tt3c8wye.wl-tiwai@suse.de>
References: <20250716062331.375090-1-karanja99erick@gmail.com>
	 <87tt3c8wye.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 08:35 +0200, Takashi Iwai wrote:
> On Wed, 16 Jul 2025 08:23:30 +0200,
> Erick Karanja wrote:
> >=20
> > The mutexes qdev_mutex and chip->mutex are acquired in that order
> > throughout the driver. To preserve proper lock hierarchy and avoid
> > potential deadlocks, they must be released in the reverse order
> > of acquisition.
> >=20
> > This change reorders the unlock sequence to first release chip-
> > >mutex
> > followed by qdev_mutex, ensuring consistency with the locking
> > pattern.
> >=20
> > Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> > ---
> > =C2=A0sound/usb/qcom/qc_audio_offload.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/sound/usb/qcom/qc_audio_offload.c
> > b/sound/usb/qcom/qc_audio_offload.c
> > index 3543b5a53592..ef144d2be7d2 100644
> > --- a/sound/usb/qcom/qc_audio_offload.c
> > +++ b/sound/usb/qcom/qc_audio_offload.c
> > @@ -825,8 +825,8 @@ static int uaudio_sideband_notifier(struct
> > usb_interface *intf,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	mutex_unlock(&qdev_mutex);
> > =C2=A0	mutex_unlock(&chip->mutex);
> > +	mutex_unlock(&qdev_mutex);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
>=20
> The same pattern is found in qc_usb_audio_offload_disconnect() and
> qc_usb_audio_offload_suspend(), too.
> Care to address there as well?
Yes, working on it.
>=20
> Maybe it's better to replace with guard stuff, but it should be done
> by another patch in later kernel releases.
>=20
>=20
> thanks,
>=20
> Takashi


