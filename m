Return-Path: <linux-kernel+bounces-860068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9ACBEF3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5DD4E55FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF72BE7CB;
	Mon, 20 Oct 2025 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cY3XfYRL"
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CA29D270
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933925; cv=none; b=GtPXIJ78Yh467kT54i3YcT8omz8tyn18ENGXfCggWMflT90Xyy9K6YJJ0xdKs1yNn2ibrbecIrbcd0LKJmfsUYw8VBE0FLxcMNatu2G+PwMdXjNxU+JUNiRlLhguddEeL2CNBcSIJ80RpFPXJXOfQVpJgeNN2dB2AxdOwSmnFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933925; c=relaxed/simple;
	bh=/0pakXuJOP4sYjdq0m56tZkLYhDhXzvPuohqy5H5sec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0i6QrE1RPOUPB0dUQWe2deTT8TGkvI1Q3mJjhWnaCWZT4gzbXBvxFJQ8k3AQR475moC0RO3zHd3psyIAy6c/l964gU98YiiSvOz2eYEJ/KumVKxXEZFbqseMlgnuznHFaM+eYxbC6Y0nsNvzotOxAsWX8AXWm+mYdGjHaSgrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cY3XfYRL; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-780fe73e337so49982557b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760933922; x=1761538722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LuEwGaQ9XPJJOLE/3JYHnXypAPS6UCg+XXTTsvHk/N0=;
        b=vofpccMDRoFTXs1zSKAZI6n0flOHUDhD9FT7B3W8QCyrSJHmQ8Nx5kCJyOWnX7XW7I
         5qwl4k7/4UeGHL/KlwtCHGhZIAYW22qxkW9lKSbOsEz/DvZ9SVFgHWyxRKYqgClQHyy5
         XevW7AY/HYKSKqjCWDXBbgE9ariX+heH46W/3jH9xSsvfzyOvKuB9luWBYPyJH5iuxym
         OCbKKGv7e8qFIJSX+AeFKydbi4NVbHQHupw+CcTm/xHlJFhLrT13fXROXq+DlTfBf/qg
         B5frlJlPB4Ou6y0zGux/fxVSHY3+pT6jcosao801njJEod9Ed8e7H9dWu7aJunMeU9m9
         2GYg==
X-Forwarded-Encrypted: i=1; AJvYcCXf+oLUGVyBZLRSbPT4ZkLZQf6Ff1YcFzA15y6AgVnuK2JIFLbDA+EG89vdIIvEB/vMEZD7LYcr5OQsloo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPO2oaBcrbYLXqVQjUiBD3puxGEWKjES+DSSuUOckKIJ+dchyy
	Tq5hdD7r2aEs+fc2Fh3MpsxC3qOGyFQJeRlMyg3dDtd1AP/2xDD37w6i1qjF7BjMldVRBZo/GHe
	xOEC/m+hUKq+Tb1xOpeD3OFYQCErq5oU9mTxY38PLNb+wrFxM0+mDHr3gItcnCgDnK/yui3tIKI
	Y+maGJSfSIEcmCL95ef5KvVWmJ9B1UT4B8CnmOTKMYiYj1AtP1LMeKPEd2ACEhoh7U+cg+fgGnS
	5xQa1AQ2qMfRTPY
X-Gm-Gg: ASbGncvyv3Nkp8jATLCiMCbCC4QnfgjvJq90dKNJeAii9uGSBcXikDmeUMAJDQN+HYL
	i0fSkdRG7CQbT2LFcvdr7L9tSEA4wKHnrLUDxI9SpVPznlNlJTjQjs4oXK0k0bkL+elvosaNOk0
	OVZ8c3Kt+okeJK4OCAgtaSmjwBRI3pIYldeDQuV36HhFZlwIhK7BNPGEuYV7OafCi7+sgipnRbX
	yEQJrsQblm5ghs6tZfBTCDt7w+ckjiUyg8a5U5ayRPxPYfjMWEeQLUkhMX7lIvGJSKqI+Z5VKUW
	nQK92WVAf/HexXc8bwxly0AWTjNSsQaakA9pm1L3aVvgJNupZ+O5ZCm4+JLXrI8Mqe1/Des0nP+
	dlATFtbeTfjBMbtXX5uqsGpk/kvnjqWd+zL8SkVfRYR9Ulws4SnCmSCZmJSkVhsly5zaVr363td
	z2uBwqz/jnF+Ugq1X1QzJmPwuue8fVh2o=
X-Google-Smtp-Source: AGHT+IGglIkH9HjaVCgrV5Wa2kPiaOvM+ezpmChg0PQlqHG7FZZTiKT8ceOCxGyGwXEZV/ruQwWKCvh+jxed
X-Received: by 2002:a05:690c:4984:b0:784:a497:94d9 with SMTP id 00721157ae682-784a49797acmr4101897b3.23.1760933922459;
        Sun, 19 Oct 2025 21:18:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7846739f5d8sm6076227b3.12.2025.10.19.21.18.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Oct 2025 21:18:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-368ab6919e9so28436421fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760933920; x=1761538720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LuEwGaQ9XPJJOLE/3JYHnXypAPS6UCg+XXTTsvHk/N0=;
        b=cY3XfYRLbxqsyGj+4L8sWZmZofT+ISaFwULdVREmYiCeuofoX03435lj6ZuTm8FxxX
         kb9DFFghaGCA2zKHiQZ1vfhlKoGe8yHql08OJoQEc0/gfg3UeWUnJ8VfgiXGii8cpkij
         mgu07qGPRrm7f5Xu/Jb43D1jA1DElDB/3l3Wo=
X-Forwarded-Encrypted: i=1; AJvYcCXeJ3hTG7wsXebNJ03ahl02lOpMv7Q2q5Uq9DGv9Wr+/IO4C+XyIo3NQOt5AGuw9kK6mlYk5xt1qZAf7jg=@vger.kernel.org
X-Received: by 2002:a2e:bd03:0:b0:376:46ba:863b with SMTP id 38308e7fff4ca-37797acf5d8mr34135191fa.48.1760933920572;
        Sun, 19 Oct 2025 21:18:40 -0700 (PDT)
X-Received: by 2002:a2e:bd03:0:b0:376:46ba:863b with SMTP id
 38308e7fff4ca-37797acf5d8mr34135121fa.48.1760933920090; Sun, 19 Oct 2025
 21:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054913.7871-1-opensource206@gmail.com>
In-Reply-To: <20250928054913.7871-1-opensource206@gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 20 Oct 2025 00:18:27 -0400
X-Gm-Features: AS18NWAUosTKQ27jce3TjH-AKPgTyXEsX5FyBexjiVIyYYWsxmdZmACNDacFTF0
Message-ID: <CABQX2QMgZ0VGQ+-RhF0suTyL9qkU1Hf5V7g2jvPQ+CwTEidZKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace schedule() with schedule_hrtimeout()
 in fallback wait
To: Pavan Bobba <opensource206@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d542ce06418f60df"

--000000000000d542ce06418f60df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 1:49=E2=80=AFAM Pavan Bobba <opensource206@gmail.co=
m> wrote:
>
> Replace the open-coded polling with schedule() in vmw_fallback_wait()
> by schedule_hrtimeout(). The old code wakes up at jiffy granularity and
> leads to unnecessary CPU wakeups during fence waits.
>
> schedule_hrtimeout() provides high-resolution sleep with finer control,
> reducing CPU utilization without affecting fence correctness. For the
> non-interruptible case, use schedule_timeout_uninterruptible().
>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_irq.c
> index 05773eb394d3..64045b0efafc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> @@ -202,16 +202,12 @@ int vmw_fallback_wait(struct vmw_private *dev_priv,
>                 if (lazy)
>                         schedule_timeout(1);
>                 else if ((++count & 0x0F) =3D=3D 0) {
> -                       /**
> -                        * FIXME: Use schedule_hr_timeout here for
> -                        * newer kernels and lower CPU utilization.
> -                        */
> -
> -                       __set_current_state(TASK_RUNNING);
> -                       schedule();
> -                       __set_current_state((interruptible) ?
> -                                           TASK_INTERRUPTIBLE :
> -                                           TASK_UNINTERRUPTIBLE);
> +                       ktime_t delta =3D ktime_set(0, NSEC_PER_MSEC);
> +
> +                       if (interruptible)
> +                               schedule_hrtimeout(&delta, HRTIMER_MODE_R=
EL);
> +                       else
> +                               schedule_timeout_uninterruptible(delta);
>                 }
>                 if (interruptible && signal_pending(current)) {
>                         ret =3D -ERESTARTSYS;
> --

I don't remember exactly the schedule family of functions but isn't
schedule_hrtimeout leaving the task in a running state? In general it
looks like with the patch the task's current state doesn't match what
was expected, plus I'm not sure if I quite get why the uninterruptible
non-lazy case is being replaced with a lazy wait of NSEC_PER_MSEC's.
It'd be great if you could explain a little bit better what you're
doing here because the commit message is missing an explanation for
either of those.

z

--000000000000d542ce06418f60df
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAtG
QoE03jQlv75krOf9kQgrtFytEbLqw6/tIYbUNUzQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTAyMDA0MTg0MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJjfKhKfR5dLhKoVRj5EsuzYtcWD4JXn5XsSy5zC
Xwh6or6UtXDeHHSv5JVi4qTRXsNoOQw0W3tl/8H9g07e86HyPyMMtXMS9hdDADsoqf0yvhsS6hA5
nrbfLj9U/sKbc2Yg39+kAS0LAHJtEd9hUGVXCZ84wpMhHo0W0V2vf2EKvkJLW64BaFptD7gOzUUj
XdNvmWAcdzEU7wNOd+RzLDOPsBn5T10vE3ZXirclNW0qwTd615OefymMPrsiFkr1YgGjYvYZc8dv
Kzb7aQL65VDM0k1Kjnq2TV1X1y3puw3kCx0liPKAUSycqrYIakB3hcUTcnpez8um8J0KeAUsurw=
--000000000000d542ce06418f60df--

