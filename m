Return-Path: <linux-kernel+bounces-871349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2EC0D007
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51E7D4E411C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA72C2ACE;
	Mon, 27 Oct 2025 10:45:29 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887617464
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561929; cv=none; b=sV61la6YO7LvllAihR39iAy/t1CpaNiHccIsXQbfqZm6YG5YyuBt/AYeHiCckNOPwNtAj5pHSg2JEVIkwFezWgQCronRQkS2qoYWefcAsaMrkS3sjx446vHsuQtKv3ryjYCT3gIRvqKQlps+ocXQgaJsVbY+pvpX1Ymjk3Hm0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561929; c=relaxed/simple;
	bh=WASv8vPf9FPyquyQDbPoOdROvffB+ReSLfQNpiWjqIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IegrY/rMauPcAYtwvEwd7OQnvEmTMp+18mOqp13TnarNOM2iIJZi69g0M/8er5j3m3ft9XOgTGOqgcjfk0LGmEv0aZ7o3vwwkLBAxsszvfPHFSwrO+WPQQyVPPWk0Tr4VJgDsODYH4DFtBUnnBRQD/ZF3XdvvC4AR7zURW3zQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so3428214241.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761561926; x=1762166726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFi78x1MtIeYqpVCKC1DBSPNonZlJu7dJLYb6jM72vk=;
        b=pE18gbP4CsoijuGt5dbaDyFGgxbbBnrUyiPk60EBvA8sTfA/iY1NThdqIg7DcgYsBe
         n6mgoXyeOFNdeqstmaXttFYsIJaoAcieZhcbR3UmWKmDxBdPmVh82LLCTqK2fjejMmlz
         LmJKHvpmIbhjF4zPVRLi6mVfmPrFSKaNybWXa92gUV2elukUfIBk+KggFPO3piQC7idO
         NQC6Y4Hwrmdy+7Tpi58YXi/e9Lpqa5IeRipULLFisKPFfS/pt6VRFUKQje/NB9WKNwWv
         aW61fG+M5+S0OayWdggtv+/F5q31eW/If/hL8mIrZPCTBwdHQ5SvYqW6GCS2mClqLfnV
         L2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcPgpw4DvcdqfeIKPDpYW/laTJy0MdeI22I65nNYubOwui3HvAUUjxLAFEMXqOhhMvnKbEtz9AGGpomqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt18lfZPrxVIKaBqkvT2CIt2Gmao1GZM+73mjDJ3C1W3w6m7u
	h7rORXPl4pFBX7/YeslSJUaTaaNXgOGa/i5u7UZvHIVUMB95E6UHMDug4fhqn/Mi
X-Gm-Gg: ASbGncvbT0rL+9yuc6Qc0rPQo79WK/8l/7FD7Jqsjy4YDidxAngiwde8N/iNX1ghMIm
	W61OQdc+sCLJakH+72mXNc2uGVqfbfEAH8X2ASOG+IlBU5Z8p0NXepLcy9rnrh5iz3wNP0qeydz
	Ct9ls5+274PdXLBhzqEkLxLFw5DOTzEoRqKVaG/tn7G/YA0AoiQjcMjG8QH9/90blqyv6+b077Z
	YP1DN4dKxeg66oot6715T00ZR5XgzSk//Y89Yr6f1XeBlFd9bonsmm/rVRGDbFZpo5CMLEjI0v4
	3oPB/bVwo1g9NEyRWTAvnse+WKXbCGvpAtmvM9s79trLhjV7gbEwgdm71JdA7hXonY9P97TeWyY
	fS2g/yPxp7vLx9+yn4Q4oDI2eV6hFiaJ4yiNL43zCEFAdBwObwXFYBPzSxW4+vvddak5c0cD14F
	ulNSwExVCmFuT4RbfzE4DGITL7VDcbM14FGtUYOQ==
X-Google-Smtp-Source: AGHT+IGncIUa+rfAptyrvmiDhIl0Ge7MEr+KAjwcIW1PPZlpQC9zEP+tw3cb7mCc7YCE1XUwEvClug==
X-Received: by 2002:a05:6122:1693:b0:557:c538:699e with SMTP id 71dfb90a1353d-557cdb38845mr2763642e0c.5.1761561926118;
        Mon, 27 Oct 2025 03:45:26 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddac1518sm2837688e0c.0.2025.10.27.03.45.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 03:45:25 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so5242754137.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:45:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2+CyupWnlQvr7q2JuhUjm1HL2W0Q9ow75W6gXY8aaTJ7q0t57wa0bKqvMUqcccBq4LkiC7bhoJzo0REY=@vger.kernel.org
X-Received: by 2002:a05:6102:30d2:20b0:5d5:f6ae:3905 with SMTP id
 ada2fe7eead31-5db3e25962bmr2803354137.22.1761561924836; Mon, 27 Oct 2025
 03:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 11:45:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnn-hFWk4Ur68Qi3gdEa85bXZjpybdjIi4iorAZW0HIZJSSUE0PNnuk68o
Message-ID: <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 10:20, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
> peripheral with controlled by a module clock.
>
> The TSU module clock is enabled in register MSTPCRG (0x30c), at bit 7,

MSTPCRD

I will fix that while applying.

> resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

