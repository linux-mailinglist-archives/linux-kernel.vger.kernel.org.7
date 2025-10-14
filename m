Return-Path: <linux-kernel+bounces-851659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E153BD701F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DFF19A139A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9472612;
	Tue, 14 Oct 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4wBxSH8"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432820E6F3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406439; cv=none; b=HVZvo4TR87/5I7Z8GpAPzeMZd4jVaAEMu7JiLW2n8/DFRsrc8vNRBTeVlDRGziWBDTrYItEkduMRHp7mxIjnF+sRXUd6tODBEH/j3aGihJ3EltsawcAEgMrWk/s+BjR+TTb9VQXkDju+bK6kcV1yCDKXI8bTzbJThelPmaXXolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406439; c=relaxed/simple;
	bh=2CsPuuc7sXtpg4PefmMtwBtWIx1LnKQTXPGwO21uvw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kng+ipIkyzZLC4IP9JW+vCJAUARLFc3OeO7OsKDpJNkvfi1T8j95b1Ge/7vZwHi1vpQZN+g0+J/2PsDY+VRIeEU+VDDIT2JYEwt7cEuwYDIMbzOnvGxOz/KDRQ+xKE4cPo8e2uu2DGiIYhaVjYPjnDUUn1K9ZR804jTw9SXMCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4wBxSH8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso4153201b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760406437; x=1761011237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGjEi7N29NLVZhXUSQ4DWylm+1B6zKlX/oEjJXnY15U=;
        b=v4wBxSH84Dw03LmIFtkvaIgk4SZDxJ1Gx1nKsIuoIvhidmL6h0tT8DUYWuLZnuSJyK
         1plIWRwu3Mqh/xfw8G4evCU4exh4xwR11w4gzAwKz/Eu8Lcv+3fY5KV4oO0wbe2vpYSa
         887wCOn5qDkLoUKfTgojP8DntC38AYQqPtEg9/MNZe5ArwRGc6ugv2H2McuaZ6iTOzOT
         nGzyEEFNZobtQaKvmkPE002nEp5kMJyXvCzD6dmZsSbkHedTKTkq915zPRCHlmEvtrKZ
         kjBF7kwfjW7reyNYGwoNzLUq8R6L1oPdGFE6eRXyxugqal9CR9aKhBIB1MYFwcvLYLe2
         umKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406437; x=1761011237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGjEi7N29NLVZhXUSQ4DWylm+1B6zKlX/oEjJXnY15U=;
        b=iLdbuNbaQWKUd+xsEs8rmULeK3a7h12tBy6XoRpM3qiZOd3TruwTrBzLORS9Suq6vK
         ais37dFWJmBuSQ+5Zfef+xqGBTMld0MTi5+Y0TCfdnULap18fgT/4A24QYTRbX/eiKaM
         WOoAovOuKuPjmwzqlwxqZKFa6u4SKUXO+DGNNDIpsyxkwSH+sRjFxAaVL+Kw1m0ZvbWg
         e3Vzxva6QevMQtB/UwL5nSqtXASuOa7e//yBjAJkMwxzaCRa3uGRaM7wc74VYGoY96qe
         VuhajVROPmVzcPKShaCJcqDO5P1cYDr6zRsEKaPhVOQVvLdeEGfACL+q+ViUQfMs3pv2
         v7qA==
X-Forwarded-Encrypted: i=1; AJvYcCXK1EEeIBtJQAoW4nAsruV/cOdBHd4qGs+aU3fy0jE30P+Jip7fyS+N2GVPz3YtC7IaucA8SCE+mlsddeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOp/RTHd6F2AOSgEWXY731EeWE+0iZYcMV2vvoPpoe9yzoCtqZ
	ChPcY9t8OgZ4dbCYxUB7IaN7TUSTtRZimKUUDVWlkOP28lv7MHbfYSb0poKaI1BJdsjyS73U9tr
	Ur6ktTwtaRKCJeRukpwTp3vpo+7Z3F1Sibr9p02Qi
X-Gm-Gg: ASbGncvubpp2ULXAVdGco0yzX72kiMmoK5VVE66Ixr7NsgTkBYKeSeV73kvmdvE5aYU
	xTPvxADgvhGCj9L2Mo7hLAhgybow1HEAsHkIb4u+F0uZYp0k3+qae4bih2vzYri7ANVFkKWFsQc
	ftGCIO9tjWdNBjyy+aUmqfI3C2gA67ktmuH3EuYLuTkEXc31qMFSD/v91ysqplfD8lphLo2p2qN
	zBZcU05ni8am2oZIfMV8OqkUkSUewh/tpXnS5/b3n6dFS2+o7w3IoA8UpbnojReYPHXEGFwxxAT
X-Google-Smtp-Source: AGHT+IFfPTj8w4BDR5D6JCsus2aD4rztuewWvMbCmVCgUqrOKGYsSJJX4teAZRKcnFjdoRF0OnNBqOS96lWMLzstGuY=
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id
 d9443c01a7336-290273567a8mr277763005ad.12.1760406436203; Mon, 13 Oct 2025
 18:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010201607.1190967-1-royluo@google.com> <20251010201607.1190967-4-royluo@google.com>
 <75756635-b374-4441-8526-175210e01163@kernel.org>
In-Reply-To: <75756635-b374-4441-8526-175210e01163@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Mon, 13 Oct 2025 18:46:39 -0700
X-Gm-Features: AS18NWCzy6Gx5qemaFGw2t6jXb-2epsDNHczVHslksbyWgF7Radr-Z781gw06UU
Message-ID: <CA+zupgwHFpP5GEwGxOksmLJBU7+Kr_o0p50Pad1NmwNB0AxcGA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: phy: google: Add Google Tensor G5 USB PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 5:11=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/10/2025 22:16, Roy Luo wrote:
> > +  reg:
> > +    items:
> > +      - description: USB2 PHY configuration registers.
> > +      - description: DisplayPort top-level registers.
> > +      - description: USB top-level configuration registers.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: u2phy_cfg
> > +      - const: dp_top
> > +      - const: usb_top_cfg
> > +
> > +  "#phy-cells":
> > +    const: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  orientation-switch:
> > +    type: boolean
> > +    description:
> > +      Indicates the PHY as a handler of USB Type-C orientation changes
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#phy-cells"
> > +  - clocks
> > +  - resets
> > +  - power-domains
> > +  - orientation-switch
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        usb_phy: usb_phy@c410000 {
> > +            compatible =3D "google,gs5-usb-phy";
> > +            reg =3D <0 0x0c450014 0 0xc>,
> > +                  <0 0x0c637000 0 0xa0>,
>
> You probably miss DP support and this does not belong here.

This register space isn't solely for DP operation, a significant portion
manages the custom combo PHY. Consequently, this space is essential
even for USB-only operation. We can expect more registers in the space
to be utilized when DP support is added.

While I acknowledge the current name is confusing, it directly reflects
the hardware documentation. We can either adhere to the hardware
documentation's naming or propose a more descriptive alternative.
What's your preference?

>
> > +                  <0 0x0c45002c 0 0x4>;
>
> That's not a separate address space. I really, really doubt that
> hardware engineers came with address spaces of one word long.

I initially created this space to access the usb2only mode register,
which must be programmed when the controller operates in high-speed
only mode without the USB3 PHY initialized. Upon review, I now
believe the controller driver is the better location for this configuration=
,
as the register logically belongs there and the controller can tell
whether usb3 phy is going to be initialized.

That is, I'm removing this register space in the next patch.

Thanks,
Roy Luo
>
> > +            reg-names =3D "u2phy_cfg", "dp_top", "usb_top_cfg";
> > +            #phy-cells =3D <1>;
> > +            clocks =3D <&hsion_usb2_phy_reset_clk>;
> > +            resets =3D <&hsion_resets_usb2_phy>;
> > +            power-domains =3D <&hsio_n_usb_pd>;
> > +            orientation-switch;
> > +        };
> > +    };
> > +...
>
>
> Best regards,
> Krzysztof

