Return-Path: <linux-kernel+bounces-897106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C2C520DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762885065F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FD30E0C5;
	Wed, 12 Nov 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Agq4Gj7q"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1F30B53F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946890; cv=none; b=unNNNDYbELigJfG9Pl80WbW1Ozco0i8InDg8aLJvlOY26NAgInVSbrqkrQM9YNaCNDyfYf5cB0oWUvZOx+Apox0EDDD8v1dbsAn/vbGBKwcfp9Uf5GejpvZ1NE7CXZjroP5LxJlEnWEp4YM1/xPgTz1DJejP8C0l3G9j+un5GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946890; c=relaxed/simple;
	bh=1dYK7f4FkPzoZeJ51K8mDZvHGpP/FeIezNcDD5hERdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pg0Ow9KP1JR5EJ+li/FJhUzMWzNU7Q37ldwSmVOuHkIU3MAUtDVWv8erxMk5Rn9Rl01od+ufTlwIEUGutXu4CWaTD+YyY5eHU37Gkca+fc/fdWPepjjdyM/EGjOvBU/CKLV0QnXqJAeMVSJVHR0jlaiiTdmbejbghj6oznwxtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Agq4Gj7q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2957850c63bso6266815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762946888; x=1763551688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig8V7S9rFhIoVLkY+/XWuMwWvPcC3NWWv4ch5Z8G1nk=;
        b=Agq4Gj7q75twnaldQoOyRwegmMpWfqRiAkSduaLyqfF9b0ngSBXUBtv38zNPxzZpju
         2LpRH+6BJo6spdCm8zZPmto1MLnrBLRUm0IpN6/mSkVf51HqIIPjhyJgDMSLvcMO1oRM
         MbjG3IMv5Lnbq8xDWQz1rKjXI92CnRArQ7ya+qWk/+lQyJy1mampYfS07KdJCS0becQa
         YfWSz7irenPniI+wFEEq7tfeB4zn1FuHmSABqEcIdGoti6+7BD5XeI+HUliFBkUsEeCn
         Oz+AG21bFX/eRk0++NhYJbsjsX5WIigS64HJwwEwNpZafC97iICeD7vbcHYl9cDYOLpx
         02Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946888; x=1763551688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ig8V7S9rFhIoVLkY+/XWuMwWvPcC3NWWv4ch5Z8G1nk=;
        b=gHpY+024t8JliX4wg3lAAf035qKvvBBq7v0cmmLVjYz3WcxzeABHyj9Q/W+U66wmuS
         oTMTUTTt2q7MZ2cKzqXru3qoogib8bQyP4qhg1CgSYAoxRGB9Xpg1+BRtxammMLMCdlK
         CvsAp3wVS9L/BGmClKr1QcENnJcZKXUcOdQ4FULkZv/YHWdm9kY8Penn4OvYmSRxWxa4
         IIXaV6xD+SQDoroNqyiFmWIAgbXBVZfWcVPCMm8gRu+ZhBLMmhDvijYh5eTgM80fJpgn
         uwHxa79JVzjk7RawP7YYM6cO3zRmr+oc5WVNJB7UKjLdkZFoB4uFrf03tzPRp5jkFS/z
         +qoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQhn0k7Vk9DhoZdN7/t9WJB4YZ5qt7UztTThOQgIXeMSA8srfvaRBxhzR1SJw4H5vyo5SjtHaEtsscE+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsV9czlen9FP+cobj3THSWHHjOV45X1ufj/CNvnxwpACbWUo4f
	N2Pt+9CiX5KeJjHF31TWNZsbQeOrt7rri/+ZncH8ymtBoDOYWHO3BYo9aONm4P1RCUTAktcby+x
	FGjnLd3Uv86lu9XTHVz1Q7z5LqDkA3SUbHmGFT5NF
X-Gm-Gg: ASbGncujTM2aCE5mlv9Wk0+oo8oZCSpEg7+pZ2Rpo7/QKSuohL+IyHtUKBK6XWJ6z6x
	jAf5xZ6ps4umMaxWY9S2WTV7I9mmfInE2yb+64IDWFMmpzGb1ApR6UivGE726X3VnmW3oi46AZg
	zUUnmBGsgAKMy1PJsnkGtvAMJ/kOTpFU2g/D0LVJ/3BjzWvTg1AnpbRtwxOvL3f+QxfT/+5JlZ2
	Hi2Ur7q7RrzHHfy8vriy1DWQi4H1RHqAE5BXdhRpNfjIH4qrVWEYrGh+lCEx8PnNNDV+gJVz2JB
	kTa3BCuVph3Y/rUuxQzQXmdZbfLvKzzHOtnk
X-Google-Smtp-Source: AGHT+IEzhYJUJIhP1itpJ8SMj4wfy7Edo9fDUXSWIfM11ytYomEi4CEvHvu/YvWNAK7+sehRmwWVHzbMhPckpBBMF6k=
X-Received: by 2002:a17:903:234d:b0:296:5ebe:8fa with SMTP id
 d9443c01a7336-2984094a5bcmr70869985ad.23.1762946887940; Wed, 12 Nov 2025
 03:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111130624.3069704-1-royluo@google.com> <20251111130624.3069704-2-royluo@google.com>
 <20251112-logical-grebe-of-modernism-dcf83b@kuoka>
In-Reply-To: <20251112-logical-grebe-of-modernism-dcf83b@kuoka>
From: Roy Luo <royluo@google.com>
Date: Wed, 12 Nov 2025 19:27:30 +0800
X-Gm-Features: AWmQ_bn2RT6EbgSb3mHFWKckHPwcrvZ-s2OqhjevpH_GhYx3Lcain4Rs18PGkFc
Message-ID: <CA+zupgxALZjF8m=PfYgb1QUgf0u+-Su0XYQ3VB=fCpM1dt9s_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, 
	Doug Anderson <dianders@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:32=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Nov 11, 2025 at 01:06:23PM +0000, Roy Luo wrote:
> > Document the device tree bindings for the DWC3 USB controller found in
> > Google Tensor SoCs, starting with the G5 generation.
> >
> > The Tensor G5 silicon represents a complete architectural departure fro=
m
> > previous generations (like gs101), including entirely new clock/reset
> > schemes, top-level wrapper and register interface. Consequently,
> > existing Samsung/Exynos DWC3 USB bindings are incompatible, necessitati=
ng
> > this new device tree binding.
> >
> > The USB controller on Tensor G5 is based on Synopsys DWC3 IP and featur=
es
> > Dual-Role Device single port with hibernation support.
> >
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  .../bindings/usb/google,gs5-dwc3.yaml         | 140 ++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/google,gs5-dw=
c3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml=
 b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> > new file mode 100644
> > index 000000000000..bfaf6cbdfec3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2025, Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/google,gs5-dwc3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Tensor Series (G5+) DWC3 USB SoC Controller
> > +
> > +maintainers:
> > +  - Roy Luo <royluo@google.com>
> > +
> > +description:
> > +  Describes the DWC3 USB controller block implemented on Google Tensor=
 SoCs,
> > +  starting with the G5 generation. Based on Synopsys DWC3 IP, the cont=
roller
> > +  features Dual-Role Device single port with hibernation add-on.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,gs5-dwc3
>
> Doug just said SoC is lga, not gs5, so you need both to align on that.
> Actually not only you both, but whoever else is upstreaming from Google.
>
> It is not the community who should synchronize and organize way how
> Google works on their own stuff. Google should organize how Google works
> on your Google's stuff.
>
> Best regards,
> Krzysztof
>

Ack, will align on the next patchset.

Thanks,
Roy Luo

