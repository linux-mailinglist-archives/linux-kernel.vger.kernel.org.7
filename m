Return-Path: <linux-kernel+bounces-889931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F47C3EDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112C31881E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790A30F809;
	Fri,  7 Nov 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0AzOqIU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEC26F29F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502664; cv=none; b=FNBSY2j+Fo3jDdntdNYmcAFw/M2MsWLNg5df/Bku5VsKMP0Q1JSaiImGfgUx0C5sJhnLc34plR2r1Mi0yRvREKvNh7t5BVX1xs2y/ih4RMkdmd2opNuqoqGE6uGXQfRfiImvb9V+64rKr9i1GtWbqEs0k9x4DuE2ziDjuqvCML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502664; c=relaxed/simple;
	bh=snAkFDVYRfKppUHhQmG/xJ0KfiGHH3syHzc39HQjvR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDPU0tVzFUocKUPanvwNC26W/VEjL7M0qc6HhAHFVyC5uiGPa1Tstukfpn7CZ4PxtwDl9szVrdgkKRPkRWWrl48rKAZa78g7/qx4vAa7+3x4ZnqXHQn5nTZMdnm8XuucfuMt8Ow01LaYy5L8CRGcc021s4qdInGUsPdORMnrlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0AzOqIU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324054so63227866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502662; x=1763107462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I90MjBmySIkPhmxDdLvFAJjwQFW8Mzv4w6oF/Lid6MY=;
        b=Q0AzOqIUo/L4CBpR1nForJyvfg22SFOPDyAHpH5MQGsK2hDMkaJWO5YqPIWdYFtdkj
         7CwuoFieZZ4OzRtUWg5d66296UsdUv+UoMv93RaYVY6TRsr0HWEgz1K321rBE7fYJLkL
         yysjAiaMSKLyV4OUCNOYMel5aCKouTHxdtxWtgSZgeZX7vLPkEBysKZv5MOihESMlnwH
         zOVfSC5HrcuRk5pHWnJRpUcBkQfV8GuUh1CPj6Qj3pDYuJEpsa9ZT6enXaiOgxibBhLo
         kLz7CEtJdpacUuvrQhzQxg604u0EM+2cx3kj+zx49udfiyaOWHxKsuVIijGuZzUds6l1
         QkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502662; x=1763107462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I90MjBmySIkPhmxDdLvFAJjwQFW8Mzv4w6oF/Lid6MY=;
        b=kwDb/B9a+3a/g1tkdYH0u5p9rZSnfO49EDdy5+k1aXfoTAvj/F8ycvpW6mx5Jl3Osp
         4HENNeDm+v0y4+NRGTaW6lbk5jCMVgT/seqlI3ZjHu7ReGNkZfboq5Szl0g8sl33dNB9
         VVJ+FRBAcfBlsD/IBsxQZ3d2WF3CvktjgudsbN7qt5FDJiQMnvFb3XKJTmsahRWcgH0z
         dPLeqTlWWoGzoC9YKCCvLQd58VxPdUKYytbGsr/URNN9Y+fT4SZ6i19msBTCC8IQmmIe
         NEJXtv6qsO8yANA3qFNByxpl9wrXf/Qtnt8hYuNUMQ63qnDHgCQfWy3ddhq+FwNmLWFV
         aZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXrLvWUeqmQrX4x3rVqWYUTZsdJxCYz5xTQLAUwMesVrhqF2U8MHTF7wBgbgHZPAATucUmX8V3g5MeTy+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPlxrm9dJqjU//lbLyc1NzAEuqtiKty3WxA0w+ymTl7YbUyGh
	S+sGTo3nr1BqFFIbsFS7xJatWQDMoZ9gH9cYvRKr5Gjgx2oicPVVc6u6CLypXQKWBaOylfEtmul
	+/ZuZJ2cg7RBX7jxtB32mCQRUHSSxM90=
X-Gm-Gg: ASbGncuY32r+dVKihVqjA1azh4A7agnqN1QdFtOiWmWuRmzGUsVk6yF3w+zjvBjmCw5
	9s/LwHzNJWhOxFcZrYA0eN7ULQpCbl8RlGRwNHPgJxCckwod9Z1UdQxbjNwa4jVsfOxKzafuNSv
	a9erLGh/3ZRJAeMbpGBXxWSwBpSsTcgOEU3yRZVJgZ3qymPaVM9Ta1HaqTJyedF0KvwIL9l5O6g
	I8dHUUxbbHzSkHUPF/whsrNBvYnYDjuTb8CGKbiVbiv2pDumDkaWDiQz0Ej+Q==
X-Google-Smtp-Source: AGHT+IH7QgHT9eplPXnblcZrAf+4AH1nvr7H0mJZC5Z77CdcMj1Gwejx1wskK7SvWJW9voFU7/sfUU/ovQGDLgCuQK0=
X-Received: by 2002:a17:907:7246:b0:b71:dd06:48de with SMTP id
 a640c23a62f3a-b72c0dbef32mr188016666b.59.1762502659405; Fri, 07 Nov 2025
 00:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107020200.6285-1-make24@iscas.ac.cn>
In-Reply-To: <20251107020200.6285-1-make24@iscas.ac.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Nov 2025 10:03:43 +0200
X-Gm-Features: AWmQ_bkyChgkG7twno4Fs2ZRPuAxXDGpX4YTffQDhSDTVbjb7HgdE6IcQyCfBLI
Message-ID: <CAHp75VfiKrCC-T45z4RggH0-eMnxvRW2pGC85KWZDdoaxNALDw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in viio_trigger_alloc
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:02=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
>
> Additionally, the current error handling has the following issues:
> 1. Potential double-free of IRQ descriptors when kvasprintf() fails.
> 2. The release function may attempt to free negative subirq_base.
> 3. Missing mutex_destroy() in release function.
>
> Fix these issues by:
> 1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
> 2. Removing the free_descs label and handling IRQ descriptor freeing
>    directly in the kvasprintf() error path.
> 3. Adding missing mutex_destroy().
>
> Found by code review.

...

>         trig->name =3D kvasprintf(GFP_KERNEL, fmt, vargs);
> -       if (trig->name =3D=3D NULL)
> -               goto free_descs;
> +       if (trig->name =3D=3D NULL) {

> +               irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PE=
R_TRIGGER);

Why?

> +               goto free_trig;
> +       }

Please, slow down and think a bit. Also you may split the patch to at least=
 two:
1) add missed mutex_destroy();
2) fix the clean up in the error path.


--=20
With Best Regards,
Andy Shevchenko

