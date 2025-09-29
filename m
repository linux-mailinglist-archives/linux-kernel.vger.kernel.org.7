Return-Path: <linux-kernel+bounces-835940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38ABA8664
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529AF7AFA27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA623B638;
	Mon, 29 Sep 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpXqMdPh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCC1E0E1F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134653; cv=none; b=FATC07GOuLUx8hfEg3CWjUGQ08wIqOoJnlqXEYYUxD8BNdPkLitNh3C6WJ28wqGk/5pKWovC24IyjWwqvqu+nozWwy64l1Jy4IalnBa8Yokwcbm1gL7vizPvX+RUvmEGmQ1EAro1umqrXvle/Es5cIxzVNgF1fIa47RYo4VNOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134653; c=relaxed/simple;
	bh=1yWrEi955nPPvBu1m9KwQaY5HyLcEXUxbZckZNeDmWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKOfVQpACF2/q6nhAMdqIq9ObcHtSmH1DT5/V7MzeymDiDSXfC/4ymNV5oFOi3ym1Wl9a4vb5xmIvCAA3SNClossuQP8kLGuMTGV52MH1bLjANKCzu59c9kAWhgxThBsapA+Ta3QZSnz5zU6My8xFSGmIjidjHtwVOztbd1e39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IpXqMdPh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57b35e176dbso5484664e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759134649; x=1759739449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJONDUXJa/G+AY4kgKaGSYPSvsqZ+MAfDWA2lmXRRpc=;
        b=IpXqMdPho9g6CT24o5ZwTclNZciefBRbPeuJYlYGsGM0zMrolwEGdMMBNpkIeY5Cmr
         jiL14FFLtOZbSrums49rO0jTa5tovzbezmPVQPFsRlnzI286KopVySdyDXjcug/HpTV5
         YQ2iFwnqyGDI6FsogC4476jbaBgshaY1vrc8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134649; x=1759739449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJONDUXJa/G+AY4kgKaGSYPSvsqZ+MAfDWA2lmXRRpc=;
        b=mF0/9KXuViyNyB+IV9N19SHGPpvlc20U/3heAl/w2Ul2UVyZhvG2P77EipBeFrjw0d
         Td7p91K5g+sLKJtR712dEVq2oI735lfuf+frsaNR5WQpuY4E8+Omz7a/TxPHFHoiwjIM
         lyXnDmHF2O0IF/pxQbEZE+idtDvK81yzHwxpeIfg+aYy2SGg5Rlulv3gj4RNgNyweDym
         aawsiwZ0f5YIJgFyEUEX+nfR4fNPT7+ua6rb5PC/kteUKxEN3LR19agU7GcRCgp7bRwt
         d+FAApfWewcaMXJnBDNq+uV/hlImVtTzh9YtPJUXecT+riUFc+wuuoOcyXpu2KsyX/5X
         9Gxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPbwyfHjkwQXRWH6xRCYNSgn29ttpx1Iv9BdZyRL3OStMgcuuNx80k90194PIF5PKzyr3t3AgHQS8a8hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uq/fo7UncdYiRDC+kKMkecG0nJb/y5JRczUqT+TZEutnTgn5
	5aT/w7fyu4Yod32eYV+vjyaLDkC3CzHB2MIVLBUgh/V8Wj50FehBQ+l1cLPIxqWpyF4vHO0e0oE
	75+A=
X-Gm-Gg: ASbGncs7ZjrCeHDY+Gv9raOCpvXlZweXweSWuGLmn3SWNsb9sGunnkQg2/HnxNM0DD1
	N8uoFBUQY+GRHBcRK4pj67lX5UejOmw4QEGdW+l+PlYoW032E7q/PssP92DDdrAJ8XpiD+IqNN3
	8gjYNnORdtXtbrQSRuKbdvvcfMo661b79jmexHAJ+zv98Xre2oS/uCX68pjSqdR2IaFDIe2iFPH
	Fb9+YAK+1ZlAgZNNg2JzvwlSAxKT8UtBxsARfSKPHYzO+PijU4kY8k6/zxJ/6o+76/cNqpasCLX
	FPgIdKVxyToneRvLXt3hU8jrfsZtS77S9Jml6DmI+EikLWDBlDMAi18b0jxXCprE84MlZXCJSqt
	UBvRWsBJaseJpD0vT2ZqVQNxC2Cn2npT8sQ7QuhokCQwPb8D8hr3xnZxp5ka4
X-Google-Smtp-Source: AGHT+IFY8f53bhuFKHwdQLMsUw1LFgSd4t8TdA/h42AYdUgMuJvViNZVWrOqV3d5lfTLqOMDWL68sw==
X-Received: by 2002:ac2:51c4:0:b0:581:88f7:5342 with SMTP id 2adb3069b0e04-582d481b96fmr4100643e87.53.1759134649056;
        Mon, 29 Sep 2025 01:30:49 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-587efc15ea5sm595948e87.12.2025.09.29.01.30.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:30:48 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b35e176dbso5484625e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNDey8jrusmzSEt6qZIEA8J3tGsOq/V0TTfiOvivUKg+rp2VJKb/MVKKE33pLyZtktR1wJkVHgaOwZpQM=@vger.kernel.org
X-Received: by 2002:a05:6512:1102:b0:57c:2474:3740 with SMTP id
 2adb3069b0e04-582d3f76e30mr4820322e87.46.1759134647732; Mon, 29 Sep 2025
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
 <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org> <20250926-mute-boil-e75839753526@spud>
In-Reply-To: <20250926-mute-boil-e75839753526@spud>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Sep 2025 10:30:35 +0200
X-Gmail-Original-Message-ID: <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>
X-Gm-Features: AS18NWDuABHOrlsFlY-rDCN1sMikoapkz5ecsd4Y1lKthbQuEsgF6GxQRq0htYQ
Message-ID: <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] dt-bindings: media: Add usb-camera-module
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Conor

On Fri, 26 Sept 2025 at 18:55, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Sep 26, 2025 at 01:11:31PM +0000, Ricardo Ribalda wrote:
> > For fixed cameras modules the OS needs to know where they are mounted.
> > This information is used to determine if images need to be rotated or
> > not.
> >
> > ACPI has a property for this purpose, which is parsed by
> > acpi_get_physical_device_location():
> > https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device
> >
> > In DT we have similar properties for video-interface-devices called
> > orientation and rotation:
> > Documentation/devicetree/bindings/media/video-interface-devices.yaml
> >
> > Add a new schema that combines usb/usb-device.yaml and
> > media/video-interface-devices.yaml
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/usb-camera-module.yaml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e49b72ae6584deb0c7ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: USB Camera Module
> > +
> > +maintainers:
> > +  - Ricardo Ribalda <ribalda@chromium.org>
> > +
> > +description: |
> > +  This schema allows for annotating auxiliary information for fixed camera
> > +  modules. This information enables the system to determine if incoming frames
> > +  require rotation, mirroring, or other transformations. It also describes the
> > +  module's relationship with other hardware elements, such as flash LEDs or
> > +  Voice Coil Motors (VCMs).
> > +
> > +allOf:
> > +  - $ref: /schemas/usb/usb-device.yaml#
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
>
> What actually causes this schema to be applied? Did I miss it getting
> included somewhere?

I guess your question is why I have not defined the compatible field?

I tried this change[1] with no luck:
/usr/local/google/home/ribalda/work/linux/Documentation/devicetree/bindings/media/uvc-camera.example.dtb:
device@1 (uvc-camera): compatible: ['uvc-camera'] does not contain
items matching the given schema

I think it failed, because If we add these allOfs as Rob proposed
https://lore.kernel.org/all/20250625185608.GA2010256-robh@kernel.org/:
```
allOf:
  - $ref: /schemas/usb/usb-device.yaml#
  - $ref: /schemas/media/video-interface-devices.yaml#
```
We cannot (or I do not know how to) have a different compatible than
the one from usb-device.yaml


Any suggestion on how to do this properly will be highly appreciated :)

Thanks!



[1]

@@ -21,10 +21,14 @@ allOf:
   - $ref: /schemas/media/video-interface-devices.yaml#

 properties:
+  compatible:
+    const: uvc-camera
+
   reg:
     maxItems: 1

 required:
+  - compatible
   - reg

 additionalProperties: true
@@ -38,8 +42,8 @@ examples:
         #size-cells = <0>;

         device@1 {
-            compatible = "usb123,4567";
+           compatible = "uvc-camera";
             reg = <2>;
             orientation = <0>;
             rotation = <90>;
         };

>
> > +required:
> > +  - reg
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    usb@11270000 {
> > +        reg = <0x11270000 0x1000>;
> > +        interrupts = <0x0 0x4e 0x0>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        device@1 {
> > +            compatible = "usb123,4567";
> > +            reg = <2>;
> > +            orientation = <0>;
> > +            rotation = <90>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff488456ccd7305cc74ba7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26258,6 +26258,7 @@ L:    linux-media@vger.kernel.org
> >  S:   Maintained
> >  W:   http://www.ideasonboard.org/uvc/
> >  T:   git git://linuxtv.org/media.git
> > +F:   Documentation/devicetree/bindings/media/usb-camera-module.yaml
> >  F:   Documentation/userspace-api/media/drivers/uvcvideo.rst
> >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >
> > --
> > 2.51.0.536.g15c5d4f767-goog
> >



--
Ricardo Ribalda

