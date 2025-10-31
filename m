Return-Path: <linux-kernel+bounces-879752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD6C23EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5603B4BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D831618F;
	Fri, 31 Oct 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otPh9ipj"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B933126C9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900770; cv=none; b=TqzC0IHTq386shdUR0IvxViWftRoiPCkqBKOXQbtMbA8Sm2Z+tOyw3OscqV/9wqMY+uvng3LNEQTrEDkkF/IT1n2Eejd1vIGeU52c7XqxkxMoFL2kA6o2dY/7TlK/NFK2XT/B+DyKU2AMwrbjSU1LRF0gyBE9zWgVK8dfa0ukR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900770; c=relaxed/simple;
	bh=SQA2+UjBZNeC3KmXm0e1JQ2dKcF/4XDLDW7+5Xqb54o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reP3+6rn7ztHuyCum5Zpj231ThLo9NVgBxFAWA1Pg31eEVXpuihP+lMnjHsL9S9znQBXF3zLxEJCeCze2HaHDEqwtyrEr4cFI9Wn8N+4eYZeRqfHgcRYm2AhQwVVEKsgg/OC8nt5Wj61ARMmPeUnPDMggHo9EOK9rxH0SZHyw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=otPh9ipj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c67d9577b3so1413565a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761900767; x=1762505567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVOOle+AJIIuteMGQoWj0kXyHB826iCzl9rVosT29bw=;
        b=otPh9ipjLVDvOw5vdWynJ/q5T7Spq2Ir3ASYwTESKFugL3hYe/vczRRP9AR0EqXE6i
         UZ2HkTuZIu7wCUhJl8Oh4DOIm0O8ic4wBg15sqFoqBmNbEaTC1FOm33UUw4yaPmbpje9
         P35TN5dJQSwifc+l49IfL+VWIt5GYp1+NNSpH1bKtduodPu4I4WiVZrURD5vgXyw/5jf
         ShLE2rbFGumGzGyC4AUmWAt7FurBeDOnrR2ZxwkE7QOg+bZ1l7WJNds1HPTLRTnCNGap
         mg+wsme8hbdeJHD/k8dHIqeM5D8sRdD4jK2mGbYAU1GeRDwbM+5+0+t06cc/2GqKQF3j
         NCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900767; x=1762505567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVOOle+AJIIuteMGQoWj0kXyHB826iCzl9rVosT29bw=;
        b=PV24AFC96nV508HPEf8nJ4JabEEFL/sdIKofZ8U+dptANlm1HjlumA3ZyGLHB3JcJL
         /ANsMxRlNNGzJzKk3guXtQv/bgoqa/QBbRZPLeR2Zp7WcNR9PWG/SAellSJJaovoiwef
         412JXHgh5UvSTUPmoqVtPqItrgqBDdr4hrs2Mnofo/Z2ImF5aLUal39+o4k+nqeE++Sw
         kDCHPExbw51krdO2OIRs1wGSHv+6Sqx30Giq83rSBPva6+oGT7SH3ygyVKEhA4WIfgBQ
         v/j8pvCD7OKYW74wsHizgGU7t4tMA0hbcjAmIBY57SoLy+Ao+0sbGVDkOTLp/ouxvaw5
         0nng==
X-Forwarded-Encrypted: i=1; AJvYcCV5iYe/XZB0qrUjk3lg2Ffq3sF7nfthz2ATCOyNoEIDrpXaktE+igMg/JngDQ8EIB5/dJrgnBc3Vsgi5UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSx99WiHPYMyz2txgMzx/CL0WdsfXAfFYE11o5RirhiWfF8YfV
	B2EgvI631BX6fgxX8d/whzt0LMn7r6wJi8dXfSWdHXQgrtoQM22Ly2GNESLSw9nUDVFLF4rKcIF
	j8BNYozVbpr0gd9WBmBlo8skUk1oCWtyLBCAQaTiOCQ==
X-Gm-Gg: ASbGncsdh0heV+Bo0Ca/x9nMM+NrheTOeYhiqfKQntF+hppwnX40KW4CyMMH+TW6obk
	lsNg4in0YBHEiv+/wY0tIn1UPX0j29g8SEda/4JHt/gkiD8D+I+yZnE7y3NJRCkRIxPK0sqd0R9
	3lLzxeQNM+YPRoTzH8LmXVFONoy3Nseh7YUZXsqNVGE7zDzU6gihQCYKOL3Qn2Y3ghR+VkwkBw6
	olk6k//NnKKx9iVQePCUeOTCLEVckBY+9GyvK1EQunkNr820tm4L+RpQoPDdMQ0NWLqlIDdvsTO
	MhTYDw==
X-Google-Smtp-Source: AGHT+IE2vnBdZNasAB1Xy72r9A2Sn2OoZw85wjD6Cd+JaiFG5aHRQrN3+j4NMQ38eKKIVVsK7pOkSngxrziJiWDeO4U=
X-Received: by 2002:a05:6808:2198:b0:437:dade:463f with SMTP id
 5614622812f47-44f95fd5661mr1151443b6e.34.1761900766670; Fri, 31 Oct 2025
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-phy-notify-pmstate-v3-0-3bda59055dd3@linaro.org>
 <20250813-phy-notify-pmstate-v3-1-3bda59055dd3@linaro.org>
 <aKX5C9Xlx2CSJraY@vaman> <CADrjBPpaJdzDSe3kjk=zrODusH3LnwhaBn9-NDCJwEy3ymwvew@mail.gmail.com>
In-Reply-To: <CADrjBPpaJdzDSe3kjk=zrODusH3LnwhaBn9-NDCJwEy3ymwvew@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 31 Oct 2025 08:52:35 +0000
X-Gm-Features: AWmQ_bmf3sDwcFE73Zf2SHIWustpcGeUpWRxOdPU5lAg-c6tgm7mH2rWSEsBY1E
Message-ID: <CADrjBPqc47TBXA78gO7VENLqYdsodKAGckB528OXv2==EM9MpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] phy: add new phy_notify_state() api
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, kernel-team@android.com, 
	William Mcvicker <willmcvicker@google.com>, Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Vinod,

On Thu, 11 Sept 2025 at 13:23, Peter Griffin <peter.griffin@linaro.org> wrote:
>
> Hi Vinod,
>
> Thanks for your review feedback.
>
> On Wed, 20 Aug 2025 at 17:34, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 13-08-25, 16:00, Peter Griffin wrote:
> > > Add a new phy_notify_state() api that notifies and configures a phy for a
> > > given state transition.
> > >
> > > This is intended to be by phy drivers which need to do some runtime
> >                     ^^^^^^^^^^
> > Missing 'used' possibly?
>
> Yes your right, good spot, will fix.
>
> >
> > > configuration of parameters that can't be handled by phy_calibrate() or
> > > phy_power_{on|off}().
> > >
> > > The first usage of this API is in the Samsung UFS phy that needs to issue
> > > some register writes when entering and exiting the hibernate link state.
> > >
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  drivers/phy/phy-core.c  | 25 +++++++++++++++++++++++++
> > >  include/linux/phy/phy.h | 19 +++++++++++++++++++
> > >  2 files changed, 44 insertions(+)
> > >
> > > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > > index 04a5a34e7a950ae94fae915673c25d476fc071c1..60be8af984bf06649ef00e695d0ed4ced597cdb9 100644
> > > --- a/drivers/phy/phy-core.c
> > > +++ b/drivers/phy/phy-core.c
> > > @@ -520,6 +520,31 @@ int phy_notify_disconnect(struct phy *phy, int port)
> > >  }
> > >  EXPORT_SYMBOL_GPL(phy_notify_disconnect);
> > >
> > > +/**
> > > + * phy_notify_state() - phy state notification
> > > + * @phy: the PHY returned by phy_get()
> > > + * @state: the PHY state
> > > + *
> > > + * Notify the PHY of a state transition. Used to notify and
> > > + * configure the PHY accordingly.
> > > + *
> > > + * Returns: %0 if successful, a negative error code otherwise
> > > + */
> > > +int phy_notify_state(struct phy *phy, union phy_notify state)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (!phy || !phy->ops->notify_phystate)
> > > +             return 0;
> > > +
> > > +     mutex_lock(&phy->mutex);
> > > +     ret = phy->ops->notify_phystate(phy, state);
> > > +     mutex_unlock(&phy->mutex);
> > > +
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(phy_notify_state);
> > > +
> > >  /**
> > >   * phy_configure() - Changes the phy parameters
> > >   * @phy: the phy returned by phy_get()
> > > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > > index 13add0c2c40721fe9ca3f0350d13c035cd25af45..664d0864c3a5042949cb121e982368fe0a97827f 100644
> > > --- a/include/linux/phy/phy.h
> > > +++ b/include/linux/phy/phy.h
> > > @@ -53,6 +53,15 @@ enum phy_media {
> > >       PHY_MEDIA_DAC,
> > >  };
> > >
> > > +enum phy_ufs_state {
> > > +     PHY_UFS_HIBERN8_ENTER,
> > > +     PHY_UFS_HIBERN8_EXIT,
> > > +};
> > > +
> > > +union phy_notify {
> > > +     enum phy_ufs_state ufs_state;
> > > +};
> > > +
> > >  /**
> > >   * union phy_configure_opts - Opaque generic phy configuration
> > >   *
> > > @@ -83,6 +92,7 @@ union phy_configure_opts {
> > >   * @set_speed: set the speed of the phy (optional)
> > >   * @reset: resetting the phy
> > >   * @calibrate: calibrate the phy
> > > + * @notify_phystate: notify and configure the phy for a particular state
> > >   * @release: ops to be performed while the consumer relinquishes the PHY
> > >   * @owner: the module owner containing the ops
> > >   */
> > > @@ -132,6 +142,7 @@ struct phy_ops {
> > >       int     (*connect)(struct phy *phy, int port);
> > >       int     (*disconnect)(struct phy *phy, int port);
> > >
> > > +     int     (*notify_phystate)(struct phy *phy, union phy_notify state);
> > >       void    (*release)(struct phy *phy);
> > >       struct module *owner;
> > >  };
> > > @@ -255,6 +266,7 @@ int phy_reset(struct phy *phy);
> > >  int phy_calibrate(struct phy *phy);
> > >  int phy_notify_connect(struct phy *phy, int port);
> > >  int phy_notify_disconnect(struct phy *phy, int port);
> > > +int phy_notify_state(struct phy *phy, union phy_notify state);
> > >  static inline int phy_get_bus_width(struct phy *phy)
> > >  {
> > >       return phy->attrs.bus_width;
> > > @@ -412,6 +424,13 @@ static inline int phy_notify_disconnect(struct phy *phy, int index)
> > >       return -ENOSYS;
> > >  }
> > >
> > > +static inline int phy_notify_phystate(struct phy *phy, union phy_notify state)
> > > +{
> > > +     if (!phy)
> > > +             return 0;
> > > +     return -ENOSYS;
> >
> > Should be -ENOSYS either way, right?
>
> I initially thought the same, but I followed the pattern that is used
> by many of the other phy API calls like phy_init/exit,
> phy_power_on/off phy_calibrate, phy_notify_connect in
> include/linux/phy/phy.h. I can update it if you like, but I was trying
> to keep it consistent.
>
> The only API I can see (that isn't a *phy_get* or *phy_create*) which
> returns -ENOSYS unconditionally is phy_get_bus_width()

Friendly ping about the above ^^^

Peter.

