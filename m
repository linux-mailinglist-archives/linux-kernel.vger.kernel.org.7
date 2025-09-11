Return-Path: <linux-kernel+bounces-811418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B56CB528CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F1C56519D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D524BBE4;
	Thu, 11 Sep 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/R9okPm"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1009238142;
	Thu, 11 Sep 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572400; cv=none; b=htpquHUtR+cBHLo7rqC2L485feomaTmufeCKj5y/uDqpX2gy6XLE6XPqFRiD7ZLqfiPi7gNSKU9Owiu4nY/AidI2akiSzsivpcwxxjtraHP5A5T1HmzJVGV3LDukxEcwUMbSA9zuAbsJlSpYmq/Wkk/+lFRCVV5Ahhgj2KfhDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572400; c=relaxed/simple;
	bh=uvScEIM/afzzxjdPV5Xl1jMKnkvszb/XF0beRADiX+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRV+BRFPormD65odSVmpQPYpCXy/e8Bha11V4q8Cj1rJd2OI5qOWglpbacIRV/EiOacPHw7IhACHczCgUYBWFaGEhfh4wJsjGEes96C0gIZLW0xoKL5UaysmQpnb6NW1ElOVKKp0s1DgbJqGtarVMUGChXCOrZ92HFfMuPIN/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/R9okPm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so236581a91.2;
        Wed, 10 Sep 2025 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757572398; x=1758177198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LM5Pvg5BsIFt5z+SVzlehXV1m0UwhXg3szUWfgfVE4=;
        b=k/R9okPmFMfRqiONIeVgV1+n+clPtNWAOg3oqKvMjywGrsPqw5glnSbV7UfNmqOklj
         tdgQD/A7ghyXA9DWwoqlGgmSYEzKQ71kMvW8Se5tAUGjs9lUTuplmwNONyPIjcZNwOhJ
         TK7/mlG7Gh1tdA6vG6VtgkNAFwukK9IwONqmvAzvmmTxgElKwHbQEcSMNjJJhZgZtiN8
         JLr68dOlzaOeGQpdc3PvtBlOnGx+AxZZ3H8aX1o6822b+h2IJns+2+yaZx4S3QWNIXYt
         QEfjKDlNPxWmgQSRel6Fvhq9AomNfBcUlcg8X2uCbU4jCEI2c/ehgaeTLzLxCTGSW+i9
         hb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572398; x=1758177198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LM5Pvg5BsIFt5z+SVzlehXV1m0UwhXg3szUWfgfVE4=;
        b=CRDRZqDMhPqA0JeeNG8iaFz/IoSHhPv4kOwH/GKZ6b3Cnhp+kiZ3xvs1ZBOEl9804B
         iLJVdBFK3yjPW5MYvWxKhnTO9jruptZYBqI/yvRD3ItH4D7IPQNepDY9t/whm9dyXWHa
         yIRhyf/8o2vu9XqepMxPpjnkwt64j+KfzhQmjWUFpFL3DFRVn8rxIv1d8vPXJ2A6VT4g
         w/qZ/K2pcdirxy5auyL7byDkZIZb+tSOj4h2WaZN6gXrfcFPrOJGgQasdVNvK8VrsRkA
         FCyBlI1wX81SrlzqFeaMaXX6u4B2+lJp0uCQ808rss9QkKy3eullfiOiqDTsEI9JHyfX
         Jipw==
X-Forwarded-Encrypted: i=1; AJvYcCUFY5xBV8YobixJvYJMgiiIPyYyGLTbWDRzjKMxXUhtPzy521mUof9CiqkmkV7MdQsi1hu29p9DwDtj@vger.kernel.org, AJvYcCWHLsGt/L7E7yEThvrY1NYGKlVXHl6PtfIU1crT3zvBQJJInk8xMNGu00eg7DV2GvzZlDJas3FVcUea2wUh@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMcg7MeVCQxg5aslGDUZJP4ZHmpTqE1pl+SqEavrZcQzR+O4V
	fUgoXAu+eE2+5JMl6ZAewXKgKENH981qnCLh2cPYj4KeGe0fY4MJBJNApRhcdGcsoBfePiUymDA
	NE4JdU7gd7lBjryMw82AlSVkwHOq6sBw=
X-Gm-Gg: ASbGncuY1rPmf/3ttjntPik4vxFt40UOxQZZz85DdrEMxITWhpXiQrdMFOi+xoVK9iF
	29fV6j3RTCJvD32nv8HJtUU+NHZL0YTu+VWFYwiC8h/SRL8Zbk8CQBOwj4Wwng5nM8AyKVXIjwU
	Y+fuohOBJjA0g57cqFB7butSytCKFN/mYbdA6abzxN7y0jX0LDQ5SkdsWJ6FFNewXlzu9BRQnva
	mNqkk+8v0Iq4BPCOTBSCFjZbxCLKkxrYpjn+Zq/tQ==
X-Google-Smtp-Source: AGHT+IFmEN8gIddP3xTUY357MDA5IPWnhKOkvlOkLJ3SgdjzEPq95PnA2fm5fDjMoQ9iGX5gOqavQnl0ptzRIfiNC/Q=
X-Received: by 2002:a17:90b:4c12:b0:329:f110:fe9e with SMTP id
 98e67ed59e1d1-32d43f5bc76mr24382241a91.17.1757572397967; Wed, 10 Sep 2025
 23:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com>
 <49db9339-b2a4-4be5-b0ba-005b3ed493a0@kernel.org> <CABZAGRH+B98nWGga7cVniwL-ev00nA2zZkLx9OhZDA2VVgMB6A@mail.gmail.com>
In-Reply-To: <CABZAGRH+B98nWGga7cVniwL-ev00nA2zZkLx9OhZDA2VVgMB6A@mail.gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Thu, 11 Sep 2025 09:33:06 +0300
X-Gm-Features: Ac12FXw6bS0Qfg8U8auC3A13VBea4lnWf2dRfsPuLP_GT-Utusd0lS-EGuB9PDo
Message-ID: <CANhJrGMa29YMLUJSL3yqxC+AH+wcLNb8Qe_aiN2uuM9ZCvF72g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Nick Huang <sef1548@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	weiyan huang <dory85109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ma 8.9.2025 klo 2.43 Nick Huang (sef1548@gmail.com) kirjoitti:
> Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=887=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > On 07/09/2025 15:38, Nick Huang wrote:
> > > Lee Jones <lee@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=BC=9A
> > >>
> > >> Looks like you corrupted the subject line with the commit message.
> > >>
> > >> Please resubmit.
> > >>
> > >>> From: Johnson Huang <kusogame68@gmail.com>
> > >>
> > >> Use `git format-patch` and `git send-email` instead.
> > >>
> > >>> Co-developed-by: Nick Huang <sef1548@gmail.com>
> > >>> Signed-off-by: Nick Huang <sef1548@gmail.com>
> > >>> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> > >>
> > >> It took two of you to correct the word "and"?
> > >>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +=
-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmi=
c.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > >>> index d783cc4e4e..d16c82e398 100644
> > >>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > >>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > >>> @@ -41,7 +41,7 @@ properties:
> > >>>    clock-output-names:
> > >>>      maxItems: 1
> > >>>
> > >>> -# The BD71847 abd BD71850 support two different HW states as reset=
 target
> > >>> +# The BD71847 and BD71850 support two different HW states as reset=
 target
> > >>>  # states. States are called as SNVS and READY. At READY state all =
the PMIC
> > >>>  # power outputs go down and OTP is reload. At the SNVS state all o=
ther logic
> > >>>  # and external devices apart from the SNVS power domain are shut o=
ff. Please
> > >>> --
> > >>> 2.43.0

Hi Nick,

Thanks for the typo fix. It looks good.
I, however, am curious how did you build the recipient list? I hoped
to be notified about changes to these bindings and I'm not CC'd.

Yours,
    -- Matti

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

