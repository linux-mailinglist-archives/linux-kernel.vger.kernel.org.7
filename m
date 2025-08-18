Return-Path: <linux-kernel+bounces-774225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4128B2B012
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335C41B27FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710F2517AC;
	Mon, 18 Aug 2025 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtZkh99D"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5132BF45
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541021; cv=none; b=DO7Zf25WxdlD+/ICW2q47XX8bbp8dyyZAy/oN1J+2kmb0s0Xz7vfECYmY0GRCNnTjJiZTlA+thQ4dnLo2W8Tp+ZXYD/cUs6CSdp98VZtam2K+/WVGDwc/5L143dAOcg0R+/aymwYIOEOUCwQ3W8YExfD/xWMVzPwvaks9j5CN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541021; c=relaxed/simple;
	bh=C1Y1an+sUmj2nAIDYJEW/GfH6u44YkSququT3k6djnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp2dBYRaV/1+h9dkcwIsoZErXkOwPWz/gfW0JBV9lHYQTIfN+wXaXvLoFHcr4i+LygOa5FpVh6Hq6aN20IzxFbRE5LRSEfy9ehOeRQ+Qhs2dmmQkOk+SX/FXz8tXbek+oW9gJ6z5V72tGXg0x1qXOxzYMSAQ/KK/lMdpQoExfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtZkh99D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55df3796649so1472e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541018; x=1756145818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1Y1an+sUmj2nAIDYJEW/GfH6u44YkSququT3k6djnw=;
        b=jtZkh99D8KgPXBEkA+bgaXUT2xfiSCjYdn+L2RLi7A46plIvwETQelo0YZidt6StQC
         el00aGuYG23FtcIsELDjrvw53LGWOCZx5qixD4Z+KjEbs7yrfHvctGXNr+s2Hk748g6E
         wRHyuvJYY+Z+tIfJKMeAYPoT5vXOefR81eEhnQUuoawE0kbjqCiw+6gLMnBVeAXCPAIm
         sxITD3dTUozW/Cj8+DUgyequ01SKoWkcC8jW8ZPB/Dq/IZnTR0mqPOW0aYT0be0WAhKp
         TDcoZsxboYttrELHuvtmSwJJDkfq/6M5yG87GE9tjqV1JQc6e+T7k/8S8WLlXrqd7pTd
         pY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541018; x=1756145818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1Y1an+sUmj2nAIDYJEW/GfH6u44YkSququT3k6djnw=;
        b=wkT/kybeyoprrLLV/jA5sQSRoqY02cPMzGlR/OSoP8FxM1NnQCeFwvJdufAKuyaDGK
         ZOEueUJJB/wb8tu985gHSl/u5/yNvFCo+mQmC8jXh4O0rAUJPjcK517V7X9moM6fdyNw
         zEhucbpjMJQdJkiLOlHkYTuRCm9z+WnCkNps539z9+3HrMUradI3Kcjhrdf/kSEpdwmr
         1FxPiM67OqapPYPDALVTMrIJM+yYbe9PXtcQpDLQn/wHJHvSdsLcImLr5aqQxdCi+6RF
         HHJ+sv+zNa4RJbNalYfAdqJyYFjqQmZm6BoJuJalkCoDkN6vVgjaZyyFL0JEhxF4eg/c
         XN3w==
X-Forwarded-Encrypted: i=1; AJvYcCWGe8O4qYIKWcpnWYxPMAnJtaB4v/JecjF8PMpYDvTcTBVA+mnKRRaIC9FMdKYU246Ru3mt5HrVAK49JGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvW7tVhz0YGUdDO6832wRcEGNSqkW4CeZox4pIi4y6X58lnql
	0JHoYvrk/+desghWjJ8H1ME44vVCjqJV2Oe9sjZs4Fp+2t31c10sa9XAHtfL25S0Fvwh/89i9ZS
	NoTlctrRLx8w2fxI9QWlYrUZCt5kHam2cm4cpJrML
X-Gm-Gg: ASbGnctQI3NuMPX2XWfUssyDH16OqmMjLGsl7o/ZGno/FWjjuLLWKp6Q40I1pqryK62
	qqsR5Z3JX5/IkPLOgeBIiJRwvd4aVWczL3Fb9xOVqdXfr49c22KrZE8mOb53Z6It+tl5YpQvdQC
	ePdrzoQ48c9doQczuxT5UjAvEPf5GA6RaHvc6ANOORrZb6t++2sbwnVDhAHB16ZCKfadQVpKpR2
	WU4fkmDPOaLTJaun/IF4Fr0tidgEP4TzCxpx//baW6uB1Ji
X-Google-Smtp-Source: AGHT+IFrEtgaEleSS/E7MfEjCCsdfFWnTZVke9fjOnKYpBW8UgHErfLttqygIW2PcKBPJauSEscACtqWd40In8O2shc=
X-Received: by 2002:a05:6512:61c8:20b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55e000efb91mr11705e87.2.1755541017364; Mon, 18 Aug 2025
 11:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-4-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-4-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 11:16:44 -0700
X-Gm-Features: Ac12FXxbqw37w2Q5TXCoed0lmNK_AKgfOfQNYIHB02CLjHEqLFsUSXJLgNpeSXQ
Message-ID: <CAHS8izMiS-OWASmzy4ZKYrgd50Tj92CkUndC+E12drbziZjE+w@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/7] io_uring/zcrx: add support for custom DMA devices
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>, cratiu@nvidia.com, 
	tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Use the new API for getting a DMA device for a specific netdev queue.
>
> This patch will allow io_uring zero-copy rx to work with devices
> where the DMA device is not stored in the parent device. mlx5 SFs
> are an example of such a device.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Looks like a straightforward change. FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

