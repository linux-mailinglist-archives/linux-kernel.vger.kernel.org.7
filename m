Return-Path: <linux-kernel+bounces-872275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FDBC0FCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A6468FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BF3195E5;
	Mon, 27 Oct 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3hwdSEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507582F8BD1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587477; cv=none; b=RF2DxaM1UAP8ags+/S/4yQdNTgSyPiDFq1IVzpwRMQhusRFnBGp+OWn608M20o0RPJ2iCMqZaec/hSvvUPk2hvT+BKiDuuCEgEKE0/w4s92fW72CEMVsqp6obDJckE6pLSnqXhaEO3GdtH43Bmz1pi17rUHH1q+1rCOepgG1/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587477; c=relaxed/simple;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2bfRJSltoN+T+4yKYHzaLGa6ou+EyJt60hwBGC9b361cbIUmw4aLk5hXNvhh/nGPb8tIYH64iY5TZna4sKm0ceN8IM2Z6A3tZxeoRubi5lav4f0elJZed+SnCNiVnUI4HbL+rYIbHXI+WC8XV+/0C4FpGH3Jd4dbUxEXzX6qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3hwdSEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB43C4AF0C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587477;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=n3hwdSEwthgPPcywNsj3EZpS+VohH9aqf7E/4Ypn+BMqjXgEGBkKnjTt+Pgn2a9Rg
	 xU5t5+FZZRzmHNXQrMwFJzcn+vmfr96vLKN/eTH7sf59prfug7+AIl6be7heIGJPtH
	 ojO0/BREXByGL1ngRzOFhj8WjaCRjSXv4bjvGu62ZxcX96rV4g/1UUuFwzlXmYOTMb
	 OhOHNwSo4ouplu8PxCMSeq9b0BGW2UplgOTjxOix5Jwm1FlUUsq6kD++kGA16yNTen
	 NCdfhVIQPEEfaUzs2J0pwVSFSZtlyYZlHbMN8T6IBQJxcowt/PvzojJhy2lYgGIGvp
	 wEd5BmNMRQ1gw==
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-945a42fd465so75682339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:51:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX0rXfI0SmhuwxaiTqqVPtQZaBHqaMyjdyMwNKpB1/9gxZnOd+cl8WtIycAl8fcqUjFnfui0bQuc39hgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFrmsliQJf3SCZD3LOUAcLyUAHEU0uVZ4SyoM/fXHE58BMA8Rn
	C5lqqQgi4CD3/4sUaqY7OSdEtHIsssQ7SBd7ukdbm2jkFQk/pbtNTwEacqmYHM7XnUfVicxXCCk
	riq8r6NMTrBQiPPrimftwlaLKvwIYlnc=
X-Google-Smtp-Source: AGHT+IEhTGVPKoQalrYiBqAlEMUBEMY4lVStU7gZnh33SrdNNW4aszsD0LMWPepio43TunWqrlJUD6gVWjPrIKcEXaE=
X-Received: by 2002:a05:6e02:1a86:b0:42d:84ec:b5da with SMTP id
 e9e14a558f8ab-4320f7bdd26mr14178625ab.10.1761587476526; Mon, 27 Oct 2025
 10:51:16 -0700 (PDT)
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
X-Gm-Features: AWmQ_bn3iNNBGbv363upd8-xJWoo6mzsgGMKFnqSa-M9FJF6MPfIXgvUhr5jEow
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

