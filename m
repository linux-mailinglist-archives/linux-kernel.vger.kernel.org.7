Return-Path: <linux-kernel+bounces-802369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75900B45197
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4098B5A6923
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1628303CAB;
	Fri,  5 Sep 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aP3mZzXq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631E267B90
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061106; cv=none; b=VLIMWws1TPQYSFWXD30D/U0PRYzahLRQ/qi430tuAkVu3/HnqQfG1xP8tGsNH2+fsaAGv5SmWwBgjs8CiV73Keg7v3j+aGO04xeFsE6Q113rAYM0OyKDBd6XZe3awC8RScdNP5FLspLSuEL5K+VXdgyUvlECYxd5dLFujBL8BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061106; c=relaxed/simple;
	bh=Cqt9y5Sd8p1bw7JwUAV6Zf77Tsf7orn/JfVBQl95338=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjNWmop1LxjMaNHtUuG3YDRVR0YTp/UrDK77Wf8n2QKrNk0zKf/gcyVMuVNPwU/2BynvyMeeyzBFqkmREvB0r+Hub9+ZEHlmj9WF/PQZabisHNVt5ya9AAiqEA7EU8mUn2sDJ5VrR9ZTjYn6L+DNDH8sfHVPpSFKMbOSH7QbH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aP3mZzXq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336ce4a8bfcso15935031fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757061102; x=1757665902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f+++oJEJogx7iunr2Qwd9nxHYBvpJqjgZ7eo+XnEyw=;
        b=aP3mZzXqbuXN6P0CrCqMWEhnbpuDcTCN748SKuhKIDSYlqbHc9DIi7/afmqqShYQUb
         vMmZe2/GXwv5yz1Nu+KnmbSwFub3vo+DuxxBOdaHkvM9eQR3kfH3A3WnWRC86IG7hP2t
         lw5y5QX/Eh7NEKFk/QHVaEv2gZu3LmEDDg9LHE3CDSMpQzjiB9c/Z0g8lkCTYeFTWedX
         4lz1rEAlZ8aWo3oUe9lhqkFZ2KISzWCL/1xzLDiXiTAO1XtDmSUWDZnKx252u4UbFUrp
         t8T1UuaydpPZw2YNInHEbPZFS482MfzN0EfjBdMo+gqe6uNg6R9EVRDOTsufCn3dELIv
         /JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061102; x=1757665902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f+++oJEJogx7iunr2Qwd9nxHYBvpJqjgZ7eo+XnEyw=;
        b=AmmXr68UYxaX3sQqqmp0pGBN9zJmRpgk3NTYhEstXsXok98Amb84cB9vcBotH4Ww9h
         tc8HbVDnlflia1oc/4mdLfUh/6Y+qInVXzuGHnkaE0bQgI6Lf3OQTkGtqHam5emuXj+h
         Jot6r2m3pZK7HnptOrG+8A57+BkwlUJXCewr1o+QJj6S7zHyvhNTmppoYEHYiCG1+NzI
         6NVD1CPIAhxvnXDkLVmZTUvTllSsJ59HWqO7QssVAlyry6gk3jph/lIwAOjngDQfzWLD
         vJRo8nWFBqiCI0IG0wP+oeFo+fxe+n8177swwnKChpnfqEZwpPUoP3PwR2MMAVoVceZz
         T+og==
X-Forwarded-Encrypted: i=1; AJvYcCWWRUZzsCsYkWQgu6HPnxO5Dwz6fWxQxp1HOLffHJ+MdmvYEsU1u1PDKABdxMUlhad8kSH/P9vPQREP2+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+uu09Mhlo7ndN3YA7r5MywVCnqDJcx+edk+aSPCUB6yLEX/O
	ZFQAW5ccz3imc9zKJRn5pwus1d1sKvugI+wvv636Tm4nd/c2sfR2x8sS1HId2hX4qJeOx1PwIxr
	TkbcU5olne2zMOT7lMspHzI+NBVRZgtBm4n/aJyNwKQ==
X-Gm-Gg: ASbGncvp/L53BHcw6QwK0v+Z+KvFRZ+uL+BdbrWe11EMYgMKQ5/yFp3MRq1zCXtZHSD
	XlzZdSQ09cpi9jBDLKJhgpP7OLxNZ2JSl2M3QdNspvDRSWorQYRGP/s3AFiSTRCcqzWX9DIz99v
	F9b8+RugRcQ+joSPAkjlR8QB3Yn0CNidAZ4NH4SSAmGNk2GukFH4vTx46y5dD7tkYxwKfPXv2F5
	FOc7Azv5ZC/xxl5JA==
X-Google-Smtp-Source: AGHT+IHp+LpzTnlm/ik4qcZ3pH7JoklV/VwhpQ2B9YB70/pzgPXeMXc+xQDV0rAGZGWmglV837F6DBjwLozLyJEQpSM=
X-Received: by 2002:a05:651c:503:b0:338:3d1:60a7 with SMTP id
 38308e7fff4ca-33803d165d1mr29380981fa.38.1757061101675; Fri, 05 Sep 2025
 01:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753039612.git.dan.carpenter@linaro.org>
 <6f732f53-7e00-4f0d-82a3-480bc81497bd@sabinyo.mountain> <CACRpkdZ9EHoHiKit+T-ur0xDKMEoN_=TydzTfoggNBQGdra2bQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ9EHoHiKit+T-ur0xDKMEoN_=TydzTfoggNBQGdra2bQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 10:31:30 +0200
X-Gm-Features: Ac12FXxg4bL_8E-D_W-eOel8gQZzsIXFhPs68sNRK9cduffuB3-nHYnzZaiCCko
Message-ID: <CACRpkdY3_ifPsQOTqa2e-kHR24Khy0axrZ=K+vO4OJB+FjdB2A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/7] pinctrl-scmi: add PIN_CONFIG_INPUT_VALUE
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	Michal Simek <michal.simek@amd.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:27=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Sun, Jul 20, 2025 at 9:39=E2=80=AFPM Dan Carpenter <dan.carpenter@lina=
ro.org> wrote:
>
> > In SCMI the value of the pin is just another configuration option.  Add
> > this as an option in the pin_config_param enum and creating a mapping t=
o
> > SCMI_PIN_INPUT_VALUE in pinctrl_scmi_map_pinconf_type()
> >
> > Since this is an RFC patch, I'm going to comment that I think the SCMI
> > pinctrl driver misuses the PIN_CONFIG_OUTPUT enum.  It should be for
> > enabling and disabling output on pins which can serve as both input and
> > output.  Enabling it is supposed to write a 1 and disabling it is
> > supposed to write a 0 but we use that side effect to write 1s and 0s.  =
I
> > did't change this because it would break userspace but I'd like to add =
a
> > PIN_CONFIG_OUTPUT_VALUE enum as well and use that in the GPIO driver.
> > But in this patchset I just use PIN_CONFIG_OUTPUT.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> I tweaked this patch around a bit and applied: removed the second comment
> in the commit message and wrote the docs to be more generic since
> in the future other things than SCMI might want to use this
> config option.

Then I thought about it some more. ...

Isn't it more intuitive that we rewrite the curren PIN_CONFIG_OUTPUT_VALUE
to just PIN_CONFIG_VALUE that can be used for both reading and
writing binary low/high instead of having two different things like this?

I will look over current users and maybe propose a patch.

Yours,
Linus Walleij

