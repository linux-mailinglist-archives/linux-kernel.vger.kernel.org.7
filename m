Return-Path: <linux-kernel+bounces-859569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784EBEDFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C751189A522
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8A1369B4;
	Sun, 19 Oct 2025 07:41:46 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64799223705
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859706; cv=none; b=IdKBqQLHvyeYktaRxKja2qLU/fFjzE5MfFXtR5nXmsqSOaXhuw+4C/iAwwGRphCy9H2mCj5zxA0+akcOYQXJH2Z4v/Yr+z2E7cImZrsYqIzHCVvaer1mbIzKApvwTQF+Fa/2sNemKc5bfAHTp4U++/PbheK1aiZkoDkrUjk+Vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859706; c=relaxed/simple;
	bh=hjuUe+UFCTyI3ZlwUaVCKaC02uBTC5d7Of/hpQUOtLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEtzbo+SjLg6/hCxaDH8h2DNu85uAaPYIgMBFbt+/rOA4vHn+DiFiofohgnBHdTuCX+Vr4O/Tpbd0XXXN0xQfzsdGA2VAxU5/B4wGLkRKoSUGnuPR7smC8qZvWywRT41wmchbzfSqMnw3cuhn2/JaStIO0w4iXgSKXg1R0d2k/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e03279bfeso3800675e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760859698; x=1761464498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjuUe+UFCTyI3ZlwUaVCKaC02uBTC5d7Of/hpQUOtLw=;
        b=ICa1/EA2h6OLSMVMbB2HAosyDBruJPrC1ptSmtvUeUNLHw1qYrsYo7ibveU4zekHCg
         3G/bTYYBC8/M0XWSofLTnEI4X6Vy6uthe8u8zV6vXwO74WlVznQ6hNSeX2F8915tkK6I
         E0c9rLUMh+8YeSS6m/RZzDLX8MRCJ0pXkAa9wkzz60ZMQnlb3WPfidXSFYj6RmO5Od+m
         WYeb6HMNmF1cw5W1jD7LP+qNPCiVdZzavr09kJDUzmU5IMQX8rFL/Gr6P3ewHznPAxGy
         uqC1RoznUK8zEwc74Z5iA4T+hACcpt+BSFbDRV67k40vAVuNGlAq/P9V7FDNdbNmbV3L
         /fxA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQVWqe/5WDVAP6B2yTruh25Ab/aMjfiSCALLsDlBZwMhEoHpaWrkL+JF5qf3xa750RlqQZ4p7d7sswug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62HMJTLB5dRKgQcWkQht+9edVcZY4VNR3Vgp+mi1kO6qwefG+
	E+bXlBJKfn/5hQJCM+f3PTrenHtT/5FilsuIRSVPjL9nWnezkjLFnFost0qNftlp
X-Gm-Gg: ASbGnctB5N9f+J/RhqyPakWZBbZbwOzdERIFsYaaH/Q18uGx59qky5YhocajUwlL6H+
	nWuTzgyQ/hiE7pYTmxHQNYpXVqw/Exzn2gMyUGu6Z//rCbmug6ScPorytxM7IByLqfvpnaj+Is0
	3a6f18JsgaoK0tbNewL7NHbPYzLbKvlesagy4H1Iw53KUZ2G8Q7OPdj/Q0yQzT4sHX7f7u2Ndmc
	H+0jtCLoRtR7xoTRZD46dCN+g7bOGVFUIbi3r75QEwbo+KoZyuc0QYPV2+xbwJ8Rvi1QxIss/u+
	xJltmD7yLo4im6nGY96A6LMUgVhgxDQYETi6ERE78Xpa37JUgjbFg0Z6LGYZ/V6mSyGp1PpwAbl
	IwRsXHhSZXC0h8BSK/tiBY9+VVCnBC9Xh7DC8oohw0OUsHfe8uqpfyTGa9JBj4cFk1Ey5bYs7We
	65SGEJwPdlo2TLCl2sTQoKQG8Cf2t5Gr5OUTSsn4EZaTI=
X-Google-Smtp-Source: AGHT+IG3HzEccthApr8404Z3Cd7NiQqUdWt64OTUSf8niSqzVE7scseD6DSLAgO6xINrv6p9RGXtEA==
X-Received: by 2002:a05:6512:2398:b0:590:59ea:8a42 with SMTP id 2adb3069b0e04-591d073a95fmr4433170e87.6.1760859697429;
        Sun, 19 Oct 2025 00:41:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec11a7sm1358932e87.47.2025.10.19.00.41.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 00:41:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3778144a440so39964151fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:41:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ/2tWmJcNxUKS57XEnt4aXpx8sdJWppp1/QQ6HZEkxM3LukEN1Ing9hkKBU3kECcBTLtKmCveTV3Iakc=@vger.kernel.org
X-Received: by 2002:a05:651c:2113:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-37782137beemr41886461fa.3.1760859695663; Sun, 19 Oct 2025
 00:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-2-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-2-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 15:41:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ddMgVSFFtQde34BY2FcjPn38hxCsvVQ+m5+fOJtyJ7A@mail.gmail.com>
X-Gm-Features: AS18NWCXbetOzzBsxzmfJfwCXigzPHLCDC4AqSPGnEbYZf4O62hkT_fB8IZOMeY
Message-ID: <CAGb2v66ddMgVSFFtQde34BY2FcjPn38hxCsvVQ+m5+fOJtyJ7A@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm/sun4i: mixer: Fix up DE33 channel macros
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Properly define macros. Till now raw numbers and inappropriate macro was
> used.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

