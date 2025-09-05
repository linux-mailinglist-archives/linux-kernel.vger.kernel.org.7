Return-Path: <linux-kernel+bounces-802746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3FB45665
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE325A4D71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315032A3FD;
	Fri,  5 Sep 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wv1ats1l"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B613594B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072004; cv=none; b=C25E0lTQLq1kxxybec6Oqw/3AvZx6G0xrNluVOR4D3B0hoWcJCJ1GTAiq4fyJbAVLAA8OeZaJYw/kh4hMHGRoxRPBgwU1UNjPBTp4HwaOala7vOQ934IRu5LOozk97nDfaioW8EwIop8XXvGWRy4mL+50WJpM6A+t8ibiKpgeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072004; c=relaxed/simple;
	bh=o3hildMwaW8SKO7ju4TnjzbgldI5VhKTu/M3PBEf9Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQpQIx0PdMW9jrI4mTRl0ysP7BX32FSx7rSS1+5ziYiSBx7gVfp3Dmr4K9oX3cQjIMmEt5+d7S0yO1kH+frdSCl7drJnBJucVnoCqGxcAKN38tHgDZ4okl+kftLjr0Q9wMiqa6C4BIJ/eLRdbH2flCZxgr9lyGjKLpRZfJ0IdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wv1ats1l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33730e1cda7so19234821fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757072001; x=1757676801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e737NFCnB1pAiZwFeuIFUAdoH1qix+jNDtR6tlkeuzc=;
        b=Wv1ats1lENeDFeCHltS6z4eXYjp2PkHp41U/KSjwkprIJpiwUA2iVdzBaZiRrx1Mt0
         qHGzczd2Z5jSluwCy8P8ACWB3Gle0ScrGvwq4D87K+DQ+Kn1EKuy9V/NtvOQhoVvhDw1
         VlhaCRenYJr1p6TqCwmNzarskvRPWlEJDa2Nj8Rx+vO3RPTFL8o/Q46mAI6+DAl6RbDn
         ZYZKDb0HjPYXY9TG0yQXthJbEdx7DvqMucAOcim7XURySnkfmfW2beuJwk8vwC9AIaRY
         bPmuFP2vDrK4ShsfmwWPEdFTsf1mqOJIf3RdGn/j4v4G0Gq7NWGy2otXfxbf4BukM+3s
         cpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072001; x=1757676801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e737NFCnB1pAiZwFeuIFUAdoH1qix+jNDtR6tlkeuzc=;
        b=U16bL2nGx6RvrRo4kiZ6OayO5asmgNRPdEaNrDvK9P7jf6NmIxXocMmd2YVNAT12xp
         MLIRagOTT77rtzilpo8rTMvBHhq4ZJTV/KlnBxZOpQXCiwUfT6SUzOEc1R4I0QTmh63c
         84MMmihLQ9t1sGRINPFBxx6ZvzlRmcx8QjvBdDtlhwEc4OeK4MBeuWPO2QZuY2ALzJSS
         OP851MiuHQFWxwo2NvsAZrGdBLOOXGiV1nLrV0C2/eirwSQmfM2MgeUNrT65zOO/Cee+
         YnN8GnUSwtKb5PpO4GC5Dueh480IH7GLPpi1WiFvgxbTvhYKGpD3MaYmRSfNB8I5uDbq
         WgPg==
X-Forwarded-Encrypted: i=1; AJvYcCVd8kUfOhJxXzeRNn0AeBUURaP6n1eOqO/FnS8ohCnMdhiprEkrsAmBisGkC/RkgVzrte/klqlbvozG/W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx01VINq/xtsy2ZAj1uA4RfW29MhpKpOt+q7ulloDVK4Hmrr0B
	arZSxodonHCSkeEJ7kNtqEd/+M6du1Bq/frdYXqiR0bP+Qe0GYAWjJ+Uv2MKQZihukohjxSW94B
	j9ul2Ag+oxAd8RzBfMm4EBilqMOHh/vPZKyR/VhZaCg==
X-Gm-Gg: ASbGncvHh9OpZnKyns5DG5NrVKor1JytvjktN/yXCtWn2rh2Oae2N1AMyPb3LJaj6pr
	C1iJiM1MD7l5+XMm+QXagTExbsVu0uyGLi/BpFVAmNu08g2IU+sjM9StcWG2URfy57hblv798T7
	B9I1wrLFAEs1Z8/GrnRX7Tpr2eC4ljwUNLV1X6MnZ47Cel11O1KwvFgTivFYHpWJPNTLKyFSLoW
	8Xh0A57QwGlx1iItA==
X-Google-Smtp-Source: AGHT+IGSWO4nCHB8o/6t/y6RH8BOysPzoQ6jiv8gZqcTwwokf+Kq7hYmaaHYY9kCJZ1mu3fJ8bEoY6l6Nt8aDc5ponQ=
X-Received: by 2002:a2e:a482:0:b0:336:7c7c:5ba5 with SMTP id
 38308e7fff4ca-336cad21f17mr50388961fa.23.1757072001159; Fri, 05 Sep 2025
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171302.324142-1-ariel.dalessandro@collabora.com>
 <20250820171302.324142-14-ariel.dalessandro@collabora.com>
 <CACRpkdbpKqKyebADj0xPFq3g0biPh-vm4d6C3sd8r0URyfyYRg@mail.gmail.com> <caguo7ud4dapb4yupeq2x4ocwoh4dt5nedwjsyuqsaratugcgz@ozajhsqwfzq6>
In-Reply-To: <caguo7ud4dapb4yupeq2x4ocwoh4dt5nedwjsyuqsaratugcgz@ozajhsqwfzq6>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 13:33:09 +0200
X-Gm-Features: Ac12FXx6o0aglHH6TQGfVH200HSX_9WYooYS5LFefZX_Ln3xQz4XYXPyVN0c3dY
Message-ID: <CACRpkdZRHQ6vuchN8x8d0uPCVMPPHOdBVWiUhzFJNs2paHGbYw@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] dt-bindings: input/touchscreen: Convert MELFAS
 MIP4 Touchscreen to YAML
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, airlied@gmail.com, 
	amergnat@baylibre.com, andrew+netdev@lunn.ch, andrew-ct.chen@mediatek.com, 
	angelogioacchino.delregno@collabora.com, broonie@kernel.org, 
	chunkuang.hu@kernel.org, ck.hu@mediatek.com, conor+dt@kernel.org, 
	davem@davemloft.net, edumazet@google.com, flora.fu@mediatek.com, 
	houlong.wei@mediatek.com, jeesw@melfas.com, jmassot@collabora.com, 
	kernel@collabora.com, krzk+dt@kernel.org, kuba@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, lgirdwood@gmail.com, 
	louisalexis.eyraud@collabora.com, maarten.lankhorst@linux.intel.com, 
	matthias.bgg@gmail.com, mchehab@kernel.org, minghsiu.tsai@mediatek.com, 
	mripard@kernel.org, p.zabel@pengutronix.de, pabeni@redhat.com, 
	robh@kernel.org, sean.wang@kernel.org, simona@ffwll.ch, 
	support.opensource@diasemi.com, tiffany.lin@mediatek.com, tzimmermann@suse.de, 
	yunfei.dong@mediatek.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:02=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 21, 2025 at 01:56:24PM +0200, Linus Walleij wrote:
> > Hi Ariel,
> >
> > thanks for your patch!
> >
> > On Wed, Aug 20, 2025 at 7:17=E2=80=AFPM Ariel D'Alessandro
> > <ariel.dalessandro@collabora.com> wrote:
> >
> > > +  ce-gpios:
> > > +    description: GPIO connected to the CE (chip enable) pin of the c=
hip
> > > +    maxItems: 1
> >
> > Mention that this should always have the flag GPIO_ACTIVE_HIGH
> > as this is required by the hardware.
> >
> > Unfortunately we have no YAML syntax for enforcing flags :/
>
> Theoretically there can be an inverter on the line, so from the AP point
> of view the line is active low while from the peripheral POV the pin is
> active high...

Yes, I think someone even proposed adding inverters to the
device tree and was nixed.

It's a matter of phrasing I would say:

"Mention that this should nominally have the flag GPIO_ACTIVE_HIGH
as this is required by the hardware."

s/always/nominally/g

Yours,
Linus Walleij

