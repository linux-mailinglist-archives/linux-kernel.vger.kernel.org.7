Return-Path: <linux-kernel+bounces-897722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BDC538AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E977954303A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260433B6C7;
	Wed, 12 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVU8gTQ1"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FB253F11
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964240; cv=none; b=VYs3t3tEnx9QZyxnLhZf2XWHl/NvMIyUp1/P41ORgJ8edZx4rE2QRJ0h8XOI/5r/hPsx2Ja524xEE/VIvHdCavNTxSe/tC6RUIu0dDRBUIQfY9htYwx99B2IDobhpqNRKbmKOK66iMxGnndXvASSbw3N2xVxZzqN0GizrKTvFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964240; c=relaxed/simple;
	bh=thLeYsmvUb/JgavOrdcC/1uELN8ZrLnaCGB0hQzFcLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD01yYdupn9RFDdOh+cinfXyooc3FPTiXcTwNTr1si6mZ1PMSs6z66AoGso1fs5YTi2A2yQRfRyI8OMSlwVWkoBi6tIJUZTnrQXxZ57BT4y/KLhHWnSwdkMn63OUL41v87mkuocvyOC0ew+pW4FyCprJbVrALt1CoQ/3ayNYcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pVU8gTQ1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e4228e0fb7so578511fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762964237; x=1763569037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8VMCABcDQg3bj1MpLgUPb6hZG0b0uHbN8RDXsa01+ho=;
        b=pVU8gTQ1772fztDyH2UbsxuA1//phf7Xrj4lEoSuGPQnmB7fPDCawyCA9yRiDVhEx3
         E5OQwn7B1QvvT6KtdM6cUU62OP0jSWuJd/aE2o4Hdq0ic0XojUXfcQW2wqlhPU1uV//C
         sed6Ugoqio6+pBZI+5Mp0pQ8AKalhVV4ymAXD+xVhgQ8klL3pYQiWcKggYvOrctfK1Gg
         sVGdtA89ITajjH/FR9Kp8SmCUTWVVk5MzE3azza3+ziCQiBCZM58JhacOY1mMREg1OCO
         Y+Uv9iscC/0oRlPj9cVs+NmQ/TvTgJukiqTlVU8u/b3Q1+4GaMmzqKieMUNIiLzDl1nP
         xs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964237; x=1763569037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VMCABcDQg3bj1MpLgUPb6hZG0b0uHbN8RDXsa01+ho=;
        b=m+uyUlMeEdDFgsetl5Z746KPUZbuJnyPN8+21EsmotJe1E+yEPIDLvE2ZsQpvwWFNI
         CTHloVkTI1BNcLAT6FUMK1YLsVem84GPNRzeRVMbSXLTNWy4zusaRgwTn2AGYX+bL1aw
         0MAQwRdqO37aF+Gc6WZ9lkwhDsp4nGXn0reL8IIlMC8VXuWvzxiIGwpN1qB00hOQqMb2
         bKXdYikKDBqBJQKfv7q8t/+A21ihCExkG+jPnmfi1uClOkAYJEEoFxjXKJemdWdYvCwK
         NDl6azz051M0la8g24iWq0dOxcFHUparc2fw+eqmn1U9Z9kCXDqlJVTVlwNyw63noNKD
         CKNw==
X-Forwarded-Encrypted: i=1; AJvYcCUjXxvtucx5UU4D6f7f+tncFz3nffv4i2QU846/23FlKUKauBYY0GvJDT7ydK9BPNuuBToD9koZJoitJ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/TL+fVoyZTbSJ6flmWcTpinQoWL+sjytiP04cN2cKd4YkryG
	NFRGpFOf9KPYp3ZV+NNAdjVJ+/xCW929hZbGspKTIt0WDDL+nOTfw3i3rIxywkeMC3WNBPm127I
	YANR7JbSrUF1XNhMrZ4wNp2lQIp0VroT6NYwp3dyOnA==
X-Gm-Gg: ASbGncsGAIDs78N9WVp2HC8dPSsD+LOrdR9VAMJOXtyxoR/pBS2uMVK0JS4fev0rTiq
	ZGgHzvTDzv+S60WbA8Xoz6aA29weU/9nVF/adNhA+ylQlSxRZFjJdTHoJbGEDuEUBIl0m56AujN
	2k5WPFs8C0AXazKsQKLKL8Zf2YPApe2ZQO7RmaWg6Lqn26Eds/H231IfgLl4w7PMMuaUDfdDDfS
	QPjtwA1GANJkEoPNTJzFgI1y1Y7m70RPIT8v7DM+hI4bm31w2+4bZrE+t4w3g==
X-Google-Smtp-Source: AGHT+IEsUM5mecSa8OvDA3eHi3Rt//Ce7dwGX8jwgmu78EO/L2nrGwzBPId/luKJz03aDcGKbnhMLH136z6/UVOOfm4=
X-Received: by 2002:a05:6870:5694:b0:367:6cdd:8c52 with SMTP id
 586e51a60fabf-3e833fe5841mr1730179fac.14.1762964237482; Wed, 12 Nov 2025
 08:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
 <20251112-phy-notify-pmstate-v4-1-717d78009d15@linaro.org> <aRSyTst8Vd-Qb2Ha@shell.armlinux.org.uk>
In-Reply-To: <aRSyTst8Vd-Qb2Ha@shell.armlinux.org.uk>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Nov 2025 16:17:06 +0000
X-Gm-Features: AWmQ_bmeUqnv9Axu23X8v5l7CIA0NkBrp9BKset-SthjnPv3fEKplJqCJGUzBUo
Message-ID: <CADrjBPqPUOQThv+KmeYyUhMA1S5HL_F8FwTa_srcZM43P4GzyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] phy: add new phy_notify_state() api
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, kernel-team@android.com, 
	William Mcvicker <willmcvicker@google.com>, Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Russell,

On Wed, 12 Nov 2025 at 16:14, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 12, 2025 at 04:05:58PM +0000, Peter Griffin wrote:
> > +int phy_notify_state(struct phy *phy, union phy_notify state)
> ...
> > @@ -255,6 +266,7 @@ int phy_reset(struct phy *phy);
> >  int phy_calibrate(struct phy *phy);
> >  int phy_notify_connect(struct phy *phy, int port);
> >  int phy_notify_disconnect(struct phy *phy, int port);
> > +int phy_notify_state(struct phy *phy, union phy_notify state);
> >  static inline int phy_get_bus_width(struct phy *phy)
> >  {
> >       return phy->attrs.bus_width;
> > @@ -412,6 +424,13 @@ static inline int phy_notify_disconnect(struct phy *phy, int index)
> >       return -ENOSYS;
> >  }
> >
> > +static inline int phy_notify_phystate(struct phy *phy, union phy_notify state)
>
> Should this be phy_notify_state() ?

Yes, that's a good point! Let me send a new version fixing that.

Peter

