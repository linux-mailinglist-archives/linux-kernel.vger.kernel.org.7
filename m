Return-Path: <linux-kernel+bounces-870479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECFC0AE75
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E083B439E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F625392A;
	Sun, 26 Oct 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcSlnFjb"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A2367BA
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498912; cv=none; b=jOHcZECGdMe3auoYUrxyVvyt2yADY7JJECvrYssxTvuEO8e/WKF2tLl153NfnCvKVSQ/5XMWcSleRgGNrc1hMXdr0lK8SssqJJ7DfH3LjI9voykn3fOFP4f8BWoBgtTJQaixfV9mV6XTL3m9re9mbFRZF3Blyxk74UYkFOOeKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498912; c=relaxed/simple;
	bh=D3iyFU74SZm9l3VCT029e6L9I6zHS3Tfx/bSbezzfeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G4FOOQp2jFee6NSe7LdsJprD+n7/qpqHSmvILoVc0nwUdD40augslS/7jSIoeFrGaSHv3Xj3FZeBXQyab5y8LICwWDuQaHbdnLDI5xf7zOZNdPXReJxVUDYkih1qZ1Hj9a0ShWZ1TeFJcWP/jH36CK4TAXY6BM524ctoXFUQzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcSlnFjb; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso485006666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761498909; x=1762103709; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da7n/lRyiS06YbMDRGJe/PhIKNbj4s3MR8oTEu6nwl4=;
        b=VcSlnFjbcjr9MyduI7RJQePIMKmZQiQ2CUSR5S2Vlc83sZcJlZgZ/muc+wY5xsKaIX
         yn85UuOYQVbRLi3g2w7mQgVohEbX6bozarjzZi4WGshs+HPNQ7nyaE5Ot2ObkvBjhYlW
         26OQsHGqZcAPyw2XiHf8xWSDDzWfM7CtC6+L0GscmmBrc19SZgdMbzSUo53F6m79haw2
         Fxl/ytfEjMJarcVik2vsfEToIneLVNNfFlXCAGfB5FfxD6aqu6F7gFhhHr3TTGsiBkro
         BkWOmW4OnyymAgU0iCi+qVCYqA1TjMhl/WG8JKB37Z9E8VBOHudYq4gyQycD8mkdMTcp
         3qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761498909; x=1762103709;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Da7n/lRyiS06YbMDRGJe/PhIKNbj4s3MR8oTEu6nwl4=;
        b=OCrcTOJGMKsWqA9pebtcdG1hL4Ra2Lv5TNrtzUrijDYwyNkkcCkmU5G7JtL2/yxvhX
         LTanTVSTl2uRTJPnNBnXZ14+aMkkK4wMT0N8tgRocqfgdAV/wSJpmDbAo/sOQ7/ItTdQ
         iEx3hN8BsVUxDyzN6Ikg8HX7BMsnV1SWAOB6gG7yjUDylBUtK4OMGxjcIwgJG1K0dzBp
         ucA6UnsAGll/j73TN+aCNCJmWdjOdYGZn/vQLjVVEUDdlVAVOUfKC32Q6Ohvj43DyaKh
         /Zn4OJ1Ir/ELEMowGOuk+7Y4QLkoSriTbOLg+4hEX/v+2oS34RQxLmGNNjGsSC8UF4IA
         BftA==
X-Forwarded-Encrypted: i=1; AJvYcCVMn2RkZe+xX3kfugLV3jkqPJE/z+iLhhZi8b9d2bab1Lml/fzwHcjCSQsjJwwaTJdITIZwuyE8wajzs7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HCGPB31Ce5CM9Dg3QEjg/gyD4IU+6h8UXvaCs9wRtRTicU1h
	I0lIpfEGJssEO5KLoUx6JeyH0E2YjapmznxHovGRCegokZFz5h4QfFZD88WgWNLWa48HsDL06BQ
	vG5MbZ36l1zeppJhmEtHOdJAcgNKy26Q=
X-Gm-Gg: ASbGncs13XXXSaDXHbi2duB4lIbw6NKhDrkjp+4MOoeY2LeJ4aPiLI4X1et8FcZw6I6
	BZW8f60wmeXr4mg0na6EZ3dEImjODo3HEgLGmLVZT5PIreBpAh/Y2Nku9PzR2/h0g1zOLKMNBRJ
	JzXhAdxlkhD7LMori28XFQtLawI0+R28g6YoWWEXDZM5sUCC3k/AOhuBUOiu4zkOxkiiE1riDGc
	vlRyRJkBOR7qk7GROUDIxuwU2DZ8EDdMt2Cg1GTBMA8ZskEagkMcfX37zUm8/BPISkCdHIckw==
X-Google-Smtp-Source: AGHT+IFzqU3QsaPE1MW2duZ8/dKVM5Mj7D0icnFlvp/4DYRo9NMCY1YBcoIDI7zlJrtuI8cbSwsY9j7dHSYnlbDke2o=
X-Received: by 2002:a17:907:1c81:b0:b6c:8e24:21f with SMTP id
 a640c23a62f3a-b6d51c325c6mr1741819066b.55.1761498908937; Sun, 26 Oct 2025
 10:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026150358.1078453-1-coiaprant@gmail.com>
In-Reply-To: <20251026150358.1078453-1-coiaprant@gmail.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Mon, 27 Oct 2025 01:14:56 +0800
X-Gm-Features: AWmQ_bnvhjvqwSYSkZyszEhUHRG058LD6n9gayksgoabyqflquBOY2fvBCiBW_0
Message-ID: <CALj3r0jVPGtVtHUwxmxjePkj4T3jZD5JUHfJL6xa6h8CAKHRzw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add NineTripod
To: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, v2/v3 causes compilation errors, which armbian's build system
automatically ignores.

v4 has fixed the build failure issue.

:(

---

I'm new here

OMG, Gmail Android cannot send as plaintext mode :(

(Resending with corrected Cc list and plaintext mode, sorry for the noise.)

Coia Prant <coiaprant@gmail.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=8826=E6=97=
=A5=E5=91=A8=E6=97=A5 23:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Add NineTripod to the vendor prefixes.
>
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d188200..37687737e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1124,6 +1124,8 @@ patternProperties:
>      description: National Instruments
>    "^nicera,.*":
>      description: Nippon Ceramic Co., Ltd.
> +  "^ninetripod,.*":
> +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
>    "^nintendo,.*":
>      description: Nintendo
>    "^nlt,.*":
> --
> 2.47.3
>

