Return-Path: <linux-kernel+bounces-725350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C61AFFDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BDF3ABF14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316429291F;
	Thu, 10 Jul 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7TMRbkY"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BF214210;
	Thu, 10 Jul 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139315; cv=none; b=AiyL4jJpjo3DYq2OS95d6+wIEzChazGbIhwP3pzbKkrbSfWo8+8qgjd946l7JGBUFgQ8tCG+yTRvWwjXHqlCcdoAtCSVbw/sgglrSKSujHLDHKfonH+p1JpY/txZF70VmpvqS8au2O8YF3jGo4LFthH5xkZ1SqdGSicyCG/kciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139315; c=relaxed/simple;
	bh=y21nPgHIHQE0X3oc5JkFHd1rukiAka8zDn3Vv7fequ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/0lmT7RIt/zGJNVr848gD2PA49M7rYaWscfiQJbSHcyUbJI2sEaJIT5ikW9M1aBxOWNNgJK4RehZ8XHT7K3Mn2b3OV6p+RNsqBwxM6t+VKcaYRjlMcs9G+7uzY3M7LuB7YrJ3sHmATHPW0/Fz5cte0qmhf/z/dy9Ktr9zD9jKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7TMRbkY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e77831d68so8276467b3.2;
        Thu, 10 Jul 2025 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752139313; x=1752744113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIb23wfO7R7H8MNklKKsDP+RsX87PaDNS4GSIFnlxoY=;
        b=Y7TMRbkY0gCLtiFlzVPIw480b5wwH6vIYMMcsQc668Is+PRF2bfl9ceVlScg2OE3ZO
         IMetBHK3MTYSFHv5Q3dJ1e/e0f72A8MKtFk+TYeYdhDe1FNlZetfXzn0xEGUTUijD/WB
         /zR97fiEwMnilUCizU+fjjiYR9jVvrEowm4j3lh05v3AToFhvJ1KEUUawbFZFH+HWnn8
         VUfCvVX9Vj0jYAozZLjwkI0KDNNNyRXCvMBHnAaroRUHcl0OM3DymFg5kmxKn/pMHmuc
         sFCzBjfFDLT0+MO+sZE+10kyWmsg3PhtD/Hy8v1B5iPSAnTa0gchYErINcb1kwEiEWf0
         vgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139313; x=1752744113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIb23wfO7R7H8MNklKKsDP+RsX87PaDNS4GSIFnlxoY=;
        b=mXxPgEcBCnk/K8p1RTFXCvzLTgJcgvgenvbF6cQCGYF0iW5omkceik4BDFk/mKzPlt
         Fd01mU92P7Bu4MePeLEox2MIxXNoBaKtuh69wkURrPrmxgbzeA6ZOc/FzyWjgZ+Xke2F
         txNjedGyySZ3AIAnh02NL1tteMJo6x3ibKoUhq+tb1utx2sM4LI1ggqCK/Q9WEsbYf07
         QpfcIQtX/v4+XAQQj7XAL5ldWi6wQe3rg/1VO+atVN4M53bgSkY2ROTlEE7+sVVhxMYd
         TJtvScBCSDpoElDgjiIOjM2/2L7tatV+dOI1L+L9+U1bn+xYL2Ndy+Zxl421OCv4/QpU
         2GQA==
X-Forwarded-Encrypted: i=1; AJvYcCVNzmqN6IblYR5brdGRYtF40uK/PPoyXshH2NIeQHJokSZRM5G5MM2T+9qzrIxmACAYSYRkJ+/1epJpLD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VRXt6ztLkeNu04K3ATiFz/P6VB7n0mhYQJGvajwhiYrweJyN
	lCb3XR4OsQOELQh1QtyQ/D53rkUmbuIDv6rbyA05/oqKhnqCAtCQaXIAkgZjXMYuJZXeUXqBZ5a
	81GYPO7QJFyPz7LVIKqF3rLSOoE/PsB0=
X-Gm-Gg: ASbGncuSUj+izLz3gnmgG9/Igg3Nt8GhgAi09rfoaSYvbbtyRW59rQP29JOQfLhIhFA
	KAcFm3atdgej4myeSpa7t82cVTUQ7X2yUFKKr2auuV3Uya61CS8rJ0CxEgVxMcSUaRy8QuqN5FR
	PHudz9AxiMCA+rcXnqv3fLELdLN8gdt2StO395ezMzKQ==
X-Google-Smtp-Source: AGHT+IEyihmR4k6j+d3nRg7Al2UjBfOwUKJgCp3uoe4n9JUTn8NhsBjL7wuXahr5HIPQlLPnZdlvYqaWnH6iYhxgRdY=
X-Received: by 2002:a05:690c:6908:b0:70c:a0c9:c648 with SMTP id
 00721157ae682-717c1774a36mr45258857b3.19.1752139313148; Thu, 10 Jul 2025
 02:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
 <20250709220714.85697-2-stefano.radaelli21@gmail.com> <9b503f65-5c8c-4f04-a1b1-40d7a1202e8b@kernel.org>
In-Reply-To: <9b503f65-5c8c-4f04-a1b1-40d7a1202e8b@kernel.org>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 10 Jul 2025 11:21:37 +0200
X-Gm-Features: Ac12FXxMoCORza1qjA8bpnm1jhAVYXGS6gK3JmG0IlhKcdilmwXZ2lWiCDsGXZI
Message-ID: <CAK+owohgk3CkQRv_PBDWXh44X2uN3p8FWBU2t9VtmO-xzOKTow@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your suggestion. Actually, our compatible strings for
Variscite SOMs follow the format "som-factor"-"processor". Here are
some examples:

https://github.com/varigit/linux-imx/blob/lf-6.6.y_6.6.52-2.2.0_var01/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi#L14
https://github.com/varigit/linux-imx/blob/lf-6.6.y_6.6.52-2.2.0_var01/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi#L15
https://github.com/varigit/linux-imx/blob/lf-6.6.y_6.6.52-2.2.0_var01/arch/arm64/boot/dts/freescale/imx91-var-som.dtsi#L14

These strings are used in our Yocto filesystem for WiFi management and
other applications. Changing them would require updating the entire
Yocto configuration.

Best regards,
Stefano

Il giorno gio 10 lug 2025 alle ore 08:50 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:
>
> On 10/07/2025 00:07, Stefano Radaelli wrote:
> > Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
> > and its carrier boards.
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> > ---
> > v2:
> >  - Add symphony carrier board compatible
> >
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index bf6003d8fb76..780fbb5970a5 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -100,6 +100,12 @@ properties:
> >            - const: toradex,verdin-am62p          # Verdin AM62P Module
> >            - const: ti,am62p5
> >
> > +      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
> > +        items:
> > +          - const: variscite,am62p-var-som-symphony
>
> This is named reversed. Usually Variscite names are var-som-foo and:
> https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
>
> confirms this, so the compatibles should be var-som-am62p.
>
>
>
> Best regards,
> Krzysztof

