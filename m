Return-Path: <linux-kernel+bounces-811124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B2B524B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4851B2615B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F622D662F;
	Wed, 10 Sep 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuWj9VRP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B226F280
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546979; cv=none; b=cI1cInM775nlH29gkH5XIB7pFPR8s1MuPSRpSo9VO67PbqWZyLO9Qvgvqeg/xvA0SCDnhG++FB2/Dcsjyg5M6LTzxW9YzSUVQPwwaNZwP79h4lRHOsc1i2HlfHttQ1AXsrM1dqu1RXFK7nQmvfjFdfqLOV3Ortu+PoacvMrh4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546979; c=relaxed/simple;
	bh=giqX8D1e03WEb190csFinToB6mmpK+SueWukzwTLrtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9YRf5CX9ByevW99fgbi4T2tQJQUTkEzaUV0cYJVo47t8dxwczxkutp8seIK+5DvpBOtZU/WfllKP0BA1WKLiiHtghCCygbhoLyoloDY6lcaAtkRNKqpLX146EtsYa2L7NzbI7ZMhF5IF4ggg2atrykHfgKt0mTZbIsvMmlRMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuWj9VRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86805C4CEF0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757546979;
	bh=giqX8D1e03WEb190csFinToB6mmpK+SueWukzwTLrtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UuWj9VRPzw1PvbSaCVy7gV5XIu21brGl+BUVHFYgg27kHS3pblH2z9FZm0Zjxv25q
	 vM6pT5R7jh5OKkI2NzxgMyQx5Fv8tw3d/fDKigI8SHueZNQxBPhV/8lB1uJ3ajTG9s
	 xUvNcX9o7L4/f1V7B0FTzSx33FWb6to8itCzKX1wbdB4WAu7Kpl/1brpLB1O/G3tDn
	 TxiZM+HCqDW8zkFyLasBq+7lhQXG5SZiejGqiHT2kol1gyw9+pY3SzmoJ0bhzIwZT0
	 0XZFkApfr8uVDYBu9rbQ39gXBGSk8G3BnLFiRb/55HfKgaFrdWxUE1VeN1tzfFAXpY
	 4lPsVBhr+WVCA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a16441so15185566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDnxaeZsmPxsGBsDSIyRnre7ITeVb9a24NlOsprouWlWytEeIroRF37tSXfBm3zC42VV2w7sgHPPHIzpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fkxkaXq1IoJW6/14UAqYtVdfWMlz1733covxF0xhNcvkG82J
	Iwr/ciKJL+Q9LPpEGEtyPCAmR791fH9DXgpamqZAA6jRblGUjC/r0rfpvzN/HV1fb4QTruf1Sdk
	ksDB+HrjZ/3a28ZcxDCqw5yHSmpsMz9A=
X-Google-Smtp-Source: AGHT+IGlGgx50+D2ydI5vBqV6/W+PuaO1JZSUd97+Jrqkz/eIi6Qj2v1ae31SM3Fqif/p17XncOr6qKwTf/VY8KBwGc=
X-Received: by 2002:a17:907:808:b0:afe:bdcb:9e62 with SMTP id
 a640c23a62f3a-b04b16c4a55mr1764621066b.33.1757546977956; Wed, 10 Sep 2025
 16:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905084059.26959-1-ot_zhangchao.zhang@mediatek.com>
 <20250905084059.26959-2-ot_zhangchao.zhang@mediatek.com> <a7589659-0352-4d47-a3cf-f2433cc512ec@kernel.org>
In-Reply-To: <a7589659-0352-4d47-a3cf-f2433cc512ec@kernel.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 10 Sep 2025 18:29:24 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzrp-cfn_GiLrHCU629wEAxWy=egOMrRh6thYbymu+QXjA@mail.gmail.com>
X-Gm-Features: Ac12FXyyVN5Jiq60xJ95u5ez5XUlTPRrkZuzl25f4dRSg1MxKAtg591tBXMalW4
Message-ID: <CAGp9Lzrp-cfn_GiLrHCU629wEAxWy=egOMrRh6thYbymu+QXjA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] Bluetooth: mediatek: add gpio pin to reset bt
To: Krzysztof Kozlowski <krzk@kernel.org>, Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Luiz Von Dentz <luiz.dentz@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	Hao Qin <Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Sorry again for the confusion. I believe Zhangchao is still new to the
upstream process, and we=E2=80=99ll work together to improve this. Since th=
is
series has become a bit hard to follow, would you agree that it might
be better for us to restart with a clean patch that addresses the
review comments? A clean version would make it easier for reviewers to
focus on the current issues without being distracted by earlier
mistakes.

Hi Zhangchao,

Please note that both btusb.c (with DT and ACPI) and btmtksdio.c (with
DT) already support reset_gpio. Our goal should be to benefit from
these existing mechanisms while ensuring that this patch does not
introduce any regressions. If the current mechanisms do not fully meet
your requirements, it=E2=80=99s important to clearly explain why, so we can
adapt the existing framework rather than creating a separate one.

And please remember to carefully respect and respond to reviewer
feedback, reviewers volunteer their time and experience to help us
keep the subsystem clean and consistent. It=E2=80=99s a valuable opportunit=
y
for us to learn and to ensure smoother integration.

                          Sean

On Fri, Sep 5, 2025 at 3:44=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/09/2025 10:40, Zhangchao Zhang wrote:
> > Makes the platform Bluetooth to be reset by hardware pin,
> > it provides two methods to do it for mediatek controller,
> > and it has been tested locally many times and can reset normally.
> >
> > When an exception occurs, resetting Bluetooth by hardware pin
> > is more stable than resetting Bluetooth by software.
> > If the corresponding pin is not found in dts,
> > bluetooth can also be reset successfully.
> >
> > Co-developed: Hao Qin <hao.qin@mediatek.com>
> > Co-developed: Chris Lu <chris.lu@mediatek.com>
> > Co-developed: Jiande Lu <jiande.lu@mediatek.com>
> > Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> > ---
> >  drivers/bluetooth/btmtk.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 4390fd571dbd..29d6a93f255d 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -6,6 +6,8 @@
> >  #include <linux/firmware.h>
> >  #include <linux/usb.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/of.h>
> >  #include <linux/unaligned.h>
> >
> >  #include <net/bluetooth/bluetooth.h>
> > @@ -359,11 +361,41 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const =
bdaddr_t *bdaddr)
> >  }
> >  EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
> >
> > +static int btmtk_hw_gpio_reset(struct hci_dev *hdev, struct btmtk_data=
 *reset_work)
> > +{
> > +     struct gpio_desc *reset_gpio;
> > +
> > +     /* Find device node*/
> > +     hdev->dev.of_node =3D of_find_compatible_node(NULL, NULL, "mediat=
ek,mt7925-bluetooth");
>
> Nothing improved.
>
> You just keep ignoring comments.
>
> NAK
>
> Best regards,
> Krzysztof
>

