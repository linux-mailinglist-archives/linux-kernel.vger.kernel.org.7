Return-Path: <linux-kernel+bounces-843899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD18BC085A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3241618883F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6647256C70;
	Tue,  7 Oct 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFPrusBk"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017B3B7A8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823482; cv=none; b=ASyNTX/CrlwtGkwTMHE2WPI798rRWc/wQ+uUAlQTStlKz6RNzmTyTHaowVmsfUj7veedpVPo9nQYAyqvcaH8977XkNBpi3wgUcziLanos/OCF8kfrBmlAqKk1wrBjiTOyOboPlHFBeFAcg+TDZr127dvyaC+h1F1WGYvEd9v8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823482; c=relaxed/simple;
	bh=YW33Rk+nnKSgtJ/tN28wpQI04VHAiH52dyQW3hzpb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQvY1hXUlW46lOGjFV97e/x//DNz7f/i/sUXaZgDF+dzmQ48GHdwmIWFtlkDwbAz5gnVevc788GT2xVh1hI4Xud6o+Vttbfq2f4bbanADsiRaj0TLd6bz3al7XlYNbgXNScw6BGdrJpefgAAe9yoMpEz4X7gOdu5AGa0yI784Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XFPrusBk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-859b2ec0556so613188585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759823479; x=1760428279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60IeKMHui+PjqfYpDC5iEMtORllnqEY6yjxQ6KcN6RM=;
        b=XFPrusBkRX40AQmrb4yw/CO62MmFcn9EYqykLzDn1fUztuTY0FluDi93fvPt1kL/2I
         EHDE6G3KWYHAk+UFxf4qJYJG8h5sgbxOQ3GIqi2h2xumXLVaDSk/qVJUy7cjFEUSFUUy
         uIrlz99UxKfr7z8rjNrv6Hb9EIhictj7CAC3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759823479; x=1760428279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60IeKMHui+PjqfYpDC5iEMtORllnqEY6yjxQ6KcN6RM=;
        b=wyi2RAa3nTX+TOFj9gkfdjEGwcVJWcWqEqzqfoO2hSILbJX3cMViHoBi2U0L8fXUzv
         Qy4SbcWCqJF5vLDPWtCrqigYzZ61oCCSnO9ZdMwmGpCoxlhBc9ucvQwu4CO8VcSP7LTY
         WBaYpIHWovzGzo9GGleXyYre7ijSvO7l2GGKLnpoH73LWGw8vkMbD0OPmArZ3qpF9Tq7
         21rb8bz0PGJe9zIwQxZWegZhJxr1EulYWHEd8M9CqEVQGM7h4au5Pqpfl0WXXeMREVml
         dfhlOYN4nKLO2cX6bYgdbIpGzNGbghCPWd6rSS5ITIZ/2JVv1ke3Q+IKA6kvYcYf54hk
         D4lg==
X-Forwarded-Encrypted: i=1; AJvYcCU4XjAfth6bb7+777Qgy1ftBtv4D30NArytVCT1esu5G68UZvMwwopgthUWS0nAvGzWwYFVc7M6accC/6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWq7adZfZ65oUSwIpwRNsT9hNG+kBBpqabAmZAj+SxkuLbwwK
	UMW+m8MBWn4Y9YfM1ZVZPRgvvB7lC7DzrLeo6Ol1OzxdfYkhcCw06gNRC5WkqewtqvMvsi3X5mj
	oiH9ZnQ==
X-Gm-Gg: ASbGncvLcBMkG1jgg4lXwBQ2jl19nAM0YkF1/dl8mTNdUNRELmvp3FS/4mgxhFOccRa
	q+6TCPeSvfG+1j2nHoskgWl/KfMCkujnVsUgclm7YbZ+d9cPIa+znZ3rOvAzX6KalXHmex/VjNq
	aPjeTeyQVXZWI5MmXKOsjpgO5u49OgbCZfSo9ubgjTfeobQex4fd56RD97rIrYGuNnww2wR6+pQ
	ZflJ8Y3G/TmiTi3fhOkBIhrlLQPa68K8bdO2f8t7q0gsgeDIV4a/hODQOphHBeJCPaJdhGdjYwk
	L9AbgpuJRFzk6VdrnnX+ZBuMp+IH+IkgI7bhICAflVKCLgv2j43bPbjP41Klc4DLe52QeRvgJxw
	b9ZpqveVqrsufwFNyybs8/BSpu/VifNW6Q1Lmpl5tCu8iM18BM+oq+FCf7aFFZF9y8JK32lMHrr
	/4raJWMiuIsA==
X-Google-Smtp-Source: AGHT+IFG41b3lelRhLGZcL/a9Mp5tvinHIqvZgf24Ve7kAHHX6ek1AI6xgQmtqzL/gyv2dl0qZxAIw==
X-Received: by 2002:a05:620a:2a15:b0:85b:3baf:9fb7 with SMTP id af79cd13be357-87a3acfbb2fmr1760052785a.60.1759823478823;
        Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777aabe9e7sm1576326385a.63.2025.10.07.00.51.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4df3fabe9c2so210681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVat6ohJLfh9e1cnJ0S1KJbKfVR59CI8RwfBUUvyROYWu1CChBiot3SzOx/IWnNxmJ8aaXgBmYwurV5/Hc=@vger.kernel.org
X-Received: by 2002:a05:622a:112:b0:4e5:7827:9c83 with SMTP id
 d75a77b69052e-4e6e01d5960mr3804511cf.3.1759823477313; Tue, 07 Oct 2025
 00:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
In-Reply-To: <20251007063551.3147937-1-senozhatsky@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 7 Oct 2025 16:50:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
X-Gm-Features: AS18NWAReY2sfeJP1qf_JcUDg1z5QtaCqURfL8VBeE5DMUAU_66L911L0sT9YhI
Message-ID: <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:36=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add dpm_watchdog_all_cpu_backtrace module parameter which
> controls all CPU backtrace dump before DPM panics the system.
> This is expected to help understanding what might have caused
> device timeout.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e83503bdc1fd..7a8807ec9a5d 100644
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
> @@ -515,6 +516,11 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>         struct dpm_watchdog wd
>
> +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> +                "Backtrace all CPUs on DPM watchdog timeout");
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *=
t)
>         unsigned int time_left;
>
>         if (wd->fatal) {
> +               unsigned int this_cpu =3D smp_processor_id();
> +
>                 dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>                 show_stack(wd->tsk, NULL, KERN_EMERG);
> +               if (dpm_watchdog_all_cpu_backtrace)
> +                       trigger_allbutcpu_cpu_backtrace(this_cpu);
>                 panic("%s %s: unrecoverable failure\n",
>                         dev_driver_string(wd->dev), dev_name(wd->dev));
>         }
> --
> 2.51.0.618.g983fd99d29-goog
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

