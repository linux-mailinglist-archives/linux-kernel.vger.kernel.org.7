Return-Path: <linux-kernel+bounces-865039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1687BFC116
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B9965622E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937B34AAFF;
	Wed, 22 Oct 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjB2IZbm"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B934CFA1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137927; cv=none; b=dmaPWThulE9akUvUzMNtZVh7rfE23qH6eqpix7ifsFvqnEKw1wI5YcgWyjfOzqePk/nA656xhhaQKBK//uVjMvCp+2+NsWxTFqqh0adTrYEjSq/dE9mgODuCKFKvtvAevZckQGZlobcvfAVvUHS6cpNl+PCETHsO3/PYjdOhfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137927; c=relaxed/simple;
	bh=armGkSkAaiUUsrrhXH17hULdm42LMKSSLzB/YcDoAGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDBrgMNv6qVJs4qoWcsx316fI5JlLZ5f6TklEsSzKPpoGo5MPmMgE4HBYg+HwFwEdgGwrwOuQXHamJOZ/cRovnngV+2zJyquN/QbBB9BPCFEn1Brfd8iseo3tEc5llcRl7YH8nUsZ3R42NDQHVbZ8j/TqZYmFUrj4Y2W7xOvR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjB2IZbm; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-633c1b740c5so6805202d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761137924; x=1761742724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLEmUot0dG9xtL8DSLz9R1/+HNCZwZn0MDiZJ/G/QNg=;
        b=EjB2IZbmIBLErE/Qbzdc/+gUwwQsUM20REtA7MNkaK1mAha1jvS50mmWQdXXSRJlnn
         ECUvv8A9uGlJfZ6hhJGS7/oba9DQkZ9psBvZ41Wb6/HbNs8eXED3TMAaec3NX97eIFne
         6zTo5Ah/X22qylATf3Wboc4pBlRQXXUju8A6JyjdXIJWsj3UVfcsYjWSifUTR2z35aih
         WcKoVFANHcuJMxj9/6w0gccf+8WEE3Xr01PIsXDFqes+SoMtksF2/+GCJJyQUBEiUrCO
         TX5vHSX+OmsuOeZ8E6Qx5IHPSSKaH4AkdR6jsFIfFS+CtVZbXfa5KsKCCcNws6HYiND6
         DJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137924; x=1761742724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLEmUot0dG9xtL8DSLz9R1/+HNCZwZn0MDiZJ/G/QNg=;
        b=agp1MObWwFq8I0BXrOBmV3V+4duxcmOT8tWnQ8w+GEUV5xm0Tnh0An4YLzXDXl6k+R
         K/AkVyhX4ZHZgW85zrrGqq/DrEAk/T3EZauFVp//m/MtF0txXhuJWVe0XdgqZUOUj1hw
         TcrrakF2LJsuEgxBZcBiNl0vZm4iUjppmav29u9qKOHRcrbFshkUmaqfgZsp0P8Dih4N
         qpxiOo0DvRHbjp7rmyBGYIGLlWekLHHY7ImNS/JR6d72uTj88YcZvG8N6bE4hqI3PiRH
         O5hH4rU5Go4Tf3InahTfJSwdJTlK3jBXYeOlDdbbkYqwgimaK/koWQj/6r1JzBURAyuI
         UVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5ygW6gMYaCp/srqBMC/cJzj/t9gxQBjjJw2SK/7Ds9n0zsSLE/419edc2uKUTBCA9vEqyY4WydwCpowA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM470L0cuFMT0LMoX5oL8QgNy5FJ4RKNVgVZWJ2vXdRHnyUOOt
	sznXVlVxkdjClx51cA68iqiEdKkj1gdzIDMB2JiHEBUHGEyP/XdT+5tXw1f+vpFCh837RZrIOl+
	EPHUa/9NWCIQUwq8r0KBHMxh9BSACZXs8Q0fIDuzGfQ==
X-Gm-Gg: ASbGncvIQmcP6wGTEJMbmnRndND1F3SHyPweJmhnJBHmbu4M/QKKSBDJ+02oyBBQzNw
	lTcHmN27FW9iiKVwbPcIScC9kPXBnBkWYbje6takzEFyV05+92mZibm2PopFdoKflglmYbyS/wA
	9TtcqdXC7LxXkPLzAvEy+gU778J/pREOnMw7V1sqgH8BA2MitaHMVSG0zWoUI4RAqfhkRGRF5hT
	MwNg928jLGDMQu0Mx0Gc853SVW0MlWERo5otBn8jxUTE61xycu/mZD79EFLMn4JdRbTzFG6B+Mr
	J32SnK8=
X-Google-Smtp-Source: AGHT+IHAv7HiO6eP4aWMFZPRTzo0gGsJMyquNUGCzuthL+6MyEwwQSP44SzayI7psI05mL8WUrrN1mroERg61KE28fg=
X-Received: by 2002:a05:690e:144b:b0:63e:19a8:e40d with SMTP id
 956f58d0204a3-63e19a8e6f1mr16159025d50.38.1761137924084; Wed, 22 Oct 2025
 05:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135155.1409-1-thorsten.blum@linux.dev>
In-Reply-To: <20251021135155.1409-1-thorsten.blum@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 14:58:07 +0200
X-Gm-Features: AS18NWBn7Jc97c4IenLEHpSvuwzifEIi9PksbXk3zzduCyplxNyhkwWrmNivFQk
Message-ID: <CAPDyKFo64vzC+66=v_4v5Z2CbFvFEQ+tYpSKcRvnvRcMvHD=TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Replace deprecated strcpy in psci_idle_init_cpu
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 15:52, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index b19bc60cc627..e75d85a8f90d 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -382,8 +382,8 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
>         drv->states[0].power_usage = UINT_MAX;
> -       strcpy(drv->states[0].name, "WFI");
> -       strcpy(drv->states[0].desc, "ARM WFI");
> +       strscpy(drv->states[0].name, "WFI");
> +       strscpy(drv->states[0].desc, "ARM WFI");
>
>         /*
>          * If no DT idle states are detected (ret == 0) let the driver
> --
> 2.51.0
>

