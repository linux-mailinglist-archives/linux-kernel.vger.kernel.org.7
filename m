Return-Path: <linux-kernel+bounces-724641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4327AFF54A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7181E54861F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C426D4C9;
	Wed,  9 Jul 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4XJA3Nt"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F926B2AD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102901; cv=none; b=WFpWC9ck4byWUbTJFODR+y0RhBVILJM8BliL3HO0005sOZah597IHYs2DUBT1HgDBnvLLbZjmFRcaPzUSyyfbAVusKTIVX/q9ghHXLV/TlmWxcpPdsSVUP4TJBxyjwNV/BhWs69aZWfB4Nf6VleSxojg6fonKHFs0OhQTWCkVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102901; c=relaxed/simple;
	bh=sARTWO+1dgLX09VHRQZHHDCKUYF3wgFz7Pen6Ocb7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5y/jW6xzoGan9xk1l89ZrSc4Psuae+t+pM1W+TQtMZed2ZrMINhhl74hs94UQrZgmA0Wqu2aXdDfBrRht3is7dJ6YtspH/pz/ZqGnzQ8ptKYMce0cdVAlvKZFlbhW0Q4iqr4GM+yU0yNIGK/uFmY0aDoJOIYx49WadJO3lHDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4XJA3Nt; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2ea34731c5dso236162fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752102899; x=1752707699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvN5sQS4Hc8yxkAu/k1pA/cn0ECnEOzcsV+Wnx5E3Eg=;
        b=p4XJA3NtCMUjrmRzVIJl67N4MT9rIm3oDyxl88SFL5ebrU/jTiIn3kt98HfDYBVoxk
         1iFBsLl2y26DbKfEvHHL3ZrMrTYOPuMmyDKumyuemxCu9PEt5I5FqtbTm92ZMjqACXyN
         e9oC1XI8lGsuoUEr+Q5Avm/BV0zyvuNBn2bCEwyER4ymtDsDHAGI3ycMa5Q8EgwcAe3e
         tjvbX5uHzoZjjQYTpvC4OayBygrK1l8pGxg8MEnblPzyz/r58/uWRIl/DMOSqlvkZReP
         jcpZuivmEYLvRwi5933yK9wr1CD4OHi5qDCSCSNb8WK+UJIQ9bLONSjnVjFFFJFnv78i
         RypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102899; x=1752707699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvN5sQS4Hc8yxkAu/k1pA/cn0ECnEOzcsV+Wnx5E3Eg=;
        b=ryWD5QElBw9k7IxenumvFMEtjSDhdIPsCr6VEnn/enCrnhyNJVpAYFzeT28qPyw3HY
         OfLRqphhLmALjFBUM/wta2pCvZnlPeYEZoWpz2g/9FBCb/Gi86/QZnTIKl25CqDaMNHl
         QScHInL0E9vK2GaALlu+5VGpfY/t2KBrfT4QcXyACJfQLBu/WvZYzEPUQBxFbkdejDeQ
         fc0haIY66jYa/Vg7X9zS+biINIO2GWMmmzAQ9hUcirYk1+UhA7ZttlWGn9Eczv+K3upn
         IqYvY8vOZNHghcpsQbd/V/3nKpVo1HBVRHoIH+yXVXTQwOH88sbd540Dl9Kwu3lNGA5S
         8/wg==
X-Forwarded-Encrypted: i=1; AJvYcCVwIMp5eqEMcsMQSGZvJQN6KvelyxV02p9J3Kl31iIdWzSGqCYsn6LflLUTEMERCW1hDEUdeAs148/iass=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTa9TussnCl58Od/WJwWh7PzS1Rt/0bY8iiwKZx/ilPEF+FH0X
	ED1JVgaNCddBF5Aoia9C60bz4XUuA446mZ0/l+qU2F+k162JN/Ua07OKJsJm51RRlAa+UBirbbO
	QG4B8avgAfTrW08FXlcnfgNs5aF0TPxKz+Dyy8O/8
X-Gm-Gg: ASbGncsMgj3CvpzEI/r3o7EZMz7/nXYxSkr17A6ki6alFHG5Dm9GeOs7XQW2NMwIHOy
	8LS813cm5EeVpHtJe701goHbWlizioKZmHaBCt52OgJSVz5wOfO2bRoblRXlYkeNOFc/9BY9Nbd
	TCuz/5Sk724mzsdJUYjlatqHluOVpSMKhoW8A99ygpd3fpRAWay59Opf+LU2JjS1O2k/llKaPcD
	w==
X-Google-Smtp-Source: AGHT+IE7W6eGMT5CWDcvvySCktSztip1TX8LPNF1gqKQssp5awnVk41oi32AcQo3aBMpnFQOZIFFSHwebOE9f4YfoBw=
X-Received: by 2002:a05:6870:37d5:b0:2ea:736c:2b08 with SMTP id
 586e51a60fabf-2ff0b9f1007mr1384099fac.29.1752102899263; Wed, 09 Jul 2025
 16:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-max77759-irq-wake-v1-0-d367f633e4bc@linaro.org> <20250707-max77759-irq-wake-v1-3-d367f633e4bc@linaro.org>
In-Reply-To: <20250707-max77759-irq-wake-v1-3-d367f633e4bc@linaro.org>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 9 Jul 2025 16:14:22 -0700
X-Gm-Features: Ac12FXzoWFA0HR0Nj86tAaqGMMfJZ8tIsMkToWl6-YsKjt6ZV07ScHAG-Z98oxg
Message-ID: <CAPTae5J698vbHbhza4zMr-ZnHL7bR4M18F22VyvaR7xNbqG6=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: tcpm/tcpci_maxim: enable PROBE_PREFER_ASYNCHRONOUS
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:50=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> This driver works fine with asynchronous probe.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/type=
c/tcpm/tcpci_maxim_core.c
> index 43b0ec2d12ba6d4c1cfccbfd355af3e5d9ce1385..19f63865079658fb2a446dc39=
0262d141b940e9a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -572,6 +572,7 @@ MODULE_DEVICE_TABLE(of, max_tcpci_of_match);
>  static struct i2c_driver max_tcpci_i2c_driver =3D {
>         .driver =3D {
>                 .name =3D "maxtcpc",
> +               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table =3D max_tcpci_of_match,
>                 .pm =3D &max_tcpci_pm_ops,
>         },
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

