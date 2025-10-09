Return-Path: <linux-kernel+bounces-846255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7CBC7669
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 771244E3963
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08BE255248;
	Thu,  9 Oct 2025 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDh69t0+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F32556E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986396; cv=none; b=t5F34U4hAJFmKfy9cIDAWzWq+nxuA6k3tyIStZSrjns05oi5/iwTWtnpMWwKEPKxNPG3oeYWib6hroLs8LqvyuSWj7b6vaabXZXmRAPJ9EodKZbIMU599ejj2amXiwuQUldZB1WzEJNQ1ToXLaVgu3NxBXWlKtKccRjFVsZvpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986396; c=relaxed/simple;
	bh=KGYbVj0SYA7csaFCm338RExp7YkFD+VQLtFHDm1WmW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7kCvAqL8NnTrWvAr8vbGEc5ACKjUCJ5wkB5bFT8Ir1AcmIWhm5uoPdpmGL+2AuG7RZY4qbk/EO1QYpM4G3gwzgMbT14qTuil0nxXcIzVo40tZrQTsgyw8PK1o5PRz/MvCTitHaYtzD/eKCcg0iYv9OXZq8i6eOPEqTwAxGxLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDh69t0+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2e363118so4119825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759986392; x=1760591192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdHEjQxG+FatWNW5/zKqLPCIUyKLAYeWhQuCe1gPWoU=;
        b=YDh69t0+rmwsfWzTffPUN//wbJVma9c3310fGP1Bhbvb0WWNeI3A90enu9hpgTl6to
         CJqDUF2juBWsjfl+o5oTmqlYFfrhJV88DDgmYK+Yjft07zF+jDYYh1q01Ord54hz0y2l
         DW9yoVUy2uNH9fxMalRPW4FSj7qledjQ88fMKaMsx6Dbl6+AZhRLdixDgA6Jb6tOlbSJ
         Qn/gtToySWed6AQwe/EhGiv1xRIfZgFreAcFUlWaKhOm9FcNfXKzpQ2fMM31RzlN11LD
         dWQ618/qYs3T1NPfZM2JVeVB2DHpWWaxFKFWDlr3B8FHoQIC0a0f6Ysjbx/3FzbOUk3a
         HuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759986392; x=1760591192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdHEjQxG+FatWNW5/zKqLPCIUyKLAYeWhQuCe1gPWoU=;
        b=XZs58Z+82a/HiQY1VE7H68Mzd6VSep+6r9PRbLqHybNqaVu1YafV8vkn73+x+ozMad
         tnj8p7oiGkEih2JJnwhKJ2CIntfbJNRX3H15cUOZnd8voTosJnCVcIkvOl1Y2aap98Lv
         oxE7LHm8QZwSO6nmUJgooObSiJjdwkQv3sWorhwFomQFgfvXMuPGCbjcK5UrlMTBnyGB
         ywABSjLmyvkK9jopcS14K8WU4Othrre/MxhzH+mhDjXqK94tZ/oEtayacNiELLigFCv0
         NxexU5eK/zfC8g5C5MYQh1FnD3M4C48ztCdO8K2Bw6K4P2YKdQ5TN7KZ4MpI4knKxt2j
         zRRA==
X-Forwarded-Encrypted: i=1; AJvYcCWylFQVyIcezN9JSszYFt5oPvS1ii6Y6cgJ2mbBOzklwrk5WT7eqnKdth26j1SvB2JbPWTuLTjeZ5yElF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn29ZksFIRp9/XJ1WbKref3hTRe5Yr0HqGDLvk8OZPutMMHcD
	b8vm3mXUX533iMZP0xt2sRgIwGIssUShKsrO/kgrVnLm+EgxFSX/ddZpMzoc8TY2b8ab8LQOFbF
	+tqO8OsO/tv6XYGEO7HLmGYSwe2vCngU=
X-Gm-Gg: ASbGnct+PqQO0Lmd92pV11WPYH6cG6y55rrOCpaXUaSJ/be0XfXi+1Dq9F04919f0Ad
	8lhuDl8G5N4MYeNSb2qQzl02fo20gQ0hKAiU4beX6pjTDC+CfIPeigcoLAwbJcvY3DzZUC5sfDt
	FVrgBUURd486BJfSW06eWGbT7s53/+wWShR/YbSuYB+nt4EvZ8NEzV1bCjPfMzpD5IyF9NyWwSS
	aMu3KCbQ+7TAhJwHGHqqOTY+gFrFRNt
X-Google-Smtp-Source: AGHT+IHqYRmivewqb9zg+yu8zGgOx+vqqkeXoxUzMI4NUKSxwIhgIh4uZTenWgZghGln5muMkEwQ0EmS5xQOqziJeM4=
X-Received: by 2002:a05:6000:603:b0:3ea:4e8b:c96a with SMTP id
 ffacd0b85a97d-4266e8e64e4mr3654211f8f.57.1759986391521; Wed, 08 Oct 2025
 22:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008082800.67718-1-clamor95@gmail.com> <20251008082800.67718-2-clamor95@gmail.com>
 <20251008-safely-reach-9274474a2ec8@spud>
In-Reply-To: <20251008-safely-reach-9274474a2ec8@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 9 Oct 2025 08:06:20 +0300
X-Gm-Features: AS18NWC-fQyHK-rMvVxkxqV6S0I7hbIVFXE8xA55zUXu7V0ibTLESXEQf_mVWkM
Message-ID: <CAPVz0n2pbAS3Qjm9WQGvcuJhkNnyjGCyJtVi=VMuUgPoQNE+wA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: display: panel: properly document LG
 LD070WX3 panel
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Douglas Anderson <dianders@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 00:11=
 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Oct 08, 2025 at 11:27:53AM +0300, Svyatoslav Ryhel wrote:
> > LG LD070WX3-SL01 was mistakenly documented as a simple DSI panel, which=
 it
> > clearly is not. Address this by adding the proper schema for this panel=
.
> >
> > There is only one user of this panel binding in the mainline Linux kern=
el,
> > which is the Nvidia tablet Tegra Note 7. Its panel is broken anyway sin=
ce
> > it cannot initialize properly if the bootloader does not leave a
> > pre-initialized panel. It also cannot suspend or re-initialize properly=
,
> > since no DSI configuration is set and it has a loose regulator which
> > relies on an always-on property rather than being hooked to the panel
> > where it belongs.
>
> I think this is a reasonable justification. For my own enlightenment,
> what happens if a new kernel uses the old simple-panel devicetree?
>

Since regulator framework provides dummy regulators and compatible
matches, driver should probe correctly. Panel should still work with
unpatched device tree until disabling unused regulators/power domains
kicks in.

> > Tegra Note 7 device tree is adjusted as a part of this series.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/display/panel/lg,ld070wx3.yaml   | 60 +++++++++++++++++++
> >  .../display/panel/panel-simple-dsi.yaml       |  2 -
> >  2 files changed, 60 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,=
ld070wx3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx=
3.yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
> > new file mode 100644
> > index 000000000000..0a82cf311452
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3.yaml#
>
> Could you make the filename match the compatible please?

Filename matches compatible, -XXNN after lg,ld070wx3 indicate
revision. I have found at least two more -sm01 and -sh01, but since I
was not able to get datasheet for them I cannot say for sure that they
fully compatible with this schema.

> With that,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LG Corporation 7" WXGA TFT LCD panel
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: lg,ld070wx3-sl01
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +  vcc-supply: true
> > +
> > +  backlight: true
> > +  port: true
> > +
> > +required:
> > +  - compatible
> > +  - vdd-supply
> > +  - vcc-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        panel@0 {
> > +            compatible =3D "lg,ld070wx3-sl01";
> > +            reg =3D <0>;
> > +
> > +            vdd-supply =3D <&vdd_3v3_lcd>;
> > +            vcc-supply =3D <&vcc_1v8_lcd>;
> > +
> > +            backlight =3D <&backlight>;
> > +
> > +            port {
> > +                endpoint {
> > +                    remote-endpoint =3D <&dsi0_out>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simp=
le-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-=
dsi.yaml
> > index 9b92a05791cc..f9f1e76a810c 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.=
yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.=
yaml
> > @@ -42,8 +42,6 @@ properties:
> >        - kingdisplay,kd097d04
> >          # LG ACX467AKM-7 4.95" 1080=C3=971920 LCD Panel
> >        - lg,acx467akm-7
> > -        # LG Corporation 7" WXGA TFT LCD panel
> > -      - lg,ld070wx3-sl01
> >          # LG Corporation 5" HD TFT LCD panel
> >        - lg,lh500wx1-sd03
> >          # Lincoln LCD197 5" 1080x1920 LCD panel
> > --
> > 2.48.1
> >

