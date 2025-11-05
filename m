Return-Path: <linux-kernel+bounces-886158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5809C34DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40B0C4FB347
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F152FD7A4;
	Wed,  5 Nov 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7rkv/Rg"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC32FD1BB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334966; cv=none; b=KOF64pN4StiNa9iaOrauNABc5HvvRlTfwiLJEKbmeydFWC88gVp/QCb/ozlQ+nqHBtJXQDS5pyGbw3KpMW56wR02ebZsm6DxwDhmH6q0Dfo2P/urPo3FKsGioK0t49wXG7rRe7tWKx8KEgqQjcJiyHcHm01K4CfWURjK4bwpzV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334966; c=relaxed/simple;
	bh=0XgQsaPK8SkvjG5BCRqme8oV5Z9wnVFe1B2vfhJEqDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7B8uhYhKn1wSemulK/6xYVAkwLvcbl10yajTJIZEJsltwXv+wQyQrpC8NvCdpx3R1ZJfJDYa0o3M4o2/gQ/s1q5dWhMdoRtGz+x4EvwSnmW+DJblEL9QJ7+/E1B/aOjeajdQjiv1WSu3m3kNe1hplttrQTsByUb/xxNXIrqcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7rkv/Rg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so488053a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762334963; x=1762939763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txxoHQsD9SBr+0uAjaOafgKfJPgFXKi5Q4JCWLCgjxk=;
        b=m7rkv/Rg4DJ8+H5Lq0alWzH7EgyJogKwn7XwBm8Q4KJIdS2fntBw30W9FWzRLSdMoV
         f9SLhchR3SD41H/R2HaAL4IVQ1UwhEYi2af2Uu2Q8IFVW9uViUIBJhmxTDU36vZUHRp3
         YlqR+rlW8e4uuQkGY/QIRrnZGTFlArsBBm2sh30nbuqOiJf3peuD4zj9A7qlvSKp5V0F
         tkqF4x4p+IY2EvsIy010NLyk/pdSDO7Sw/aX1egJEla4dJebO4cV/IYvhqUb1adfQOLk
         +p9L0OyieXOg3pYnWVirKsQ6Fs7gE5gGBZh/X1cjFJ0AOjuVWbux6JutGulYfyWQeDUT
         6CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334963; x=1762939763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txxoHQsD9SBr+0uAjaOafgKfJPgFXKi5Q4JCWLCgjxk=;
        b=LFmjah+igUGHugmb9bPcGW7FwW8gSDKMm17KvBUxkVir/4cn626hCPptU/tc+Jp7fR
         KdjI9ZCkCY4mhhnsyEOi0NLWaWAFOtR1hJDYPHphAGOACngm1whXdmGM9AuDAMvRowkj
         ryL0UVCBhMHuTIY6vR5w4ptlUsIGME1onxAz4PzZKdBEyiH+BXbdAAzb0zZ2VIk/iWvB
         acAtw6guRhVgbX5npJCN0Bfz9L7MjUoPMRmo/TMJw6WrRLHXza2qgMRLHe25t4mkWIeT
         iCY1IiWeNbUu6KIsW3AnezLmpj2B8dkAyLMD6dy2UdlE6v4P8VRTUwtmq4RkKawxyM9r
         PPMg==
X-Forwarded-Encrypted: i=1; AJvYcCWBntPw5/yKSOqvptT+pWV1+z04emyGlxoJ+OuxrGlyEHmHNLG/XBs+zvFkCZ0pS9O2bCr+uBmUTxOIVlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03gwRCcJ+9GYHAsBPM9dINg26AZ6q2M8i07vfKr1GewJrgaVh
	S4I7SFQeL+KK1eqHnqEZqbfJVCfbur51Hq9gX1TXuT60mqLjdefEwF+sh3D31ixKJuAZKT3jqoh
	WN7kUkcH8+/Q0Ij9n8EMe3rFUnU1CA8Y=
X-Gm-Gg: ASbGncsBbHDiPgIpHSSa2Q605G1cjL+qhmllta+iBvkXMoNpj6ucslwG5KMBFSNobOI
	l/Je3GOXNUJvoDmGd+tijbNKDSlO1eq3Ry+Y5V3Jwnpjj4NlmJMEqIdieKDNAIfeOtIwgBc5RkE
	ph7wjpw8NN2ZnxARHBUO/LZOecIkxYoBt2a1ZHLqBRblRMjArAvihre795m0cze06ONW6+Ogbdw
	eK5rzSjJXH4dGNzsUOgFWVOmmhFTDGLJ8/JVzczBPCrmCdfChoLiPHYjg==
X-Google-Smtp-Source: AGHT+IGkCxRvJh3fC5yidm37chqdIHgljJdYABqu7mHMgdmlemqRQI0lkZmwfrypszqAHRlZ8j+gATWb4FCpIOGaggI=
X-Received: by 2002:a05:6a21:999f:b0:334:7e78:7030 with SMTP id
 adf61e73a8af0-34e278f99b1mr8298964637.8.1762334962544; Wed, 05 Nov 2025
 01:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-imx-dsp-2025-10-31-v1-0-282f66f55804@nxp.com>
In-Reply-To: <20251031-imx-dsp-2025-10-31-v1-0-282f66f55804@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 5 Nov 2025 11:31:49 +0200
X-Gm-Features: AWmQ_bkrt0ospuWqleJ6w_sx1LCaBE7SCRpsPmV7R0cWe73tR0hYLHwUvfH1Zeg
Message-ID: <CAEnQRZAOTFw=sBppHTYQAdfDBuNqkqk6gVO4FyP0EBsva3Oi+Q@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 11:20=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
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

Thanks Peng patchseries looks good to me.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

