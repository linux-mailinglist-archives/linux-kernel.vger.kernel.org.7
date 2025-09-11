Return-Path: <linux-kernel+bounces-811861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD28B52EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87585171FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56630FF3F;
	Thu, 11 Sep 2025 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdKPMovo"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4F2E7BAD;
	Thu, 11 Sep 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587190; cv=none; b=avLpt4CsQjIk7zvUcUNctnCoX1WlZBN/r4ZA0dUXh/fMg262xNuYZCXCXLbhZz8SRKtXtdTCkIY0l2KK6TlyHMQ7fHildC8xgx9wsKVtUqzPm8Cms7ohEJvp81+b8Nck2aEbIGijdUsQzNRPXn7uJ1CyQr0MNRQdJEL5vtxwrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587190; c=relaxed/simple;
	bh=UNGCJmmeHVEWauLXJHkwHmIe5gGbiGUznfmjg75Y67c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+de88zXOX2lSqxPE+66T/dJkofG8ciuWVYxJzak+WEUFBESDsXTB32reQJR2krU4fZZLFWLnmn3Y66x+nS/0izDCem7IzAHneNMDdvxE+UT+V2kS3Iki5mmeHt0rW87S2A6fjkzdoq7HlaOQRRGBe405K3D+oibwCNT93l/90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdKPMovo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-31d6e39817fso633934fac.3;
        Thu, 11 Sep 2025 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757587188; x=1758191988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLjSCnWswzv9dZZDKZ0ejlzc7IJyVoJkpxm14LgUN2A=;
        b=AdKPMovon6UeGb97Nrq6ilRWirsgd+jcI9keggVMycXrArdEZHKpOJ0AF1oXu/LBQO
         vj5Hh1Vjdr978Rox80LzN9vwxRs/UvWqpqGG5gWZ6B5gVjl5e27CUzy5ANYLt3e4Itq3
         rJ8QQFzu8nVysSOsnR1uVBMtPabgcNosug89n6YXNffQ5qiC3XUHuTT8xrCboOMbm0i4
         N4qVhjDYJ2MmYcIK3mzprn1bt3LQSNingwSqEh6sWnw2a+eLAczfwgKuBbT2jB3RBfnS
         aIs+XreFGcKdHSZnXr5tI+UIYy5d5KoEIPBcKzHCyAq9jUnvSBHWoJpXkzlovBIScOXR
         4GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587188; x=1758191988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLjSCnWswzv9dZZDKZ0ejlzc7IJyVoJkpxm14LgUN2A=;
        b=B08Gg6nxspme+2YUM1t/IIAksFqPMuzWs+FszDm9njwI0Y6TEdaBEt4iB9iJpcTjjn
         90sL7p3QPQpTpCHNULRqI4yFrntP2Y9Hxqc5UoTciuZ7gOsOXav9KNUBqKlgS0mLKJqt
         oeCeuIXIMUeQKVEJTh23ChMe+tXaDB0+DKtJfugISmDF6O7HztVHHbZAjXABmaiCmv4J
         ryFGHCq3ItsALS+BbHgKh7n9VM08CzySoNYUBYGQ70FY+7caLr7n3xqrwbZhDvCexIdd
         3UvpNHccbTnY7TuCFQ8FvI5z2GZ9CgQTWk+vkUr7z14LuwkIr51Dvhkek78BeZySEN+l
         rmww==
X-Forwarded-Encrypted: i=1; AJvYcCWdEnjO4xCWhdvFBzvSn51akGO9WGx+Zn97stsJII7d1g4Y0fydqIv5p93+cRDkqu2YYa/rjDNDqRF1@vger.kernel.org, AJvYcCXkJ19yRL66K2FWrzmq9TApkCUAtKJgp/FQkBZfFHf0aSICYh/qmWpLbamwDqawpCivSwmFVznhG+A9cs8F@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZ42aR8aaIR2fNUwxtVM0Gi8CLGmSoImSd30tsra48KxZIA4B
	EXFmZt6jNv1+8gfmdZhvhZL++els5DZed/sNaTAlJiuCiGLVIxo7gjVgK5Yeuq/UgJ0g2tCCm5T
	a9pmWTzv7Fvk91CTQIIKfDGRfvs02rAY=
X-Gm-Gg: ASbGncvJeM5MPrdbFNe+tZDwZmq0vD+uZhwLvB6tMfziGu9xclqDU1k5wunajcW6h1R
	LBfxB0FGsfWvcA5paEQ1mZSQN4MNXsVXVVGiFkPPVIgCXZLsNEAIHQclSKHnWPpqFAaNmc8LIFt
	q0K7hIM9tW2al1QfCeH8z9i4kqJY4NoPZuBlYLwZDd6e3iI7MwuPbi2WlordlN9xOiCtfY31VVr
	wBIu/JJQrIH0njjN0i3Ca4f+Nk48btH+vOsopLqgw==
X-Google-Smtp-Source: AGHT+IFyCkhyOO5BdxLqYhRVEoHLOKncnMI10XYYASRWLWgCIofWQYolA+/K09A/SdRXA+1mjsurgRLKWiZBhqwM3To=
X-Received: by 2002:a05:6871:d489:b0:32b:d4f1:89f1 with SMTP id
 586e51a60fabf-32bd4f1a28cmr2767601fac.16.1757587187676; Thu, 11 Sep 2025
 03:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com>
 <49db9339-b2a4-4be5-b0ba-005b3ed493a0@kernel.org> <CABZAGRH+B98nWGga7cVniwL-ev00nA2zZkLx9OhZDA2VVgMB6A@mail.gmail.com>
 <CANhJrGMa29YMLUJSL3yqxC+AH+wcLNb8Qe_aiN2uuM9ZCvF72g@mail.gmail.com>
In-Reply-To: <CANhJrGMa29YMLUJSL3yqxC+AH+wcLNb8Qe_aiN2uuM9ZCvF72g@mail.gmail.com>
From: Nick Huang <sef1548@gmail.com>
Date: Thu, 11 Sep 2025 18:39:36 +0800
X-Gm-Features: AS18NWCiHma0gY1K7rqjlYLs1_HbIaST8Q5Euaa4jJzJpE8oJOca4cQdUYtCVD0
Message-ID: <CABZAGRH=cu5_HZwseJ+GuokUNkEPDzoHewebXmLzcMFaTGdTOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	weiyan huang <dory85109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matti Vaittinen <mazziesaccount@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> ma 8.9.2025 klo 2.43 Nick Huang (sef1548@gmail.com) kirjoitti:
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=88=
7=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > On 07/09/2025 15:38, Nick Huang wrote:
> > > > Lee Jones <lee@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >>
> > > >> Looks like you corrupted the subject line with the commit message.
> > > >>
> > > >> Please resubmit.
> > > >>
> > > >>> From: Johnson Huang <kusogame68@gmail.com>
> > > >>
> > > >> Use `git format-patch` and `git send-email` instead.
> > > >>
> > > >>> Co-developed-by: Nick Huang <sef1548@gmail.com>
> > > >>> Signed-off-by: Nick Huang <sef1548@gmail.com>
> > > >>> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> > > >>
> > > >> It took two of you to correct the word "and"?
> > > >>
> > > >>> ---
> > > >>>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2=
 +-
> > > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-p=
mic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > > >>> index d783cc4e4e..d16c82e398 100644
> > > >>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yam=
l
> > > >>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yam=
l
> > > >>> @@ -41,7 +41,7 @@ properties:
> > > >>>    clock-output-names:
> > > >>>      maxItems: 1
> > > >>>
> > > >>> -# The BD71847 abd BD71850 support two different HW states as res=
et target
> > > >>> +# The BD71847 and BD71850 support two different HW states as res=
et target
> > > >>>  # states. States are called as SNVS and READY. At READY state al=
l the PMIC
> > > >>>  # power outputs go down and OTP is reload. At the SNVS state all=
 other logic
> > > >>>  # and external devices apart from the SNVS power domain are shut=
 off. Please
> > > >>> --
> > > >>> 2.43.0
>
> Hi Nick,
>
> Thanks for the typo fix. It looks good.
> I, however, am curious how did you build the recipient list? I hoped
> to be notified about changes to these bindings and I'm not CC'd.
>
> Yours,
>     -- Matti
>
> --
>
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));

Hi Matii

I used ./scripts/get_maintainer.pl
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml to
generate the maintainer and CC list.
Sorry for missing you previously =E2=80=94 I=E2=80=99m including you this t=
ime.

With the current patch, should I resend it? I=E2=80=99m not quite sure what
the proper next step is.

--=20
Regards,
Nick Huang

