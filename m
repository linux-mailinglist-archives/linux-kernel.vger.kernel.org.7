Return-Path: <linux-kernel+bounces-823608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4986EB86FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504051CC1F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CE72ECE9C;
	Thu, 18 Sep 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MFPGL+0F"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0A188CC9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229238; cv=none; b=uKZANNoN2XNqLw76W/8VrTLtKO+eZ7xS4x2qbu7yw1ixVttrdcsfaSNFKXgLiU0X64+XREVI4xwfOlW5hom+jZH0/rDLIxLxi8qDPS4R3XryT0jcyPJdHZzXPK+R9QoOfNOdKm6TTcjaio/oc0Ldpx5f2xnEbAKg9Bc8sM/YajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229238; c=relaxed/simple;
	bh=OfUXqLDDkS545GzfXO0iJxOO/Yluws5JSCW+LfxKucs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juONw+bj/wIDwCy0xIEGS8hKyed1vwU1BbTcRr8Y46eVtOG35v/xSd9MwNhPDC5y5Lo117ourEatzmHGEjh+6ehambtSy8ri9+cc/sKprWa8CgCRpgAWb4y5GFwwb4259HSYVLCm2j1hS0dReEZ2lMg2AjGL8PXdVl7gx8JnLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MFPGL+0F; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea5aa2fdac8so1367348276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758229235; x=1758834035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa5OIKUu0Ca3IINo/LGf7w71t2tXTJFyE2lgg6vz7B0=;
        b=MFPGL+0FHDPbWs/ygIeidMVhI5Cdq6jQi8gVFLKAasHVHjN00pm4iJnSYwqaZJcY/6
         2TJNwD1YlvnB+Ntz0YBw+IvSsKbC3rJF7qdsDAavg1esPzTYdmlaM5yqqrf/oynqplTG
         PSOU5DH3PBUmbyfD525Fnkxs+O34/04QaqILY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229235; x=1758834035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa5OIKUu0Ca3IINo/LGf7w71t2tXTJFyE2lgg6vz7B0=;
        b=NtzK/X4Px1nju0U7lIf8ErBv+4Xj/lww29QMOu5SzyMIs39BH9jdn6dJWcuP+WJPpn
         vxIYlhOnnrju8I8zF7MESvSqy3cxtHAx8+P/SZyOP6iqITk2FYUUdflgVyvPvcK06cOQ
         tPxZPjXal488ntWI5EeAc3O4PH14CyyCaI8uEaBtb0D0tsXNZNx+bYvqsJPnwXVFLHiY
         B8gh/Xb/dVLHZn8spIateCXji7o8DqR2GFprPht4zfb+Svt4GzMdrP7dHA9h3ZTgif8Q
         Attqa/hOiymfGwJoNaIq0p0/emlWacNfXh7W7/pfBvaPtNRc7GQayHETNVYK3YFmGEha
         W/CA==
X-Gm-Message-State: AOJu0YzK+Y0dwgM1MWas1Ma+7oJtsYV0Nwu4kQpi+YzTdFD0wU9YmNQp
	QAgW1oSfJxw+I0RqRckXTNBhnlYuqz5ntGltCO2ndBhgsq8x1lN4snbgPZyS3YkD5tc7mmHm2hc
	JdYInLB5mrmB+B5U1QKtKYCVZjmb0ciRBAYeypDl8Lg==
X-Gm-Gg: ASbGncv2jDClCgNDVpvx5/Ws36BrB/nxMheH0HALcjQltHGtO6e4e6E8r9cDcjEP62K
	qoDTcByEPrzBVoGdRNeCKHHd29jb9GbgQ6S/M8LnZLSMCEGWTWPooEnig1aTV7rlDB5hVVXBeIu
	tVC0hwH8k5cvrmt/zVrBprvtpD0wFQXL2W4WQgpnv99gKOp4QNRAScOwouO3EV0KVB6uAWV9UBL
	6+1v14kMqdGCrZDOe5tBo0rlNNisq4HzTI=
X-Google-Smtp-Source: AGHT+IGp28b3RtzB09/vCQSod/GaXBm+1LaU+/ZwEenKAZ82Ogxy8gcysNIceSHCo4CO5jfnfEMY8Yfg89rinFTkagQ=
X-Received: by 2002:a05:6902:610f:b0:e98:517a:d058 with SMTP id
 3f1490d57ef6-ea89d1e9730mr930412276.19.1758229234832; Thu, 18 Sep 2025
 14:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
 <20250918153630.2535208-3-dario.binacchi@amarulasolutions.com> <20250918201027.GA2547040-robh@kernel.org>
In-Reply-To: <20250918201027.GA2547040-robh@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 18 Sep 2025 23:00:24 +0200
X-Gm-Features: AS18NWBVm6SiQea3xV3X5Izj9IWvwA2EVM6sgJdzxnP17KY04QnqWViQQGH1JFU
Message-ID: <CABGWkvoxALJgbmaiBe7+1EidtnX2aVE9M9S=QS_Z=hOTh03dRA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: touchscreen: convert
 raspberrypi,firmware-ts bindings to json schema
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Thu, Sep 18, 2025 at 05:36:08PM +0200, Dario Binacchi wrote:
> > Convert Raspberry Pi firmware 7" touchscreen controller device tree
> > binding to json-schema.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Drop firmware-rpi node and use only touchscreen node to fix warnings
> >   you can see in
> >   https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202509=
13092707.1005616-3-dario.binacchi@amarulasolutions.com/
> >
> > Changes in v2:
> > - Added in v2
> >
> >  .../touchscreen/raspberrypi,firmware-ts.txt   | 26 ------------
> >  .../touchscreen/raspberrypi,firmware-ts.yaml  | 40 +++++++++++++++++++
> >  2 files changed, 40 insertions(+), 26 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/raspberrypi,firmware-ts.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/raspberrypi,firmware-ts.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspbe=
rrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen=
/raspberrypi,firmware-ts.txt
> > deleted file mode 100644
> > index 2a1af240ccc3..000000000000
> > --- a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,f=
irmware-ts.txt
> > +++ /dev/null
> > @@ -1,26 +0,0 @@
> > -Raspberry Pi firmware based 7" touchscreen
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Required properties:
> > - - compatible: "raspberrypi,firmware-ts"
> > -
> > -Optional properties:
> > - - firmware: Reference to RPi's firmware device node
> > - - touchscreen-size-x: See touchscreen.txt
> > - - touchscreen-size-y: See touchscreen.txt
> > - - touchscreen-inverted-x: See touchscreen.txt
> > - - touchscreen-inverted-y: See touchscreen.txt
> > - - touchscreen-swapped-x-y: See touchscreen.txt
> > -
> > -Example:
> > -
> > -firmware: firmware-rpi {
> > -     compatible =3D "raspberrypi,bcm2835-firmware";
> > -     mboxes =3D <&mailbox>;
> > -
> > -     ts: touchscreen {
> > -             compatible =3D "raspberrypi,firmware-ts";
> > -             touchscreen-size-x =3D <800>;
> > -             touchscreen-size-y =3D <480>;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspbe=
rrypi,firmware-ts.yaml b/Documentation/devicetree/bindings/input/touchscree=
n/raspberrypi,firmware-ts.yaml
> > new file mode 100644
> > index 000000000000..697c508326b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,f=
irmware-ts.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/touchscreen/raspberrypi,firmw=
are-ts.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Raspberry Pi firmware based 7" touchscreen
> > +
> > +maintainers:
> > +  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > +
> > +allOf:
> > +  - $ref: touchscreen.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - raspberrypi,firmware-ts
> > +
> > +  firmware:
> > +    description: Phandle to RPi's firmware device node.
>
>        deprecated: true
>
> It should be a child node.

Should I add the touchscreen node to
Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
and remove Documentation/devicetree/bindings/input/touchscreen/raspberrypi,=
firmware-ts.yaml
from this patch?

Thanks and regards,
Dario
>
> > +
> > +  touchscreen-size-x: true
> > +  touchscreen-size-y: true
> > +  touchscreen-inverted-x: true
> > +  touchscreen-inverted-y: true
> > +  touchscreen-swapped-x-y: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +
> > +examples:
> > +  - |
> > +    touchscreen {
> > +        compatible =3D "raspberrypi,firmware-ts";
> > +        touchscreen-size-x =3D <800>;
> > +        touchscreen-size-y =3D <480>;
> > +    };
> > --
> > 2.43.0
> >
> > base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
> > branch: drop-touchscreen.txt



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

