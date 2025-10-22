Return-Path: <linux-kernel+bounces-865144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B24BFC43B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E50188914F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0315034B1B1;
	Wed, 22 Oct 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXWn21+l"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DD34B18E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140746; cv=none; b=cOryVh86PP6tYk264RbraXf20SxfQ5RVWYf9tlDjfahxAIrSUqQqZ6LybWjBL2WLSednQVF/ls/2I8a+DB3PIzWb1YmMtHnqZsvGEj1vXeopXiMMGVp4Z/4J59xiZQUw/vNpJ0R6fd+iNG0lU2Oc4hGT83vBZupwenQ+YPrjCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140746; c=relaxed/simple;
	bh=yqtWMn6RCYhT2LdGTuph46Dc3SLko07nw0VF1z3B/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnjBS3IOdmMkYVWYQso0IRrtL9nSd8vVr4MrTwS1I+phyzDV/vD2cB99/MPIprdnHftnTqD3NxL/fRh7OQqVxN2D33YR4VGfaCg79JSYulfR/qbzW19QfMAO0Zu20N3upb2120pZ2PtsHUPbBANOqyD2sKoNQIiPyfj0BQ+PedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXWn21+l; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e886550a26so5496091cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140743; x=1761745543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIYOJe3ka8O5pu8oWdxkEFZ87xWcphksyqXgF6ADSq4=;
        b=QXWn21+lhnWemyDGKYzpTp5YuPr9Cv9xB3m9j1DM5C2aoFbaS+gnxvmS9bY23HvJB6
         9k28CwSbjnKN2bOBlHTCUkupxqTn0+FbxZqoZ5BLNAgg8WG255sqxYfvWbV0IGpC3jr8
         eA0d6qgq6Cfx+MHLBKhfu0zGiRTi6NEHixy49F+XPVh1sKs1Ks9QNWKnznmxNmnHGTax
         4siqZ2iWiGcwP8EQJn+oAjT8izw3KJVNAfiO2j18Ia+/6LNDbG11uXj13zwiJpxOv2vw
         towD/o1zTOtmmjcimxpj7aQqwgole707b6RM+jDg2i90trKpQif3lEvRunsX5q22g5EP
         OEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140743; x=1761745543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIYOJe3ka8O5pu8oWdxkEFZ87xWcphksyqXgF6ADSq4=;
        b=arIOs9c+opOgoM5OgIxjoYMw8y5IPszWnggLaKWB2wEyvNdDlhwin5ZnnZP54vzFyi
         JffwqdkreO4XSAQ0fuK1Zli1yTDYs/fTzv66Di9oFZ2hiM7DdT5eOSey0Inw9mPdHcwP
         nahXY/IBirHljc9pf971PvgpwOmlVW39eNpXSVrGYmHwjF8iqq4KFtsPK+Jd9W7+iA6F
         ASVB3ioHHzUOJY8enxk/383Rrl5KAexhRopuKYiSPQCmumWACEqtVGn7AGTVB/BucebY
         dVAYK7d+4zO1PgWuE5jZlpHFm4o33g2mIGxHH0eHRWoRd7yvvolKQM6vhKJvQ7UXQ4cz
         JZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd8LuosbMeN3gSNLrBKZOdkt+ZDBstAyKlOXCTsX8lEtNVGNooeynbOHdd0YiAhHDJ73hhJ2NNdxNOlvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytE4HfCayNAAZGy4F17Am65NGk2m1vz1mBZyBSK2mM5b+ifxoH
	djjdnloMO3srvLgopWX33qI6F+cPvpnasnYO88uqSioxW+s4F2KNfsgVcbSsHd5Xj5kWZ8ZvmC+
	bF3wlkx5lF5Jd7Pods6K/87YEH07LlhQ=
X-Gm-Gg: ASbGncv0VJy60zPbwiJD0ZxVQFq50JqAUcMKQusoaNeDx6A+4m61kW4hwvfp8xabkw2
	ct/xysIfqnqnSUn4r5tTCLrxry8QSLCaL6H1MdNlxsaHl5Bltfzoo9uXTA7EQsXc83zOm+qn6Tw
	XDLhSkJ2f+F/E3Z1RtpSJca5lsor5Xlq8qv5gPapizF+EHY4lCiVF2o+Ik5Z8x5MIUdGlug0IVp
	iHIFS37GiDSo62+DgBjACY4yUpb67MeUHXqiT+27G5Sqoqn1JHk1tFtFsj7OkMXdHjdNzjatR9L
	OscudU3Bp4e/9lsZq0u1i+dMkuo6
X-Google-Smtp-Source: AGHT+IF56YHvRH/MTqGxxROGVcRUQbEr+0Cm42TWPTnoLlTvbvuksg92K6kAb7Dfb8VEB6gK91z+Obd6Zd2mBQqg7Ck=
X-Received: by 2002:ac8:7e88:0:b0:4e8:b5af:ab4c with SMTP id
 d75a77b69052e-4e8b5afb667mr177959231cf.72.1761140742906; Wed, 22 Oct 2025
 06:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102015.1345696-1-b-padhi@ti.com>
In-Reply-To: <20251022102015.1345696-1-b-padhi@ti.com>
From: Hiago De Franco <hiagofranco@gmail.com>
Date: Wed, 22 Oct 2025 10:45:31 -0300
X-Gm-Features: AS18NWAO0plVB9Z0NPP2vcgWMYOyC6CXUfEU8yV4bMVN_eMDJ2EcKqZ81g6EuHc
Message-ID: <CAK4ZnzmKOFYcC8YhZ47DgAp3oDhZmwhQ211u76-UaPYFmz_F+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Beleswar Padhi <b-padhi@ti.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, afd@ti.com, 
	hnagalla@ti.com, u-kumar1@ti.com, Hiago De Franco <hiago.franco@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22.10.2025 15:50, Beleswar Padhi wrote:
> There may be pending messages in the mailbox FIFO that are not consumed
> by the remote processor for various reasons; the remote processor may
> already be powered off or may be in a bad state. Instead of aborting
> suspend because of these pending messages, flush the FIFOs and proceed
> with suspend. Pending messages could also be restored in the resume
> context, but since remote processors are typically rebooted during
> suspend/resume today, there is no point in restoring stale messages.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Thanks for your patch, I tested it on Verdin AM62 and it is working
fine.

Please add the following tags:

Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt=
5ddwjvedaio@hzsgcx6oo74l/
Fixes: 1d6161617c10 ("arm64: dts: ti: k3-am62-ti-ipc-firmware:
Refactor IPC cfg into new dtsi")

With that,

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62

Best regards,
Hiago.

> ---
>  drivers/mailbox/omap-mailbox.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index 680243751d62..5e6373911630 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -341,13 +341,10 @@ static int omap_mbox_suspend(struct device *dev)
>      if (pm_runtime_status_suspended(dev))
>          return 0;
>
> -    for (fifo =3D 0; fifo < mdev->num_fifos; fifo++) {
> -        if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -            dev_err(mdev->dev, "fifo %d has unexpected unread messages\n=
",
> -                fifo);
> -            return -EBUSY;
> -        }
> -    }
> +    /* Flush out pending mbox messages before entering suspend */
> +    for (fifo =3D 0; fifo < mdev->num_fifos; fifo++)
> +        while (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo)) !=3D 0)
> +            mbox_read_reg(mdev, MAILBOX_MESSAGE(fifo));
>
>      for (usr =3D 0; usr < mdev->num_users; usr++) {
>          reg =3D MAILBOX_IRQENABLE(mdev->intr_type, usr);
> --
> 2.34.1
>

On Wed, Oct 22, 2025 at 7:20=E2=80=AFAM Beleswar Padhi <b-padhi@ti.com> wro=
te:
>
> There may be pending messages in the mailbox FIFO that are not consumed
> by the remote processor for various reasons; the remote processor may
> already be powered off or may be in a bad state. Instead of aborting
> suspend because of these pending messages, flush the FIFOs and proceed
> with suspend. Pending messages could also be restored in the resume
> context, but since remote processors are typically rebooted during
> suspend/resume today, there is no point in restoring stale messages.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  drivers/mailbox/omap-mailbox.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index 680243751d62..5e6373911630 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -341,13 +341,10 @@ static int omap_mbox_suspend(struct device *dev)
>         if (pm_runtime_status_suspended(dev))
>                 return 0;
>
> -       for (fifo =3D 0; fifo < mdev->num_fifos; fifo++) {
> -               if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -                       dev_err(mdev->dev, "fifo %d has unexpected unread=
 messages\n",
> -                               fifo);
> -                       return -EBUSY;
> -               }
> -       }
> +       /* Flush out pending mbox messages before entering suspend */
> +       for (fifo =3D 0; fifo < mdev->num_fifos; fifo++)
> +               while (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo)) !=3D =
0)
> +                       mbox_read_reg(mdev, MAILBOX_MESSAGE(fifo));
>
>         for (usr =3D 0; usr < mdev->num_users; usr++) {
>                 reg =3D MAILBOX_IRQENABLE(mdev->intr_type, usr);
> --
> 2.34.1
>

