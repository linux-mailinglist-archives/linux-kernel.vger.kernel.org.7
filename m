Return-Path: <linux-kernel+bounces-874149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F4C15A00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D8E1C23CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DC342C88;
	Tue, 28 Oct 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ksuUqZ0Y"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B833507A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666536; cv=none; b=nv8y0v1TlitXHnXCzx/Rar7kMZi/fYjL5XJRf8xmuKwL4Goznjj163mWmGDDalUUp/6U46lTbPPkeSZZyi6Wf1jornhPx+LNhjSBljERWWpRtEmyRZOJGYZuLEiBU7SmU0nA7tU7B2T0H5vTzqoqt2HgnllLyEdvPgJsjk8M8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666536; c=relaxed/simple;
	bh=k8I9h+2k6IeAyl3/Vc6zs1prRM4rel0Sjd0zv9duXjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4yCrK/S85xrnDvP0UeCRk47xtxQF0AIpmWyc8E8t0ciYAnu/Oe9ePMku5KXkk/m4qTwSTd7TzTXhYTgNkt6j0eipsV2OdL8mvMSThPOuzXeTImNYXbJFRGgF0qv0UYg+ECTjydxTbglHruKcsLZk9aiKrSThyha1m3ZWnUcUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ksuUqZ0Y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-58d29830058so7117342e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761666529; x=1762271329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwnCWAx8OAVXDxRLd+WdlJJdVlnMbvByJtUaS0y34MA=;
        b=ksuUqZ0Ypzyeyx4wH585OL1Kw2LbSuTiBo2MRICReaYuuSEND/RtKHtCyzwAhD4UqP
         tF+2gfp/B8Qf0MiR9QZEvZr/YLKGHhePhe4ap8Uee7mEkAW2wz6LEESQiGQqGQZl2/Mo
         z39AD1wnCuZLlDhRNv/dFi13d82/8ofXGtWT2mputn9eeZ/ej9qU0NjLufzhph9o+zHp
         h5We5NPUFgs6KwtWlWfZDZ8enQBZl6xN2KF2O1NvHtahiqDtESJ/d0WI7ajrVRk/Zio4
         TP68X2lL+VaHMqvzhWka2GgnsdgsjFCN8oEZ7feQDT3eyMT3V6PbYvFKZVp3DOSEfM/U
         u0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666529; x=1762271329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwnCWAx8OAVXDxRLd+WdlJJdVlnMbvByJtUaS0y34MA=;
        b=t7b+kJU4aRwmfjO7uwpaA7ILl/4ZqC6GyzijViQP/N2hVf6pva+HTVrJTbgAQNByCA
         IWBAuqaWh7w02rbTsFUczwtdYwpuNg5L9jbny0CSWEgQRbUJTvyNsN6Wc6zM7EdsbZ3Y
         iAzSpDl6QV9kkfTZ6WzppIDW2IWC2gjX1vfQLEBJs8YA07AdTWAvunAZgSUhcc5YvK6I
         MwOkidK3vQJ5latvmPv8+TS6rmuiN1zAipPu5nvJj+CXCkFGqAFjjK1njQ7omcKPCaW0
         lbOUe+EpQYR7EYaSmNXvaAje3a0aijV46YjdFRCnFHhY2DIJkXWHnS0FV9oo2DRgXa1B
         i2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWVewBflhHePhTX9IHNjakhy81Y4D0SqhTYyqU58o4g5EXW/QN9IZqv0FZ66fF0cjorUn4zPlwnzywN/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7FuMwsX1Di4A/CL+0lFGOVq/jfPQEe2fTe2KsebfJvbd5ID6
	L/+pPb2UF6IGtDCwcr0ELWUzCHj86W5sDjczIbm2jVTdzLbHZlQx2AjlgkzSS7QqVGlmhubnsvK
	GIFysC0O259/rrvfV+19gMu0nwBdAtB+Wstt94QudVQ==
X-Gm-Gg: ASbGncu00MLUOmGosOTJ8+2yq/CQ2cgOCmS6Oq96lQTasvT5MKLAqXm3lt8wtzcg0OJ
	nLNwJKKcSosjlrFT2+oRJuXNTa2V6ew36WHKhpTMhaqOcLFx5candvDtWLskCAlGGfOppFtbS35
	b8m2K7ed47UO6lCqEFJKk3x8+v5YQ/q2AohuZn2tHKf3vtrlPojq/oZ14KpEXzqqUtUrM60WWU6
	G4KhGLsqqzXxBjt350I+eajWIuXAYKnCawb8WB9wew7BD1dZe0ROFQbPwFKgs7DaDyWulNv/LNC
	jqbutOaIZC7rlTY2T2kcIi1ACjw=
X-Google-Smtp-Source: AGHT+IHHQJDBFfYRgVJqX8xhSBA+9GpHTt9NgT260wr0JACLtpxb1RyGaZnV1bwmlzp3ct/hmGOguYUodPiD3cQebnM=
X-Received: by 2002:a05:6512:1095:b0:592:fc21:bc17 with SMTP id
 2adb3069b0e04-5930e99bc4emr1498445e87.3.1761666528580; Tue, 28 Oct 2025
 08:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
 <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
 <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com> <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
In-Reply-To: <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 16:48:36 +0100
X-Gm-Features: AWmQ_blgYmNnJtX1_PVoBYu1p1yrIy4vMPH61Mm6WV-4oL23HbeoCUDP69m6qE0
Message-ID: <CAMRc=MdL4yqY2em5myZO106FEzRF1RQuYroc74Qt_iHm-KBn-A@mail.gmail.com>
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:47=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2025 16:43, Bartosz Golaszewski wrote:
> > On Tue, Oct 28, 2025 at 4:33=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
> >> it explicit that driver was orphaned and no one cares to keep it
> >> maintained.  That's also indication for future removal from the Linux
> >> kernel.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 8abdc0e50699..be637b9dc7c0 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
> >>
> >>  QUALCOMM BLUETOOTH DRIVER
> >>  L:     linux-arm-msm@vger.kernel.org
> >> -S:     Maintained
> >> +S:     Orphan
> >>  F:     drivers/bluetooth/btqca.[ch]
> >>  F:     drivers/bluetooth/btqcomsmd.c
> >>  F:     drivers/bluetooth/hci_qca.c
> >>
> >> --
> >> 2.48.1
> >>
> >>
> >
> > Actually, I added that entry so that the arm-msm list can get Cc'ed on
>
> Ahaha, nice :)
>
> > patches. The fact it didn't use to, caused some regressions. I have
>
> It also points out that drivers do not have a maintainer.
>
> > done some work on it, so I can take it over as maintainer.
> Sure, I'll send separate patch for that replacing this one. Shall I add
> you to the bindings as well? All or only some?
>

I'm more familiar with the C part but sure, why not.

Bart

