Return-Path: <linux-kernel+bounces-873460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4297C13FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946603B4BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606AA2D877E;
	Tue, 28 Oct 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="J3k8HRJC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504D302779
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645535; cv=none; b=r4PbaGjg54mez5+HRUtQLrU9xunkijZMbSDwVIHQcaW85P7UYm57xI9mrBt+7LI8COcg7llsS7qnVoy/V7oKOtQ67OIhF/O3iMEDwKd5uMC8JvTt1P6hoCSxLMciIuSCz2A/SRdO2Y9avXg+UXX/LdAYnc7+peR2q5yu0aMaCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645535; c=relaxed/simple;
	bh=Udw4Kac4IPS7oanBQ6UJdyxqv8+zAPZHZclswaCqs0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxl3lLeM974XQb8huOIDCy0ZKtFaU95VdgOdNpE6To0ZWRtOTT5t0WlUGTbMu5wf3e7Q09ef2WSQqKUZT7kYNgGErtQnurATGBec/zFVVCuYRGXAEA8w7bmwab9g2U6YsL1xCNOjPdpXqc2IcL+YdH/+wueyKaalt6JGaLET8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=J3k8HRJC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430ab5ee3e7so25733835ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761645533; x=1762250333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PY8mCSuKOhJf2Q+W5FTads5NFbSblIDSqg2ZyPdi2M=;
        b=J3k8HRJClO8sGnJrBPVRqmAHzuXoyZ6O9JTTC2GCDLv6qcXuPnG/EGHkXxgTzPYrGc
         qi7ZOqLlExHdvLpw6d3ka/tZ/ExTCFt6AASgtoVEdogoK1BWKQKqvRqJldMsxkUVzEuB
         yTrJM7VAzgrPRKgiPzWKjPxZGpVQOVLXUDkHYZMmNNWkLOLfB+/KHJe+3U8EkE8jC4Qu
         GCujq28zK1Ria5s/hj2xEijJ+NJfDs9GeJrvETHt5vqTZicirOT8FIY25SgMqekfMlq1
         gP0ARg7SHv5MCMg6nhmVseYR1dmTF+DdYM6nzfbmfc6HpRBHKX5LkUXUzNSqjxCQca2r
         WKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645533; x=1762250333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PY8mCSuKOhJf2Q+W5FTads5NFbSblIDSqg2ZyPdi2M=;
        b=mPOkCaWdG5BXM3KB0hxNdRNWnkjIeBInooQFEdfEVV2pS2USnUWGKYomeZPsqJ1Ccw
         xieTMA6pzIBI3XBSWZlrga221y/RiOiNsH7/V4s7sn1wBRD46DXqRXo36KMegbw2eRCx
         sFFV1SiKefqgd75AEr/4xVnk99oSRe/gUmxyj4yo+/kjuZ3CcESvC4ntAXgPB5AM9qGG
         GA/BER+NiGLcEXALp0VZjShgJs32vegXwLqm71mqPSVXwp6OcbQOia1TyL3I4O4y6K+O
         R6V5jU7v/ajP2SQP6ITI/mIY5etesdDBi1CZsdGPuJ+OKLlitTIKaaWBMd9WVxJryTHi
         M/2w==
X-Forwarded-Encrypted: i=1; AJvYcCUNKcVUrPx3ZN/HhlC349yIDd93MR3dHtqsUtRpWObDx68TG8B6srCDdONLRPCbGiebDifja8w4XDCmGJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynjf5AORyt+7Hdw72l7mMZGomUb3JZhmqlaJE+uDfrWO4k1jRk
	DqCuqMwKokbnByLZC77QInk/2RNaZG6w0VrprA8EOS7Ac1kIQFP27RNb/vBZzR7V8/dOojIDN0f
	1Zry8/nbtAPRFRF/Fostmdc4+716KwxmFXlnH1pA0rw==
X-Gm-Gg: ASbGnctqvXn5rvxRrI55ZlYcNAE19hFbmagL7ozXikuLyiqpPiYApzVWg6lsb1iwl6z
	rVg4JMkDB9/1A9ojWYpLTQh9zE8oIC+pvXquy/d3raTmvwmkGHhAmtOHzv5UF0gU1scFR9ls5Kh
	VYZveKb4gUKX1jPw/oCldHHpzQq1K7MDC8Tqm2zpjTe/Dm1gx3+hxSxGW2NxFLn7qFDzDhQ96b3
	ncezVbP6pzVY3N6WG4fGpH9dMS7uXsrOMs8MJ/K0h4benisIyswLxHAopK+G01uo8YvCtDoA5Y7
	jEGfdGXK1/BT4ymaVg==
X-Google-Smtp-Source: AGHT+IEg0a1CT3cJ1oaHQ17yWX2472MdL2RHimICjHVP34ZQDjWMsWJJoe7Ni16kwKdyIqohFYWx2NwOzODq5cmzegw=
X-Received: by 2002:a05:6e02:d:b0:431:d73b:ea9c with SMTP id
 e9e14a558f8ab-4320f6b1237mr44673025ab.6.1761645533137; Tue, 28 Oct 2025
 02:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135155.1409-1-thorsten.blum@linux.dev> <20251021135155.1409-2-thorsten.blum@linux.dev>
In-Reply-To: <20251021135155.1409-2-thorsten.blum@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Oct 2025 15:28:41 +0530
X-Gm-Features: AWmQ_bmouff25xtnvPr1URYNqHRT10uCqQrPn__6ZXy4Z26vl234qADpGcUh16E
Message-ID: <CAAhSdy2Y25TXjZNmaMMKhwZBi-T-UzXjQGuVfqy-ThTuJ4rmNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:22=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a360bc4d20b7..19be6475d356 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -303,8 +304,8 @@ static int sbi_cpuidle_init_cpu(struct device *dev, i=
nt cpu)
>         drv->states[0].exit_latency =3D 1;
>         drv->states[0].target_residency =3D 1;
>         drv->states[0].power_usage =3D UINT_MAX;
> -       strcpy(drv->states[0].name, "WFI");
> -       strcpy(drv->states[0].desc, "RISC-V WFI");
> +       strscpy(drv->states[0].name, "WFI");
> +       strscpy(drv->states[0].desc, "RISC-V WFI");
>
>         /*
>          * If no DT idle states are detected (ret =3D=3D 0) let the drive=
r
> --
> 2.51.0
>

