Return-Path: <linux-kernel+bounces-872273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA5C0FCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D4BD4FCA50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0ED319840;
	Mon, 27 Oct 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4dvlx4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B174316190
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587436; cv=none; b=RrmO4ORIOvZNOd1Tgp1g1IDszKXEKkb3Gq6bSzcDlqkJrIH/O8CnxOSdY3W6en9OqzvNDdEacjIbj4ZQjKEBwjd9ScgZnObvdEP6pRTkunWgbu/rDxpN/GE6Wgb7N043WVkX/maZv7qIQBDSMENinq7UdF/6iwW+DHEFpW0WmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587436; c=relaxed/simple;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceCP7oZcjc6vrW/n0FDQRql5kHdcl7uSqfwZ3aIDlz0btXQqfQWtpGDLuSetgCuuq6tnTJt2Nufvz7XSvxDuIaNQpUdc4V5rjFBBpmHr7WetnYQDd9Dec3ysetGVEKnTXdY6DCxs+Yv6gpXF+pxgUY9OWvnTN4oWUdkjNyuzQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4dvlx4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4A5C116D0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587436;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=m4dvlx4w6KBYhxMDLAI4pez6ydEEk4UGnFPonnYfoR7H9WrtL9a9gDNGskHkLVbLq
	 vHaw3VQTv8Jbzo3c2B4UUdm8/ruCVOjP3nDmJP1oy7QJX+QQNgtJf/E0K/6AXHy343
	 wk9RY/KCy/N0u1XJdTuCfSp5cRvz74+LJbJQTPM0JXROCtzEwfdEQ6NyURMzCdZvll
	 xRPWUgKPsZ0tmso/txU7IZXM0Fx0XAeGCFXBKY45mIGHlyRQJmGMF3yc/2Dm5prt13
	 NhfqmSb1VZGh3h7dG4T/m0TDD1VzTVVZ1ZSnsdsBKTQtY845SwsrWbd/6MPriw+hdO
	 xqOlQZc0Fs0Wg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-376466f1280so75391221fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrmwBEIQYP7RF95dm5IChhmmRNq4QGplVpf2RoKnxrshlA60PNmJnX9U/Vf0FcbxsNGW0riSzNU/SU9Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHW0VyfRx46soTUBRMrzt8KjAFMWTvwW6oR4QRmn48mXGV8Fz
	GtrdrsfksOw3C/Isq9lLQ7/bQs88S1+lsoZIwuJYK/W8Q5mRJDVXzl1/3w2XJuyJoUznN+vLE3I
	beZA+Q7t3tRxKZ6JcvDhmfzgHqs/zR3s=
X-Google-Smtp-Source: AGHT+IEpGNxxA7VDQv+o8rVV0qXU7mdmIaNInPaLQFSEX+7AAmZL6Vjak813oddK9k7tZDInWi03lBY0pbQ9WFw1kig=
X-Received: by 2002:a2e:9f10:0:b0:378:ddbe:2d93 with SMTP id
 38308e7fff4ca-379077813a2mr1483941fa.40.1761587434294; Mon, 27 Oct 2025
 10:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-20-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-20-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 01:50:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67mHaxFAZ_OtPoOfoKbV8x7EFCAmhiq7D0NY0zdRZ627w@mail.gmail.com>
X-Gm-Features: AWmQ_blUGjau3HSQfAh8dWnb5YOCLFjTOutdiwr-yTqdCVXgYeAKGne6ORl8okc
Message-ID: <CAGb2v67mHaxFAZ_OtPoOfoKbV8x7EFCAmhiq7D0NY0zdRZ627w@mail.gmail.com>
Subject: Re: [PATCH 19/30] drm/sun4i: vi_scaler: use layer instead of mixer
 for args
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Layer related peripherals should take layer struct as a input. This
> looks cleaner and also necessary for proper DE33 support later.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

