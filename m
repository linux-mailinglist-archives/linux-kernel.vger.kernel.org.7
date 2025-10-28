Return-Path: <linux-kernel+bounces-874589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E54C16A25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 606A74ED0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC234DB4F;
	Tue, 28 Oct 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh71enLg"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2F34CFD9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680295; cv=none; b=aivwm0HBpNhuhDepzJy6eWh0ugcCgGRmHfMedf3HgdovZQxgOGtBZsP5MWcf/ZCTjK1UbXqUWwyiwM7F0PDSsPXdA7NAhconI412B8nL/9E35QxPf5ZGPicUDoa0pE31dGVPh4Mv8UmvUQT1pYEjTKn8VCgx4CrW3bHKP98KCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680295; c=relaxed/simple;
	bh=aNeEuzDTDWur/0YtA72ZPsuM3beIOXvdru72F3c0jlE=;
	h=Mime-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvqAjN+TnmIbkD4YdQNdkI7weHHVtblTB4dYpVb3dkNnT/85uF8lASj8CdWeizuNwK+YvGY514H45D3pMUHSsWi2KoI+JsND3tXhmYtFr2VUtZnfGSvCZdy3UorhiC0YeD5/gxn8ntCo9suO7rt4UMR/omMruw9Avi3X0ctCF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh71enLg; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3e9d633b78so54431366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680291; x=1762285091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/d1nVDJ7emVNTsvQ68M7pKA7Zb5SHnnPUqNukDQj+RA=;
        b=dh71enLgjHH7yw3B6+G4KeRiH5Tf8i0ttCbvy+RmoAZ0Zmx9aaxMPyzxIhygf070Gb
         mtKb5R/imC0SkVi3pVC5GQaJ+Y6F7nYHwdARAJv691Ktn4eC992V0+yhVIh379gNR7Ds
         EMtmKiOUQfePukJq7svLZMXkQQ+b2LE11CBJgnWtfGuw4s4liYYf2ba9G2XQbcQ4Bb/C
         RpB6kFCoYrstHNzD05+AcCaYobbGNBYq3DEcphEnh9foQUHHbvQYsf1VRkG5CdLiY3+E
         mEBDG5u7ZvsLLEmQua5CZBExsmAePzsbRFDsXwPQ+r9V36BJG+Kdh//EZ+wzEqcqXXWT
         MLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680291; x=1762285091;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d1nVDJ7emVNTsvQ68M7pKA7Zb5SHnnPUqNukDQj+RA=;
        b=kehQftw5Q0fBn/A4CNplVGKyEw7EtCB4+j/oveJX7IrGjK+tOkTiQ/kGHTthjKyBCk
         ZkTny01n9BdJhsg/vWcflVz3R6gQ0dkH5bpamP/qERrX/oiJLtLH3mV/bLo/nu45J4wj
         p0IZKEZUMn9H5j0dawGAILe3EtYVk0qZCME16OOpq9ja7AU8PV2DjZl0Zhp9gHCd4ejU
         r7XrTFRIxSf7F5+Za5/joH0cqGuTdn5XtpgjvOi8VaZ8h2E0IBDQqLvQ3LQSTwYzApY8
         TThQf5QPQDB4bzOQRHIQi5GviWFvfSzbSdytxJvhqPklyiQbvVLKRM6XeAQhMrapPElD
         p+OA==
X-Forwarded-Encrypted: i=1; AJvYcCVwm+kxC7d5IdyIXp/LrE8fRVsYrkQtJ6myKP4vibhl2QDCBba0bD+coWGK7uAO88Dh+O3no873xGygbeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+XkXMWn5fQ1TxkQLeNtWxII3tmZWRL/HcQYp3GaEaFDXOnJk
	q15ThKArouBSAuE7zR00hVVl05OdJ8qTx+Z9iKVWauDM9gTCjcMKTOPEycAkRwHLdIYstFCbYzt
	Adqyw19QkNlOUPTNF/DTnG08TQfnW1LpZx21q
X-Gm-Gg: ASbGncv7tbBePz66nsNKPX89qJcgG9UnRk/TB+U9lC3WqJuajYouQsrd5NON/OMEraf
	BQLaPDsUAlektbpB/jGcwMgK3R3TcRhfCdGpOHui0o8lmRxOmI1gO+KePnSXzTifSbSF0SHEGHh
	RutUEi+RZETsZcGdXVLWK84pAvBdqUvE0vWQZaKn5lOgRmTD6/rD+axKmtXM3UdrASY4vSC558S
	CTYokTbJdAWibak/XJbaCsEHhO/B9pK4qb15JN7TwukTkMp8PkEKWWYjcv8TuhCgoZm0A==
X-Google-Smtp-Source: AGHT+IFXCv3NLTqCfuR85Tev/aBDdsf4JrxkYAhURFZZFkUVV5Guf6SWg8m7dcZhUo+L4eIXn4zfs5S9vSsND2tSgig=
X-Received: by 2002:a17:907:3d10:b0:afa:1d2c:bbd1 with SMTP id
 a640c23a62f3a-b703c1f1e89mr42748766b.30.1761680291324; Tue, 28 Oct 2025
 12:38:11 -0700 (PDT)
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 12:38:10 -0700
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 15:38:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Coia Prant <coiaprant@gmail.com>
In-Reply-To: <20251028-haste-amusing-78c28e834b5b@spud>
References: <20251028-haste-amusing-78c28e834b5b@spud>
Date: Tue, 28 Oct 2025 12:38:10 -0700
X-Gm-Features: AWmQ_bn7Qe26tzowtppaIPQCwjocMKpUT9bEG-eaS4l2nl7sB4xnwDMEoMgE1XA
Message-ID: <CALj3r0jQ-Y3wt=iyykrFVWDXyA+2feCtYy+budYzqOaVY6WqnQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At first, it was to avoid problems with the beginning of numbers.

Given that it is already used by downstream projects, we have retained
this to ensure that users can seamlessly migrate to the mainline
version.

Thanks.

2025-10-28 19:35 (GMT+00:00), Conor Dooley <conor@kernel.org> said:
> On Sun, Oct 26, 2025 at 10:36:44PM +0800, Coia Prant wrote:
> Add NineTripod to the vendor prefixes.
>
> Signed-off-by: Coia Prant
> ---
> Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d188200..37687737e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1124,6 +1124,8 @@ patternProperties:
> description: National Instruments
> "^nicera,.*":
> description: Nippon Ceramic Co., Ltd.
> +  "^ninetripod,.*":
> Why ninetripod instead of 9tripod? That's what the company uses and in
> the marketing fluff for the boards.
> +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
> "^nintendo,.*":
> description: Nintendo
> "^nlt,.*":
> --
> 2.47.3
>

