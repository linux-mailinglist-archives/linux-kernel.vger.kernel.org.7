Return-Path: <linux-kernel+bounces-872252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880EC0FBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B64164E4B79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7501316918;
	Mon, 27 Oct 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjJgdn31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106372E6CA8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587029; cv=none; b=CSIgur4eaPwKLuU3kN4Xi/KdR/SHpvTWT0/TL9feNUjMNHGqFR1iwqQE/j/1VUtxJTY07D9a20VFF8Oe71dPJY1KOJ6T5nCmHxdwbx6GTPqcOEeqYmjmX2v0RvvIC/Nz5jIdixUCpIhqKAuAJjp+TAVLFDHWPbThO0TP23rnJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587029; c=relaxed/simple;
	bh=nS2ceydtY7arO53figgNl3Skob7MFYJcnB/okNLIQQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4tT48+wC0QU8m9jlD0vLovtWr9TDu+2B4fYYTLbRNlRIS7pkH5caEWbck4ikTyw2SMBH2isS4Blv8KvKSrlXuYMo+pVW89/Pbd5yqMB0uPGnEG6o8Dt/EN+s44GTeBFWt9K+vj2F8nAaYPV5k+t2l7ioKO25nvBfrDu/UoCpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjJgdn31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77BBC116B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587028;
	bh=nS2ceydtY7arO53figgNl3Skob7MFYJcnB/okNLIQQo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=cjJgdn31XIKVTvn/EQRmDwJvDk+eUYujuuM1rf4nIDHf8QMPJnsaHb8ZwxrF2X4w7
	 FN0rCQrr22UjMCXMMgvOCfwTtIIaq8QQuJHGtcJtp1zYhWg7OlI7c3y7HLJAE9kgPt
	 vQYvgjVvfu1tubtbxXnq+MD4JJDp/ev7VlBbHkVjeKVBPME8BlPWj8AA403wkDCBDb
	 D5NU2EANOWv/4e4ipiDfu3b2owrASECX4K6qOre8VZbpFj9Y2Xdym8XURQurHZFHg6
	 Fhl3bvO0LfuVtgI5uP+4Du5TuyeHhVsjdV9i9H+HE0oDjHCEtkR5OMQnFDjdmxDloj
	 pDnqcStXCz6/Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36d77de259bso33022441fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:43:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWP1HMr8R7NMl19AmkcEls7ar+/LvnWvIan20udEYW6hIrvcLxIz94RHjMz6/CUvfpZ0eiMRI7XFEJQjNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pp4GdkwQo3iHFI8D0pGcrlnhBKo41rl1bhi9Z7OPz2fHgz92
	gG15DB+RXIaAjaBmv4Hz+Z1GiGGq7d47rpGn/szuOHanIo/vhDHEaPz2+ufQFxBXx4uUBEIxXVz
	MKWPwNX13eoYSzm3voifozZvBm59YchE=
X-Google-Smtp-Source: AGHT+IFUgpNOk2/lm1vINh6P/T+9hrDdSIGL0HQ0DNlL7efemsNxiG/a9dBuTEttStk6lJAJUQFTUsvRn5K8JymcC2E=
X-Received: by 2002:a05:651c:4112:20b0:378:de30:74e6 with SMTP id
 38308e7fff4ca-3790774baa7mr1284371fa.25.1761587027036; Mon, 27 Oct 2025
 10:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-17-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-17-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 01:43:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v6545EkcOCXYj2GzVNh0NK2CzqLEgHA+3yA0WcHu9jDiMw@mail.gmail.com>
X-Gm-Features: AWmQ_bl_-VKJDXdC4sK8FJlKiPnwMqUHPzZ_DuY_Cd04DihfBUomCFRnXNe5gis
Message-ID: <CAGb2v6545EkcOCXYj2GzVNh0NK2CzqLEgHA+3yA0WcHu9jDiMw@mail.gmail.com>
Subject: Re: [PATCH 16/30] drm/sun4i: ui_layer: use layer struct instead of
 multiple args
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
> This change is equally a cleanup (less arguments) and preparation for
> DE33 separate plane driver. It will introduce additional register space.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

