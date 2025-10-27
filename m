Return-Path: <linux-kernel+bounces-872529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9DC1161F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA831A61407
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585102D739A;
	Mon, 27 Oct 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqUFY/pf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513A2E62C7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596658; cv=none; b=GAM+U/wEVGOFmrkfrDoILn9Qp9UIOUVlA9eIO3r4zJN9hHhvtET7smVgMrWn0IvSLllcnAGK2IYIE2JvBT6buB2ZNj9faGTjkTPec64q0nWtNN8VeOFtn/3r1pSpcoymlssgCntjcZzW41fnRDnxXmPksda5hHOkIOGsyVeNLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596658; c=relaxed/simple;
	bh=9Z7j6frYiud+8fgLPJNNX2wAipD0uqfxks5QxqPd8+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrFZP24CCdsBmueI058ooAaCrkOUM2mxW9Wwx/wAQWgmFKg+uu5/u1G5FO5Odsy2aJNU6hOEW8bECHr7m8Se0izF7QZ62ZgyHmMVG6WC+LYwRFQBpaCcGB81e426P1m9QrZiHz0xsr5WvGEsa8jEEghg5ZSj8nqmOAN77irMLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqUFY/pf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso2490650f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761596655; x=1762201455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sAteg+F5oQJPVS5wX8AGAiIq+FclqksfL+/bVRY3pIY=;
        b=UqUFY/pfNvVLEbCMq7i5sr/4F3Zl7Mvy7NWwxPCZRoLcXaV/TzNNrptitjKqwnyVeP
         KLjIb3iEvsatG+Glnh99/4ROSHW83jy0dt0QEcHdO8/V4RoYiWrMQqdJry13bZ7r8AZv
         htsLU60eG3v9GUkG9zeE8xDg0o7uB3+Df13Bpydpb6NreFXsiPzqmA4OigSNkkML5KSo
         tX6X/kbxkgrwf6O/p0J34JZHJJ/dzE4DUMLPJNssRKj7bpZRFYq5ZUtXSt6Mha6xchyu
         3bs6DvEJqPdByJZ1gm6hgBuZHWCkGQ0pSXhbxWTLBJ4Lk4k5LiQlPqtUA0J/O5s+B6fO
         v1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596655; x=1762201455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAteg+F5oQJPVS5wX8AGAiIq+FclqksfL+/bVRY3pIY=;
        b=IAa8x4KR09ROPeIw0ugjJmNj8gAYpG2bPn+EdSLU4xrX2mPOAbG586w9NwK6ljZlAs
         5pbsPcddImqu7w4PDcunnSHg+hE1txaDLmzJx1SKxHpC4qyw+15c6l9CQkTFbj2fGeJ9
         K06RMwPcJf4oxeNgYCnyfAq138DcDkf+DWLAw0VZpwGQjOn1hPM6/TJo7uEM4k1ZaCKg
         XBZ8o5uwFnBA3qp7peA74x5TM/hyBqwcuPTZLG4ie+L8g/QzR6LDPuVIarmaXjN1SS6L
         WwUZQYbBU0dGxMnNkj7tgMdEHkYHO8Z+5w1qqaJJo+UisVNJnkW63BMnslaCqd1pE8me
         ztNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWphvdreTEBm1QGob2Q1QL9mrbrUkTGWc6UhnOExziHt/uDKJRwnIyBlV0Kb4N8j6ejfcyHDR1wKm6SF30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRMrok2XKaF2Hkxxp0Kzynyk4buUIK2GVveL8DBj/+IJtZYq6
	bf5mod/0xWS08hcN8nJVTYodHWuezdBjMyD9D83RIjgKPv4uSdvMbH1F
X-Gm-Gg: ASbGncuhY6ut93sWUiBkH3RpPRREbnEwB68memPDwOdANXbuAfNxa3fdjdEQDdssTog
	55Bw9Stz4dH2fB4MY9+H/D8bYmQJV2bXe/CIT7FcZbFDTlxBa2HmqMpb3/cU5xGC/DegguBMaoo
	ymiKOiCMcd1dZbvl99wvlI392e0BVMQ/9e1FRoRHWe3fNH80g22PV9qrY5dQ/cmKgBNTVygri+R
	S3wYxiwOAXj7JpRGbht0zYq97fyLN3qRVv4lxzQBdV2clxxHcX03ag7AGqs2lHqj8CJifdUdJfl
	A2XBlWnaVK0hQGuEShOjq/lKTv9mxa/da0WbOXxTzgcYbJcS/JITD5lLKPWSSQxCZgWWpD1w9Dr
	idfWL2IbExocLtZ//HyixNOGZTx1xFxE9FVdYmea9M7f6JYWHseGuFzUBq9eeDMB4LXAwhDy74G
	qRQPFxkuWd+czitFHtgeS1DJnW4QxBRrBZ4Q==
X-Google-Smtp-Source: AGHT+IFjSyEOJ8OO9p5enPOa4OY5LYK/YHPQz+HhFO/SNaTbXxhM08eDKEWgk5JuJu6a3RlEJUVVfQ==
X-Received: by 2002:a5d:64e4:0:b0:429:8b44:57b7 with SMTP id ffacd0b85a97d-429a7e844eemr974038f8f.51.1761596654557;
        Mon, 27 Oct 2025 13:24:14 -0700 (PDT)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47794asm173897105e9.1.2025.10.27.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 13:24:13 -0700 (PDT)
Message-ID: <91e8f4346a677a2ea46a210d7422adb99e70b3be.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: j721e: Add support for optional regulator
 supplies
From: Vitor Soares <ivitro@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
	 <s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
	=?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	 <bhelgaas@google.com>, Vitor Soares <vitor.soares@toradex.com>, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 20:24:12 +0000
In-Reply-To: <p3l2p2raecqqkpdjswiddkthpxzvhm3rl4cw56y2epgcxfiwbb@gsieef3yqvpk>
References: <20251014112553.398845-1-ivitro@gmail.com>
	 <20251014112553.398845-3-ivitro@gmail.com>
	 <p3l2p2raecqqkpdjswiddkthpxzvhm3rl4cw56y2epgcxfiwbb@gsieef3yqvpk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Mani,

Thank you for the feedback.

On Tue, 2025-10-21 at 07:36 +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 14, 2025 at 12:25:49PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > Some boards require external regulators to power PCIe endpoints.
> > Add support for optional 1.5V, 3.3V, and 12V supplies, which may be
> > defined in the device tree as vpcie1v5-supply, vpcie3v3-supply, and
> > vpcie12v-supply.
> >=20
> > Use devm_regulator_get_enable_optional() to obtain and enable each
> > supply, so it will be automatically disabled when the driver is
> > removed.
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0drivers/pci/controller/cadence/pci-j721e.c | 13 +++++++++++++
> > =C2=A01 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c
> > b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..f29ce2aef04e 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -21,6 +21,7 @@
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/pm_runtime.h>
> > =C2=A0#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > =C2=A0
> > =C2=A0#include "../../pci.h"
> > =C2=A0#include "pcie-cadence.h"
> > @@ -467,6 +468,10 @@ static const struct of_device_id of_j721e_pcie_mat=
ch[]
> > =3D {
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(of, of_j721e_pcie_match);
> > =C2=A0
> > +static const char * const j721e_pcie_supplies[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"vpcie12v", "vpcie3v3", "vpc=
ie1v5"
> > +};
>=20
> Please don't hardcode the supplies in driver. The DT binding should make =
sure
> the relevant supplies are passed (including the optional ones). Just use
> of_regulator_bulk_get_all() to acquire all the passed supplies.
>=20
> - Mani
>=20

I checked the bulk regulator APIs as suggested and of_regulator_bulk_get_al=
l()
does handle optional supplies correctly, however it is not a managed functi=
on
and doesn't enable the  regulators automatically.

To use of_regulator_bulk_get_all(), I would need to:
- Manually enable regulators with regulator_bulk_enable()
- Add cleanup/disable logic in remove path
- Handle error cleanup path manually

This would actually make the code more complex and error-prone compared to =
the
current approach using devm_regulator_get_enable_optional(), which provides
managed cleanup and automatic enable for optional supplies.

I also checked devm_regulator_bulk_get_enable(), it treats all supplies as
required and needs the supplies name as well.

Unless there is a devm_regulator_bulk_get_optional_enable() API I'm not awa=
re
of, the current per-supply approach is the standard kernel pattern for this=
 use
case. Would you still prefer the bulk approach despite these limitations?

Best regards,
Vitor Soares




