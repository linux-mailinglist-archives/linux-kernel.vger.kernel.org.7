Return-Path: <linux-kernel+bounces-882300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C6C2A1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20A03B08C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7428C871;
	Mon,  3 Nov 2025 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX5/7TfC"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7A285CAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149369; cv=none; b=HiJxk4VC/IRgDGqUUN0clKuEwPrilhQHuRwD2ZJ4Ybu3afRL0IObxcV/FHUs4J5nh+s7OjvkuDQz/Hrdj1j/kQsHwuWAzn6MbZXuaW+wgta0cJX9QYjTzoOYX+mG3kSztFd+9r8bOYfJVUZ3iIr2tT9B304WwfpSR4xyR+yIVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149369; c=relaxed/simple;
	bh=UtorwXqAXSaw0nE6ogrsZcNgRw2KJ1yd8pf1qvskGWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWcJFH3TqnCifkEzknDo2+SH1Mox+LTHNL5ZfgthJM0IcC6/tnKV7N02bUlBYfS2GzaLb+QWnVDvU0A+OMkT5u8hhaqJe6mlzWm3BZ7ns2cVAwzr3V+xAxLbL2/lyTencEOVr+bd7P5JqNef982AVbChMp9rgJhI1Ds9eWJ3Eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX5/7TfC; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-945a2c8e52cso176251139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762149367; x=1762754167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySAXejUoNq76L1FW98+NXykq6E7oItJRChqh2DI4aaw=;
        b=aX5/7TfC+l6J8ywagSPZzofiO59rYgAlC215e3no9rz6X9kiqRMQuu6/JHIhWBQYRp
         PdO8loU4b/8CrsEYbVPDnZKYBUEfgAbp3Q/7etU5rLEt4qT7whSfyPEApPckhHdQPCXI
         zBcZSkfMDYES9mcZyGf5gYypNtrJMUqqXqAqBDlEdL7K0TMqRoOMV4GiZNFHn9Di4Bve
         eJTJqH/QZ2/hIFSrbd8Vpcip3dU0AuTV6oO3n3k5vio2J1NmTVpHTVKeyFI8VQBgB6hF
         CfRlFN0U/hUQUASkOs8dtmR+tqoDFd9J8A998bJAX115zb1/EUY+zAt+J2kUspZLV6tn
         h4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149367; x=1762754167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySAXejUoNq76L1FW98+NXykq6E7oItJRChqh2DI4aaw=;
        b=UVDRsre566yXk2qkB65XBI9CTEiNme9C+1Yin9ZgDY+Gsy1uNUhsk8emGENsq+uu6d
         RYWWTAbI3OvFUZO0WBU9yipZkWrvMw0UsXLyTP9bd6PLvEw+tjAm+VMa5kcQEDMaL+lG
         Qnrd0GqO/bInHgIH3KtasEng/Vxkf8ZV00JdiT74kvXbZ6zMNDzMuwXy1kWQb489EoGN
         vXAQcmT39gCoTQH6ag/EMZUVvbTAWGJqGFVTj5qAvFAwzojuns9zsOA5KGNcOXhQDr6t
         fIpqYfhDBXe0IfzT8hNvuvNAbEM8OlFSYZs2EVp7bc/XpSGprqmkrrZgzPyp6z+cNkLn
         xoEg==
X-Gm-Message-State: AOJu0YyupVB1wkJ9CvbrdbxdJ8jnUvhjt/hc8LBJZP0dnar51tALlez1
	mFSzIuajFQ0T35yIQWrCABddoQ1DYwIrzbndeqc1V6lmoG1Snx8wOazEFM1M9H+kXbHAjOMwt2H
	1mp2+uxQhRTAU45vvcLmMXspdPYY9c4E=
X-Gm-Gg: ASbGnctQ6CC3p/tW+/wzOfMaySKH6sE59ONWuHUDrASfcrI1imr7O4wF0OV1xueSYze
	LD/MMlqjPNHoQfMOw1qL7Qx7j1cVlYmni96l60yEh1ZBJvsXANS2iH2wLlKM9Cu556++3TdcTy2
	W+Hqf7a9JEOUPAXpEiqlCpL7v+2i/NOkVpLi0orZ6VrG8opVV45CqBehn9l79E+ZVnoPY6sDm/8
	I1NVLdwUkyRGE2nvml/l3zmouxj6y0qfFYgi9QMt+fQvOC2YV5DSgACNpN802T7L1Fu4KBm
X-Google-Smtp-Source: AGHT+IHz1WqkJLOQpAsugUSR9cfTeJQ8hKAkloJI+TOdjd0I04a3WY4GgJThMDp9IKVL0MBacyB/e/dDtgeh3QWSt4c=
X-Received: by 2002:a05:6e02:1566:b0:433:3487:ea29 with SMTP id
 e9e14a558f8ab-4333487eb72mr651165ab.6.1762149367038; Sun, 02 Nov 2025
 21:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015094117.535157-1-rk0006818@gmail.com>
In-Reply-To: <20251015094117.535157-1-rk0006818@gmail.com>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Mon, 3 Nov 2025 11:25:56 +0530
X-Gm-Features: AWmQ_bmsn8XGUapnm_MiE-Vh-5KxCGmgAdRjXmPAKJIrnxfKalBNNin0FQp-UH8
Message-ID: <CAKY2RybBidcyMtUY8mwyT=F2e5f=HT9HR6JXmgz+UyU6_S3kUQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: stratix10-rsu: replace scnprintf() with
 sysfs_emit() in *_show() functions
To: dinguyen@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:11=E2=80=AFPM Rahul Kumar <rk0006818@gmail.com> w=
rote:
>
> Replace scnprintf() with sysfs_emit() in sysfs *_show() functions
> in stratix10-rsu.c to follow the kernel's guidelines from
> Documentation/filesystems/sysfs.rst.
>
> This improves consistency, safety, and makes the code easier to
> maintain and update in the future.
>
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> ---
>  drivers/firmware/stratix10-rsu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix1=
0-rsu.c
> index 1ea39a0a76c7..53c896ceca9a 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -454,8 +454,7 @@ static ssize_t max_retry_show(struct device *dev,
>         if (!priv)
>                 return -ENODEV;
>
> -       return scnprintf(buf, sizeof(priv->max_retry),
> -                        "0x%08x\n", priv->max_retry);
> +       return sysfs_emit(buf, "0x%08x\n", priv->max_retry);
>  }
>
>  static ssize_t dcmf0_show(struct device *dev,
> @@ -632,7 +631,7 @@ static ssize_t spt0_address_show(struct device *dev,
>         if (priv->spt0_address =3D=3D INVALID_SPT_ADDRESS)
>                 return -EIO;
>
> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address)=
;
> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt0_address);
>  }
>
>  static ssize_t spt1_address_show(struct device *dev,
> @@ -646,7 +645,7 @@ static ssize_t spt1_address_show(struct device *dev,
>         if (priv->spt1_address =3D=3D INVALID_SPT_ADDRESS)
>                 return -EIO;
>
> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address)=
;
> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt1_address);
>  }
>
>  static DEVICE_ATTR_RO(current_image);
> --
> 2.43.0
>

Hi Dinguyen,

Just following up to see if you=E2=80=99ve had a chance to review this patc=
h,
or if there=E2=80=99s anything more needed from my side.

Link to v1:
https://lore.kernel.org/all/20251015094117.535157-1-rk0006818@gmail.com/

Thanks,
Rahul

