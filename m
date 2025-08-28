Return-Path: <linux-kernel+bounces-790702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18576B3ABEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B7B1C278B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A61273810;
	Thu, 28 Aug 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duuC6gdi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2D26AA83
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414028; cv=none; b=e5EaxvRleQ6MU2EMWtMBsIbsG7V1GZNNBkTm/wEMbH7X+hkTq96ReOQFwfKZ8/vd6sbUBRBn8nbaJBdxDe+iVW88MWMAy12LrLVbawQndoPVdOixt3JUNmFyC1GGzHHEORNeW2EmIi/0MB+9stWb9lly8XbzG3XgYdGNJvanFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414028; c=relaxed/simple;
	bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtCX1BN8H+3AqPmtO8bCtf0qt03kHSkmV8iN7TjjFluNL36NAtykSHTDCtUCLRiMqqa2L4HpfJdwdWGJBDLsspeDUW5C10ptz8dWG7BH/Z4NxLiHCuGmaJa/NRC1b7SkIgvKK75QDdS21YRqmXx/+VD/A9Ghnc0f5UKNng8Wjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duuC6gdi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b63d2e56so1114701fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414024; x=1757018824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=duuC6gdiDFxj9zSs7kJC5i30idcZkpCgXs3RsvTPLn41WIrZiLyjg47iKXVgDp0fGy
         sR1Ykp9kakPLjsqHqgAhVFhbv0MJWFPX7+pp+j8qDVg8p3yorBM7KzMIzdrCtrwfybW1
         o01WRpxJ90KqhKvZoQJJZ1i49LoC3j6DIjaxxgSUalbD83CnnK/OMUPPX1R2VkjF9EJm
         Fk5hvnS9St196MU70qE6Hm+tZ7nVCmBFILCDK0S7awwxLZAt9vNPeb/KWS6HLNT8iS/R
         KZfT7vTv1YgLyn6coGjbr57UB3adlC6qzvmLRus9O1SIvmDkWsV+8bN4ho9ZEdC7M9BF
         7sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414024; x=1757018824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=XydzPfnpLqAXhXw+5EON5wFqk91x6BJaBq5KFv1SPlrUuxErPxKnCG5HcJPFT3KCHE
         EL3wqh0/HAlgZ81NE7NWYdy3xNoc+MYmpMUdiZgYW9BJNc7cWkZeGMOY9gBNnjYkU1B5
         3jw+PYRH5cFeCyfaX7ZaMjBlqFgv8aPlinXrS51wy1GNfB+buuVKgpSsqzfHzYdkpUpT
         a9r6Jco2Bb0q+IPJ5qbTzcEPDiLW3560atNmmUd1kgWEn3A+ue4mBiXePVfWwIQT+gbe
         KeWNsWsM4Fr0T10bL6VcvZgDa9hS6Cp2HrFirpZqb9IfMVc6jr2kDb6ArZBqEvtysBnn
         tlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSAWS8bzCqWJLR0mePKS+dROxm9JvRBEZEgge3FkFnAAgPJNuZTI3FBXed215g5z7hvbObDj4P+KFTigs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDHzHsYk/HMX3iWPN8IOxHRN7IJwohI3hLKmQQB//IYTUbTRB
	AxlreS3uOVKZrHGm5pYspsJgx4S5xlg9XEYmBJx6jsVheOVsw8iH4THIsteK+ewljStKG7Apoul
	fStcDxylFpOhKzaw0ZLGLH3o6c2jTA/Sr2J4tmH5XDA==
X-Gm-Gg: ASbGncuqfmlO8VthUO2fG+7AL2wfjL5+p33ePZ4kdDtYzwB93L915cKoRPhvoFn+/Us
	M71A5XjiabFusFa4WHVumliXUMsfgCeVVjm36jOid9ltKKzllUkmqaxQ4xoeYVUcbp2bx7gBeiz
	ZteL7YZRcPM3kkUNJpj/KY6ub0AG5vchgF7JmB1mIgC4/U5iYnXNRv69UgeHz8eUwnxN1M7Gpvm
	mfvjpU=
X-Google-Smtp-Source: AGHT+IE2uWhuibXcObFZ5VTNIy6zlok6JnK2MWtwL7cqbL+/SAGd1n7jHXQKxLY98v4CVTQiyLHeR0E2ooltz4RMmZg=
X-Received: by 2002:a05:651c:23d2:10b0:333:f086:3092 with SMTP id
 38308e7fff4ca-33650e704femr56328661fa.11.1756414024499; Thu, 28 Aug 2025
 13:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-8-jacky_chou@aspeedtech.com> <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
 <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
In-Reply-To: <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:46:53 +0200
X-Gm-Features: Ac12FXzlvTJpPFPcU9uQ_fN2isTkkss2_BjIEzvxJnxhjmRwD11F1FNpCNVPGsc
Message-ID: <CACRpkdbmRpH1+HtW+vbK7rVk6OCEve54BxTAxrUhX631a2KP1w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:08=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> May I remove this patch in the next version of this series?

Yes, and in fact it could have been sent separately from the
rest as well, no need to keep things in a big bundle, it's
easier to merge in small pieces.

The only upside with the big bundles is to help developers
develop all in one place and have a "big branch" to test.
But it doesn't really help the Linux subsystem maintainers.

Yours,
Linus Walleij

