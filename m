Return-Path: <linux-kernel+bounces-881228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6838C27C33
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6C84073A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CA202976;
	Sat,  1 Nov 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NThrswy+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1F2D29B7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994096; cv=none; b=LnvjcqeysJCeaObHqQdzwk+XqGGmJerwnBa/Fr134mjcr0aeUteOgDNASby9LzhP9sHPQqUbp7OxN7SPXO1QyYFTTh0S8nhKEXYsruJu/kkjdKbYl5K8t76yEufarvFmHhWB9Kc9GgjDZT5z7+Gkc7u9z4AUpl6KIgu14XRDwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994096; c=relaxed/simple;
	bh=xzez+fchR72BquI7aMREthZ1SO2DLRmUDjwIbYO9kQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxhSQ1h0gkRjMGVtGwlp45HZxwuURZrRpxM+JS/6y8eFdZaKhv4HJUts99SffuS5tZELzbb8Ae7UGD6akr2q8+6jRimxUjI072TKi/KQZ4OiOI6kTjmNcB+8V7lZaWRo/Yd78T7tW+yM3kI+IqtWmlkKRqzvJ8ISQ1z/NIAqLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NThrswy+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so5733865a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994092; x=1762598892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtLoHp0kEwq/bLHJArViyfu5fWlEi0xAxEhFmz0T09k=;
        b=NThrswy+wIz3JR7dQ5EI4mUVdOoPoo7rRLQmZFYXp9D61b76y1jc9YMpolQvR0cB7u
         7dEQjKatmW4Dz3Tfe8ph24F8+VSygQbmHudW0fZfgbOXQBBpAq87KrkwZvYq1xuat0jQ
         7Jt+85YH3Xg9e0yadg1XooRtdSzL6p8Q/mxLsMERxVV2lZXPAC1XsFh6sWREuqJG+287
         cVn18acrECtn2dLiBKobGs/79ppMQuKk4huK2SWIioIRdRA8NCBE/mPveeZlD5XayTwW
         g1SNRTeBbKN5AhGllbBxw9SOexE/rGtUagiim9EjMNitxXKK0uv2PZwBUsCB/5raYraI
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994092; x=1762598892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtLoHp0kEwq/bLHJArViyfu5fWlEi0xAxEhFmz0T09k=;
        b=mGnytH4GHVZ3WgfobqDVjgEN+0n8jsbwdLp61ZgTNejtFs5DX7/E+cEJVpQlxBKVhu
         OL6QItcd978xJGX3q1ERgx5uCuNkZeB2Zdqv+IcFZ0DJF/OCdJjKZ6sX2j1o2kaLU3cm
         xfbhVNyWVJNvBsutLsCHt3NJl25OC2iWxRMdrPAgRsaUhfvA2Dc8YgInEgL/79eU7XBl
         eb9eOssiOLFiN2SdvnGmdnthXZNcAhRhfojEU6A/pCpj64jQu5D1OPkrOnh7QsQfAxxE
         9HzLWo7dQVkpCDC3hFXiYkBHaer69Xh9IAQwvhWuvszyqH+WsUWW54T89T8pSWQph/Qg
         6MLA==
X-Forwarded-Encrypted: i=1; AJvYcCU/l+jyIQntTZW50q5AYN4SukDnej/GeCKIekajZKYEpDmb3uH91GtBPhnAdsR0Ep6xWRle8icH0PyOarQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DAKOIQAN37mqoeNmoay7xW88PqwVDjodPNQ95Bx7prkdcC1W
	Jq4ZUhBFx2iMQa+NVAjHmazMR2/yITQYVSMlW7X7LXx+9jEZmRZ35Az1IoTouUARuxRa98K0PEX
	xvMv4XB7KyEyGUfduHMfecLDL7KvAMS0=
X-Gm-Gg: ASbGncujNDwPvbQfk/X5z1gBZJXnOX8U1FCZHk+bV1UFgJiJZxnug4dJLjFGIQvo3uS
	XXlZKyOvSXKiwyenY3XbY1bVSNgs0SPMgCWl2N86jLeUwJS+d+hF0DO+LugLd2yy1QATdvEY9jS
	9atApYdNUwyYQNMSvLoV3761A4/0+ulUxoxCs8DsrfR4TlEglKz/IprVxA03V8Qn5V3kGaD+cSX
	BHgYN+E6RfzfLRKY9sxy1N32r1m0UdpiSNxp4l1SGvQoTquc2yppFbm4RK5sgiRrczWxg==
X-Google-Smtp-Source: AGHT+IEwEAbpzczbirHeYPq9CirAqArt7tfqx1f1DuepotXx+VdlfMQPQPP7/cGb1j0Z5jLq9Qc9/0ubBl45KkLxH90=
X-Received: by 2002:a05:6402:518b:b0:639:dd3f:f265 with SMTP id
 4fb4d7f45d1cf-640771ceb67mr5718247a12.25.1761994091667; Sat, 01 Nov 2025
 03:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905112736.6401-1-linux.amoon@gmail.com> <176085588758.11569.7678087221969106036.b4-ty@kernel.org>
 <CANAwSgRjXS4V_Kpw5kaJnPA8f=18uN-MgfEQ5ErN3aFRqbJKfg@mail.gmail.com>
In-Reply-To: <CANAwSgRjXS4V_Kpw5kaJnPA8f=18uN-MgfEQ5ErN3aFRqbJKfg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Nov 2025 16:17:54 +0530
X-Gm-Features: AWmQ_bmhgMeWFkOeYmBpsEodWI1g24fEo-iGnLSXhllxCODvU7vKr_LfOJBB0YE
Message-ID: <CANAwSgSrisWFPPRkZ=ukCjui3_xzgrmLKz5F9iXnerUFktk5UA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

On Fri, 31 Oct 2025 at 12:27, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Manivannan,
>
> On Sun, 19 Oct 2025 at 12:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> >
> > On Fri, 05 Sep 2025 16:57:25 +0530, Anand Moon wrote:
> > > Replace manual get/enable logic with devm_regulator_get_enable_optional()
> > > to reduce boilerplate and improve error handling. This devm helper ensures
> > > the regulator is enabled during probe and automatically disabled on driver
> > > removal. Dropping the vpcie3v3 struct member eliminates redundant state
> > > tracking, resulting in cleaner and more maintainable code.
> > >
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
> >       commit: c930b10f17c03858cfe19b9873ba5240128b4d1b
> >
> I am looking to suspend or resume the issue. We probably need to
> toggle the regulator
> to maintain the power status on the PCIe controller.
> Therefore, dropping the patch is an option; I will add dev_err_probe
> for PHY later in the patch.
>
I found this series with the address system suspend support

[1] https://lore.kernel.org/linux-pci/20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com/

This patch will conflict with
[2] https://lore.kernel.org/linux-pci/20251029-rockchip-pcie-system-suspend-v4-3-ce2e1b0692d2@collabora.com/

So please drop my patch.

Thanks
-Anand

