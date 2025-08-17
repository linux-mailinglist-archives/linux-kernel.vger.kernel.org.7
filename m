Return-Path: <linux-kernel+bounces-772646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21AB2957F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2403BF49F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935A2192F4;
	Sun, 17 Aug 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYtFliXn"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8665137C2A;
	Sun, 17 Aug 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755469135; cv=none; b=NTDrXqYsLqQRylFDEQGeU8gpPriEkBQQx96t/0nuDoAsP83aSqlcGI58USAFia/dtqc0INbOHa3w3eqA2Fcx+gUg/MizfsPae5qbODsfxvc4rrLoNvKxwe3MjjfpBIou1JYzsT3alvVa9F1ISh+AskiOZw9Z+I6DWx7v6t9fuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755469135; c=relaxed/simple;
	bh=UTVz0E8nYrn+mtSHGGMVUE4aTrLbWGzLO0jOuxI5UXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMGcW5/8qCJiStJ5yFQWxRZML27u+7aoUbsUegXWVjdIqvI8JL51xVotjq3LSzkRGsXUSr1o0jirC5ozaYI4h2+mSTGus4vm3DFDURwVjyxezPrH2GwFWg6y6WjpihTdt81T+4Myo0qbpyModbPli8DM/7Hp30m9atcqttNvxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYtFliXn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso2862296a91.3;
        Sun, 17 Aug 2025 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755469133; x=1756073933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR9IMnY93Ea9hjevD2RhY6NAfKavG0y3XJMprGSi8GY=;
        b=KYtFliXnROIOYi+vBJyqKs2AWVogHzOZXg5x9T/dLy/OsfGr+fetAiT62XNPDaGk7w
         zZ4lssLfrKI0k5jaM2PxFBX0LOsEadI8VfDloISQUjqN8I0mAYJzANunSf0Y+qcbP6Oy
         JExM+0Y52QvdsVPUMU59PCVpvgV/whj0adEqXSMDa1LWQL8ixulVv04tfwuPZ7Zpd0AD
         HMdYFeqMeu1M4HaGyFxfURCBNSWebyrIqjlUaBkcb/wcOd19Jk5mqF8Q4CMfQQT+Hc/R
         Q0hJUsINdB68k4/G9vQF+Ze0S1DvIFRgYgBXyuJC3WiPywfta733cVK+frbUndj7uj0N
         LaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755469133; x=1756073933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR9IMnY93Ea9hjevD2RhY6NAfKavG0y3XJMprGSi8GY=;
        b=ICGLhuh9goMC5tBNjhwXHJ1C2h48GvAkrDtYA812fLUyr0FzHZHr3IgrEwRjXb39H5
         k/ncGhOFMKHnD5+XbK9d8AWpTsScLSDATAQpdmMWxIzEIl86ZMVPyq6s65O1nyPHwIxJ
         6+a9sOSjaxXTIZpHX8Um0Uk1T9TukwRtYQm/SLcMoSYxW65OLbtEmVzZ0BrlxuENai8A
         kpVS5gZxms4ih6k8rLk97/nd2hJEVHti8Q74dbzc0pgHjScZkD2oM/wL8ePuqgz4dDJ4
         CPHA3AVF0VUQXbny9mfQD8qrF859ISbQ3mIvIGlVCXsaBPwlHrz6UrLH4h6TvtD+rOeo
         v9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcWuuIRNN+U/ETGOrlFum460mqc3MSGA9fH4cM9jGoNRxBSJEBBZiREvPuFfZ2SpFdKLzy73XSjb3IsPdZ@vger.kernel.org, AJvYcCXii4HhnsRrBsFva2f4B0nFkdklIC/b5s9GK2qZcGcRucj7QZwE+kbt+SN1GJ24YiRefkpvSvn4MFiI@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAqyDkuI61DBkxdsdjG/s+0fGV4vGfLR5+xl9jZ5E3Zx+sohW
	mpQTS1LuDqohc+WlqeKfRFgs2Q7vEUf9n3YC1moXFVhmntSijKMbEr9qA8mY0LtOeXzP1xxYsqw
	EcQuCrsn8dGNFS9Pz+6HDqtRmPzAtqg==
X-Gm-Gg: ASbGncsUM959wxmGes54N/MQcR6c6rMKHQKtxCSu/kmzcbshnVTriG8koay2ZAwDOK7
	4jbv2SmJa/3SMlZ4HWyEtIgCxOAHeNxnnAwkOX9uTEFhQKD2TjvUfmkVk7umbDCT1KSMMXfkfrc
	A3PacaYpvVRR5doQ83M5ia/atzcGi5mhRyH7CSGxKDzu0sW4eci43AhW97jHsRjRDhjVQyM2WAW
	+CM54QjUnB7hQCTaWbhGxScev5AdvofsjNMFA==
X-Google-Smtp-Source: AGHT+IGaLw27Ljz9znErL/wXlKrmw2vVvXcybmvvEgz/5LXcZQr8XHkjzeg+8GuJGUPK4l3BPO48YVyBvFg6Txiap80=
X-Received: by 2002:a17:90b:2d4e:b0:31e:d9f0:9b92 with SMTP id
 98e67ed59e1d1-32341ec09f9mr14945541a91.14.1755469132784; Sun, 17 Aug 2025
 15:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723224504.70862-1-jihed.chaibi.dev@gmail.com>
In-Reply-To: <20250723224504.70862-1-jihed.chaibi.dev@gmail.com>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Mon, 18 Aug 2025 00:18:41 +0200
X-Gm-Features: Ac12FXxNZsd_NKVMb232yi7NEU5fcTyLEUXrOV2bg_aHCMaU0qA9kYq92dWFaRg
Message-ID: <CANBuOYoDXtH+9svKX6WzF4GOhEF8dgxLiFE0wwo5SWfqggUPXA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: armada-370-db: Fix stereo audio input routing
 on Armada 370
To: andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:45=E2=80=AFAM Jihed Chaibi
<jihed.chaibi.dev@gmail.com> wrote:
>
> The simple-audio-card configuration for the Armada 370 development
> board incorrectly routed the left channel signal ("AIN1L") to both
> sides of the stereo "In Jack".
>
> This commit corrects the typo for the right channel, changing the
> second "AIN1L" entry to "AIN1R" to enable proper stereo input
> recording.
>
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  arch/arm/boot/dts/marvell/armada-370-db.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-370-db.dts b/arch/arm/boot/=
dts/marvell/armada-370-db.dts
> index a7dc4c04d..a9a05d826 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-db.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-db.dts
> @@ -119,7 +119,7 @@ sound {
>                         "Out Jack", "HPL",
>                         "Out Jack", "HPR",
>                         "AIN1L", "In Jack",
> -                       "AIN1L", "In Jack";
> +                       "AIN1R", "In Jack";
>                 status =3D "okay";
>
>                 simple-audio-card,dai-link@0 {
> --
> 2.39.5
>

Hi there,

Gentle ping for review on this small patch,

cheers

