Return-Path: <linux-kernel+bounces-881355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B21C28108
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E14EC970
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEB2F39D0;
	Sat,  1 Nov 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Yny+Rq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513C60B8A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007266; cv=none; b=M+O34mXnVnyyJchjhPcrqs4Phw4lB0kSNCh+5z3D3Q+Ge67cpkrWEcTSa3nt4P9vjW1ouW1XX3/JE66kyL6PdWZ7LCyOyJqGML40EZ17wIi9wOr7eOECAfAAAsqVi7AlBRaMgcRVd3mZ8xXG4E/Xgx5E2z3N+tF+F0jniU3aNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007266; c=relaxed/simple;
	bh=lV3WbcP4L63VVdKmRFHTW2IFkZA0MqVRd2TKiW7+rwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRgd84b3jya6JqMci0s2WZKPuu15nQWptnfTR5vyKEKhMqOyQHOal7OcqGFR8KgM7HI0+8MrfcNiy7Lr4a0qoU+e3Jik3xA8ZRgL4iW/22ZKLWdzVVpZJ6xTu2HSzFigblrcPgOFEwI75HWHNdBxAMaP2L1flOj5eEAZudbxb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Yny+Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFDCC113D0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762007265;
	bh=lV3WbcP4L63VVdKmRFHTW2IFkZA0MqVRd2TKiW7+rwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L5Yny+RqR6ejBT6dWjFU5SPnufclvSK/b4ZmkHgMH6VFD/mWp5pBe6NBwWJvKh9WQ
	 dsgceBxVUt+AO2fGJ7F7f4vOLZIkAgGFHdATQcvg9q0kcr9iabq4uwwJWy9kUzAwa/
	 DoFWq7t+6T2yv6Ptrc+1xMFw9+2PuFR79bBKtT5OVGW5QUlQ4CXg6r4756IW3Qb5v7
	 7J0q4ufSMc/E670BHmPOvjV+CV0F5R1Wsu0m4YJP2ZnJbv3BDCkn6uHoqDdpjcqTGE
	 GNEOyFEnh+Zc8PEnjyMQkOUWtgLc+S/vNujsiam8gFVG3pcxFUM8cBPBRvB7oe3FfY
	 5Cs7n7Dvgpnyw==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2342208a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:27:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuMcP6T4WhM/B1SHJM0ya9thVc1iWIoW4aLYm8kdacjKiHrTar65/QCY0AnOjQL2iHPs1t9CWjOzGe5SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMGdfA7aNIXOu7wdnXRePkoEpToCcQVaMGIVprfSiF8BK1pYD
	IWZDxdiRAdKNpwvsoZEcv+HIHxh8F/74pOYtsxEchQ55EUznY5BXPdCXkMuVBpBIxHKm5JC3ElR
	6S4gVyeCRc5pir3FGv41K9xdahGXCfA==
X-Google-Smtp-Source: AGHT+IGnOFjLL6wAsT9pv5cIhcF/90Mw/1kp/7g3CvXtV1RTTu/pF5hz4dyECsPv9IpJsPMLjLxpTdmcXg7a1NiMbbo=
X-Received: by 2002:a17:903:24f:b0:295:24ab:fb06 with SMTP id
 d9443c01a7336-29524abfc57mr60471485ad.22.1762007265054; Sat, 01 Nov 2025
 07:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sat, 1 Nov 2025 14:27:32 +0000
X-Gmail-Original-Message-ID: <CAAOTY__Ac8S3gnbx6RbVZrNzMcqSkE70xuq5ErbzAWPUh9moAA@mail.gmail.com>
X-Gm-Features: AWmQ_bn-FuEPLjCksrS_ODh-bQvHMz1N_UARyqPo_gbgBDuh1txOjH8bx8rhYo0
Message-ID: <CAAOTY__Ac8S3gnbx6RbVZrNzMcqSkE70xuq5ErbzAWPUh9moAA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM driver
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, greenjustin@chromium.org, 
	sjoerd@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ariel D'Alessandro <ariel.dalessandro@collabora.com> =E6=96=BC 2025=E5=B9=
=B410=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:28=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Commit c410fa9b07c32 ("drm/mediatek: Add AFBC support to Mediatek DRM
> driver") added AFBC support to Mediatek DRM and enabled the
> 32x8/split/sparse modifier.
>
> However, this is currently broken on Mediatek MT8188 (Genio 700 EVK
> platform); tested using upstream Kernel and Mesa (v25.2.1), AFBC is used =
by
> default since Mesa v25.0.
>
> Kernel trace reports vblank timeouts constantly, and the render is garble=
d:
>
> ```
> [CRTC:62:crtc-0] vblank wait timed out
> WARNING: CPU: 7 PID: 70 at drivers/gpu/drm/drm_atomic_helper.c:1835 drm_a=
tomic_helper_wait_for_vblanks.part.0+0x24c/0x27c
> [...]
> Hardware name: MediaTek Genio-700 EVK (DT)
> Workqueue: events_unbound commit_work
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drm_atomic_helper_wait_for_vblanks.part.0+0x24c/0x27c
> lr : drm_atomic_helper_wait_for_vblanks.part.0+0x24c/0x27c
> sp : ffff80008337bca0
> x29: ffff80008337bcd0 x28: 0000000000000061 x27: 0000000000000000
> x26: 0000000000000001 x25: 0000000000000000 x24: ffff0000c9dcc000
> x23: 0000000000000001 x22: 0000000000000000 x21: ffff0000c66f2f80
> x20: ffff0000c0d7d880 x19: 0000000000000000 x18: 000000000000000a
> x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
> x14: 0000000000000000 x13: 74756f2064656d69 x12: 742074696177206b
> x11: 0000000000000058 x10: 0000000000000018 x9 : ffff800082396a70
> x8 : 0000000000057fa8 x7 : 0000000000000cce x6 : ffff8000823eea70
> x5 : ffff0001fef5f408 x4 : ffff80017ccee000 x3 : ffff0000c12cb480
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c12cb480
> Call trace:
>  drm_atomic_helper_wait_for_vblanks.part.0+0x24c/0x27c (P)
>  drm_atomic_helper_commit_tail_rpm+0x64/0x80
>  commit_tail+0xa4/0x1a4
>  commit_work+0x14/0x20
>  process_one_work+0x150/0x290
>  worker_thread+0x2d0/0x3ec
>  kthread+0x12c/0x210
>  ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> ```
>
> Until this gets fixed upstream, disable AFBC support on this platform, as
> it's currently broken with upstream Mesa.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---

