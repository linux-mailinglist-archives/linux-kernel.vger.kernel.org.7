Return-Path: <linux-kernel+bounces-751566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B55B16AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F55618C7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0923B619;
	Thu, 31 Jul 2025 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLQJtc42"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316ED2F41
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933619; cv=none; b=m6oF62MBI+S1sQtBEAuKS7wnhFbwNqStjGjCD99ryffPwUiPCZyWx625txJ7XwONC111BGCF1G4AC3VW9T/b4GeHY/DDE1TiByHD0n1CPTFIEWL1mI0thZiRSZEzt/ewKReebQk3Te/bjKACkmRuZ4IfzELogSvDyZPhEO+im2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933619; c=relaxed/simple;
	bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISJJY+lSaYPwGmMxy4dEXoPe7VyP3vu3i72QCT4E4LzZWPRiiq39Bc9t5JSSB/omxJjVLlZsp35VVYKMC4pmN3/8Wdm2XTtl6MubE6NwdT5/lb7L52yrgMbDF5k7SGISIg1PG9IUyTaTLQwIvKSzv15q6jEeyLfhl9vVXnRsTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SLQJtc42; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5376621dfafso197823e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753933617; x=1754538417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
        b=SLQJtc42ptwoDJPt/0gyy2PQDgdzIAomyLQl6hr25Hll0eU2/pKMpdzwkiz3YyrYAs
         FPfw9Rzwb0iU0bXtpFpvFqCkcF4IdsTZznUbuohJupEuFLtKqwyzhiK//gxh2pPeWa70
         ckb5ylg5CRgOaRY3ymd/RopymbuOR4Sf6nGko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933617; x=1754538417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
        b=XHCJzsqk2Tv5ky8UsGtC0a/W9cHuYJ6xDrH9qU1Qf56PH4RsE36rIxqs//LA6mh0aO
         gelLnch6R0wsbVsV4/PuDBbfEU7nKAG1L+CuQPAEgvDBJQ092cyPNXdYYT65TVZ7SOEA
         06pWJOCzN4Yu0P+aqcNKSj9NDa2tkooNxMczJMEoaf6Slv3hgI8uMVkY8qRpufYsnkTM
         smOZeeg/6hGQ4u3UyhxTr04LtnPt2cxtOZmAXzzOgEVR74Ts3gI8cjvaI9O3ZeVPSiPJ
         YAe7/xGRtDbNxnH5nGAHIaBjFVs2HYmm2RO99i+BM/7bSzkg0wWOlqDQEbRJUHdiUq0m
         I8vg==
X-Forwarded-Encrypted: i=1; AJvYcCVwADNqyNzHitBPzEc+yQOcqcsLVBCZgeIXYDblE2FLqXiSk9r7zeGRzBVgt8yffvPVCQWHhW9ukq9EyUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeS5YQXrqoIiEotO1Flm5I8ihwQcoLzr0t5o/6DEedoXHQftD
	psJZOgcukLsd7WOQSMRbIWecSh3pBSdjAb5Db4+YScOFldLEGOyPT4/2XHtQBNp78cLCBL/aeb2
	gJkA=
X-Gm-Gg: ASbGncsSlUlBN3c/PmCJxYaNLfHF2EIHpGYUMxMN9PtJVBVnBNOrVyHDo8pHXq4nh/M
	z5ObyPC7Jofaq0Xh7g6tD2l9CXdVm9LCi86QxcPaEJMy/eTcH2+OSKMSnFs8kN2jUqjWx41b7NF
	lGPKSEG29UQot8t3FNBobkl7d4s8ir5RUKzEbqjza7iwdt1JFIXiVbriJK9jzznci+SKK5/3wTn
	Rre3e7VyfFFnU2ohsb8QL5aBSEseAP8Q53pXj1Kf9h1DePi8lnBkre8T13I8aq3D30mjoIFWOvi
	T742v2RYyP2M6JiO/bM+gKVK4z/uBYMnVfEXibJ3yqaMbq9DgaabXnw3GSoNXtFoBw4O/Adnd65
	YwIM6TuXPSWObEzTY/Aun/nrw/lnnALea0gWZvfxm+/SHGWcPdFgIAlKXmXvQ9Zp0gShF
X-Google-Smtp-Source: AGHT+IGIOed3z7fS4ODvdZnKr52jfl+L0M0M0kldlOvjB25hi7Njy9Acl8g6NOCtqQFIRtO3FD8tmw==
X-Received: by 2002:a05:6122:da7:b0:534:6840:fe0a with SMTP id 71dfb90a1353d-5391cff7f45mr3881731e0c.8.1753933617137;
        Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936cbbc29sm181523e0c.19.2025.07.30.20.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4fa75f98b61so185812137.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeM7r3sUuU7piTDuJsfhQ+WpZMWaKixbFNPrTFVRnqQR5Ma6mh3PZsBtHgchqQsqByLrGvpmh1FDueLL8=@vger.kernel.org
X-Received: by 2002:a05:6102:3e92:b0:4fb:dde8:76cf with SMTP id
 ada2fe7eead31-4fbe8753b11mr3988803137.13.1753933616614; Wed, 30 Jul 2025
 20:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-4-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-4-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 11:46:20 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj9eVDxSxPuntMjTSrwhVAhVLMs_s0aR+COQjM2HB0S9A@mail.gmail.com>
X-Gm-Features: Ac12FXyuQfNec5PpeCVYeU9gZNhVWy6e9AZ1QYJ8r0Oc3K8xhe2Kp-euR4Zabx0
Message-ID: <CAC=S1nj9eVDxSxPuntMjTSrwhVAhVLMs_s0aR+COQjM2HB0S9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] thermal/drivers/mediatek/lvts: Guard against zero
 temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:32=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.
>
> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff c=
onfigurable")
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

