Return-Path: <linux-kernel+bounces-867472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F9C02BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8340F4E4CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E33491FC;
	Thu, 23 Oct 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDyKTGbI"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFF35B124
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240634; cv=none; b=ZaI0zfSSqpgQvOUqlqIuWPeXk3bvkeu/0jwbGv463WE1+8IFE2f/yRmyMC6Fj54/y0K2F9WaxWm0Uk0q9YdyaFn2pnfzDRkLi/QYv52dbcwcojyw420AUsHc//L6tw/Cf0mXdMaftnUM/EuhRB9VD03iKJpf2yN90xWESmXiUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240634; c=relaxed/simple;
	bh=3R3FFQDckzFinPZ9DYjEUNKdg4nDN9YOsYJfidN7V/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCZ6Q+I03E0wqRYwL0bzQjSfYffA4FIx5GJZEYFrMiEh/2ZVDjf+WWaxH6AGCLvtct0eZAi6etHT1KeaNF5i9kEQdgFpS8pYR6Yu1Ie7Ps4ld5a8gu9T+kUNjhdw4OYRvRbhUEfVxj1c1rH4/WXXFOPqjRtb8iSjj0tDUly9qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDyKTGbI; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43fb60c5f75so240997b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761240632; x=1761845432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q0ZDfwbl/u7cybt8YKpCyUwHveVPSaljmjRaq3VaaQ=;
        b=iDyKTGbIljH5PXCy5JUP4gslZmJvdIGXrhGEzy+1t7omMmLj0sO0arJGllb+McyT1u
         eVKB26+9dklELx2CbWY9y024Qw6r5Cc8Zvp+EAFSy+/aLS530J5S23NHCaKNoseH51pj
         iuoyWsG1Wg6oz/dHInpH7UYWci26DOJniR6z6+yME7fPOjSklfRVk9m7gD+q+ypHMUs/
         6TNsgWZeNh1CarzGvcgPw1E/0r5G1zNCRoYadI3a0W9Mf7LpFeo9PS3bvsyA0twPmnGj
         0gYEPAnwwsa2IUIfM5c/NKRWurLuNZDuqa1X84rjYHbrKRW69QWnVKAOYS85x81oES8p
         4xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240632; x=1761845432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q0ZDfwbl/u7cybt8YKpCyUwHveVPSaljmjRaq3VaaQ=;
        b=n4Z7M0DKTwIJxwqBOw+gT9VS47xgdgYqG+qEk2OP6BNYPnJsnESk/6hNQ8J+UPqCSM
         ce3uE9xhJLz4YYBraOACwGJjprWn8tvINR8GrZhs581ayfHBiRIPcDRe3x3I35IFy/qS
         Yf0YuVIh4aQZjP95pAsE5t7IF3VXzs95wWUaPC3+I5WmQBGDvdweQFm9jVh7c3kXix9+
         HPQLNgcX6VpnEG8doZ0T3GJvjEMBRYnXsySWB8mxdw3h1dCIdhAgcbQ1D76r2Z4xYZ9B
         m2C5xaTIv1MMaauMQKsyUhjVOpbY1IoYEh1aGyPxZ8M0BTFfEkl36L5FuoYwCwpCTfPG
         0a+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuWLMi7Z1CLNsGd0FkOdTBEw7Eufs8ehLm1u9NWtBxXii4WCllmqGekZbhfi9n1b8oxIV6wiTzfZAbsIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+DXO0gJtmTrqUKR0r/9iTVZOuiWv0mNwT7fp/WLD/0XWJa5i
	S1UrYj0hU+nzdnv9xsDkKL3XU7hptXuBLoQqK1MxifcpM3d+Fn3rtHalT64Seg/7g8hI5L8sn+t
	zcQtEr+rTDaTL/jFstETuf7i8UiVKE3t9eA3xD+L2m7jPuocOWsBs
X-Gm-Gg: ASbGnctCLOCyAJ6AdPc1EC3zD2gCcWh2ndqYnsiD6fssfQvwBYyqYYqCWzMEi2GUF5h
	coLGfEWFQJp+W9Sgswl/jcLnuZ5Bcgv6complZzwK/GNBoQLTqoAzzHEps8CO98chSuATnoOwWs
	RD3IahGyJcCQtkGWYjbIjgGEkXdfdlO3kXhncUVe/UezV7maTt1fJt6t0FcTAbtKm2xp+apzIXI
	0LXXp4fkNUUCk1RTjs9+fGyfl+HbOGDJge7eRAFxfhk1mimdG1s78mGh4w/W3Edr92x5A==
X-Google-Smtp-Source: AGHT+IGQZb/+WiP0CrvwARqmYEBm3+w/xU0bS9W+t7PIXzN81QWPsXUtM+r7NNZB2Chz3CZ4OOyIxS/PfDaH9o77eNQ=
X-Received: by 2002:a05:6808:1304:b0:43f:46fb:cb92 with SMTP id
 5614622812f47-443a3013dc8mr10225394b6e.48.1761240632004; Thu, 23 Oct 2025
 10:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021124254.1120214-1-beanhuo@iokpp.de> <20251021124254.1120214-4-beanhuo@iokpp.de>
 <CAHUa44FfQAPWGgVbfrCnZfF9HkGwW=fgUhV-y9RKrUQf1V6yNg@mail.gmail.com> <9f3d1d277b0d102b5d912b533be21ed78103e142.camel@gmail.com>
In-Reply-To: <9f3d1d277b0d102b5d912b533be21ed78103e142.camel@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 23 Oct 2025 19:30:20 +0200
X-Gm-Features: AS18NWAw--zf1xvWFn8x1bXCYQIGoU7cQtPmENDlCdNol0eKwsUCjkp7RVvRtiI
Message-ID: <CAHUa44FCYnQ7EL8pXH-72ptENus7KZRvfE8Ym1vjN4QiVsVtqQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver for
 UFS devices
To: Bean Huo <huobean@gmail.com>
Cc: avri.altman@wdc.com, avri.altman@sandisk.com, bvanassche@acm.org, 
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	can.guo@oss.qualcomm.com, ulf.hansson@linaro.org, beanhuo@micron.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:09=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Thu, 2025-10-23 at 15:53 +0200, Jens Wiklander wrote:
> > > +       device_id =3D kasprintf(GFP_KERNEL, "%04X-%04X-%s-%s-%04X-%04=
X",
> > > +                             dev_info->wmanufacturerid, dev_info-
> > > >wspecversion,
> > > +                             dev_info->model, serial_hex, device_ver=
sion,
> > > +                             manufacture_date);
> >
> >
> > The device ID is part of the ABI with the secure world or the firmware
> > we're serving. It might be worth adding a comment so the format isn't
> > changed without understanding the consequences.
> >
> > Cheers,
> > Jens
>
>
> Jens,
>
> I can add, do you have suggestion for this reminder message, for example:
>
> /*
>  * WARNING: This device ID format is part of the stable ABI between
>  * the kernel and secure world (OP-TEE). Any changes to this format
>  * must be coordinated with firmware updates to avoid breaking
>  * communication with the secure world.
>  */
>
> or
>
> /* Device ID format is ABI with secure world - do not change without firm=
ware
> coordination */
>

The latter should be enough.

Thanks,
Jens

