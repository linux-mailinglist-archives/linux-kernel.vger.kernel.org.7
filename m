Return-Path: <linux-kernel+bounces-862292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C6BF4EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99B33505399
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442E274666;
	Tue, 21 Oct 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8z9VVcO"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9D1C3F36
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030831; cv=none; b=rC7IJskA6xq6ifERa7NxTZi4DYvkgGeXRIh89gMk+32pHTMAwmkb5HIg9JNWAwwm0/AIPbr8garhbNONDLiGfYU1KZq7N/METjAKxAM9pIU3RnQ3G8hYzaDn6alsuH7P5HymnwxUJ4Va3Mtae/ywB+cXNTM/ZN4AQardcp/pyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030831; c=relaxed/simple;
	bh=shnocEozDkLvjkbbYpfPCYmb3LZ8IOs5v0zgxrtXZUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRwp1ScNC52PE2LhKVG1qEuh8/KrKqfI5QFGM6eP1mOZvu/0XJow0+28cv74IbiV92cIVMimjcmXOKzy1aasbRvyFMNzLaU3xo4Bq6BkiyWH6soR/TWpmiZvYqfxwYXIAAn1WN7tvzF/wGg8b+DxVYqba8+ke8iz4K46m1hFpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8z9VVcO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3778144a440so61960321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761030827; x=1761635627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuafyjGQlDm3fykSpNADHjSfG+tYdvPkfZzAXtiw/Co=;
        b=b8z9VVcOmmTUtezm8NH6uyAlUgkYd3nhzDiMQfBc/a998Q55CuP4YskghZ3rr4OyPp
         VvvPx+pfflk55QdmUM0iHBu3FCkLjWVluHP+tDFR9iJpGREP6ViN392s37StstEM2285
         aWbrzFcrCfPqB5peC7ChUkk5UkIgR1pfiAasAALOD571jgXg1THRB7ij65LHN8glO/Dp
         MIQQ3DIXB4onaD8yTFFNoaLaW2kReUXR/rDBqQ5ate2w7NQFDtfy//w2Icphk8eXkDtb
         iA1wla7kmHEZSEjcNzt/14DmXufVALtH4WUZ0gceiTCl7zwnWmL2sb9flC98dsNwsiqB
         x9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030827; x=1761635627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuafyjGQlDm3fykSpNADHjSfG+tYdvPkfZzAXtiw/Co=;
        b=khYwhNMFwweYJsLNlwM62H52FbvaM94VvsJCQBGulDGUjla4qiOwbT41L7k8kGgm3F
         s8xJmthtICEhkwHmuecgX/8St+1DMMVMNA8YaN96KuFJWvSKUKxiZzHoeMjSMl8boGMw
         tUjKByK187AlB9NZyEqbfUstAM65SFb+ymHS9JUkDvKJqcT3/plQ23IPewHmidTMaDrf
         SG8daFCnspbsxQEqRSuymqv75th+v1fPjoUPf4UMh+/Q2Iu/liTjYTJweU9DTcp/5sq4
         CnJc9EPfMLUPiR1GWaZYy+fn7DBCKcBEfAOcdF3Pm9vo9dTZ/QzYL6F4jWEv8Q9HP0fn
         Igrg==
X-Forwarded-Encrypted: i=1; AJvYcCUhdmp8O7D3nIYFjwbAS7Q8DWeQYgb4hNPAXzNomZ+fVOllGxomHI2KiFRIFVZmnOioKfOtasQvMjr+JFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FhlePYgsvadHkYC4i4loX5SJFSiVuo+Cp5NCyb1dB6XPBqL5
	aTV2yi8qcb6DCPogToAMZSCZ5byURipzjhQyjx4ptI1iiEuwmPo5/7o2zJ95+ufDhppxnb0GUaG
	sdJpKANIZ7vYnhiSTJPDz9v4hSD/QNV7z/f25i9yK5A==
X-Gm-Gg: ASbGncvA/5Mh3HJ433P1wBAaQjldjBaPqPTpmyMTYX7vbk5jaPeSxHI38pe6MFYVDcE
	lILwpJK3/yvykpGzgnQ/DeCpSC1hZ61GF0b6HoO1+9U1O0aA6A06WOxT7odRk4COXWyC9xMc3YY
	hXiaDPW3fpeWHpZud0c6yc49hzePdJzdd1DrAfcFMLqEJvNCmxG/3BWPdD7TVHTEAkPL1cAe1Dy
	026RsQ6iNlUNStFYAmaD18G5wUUITkyhoiM0rGmyDKj4Fna1Q/WmEenBowU3yaODW4VeUA=
X-Google-Smtp-Source: AGHT+IFXewE5inD7CgvvKJbWyXxMNEGciqb/dhdvor+BMXV8b4ojerJafcr1lFElVmRq6Yah9RSUyGHsXMPY7mK9Yhs=
X-Received: by 2002:a05:651c:1118:10b0:376:2802:84c2 with SMTP id
 38308e7fff4ca-377822498eemr50953931fa.23.1761030827133; Tue, 21 Oct 2025
 00:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020080648.13452-1-herve.codina@bootlin.com>
In-Reply-To: <20251020080648.13452-1-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Oct 2025 09:13:36 +0200
X-Gm-Features: AS18NWCX83cFiM9B--nMGIfUIvsXguic5HJGZGgd7PDtP7ogZyhxvv6xui0ko10
Message-ID: <CACRpkdYwG_rQn7eF9QNfApo+h-BGuC8Q_nPyeAKvcuUh+Bf=Xg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] gpio: renesas: Add support for GPIO and related
 interrupts in RZ/N1 SoC
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herve,

On Mon, Oct 20, 2025 at 10:07=E2=80=AFAM Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:

> The first patches in this series are related to a new helper introduced
> to parse an interrupt-map property.
>   - patch 1: Introduce the helper (for_each_of_imap_item)
>   - patch 2: Add a unittest for the new helper
>   - patch 3 and 4: convert existing drivers to use this new helper
>
> Patch 5 adds support for GPIO (device-tree description)
>
> The last patches (6, 7 and 8) of the series are related to GPIO
> interrupts and GPIO IRQ multiplexer.
>
> In the RZ/N1 SoCs, GPIO interrupts are wired to a GPIO IRQ multiplexer.
>
> This multiplexer does nothing but select 8 GPIO IRQ lines out of the 96
> available to wire them to the GIC input lines.

I had my worries about the multiplexer but seeing the whole picture
and the nice refactoring with for_each_of_imap_item() I have to
say the patch series looks very nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

