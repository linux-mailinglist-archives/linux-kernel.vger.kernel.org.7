Return-Path: <linux-kernel+bounces-751609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A5B16B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9398E189685F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6042405E4;
	Thu, 31 Jul 2025 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWjKOzqN"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1EEC5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938414; cv=none; b=UYX+eDpi7uvj4mhn0CpHv4450ue/BzpAMAyfmThnz9lozmA4yhE9iWRYktthSS+6lf6uZRkR3BV2uIqcVS/bnaB7D/TKZ8cw5Z2tfJJ/wn1sioPXYmbCNwzUpYc2zN/d2fEFRLkm/pSW0jXbjLl6rZIPSHx8D65KZLb7V3sMaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938414; c=relaxed/simple;
	bh=oqDNnKTx6evnFIVUnZBPUaHw4iEO5wpEE0Io14bZaAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtMq/zTKAPIcIIPUu2LTAiwVBmpS8YY1tDvjgIFsIviqSkNKpKwD7OOkiTOk0PgqvuX+zAvNC+f7Ejt0/kmoJza4D54RnTfDKRE0+xNuBGmqYdLiPBSKFPLc9STxGqi4GMlGwGMkJOaCcshsQ8g5gWItXgun/1246K5BXDqsIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bWjKOzqN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e32c95778aso37946885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753938411; x=1754543211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7OHyfOZxU+Pu6FEnzeag1ObO8U/z/6yZ/ALqHmmTR4=;
        b=bWjKOzqNNgcBz0vBPPpQ4jeaHB8jCBctWbrMhEeQEqo3sbnGA2JvjG73nwfbZB95e1
         hVMZJ6kgjmgyaJnX1Z+j20BPUezL4kNno5kLxXsaZ3Azth6g24BsrYgAtGeE54ppuDUo
         YmI3plVNBeZm99OOQg0So0mk/lZ1CF7v115ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753938411; x=1754543211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7OHyfOZxU+Pu6FEnzeag1ObO8U/z/6yZ/ALqHmmTR4=;
        b=R7fYgq42wuVUe5mwt/YhVYEGL/Qkt8AEceVS02W2ET2ALSo+sgteUirzYJwklQNSs9
         7z04+Q2OjR61whcAPsp8ygCsrBH0Gdh+eD6oHwluMcG+ffDMe66q3Sb70yLS21FfawRD
         BV2ZS/DPzC9ZMFk/6+/GJt684P7dYiAKv3B9IClObQ38MnCKu6SfejqwoLLy/URaK3xI
         AzJgBIH3rrF9UKm9KYCaWuIIOUwAImREGReOCViOBuo6a9FXKQemchN/ybIuY0vxQKVX
         Y6j71GqeTPKa4Fm31dy17RLNsK+JwBFAcwK6ploy8JG1Oro3IE1Sx546sxob9zCRGG2F
         JaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7TmqaNeJehM0/5e5KQg4v5CKjASjaVQiHaZIQGIvFX8HleumnPelXsGxITZBb2ew5DYGIB54Wo5EASDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3sqq7bPwV+7ZDzat2yZjWt2xS/xn6qinXUFuw5EOT+VQ7zJU
	RxKFYmheaP/hp9wQfjUcjsHVEBxp0kV6DKEX0B31B2DB2L5jOdry8NdzApv6PeEsJtLgKhRAVzD
	hv847tw==
X-Gm-Gg: ASbGncv1/VoAfg+ZM0AE1ipkvEfkvYSQVYxVlBoTRWhlY0sV9Ra9sGyto2C+PGeyOIF
	YK1Bi3OgdhCws+lCoIURk/gWMn27NDChRAVCFScz+Pez3pjcN1ZOW0wxhiZQLwGVb8ThifoSxAO
	PYGDZdJK3DvXuGQhe0da7Jl6nAFt9HrSdjX71NdApXb7f6IjPFCgXZLW5a9NUmj1FohrRuJIF5Y
	jRzg9fGugWtdrVz2q5v7OF9whxCpNEgCbRrR/807bwKkyKlUUHh1wwNWooHGWH6YsqAxFwPsaj0
	hRngqzLdCLEU7tIRLvq5B+4X3u7JhhmF+SxXv3kIzvkG/LnWojnXr/mL7bCrK38Qua/rZ/iLnB1
	dIrZB25ZioTkbJF2yDJE4aAZ+yss+sRGmCOVz/K0RMUp4sSnUmvou5Ip4QHjGUEe2vo06TZyi
X-Google-Smtp-Source: AGHT+IE26dpOLIvKbSnc8XIb1Pm81IU6LqTM7eVLWnclxG4M5mXDvWGDpsx7Om5FyNotfjGKOilh7Q==
X-Received: by 2002:ac8:5d08:0:b0:4ab:81c7:b992 with SMTP id d75a77b69052e-4aedbc5c7famr87739471cf.41.1753938411421;
        Wed, 30 Jul 2025 22:06:51 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed681d4sm4558511cf.40.2025.07.30.22.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 22:06:50 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab86a29c98so169951cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2HVhe137NW2gip0BHd6oABFPLZHkJt9uI/9uX6aVDt4odi9T1ZJ6Z4nhryULHx0gfYH1/xSywoTcCql8=@vger.kernel.org
X-Received: by 2002:a05:622a:cf:b0:4a9:7c7e:f2f9 with SMTP id
 d75a77b69052e-4aef1cc5bf6mr922481cf.17.1753938410102; Wed, 30 Jul 2025
 22:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
In-Reply-To: <20250731030125.3817484-1-senozhatsky@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 Jul 2025 14:06:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DQGdTSw0k4fX48qO=5XW1phScmSEYw=JmTOMuATcGjog@mail.gmail.com>
X-Gm-Features: Ac12FXyOSY-ncCQq_pMoHKvGeLdAODKyCgVM1vJKBOddnlG-iFTKjhcGmThEYWo
Message-ID: <CAAFQd5DQGdTSw0k4fX48qO=5XW1phScmSEYw=JmTOMuATcGjog@mail.gmail.com>
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:01=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add dpm_all_cpu_backtrace module parameter which controls
> all CPU backtrace dump before DPM panics the system.  This
> is expected to help understanding what might have caused
> device timeout.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..23abad9f039f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>
>  #include "../base.h"
>  #include "power.h"
> @@ -517,6 +518,9 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>         struct dpm_watchdog wd
>
> +static bool __read_mostly dpm_all_cpu_backtrace;
> +module_param(dpm_all_cpu_backtrace, bool, 0644);
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *=
t)
>         unsigned int time_left;
>
>         if (wd->fatal) {
> +               unsigned int this_cpu =3D smp_processor_id();
> +
>                 dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>                 show_stack(wd->tsk, NULL, KERN_EMERG);
> +               if (dpm_all_cpu_backtrace)
> +                       trigger_allbutcpu_cpu_backtrace(this_cpu);
>                 panic("%s %s: unrecoverable failure\n",
>                         dev_driver_string(wd->dev), dev_name(wd->dev));
>         }
> --
> 2.50.1.565.gc32cd1483b-goog
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

