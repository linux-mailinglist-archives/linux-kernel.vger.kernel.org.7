Return-Path: <linux-kernel+bounces-867848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87DC039FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129913AE959
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FA17C21C;
	Thu, 23 Oct 2025 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tA6lyhxf"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF713D3B3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256538; cv=none; b=aMIbJpPIgfTb2Mpw9vyCVwdJ/gHVq0L7qQGVpB305q8a8BpGWa9uYOOKw6xli2RELRixp7TKslKLZqws1Vc9WMSR8e7AHIIDQD3syDShtV9AwerUsXUKEk24MFpWJXsIujXPQmrRoJlA+HI3dIhNNEJ57W3A3O9hzbZPZWt/M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256538; c=relaxed/simple;
	bh=cog6S/R0M1m6Oqk0Kk2myV4ppTBdZBk+i/lE1k+LB6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9BOpMZVy0P7paKzC3R1oLCEO2op7AaCQtcRrK50O9TLwwg8lLzQOUx1S6O7pbgfkQ/qjsOFaHUzY7RyNl84K+hkALv6lB3g0etjzk0zGJp6GmplaxwCRk9O0dPPz0Tl6Zt5kq9skaLTdpsZfeIapfDTR8f7tvErh7qbBv7PYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tA6lyhxf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-794e300e20dso2316458b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761256536; x=1761861336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyDCy69Q/3azt6BaC0jOoV9WgJt8g3WAXELT1WMNnq8=;
        b=tA6lyhxf1EzZb4irJcJFuvS8i0lkN5hHIoG0dS3Fs2QwrNpgtnslTVraXiDGA6Uubj
         7h+aGj1Ad7bouuXRc4RfZC12kjPxr0TkCqJFpsWxDzH+s0/4s9Xn8Yv4dXPtVjDAMS0R
         DaKSARzs4sesU3f9AFh6E2hIb+Nm7sbcB2NC0h9DnkRNnfVKg1PQBIIOPZ/ADkfKCwMn
         NxvgJ5LGnDp0Fok1IPwrKMvrPUk440jZVEGHZxXYtKhzf+On7IOhoeroZIGCFFWZpLAc
         P6Ed20pElUkZINhUMWm+a2FP4atAshBG9ItEDuLG71PShVS+/tNYcYjiDEnEAPupBblo
         hy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761256536; x=1761861336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyDCy69Q/3azt6BaC0jOoV9WgJt8g3WAXELT1WMNnq8=;
        b=D24Hmw9btZIK7Q3HWUVyiWxgzPyYpZHCG/NQHSlzmg46pI1t3jGqADTWI1ekdY8HIt
         e9QudWnFDLYtk64NVnRvwcRWLlrEt87Uo3IZfIue97mbZWXtiwMJQsuyjHjjMt483e7Q
         2a/bFs3NkdU80X5Z1lUnqKPeUUnye6Vd8FfZYuCs/Yeh+HxKRBubFSKfns/Yje/VS3it
         SwCj8ZvY+WuSyssmzol6idhHiDgYp46R9PKN9BitII/9JeaMzpMsVNO3GKY82IiTMmqO
         y+TVPALOPtHaQR/cGV9JOCtkGVG0XNwhhAOcvRTo3JyRRNX70pKhLhYWaqp2eIjyimf3
         p+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwIi/zpax+zxYodwQcMJ8v06C1kO8bxibi6rJKmKEydQqQjhXS8QFSCMd8cETfKNF01mzo5LaCSSB633s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQ7aug4zemFI6yIVB+12aVoJm3iwmQu3GV82BwUKP0luaTdnl
	QwFBzmw/ODtpilHaRCxgr2XKz7TLhLdVCal7qyIIKSWz7n6ePr9QVzxZCqOfIQVVvlYh1AZBQp5
	y5pPU1B2H4XQMkI/uSVxOPKxES/izboi8IwG4Ipu9
X-Gm-Gg: ASbGncuB3J9RPKgrEQk3AYvp6d/wmTxED6VRCMXB9ZOYXG797teZu5W0MsjJOdrf74I
	CYU8eEI+GEbYRMIvxkfsI3ylaXvhYxhHHZ/ADeYiLEpqQ5FTJDcQVdAkQoQsYC5n/er/k8XfS4A
	LPBxHVwwVeUSdNQ/ibjduuCmMV/jy7ly/xSL+GN/npAM+klW+GervkVKvgX50jvD1j8K1GNBGKY
	DKfpWaDr4hfztT+qPlH2TgWdY+o5J++Ut9wjFkEPloStDkYzXlMPAyoFNsRSC4eDWr/VvJerOdC
	dYYvdOI3IYv3+dPizRrIdRZmdg==
X-Google-Smtp-Source: AGHT+IEqbJRbROlu/bm5j7ru2eVdv2x6DLq7HzQUwIw+dlex2w8ixWSRMneuISkc9NPo7yYqi/7YRgyhlNDhmAvraa4=
X-Received: by 2002:a17:903:1ae4:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-29489e60c01mr3502165ad.27.1761256535858; Thu, 23 Oct 2025
 14:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017235159.2417576-1-royluo@google.com> <20251017235159.2417576-2-royluo@google.com>
 <20251023-collie-of-impossible-plenty-fc9382@kuoka> <698ba0ea-3367-4fc0-bd4f-0177283c2e77@kernel.org>
In-Reply-To: <698ba0ea-3367-4fc0-bd4f-0177283c2e77@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Thu, 23 Oct 2025 14:54:59 -0700
X-Gm-Features: AS18NWDaD_LUo2BMw-kgQvNid_X2lR-GtxBED31qsEqmuEgC28zy2xECKsvSUZI
Message-ID: <CA+zupgxv9h1jOW=Jnx29yJJQBHOqBrY6tSBhoUaLb4eYuXhW7g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: google: Add Google Tensor G5 USB PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 23/10/2025 08:43, Krzysztof Kozlowski wrote:
> > On Fri, Oct 17, 2025 at 11:51:58PM +0000, Roy Luo wrote:
> >> Document the device tree bindings for the USB PHY interfaces integrate=
d
> >> with the DWC3 controller on Google Tensor SoCs, starting with G5
> >> generation. The USB PHY on Tensor G5 includes two integrated Synopsys
> >> PHY IPs: the eUSB 2.0 PHY IP and the USB 3.2/DisplayPort combo PHY IP.
> >>
> >> Due to a complete architectural overhaul in the Google Tensor G5, the
> >> existing Samsung/Exynos USB PHY binding for older generations of Googl=
e
> >> silicons such as gs101 are no longer compatible, necessitating this ne=
w
> >> device tree binding.
> >>
> >> Signed-off-by: Roy Luo <royluo@google.com>
> >> ---
> >>  .../bindings/phy/google,gs5-usb-phy.yaml      | 104 +++++++++++++++++=
+
> >>  1 file changed, 104 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/google,gs5-u=
sb-phy.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.=
yaml b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
> >> new file mode 100644
> >> index 000000000000..c92c20eba1ea
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
> >> @@ -0,0 +1,104 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +# Copyright (C) 2025, Google LLC
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/phy/google,gs5-usb-phy.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Google Tensor Series (G5+) USB PHY
> >> +
> >> +maintainers:
> >> +  - Roy Luo <royluo@google.com>
> >> +
> >> +description: |
> >> +  Describes the USB PHY interfaces integrated with the DWC3 USB contr=
oller on
> >> +  Google Tensor SoCs, starting with the G5 generation.
> >> +  Two specific PHY IPs from Synopsys are integrated, including eUSB 2=
.0 PHY IP
> >> +  and USB 3.2/DisplayPort combo PHY IP.
> >> +  The hardware can support three PHY interfaces, which are selected u=
sing the
> >> +  first phandle argument in the PHY specifier::
> >
> > Just one ':', anyway this sentence and below does not belong to
> > description but to phy-cells. You describe the cells.
> >
> > Or just mention the header with IDs - here or in phy-cells.
>
>
> If you go with free-form text description in phy cells, then some
> example could be:
> renesas,rcar-gen2-usb-phy.yaml
>
> For the header (in this case clocks):
> display/msm/dsi-phy-common.yaml
>
>
> Best regards,
> Krzysztof

Krzysztof,

Thanks a lot for providing the reference!
I will go with the free-form text description in phy cells following
renesas,rcar-gen2-usb-phy.yaml in the next version.

Thanks,
Roy Luo

