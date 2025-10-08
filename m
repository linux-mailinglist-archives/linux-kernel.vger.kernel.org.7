Return-Path: <linux-kernel+bounces-845168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEFBC3C12
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F64D4E925F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56DC2F3601;
	Wed,  8 Oct 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2mGKk8o"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B22F0688
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910837; cv=none; b=CVNMFi6NBbJX0lw9mto1AUrM+Q647w90/mDQyGqZWzz9VWglvnmTsDrJN9QK+jH4jst5d2Up3t+1gduVNy1ZjnX4Yn2Hga+1M0dDv0E9rzZvs4kNrWZiYG+lC9HxQJ5sn6mPS4nkSDoLJJYJULHRfFpudyIYAW+ktEdF4rivBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910837; c=relaxed/simple;
	bh=lz3Dr9+oQCFUFzdJjDUHVM7lAqaXzoxTfNaEvT4TpvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kSZa/Ay4hsJUMtnq3XHt0X1RIPcJfjHstcBbTst8iCkUXxDZ9WLZKj1SoO8mpGrGjmPEnxpONJHYt1mRyCLO2/PtpFVw+0FNDIijhokRCze8HlyXujogEt5zWQDTBl3Eoie7NEy7gEqunvrUY6OYUK6QAlEtJSEhmTjqPzTzGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2mGKk8o; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d50882cc2so1334622766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759910834; x=1760515634; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lz3Dr9+oQCFUFzdJjDUHVM7lAqaXzoxTfNaEvT4TpvI=;
        b=V2mGKk8o/rX2W82CRvTJEJ6gGks7L42Pk/5rBzqVDEmh4Y2rrjE9gxowcK6rTwbffD
         1upzhol0/oxWHrZWZwlasvf7xuBizFvxRmozx8x+Pr8iY2RN9YV+96YDHgSx5GkmmcZI
         SvTGov/YDHjmBE27TAv9WAFl24jELiXnsvC2paU7yfG0zkacbXm9KI8YoRaym895KRPd
         MYze4Jtnb6yn1lU6CoWnOVQeEJ4uBauJpBuPoUDk6SuiK/G8UvZLIj2P6NrfyS64o3wS
         Db/psh9+So8mJKWVqPyCm+zgnDxlYZUfWQhURcVQspAoDVQkgYN3oeR0P9kg0ofqTb3d
         lQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910834; x=1760515634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lz3Dr9+oQCFUFzdJjDUHVM7lAqaXzoxTfNaEvT4TpvI=;
        b=gCVgfOCuE+j9NPPJdwWM5yP6SdJ4ofPIOi2m0pCWSNX47C3ly+aKSXWSAE5Y2JnmLn
         e9h6Z75fL4ghVJfdGMpmUhqqWNeVFmNx/HpGrYm+QF47RX7B+Xt8lL1TTIDXLuucu/0b
         8DqsA4sPqMkCUdeeQcptVmf4Erjix1BQJTJRjjPh+TdbYxdX6cw5Pqrk3QRoPD9MTnXS
         IJu1JhkkUMPSxSRED1xydwGeZl2eJfX27Ba1ofuUfg5hCWENOk5Z2+UN3LMob8ptE5/k
         ngcaejQ4QHlm+6+QEODSjAXfkQ3ApzbRof2+aGsvgiscCIGzokUu0A6QyIAa5JJ1OWvj
         5VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWympsQCAIC+gJnwzPXG3kTBp2JcuQuj7n4cW3JbXoxU0ssKrDZF1b83zcIiaj2uDtzhTFRbQkiBgjp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IAc/ux/J1/HNI4mkb8QAlbabKjzGuZ2qfXXJFV1nHFIeprpV
	8T4sh57AiT652hSirxaKDVzHzHsgEnBfW+UIIoXF81FIvUE8VpXQ/esrrNqg0Thf3wQ=
X-Gm-Gg: ASbGnctBr9Icq1dkBxZmBOm7yD+03tK7XhoiilvLoFC3YKf7G++h05PDRYj9jnUcrer
	3FvDsdEwv/FtXc4jSjJSyZW/wVGMeDKSSPCMeQq/hNTevuphE9Gqc18tdW+RNtL6mzSB0Th0YPI
	VniFLF1Oplig1WOUxi4JaVATG1VogH8AXDO5csH9OaAt1CnZCNv5TCBRjplvtGXougQJOFijlhf
	LkkzxhwiDc854K3VOkYQopjXvqeMk8WzqLDgE07G87q/s8FoiCr8vsn0NLOOEH9oEu179VodE08
	xajLR1P1QbZRpvUc/oFq11D3Qz5SgKajTZGE1bbb/1KG+jUkMI/B+bxCRk9n6MJHnWbGI+mT+H2
	FQWevib6sAiPr1YlqaqcQueul4dFKAItKvHKLuYWHhA5Z7PHmarGLU/B/MxyzOIpB
X-Google-Smtp-Source: AGHT+IHtm6BHE8ZRQ41FN4MsQQmn1glSpIZ2QsHJBtFdvnhqSHUzpN0y3S8QL9OiODXZeENcyC/EIA==
X-Received: by 2002:a17:907:3e1e:b0:b3a:b22e:dd35 with SMTP id a640c23a62f3a-b50aa48d854mr270829266b.2.1759910833825;
        Wed, 08 Oct 2025 01:07:13 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9e66sm1563103566b.14.2025.10.08.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:07:13 -0700 (PDT)
Message-ID: <e91f6754bf13f1d42402fb708dfc2b3d7bd59a6b.camel@linaro.org>
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
Date: Wed, 08 Oct 2025 09:07:12 +0100
In-Reply-To: <002001dc381c$85e17fa0$91a47ee0$@samsung.com>
References: 
	<CGME20251007160147epcas5p305e74b7b3449b934687396e9c8aa3ff4@epcas5p3.samsung.com>
		<20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
	 <002001dc381c$85e17fa0$91a47ee0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alim,

On Wed, 2025-10-08 at 11:56 +0530, Alim Akhtar wrote:
>=20
>=20
> > -----Original Message-----
> > From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > Sent: Tuesday, October 7, 2025 9:32 PM
> > To: Vinod Koul <vkoul@kernel.org>; Kishon Vijay Abraham I
> > <kishon@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Alim Akhtar
> > <alim.akhtar@samsung.com>
> > Cc: Peter Griffin <peter.griffin@linaro.org>; Tudor Ambarus
> > <tudor.ambarus@linaro.org>; Will McVicker <willmcvicker@google.com>;
> > kernel-team@android.com; linux-phy@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Andr=C3=A9 Dr=
aszik
> > <andre.draszik@linaro.org>
> > Subject: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
> >=20
> > The UFS phy can be part of a power domain, so we need to allow the
> > relevant property 'power-domains'.
> >=20
> Can you cross check if there is a separate power domain control for ufs-p=
hy?=20

I'm still having some other troubles with the hsi2 (UFS) power domain on gs=
101,
but I can confirm the usb-phy is part of the hsi0 (USB) power domain. So fo=
r the
ufs-phy I presume it's similar: it should be part of the hsi2 power domain.=
 There
certainly is no separate domain for the ufs-phy itself.

See also my reply to the other patch:
https://lore.kernel.org/all/ff3a0b96980669f326ed02ed81b97d34c104b09d.camel@=
linaro.org/

Does that answer your question?

Cheers,
Andre'

