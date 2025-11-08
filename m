Return-Path: <linux-kernel+bounces-891537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A370BC42E09
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311F44E3D31
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798A204C36;
	Sat,  8 Nov 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bw2oL8Nx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB118FDDE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610937; cv=none; b=IyQ5/1z8NJ3zq43LC+C0BqMeT1ZfsLMDndQbtGm6uPJYngYp+7VwSwwNFeH2nU2wPCQf3BjIY6mhAlEj1XR1U5avU9/btU/pU+fJT+UDa9dde1UWZJFzg8radMZP5wAYCy9mwUstprAE3csiBxGIJeHbQSrB6XMbY1bLGSK4Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610937; c=relaxed/simple;
	bh=88SK9HlF8ID4j2mgeXZK5r75pqvAiovy9hjLKXg2mUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEPDEOsYAJeg8oWP3DSTggekOZNy6f5nYgTI1xVP2ezOy8/mYbKbzPntudSK0Qy8D9n/H0g+Z8SRP/YzRwBQra/HQmtRuPGFPNc401u3yd5KIg29uktUs7qToUYX8uDkHuu5xOC1vQT94tK/07LhaQ2fFBtKMqdAw5JykqxnPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bw2oL8Nx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so262497966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762610934; x=1763215734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=88SK9HlF8ID4j2mgeXZK5r75pqvAiovy9hjLKXg2mUA=;
        b=Bw2oL8Nx5pdDvt2hub1vX/LWOr0w5YNESA2TcldKBBsBsyJmr2aV47BBk8BqOB/BDH
         z+AL9mKc17uEccImArnb/6hesdfBqfowvxh+YT4ZVviQm8yaMuwYVB3hgf4zyst+uiJZ
         H0MQPNbnehx4A3pb1DtFJNcuOTWcuM4HkJuxv1QONrNzrZVTmVkhtoi2uYtBxHfsPFqD
         wY8JIzCk6siJ+d6FXP/ZcUaoypqsv8TF9BmUy5uZweW1KbvcTTdStBXgqS9OEt+0xA89
         zcg2+McMY+QsKfyL/SjGMJuZSsmlPF4q1/ff1A0sVPpCLbXoLOR/g5vUpIOMKN8Oedvt
         Xy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762610934; x=1763215734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88SK9HlF8ID4j2mgeXZK5r75pqvAiovy9hjLKXg2mUA=;
        b=EZYoxv03HC2fufnXRYCaAPaseT35gl+JXpHZi+a3s1ke9HCm6WYi4uWgtBIdZeIdt3
         YNKPtcwdnQ5sMsArjLiqIM14dVJH/dbt+aZFghX/YTL1YOm9xcjhHoMobVtKirlWCP+F
         5vUcFvyFRajAuOMVJ+pV88WiZeL0Z0l7vp9t5DGb0XOAhA5gksP+jbezLverqsLgt/1h
         oecnGiz7s1YrV+RJCPq9Lx1RRG7rJrVao5xRiaOKAjcLLa+HAfeLvDp/ddDCto1P4Zfp
         i4mbOt9MfkDlAYDyVJfFyQG52Xiw+pp9aJ/g3G6payaPH1CMUmg+77Cib7bZ9nF6zokE
         T2VA==
X-Forwarded-Encrypted: i=1; AJvYcCUvSPDMPpoVFH5tjpp46B6iojntbmE/P6sDXejclHRdr+bpLcRIYGFFQWL1jJDJeRrlOZj+UWgywqfnn8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSglrrJBLaOLDzs45YOzfWAF+rVuKhlE/7JUmCphOmnAuySnu
	sHwZ09cZAR7cL2kUf/XKr/7yX666Nb1UUlK8hEKMMABkdFi+ooOGhKl2NBJ3yKIbqeY=
X-Gm-Gg: ASbGncu+6mMtd2LQqfjtYnxEn+nnfdpFN7kDcT3aZyFS8KWeosNFHBRy59o5ShTgVOc
	SuzO5J8sT+p1eCgO2ouSKe16ruymUynBNO068rc3g/70Yc3DemUeNp/PQZaHlHxSvXLJYk5st02
	ptjYMMw6YIzxk4rLB+G9LIxFmqiuN5XMNtYDbytHmfKKRXk9sy9mhuD9Kp9tRRrWxqxwifMBCwK
	zytPb64kHrGl4/7IgNPev89CeZfzXRTJYV17ERvZiHmIN5PcDj2qgfZYte6QjH/uYbuUC9ASisl
	Sz1pdpCS9wVEH2mQHMADFtLRb77uDgHq+5uZuxLiEzmL+zO8jYiVJ9R3+R0pft0N/UdPsMV7paK
	h34S3zapY5wukLRVu/YhlD7TyGlIzyizdfHQ3wkcZXHY6Sjs3CyPKulqNiTULoA/jmwweTn9Qay
	DE62lNqxZi1DZ1rPIi/hGI
X-Google-Smtp-Source: AGHT+IEU8px863DOF0SHJM2dOiCgYfSF7uWOZKjlSkmUmm2odBp/m7f85l+VxG8z6Xkcbao4KUCsgQ==
X-Received: by 2002:a17:907:7ba4:b0:b72:26ec:c8db with SMTP id a640c23a62f3a-b72e04e2c4emr263436466b.30.1762610933770;
        Sat, 08 Nov 2025 06:08:53 -0800 (PST)
Received: from [10.41.228.128] ([77.241.232.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm577021766b.42.2025.11.08.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:08:52 -0800 (PST)
Message-ID: <fa2e704a2f295f2c9b2c7811e8ca89972554ff7e.camel@linaro.org>
Subject: Re: [PATCH v3 07/20] dt-bindings: firmware: google,gs101-acpm-ipc:
 update PMIC examples
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,  Lee Jones <lee@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, 	kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-gpio@vger.kernel.org
Date: Sat, 08 Nov 2025 14:08:52 +0000
In-Reply-To: <20251104-awesome-tacky-magpie-bacd9f@kuoka>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
	 <20251103-s2mpg1x-regulators-v3-7-b8b96b79e058@linaro.org>
	 <20251104-awesome-tacky-magpie-bacd9f@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

Thanks for your review!

On Tue, 2025-11-04 at 09:31 +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 03, 2025 at 07:14:46PM +0000, Andr=C3=A9 Draszik wrote:
> > In a typical system using the Samsung S2MPG10 PMIC, an S2MPG11 is used
> > as a sub-PMIC.
> >=20
> > The interface for both is the ACPM firmware protocol, so update the
> > example here to describe the connection for both.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../bindings/firmware/google,gs101-acpm-ipc.yaml=C2=A0=C2=A0 | 40=
 ++++++++++++++++++++--
> > =C2=A01 file changed, 37 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-ac=
pm-ipc.yaml
> > b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
> > index 4a1e3e3c0505aad6669cadf9b7b58aa4c7f284cb..c25e155926e5f44bd74f195=
cdbff3672c7499f8e 100644
> > --- a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.=
yaml
> > +++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.=
yaml
> > @@ -45,6 +45,15 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: samsung,s2mpg10=
-pmic
> > =C2=A0
> > +=C2=A0 pmic2:
>=20
> pmic-2
>=20
> Are there more pmics? Bindings are supposed to be complete (see writing
> bindings) and if you did follow this approach earlier, you would nicely
> call first "pmic-1" (instead of "pmic") and then "pmic-2".

There aren't any more PMICs on ACPM, no. At the time 'pmic' was added, it w=
asn't clear
unfortunately that two nodes would be needed in the end.

See also https://lore.kernel.org/all/963bbf8db71efc0d729bb9141c133df2c56881=
fc.camel@linaro.org/

That said, I believe we can change the existing node name from pmic to pmic=
-1 without
any driver breaking. The sysfs path would change, but I don't think anybody=
 cares about
it at this stage, so I think such a change would be fine. The ACPM driver d=
oesn't care
about node names and instantiates all children regardless of name.

I propose to update the binding (and DTS subsequently) to add pmic-1, to al=
low 'pmic' as
a legacy fallback (i.e. to not issue errors during validation of existing D=
TSs until
they're updated) and to use pmic-2 for the 2nd pmic.

OK?


Cheers,
Andre'

