Return-Path: <linux-kernel+bounces-875634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07810C197CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC82561CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24531AF25;
	Wed, 29 Oct 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXvyNhLs"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A4225402
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731159; cv=none; b=YXZYtmjUayAmyGTBQ2geSlBSxwSi82fzcd35VLd5WfVoCMYd903DsnLGgj1zFpO03yq8Le9V3zRwLQrK0bWEnfJYE1nwmGF0J5Wv1u+WlA1o3EynKdzm/aESiJCEEZxgN/f6jxJRtI27APeuPoO7Aiyc380uscGVf7mvtfxcToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731159; c=relaxed/simple;
	bh=4o1P0z9zgAdcg3159+pZiazrU0J4QU5VpIS8Y7AdyTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ0OJixsTBDMCV3Z6jL3+aLM8P1kp/FCDPxwc7pBSssmsiXM4488g94i/6AVDCZNYMEQEQttPi8ziYGavKdK6pWZ1KTZc4rD3dp9/3AGTxHNMsMdKUyYUn+RTzwAqFX07GSDg3sfrbDsY6nrQxwRQRd3PzgHHsG3ussRgBN2NFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXvyNhLs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7815092cd0bso83733857b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761731156; x=1762335956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+0dV49Z0hZQvL1JwoyFgg+j9v/HxeFYx2d1Gt9wCQ4=;
        b=nXvyNhLsiC4mm3n0m2EBak1+nEu0PBavqaH1RVnAxjtT9Y4SQwQ0hYXC37SaVdUqNq
         cIzw+jBiAKZIXCA92prJliUZjArWgaLt0Nt4+1o0YL2R+WJqpei4kSS6yAuU8/Gn/vBY
         376mH2ffCsHWRyeIqYfTt/RxvuYwGXKxCtg1myKYt67I8YyqZAC6X1nXEu+3kypt+a/0
         oKLnv861ibTA1bQJ5wM3e7AC3fB8hYV/Nv3dL+82FUTZabk7s03AdRDhErCUtqhrLmZi
         M9QVypEqxMx176JycHS7SybFT//ZAwRrmDQJzIXpjr8kE9hYY6DjYxQ5uza1QpcvGXV0
         IH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731156; x=1762335956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+0dV49Z0hZQvL1JwoyFgg+j9v/HxeFYx2d1Gt9wCQ4=;
        b=Kx0YeaDeQzpF/c0wKBZqKfEJCDmDMsEtCsgoMW6mJ1VAOygrXol5isht8tP4fl/L/d
         coJinVZwWlVOmT4x1uiceAu1S6/nTMUJ/UyD5OylRh3l76jj+bzam3XALMk6XNDrPCnC
         sGQCzpT65mxMDwkCOSd939uM/8krPQuz0vypGxjaab5aS6ecyvGuvWsA5kl6ptr5eOIx
         hVa8VwIgfp0NX8gtv3qtuOZuffq9zmXSCfjmmVBxRAkOLKhzh2ZX9IzozYdRx4ZoKFnQ
         iiokZ7PyzmHIAicdjiCMIQ+VrJoUo3gYprg5bvuZiyRfo4dniUCYD6h9SDEzHHIVU6AX
         Gsew==
X-Forwarded-Encrypted: i=1; AJvYcCVxDIh7wDH5C29MgpUYwzpqG45GQw2VXWIciXYdT+ZgH7y02jsYazcvGSjjcKQQDnFbPQxopUpGqQyevG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3GdWl1Xou9KjXUBTB4mXgB22fLHjyPYZ5Icvb12Y9ZtKkeMN
	ZX1gRgMUL6f4+SgRnS9uy9ToxDtP90eiAP1forCzMjbbMBCERF7uZAz7s71zdjTOhAGqLH37Om7
	fFnGcwLVR8Lv6WWhlh+SmE0fIUZq0hLM=
X-Gm-Gg: ASbGncuLn3Bex1cWMmvW8nFlBm2pIGxIdp72v7KO8Y7+EP2/RCAUSGjTZ9ksTqmhChC
	6yJ9ksv8CYzOnjJpuDq9LGpgAosK8QjfErEs5oGAj075wanXOQo1zBLVG1jRx/vvifr2EGsmO6r
	JjFkbdXoF7stu9iIvXqGnXNWGWj6uGciLpxA940QQ8tgHnV22+HDV4FhPKRGzHlkpTlnXhXLyce
	sfV/fFw7tYVNENg77doYsdy7vr3buEU6tL+yMqG1beGJNJ197w0XCzxwTm61NN+zNEgLQ==
X-Google-Smtp-Source: AGHT+IFXTGFBQZQCvoFTcD2XW69zJNvRv2jA1skYdjLaN3X9V8WOQAc0sJLs73yBIhsOL2y0JL1ybcsga9Zkjczkf4s=
X-Received: by 2002:a05:690c:680d:b0:785:bfd8:c4ad with SMTP id
 00721157ae682-78629298707mr36580707b3.3.1761731156514; Wed, 29 Oct 2025
 02:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071435.88-1-kernel@airkyi.com> <20251029071435.88-11-kernel@airkyi.com>
In-Reply-To: <20251029071435.88-11-kernel@airkyi.com>
From: Peter Chen <hzpeterchen@gmail.com>
Date: Wed, 29 Oct 2025 17:45:45 +0800
X-Gm-Features: AWmQ_blYmsodv_vg4uKolYRe0NzpqIhwJ3rq0FrOe8J4voY-HqIG6eRi0roVBPc
Message-ID: <CAL411-o6mF71oBeRsJ-OPZNbLegn4iJ_ELN9xVdppTM3ssUPOw@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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
	Amit Sunil Dhamne <amitsd@google.com>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> +&i2c4 {
> +       i2c-scl-rising-time-ns = <475>;
> +       i2c-scl-falling-time-ns = <26>;
> +       status = "okay";
> +
> +       usbc0: typec-portc@22 {
> +               compatible = "fcs,fusb302";
> +               reg = <0x22>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&usbc0_int>;
> +               vbus-supply = <&vbus_typec>;
> +
> +               usb_con: connector {
> +                       compatible = "usb-c-connector";
> +                       label = "USB-C";
> +                       data-role = "dual";
> +                       power-role = "dual";
> +                       try-power-role = "sink";
> +                       op-sink-microwatt = <1000000>;
> +                       sink-pdos =
> +                               <PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
> +                       source-pdos =
> +                               <PDO_FIXED(5000, 1500, PDO_FIXED_USB_COMM)>;
> +
> +                       altmodes {
> +                               displayport {
> +                                       svid = /bits/ 16 <0xff01>;
> +                                       vdo = <0x00001c46>;
> +                               };
> +                       };
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +
> +                                       usbc_hs: endpoint {
> +                                               remote-endpoint = <&u2phy0_typec_hs>;
> +                                       };
> +                               };
> +

Why USB2 PHY needs to be notified for Type-C connection?

> +                               port@1 {
> +                                       reg = <1>;
> +
> +                                       usbc_ss: endpoint {
> +                                               remote-endpoint = <&tcphy0_typec_ss>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +
> +                                       usbc_dp: endpoint {
> +                                               remote-endpoint = <&tcphy0_typec_dp>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +};
> +

.....
>
>  &u2phy0 {
>         status = "okay";
> +
> +       port {
> +               u2phy0_typec_hs: endpoint {
> +                       remote-endpoint = <&usbc_hs>;
> +               };
> +       };
>  };
>

There is no switch and mux, how to co-work with Type-C?

Best regards,
Peter

