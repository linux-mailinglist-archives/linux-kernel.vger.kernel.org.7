Return-Path: <linux-kernel+bounces-872101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BFC0F428
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8846B4F41C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F6931283D;
	Mon, 27 Oct 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ6eA3jN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB42F12CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582295; cv=none; b=FSHNhdVc0+uMjP4CVbk4cUoZdh/EEtdN4FdBUTbMvS8K87W5kZ3Cu0T0Q/nhU5Syo9DA2/r5Z0Cmv7pMIW4c4pzO5CsyuGIXhHi2tigJDrt8pgP04s5ZutqtBChyPv3Sstc1gK+ZIwfczWKwZu1io7gcaG/vmDZW6zralIOdJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582295; c=relaxed/simple;
	bh=iFUNgXsnYA88I+eiduiUIs6MsVz6z/JWH9W3jdxReHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMSl+hOcSUkY0mIOgvHdta50EbhiJRXg9MPXEcD+uhhi3tvq0hybf2Nwg6zxu2wNX3hi+NjHVjcGaHcRdurEiVDhXwZD4WcmXKzi+rbqs9NuYE3593gKeVrNkvVyzvSkLxPe2k85dOApRFUfDIJ7Q9tZERvAo5eDD4rhylBaZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ6eA3jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE7FC116B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582295;
	bh=iFUNgXsnYA88I+eiduiUIs6MsVz6z/JWH9W3jdxReHE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=MQ6eA3jNU6YthoVvX9LZ7l+80taYxI33oodM2msDJTiUA5VHRUvGusLkep3aCLkjE
	 3jmrvbvutcVP5Syp0em/zfmzPGmZFbs9LozbbtetBmEOG/lJwiKUed4kZrg2eNV4kS
	 b9UKDn/Al9scQPwUby+8F5kIvCnKk2qcqFh6U2K9S+DH9v5G4ts2XqRVjHThROt+Pa
	 3PTahRDXzojIbg4T1m9SHq/IK4YTvLwe2X5Nbk+T1z2Xi/UrJBuhGigCvyRneTP6PB
	 +afHi/6I05xqwxdD9ih3/mcO7p2Rhkuv947Nl8N3n/F4Ej59NjVgJ3eCszGv/37P8M
	 bFe2jjYotgUPQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378ddffb497so45695721fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:24:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrnnIMM8ErNV/GWPGiBlo74ICPzTPFDDRTnkdffOXYlaqNlyinWGoo+Xw7u9LyryL2VvIbjPYz4zygt3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYO3vG+TJ8qSwSFiUgSM+1mg+dfjWdOkQ/eq4M+lCqhailXPW
	Ax1vFlQvr+N9a4Ub0YB5urDqeO0+90Af9nLtlDD1mJ7uAQ7456pJXF3mVyX+UQxGN4/ugidK8pb
	4J8sepisYU5v7/0Da9QGn++AtxxvCq+I=
X-Google-Smtp-Source: AGHT+IHNdgAoqvQ51FNTDPIFsFNbMTSVRAmipqt4BZBmwcLmVQfhNjS4uyy5v2Kb0Ej+dyceOX4GBhIVuo22H/auzvU=
X-Received: by 2002:a05:651c:439b:10b0:372:904d:add4 with SMTP id
 38308e7fff4ca-3790774ba0cmr625021fa.28.1761582294117; Mon, 27 Oct 2025
 09:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-10-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-10-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 00:24:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66f8qajMGCYLKPuS_mg73KejXx-OpfQqcdEf2fWDZkDig@mail.gmail.com>
X-Gm-Features: AWmQ_blCgsGXDdJxE07gjzrrlwEozdYBwqYFXf_-O0uUfEiCStxuxYsNrPVbQE4
Message-ID: <CAGb2v66f8qajMGCYLKPuS_mg73KejXx-OpfQqcdEf2fWDZkDig@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/sun4i: vi layer: Write attributes in one go
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
> It turns out that none of the VI channel registers were meant to be
> read. Mostly it works fine but sometimes it returns incorrect values.
>
> Rework VI layer code to write all registers in one go to avoid reads.
>
> This rework will also allow proper code separation.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

