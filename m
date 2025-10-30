Return-Path: <linux-kernel+bounces-877460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814BC1E2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37881401409
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE532C93D;
	Thu, 30 Oct 2025 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDmSfMcI"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E9264F96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792628; cv=none; b=R17qBrxdLhvWhPQgBI44lBJi1K+LK77adodWQBnXncJfc2k2X5oYJj0L1WxcdChb2haIn6cfB/5VJbFgzCzF+kP3fKkN4WaUNwtnfP6LGgo8nPL7SY3JSITcTlrlUGV5odtXmheX9ZfHvNLTE+R/ueYa8Kc5sAcMlTZ/2evyKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792628; c=relaxed/simple;
	bh=ULHZ+cHHaL+5iHaOLJNUHVNaWClPu5YSGCKCYmnu47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOwiknjwKBICzlClvE8tOv2jvtV8Ov2mv/jcbj7kjbpYNrXMSMrb8dsQWKOr5ixX2k7VRZP2m3KJZkIJwVLSYvWwlxNxiSaxtpFJ+vgcYXSDhkGg0DY8cxsME3iFGpTe7g64Ry+GYyEHF61H76VZgRXVLSg543gzGMSWSkv8SYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDmSfMcI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6014810fso7068767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761792626; x=1762397426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49j9QrYlm4qxZHbvYSYUJsJt0aMp426fig3D6hH+fj0=;
        b=EDmSfMcI1I0RB3mL+KS6FaXru/zT9nI9bPxO8dUeZOTkNh1MHBjO2te+pUa1T5EvS5
         qry+N/5WTv4eEOU1wnMMKUhY8q4s2qAmXvx8Ml6vnU7xPor/nTbGKb5nOYe0+zJLjeK+
         v9o5XfgB0JvmGyX6Hsoffmb2SltZdvxrWZRvPmtyG9pEykkVFDWfQBGDg5v/npxL6k95
         nnvnVhJJhmj1Ubc+413h7hLwA9k76z79lESUR/rcuT3f7r5wezXpGfQ2sERYgATbEbTu
         U5yeIM+COkMA2QFti8fvSHF14E4JA9KrIt1tvxD4hHsqpJCKsxKam91NO/s3kVx47u36
         LzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792626; x=1762397426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49j9QrYlm4qxZHbvYSYUJsJt0aMp426fig3D6hH+fj0=;
        b=LriezlXCyI3uyaMCS1ITuEd8rZ8aRlaY+dRbh38TB8Gy/cakskN3vxlMHC/ql0m49T
         Qw9+rb+d/Rk5EgubcYiNdl8DruV9thwsJ87N46BvctD54OmdePPoKnjSD6UCqZH2f4u4
         /l5naB4/EKZs/pZLbpSPCXVPATwmRs6CcJ8EwnY38jMAUXf4BnfpJVnBIIzK4+sdtAlv
         efQYYmasz2QgZG/bn7oKt5NBwmx/nJCoOnIhNoUUUL4SEIOj8vESFm3NQEV2qtneW1Eq
         5tjuCTEiCHFTnIOL+YNguUoJP4ILHlPSiwQbk9eq65mTLaAGm87G0Z4fcLbwHg9HP57R
         ZnSw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfi5dpFZ9Mp7+Qy/U7HSt1+7+aw8cjtt3rg0eYNiOHa2PVnxLYQ6ZqEnHRoHDs3jmBfnEWm3fqm76/PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4X/esuzV/eQ27mVb44HgnDvolgl0wuAMe38FdoUdkOw2+0RM
	j45qX7ExWx7iqnpfKcu0wTxj39dZXhBfDwkg3bK/Stgv67XPSnUjwv++ZT8rhpO53tkG6Pq74Mx
	4ywaIEGWGZv1txP0KKaIRnZliBypRBBg=
X-Gm-Gg: ASbGnctQiMKYpq8VNsD9vO/1U/JErYFqwzlntqYv+ZqzP/ty3aN3ZBiWhKGATqqjdIc
	stdo8T2dYMng0j/hR3BBeQ646biDsjQ6KeeU6/jm7iIYSQ8J67ZbUlMxalUUZnVfPlKKg7hjRL7
	YoF4GSTnRDdt9zqEGYtkRi1MovqjZb5geGGMGz37JjL7JLLF4k78yff0FZbtqRT+elC9CmLxKA+
	f9jvtQO/G35JWukSKPnGATykb/n5lZYeeCSJoaSZPwMoQHQd/eOaLCWTCxyOnaML6XxWw==
X-Google-Smtp-Source: AGHT+IHyoJ9K1Vnf2DZwS2Kk6JM2P4IoAuduJ5ZhKYBvP2Erk/Knw6rAfD9/QlPYp3ts6NwBBaU6zsVdEYEe2Nqfv+s=
X-Received: by 2002:a05:690c:22c2:b0:784:8a26:b74 with SMTP id
 00721157ae682-78628cf728dmr50871897b3.0.1761792625956; Wed, 29 Oct 2025
 19:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071435.88-1-kernel@airkyi.com> <20251029071435.88-11-kernel@airkyi.com>
 <CAL411-o6mF71oBeRsJ-OPZNbLegn4iJ_ELN9xVdppTM3ssUPOw@mail.gmail.com>
 <cc8b583a-77ec-4a7f-97cc-2d148f7fee9f@rock-chips.com> <e0c5bda3-7428-49e0-9955-fa23f1e4f35d@rock-chips.com>
 <CAL411-oXfvp-iqN+uRmFHijdmW=1omKwozKOoZ2shxukMHmwPg@mail.gmail.com> <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
In-Reply-To: <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
From: Peter Chen <hzpeterchen@gmail.com>
Date: Thu, 30 Oct 2025 10:50:15 +0800
X-Gm-Features: AWmQ_bl1mNxPmQHnKmASAzhusTRjlDlCn6q9Kp_CyHmpybtPIUgHFck3iJTK_U4
Message-ID: <CAL411-pULVu4AYybW9oW7kmr4M_kJhdytgBjLPb4y6w_2dj+0w@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Yubing Zhang <yubing.zhang@rock-chips.com>, 
	Frank Wang <frank.wang@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> > Okay.  My question is basic: USB2 PHY supplies DP/DM, and the DP/DM is
> > short for Type-C connector,
> > and no control is needed for Type-C application.
> > Why is there a remote-endpoint connection between USB2 PHY and Type-C connector?
>
>  From the perspective of Type-C, this should not be added.  Is the approach in v2 correct [0] ?
>

Have you tried debugging based on upstream code?
v2 is correct, but the dts needs to improve.
- There is a remote-endpoint connection for USB role switch between
Type-C connector
device and USB controller device
- There is a remote-endpoint connection for orientation and lane configuration
between Type-C connector device and USB/DP PHY device.

Peter

> [0]: https://lore.kernel.org/all/20250715112456.101-6-kernel@airkyi.com/
>
> Or is the following approach correct?
>
>
> port@0 {
>      reg = <0>;
>
>      usbc_hs: endpoint {
>          remote-endpoint = <&tcphy0>;
>      };
> };
>
> port@1 {
>      reg = <1>;
>
>      usbc_ss: endpoint {
>          remote-endpoint = <&tcphy0>;
>      };
> };
>
> port@2 {
>      reg = <2>;
>
>      usbc_dp: endpoint {
>          remote-endpoint = <&tcphy0_typec_dp>;
>      };
> };
>
>
> >
> >>>>> +                               port@1 {
> >>>>> +                                       reg = <1>;
> >>>>> +
> >>>>> +                                       usbc_ss: endpoint {
> >>>>> + remote-endpoint = <&tcphy0_typec_ss>;
> >>>>> +                                       };
> >>>>> +                               };
> >>>>> +
> >>>>> +                               port@2 {
> >>>>> +                                       reg = <2>;
> >>>>> +
> >>>>> +                                       usbc_dp: endpoint {
> >>>>> + remote-endpoint = <&tcphy0_typec_dp>;
> >>>>> +                                       };
> >>>>> +                               };
> >>>>> +                       };
> >>>>> +               };
> >>>>> +       };
> >>>>> +};
> >>>>> +
> >>>> .....
> >>>>>    &u2phy0 {
> >>>>>           status = "okay";
> >>>>> +
> >>>>> +       port {
> >>>>> +               u2phy0_typec_hs: endpoint {
> >>>>> +                       remote-endpoint = <&usbc_hs>;
> >>>>> +               };
> >>>>> +       };
> >>>>>    };
> >>>>>
> >>>> There is no switch and mux, how to co-work with Type-C?
> >>> I checked the phy-rockchip-inno-usb2.c but did not find any switch or mux. Does this mean that we need to implement them? Thank you.
> >> Wait a minute, actually we have multiple hardware interfaces, one of which is Type-C, eventually connected to USBDPPHY, and the other is micro-usb connected to U2PHY.
> > I assume the Micro-USB connector does not use Type-C/PD IC, is it
> > right? Does it relate to this patch?
> >
> > Best regards,
> > Peter
> >
>

