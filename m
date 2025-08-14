Return-Path: <linux-kernel+bounces-768492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC45B26194
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05C5188BE57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4C2F0684;
	Thu, 14 Aug 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nebqiF7N"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86628504B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165040; cv=none; b=Ci0oHcV0xHdAm7UBYtxaAmExjpQXSJAhMzxyKv7O4+JbPj74qUMz/Xos1V05hm6eK/xKTzVpXtLUwN7uOh8bUiS3q5qDoht/1AztCJjAbz9dsVpsnM8+FU1CYRHEkNeOSOEf6Y6xRzsK1So8w2jXSU6kn86CLInuy+K6V6I9qGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165040; c=relaxed/simple;
	bh=l+SUkVruI2YCcUMa+FcC5+QPx3okcUg5cMFby/7ouv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxkzWcFcioVhv0gKqG1CdFHIVj6tcCu7cgDkRD2JQzA8npk7SvNE2PVstT8HqaRsA0gfYJwTfparcKZZAtWR0aS6p0KL3JfSDBwl44PoNROxPySSLhy9m4qUdVIuqNyqbk7l1PKWalBuO5JXDEc8YXaWLj9EA10HG++2VFPQuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nebqiF7N; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-50f8b341e40so244146137.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755165037; x=1755769837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SUkVruI2YCcUMa+FcC5+QPx3okcUg5cMFby/7ouv4=;
        b=nebqiF7NCJcHoRXAn/SViTXhdILxqcbklbLh5n2N7hfKCJXSqGTpDWqmBcBD8IOwua
         sTcLyFpprWYG5alkFmSOhxbyk98gdDATS34lmT810NDtXj7pTXhnvciLRacufkBP0DQO
         BvAOPUp3TpwSHqo0p6l2UY6YfSD1h0Cj70J1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165037; x=1755769837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SUkVruI2YCcUMa+FcC5+QPx3okcUg5cMFby/7ouv4=;
        b=CcI6Q/+OrldROF7kJ+dy2PlVJw2Uk4cdyeRoxtyblpvPDRb28FllgZO+JQEYpWlVFu
         HKPnp3ihqyqfRjIyQ8asP7/p+c7eRklN7wW8Tgx8LSW8AV7xC/kLdHs/92aO7vp7aBEe
         i0XJCLXAB0qxH8F1rnxktqjN2/QCR4j1WP5Nwr1JHYmRDhiljBd8z+TfJBtvjEYlEsF6
         gwd1Cv8kJOEUoNk1sAhEfLVvPLc6/kHP5yU9jzQbgEDWyxdwan/AReZTEOa7MR8WGUIG
         VQRJEHWVjcStFXvRnaWSg6wGJRSBFCfO+fX3vAIt6h4i19xOXeS0dsaZ0a8bKtUcfk44
         mqOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdEUusf3bzknslFEcVNskZ+JV317UGRazLWMU32C6IuCSeA02PfLAccIEp+tokxsqQ96MjfUMwTpTJ7iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzMH5r/pqn8WCfxKJyPOvUd65xnvYak+5YtmkjFyu2yTofahO
	axv+YT15SkQiSKJIqdCYp5WHzczpPfY+GBKQg+ODX1nk242+ZnUz/83ynw/4x7qai1+JdYtMjXc
	JhuM=
X-Gm-Gg: ASbGnctNI8r5szR0hdWbgGI6NqfV1UrKRu/dW5+hHjmYwr6R/4R35Vm4gEEYqvMJG6B
	OXYgcjF22XFbixrIJ82vilbsEUL3ZlDw3XUuv3oU0f2vfGfyH5PSGursmmPupFIe6AF1p/2w9Ji
	U3h6BZEEcnRtNgDZIixriv+470EznkXRXAu9lnw32qDAtzuD3yxUfJCE52U7vgArSoylGhdOqep
	UgrW+BwW+U9x2egDonHf+OhRc2G/eI/zUkUAnMC9lXvYS93h7VvFDqu6cPamSTKKB7uKZ6vSqSD
	f5tyV823M4+cozO/99gD0iIBKf1mKElErUPJYQ0igRW3RKUXYFfgcTwmmgxxXZLr8/iEcpz6JBa
	iQ/5f1EsUcsC+nNt56pUMxQEQKM7P+Vjd1BVey2qk6ZW8xDHQqaYrhU2qrw==
X-Google-Smtp-Source: AGHT+IEWaVSVM1yr8uTttY7kBpE+AYujKD+l8IPOSpiYol56x/R0HqHlGRbWUbRqnIIf/sxM80Kr5A==
X-Received: by 2002:a05:6102:374a:b0:4e7:f3d3:a283 with SMTP id ada2fe7eead31-50febc1d9a2mr720661137.25.1755165037448;
        Thu, 14 Aug 2025 02:50:37 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-50ec2405bfcsm627280137.19.2025.08.14.02.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:50:37 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-890190c0ea4so179886241.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:50:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXILd4P/i6APhjxIxQGS3T4dyWoFrrnQVodHOlrQBAImNJWSSBLpdRF+2Q/C/QdbM//LwmoVbviMdI85M=@vger.kernel.org
X-Received: by 2002:a05:6102:3f9f:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-50fe030e2damr804847137.4.1755165036132; Thu, 14 Aug 2025
 02:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814092510.211672-1-wenst@chromium.org>
In-Reply-To: <20250814092510.211672-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 14 Aug 2025 17:49:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhw2R-2YVpgBnRDAn-6prJGm2a9oq9tCASkpXHDP_-BoA@mail.gmail.com>
X-Gm-Features: Ac12FXwCy2I4l7L6eb4V9g1X9AwsA4Ouah27uikhuRM8HDiKM-hrJ7wZo6sGxh0
Message-ID: <CAC=S1nhw2R-2YVpgBnRDAn-6prJGm2a9oq9tCASkpXHDP_-BoA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:25=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The first SCP core is used to drive the video decoder and encoders.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>

