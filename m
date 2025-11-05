Return-Path: <linux-kernel+bounces-885963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B94C3464A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB36618C5CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D92D8783;
	Wed,  5 Nov 2025 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQTA1yDQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0042877E8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329879; cv=none; b=ULnPeLuOMqyziHUvjf22y8nszZl18JhmDVoufaVdwBRLugzSVGXqTc+YM4SloPNGwUgcP3skuDj/L05AM9XKbhs9vx7IM/nlK6FGVkF/DeGu3nqnxRg/lqrUlWR1QA/tj+cD7d7R/sS2W28MPgNTt+awVlvydem4Ge7Ym+6h7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329879; c=relaxed/simple;
	bh=LsTjAm09M/yGM5svcRs8AIkfB2f/URAn2Y/ln47haPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzUQgr3aLvsKJfxBgB0SH83LDmhIr4Hqk7RH75B/oTWYmb7Z8adBJ+FkuSOLD1TY4XUbL6k52+nlDLKyHxqUVydhiNC0x43avd0E+zF3tiwL0vTKdjF4rwwEbKzj4vrIuOMF00xuUvNr77ZkM4gf4onLZnOTy5jzRfjjKi/NnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQTA1yDQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-341b2e98486so192245a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762329877; x=1762934677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDe6kRSygVEphf3RSRGt9HkF/eyEhvziT45X27VBXsM=;
        b=SQTA1yDQURc4KmPIgZSpUjvkM/w8kK/AL+NAd3a+3FyoHZ7MG4JHelmoMB3lzar3Rs
         slXHx9aLOYeu927i8hsKL8gLgT3Q9+53k/B4Z8zdDGYQNpvm3ueG89r+OeQFtH4AkCMb
         LLNnsTNAiK/34gqKGoVLBEQ+hj02mlqmgD4XK/RoR+QoqqQ1GQ9CvbYG3PJkphKuw6R0
         2piOgVOjg8gXcWaHpxemgl0jHh/29DVweisrn5FbTIjxeLymJK0/UwPpKgYNQpKNolqe
         O94iL/zVwkTjaFzEfjMv5frjtn2ubkh89p+QFaRG5ZiO1shJqt+TfQRP/lbC+NE3hXQc
         gaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762329877; x=1762934677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDe6kRSygVEphf3RSRGt9HkF/eyEhvziT45X27VBXsM=;
        b=Or0qsH+WvptSjeHf2Jv8BGdeaHEAK28f2LlESqgQhvrnFkE6kw7f8/qI102ZvbgZZM
         x95QGZ1MHVBUXdW5vOUoD2kYw0cHJYu1aMUeBCnh+YNXRavukeDK9JvvU7dqNYCsb52w
         EgwlirZBQFX5qZlYiMQcLohMUTTT4KZnseiM0y17jdXmV1KyuGFPN87efDqBgaeldQ26
         pTUFlsHMLgyhDbY8zBD8VbOhaawQX6OpaDTMKoTqt8NUrIp1S55PMVScHm7wJv/w6cUu
         cnDEWgylDn0912MxZUHn2KJ3valn3Aa2WfYIvypiGmsRPS4X/3Rhy/P4wyb7dE7oCb37
         vHOw==
X-Forwarded-Encrypted: i=1; AJvYcCVpLF/rqlAKS16f1rSMzvRXMaK69yqgrY9kLshsOt0W4ZWzCzVQeyxkAFfjfF+oxwezK0A3PG/gvml4Cbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwKdljWOissMtUAneI5xRQut1lk2NJd4+ZvJfOp1/ps9Q18gC
	mT2Z8yd9ghUUVuDA1DAj5Yiw1w3UuMUdFVTRXfK62kOhb9gfycovKqlq7ZqcUgwefSXGpdZrGAb
	2NAwNhWQP9T6W0D1kyzgiqexSbGJJ8EA=
X-Gm-Gg: ASbGncvgevY2+8rlqsmSSySK4nI1JoNFiQnsfKBMNocqH5w6K4ah4p25yu/oYFBBb8J
	Fupi0POutysPtJM78165zI9PqtKbi75UbeexkJiEykhDNBLKQVXsg0WvLIRrRqAigNRq6eO9EnD
	caypjqeNvdliV2zMf/uRfii5vFp6/CQuiMzPxRYODRMfojGxEQIaJpRpuAvNDYGLoCg3o8cc/vN
	/70iXJ4i3FBr9IczrygGZpqZF3vYX85w6ajmyaapsJMj8izBvldG7jglM+udo8kM1MmmgQ=
X-Google-Smtp-Source: AGHT+IE3kiYdO6A81tH3ocwujCNPCljvOzypJY9CyERGKSeoHzPi5nZ+xfnpKr+voNC9lIaFIPYuRWd+eHWQF6ZoNDQ=
X-Received: by 2002:a17:90b:582e:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-341a6c1e406mr2591161a91.6.1762329876771; Wed, 05 Nov 2025
 00:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-imx-dsp-2025-10-31-v1-0-282f66f55804@nxp.com>
In-Reply-To: <20251031-imx-dsp-2025-10-31-v1-0-282f66f55804@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 5 Nov 2025 16:04:23 +0800
X-Gm-Features: AWmQ_bka9Xr4B-LvpKHRbIbtt5BkAdNQKoTwEnWv8Ppu3FZE5Ou4N-m9M6c5JNE
Message-ID: <CAA+D8AMgXCcQuH3SWh2UU5ib0h3EqdJOdXTkwyFx4duv7qL2Ug@mail.gmail.com>
Subject: Re: [PATCH 00/11] remoteproc: imx_dsp_rproc: Refactor to use new ops
 and remove switch-case logic
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:14=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> This patchset aligns imx_dsp_rproc with the cleanup and modernization
> previously applied to imx_rproc.c. The goal is to simplify the driver by
> transitioning to the new ops-based method, eliminating the legacy
> switch-case logic for a cleaner and more maintainable design.
>
> Patches 1=E2=80=935: General cleanup, including code simplification and a=
doption
>              of the devres API.
> Patches 6=E2=80=9310: Transition to the new ops-based approach, removing =
the
>               switch-case structure.
> Patch 11: Remove the obsolete enum imx_rproc_method.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Best regards
Shengjiu wang
> ---
> Peng Fan (11):
>       remoteproc: imx_dsp_rproc: simplify power domain attach and error h=
andling
>       remoteproc: imx_dsp_rproc: Use devm_rproc_add() helper
>       remoteproc: imx_dsp_rproc: Use devm_pm_runtime_enable() helper
>       remoteproc: imx_dsp_rproc: Use dev_err_probe() for firmware and mod=
e errors
>       remoteproc: imx_dsp_rproc: Drop extra space
>       remoteproc: imx_dsp_rproc: Use start/stop/detect_mode ops from imx_=
rproc_dcfg
>       remoteproc: imx_dsp_rproc: Move imx_dsp_rproc_dcfg closer to imx_ds=
p_rproc_of_match
>       remoteproc: imx_dsp_rproc: Simplify IMX_RPROC_MMIO switch case
>       remoteproc: imx_dsp_rproc: Simplify IMX_RPROC_SCU_API switch case
>       remoteproc: imx_dsp_rproc: Simplify IMX_RPROC_RESET_CONTROLLER swit=
ch case
>       remoteproc: imx_rproc: Remove enum imx_rproc_method
>
>  drivers/remoteproc/imx_dsp_rproc.c | 344 ++++++++++++++++++++-----------=
------
>  drivers/remoteproc/imx_rproc.h     |  14 --
>  2 files changed, 184 insertions(+), 174 deletions(-)
> ---
> base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
> change-id: 20251031-imx-dsp-2025-10-31-260b2b979258
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
>

