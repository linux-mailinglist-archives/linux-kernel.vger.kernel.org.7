Return-Path: <linux-kernel+bounces-823247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC25B85E85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821CB3AFB33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6D314D31;
	Thu, 18 Sep 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i28v2+q/"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3801314D0E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211503; cv=none; b=NUAIfx3/1P8oF/NPdMpCeLtMvhBDM1qHD/UiCpseMPtDX5QdUrgXUZdhmPt2ttB6IFeZKJTEyQ2u7LxC8vWQCw2qLaef2OtWZ0NQgPFH5U1KhrVB7M+saogZbXryRCxE1k7Q42EuM12vgIi/0SZLLmbL/3jWpIC/4Z6J8u/A7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211503; c=relaxed/simple;
	bh=lYuuVq2c2mGG8GtYZXdwpj1TRV+Txzn06Yn/v4INq2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8g8MUFKJqoJ6cSt2vvsHY5WGkro0+dl1j6K4XVCVpo+yn+VCHSnGSlEw2WON9ABYqxwdoZ6xMR2ZI1eVFsGjsdb63/h2/NqtmsNImA5FW0AhNHfCI46mS13aPOBi44og+UC2LeQREiOD5uFvnhNlUQCQavQ1TpJEYsV65NWPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=i28v2+q/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea5d1270b56so1165026276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758211500; x=1758816300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYuuVq2c2mGG8GtYZXdwpj1TRV+Txzn06Yn/v4INq2g=;
        b=i28v2+q//rWj7n/cnrIgNw7ydEsWLK6vJyrlQ/t2TZqitsuJx79ghy8Rq7w57qNqCV
         zBQI3EbC2hTYNn+jHlWREJb/7d+XaT8tKCgDDIQR3JN6uNi/mphP5Z2D7sK5I8TEH5IA
         FFxhXZ21lvLlmPeuntzGhGuM5AuCEZcrv+7R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211500; x=1758816300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYuuVq2c2mGG8GtYZXdwpj1TRV+Txzn06Yn/v4INq2g=;
        b=NQjti59JvK2ViT13w093GRDqbmHDOHVSd5vGi4ZdYqwYUDQGn6+FH8j6I/2dK9JFGS
         26laz3J+Gt8FBxPDlJZ2Eflc5V6w1rTu+iSC//Wbz5ahpHll6jYLhGy1EyexZRl3WLon
         Te1RFDrSwy3w2x1Ry9SJt47pD3pULZgRFDm0whyxF/BQyj2CsHmG7WAVlqx/aiz+Us/7
         AQaVUAhoclpQ+owWd7RaRTuPoGYJg+0Jw7BuSJnkzmlpYwJE5Zv7yxMNde8RIj7I0KGw
         jPIfjxhATJ47L0dfEb6C14v6mgadbw51OFylk8WBxs2jffYOsSl7Pfer8w83G7oH9F7T
         g6tA==
X-Gm-Message-State: AOJu0Yy4hfqFK4Y2w4donRXK1gBK+17qrtYlhH5BXHHvHi6+t5MHf3WA
	w5PJ9IZI73E/SXroHUdKi6hx58LtIcXYvuyAaLIQ+o0ciivLHqvlLPUwrPOczCEz+sumGTeCFJH
	3kKsUBolbTuyPu6KufH4x65UODIVF8+36lL4xlSQXPA==
X-Gm-Gg: ASbGncsabVlXooXlynJoAn9W5iGM1V1fp8tRWaCEQdXMnbfjin5jE4BKv/dN8ndkpvb
	VyKmNGCVDyiW2M9WB+qP3Cj4C0FfKST2FSwq2473Xc/7/q7kKLo5yzokLN2420CfwI7+7ZtKyEC
	V5Fu6WNNtWyQCTVxeLT2gp/ufhARn5bek/8F0Q0kvtFFqVtKKkdgx+FE4Je96dIQ+U3t6vY0wFO
	sNIvNQbkAJQkQ7XD+GW0+Xs
X-Google-Smtp-Source: AGHT+IHxSXi29UFW2nfj2WCiCTSiNTNZ0K9Fav6RAJFsRCcIQzCBj3yv1u6H5MOa6iU2eN8pItlTROtG4gg/yGYd8sQ=
X-Received: by 2002:a05:6902:e07:b0:ea3:f6c9:ad6b with SMTP id
 3f1490d57ef6-ea5c057dd64mr5394869276.43.1758211500339; Thu, 18 Sep 2025
 09:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915201748.1712822-1-dario.binacchi@amarulasolutions.com>
 <20250915201748.1712822-2-dario.binacchi@amarulasolutions.com> <it26gfh7qwemksyqw3btcqyr4obbviwaywmyptsjedil2v52vi@rylzlifvans5>
In-Reply-To: <it26gfh7qwemksyqw3btcqyr4obbviwaywmyptsjedil2v52vi@rylzlifvans5>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 18 Sep 2025 18:04:49 +0200
X-Gm-Features: AS18NWClBmtV3TGuBJja7IxKTv258z-H9vTIrPPB1rYqlA078YmgINmcyYbNvFo
Message-ID: <CABGWkvpPesDoz_-X-rMjA567eX3DQEQ8mpSsp=ShpoKjTWWhjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - rename sysfs attribute
 report_rate to report_rate_hz
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Al Viro <viro@zeniv.linux.org.uk>, Oliver Graute <oliver.graute@kococonnector.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Yu Jiaoliang <yujiaoliang@vivo.com>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Tue, Sep 16, 2025 at 2:38=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Dario,
>
> On Mon, Sep 15, 2025 at 10:16:32PM +0200, Dario Binacchi wrote:
> > The sysfs attribute has been renamed to report_rate_hz to match the
> > report-rate-hz property from device tree, making it clear that the same
> > parameter can be set via sysfs or device tree and behaves identically.
>
> No, this attribute was defined since forever and we should avoid
> gratuitous renames: they will break existing users.

OK, I understand.
Do you think patch 1/2 is correct?

Thanks and regards,
Dario

>
> Thanks.
>
> --
> Dmitry



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

