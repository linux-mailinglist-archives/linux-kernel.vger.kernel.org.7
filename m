Return-Path: <linux-kernel+bounces-844674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87392BC2784
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B699189D775
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F148223DD1;
	Tue,  7 Oct 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQTAky3R"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC841AAC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863906; cv=none; b=UmI1AxkIBTt5g2SdgblbW1GyS5lJLhIQ6s7r0nhdzQD2kaZa+UzJFeH02Ak08nMjUYIOyRL1b8xNV6+KYQtLpVQFDr2C3FS6VKQ2tWF3iPYpMEHiJG1wUeZdDXdI9ijuWX9iSCY5oSbGO9X89tO6ePzlGry9tyfacsV5BBPw6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863906; c=relaxed/simple;
	bh=kO8M2sUwBSg9QsJQN+wxcXT5Cr0LRxFkDBem1zTMtMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsU9Q6JLhrFnBfXcylPoxTEGRAc8iWUIuCKa1mVHWLyBdqAeX96xPzCftV2XY2fzSU0LeLO5DRCeal0vDxEpkpnV+rSOXxa+3Wh5jEzhpQET2iBNACdiLDMnS05KXrKrR3XvviBdQ02whBZw8e8HD26NCaqWcoo10/0nVIkmPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQTAky3R; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ba7aa131fso71993446d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759863903; x=1760468703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfYcdfacXGl7fDg4hKzg8AXQsGo845Ky08ZG+mHHCa8=;
        b=iQTAky3R610ZXX9mUIQrAeh5AKAhDv5eDuJafG7gN+PPdUeDtRlxzLEhcZXDdkOfhe
         dJ4OrlDvWiIvyiNs7n+mcqtofHEU+TEBrygH20afQiHcs4QA7PjTW2IzULeSWnPZ6m29
         FoFYHNkh7sQn60EhEoEz6QkuU+fsCa0TLjFdJ0Dja67cdUfKYzmCikzIBTiC5zHbVz0J
         w0DmbTi+bsGEj9UCpFFDpWPBSgA5z1lkgsKx0nIjrolO/OejlbnUeFqaxybTOjWwCawP
         4SPmPr20LdUOsekbgx6Y5P4RVLm8l34wp4ndPjmK9sYlrRNBkr1f5ayKVDuzSqQ5uTJC
         SqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863903; x=1760468703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfYcdfacXGl7fDg4hKzg8AXQsGo845Ky08ZG+mHHCa8=;
        b=Ndbk8Q0BU84KrIkYaNPnjqJshKNuzkQ8vFHk1ok0AiPJdr340uj64HGrw4fPtj7ZWL
         /H1mWfhE0SvFeYV8YWZHWW01txacEReunUILrsnVk3lm8jZbT+RvcNSbufQm5B7nfwAu
         3+8RjbErYIcpo3dMRTvkM+WSAhFLB508XMlBJyKe0ZA8I1I1puZiIe67HLj/s5dzFu73
         Fqn10FF9MIZBN9NER6PVFXnOzpKcxbMyulTF9xvnqO7R9boILtAxol7LmwFW0rLd/G6h
         MjbQ/AKeeoXc3ij3PGLOLPA8LruFq9W2jpuBnlDYAX0TJG1E0ZBbaW9cy9oJjDFpP0eI
         H7oA==
X-Forwarded-Encrypted: i=1; AJvYcCWz7pybusus9ieUbArJ+TPNZ3NTFsD/Q7YD2iuELxqRiJhWbrp61rizRNGs39UtBeXxw4LubLtCFUcsZ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7yxVeIcFhIRXF4lG0MUtiibvgf9oXgrvfFjaFOsOU3x3MOSI
	lf+qArzJ2J1z6jkRHYgb0lXklX739Jm41qw2H7wXLAgX5QEr8ctK3wd8R1li9WBH5vNxq02iIPD
	7zIQNwG6/XC8uaCG3fI0UzMfn12nNYGYVwTqbKY2K
X-Gm-Gg: ASbGncvAdA8GiJu4nSEtiaQ/S+Xc6uZoJEnw5jYcUvq3SnCwg//r8DnyURwCTWVfJb9
	byLkAqw3HOIPxjzBQDDHGLsIL+NrW7qxqcpEpSJVhXjUWoLlC6S3cP4hG0nK0ati+SQWfpQ2J25
	zR4WOn/PFfRd7Kxjo/GBmIMe9fZCxqz4fEepNdH8Sskm/Nm2z6x68b0B3BahlYYpM/6b+mirYhb
	Cfq64rqPs8X+sHUPx+6AzYxby6JYsZAcwTES85EUZ9wDN1uCQN8M8N+VXiule1kohyC
X-Google-Smtp-Source: AGHT+IESFakXnW6Fg7wLYTYS/Mk7KjZzZUlAj2VCFe5Uoi1p/a2ZlnMdRcd1vHRmazVrtj5+BAM5Fv3D9UEy9BjEHP0=
X-Received: by 2002:ad4:5c62:0:b0:879:eb26:dafc with SMTP id
 6a1803df08f44-87b2efdbb1dmr8896926d6.54.1759863902406; Tue, 07 Oct 2025
 12:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006232125.1833979-1-royluo@google.com> <20251006232125.1833979-5-royluo@google.com>
 <c9ac3ada-d527-40b6-a45a-41572ae1cc9b@kernel.org>
In-Reply-To: <c9ac3ada-d527-40b6-a45a-41572ae1cc9b@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Tue, 7 Oct 2025 12:04:25 -0700
X-Gm-Features: AS18NWBx0Fa1NrpP4hD_qvt4PklaMmDusw8GBylg6_1boLk-co7d-M-x80eszUI
Message-ID: <CA+zupgyjFnNjVjv0hzOMyt50aPHZCK-p2wkj-oka7J4wtv+WUQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] dt-bindings: phy: google: Add Google SoC USB PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:45=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/10/2025 08:21, Roy Luo wrote:
> > Document the USB PHY bindings for Google Tensor SoCs.
> >
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  .../bindings/phy/google,usb-phy.yaml          | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/google,usb-ph=
y.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/google,usb-phy.yaml =
b/Documentation/devicetree/bindings/phy/google,usb-phy.yaml
> > new file mode 100644
> > index 000000000000..5552696edfff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/google,usb-phy.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2025, Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/google,usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google USB PHY
> > +
> > +maintainers:
> > +  - Roy Luo <royluo@google.com>
> > +
> > +description:
> > +  Describes the USB PHY block on Google Tensor SoCs.
>
> Which ones? You need to be VERY specific here.

This USB PHY is specific to Tensor G5 SoC (and future generations) and thus
necessitates new drivers and new bindings. Will update the description and
commit message in the next patchset.

>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - google,lga-usb-phy
> > +      - const: google,usb-phy
>
> Please read carefully  bindings. You cannot have generic compatible.
> Plus you are duplicating existing Samsung bindings.
>
> Best regards,
> Krzysztof

Will refrain from using generic compatible in the next patchset.

Thanks,
Roy Luo

