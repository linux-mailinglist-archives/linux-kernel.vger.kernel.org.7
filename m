Return-Path: <linux-kernel+bounces-818512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B71B592B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F6A522FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8A29BD91;
	Tue, 16 Sep 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jYyW69hS"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF229BD81
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016356; cv=none; b=ojgbKu7ULb9iFCFXpjCY6XlQ8XZtqPbtl/od//t6Apyd53ORux6x4QBiOZI0DXONP1LG4PvXPgs+R37T9Fp3xG9mADkJ9fS9NrZYI1viZq2kPxuoiYqyC8GqspMBHI5v8ky4ijC1tQyUTafYt4K0VAVNCeghJDf2CvVoVRib2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016356; c=relaxed/simple;
	bh=aMG5F7xpbshGg26N6ZjbwilfqXgobZd+0i4J8EC0NG0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfopCyzWpLYMYKrfPL77HiCvEgX1YZFk1dSAygATzQrK/ZFM5uwBKzumKgR7Ya8sXnvVlNnt2X83MJqC8OMc6/EFiNCywqDjpDMdPn26F5ReDmZY/yz8NWsjj/IKkpYTLcWkHTV/L+RA27yhwiXNHctE9qnG5FhiB9CoBVPBe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jYyW69hS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-560888dc903so6381079e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758016353; x=1758621153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiOC/M78bEv61Cna7PZSesU2fWMjqsEn6aaaGX6/V3E=;
        b=jYyW69hSu6lcclYx4f+E5zsc/hvOWWAVgFXl5kyEiJAfEsIcqXKMCFfhR0LeaBFurk
         4ZD0w29C8cAtgRDqApcVMCPcPUerjSD/uK0fF8/LHj5aao71Jcm4iXwqaW7cTiEfg613
         9wnFM9fqUp8uAWDDBB+sMBRxvQB51Cxp2j7UUBnsyA3wAhGupvz7AjSIMCojApgrfblq
         +gjgDZ0dS0IjjkHHSRuT7PK/7d16jZ8kfmkaOhVDsl+2mAU9NODyk0iqPAtns7Wk/QcA
         Huj6waHkIVx++B4yJAtTzFOKSXwFQfeHJuSQAHapg/ocQYva7vePgiIETLBYMeq6mSCk
         yVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016353; x=1758621153;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiOC/M78bEv61Cna7PZSesU2fWMjqsEn6aaaGX6/V3E=;
        b=lTpfMI/mDoSe+JhYnNAZCE3WzPZNBC5L6oPGl830mPBcVwVhQYQ/3PJaGEsTLFB64D
         yjd1kUN53qToxbxAAVLhEIkAN4LWc9lsp2416Mkfj2tVqvdaLVicySXm7nBnBdt7XeUZ
         0Uf77g2oiEnqisU5suGgCPr19mZnF0bazR6ukgJgjHoF4gLVSdF4g5WEdeviXbNtg43d
         69EPffknNzI6Kq5HrgXUwChlUwVTeQQfzwqN4NteQ9GVeaPgVvEEJYJZkts4avSg3ntA
         BfvNBmQciwTmQlpnczvN1N0ONO/EKfYdDCyY36Hg9EgJu8lFkHXH1Pq3UK3xgU48hg2N
         xIow==
X-Forwarded-Encrypted: i=1; AJvYcCWTwL4d123CmxVBGsdROpy8nFyNxbnXpuwyeTQCOjHyPiOt+3WPF7TtUhBGpDgpeBLcPMGNhybuk9CNJgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFx0Az7e8EkGXdP/O1nDpL6mS8UtG45BuUpbrds+cHYlt6F+GR
	HBHP4WPFfcwNS8yZ3Exmjlv1lbaBKbXLswZB9lQ6dFidTWXPMybo0mGEVUiQpanhTP5PrFrIgL8
	DRXTyZcwLf6h+vgQ0dguQqNshKE7jgHmVsPT45manow==
X-Gm-Gg: ASbGncv/tURW6VSFOVvdj/ThCZWaQQOun9yt5M5wtbNl1OVNYU1t/zN3IKlkI3l33gB
	cmoH4jMlSmQK3DydJkjGIkT3m31134dDSxH2hMSL3O4m2lW6L2YpOhmx/Pe1dvnNpAZoce6v27l
	XvMJkrSWGOT7WXyKCh/j9Zghrsd8hvf5CRHVp4cuPpzZS9dfGj7PSuYR6mJKUojh8EG3+NVUX7Y
	OiATxU=
X-Google-Smtp-Source: AGHT+IHX/v2Sv4pNLDqBj2a0T8TLe+4AuuhJRQKT8EtfyDIe0B7CYhCKOOu4ksFfaiZpITJ9Ev2G8Po+8ZM3AqaIkKk=
X-Received: by 2002:a05:6512:3f05:b0:55f:3e4d:fb3b with SMTP id
 2adb3069b0e04-5704d0071c6mr5659388e87.30.1758016352992; Tue, 16 Sep 2025
 02:52:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:52:31 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:52:31 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <DCTDUJO0PS8B.1LD03WTEMNRVP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915122354.217720-1-ioana.ciornei@nxp.com>
 <20250915122354.217720-5-ioana.ciornei@nxp.com> <DCTDUJO0PS8B.1LD03WTEMNRVP@kernel.org>
Date: Tue, 16 Sep 2025 05:52:31 -0400
X-Gm-Features: AS18NWAbYT5SIpslmbsM29_pX3ylDm2HlYwz1lrLiD9dqodJMb4U8hXy3-TvuOU
Message-ID: <CAMRc=Mf7bnAM=-A4jWrqOvS8-ZetTHPfMaEpmQdbKMt6SWKtQQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] gpio: regmap: add the .fixed_direction_output
 configuration parameter
To: Michael Walle <mwalle@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Sep 2025 14:45:58 +0200, Michael Walle <mwalle@kernel.org> said:
> Hi Ioana,
>
> On Mon Sep 15, 2025 at 2:23 PM CEST, Ioana Ciornei wrote:
>> There are GPIO controllers such as the one present in the LX2160ARDB
>> QIXIS FPGA which have fixed-direction input and output GPIO lines mixed
>> together in a single register. This cannot be modeled using the
>> gpio-regmap as-is since there is no way to present the true direction of
>> a GPIO line.
>>
>> In order to make this use case possible, add a new configuration
>> parameter - fixed_direction_output - into the gpio_regmap_config
>> structure. This will enable user drivers to provide a bitmap that
>> represents the fixed direction of the GPIO lines.
>
> I wonder about the ownership of that allocated memory in the config
> structure (and btw, I guess you leak the memory in your driver) and
> if it's not better and more error proof to allocate and copy the
> bitmap in gpio-regmap too (and maybe use devm_bitmap_alloc()) and
> leave it to the caller to handle the passed bitmap. I.e. it could
> also be on the stack.
>

I was under the impression that whatever is in the config structure for GPIO
regmap init function is only required to stay alive until that call returns?

If so, then yes, a deep copy of everything from this structure is required.

> Otherwise, this looks good.
>

[snip]

>>
>> +	if (offset >= chip->ngpio)
>> +		return -EINVAL;
>
> Not sure this can happen. I tried to look into gpiolib.c but
> couldn't find anything obvious that it can't happen. Maybe Linus or
> Bartosz can comment on that.
>

Indeed, this is handed by GPIO core, please drop it.

[snip]

Bartosz

