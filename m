Return-Path: <linux-kernel+bounces-804885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A6B48160
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4A63BCCC3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570BE2253E4;
	Sun,  7 Sep 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXbvDrqR"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29925771;
	Sun,  7 Sep 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757288603; cv=none; b=IVlsdP4qlJ29CefeVT9k4Nvx2JNgv4pMNsfXWBKml12F79nFT25n8HGUYznnwgzMrbUpP8sCfyMma9LcdDolrwHfbNY1/mty4EB0lisHR5KD40xsH/TTH3UDl+RsZtMn+zORiURj+NZNLaABO+ZQQxnVu9SBBH5MJ9e7uA5Lvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757288603; c=relaxed/simple;
	bh=5WpCK9DWves0I2feGleCVQXP78pfs2xzAnpxxs/rNk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln7b9u+1nIkzQDo+CHbKB5O58HgUq+Lz81thf7hClwvze4ZfsMKefxaBD7lQTud7PDbAzIyCLhprco4pybBPtXHUTN2MCA0Pi+hv2uiYLHr8iWsLclPJbdcNYdmf4vVMRc3TVcdgPESx76Zj5ZXqrAnk7HR86jFwVJXxQlj8Wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXbvDrqR; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-32314296757so1068983fac.3;
        Sun, 07 Sep 2025 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757288601; x=1757893401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1R5m2ofcDqn5MZgtRWBTb5ZpZg0imfutMdx76rGnAA=;
        b=hXbvDrqRl84w/BYld3S2RMruoWAZggzrEO+8mhz8akMgohP2+o4dPz/fdOSoidsnXv
         DIk60UTisShkb+OR0Nvz5ex14j1kVEaf9cdaoDh0M/EwzCBNWpHarjUeGuzRDn/Ep3HI
         lmYRqX3spbhWySbwDwfr6oc3i53w165Gl3gbX8xktxuAaLnGJRK5cNLZ7+5HdRBCJvuI
         EsQedtukorcS0+/sF1/UVp7ludfpRNK5QD8DNviPvS3AtgEgN+BT/vz1JCL17yMVfgjt
         5rACznZF916hQTe5SYpkbuUoSZKpxqNZMFrXVOAapuabpZRhles4fFunCG1BaaiwcrJY
         aN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757288601; x=1757893401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1R5m2ofcDqn5MZgtRWBTb5ZpZg0imfutMdx76rGnAA=;
        b=DFT4jPg0RKyadR7xZVDsA9BpL4uz2pYURiHHwkKr9SJaS/iDqYjocJy0O3co1vcKmz
         CgxowW9FtOX2SXT3QvQTehAWxOlNitsYz4Int2RWViGTn3EBIC/26io28KLPkhjRm+Zb
         IHG8+EYrRphqkwdj1BkLiVGd6HM+dvVc6qNq+owsi8WnlaWq9KFON5DzEWam6/1Atox0
         FJZoSgGnZfdxQyTKNgDRugqcCe9sXhh486bSnu+Nfs5MLPuaVcq15i9un1xAQdU/YkHH
         FbOqHkQsGiX21tEeegGrk6Zer+Qjn+J0TR3RAUAR3EbkMxWxhrIXAyovLjYa46QHsYVa
         IuhA==
X-Forwarded-Encrypted: i=1; AJvYcCUtz51fjmB/yFT28goR6+eAfh+lNBJo5D2stXSpnZxpTx0vBkaZnDdOhiW5HWH9mI9KT5VmMHSfLGN4@vger.kernel.org, AJvYcCWApyIIfNegu0iuwRrIETbks+W6JmzC7leSSEppTxfTvqUlgYRYOix+aWLLQTu9db7QvZ7X/Ru5BQhzTSWl@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRts/slhu1+cCFLATH4i0UP0OuWIy+Kpc0AXDEnFSSIcupOjw
	UqX9sMwVTAw0Q5POrzpjhnlGscI7e2Zi0lcvuzDdLpXfeAT09wBVxF9hHdTZNc9FT3SuE2lAC1U
	R6wwuqYABchpQtwRGSNrfKO6JawtYFaQ=
X-Gm-Gg: ASbGncs7uTN2LufR4zXPtGv6BR5IQtGpnS11kJAWQqVKFL52UWbcIUR/0WSrdVNWEIV
	cYpNv+MZK/hGgCc3Ts5lBnc5Nmef4LayVMMyVKYNnTcwuPVeIu9d5SIJPeVjCAwiEVxO56dtLZa
	9fOPH+FwMvFFRtdRA9aFuR2KxTdto6BOlW0ucGUtQ6qlytyd/UMfrpuPDNdanKcvxpcPLCpWENa
	AzNeFdD
X-Google-Smtp-Source: AGHT+IFN0qdS59XsIqM64KAQQGMLSbZHnMsFT6y4Ksbrai8YGYOI1NaBBm779temHUzjnHl6rmKtJ84jFBX02M41Mjg=
X-Received: by 2002:a05:6808:1b08:b0:438:2199:6874 with SMTP id
 5614622812f47-43b29b26eb6mr3009468b6e.50.1757288601240; Sun, 07 Sep 2025
 16:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com> <49db9339-b2a4-4be5-b0ba-005b3ed493a0@kernel.org>
In-Reply-To: <49db9339-b2a4-4be5-b0ba-005b3ed493a0@kernel.org>
From: Nick Huang <sef1548@gmail.com>
Date: Mon, 8 Sep 2025 07:43:09 +0800
X-Gm-Features: Ac12FXwWUpJPGjF6PTjmn9l5Ph1ZMVOP4982juyA7Sf5FUNNuayb8VceQ41I1yw
Message-ID: <CABZAGRH+B98nWGga7cVniwL-ev00nA2zZkLx9OhZDA2VVgMB6A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, weiyan huang <dory85109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=887=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 07/09/2025 15:38, Nick Huang wrote:
> > Lee Jones <lee@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Looks like you corrupted the subject line with the commit message.
> >>
> >> Please resubmit.
> >>
> >>> From: Johnson Huang <kusogame68@gmail.com>
> >>
> >> Use `git format-patch` and `git send-email` instead.
> >>
> >>> Co-developed-by: Nick Huang <sef1548@gmail.com>
> >>> Signed-off-by: Nick Huang <sef1548@gmail.com>
> >>> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> >>
> >> It took two of you to correct the word "and"?
> >>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.=
yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> >>> index d783cc4e4e..d16c82e398 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> >>> @@ -41,7 +41,7 @@ properties:
> >>>    clock-output-names:
> >>>      maxItems: 1
> >>>
> >>> -# The BD71847 abd BD71850 support two different HW states as reset t=
arget
> >>> +# The BD71847 and BD71850 support two different HW states as reset t=
arget
> >>>  # states. States are called as SNVS and READY. At READY state all th=
e PMIC
> >>>  # power outputs go down and OTP is reload. At the SNVS state all oth=
er logic
> >>>  # and external devices apart from the SNVS power domain are shut off=
. Please
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> --
> >> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> >
> >
> > This patch was sent by Johnson Huang on my behalf.
>
> The From is malformed then. There is no single reason to change it.
>
> > If only one person should sign off, I have already discussed with him
> > and will keep only my own Signed-off-by.
>
> For simple one letter typo? And then you sent three patches one-per-fix,
> which is way too much churn.
>
> Best regards,
> Krzysztof
Currently, I sent one patch per file for fixing a single typo.
In the next version, I will combine all the typo fixes into a single
patch and resend it. Is that acceptable?

Best regards,
Nick Huang

