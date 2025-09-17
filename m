Return-Path: <linux-kernel+bounces-821013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83991B800A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296463B40AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D551CDFD5;
	Wed, 17 Sep 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUYV48in"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B041A3167
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119570; cv=none; b=SSRKZHnToGK8bB3iuxQA01jQPhPpjWWJgTs4BpmLwiD3PdfxGify0vfMU8D3mpRSWRr9I6R1XzY18HfYNs5CwKOskdLwepdeOWmxF5dgwBIF0Y08FlngV8YdL0ECIVVqNLcZrz9r2av24wGDB8QHkvQacJ3C7oLYmYQZ3s+TOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119570; c=relaxed/simple;
	bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyqnLqlDwzkbdggfIXS9Ioyg/FBG0LWKnqo9Ivbv/XKutkwGWa44J79aPC7TdxBlv7YuXMf65p9pVSX5qrnzd0WoowyFKId7U6BTJRjqzeA/+s+7F4Vw9TkthoMb5Ggh0uj2T1R8Qj2zmgbrWBJw+UBkKsbiOmyLvf82jnLZr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUYV48in; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea0150ee46dso5585236276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119567; x=1758724367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
        b=OUYV48inhaKrKUvjYB7tdrAfAuewYRj+RLVJWMrAY7IAFAzABVufqZV5YelVdS4xr0
         9Yhewg5BsXreT2vaPw31Pq5/GGt54tgd/QBGH+3es0fxAjhfutft7w4IIYAb74YR8Bkh
         5NWViOjWBYqSXx5mn50IfB2dQSFXU+/pfVNKQSDDBNcuv7gzCRXBVE4yd5c9HbC7P5as
         f1q5JC7+3/w9VGQo4FhAAICJrjVc02MmdBgY3GPXYN96Z+EP6I5bfpC+KXnNRLnMlTj0
         2GdAyayUYLqVV48RKZ2YtaKu5uM2+w6ap2WxzEpFdKlsAeb8fXmd4yjkaRoYMrFFWPym
         eAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119567; x=1758724367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
        b=UPX46Fd6p0BTGvqllTzhTNG6DqsXjzlBYKNqCxf6UJ/v0w+lMoAKTryBqJOJEg56TN
         RFTJWSVUv0rlWIcboPN/mE7MiMHqz6h9SIMLTg5E+Ugt4Min62zVTVvm1mzpVT7IbaRJ
         W0XMgZXhi805Aqjx4CEUjKDU44G1j5JWzzo8zVJfY+CiK93e2gpj6NY6swZ1UvfYSwpc
         B6lD6/B6o6dQzksdcmgKJXyJQYAFtglhHbfLZledcfnj5PbCEWCL6egBG0TTGrXH4zBv
         reInU5nxNTtIuhjQBW4o/yI1sORgNQVmP/iFo0AXCxgIdmmaeyIDpu5/XWjuNspjhMyH
         ua0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzVh5igxmMSpWwPK+x4CGA4RcK04BTtM+WCJUkNnFu8eHsL1shtswQ70OEB2gB6b4tazFRKXhR+Ae3Xgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFzQy0qQmzdz2MlroxFft70praqrRGU6gpMM2Ls1dP9cOBRwH
	F65VR37Tw9T+aWPY3mUjb3wEtJCsEGyAUFwjZ3L2KDXv2pVjpqLE30K/6DV3FqSXdowrtf6jwPT
	KAl6ul3RwDN+BEulZaXM6GtOUsp87YamIhfZNOJVg2A==
X-Gm-Gg: ASbGnctan0obGOVA5kOEe1QsTIDLz0mBHODHAthieNouGkhYAxReWv+difudZOQcbma
	NRigLwqtS4L8XGHbq3Ta7mPTlQ1RqHtO1QkmcvWlJu8mtuqBR9/aGIg+b1pp+6czlyqROs0so5G
	R4luN0pI/rSz8Fb9tHVMuSTz60RvU/T4gr8Xd8bSHBfrWcwDw4cepvYwDtWxA9+2hxf2qDdkkea
	TlLWN0z
X-Google-Smtp-Source: AGHT+IF8958qtxMgepRmmh01erhzEe2CCKMaB8p0aTdmbEk0KITYYPXFKjQVfYFyDlneSgtW8sFxeX7TRTnXN5JBV/c=
X-Received: by 2002:a05:6902:6c1b:b0:ea3:d667:affd with SMTP id
 3f1490d57ef6-ea5c06c1586mr1899822276.53.1758119566841; Wed, 17 Sep 2025
 07:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com> <aMasUV14w0Dc1ki0@redhat.com>
In-Reply-To: <aMasUV14w0Dc1ki0@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:11 +0200
X-Gm-Features: AS18NWC-l2ZajfsWo9MjcYD2GJjmouYf3pDYfF1nnijLrVzTzi40JFoPMgBPLz8
Message-ID: <CAPDyKFosHY_aVP3EdzXJj4=DvZCPfC5c80oSwTEeyyV-7MRQJA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: airoha: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 13:51, Brian Masney <bmasney@redhat.com> wrote:
>
> Hi Ulf,
>
> On Sun, Aug 10, 2025 at 06:16:19PM -0400, Brian Masney wrote:
> > The round_rate() clk ops is deprecated, so migrate this driver from
> > round_rate() to determine_rate() using the Coccinelle semantic patch
> > appended to the "under-the-cut" portion of the patch.
> >
> > Note that prior to running the Coccinelle,
> > airoha_cpu_pmdomain_clk_round() was renamed to
> > airoha_cpu_pmdomain_clk_round_rate().
> >
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
>
> Would it be possible to get this picked up for v6.18? I'd like to remove
> this API from drivers/clk in v6.19.

Sorry for the delay, applied for next, thanks!

Kind regards
Uffe

