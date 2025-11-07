Return-Path: <linux-kernel+bounces-889742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89EC3E61C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DFD3AFCAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE382FBDFD;
	Fri,  7 Nov 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ8yOBBr"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468AC2F7ACD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486787; cv=none; b=nOvBMmJ/7Sj2knkkV4HvmTQWz//5bud6l9vo1i0ZLQdj71cJ3O5vv9vMlHeZMgMXpBjrMbw3hXygqNx8uc1MQARLe6Tgjeq1bW/jiOL8P01ex4GUPpwcp4F/fIYNa8DLnDnJ5ZL6CyswGhbGYBJgCkdV09oZAlSQADKXfoQdyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486787; c=relaxed/simple;
	bh=hYOeoqXmSEIDHI78r81gIByIxvqycJsoQtqBa4+ZRmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkEDSCpxg985GPHS+hpZnVTLbV82llNR7nMi0UmmYWyrhVPOk/4Aw7MNw3llGVfhoRBSxEsBUOlPQuvor2wsQmQqLIxOnJutJIAAWx55xT8bsLe6+P/S3fdQDNov0BprOxaz7zKmN66LSYzaF8meTlpHZN78zs5Wp4CcXa6ujaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ8yOBBr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429b72691b4so225510f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762486783; x=1763091583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbO2nTB7Qh4Qw6JsJr6W4VgsgC2mZidOm7iZWG0m/78=;
        b=WJ8yOBBrnDqu6KHDZuK5drza3tRu8dVg+rG/hNmICmNCO7dTU5mxoekLGBCanXKqVt
         dSssoBFTwMGKUoUKMAGKrzfW/qD26TU6CIRYw8s2Xm53rOzoCJLFhf7208RpAbVq3Uzb
         cwO94UjgK45X3edusQNOkkrHHC7VKWhpPQ/Qvozd0/llLpABPdrZyVy3tyB4rmF3F81I
         TOAeyf07UQl1kRyjW8xINXC62Vd/Buimph0xroSV8A/9rK3JoTWB4ohfDTqAw+RiSP7N
         ZiExonkST1QmcySFfAUIqUBStH2YZIzTpM1eW5j9ID+bgOwoHCqRgf8CF3qr4R/aPvs/
         PYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762486783; x=1763091583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbO2nTB7Qh4Qw6JsJr6W4VgsgC2mZidOm7iZWG0m/78=;
        b=iFmaBOsasjch6T5GpUVizZLdy7WCspxqfRcYGuT8ziSBbnSRONqh2v6ex+6hYBw9tS
         8pxeHtPcuDI/aumsyWal9NTOXmty6+4oYb0KZa035zQvOwr8wLV6ojJAdulcejI/IU/y
         297LuIXECLhXZK3tJhkQDsY8ydkkGSfy60A8aGdVXC0cgEmi4UwmnSfck0gRdHDlErJc
         lNnMSqxASo0EVhi+DRggZZgXeihVIme3L+myidI04LOQO0DgJHkNT2ER7omhbhG6nHDy
         ySaRw+TnFW8RkQzvvIJTbVIjNHWCffGZUUCnsvAJvLVZVYI8JNR+UVO4ulVfRj9zJJh6
         FP1g==
X-Forwarded-Encrypted: i=1; AJvYcCUqKPaw9cIpGIT+LKmXVPCn28zikn2vzwP1eFFbhAlO+rty+KEqOK8KxZwXB73iFTjjyjd7ZpdFzboVL8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6a6RvIMPvftsp+6xUONr72h97J2tYVbl1mW7vvmukSuTI6K7
	J2I6hSP2futvqNU3VwS+QAp+wP0WK01TLnBiibJX3CeBF8bkvm0p9OlGgMv1kurfgREd+j5Fygo
	TzHaDmieK22uCtcZHxlEm9NP1QElQymPoe/TgrT8L
X-Gm-Gg: ASbGnctrQ8AufGYQUhBeCT5vw0njJ5mYJauszzEHp09dyH+77qUPBvDuahZirg+tPFE
	Bs2Ty5fUUrrzT2Bm3o8uconAhFLomfKcraOvrSNn3vc2jRobwqDX3aJBqzRP64aDSTM6nXopb+3
	9Hqi9c/sKn9KggcyLzs+wVvw2uVIxnl4lCGPE2M1JSV5/6lQ+S7rmfrvykx6dYBLngGMjSrjXBT
	4I2urNwyTw2nDPwlNaQk9WCUsVCw1yyW4MX7NP4FhkXzDOQq98Wdglly4hUr6RgwRfZGCwUB+v8
	TkQSzyOo3zWPs2inXeuXrt6g
X-Google-Smtp-Source: AGHT+IGEh7IhvQg+TrDD6zZjcWzRpXTsExEgfoQszOkKmBt1xXGm8ca7e3AYQMZfs4zZsYumxirBfUxPg23Zvt75ckw=
X-Received: by 2002:a05:6000:240a:b0:429:d6dc:ae2f with SMTP id
 ffacd0b85a97d-42ae5ac513dmr1043717f8f.31.1762486783011; Thu, 06 Nov 2025
 19:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029214032.3175261-1-royluo@google.com> <20251029214032.3175261-2-royluo@google.com>
In-Reply-To: <20251029214032.3175261-2-royluo@google.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 6 Nov 2025 19:39:31 -0800
X-Gm-Features: AWmQ_bk0tg9nfbEFrAczn7gf3WHlPnE4d6lMh6R1gsb1gSV599Sr46OpKQ3eUsM
Message-ID: <CAD=FV=VYOD=33secA=2ozE8EO6Z_Wi_ZjiDMov5oP8Z42JytAg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: google: Add Google Tensor G5 USB PHY
To: Roy Luo <royluo@google.com>
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

Hi,

On Wed, Oct 29, 2025 at 2:40=E2=80=AFPM Roy Luo <royluo@google.com> wrote:
>
> Document the device tree bindings for the USB PHY interfaces integrated
> with the DWC3 controller on Google Tensor SoCs, starting with G5
> generation. The USB PHY on Tensor G5 includes two integrated Synopsys
> PHY IPs: the eUSB 2.0 PHY IP and the USB 3.2/DisplayPort combo PHY IP.
>
> Due to a complete architectural overhaul in the Google Tensor G5, the
> existing Samsung/Exynos USB PHY binding for older generations of Google
> silicons such as gs101 are no longer compatible, necessitating this new
> device tree binding.
>
> Signed-off-by: Roy Luo <royluo@google.com>
> ---
>  .../bindings/phy/google,gs5-usb-phy.yaml      | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/google,gs5-usb-=
phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yam=
l b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
> new file mode 100644
> index 000000000000..8a590036fbac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2025, Google LLC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/google,gs5-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Tensor Series (G5+) USB PHY
> +
> +maintainers:
> +  - Roy Luo <royluo@google.com>
> +
> +description: |
> +  Describes the USB PHY interfaces integrated with the DWC3 USB controll=
er on
> +  Google Tensor SoCs, starting with the G5 generation.
> +  Two specific PHY IPs from Synopsys are integrated, including eUSB 2.0 =
PHY IP
> +  and USB 3.2/DisplayPort combo PHY IP.
> +
> +properties:
> +  compatible:
> +    const: google,gs5-usb-phy

FWIW, we've had some rather heated bikeshedding at Google about the
use of "gs5" to refer to this processor.

* The processor is almost exclusively referred to as "lga" in code at Googl=
e.

* The processor's code name is "laguna".

* Nobody is aware of the processor being referred to as "gs5"
internally. Though this is the 5th Google Silicon ("GS") processor, so
it makes some sense, "gs5" is not really an official name for it. At
least one person pointed to the fact that it's a tad bit confusing
that the first generation Tensor processor is called "gs101" upstream
and the fifth generation is called "gs5".

* Some folks proposed "gs501" to match the "gs101, gs201, ..." trend.
The first two Tensor processors were definitely called "gs101" and
"gs201" and the next two were referred to as "gs301" and "gs401" in
some internal docs, though this was discouraged. The processor in
Pixel 10 was never called "gs501" internally as far as I can tell.


In any case, it's a bit of a mess. The straw poll I took seemed to
land on "lga" being the preferred name to continue to refer to this
processor in upstream code. Would it be possible to change from "gs5"
to "lga" here? The "laguna" code name for this processor is well known
publicly and it's generally quite common to refer to processors (and
boards) by their codenames, since codenames are often available sooner
than marketing names and also less likely to change. Indeed, I was
even CCed on a change recently where there were plans to move away
from a processor ID and back to a codename [1].


[1] http://lore.kernel.org/r/20251030-rename-dts-2-v1-2-80c0b81c4d77@oss.qu=
alcomm.com

