Return-Path: <linux-kernel+bounces-836120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F7BA8CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1447A390F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FE2F1FCD;
	Mon, 29 Sep 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmVmRk8M"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAA2EDD78
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139959; cv=none; b=T2OiQw49JmaT7Wdm3UuMpCWA9j47WbhzMbWRkMh7Kepfx2k9+jZAS+PccriaFBl/XZ0f+CAlEo8HlBCX6GCMJC3nnKaQjuAfE3MVLpL05HEvQ1HPr4IrYBoXxz+FzY192rFTBBeBUMqOvwZHrKgL7jA8lwEzlRTMdPNZzBMgVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139959; c=relaxed/simple;
	bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAVEWiodMe5Gayza8fNybFxJ808tEA/R15CdQSTP8EHFeELoyxppYA0Oz8bZA/vDe8x19nCkURiRAyxT+sxh51Cg5mAUYSoDzE6gcwJAj80o8l/UgnHs6YmGYFgkMKjiSht0C8KboPB4uZ/zAG69hv9exvJl074rPXf43UpLBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmVmRk8M; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-635c9db8a16so2964219d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759139957; x=1759744757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
        b=HmVmRk8M2S2In+vPAyFQuEH0KPEsA7gftYVcwmCL6u0TexkZrTr6w4XB6SSOt6CrFk
         jzK15dZ/vSDaNZGI6OxWA0jeWiUrDWm2sme03NLcAunOfQSalUKBkCjOfOeVScM0B7Mb
         ilwAqFcyFziN3kDdAw/LsXRttOxXRem8wXSYA1EHX36ZG7jEgrEckroWfMzpmQNdxSVI
         5UPUzSXuReAUGDJwtTof+Vdng7+7eXac5jNPvb36ihG1qJowi6wcHzCDPHcvikORsNCf
         p2C8sNh5YF7wwhW587+/wrWaOG/sSE1p/+daSIsLuXlBkyZ+GA+e9OsbPqcfvQGvwVxv
         y6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759139957; x=1759744757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
        b=YhfGnekS1/3z2pqLVHox/fBgfUWj9G45sYphxRa/S8QW52y3x+HpeLT4nQMVZWNO5h
         3j8D1XD/Mz5pBBlA/8T3/P7YqZbFt7pdAjBxT8snJGQ9v+oFNXCAoSC0bXHg8ixGrozy
         mBUhf5HY6eRQlShN6ZKnCulYy84OSwaZzjYCok8RbaIbxvCR7kq/PR0YDaEQIlGB7web
         1wklHmu2+JrPTmC+mQOJTMI7vjqSjSmxz6JjKjQpq5GEtI1cbyi1uKqTvWoLmm2u1rRs
         klfkiNExMGiqlrJLOzP0F6r4TZZZtT6WotSx15e2Ujfe+4iFA9TxJpjH/CitZnhRtdEq
         tdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDT31FHZ8HazkIDvl9ZXmIrjX9SEDA8YyleAGoRZ9qctqlIUmrAlXDZrqp2u07m8VQHzGgJLmLBa8SD4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIanS9/8FNjv+NA3CClRqqCCkHvLkO7tjuEzDIMz8y7SNGMEu2
	juk6Jnf5ZhqZMGHdJsgWRXiqydplYdX0Ocmis0tXSTkMxcdoFVam/AUahbo27+JKwqPWIE29zYV
	QedYgMyzbn3h/Ywz4PeNpKialJdAdkXVGeN3TJLVl7A==
X-Gm-Gg: ASbGnctmVSJaatikOPbj8bUNJt3QZfW8PtuJ9KvVNY15krumfI5k6I3vKFWqv5tlbl9
	jwDTsMoT/IZ5hvt9js3e5h4yme71SHWrPbA/lx2kxM+IQbBLkins/jkNHEpIwAI/wsgXQsR1xGG
	hrqSquUK/0jB6SxbVlqCZRHkLZqs7mK45EKS+dNGjHl7bzVOBGdrT7zhJZnGb/7cEP9utvCoy/1
	2zMSfhl
X-Google-Smtp-Source: AGHT+IHKB6dZwmkkiRTmQMJ6qqV5u+Z5RUcKikaK+UuufgwTUJ8RoCQyTBvf2kQBGXi0WQ0jZXHoQTtqUIZWVWUBjSA=
X-Received: by 2002:a05:690e:1a4f:b0:636:f1d:e26 with SMTP id
 956f58d0204a3-6361a8734e7mr18613222d50.32.1759139956833; Mon, 29 Sep 2025
 02:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com> <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
 <2015216.PYKUYFuaPT@workhorse>
In-Reply-To: <2015216.PYKUYFuaPT@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Sep 2025 11:58:40 +0200
X-Gm-Features: AS18NWDi6KooeuuBdFZYN2-L6gygoxiX5visVgVu6hIAQ09WtQulOO0qEvr47Zc
Message-ID: <CAPDyKFoCPkNsbq8s3d6cQXxfFhiYH1kjrocNdq8=v+g+LY8c6A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

>
> I actually have a question about a mystery that has been puzzling
> me as I work on v5: when unloading the driver that uses the PD
> (panthor) and my driver using `modprobe -r panthor mtk_mfg_pmdomain`,
> I see that sometimes detach_dev is called with the pd status
> reportedly being off, but according to my own power-on/power-off
> counting I hacked in, it actually being on. It then proceeds to

Yes, ->detach_dev() may be called for a device, when its corresponding
PM domain is both on or off.

> call my remove, which results in three splats from the regulator
> subsystem as the regulators weren't balanced with disables before
> they were freed, which isn't the main problem but more a symptom
> of the bigger problem that power_off and power_on calls don't
> appear to be balanced by the pmdomain subsystem when a driver is
> removed under certain circumstances.

If the callbacks aren't called in a properly balanced manner that
would be a bug in genpd. Certainly.

>
> Did I run into a core pmdomain bug here, or do I have to balance
> the power_on/off myself somehow in detach_dev? If the latter, I'm
> struggling to figure out how I can determine that the PD is still
> on without doing my own bookkeeping, as pmdomain core seems to clear
> these fields before my detach_dev gets to them :(

When genpd_dev_pm_detach() is called, the device is being detached
from its genpd and part of that procedure means calling the
->detach_dev() callback.

When the device has been detached, we may have the PM domain being
powered-on for no good reason. That's why we also punt a work to check
if we can turn it off (see the call to genpd_queue_power_off_work()).

Kind regards
Uffe

