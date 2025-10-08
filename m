Return-Path: <linux-kernel+bounces-845224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7372BC40A2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908194E3CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9502258CE2;
	Wed,  8 Oct 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wndgDKdl"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBD5464D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914044; cv=none; b=tGVlgSqP8KMExVr3PnQYTfGNOBGSl3snsokdgbqTvtUekcCRLKjzDOqQep3sS2C648a7Guoe6w+K8FNmoYSp382JvWIsuJbooXNoTlZjcRRaOetVNPNNWZ0zoruoqeuXhctjQdG51jhxIjij1gbKSSeIuhaQZoxwUaPLz1mABEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914044; c=relaxed/simple;
	bh=Pz2l/rMRcLdX9YAbOqnYcT/TpRjS8ffGQdCMHByptm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhfAaebvMGrymUjlusokt7kxsZIVxkuWTNdS6Y9miJzXX6MChtDeGlIqa+DFH2utyA2ShtK7EaLKzQMetnRaRIX7RvX6Eta+lsV9ITdhi24E550D2Vc0wC7BQxpLfqYJIwdshBCXBD5alHnUKKY+b4UbpwYTSmCXuwll19o3vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wndgDKdl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso12959786a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759914041; x=1760518841; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pz2l/rMRcLdX9YAbOqnYcT/TpRjS8ffGQdCMHByptm8=;
        b=wndgDKdlGjvhN0lkBNwHgWGjKLY1qPIy5WutxFF/RnXBxbZeETAJREijUjNPtiW7OG
         UTKU60YS+sqqDRLPPaiTc2OTdF45/Y+tAADb4ZGCyCg9ZqlW0B4lEueovVjsKmD+bISN
         qeSX+KUndXHSICoGQoSdUqcCZl5Uq97fQDEcrjaTdDqJ9mD8IkLKJmyIGom/dTz/AZt6
         MUlI+VAtPyMDWxGdC81mXmEPWO8BirpkgxbtPuAVnJvj5fui5YK9LTYIQNawGMcRH97F
         CGgXkZtoBWwI56pYfCRkKSiMXQdOiGheU47yCwxyRc7564qpkugHXyqTd0+Z3k5ehUta
         0dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914041; x=1760518841;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz2l/rMRcLdX9YAbOqnYcT/TpRjS8ffGQdCMHByptm8=;
        b=NDdjBukdnhVCuwtvuGZ+/gantQqdUZ/h8yAuKa1pavBqhbHjzC+h1F0l2q0TntultO
         CvxMc3uWHPYTfhlhdRDvUm2VOpUX6KXyoFlmZDw1goChQdpaemtYELBjmZmjpse2DNAR
         Yfg59FROnHKWiL3mkXGqpcFsEp2nT4MdHPDfI3vr5PcJXuD9NMzT6VYHPjORGYa9bsSE
         Voh73OHHZ85wN9oLB5Wjxqw/0DqEz3QXhQ8cfALmnhA7xI8/8RCafcKtc5R3sMlMs61r
         ZC4ij+RUQbf0ZHsoPQsf1A3Cmnp9tAd2swSosR0PKVP8OBjmjzGPTxu9k9zIvziSRp5+
         c0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiInsptMs0IC2aeoJBMUTfJCPoxnueWZ7KqUFJqxO4HXavTHEsVPECKk4DweinUd6gBlDNnX9CD7S8mwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Pnm6S6LCBS21FDdhHNIXoeqWUyJ30FlMavMuvWgvlckqcP3u
	LQ7VAYRiD14JtP/3hO6lCB90igG1wFwhfODMvIaTjWz4PyH8y7kEcu0CzAoIXRFMUlgpbUEc0/F
	zUr4B3uA=
X-Gm-Gg: ASbGncvs32UqAzYkOewjrfDgoeZoxdczqmevl0gJ3FF4725CCYASoKqbDhYaZCYjpY8
	QNin74t3GMSiEEUlm097bx5BYdP5H34p/CjALQaz4D6IjJRDk1PxTHyHzXjfZadxbSYxkRygLMB
	7I1mSHwrYTK/2UvcJ3FK+okdSgDRjYRgpYXzA7dDusrddL/FXGCsjrVpS77ucMPj4RRdClGLheq
	73CTEbn6Bbfa+jSBwf8H85eLNNyAsxnLxPwzbnOySmq3Kf2e0BQ7UaAV0hyeyeDZa6AitAbtEU7
	CS6Nke6l7XLpi3uZ37U+hLwNDiRb+jtqfiSYvjq3MDQHUZAj6Ks4t8FizrQj2bTSLJx7W958f+j
	yWnXDkCIwSQJATebPLE90lJS1p70j+9oFNbYFN8WZ9MOk+Z+R7NMuQg==
X-Google-Smtp-Source: AGHT+IEiFXBypqPmbDwaI9Pl80eN8BhmwecP4sAYuvQIiYkyo/y3ydXKvIjc3+w6d6/oIwQoYDijOA==
X-Received: by 2002:a17:906:4795:b0:b41:1657:2b1d with SMTP id a640c23a62f3a-b50abfcc8dbmr297326866b.50.1759914040532;
        Wed, 08 Oct 2025 02:00:40 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8cdsm1604299766b.38.2025.10.08.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:00:40 -0700 (PDT)
Message-ID: <15e8c6620fd7b49a64df9aad75afccd32995cf29.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 'Vinod Koul' <vkoul@kernel.org>, 
 'Kishon Vijay Abraham I'	 <kishon@kernel.org>, 'Rob Herring'
 <robh@kernel.org>, 'Krzysztof Kozlowski'	 <krzk+dt@kernel.org>, 'Conor
 Dooley' <conor+dt@kernel.org>
Cc: 'Peter Griffin' <peter.griffin@linaro.org>, 'Tudor Ambarus'
	 <tudor.ambarus@linaro.org>, 'Will McVicker' <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 10:00:38 +0100
In-Reply-To: <e91f6754bf13f1d42402fb708dfc2b3d7bd59a6b.camel@linaro.org>
References: 
	<CGME20251007160147epcas5p305e74b7b3449b934687396e9c8aa3ff4@epcas5p3.samsung.com>
			<20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
		 <002001dc381c$85e17fa0$91a47ee0$@samsung.com>
	 <e91f6754bf13f1d42402fb708dfc2b3d7bd59a6b.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Alim,

On Wed, 2025-10-08 at 09:07 +0100, Andr=C3=A9 Draszik wrote:
> Hi Alim,
>=20
> On Wed, 2025-10-08 at 11:56 +0530, Alim Akhtar wrote:
> >=20
> >=20
> > > -----Original Message-----
> > > From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > Sent: Tuesday, October 7, 2025 9:32 PM
> > > To: Vinod Koul <vkoul@kernel.org>; Kishon Vijay Abraham I
> > > <kishon@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlows=
ki
> > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Alim Akhtar
> > > <alim.akhtar@samsung.com>
> > > Cc: Peter Griffin <peter.griffin@linaro.org>; Tudor Ambarus
> > > <tudor.ambarus@linaro.org>; Will McVicker <willmcvicker@google.com>;
> > > kernel-team@android.com; linux-phy@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Andr=C3=A9 =
Draszik
> > > <andre.draszik@linaro.org>
> > > Subject: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
> > >=20
> > > The UFS phy can be part of a power domain, so we need to allow the
> > > relevant property 'power-domains'.
> > >=20
> > Can you cross check if there is a separate power domain control for ufs=
-phy?=20
>=20
> I'm still having some other troubles with the hsi2 (UFS) power domain on =
gs101,
> but I can confirm the usb-phy is part of the hsi0 (USB) power domain. So =
for the
> ufs-phy I presume it's similar: it should be part of the hsi2 power domai=
n. There
> certainly is no separate domain for the ufs-phy itself.

After double checking the HSI2 HDD, the ufs-phy is indeed part of PD_HSI2.


Cheers,
Andre'

