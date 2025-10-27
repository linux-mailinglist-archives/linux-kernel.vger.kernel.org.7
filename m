Return-Path: <linux-kernel+bounces-872271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC95C0FC70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CB519A880D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE332FF65F;
	Mon, 27 Oct 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmDs5Ea2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457572BE647
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587371; cv=none; b=j4ipO9BVYCzNWICMBzO1GIxp/0kQAgVqKFfwdnz/Pd0SBZQVl2Vg0QO+WoYxdYFK3E3C60RvJ0nC2vkAyUv1GIT9NcfVQbJt7m1YZdiRU/41aDck0Yy+QptQMXaSDQRwfqeFJO9onfh7wej5TG4ouI/qTxgrqz+iNkZfnosUhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587371; c=relaxed/simple;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8WsQYJ4LHV9arY/n1SA5MwhbHVhZyOLSvJSjNTr1cOdwyhrX2YTHopIOw/a0nwpRqBzkJh/vrHUIuiONoIoAknzB0x5LtR3QX+F/yg4gI7U5zE/4tQm22Q8RqFMKmGzVAmeDDZWYrzet7LBrV7htzUpAU1sFFtUp+G9AOXOfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmDs5Ea2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C0FC4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587370;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nmDs5Ea2BJ0QWZz2Fnj6YnJCwAGH9ivTFSEKB7hbsxg40ESYbuLp5lADWA+AVBpAI
	 yt3wp0PEAGmkqI0b9jM1OEM115cLxrFqjqAADUnRlb4lCnM4qxEOhBG50l4Ht6QJoH
	 dPGJjWkTO+ZdnKTxP4Kr542JJT2c0n6l/hXpRMNsrK1UhiHuAYpCx/n+DNSh7fneiQ
	 Xz71EBZIifFB8BGItaAtKMD982nX1dWQP7diMxUr8JpHi/7iL9EtY6An6BUSDDg6uw
	 pPF1l5md43z77yxjTWXZLF6zRcHg0m25WL5tXIR2qgz3nf8MDh3xga2Jx7QEOhWMtc
	 kLpCppO/X+xlQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378cfbf83f2so54766621fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkdJVBBnTULXfWgXMfbO84AmkQhxXjllOHm10Fz8u/98PYB9dEP3URdCdpxD0+lhBwlZu2hAq6ZO3wbLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDwV7xAA5b2oAg+fcI4htuK7c4vf3BBC73QonNjzzFdRLjPM/
	lXrIzMl+aU9UrLzndo2+e1LLB+PejZ4cCluOC6EucTmGUefpsDFmoHJosNtk0aSkx0MDp9Ibhxb
	67YZfD3Fdogv70GxC1O65H0vL7SfA73I=
X-Google-Smtp-Source: AGHT+IGvL3+rmUcT/vmlGB6JqgMLiakuW0wtgocLdITSs5J6YhIhu+bJ3QUjjP/Dh4NLN0bmdcv0CpnIkj1evrKbsNk=
X-Received: by 2002:a05:651c:234c:10b0:378:e097:e16e with SMTP id
 38308e7fff4ca-3790777de3cmr1218271fa.36.1761587369224; Mon, 27 Oct 2025
 10:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-19-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-19-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 01:49:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65aY11Hi5JN1PEMyFCoYK9Z11V=xYXLcSLqQizwdVOarA@mail.gmail.com>
X-Gm-Features: AWmQ_bkqzQW934j8vgxNIiz1K6pixo4CW7R1IQZPgknoWpc_MwhACwyMTj6ZI0U
Message-ID: <CAGb2v65aY11Hi5JN1PEMyFCoYK9Z11V=xYXLcSLqQizwdVOarA@mail.gmail.com>
Subject: Re: [PATCH 18/30] drm/sun4i: ui_scaler: use layer instead of mixer
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

