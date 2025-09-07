Return-Path: <linux-kernel+bounces-804694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5BB47BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260B73B5E3E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD62494C2;
	Sun,  7 Sep 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmkV3Izb"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997C3C38;
	Sun,  7 Sep 2025 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252346; cv=none; b=oU0ZZsZzFw48MLJNwv9nycmwF5FyTTCDljnjaLcc+tEuElNUmwCBaqy5lcLiQJxhh/IBQnqKN6mKNBI2ldjUd5fgMIQrZPDxx9w1qJxRLr0JeoMud2wE5i85F/08p9r21vUJV+zssowBIRAi6gsDs6cg/wNlyr8hHZocchrTFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252346; c=relaxed/simple;
	bh=hCVSKOqNI6rT9Ic4HOwE8gr3MRYNp1aB1sdk9r43cXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im662Zjsbg8COG4qOjrqelNHM7WzASlqcJTpCu0Ez039anKROKKs54o4XapKI4N+odGXfYHsNm+xKD3QBIJyoz2kAEpph3ry3SHKkft1iHDSTswZdJGkxkXoxU21X8uVHjvB2PYiAiMO4h4gkbezGzFwNJ2mPN9zTRHc14hBAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmkV3Izb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-746d5474a53so1133385a34.2;
        Sun, 07 Sep 2025 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757252344; x=1757857144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg5hYRTBuoMmJcla3ZNoXDgwIuEPXV4U0p+U6RpgXzY=;
        b=GmkV3IzbLP4U4gMqo93uv8M0PaMarNaDj4Ml9mGUQ9bnY66bBCfD2trHya8HUM/ojA
         gfLug/4GCGdmCS61Lo/m2Zhy1k1MiMHfVtdmqQ6XZ9SyABNIwZqBQ2m1xkpsWb/8KFpb
         SzwEo86OFpW8RoFthO2IxnMXdlgMdVdB9BnnJzSB2VRJw6yMtPwnRJUJ8IGa1gCMTdRh
         h+R/Tj3+BEeFBzamcSaCs4InUiZGgP4q45EU/9FcYk+lcFGzpH4K+ge2n4uYi/3obSKx
         f62PqxRt54OEDPPhKMzd9nACXxcSlNS1RNXMNvMTOW/7Yg6Hv+EVfPwRxKE16vW6P3oF
         0JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757252344; x=1757857144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg5hYRTBuoMmJcla3ZNoXDgwIuEPXV4U0p+U6RpgXzY=;
        b=fs1ZqZ+SY/OZEXNMmdnaJMQMxGaThwAPkvrkuwdqyZzi4hqbJsuIndJCmLxy4Wi00w
         eHd4ca7C6IQtWSdFcR9iIppHBncS//SLxENW1U0oOpP/g4eS6nYuGOH/pHlp9K/ZpbjK
         xFCyQqr5uHlbI8lHpopNQ4yzfF6F0gDTrB+G4c9pMVR8swL/mjVaatK7zTaYtrIasB0W
         wJ+pa71Ss3QJBgCbxbMkzyfg7628vP+2oI1TYFseZ+PqRS9CRszlfibZkpScfYKz0lGE
         wnJKdKqobakxe6+AaGu5BkOgg3dRqhSM4lExsTzjLN6irNc3siPcBWtDeuSOYRjUnnrO
         HCFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9aeSHLhn0ihbnlXDDZMH9O/yKmF4Jm5rFNB4IOvRZUxCecbWxN4DFyHpEFIArdY7fMOw9MQYjB3Fx@vger.kernel.org, AJvYcCWHOuyhnNUXoQmJOWr/BEMrTqJlTAxPXu5PLgQfPFjYk5qkByPesI1Z1/4DS4p7lROuw5kfy4r26Ea/Mh7l@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmo2x2n5fhlmzE9qOusFxjBj8zhhPlCNu9WEnRG98AIi/yejBP
	Mo6fzRb2k9sJD3oFtMioVM4Rf5ZICUxkXJJAnZ7CY3PU8J/jOLg7PqekQ93TVXAfIa8gZj0jDuc
	DIKlVASiwBpaxQTnYxs+GdkOYtl/kzORmxQroLdw=
X-Gm-Gg: ASbGncsv+Joh1LhUVc7k2LqM7r97Zy6DIGAtlTQd3dTDSQ2NX8pW8QRGdNKqmTJPHyA
	SLPcqMlDVvyi4O6DR4/95gKTXPjGFTzPD04wdxwwDRDXOBYwZ3n+NTZagGQjQohnB5PYSlJH2yn
	INNaY9MODjyWupMNTacZzDlGktBajiZMt7y3ul4Kg8w9mf4WCdKn9Onb/rjpehiRXHo+ln+xcOj
	G7RkFv9b2nN7ZV8HviAIV6frkv+DQ==
X-Google-Smtp-Source: AGHT+IFWowJxi0HU0HhTmdgVwg8ZHBsbT84KB18dj5+PMiQWQ9ZwGXApazxylXrgyxRrIjtTw/LMrcHR4FY2RxfFD9E=
X-Received: by 2002:a05:6808:d48:b0:438:42d1:2071 with SMTP id
 5614622812f47-43b29a6cacfmr2451210b6e.14.1757252344545; Sun, 07 Sep 2025
 06:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
In-Reply-To: <20250903074205.GB2163762@google.com>
From: Nick Huang <sef1548@gmail.com>
Date: Sun, 7 Sep 2025 21:38:53 +0800
X-Gm-Features: Ac12FXzwHt1wYtoKBFqFUWbaMgMC3JPZG9nUEXW-zPSi2eYb8mSiw0DdkltVXi4
Message-ID: <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Lee Jones <lee@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lee Jones <lee@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=883=E6=97=A5 =E9=
=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Looks like you corrupted the subject line with the commit message.
>
> Please resubmit.
>
> > From: Johnson Huang <kusogame68@gmail.com>
>
> Use `git format-patch` and `git send-email` instead.
>
> > Co-developed-by: Nick Huang <sef1548@gmail.com>
> > Signed-off-by: Nick Huang <sef1548@gmail.com>
> > Signed-off-by: Johnson Huang <kusogame68@gmail.com>
>
> It took two of you to correct the word "and"?
>
> > ---
> >  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.ya=
ml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > index d783cc4e4e..d16c82e398 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > @@ -41,7 +41,7 @@ properties:
> >    clock-output-names:
> >      maxItems: 1
> >
> > -# The BD71847 abd BD71850 support two different HW states as reset tar=
get
> > +# The BD71847 and BD71850 support two different HW states as reset tar=
get
> >  # states. States are called as SNVS and READY. At READY state all the =
PMIC
> >  # power outputs go down and OTP is reload. At the SNVS state all other=
 logic
> >  # and external devices apart from the SNVS power domain are shut off. =
Please
> > --
> > 2.43.0
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]


This patch was sent by Johnson Huang on my behalf.
If only one person should sign off, I have already discussed with him
and will keep only my own Signed-off-by.

Best regards,
Nick

