Return-Path: <linux-kernel+bounces-755878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB264B1ACD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E3916E69D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015631DF968;
	Tue,  5 Aug 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y7HGxkOc"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC46ADD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365129; cv=none; b=oXBBX59BmiOgV8y7Ptp9mrIgCb5dNzH42gQNUl2kiFSxbgHuTE9F3DHi6MbBUtFQQ20Nk7o7yNEM3e84KdWxKM9DbO32HxFwZq0aslYqPrPK0g/EK21ke4MJH01bXkiO8Ka5S1c1zuJW7W9mrHYmTmozo2eIOYkWxk7T8g4Y0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365129; c=relaxed/simple;
	bh=/SNZxRzFlk/QovwahhIvN5xPQltbQzvBaYBF+ln5fNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtG4q/cQIL2PtNji4W9bxhBVUGyBr8/gq1qJ/XnwlTCa16NUAWcckF4/ya4ACt1+fNuHANDIVrJERcIfGpM8c2tZmwaGA4M7mfapMbxSYM9fcNotsnAppaLEDlK1UEHV6N+AIM+lJMsSfC5xWXWpyCdQT9PQuPm0D4oJ5+0WOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y7HGxkOc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8e2b50f8f1so3540714276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1754365125; x=1754969925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POVkbC6m0FbsZQCVqqY6DRqPTZCsdOevFhpQTRfzR3k=;
        b=Y7HGxkOcHr4yWrB9l4k4gFiShYCQpv3DEdX1Y2qvrmmBdTPxY/kaxcqjBl8g4ushO+
         EW2OvHNdaS1X1ipVS7Dvz1N2YP/JsXX37rpUJer5+OEOnv/Fj2L02jkVOaTFstfcW1iW
         MKGq320cSpdgmCL5dhYo1gU212qldzTgCj4Sua0OkoEP6jwJ+iegLFHoOn1JViPmD476
         Q+c5kPHKjWV99GioKiCn6gK+Px8oyfcQA+S54UAhRlbde1P7PI7joue4Zgt87k1+CoLj
         nUS+tDCqYkO9OgeovDNd6my9kIqsK2wpHmrqnnMYGCSmqGoggWkGtf37sZ8Xf7uWaw8e
         09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754365125; x=1754969925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POVkbC6m0FbsZQCVqqY6DRqPTZCsdOevFhpQTRfzR3k=;
        b=am1/lBJOtg9hV8hCfWPiP+aEIQyftwrOkEz8R2DkP6tEZG1IwoKdmFB0sgxDYa6HPA
         3lax2/QL134E4kxG6haNFtKN5w0TyOW45UI1L3PVE7d7PM7b3swIIeIcEcQ0RHjH29jo
         T9QMZCwKLdggRZapXV31rSC6o1f9b4N9JhDCaZv5rXOy9F/0aDRVtY9pzXyV+qWwFfOh
         jq9rAM3cvJNI37nevcdjnGS+R8wuy17M7kcY8Bnvehxct3unJvRkIsq1tKrq67qB2JFt
         GTAP7kZ3pUvJ7AAYS0WYnW8Y17psW3jBz4xc3ENdHY7VxON9uqsxaTMrwJg55ikXtrpR
         QLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTW+8irzFR1PKt+IqcPnwEu3MQcWKaDIvrzmtzfC/q7f+vM1J2gX9cCmLAu2NzEkjDFvFTjeSTltJG3FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ugTXiWKgnN6IgStAaM8G8lHxE60p679H155StqngvNHIDnYi
	DFF9IaVDhYeioZBYG7FxjDowoDaWbYKWvWnGBGzrm7zJVw1+xz+a3nJAh5oFejmYDob+cO0MY9K
	NPRDLXrLQDCsex5igbNwrgC8g4VwCJXGnypupXwy5QQ==
X-Gm-Gg: ASbGnctPMvSZBFbkY8Sf8at5k1/I+xLMRsAuKAfNcvHxwRH3XYzcB1ZwYa/GAZG3aIo
	/GSJncHSZarUsZxff+AkhrSck4CeVVqvwsEvCYpfvxE4u4LLyr9gGJqLEle7atatkDj7Y/XAgg1
	XAduFcrQ90xbx6cX6i1baQIRPEd0SwobCAb/3FUhOlnH06s09B10y+K/I1x+4DJPzusycXHy9BS
	BW1cR4KTPcncud3VB2f
X-Google-Smtp-Source: AGHT+IHQC+FWa/sBV6PObYXRFHKF0ipC8ClxXs0v16B6xElYzTA11LPuJqwPvrY3kuC7CE6fdD+FC5kTAS4MnOQ2ZQY=
X-Received: by 2002:a05:6902:4187:b0:e8e:288d:1f53 with SMTP id
 3f1490d57ef6-e8fee03324amr14194932276.26.1754365125300; Mon, 04 Aug 2025
 20:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801070112.12071-1-nick.hu@sifive.com> <20250801-lunar-stream-0fdb3f0febec@spud>
In-Reply-To: <20250801-lunar-stream-0fdb3f0febec@spud>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 5 Aug 2025 11:38:34 +0800
X-Gm-Features: Ac12FXwV9XevZuRxzcMDGn197rKxsHebzj--29n5CzxP2OQ9om678fcPueT4y3Y
Message-ID: <CAKddAkDMd27icz6sa5xONAiWGcb8Un8CddHKyX1=jQzH7DCvZA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: Add SiFive vendor extensions description
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 3:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Fri, Aug 01, 2025 at 03:01:12PM +0800, Nick Hu wrote:
> > Add description for SiFive vendor extensions "xsfcflushdlone",
> > "xsfpgflushdlone" and "xsfcease". This is used in the SBI
> > implementation [1].
> >
> > [1] https://lore.kernel.org/opensbi/20250708074940.10904-1-nick.hu@sifi=
ve.com/
> >
>
> > Changes in v2:
> > - Update the message to indicate the user of the extensions.
>
> This should be below the --- line.
> With that,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> although I suppose it'll be me taking this and I can fix it up on
> application?
>
Thanks! That would be really helpful.

Best Regards,
Nick
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index ede6a58ccf53..5638297759df 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -663,6 +663,24 @@ properties:
> >              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev=
.-5.0.0-Datasheet.pdf
> >
> >          # SiFive
> > +        - const: xsfcease
> > +          description:
> > +            SiFive CEASE Instruction Extensions Specification.
> > +            See more details in
> > +            https://www.sifive.com/document-file/freedom-u740-c000-man=
ual
> > +
> > +        - const: xsfcflushdlone
> > +          description:
> > +            SiFive L1D Cache Flush Instruction Extensions Specificatio=
n.
> > +            See more details in
> > +            https://www.sifive.com/document-file/freedom-u740-c000-man=
ual
> > +
> > +        - const: xsfpgflushdlone
> > +          description:
> > +            SiFive PGFLUSH Instruction Extensions for the power manage=
ment. The
> > +            CPU will flush the L1D and enter the cease state after exe=
cuting
> > +            the instruction.
> > +
> >          - const: xsfvqmaccdod
> >            description:
> >              SiFive Int8 Matrix Multiplication Extensions Specification=
.
> > --
> > 2.17.1
> >

