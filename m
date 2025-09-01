Return-Path: <linux-kernel+bounces-794982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F9B3EB70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F2A1B21347
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D34B1DEFE8;
	Mon,  1 Sep 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="0K7ZSC71"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A51DF271
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741518; cv=none; b=A4zSOP/+JVz+bdzP79cd6q6wyS7kG7YbT5G65MhD+hNNhJxrYtVaVzMIhqEmT3JjIUs06qNHCor3Lohiz9Y+RnwaIPjfJvpgIp/YgYvG5Fc2wgpMgxJVHAtUaDTEQPSukCboM/pMyuIfShUX4xAXD3XawRuL2Kb/iVbW0kprpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741518; c=relaxed/simple;
	bh=OMgMJoTTIlGi0H5QyW5KhwgKKN36wR/vSC5h5hgxia4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvuiNpa4/2ayGzRbMSBXMRQ9aTu8o9mZso0E+J/dZBEyRGRF6HWudlY1ssAptw/86QzvYY7ix4CFdRTicbJ1hHegEHVY3iLiVc47Ll0z1PfsaAJmGQwgsf3uCH7rSZKcK6cU26w4EMZ+Q/AoEuAiIyAiTizGaSV6j2+RNZ4+m4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=0K7ZSC71; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60157747so34491207b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1756741516; x=1757346316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc+cyyLMv3ZDCW9TrBfgm90Y/n1yLM6D15As+zF4o6M=;
        b=0K7ZSC71g12YfQ9xSO4dbzT8kvkcsOg/WgYr7cp4Gy1Qu5wj6UkxEi/atZoNCZpXCI
         JcXfiT2GW+gAy3ztd4zcFLwhSspL3aInE2mQm51Fa+99VPBbd5cZIaxCP+a/WQ5sH1AD
         9lmS2i3xfDFCIcnKvS7Oi06ryVi7vtK0NlS35+4ZtjaKl8LvsEOIgbKYCZgm9XjYbfTV
         vTg1kG4D7hC6XQnPzTc+wzZdsyhm96Hh4DWFFvH6uBuW5442gMRRE4g+iXEP/Y54/6tm
         7tvTxa/4kfI7MZrUkDcCy3QM31pUp4FejMM9vHtiZMaNmUJ0INfwCQnDta0S8Ju9KWnn
         +WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741516; x=1757346316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc+cyyLMv3ZDCW9TrBfgm90Y/n1yLM6D15As+zF4o6M=;
        b=WVqQjnp40exIGOP+qMb1JmhIVN0CVA9fi7CrGfrG/VPz3EhB3eRKBDfJPiSXg0Quv2
         rzvk92kggdVXmKy9IR8aau+et1575M3HZW6WPsF5RtVbrHaFT/4xysgsaAXriVRy65ap
         w7gJb6VgtCbVlPztVG+rZ1N0hmfrnvbBpFAYVRB9jl7E81oRmELgK1xWL5QEjnrW/F5J
         gO4PdncoyJefnY59G41P/fqZbd/wV9ckaLjqDBI5YNdoP9MCB4+yjrky/ATbqO6OEQ85
         mqvQnAbJK39UyWhS1t1Fhmzk3A38K0Zfrw0YspCPFd673/Dys6mdCiG0ChPVv3WB0KkY
         jVoA==
X-Forwarded-Encrypted: i=1; AJvYcCXGvvVQaBjh9eW0lrZXr9SakYvdTKBQ+WxinyF2QjuDdZpeGCRrFT7hs5Fq0uohJUlo50gKUDnIUxxfrn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOvKVm+JwE1NBk6NB0UwO/yIodDWzOpPVKgmIo4bInFvnDaWF
	2khBCUo59zZY0wmaowXSLihx7N/7ot2IlwHS4ft2E4X/ylN+pDGRjp03knDl8OIdnfbio43aijz
	oNTx7y7t+sQ==
X-Gm-Gg: ASbGncti961+5//aEHUFRy6ntuqht1RkdJ/4FujDLok9sviwu86iOfySLtxkKfG71WC
	2g2K/uvkBamMCN8iZjWSAIBHF61jEYazlbihwPVX6jop5VabAcBjUpyVkMuWz/vse/FA59xJuAL
	kNxg46B86N+fYlfJ5EmJbvmeOi2jiuYJUt3LASZFPOuKny+URPkXXqHk0w+3dTj4TRdaTgYLWmf
	pxKtiKq/0CXXMHsqyvb8lifQzjfdg0buJrVN50VTZJFoZauldRikDNIwvEUmTu/YrZARWsHsmi+
	At3ZAhkr66X6uXrcck3eKJe7pNpfa7HrjcS7AM/R4xMcRqQLSQcYTqD6nv1L66k0weCneWXnDnw
	5XoJNP6UF3RbvmNC7NXwJmM6YhLkxVIV/ikezwOuULLOuBLxRk9hSKkTMnKNfzmZv1g==
X-Google-Smtp-Source: AGHT+IEK+H62sspnEtnDLScwWcDVMKTYAM+pOOVoVbMzJnSP6sXYqw2LgdTZR87jBp54tZAFHsSNgA==
X-Received: by 2002:a05:690c:34ca:b0:71f:f942:8474 with SMTP id 00721157ae682-7227657547fmr93959627b3.49.1756741513730;
        Mon, 01 Sep 2025 08:45:13 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d6308c9sm15885297b3.25.2025.09.01.08.45.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:45:13 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d603b674aso30311357b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:45:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU76HUfivR6HSWXLLilHhKCq/yykXdYweL2x5ulQ9Tl21T6Zpr+WUqD2FgBoATDrD1IK/o8kFebav0y3qQ=@vger.kernel.org
X-Received: by 2002:a05:690c:6004:b0:71f:db79:994d with SMTP id
 00721157ae682-722763d887dmr101946407b3.19.1756741512904; Mon, 01 Sep 2025
 08:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818185658.2585696-1-heiko@sntech.de>
In-Reply-To: <20250818185658.2585696-1-heiko@sntech.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 1 Sep 2025 17:45:01 +0200
X-Gmail-Original-Message-ID: <CAAObsKCGbS4kkYjFvQONjF7RWbzNRejCGMi1puzHnSpsR4pguA@mail.gmail.com>
X-Gm-Features: Ac12FXzZ3kIusG_YEYmGkUAIbd5-b4np1Jxp8QvWXSPz6RxKWESjaAnxctrV8IE
Message-ID: <CAAObsKCGbS4kkYjFvQONjF7RWbzNRejCGMi1puzHnSpsR4pguA@mail.gmail.com>
Subject: Re: [PATCH] accel/rocket: Check the correct DMA irq status to warn about
To: Heiko Stuebner <heiko@sntech.de>
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 8:56=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> Right now, the code checks the DMA_READ_ERROR state 2 times, while
> I guess it was supposed to warn about both read and write errors.
>
> Change the 2nd check to look at the write-error flag.
>
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks, Heiko, you are right, I have applied it to drm-misc-next.

Regards,

Tomeu


> ---
>  drivers/accel/rocket/rocket_job.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5d4afd692306..3440b862e749 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -422,7 +422,7 @@ static irqreturn_t rocket_job_irq_handler(int irq, vo=
id *data)
>         u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
>
>         WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
> -       WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
> +       WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
>
>         if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
>               raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
> --
> 2.47.2
>

