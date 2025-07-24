Return-Path: <linux-kernel+bounces-743466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D34B0FF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A1FAA4C53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60E1CEADB;
	Thu, 24 Jul 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK0SgjM1"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3E1BF58
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326161; cv=none; b=LkKeRWliUaio+f2ioXC6+tC3Abtn4he1uFNrMKYwicF7KRD4gtjKMYDWgCrl5AQpBpOO7JMF/FgwMeg/s2ard1rOmcCgYYBnbKxp2q6dS7LUbuUu4SNuXvi9vvwjXkAlKT0NTvLWCKM8MRiZcEqaEHT1i4Gps30z6ruKK8/SjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326161; c=relaxed/simple;
	bh=DRqbgA/rfP/Lt72tSXhOwfuAln34SEWpdKk2oJ3oZzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JECpLFqcitHfs1RvzQc8IzTnlRBMGD9knU1am77Ku7csGW9Vz/VgOLrwKfnsehIS3R/L8Oiqf9YDlVlSJmoJwDnjV2nFYWRHp3vuqBqtZZ/PQm8RLfwSe0YUB26qX/kV7pAG8pHgtxXG+Y/v+uHiACpj0j6uGwMDmFoE27Q6dF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BK0SgjM1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7196cb401d4so5817277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753326157; x=1753930957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4szIC/lsRfoeS9xWMEZR5DrnZmuFrT5s30XlGRR6/U=;
        b=BK0SgjM1Ny1jk5rTSIg/ig+VfYG9BRxEct3dpBnQK90wbc3NvOqwqxiWbmgHN0ojsb
         Yki5u8GdUBMtOwD5c0Ztokufi1LLZzjuG1A/a5/PVCNfGTQz2z2p6fL8l1Csxdpqh7oO
         KAjBuY79vdJpU/tpTJxBB7VMinj1alftr3Mj9d4bQbeN2ZV7rJsV/L5bi8Y9lCnhLCIA
         vpnUJ8hyMYJyFvpNxMvJjSVFE8nnoHyKAjfdY69xX4KT3UuI9onkKbpLfUPWmDQbzady
         cnan5aJLALr0NGshULRYQo5ZeHZA5OUlHZ70v6AczA/Mdk/UsgSJK7PBGR/c8/+1fZNQ
         bFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753326157; x=1753930957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4szIC/lsRfoeS9xWMEZR5DrnZmuFrT5s30XlGRR6/U=;
        b=wJ15yHlfT5uMytspGfEka5FKMYXfgrCZ8Qk+IrriqNOS6KlSeJMasfFgqzl8YUAf5B
         ff7Cbm7+QAoKdcuXLFp4+hqKs9FgYWDGCoQpe8xI4F1FG2N9vnnAeWD+vdHJiwVn4muL
         jFijN6VDBTWwuyXQP9vs/YRw+ZEoaoPiBVgvVQ5tRQ6Suq6KJ3leXPcdcjiQVeEwvAPq
         Kz28gefmo9q11qJlUj7+oO2POnN8Dy2IE0Tl5KMMQnd/5EgWdbcsxBaMv2AulLBOViXQ
         mH45wfMvAqFUhuSfvPqjIA/MG6Sb8IF1NAIku67ZEQC3Lam0R9GXKd9CJlQOTvZf9ajY
         zC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFbiNqFJFEnagWe7sejCqFTGB9Y5JrOQ9UWXRJFRlp6mhLe+tK6J+qmX9Zc3hxUlVE1WO66bWo1Manoxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZalFutnPBPLui5yJOk4OZABrxADxfQeZQKM1w4QWJpJr4hmv/
	6TRopLOt8TYq87UAGxVohMug3lMz3MmIaymwPtzGaxDEhgJIdwUmWX7WLqXvMMS/Y+bQy4o9SG5
	os+t1Iv+m7MovzvpEPtpjQpAs7UKzh8GxX3LV5Toy+Q==
X-Gm-Gg: ASbGncvIOKdBsAUFFsEnFhgKdDjdIo8Aaq0xWBvF/y2qd7dRgD+8k6ZKey1a8UCxFkb
	v3CCYbXiObwY5oFYi3SMpVInxo/T450EAdr/q01fKlP9aHsV+Gvg0rv6HyTg9fUPOEQuLRI01tE
	m5czgvzETmhXiW1iKVStH3A/Tv/A34IJGcUubVm+uobOecbc9rE9O8pG7URNhhvvmmcbiSgu/bV
	Foqblc=
X-Google-Smtp-Source: AGHT+IEIMtv289DTIkybfPfffRPAzee3+9DmTAuYGJM3UvEoqefg4H82jx7CiRhNSKxNLqGq+1drRcysqqTEjMpfosA=
X-Received: by 2002:a05:690c:22c4:b0:70f:83af:7dab with SMTP id
 00721157ae682-719b41e5925mr66244057b3.4.1753326156883; Wed, 23 Jul 2025
 20:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722121037.443385-1-ivo.ivanov.ivanov1@gmail.com>
 <20250723-hypnotic-malkoha-of-trust-9efdb6@kuoka> <3e1d7be9-e99f-41c3-8b0d-aaa426aa9de8@gmail.com>
In-Reply-To: <3e1d7be9-e99f-41c3-8b0d-aaa426aa9de8@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 23 Jul 2025 22:02:25 -0500
X-Gm-Features: Ac12FXzQwje0qjCw-CvN4blAJTQm7ENnYNl_ILs69QPBbFxu9MyH6hiUp_sqjVc
Message-ID: <CAPLW+4kPN65uX0tyG_F-4u5FQpPnwX9y6F1zrobq5UyVbks+-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: samsung: usi: allow 64-bit
 address space
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:21=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> On 7/23/25 11:15, Krzysztof Kozlowski wrote:
> > On Tue, Jul 22, 2025 at 03:10:36PM +0300, Ivaylo Ivanov wrote:
> >> Some device trees, like the exynos2200 one, configure the root node
> >> with #address-cells and #size-cells set to 2. However, the usi binding
> >> expects 32 bit address space only. Allow these determining properties =
to
> > So if USI expects 32 bit, then why do we allow 64?
> >
> > Switching this to 2 means you use 64-bit addressing for children
>
> I don't, but the main point was to avoid defining ranges for every single=
 usi
> node, because they are a lot.
>

If all MMIO addresses in your SoC are 32-bit (they probably are), I
think it'd be neater to just make the entire "soc" bus 32-bit (so both
address and size cells =3D <1>), and map it to the root node's address
space with "ranges", like this:

    soc: soc@0 {
        compatible =3D "simple-bus";
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges =3D <0x0 0x0 0x0 0x20000000>;
        ...

That's how it's done in exynos850 and gs101 dts for example. This way
you could drop all those extra "reg =3D <0x0 ...>" in the child nodes,
also avoid declaring "ranges" arrays in each USI node (just "ranges;"
would be enough), and this patch won't be needed. Maybe I'm missing
some details though?

> Best regards,
> Ivaylo
>
> >  and
> > allowing DMA for >32 bit. This should be the true reason - what is the
> > address space and DMA range for children?
> >
> > Best regards,
> > Krzysztof
> >
>

