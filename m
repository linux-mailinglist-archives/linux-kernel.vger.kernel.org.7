Return-Path: <linux-kernel+bounces-889913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC0C3ED1C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EB6188AB80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3109171C9;
	Fri,  7 Nov 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwQEsdr8"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C830DEB0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501903; cv=none; b=UaNKSPXkR7M8D1UUlh46m5jeIayWkRU/50JNH+VznQpdDMLrWZqNk7A1VMEyqxaf/G+BJ7eq8hCs6y1+ZQ0btpxGXFqcySdpHXE8K/rgHo2n5Wu9vIfLB7CYBc26e6l+O9NW5cb1ZBw7UPbfXbDWn4gN9bL2wR37uAbfMxf4DQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501903; c=relaxed/simple;
	bh=m3vCS5fEBZTrIlk0oaQTEp9kJKU7A5DiAAXFXV5fdVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I79shamunp6oxNopveGw+rOWqqvDOAuL+ZTbKyfKQG351I0QrCEzIGiM7FXgCzMa1g7cNQRhj8Agh6aZ2/FMTc3RhJfn0J/ndNMq8hTrvaueN+Papm0YbTU9ASZAAndX6dUCpyt0a2U/R9X1dVvxAPcwbZSLymQUTV1SxJ7TBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwQEsdr8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so284687a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762501900; x=1763106700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3vCS5fEBZTrIlk0oaQTEp9kJKU7A5DiAAXFXV5fdVI=;
        b=fwQEsdr8HkxhXUpnLpI0r+sEsbQdiOjdeLGAwGNOSrSzRIW9mxnZZeXCAgTv/gKFWt
         VKkRoY6+W53nh1HEaYWLAdKjR149whtnK5iwydZKkTi8BHj0z/48fDU/RvL3quSaR90T
         gnv6W0dMcZJ1BlvZ2SWmvO6aslwIwKdgdLt6ycsynI5VdFDilMQWCoXvEUQmOIKtB5WB
         cwv0wKPDuTX1sf51b9AaExExco6dk3rFBFYsFyYfpAjFqoWFt8fb8d+BJCtYouhH8AMH
         QEXJSuAeM6CkJOAloy/Be7bWX6l7SxMtZG06uQS7P2zjIkbeE5cdUv5tOx+MIBgzKc66
         HRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501900; x=1763106700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3vCS5fEBZTrIlk0oaQTEp9kJKU7A5DiAAXFXV5fdVI=;
        b=xE7NxkfFWCikC+/OBDX9iYVAe2DCXHaE5XdAuadEs3QIewYPWWTR+cyiIYbniKxdJE
         MUkSB/XW61dkSTUpfOzh51Z5to1g/cl4at66eStT1H26Aw69+ifCkY1YcAyiQIO0Nufq
         4WBqlEdQ21RrjlLwr/GgUY2yS9fM1CZq4u77SSjg0PuW9bCE30RSyzUSjhJ6DPgvoOIk
         uL/t//BUmXYa7RHsB1hR8pS/lqlBHdAnfMT4CIwvDUQqPDYs0+aA591SFDMykdf5FxB/
         aVcd4qjoTJqPNcEVaDm/O0SrM4a3ZDBuBjFAV0Pcce02AH4/EZ7G7U9l5ppzm02GKxmx
         a9+g==
X-Forwarded-Encrypted: i=1; AJvYcCX9w3A8H8/cgV8Yny6WtnXCEDdyAK5hd01Hxwc1QLIUn/dJJe/KdZ7Fm4alQwIKsS5xQSV8Ofv+0LR6PWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg6I0bSJlYkRKQeFGSwZt1WmU2d6Kb0YU+pNZFmb1YxWzZ4Lj
	LNDj486RDze7NPUT/AQasoqcrVTAQHd0FQsUGVLVs6vNZhx6qLqzobS7z1hNTHt6jTIIKrpsHKc
	+/6ithiM4xhlYhPf1bEUmBuQQrr1uyOQ=
X-Gm-Gg: ASbGnct1eoSvpaKsaWuQr8YbqUvJhyZEmlquBL0fSrnZtk7s4lkUzosljVqhaZJGWXW
	kOBAsq30FJ50AvC6wZ5lYyEPaktTEkD8iAnGXTWIIeGHUJp4QzRw0WkWX+edMI6rNl39xKkW3rz
	Vcx7PFLOU3fTh0fDaSLuytQaYGATRACuZ4v4e9/I0lw2x8y6zhXibNEoIwpARQRFrt/7gU5MjQV
	3JyX9fEzuLLve6fR0dbKw4gCLHaUQ6Ng+X9dnZLwsKxjPTkMLtOZAMfAA==
X-Google-Smtp-Source: AGHT+IFkh8XME/XKdmm+TIe47BXYcMMyHnwgbqIA5X6bAhqAdmw5d+3JqyQ85nbSaeZPIXV7fRyM4oESPwNxWKjSk8M=
X-Received: by 2002:a17:902:e847:b0:292:9ac7:2608 with SMTP id
 d9443c01a7336-297c94b32a9mr11604375ad.8.1762501899726; Thu, 06 Nov 2025
 23:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-imx95-rproc-2025-10-31-v2-0-758b2e547a55@nxp.com> <20251031-imx95-rproc-2025-10-31-v2-2-758b2e547a55@nxp.com>
In-Reply-To: <20251031-imx95-rproc-2025-10-31-v2-2-758b2e547a55@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 7 Nov 2025 09:54:06 +0200
X-Gm-Features: AWmQ_bnGeOFtoZrRWw9KhEpAzRXkaZJvKZO7s-geVquRIrpRxLbcQTb4ng5zby8
Message-ID: <CAEnQRZBJCZOO9yLr-T_DT_QYerKgRP9gdasmUK+WN+d8VJPV6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] remoteproc: imx_rproc: Add runtime ops copy to
 support dynamic behavior
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:27=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Structure imx_rproc_dcfg contains a const pointer to imx_rproc_plat_ops,
> which defines the start/stop/detect_mode operations for a remote processo=
r.
> To preserve the const correctness of the static configuration while
> allowing runtime modification of ops behavior, introduce a new
> imx_rproc_plat_ops member in struct imx_rproc named `ops`.
>
> During initialization, dcfg->ops is assigned to priv->ops.
> Enable the driver to safely override ops at runtime without affecting the
> original const configuration.
>
> Improve flexibility for platforms that require dynamic operation switchin=
g
> (e.g. i.MX95 Logical Machine ops and CPU ops).
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

