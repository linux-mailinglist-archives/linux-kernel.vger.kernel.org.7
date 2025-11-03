Return-Path: <linux-kernel+bounces-883410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C910C2D665
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54273427324
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081331A7F2;
	Mon,  3 Nov 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaY6Tv7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778B31A545
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189549; cv=none; b=THZU1fc3SiXANiP6vnRuCA6Mp9lnJqxrfW3+tv4pKR4VX6xwl3A78E6BkHyMBcCKODr8OTrZaZis9I3OlnaCtTp2GXUhPRMJ7Cr6zA0yDHaRTmIlXZ4kI1h6tMZ3D4AcGRThGAG3WaT+uTgxlhJ2c2k7OcEHnXnlJBIRn9maAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189549; c=relaxed/simple;
	bh=R8/epIwjK6bK49ZWSDEUOL8uhBPyT7+iUssIctqWPwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEJOjLxwnveMH8WUGsvijyPWlm7g2Ghn7By3ME8dQktDw39RpS+HeAqCuu/Pnh0vcIgCC4/t5tCycjFzNV1ypN8D8EcyMHcKEs168E0TlOiw+wf+TJZZ9pyXG94aud6R5pe3T7jCzZ7/VLGAXNZpZr+KyTZqVyC5osLZEmciKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaY6Tv7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BAFC19421
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189548;
	bh=R8/epIwjK6bK49ZWSDEUOL8uhBPyT7+iUssIctqWPwM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=EaY6Tv7cHr4o4Vfi3GSo8Tkg1iZPjIh2CtCdICyPQfWzhfho3O8ACsyEJNXCcU1f3
	 D0LWz0bttvecSDQLjs1boz1AEPsi98IlZT/T6MOs97sSv2Lf4zuv3p9LD7jpM/N89E
	 o4Xbilz+6y7+bCiNnviZq2GSlOI904Ai1Ea9/gOJgpw0Ht19WCfrD+i3pFUeZusmEJ
	 ZnjlKzoIjaezB8RYWF0m9qincwp49CKthFdx41zFzi3kR/Z7H9xhltClZkWSzYMv5C
	 D9zU0PTPDK21/3gwmirE7CXW9svxQo/d+TviHxm2ryicvJ0TWXZsdTCtpIa4jrRiYF
	 NF0ZcMjCfN/GQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a38e56dd5so8298151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL8WKTZQd+YUlG+aus18dbCvWpv4LFT0zY6pFxswK+PkWb7DwA7lUH0VVAsAWUvuF15gNR/8xYCYRzM+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbYalEjcgTStyxHNGqmS6c2DSgK+rxXATdtd7uTweqYfSe/o6
	c/R6i84c6KRKqDPvK0BjRhg7ANyoQ/phZqns091HzLgngh5imDqRJCBmHTQlKjtGVgHG3bcBIm6
	GlzS2iZr1o+fuJI3IASLIoJVodVYiCBc=
X-Google-Smtp-Source: AGHT+IFFN6zMGk4DLXEheEbfJ2wV+RhlYINJykEwMAz/aoaR1rEWNKZw5HxZGXozvXgetNVLf4i7Wb4fjcgrBvfmKaU=
X-Received: by 2002:a2e:7c1a:0:b0:350:adaa:6b93 with SMTP id
 38308e7fff4ca-37a18da8ba6mr26603351fa.6.1762189547139; Mon, 03 Nov 2025
 09:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-26-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-26-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:05:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v67=Qd1G8JyR=5TABHf0uzoiJAw2-TkG_zMKyB0UEnOevw@mail.gmail.com>
X-Gm-Features: AWmQ_bn81nvhbH0jeJNTVxHpTlgEQh8OpKt7eJ5AA-3FjjmbBjHnZ0HpUXyPv1g
Message-ID: <CAGb2v67=Qd1G8JyR=5TABHf0uzoiJAw2-TkG_zMKyB0UEnOevw@mail.gmail.com>
Subject: Re: [PATCH 25/30] drm/sun4i: ui_scaler: drop sanity checks
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
> They can't be triggered if mixer configuration is properly specified in
> quirks. Additionally, number of VI channels won't be available in future
> due to rework for DE33 support.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

