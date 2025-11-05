Return-Path: <linux-kernel+bounces-886143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A9C34CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAD34D221
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65192FF65A;
	Wed,  5 Nov 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFloza97"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815862FC00E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334498; cv=none; b=DwCaVM25zX8d5c4hdZN65wCOvvhXee5eYhPa4S4Zr5HrxABwk3PC5iAa9JVy+DB1wGJJSbRCFy2E99XxJB5ch22OeL9iUnWzNhSnSUx1Q/UqOsNrcIbZgE5w/4PzQlJ3eFNjxVKFrwXuvsy+Bxx8cL3ciwVqVj4okFFodsuaPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334498; c=relaxed/simple;
	bh=r6IAr6ThWrXT0VQC+S0LBlsjUYHMVkUu3AebSU18ydI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffZnIjt08uHegXuxWTW3rRTUHWWly5HhbO0eP8MWqXmvv3NNW5yYXoeipMt3aBGmXkzLRqUvIzHzy5RhBACQkHLa8YeNnHCOVkYLEt6Bz5Z0juOKr6gMtnmsAJGuY3WT1vIZ1s7Ga8vp9fKU07etjEJ1YXgQY+G+yMNE6Ksgqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFloza97; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-794e300e20dso531858b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762334497; x=1762939297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6IAr6ThWrXT0VQC+S0LBlsjUYHMVkUu3AebSU18ydI=;
        b=hFloza97B5w7DsfQRSi4Mjmbe20uloSJ7wYu1EimKgZ6DZ3Na5V6ADVnzVomaUu6u6
         mD1l3vSGK80x7M8o1hqNS7Kz5vx1s4PwdNPc2T3YQwEii5ZmhXRXNXhsur+Ud+lIKhV5
         xwkFUK1aJPCYAGf+2+ty92lkFxC3UMTu4TKnlDTroYeZk9PB6s35t4XWsJJCe1A563RD
         GLfOuHwGXxRxbkh25qjzZdueFH0lvzkdhdcIEtOoHBwsKyLVVFvtFK47Q7sDGuEb//4i
         dNGfA5t5cq+V1oHpm3m49A8ja5DRWu/jz3nne+JTCF/cRM9zb9u61eeghGllBBq9ng7k
         CZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334497; x=1762939297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6IAr6ThWrXT0VQC+S0LBlsjUYHMVkUu3AebSU18ydI=;
        b=T/KFarmkjMe+3U447Q43vpa3KOT4rtf4zLIQO7Yohgwbpypo9f18Y7zWkeFpMIyybI
         tGUFpPnp6bCwLox4kPDqFii0bT04ymWI9ZytdcnMwLspYDcRru0jYWxjcD3gx9Cz96Dh
         /NN2cgETSFN49LDZhrFiKfN3AQtpAIhFt5e9Ds9qKt1ipVyGI1UN5qm436VKd8mW3/TM
         /hPHJD3mohhsxKL73NB5zOVil8XQtsFBElhE/nTZBG4aZkjBXWIY0st+TlVjinjU/gqO
         kdfxGJp+RxqSWzW+1aAX+/qweshoPkHE7jnVh1rwi+2uE3UCZn9QS2Dl94kXtui0pNvj
         oAIA==
X-Forwarded-Encrypted: i=1; AJvYcCWP8lykJrw/p3JggNbGuBfY5stTT/oiNEIV5NM/kqttezEsLgaRwJecfvQZFheXMK02djE0tr8vsK+/0Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYr80bfBR94o4JM7mroCjPY68V//8j9xE7kbSZCMuiYa3R9Kk
	dcJNb41ikjgUoSopqTYWrIx3xY3iCn+HJqN6MwNVH3Ja6YLQS0728I113Z4BD0/FVwwS/6hBiBP
	g7cy9vdNFK7j5hliP8Sxcf2Tt94/Dt2s=
X-Gm-Gg: ASbGncvOa9PaDVguEBHY3QzmmZ7sMV8xX+PWdPArQIozENmYylVUxdRldB7MqhjmZO8
	BpY8HhPooXmP4wqxRrxN75w3KQHen23rV9z0kls9a42lIPbb2FaSoHEEif5Zz+WQDJcL65mzG4a
	uKbJksZ1XKIDhma2fBt1cjBQmY1tXWMaGv7iPHvbYZvBDziByAyz+R4kVNOxeMD4BZ278ZDPI+0
	c2xaaOJsVkoKH1A6y47NYb6tYwk8VEEW3lDmfqg4VqhD0BO9UJFEc4WrA==
X-Google-Smtp-Source: AGHT+IEhLgnnarruJw6eIIB+8bTnN8uYAF3Chn6W7iyK13efG69zCQaoyAaLYmuTmnpZholD6kqVshKjrwpDBWN3vSI=
X-Received: by 2002:a05:6a20:d049:b0:345:4b5a:16b7 with SMTP id
 adf61e73a8af0-34e278f999bmr7748938637.11.1762334496625; Wed, 05 Nov 2025
 01:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-imx-dsp-2025-10-31-v1-0-282f66f55804@nxp.com>
 <20251031-imx-dsp-2025-10-31-v1-3-282f66f55804@nxp.com> <aQUEzx6sobI4Yes5@lizhi-Precision-Tower-5810>
In-Reply-To: <aQUEzx6sobI4Yes5@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 5 Nov 2025 11:24:04 +0200
X-Gm-Features: AWmQ_blaxwVbzKBmJKN_0Fj3HFefT03QXEkDQ4Lh8h-h3RbucXTuRrqR5o2qb58
Message-ID: <CAEnQRZBNzo6RKjNf4JxxxjxtLCFfEGMMt2fSK4MdVeSjtF5aag@mail.gmail.com>
Subject: Re: [PATCH 03/11] remoteproc: imx_dsp_rproc: Use devm_pm_runtime_enable()
 helper
To: Frank Li <Frank.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:50=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Oct 31, 2025 at 05:08:32PM +0800, Peng Fan wrote:
> > Replace manual pm_runtime_enable() with devm_pm_runtime_enable() to
> > leverage device-managed cleanup and simplify resource handling.
> >
> > pm_runtime_disable_action() not only calls pm_runtime_disable(), but
> > also calls pm_runtime_dont_use_autosuspend(). The current driver
> > only calls pm_runtime_disable(). But this should be fine here to use
> > devm_pm_runtime_enable().
>
> looks like this paragaph is reduntant.

This is not redundant! But it can be phrased better.

```
Current code on the cleanup path just disables runtime PM for a device.

Using resource managed version devm_pm_runtime_enable registers a
cleanup callback that
sets autosuspend to false and then disables runtime PM for a device.
So, basically the same
functionality as we don't use autosuspend anyway.
```

thanks,
Daniel.

