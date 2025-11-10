Return-Path: <linux-kernel+bounces-893419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4378FC47567
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177FE18853A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD25313E21;
	Mon, 10 Nov 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuh7JrkT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F17312838
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786190; cv=none; b=l2oYdRrM0i+nip4qaVB9m4Hd1PzZ68uXVdma+Hvq9+AZnXgRIlKyFllLWAXE1GS7O5YzrUxUzHhmDylwXTEdcz/8dKHbXVP36Uk9C1Ozhwo7ujW9gYOB8zkkLkJdj8Y8/QYEOnp/THA3eIV+XqFv8GAelstfV8o+3oXZWAkP/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786190; c=relaxed/simple;
	bh=PyrUyZt1KXdmHL8ZKhHDOfbDbrsNYwct4PjGJS3obe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hywTA0ifz3UqGl2Rq7k22KOfiHROKsEWiacbYrYSP/cC1ridamRlU15sbGFaL99x4UcIoFxRfK4QAw7zevBA/Qbsv9yrDLm6PMHz6EVlhc9J20AsFe2+j3I6qHNgTWJuRFjcGh+hA3L+7bBtnRgfL7iPnblWte0HetXRWrnQ608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuh7JrkT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so2260050f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786185; x=1763390985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUTsjPuq5IEg7AJZaGEawlugjH0SqT6TpHHFp6KpABQ=;
        b=Uuh7JrkT8Kyd3pZUkzZ4upCElVjWcnehxMrWtcyiQw3v1dHYpDtPe17SSqnx/7it2x
         miaQoVYsJ6VoJk8iPVzOrJggOAjcqcLWd3TCW6ADiv0vkDSL22cM/LZ0lhXzujimkbQk
         L3nbKNLIuKtlzlOMLmqoY1+kd+81mud3QvdpqTMebdzJpOYumZhOmdcxXOxG+579CvbX
         Nv0seP5hsOFkCqvVURk/Wr9zgOvytsfiNztkUl5utypVzhV9h3pXRNT3VAB7I2hEjc+l
         nXd4k8kTpP7Gp7df+Qx/wTT3Wa2wdqTnCcexaAiWAraYhHKxyChfa1Sxj//Js7wcYSt3
         1C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786185; x=1763390985;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUTsjPuq5IEg7AJZaGEawlugjH0SqT6TpHHFp6KpABQ=;
        b=D/gxx+2Evx9OUI1t6tHbJ0lbtdhhf3mthNl8eQLY88Nj5S2JGKix2gQSDYwrDdlHdB
         1AD4cOLth93VX0Hn5mIg/TxLsczs16McIJ1YneXlpJTi4EsgUC1rRlSNEGuq38Nb8KbH
         oKsiUZ3TaYR/BQgLGuAU0s6ICgWjKUYieiVHTyIjj1jeXxHCsbKKNUYoPNttXYmit7cN
         pgTYp4FQjVCnIJGWNkelFzV56ZTRNIVwmyqoueqPk7LrRABbU9s9QAgXh8UfIXu9ciOd
         8qosvgz4kj0r2i/0ek+nZnt/IZBAfJbsBwgG5RCnXrY1ALKDpV2wF+cwlZY1Ab2f6SLQ
         RCdw==
X-Forwarded-Encrypted: i=1; AJvYcCVd4cvPXj9G2G4JJdEYN8nylKnMDLzUUSx7mj/X9pjNXiPaflJY5rROobUjzbXINn+rql1+qhYJmHauvTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UKhpRzGF65eVvmh3MgalMmOwJin6cU6SJKO+j1xFb0KeUQH7
	sCSlS/1nm+BhJrxjAmpWoFIsbQFPjDmkfJpHnhia/n1FJb7YPVpqmzei
X-Gm-Gg: ASbGncsyK6Td2Qv14cghX2vjUYsqyW/0mw4jtH/xHWDh9ifbyN6g7sxNmxP4UOjDDir
	29TVcXDuHZmz6FxiYA/V1k8KS5PnRK2mWZaCwIo62AFaYYjm7WXC+4/CZIE0FwC3XktP/S7s+y5
	3pkHLFPmq1D1GYiWFodysrwqeE22johy2zoI8yPsveh7gKU3FjuMBPNGBvCaS/3Ot5CrZpFfkEq
	wTUR6APbHRnpegv5p+C7EHb6HzwTpfUfdMyx2Yp26Jrqo+tyjFSfwYv0Jz/imTpUzAvEaOLXFjl
	jy7Dfm9mDUftEWDXWVvRwoa/MPc7EqZANpmLfLvKP1l59dcPG7ubk3vkOrxGVuCMlfWcZ9jvGTn
	t6dgNDjb0AtNoBJcKvC9NVorU7IY/jHak9czjfbFrmRm3tBwoHDhO6r1gl+EXNF5pze1RmZGcNZ
	9YiS7k839e
X-Google-Smtp-Source: AGHT+IELre3k/Ybgp83pqzytOhWu+YaCKhxQ36NRAH8s58X0T74e+3oEYogMVn9EIsnJ1kyTRxHHWA==
X-Received: by 2002:a05:6000:22c8:b0:429:d6fa:da20 with SMTP id ffacd0b85a97d-42b2dc31fe4mr7011373f8f.25.1762786185297;
        Mon, 10 Nov 2025 06:49:45 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm22834283f8f.22.2025.11.10.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:49:45 -0800 (PST)
Message-ID: <c8e0ea2d1859042bdc19a635718572f0e91d9889.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] iio: trigger: add missing mutex_destroy in
 iio_trig_release
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Mon, 10 Nov 2025 14:50:22 +0000
In-Reply-To: <20251110035701.36691-1-make24@iscas.ac.cn>
References: <20251110035701.36691-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 11:57 +0800, Ma Ke wrote:
> Add missing mutex_destroy() call in iio_trig_release() to properly
> clean up the mutex initialized in viio_trigger_alloc(). Ensure proper
> resource cleanup and follows kernel practices.
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - split the patch into two independent patches and modified according to =
developer's suggestions;
> Changes in v3:
> - modified the patch;
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-trigger.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 54416a384232..5baa83349e8f 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TR=
IGGER);
> =C2=A0	}
> =C2=A0	kfree(trig->name);
> +	mutex_destroy(&trig->pool_lock);
> =C2=A0	kfree(trig);
> =C2=A0}
> =C2=A0

