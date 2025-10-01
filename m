Return-Path: <linux-kernel+bounces-838613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9BBAFBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14AD19402FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2A27F16A;
	Wed,  1 Oct 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBRY0eU8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865323594A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308867; cv=none; b=lWRn2CilbUQiBAq1IfZYH0Y8l8UTOXT3RXDm8no39fB1RxViF8Awv8H7qnGw3pJZRo/tRWOt7nfvk/jA5WnO9bmMV5Gphb8WESbQ7WrQdy6eRF4/WzHXJ2yjvrp/5QmvZiCqN116bPSCeSN+zaTxMAV8ptXqru4KW4tGy2vTBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308867; c=relaxed/simple;
	bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgcYnVOUzUtYs6ymraYY5oCULaBoUWkmL1luXV6qxLPvoSPkYL96oXPhKuEZ7mnJ7CE1L8iO9spW0F9FSBtWzu91k7pGqLUMmVywddUMWP6gojSdbdn6cNzvXtOkwmeaq8zc/JUEuBRFMZ+KZskPGYau91kyhjYsPB4k1OtT2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBRY0eU8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5375865a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308866; x=1759913666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
        b=QBRY0eU8r1XfWAXMKmj0Fx3Q1MYTQYPluYFWuwrfrLBjECvHfP6SpxosiN85WViT4H
         KNVtdzge5K4q/are8hSQFQt+FAVbhSovreAYW8J5sTGBqqGvy93Y8lNWJQ1uDJR9abv+
         6peMX4A9tkUFripY27Fehg8wB4iRDjj515UO3c+PmhrOK6GnrI5+BPsfnQJKbD+VuV1K
         IxEOtS2eQygaAkuTEUCFEhZVxe+EfZhRcbV+KxqamuR07JYM7FuKdAAaib1GRIJQo+yw
         y8k3+ZF3DjsdnfKg3m18KaZ0F58B6Ja/SwYcjFCOlrVgzlX2ou2XtZtGboiHgGUwMOwI
         OUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308866; x=1759913666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
        b=fRlB4gBg/lLvtOk6138848pZGN904nsfcxBn2hpzvV8a7bez2O4MYIGhUXGaYAgB1M
         kZ0R2NVeMBXEAuyAvskni5boViwRsDuzC9C7wumoCbZI8pqa46nK4L+UT/ZE2en8x1W2
         /FBaVltBc05kLnISSB78CgrPrVCMYx3kM5KjAMERj5HUXgf4ldRZ9LOdatk5v2by71vm
         gsquVBSaxEmSM1na9zcqiJlXIMyObCsWiHb5q5vA2XkwnSAZ8kCUm/mwJbYHaZ+2b+YZ
         I+B5Kr+104JSBkLx5iJvsglbOyEO2MC2/z6zrUf6M8KcRHrHz/yC+2uDXCULuwTThYcF
         Empg==
X-Forwarded-Encrypted: i=1; AJvYcCU0PzHqc5hecV9GkaAnOBAqXDn4/BnDg1ITloEMGnMqdmwYyQyqHlYf0TFNgSROEE9jeQD4OA+pUYk9hiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNy34wNXjznlS7wBUF1tSBfmgXCLMocJzjw1qyyBAoiNXAl/d
	YIZiikF+FGYgWDdvVewpKrIhwV7cUlG/OgCP8v2jt1gEelBHH0QHm2RWENQnf+RgpV/wEPrTkaB
	frwy0MqYG53FIu5WzrXi3eDs9oOPbSPg=
X-Gm-Gg: ASbGncsswPXd0J26nCeEt0Pk92mmL8Li79NFeRbOmvQTBoi5dYadYFCzvRSorrKvi1D
	YLpu9mlyVI26979LV6BpaT64HXst6pjoEDe+PGs/toWqe32gkCtZtUz/hYDYFpgyn6WhqJDP3gp
	Mnjz0p1a1Ehe9eIsgd1putMLYNQvfdXBd2qGtFRjkah+GE5O3q52Usi40iNW/OrddUxAgsZUOQa
	C6FP2Y1vHu1zVUh8BdOZkrNSm9tt7DnnsO2AR2WPCup5FY8sSEbn4tYXCyJA84a3A==
X-Google-Smtp-Source: AGHT+IFkHVvzIlBnrVeHVBtBctgazh/MCfsQv0mLNCnxfXKJW1PT7QAVMcEH+xX6FJvFAD4mRgwQJtqqKlzNOAz6QnA=
X-Received: by 2002:a17:90b:4d0a:b0:330:84dc:d11b with SMTP id
 98e67ed59e1d1-339a6f36367mr2940411a91.18.1759308865859; Wed, 01 Oct 2025
 01:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch> <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
 <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
 <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com> <090d0e196fd0f814b5385f2c6e47e5196f0be649.camel@codeconstruct.com.au>
In-Reply-To: <090d0e196fd0f814b5385f2c6e47e5196f0be649.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 1 Oct 2025 16:54:14 +0800
X-Gm-Features: AS18NWDyzaFR3D4tmBrIV6Dx9lyGm72vUyiAB7CZStN-eawEDelhMt9miv_jN1k
Message-ID: <CABh9gBcaUbwR9ScT_xSYo3q6FHZaMyXYewByPQoReUp1pktcEQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:16=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Wed, 2025-09-24 at 08:34 -0500, Rob Herring wrote:
> > On Wed, Sep 24, 2025 at 8:05=E2=80=AFAM Kevin Tung <kevin.tung.openbmc@=
gmail.com> wrote:
> > > I also checked the work with `make CHECK_DTBS=3Dy
> > > aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
> > > and the warnings that appear are not related to these patches.
> >
> > Um, they are related because they are warnings for *your* platform.
> > You don't care that there are warnings for your platform?
>
> Which is to say, by contributing a DTS that relies on the ASPEED DTSIs
> you're now part of the community of people interested in maintaining
> support for ASPEED SoCs in the kernel, and it will be appreciated if
> you could help improve what we have.
>
> If you could pick a warning or two from the DTSIs and contribute
> changes to address them that'd be great, as this improves the situation
> for everyone.
>
> Andrew

Sure, I will look into contributing a patch to address some ASPEED
DTSI warnings and improve the overall situation.

