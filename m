Return-Path: <linux-kernel+bounces-869306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E07C07935
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DDD1886AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A01326D4D;
	Fri, 24 Oct 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2PSQDOp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6291FCF7C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328011; cv=none; b=BI+LqK4Ws2FgZAAFyZhOjf45GA6gUV14Grr2wlsdIfcRd2vwo+cuWCSCWvHxeIuusEUm6ktoPQzf80Kk58HT2DDAy8Xt0nYXee33OB2jkLAueJj/L37/4MMPAY0BYUJSxFjfsR/GmehV/Fm5mObDdmsBLDKwre2oLitR6cHdp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328011; c=relaxed/simple;
	bh=K6zD0dyxA5X3dz6tOjR3SyTpnMhYisRl3NWIn5tca+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9YHdy/iL+rXhUxMG2SBhbuAQyw+/9s4DzmU7UumFblmIMooGSgnVGH/7Kt31+Qgt9omBMh1ZsGenY63/CNwNoTiyWHtkuZX6uDKPWNXYXJpNzOBduCHjQ5jLkpfyuB+5faWuoDR41NcdYsd3iO0Kb7lX3N47qGljyQfvhpE/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2PSQDOp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591eb980286so2482607e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328007; x=1761932807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6zD0dyxA5X3dz6tOjR3SyTpnMhYisRl3NWIn5tca+s=;
        b=A2PSQDOpNJJx+gPryK0V8miuxc1723Fpmx3o+U/zSdlIcTwWUtXDwgH7ZWmhmUq5I+
         DlpVST5ir0ElBFlCd67Uuw1KeeHSQqDO7wtG2cHY/tonBJXAERUmUrGmgIxzuyrX6mFI
         2xGgLdDsez5UBtAA6Vvpha2JLhHbZXfiSA+hRpVs5na1g5pJg5R9T1T/omVF3IIsb1A4
         oCfHVqFwS/pDDC4QNEbV73yBSwBkD9ctbTSsgGMZtyl/BBe/mB5KTR2irML1atFuvFcs
         ilaWNzm+StFZ7b+BevAqZcIV3pebu5SCenPbQ2wtE7tn4D9wtMkRV+zVDFQ8FkEo61Wf
         4bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328007; x=1761932807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6zD0dyxA5X3dz6tOjR3SyTpnMhYisRl3NWIn5tca+s=;
        b=UcTdKTQ0jmDCpft+KIUxuF3/tCVWkZOtPsXN7Aia5WcNEJAOWH/MOU+apqzWUrZ3n/
         GM9vTCCv4Si12+K3lEuNjZWjDxJ7UZKIc+E0N/wGRZiJxYrUuYgfsdr7CDJr9qFgf7o0
         GjGnNwabGeNSH7vITJamCKZJY9t+KJWfHVA3d4NE0whpM3PdzJeNOnOiJlyrleus9Ziw
         L3vxoTlnQZEkQWDBTkS6p+/50/skpBS+fJRJyqfS0E13FMa4Q5GN1T1zB84oi26Lau8e
         Zj1/7vi/+V127d42oU1kPl4+yH9w5DxICfOheLbo41TncPEPbFApR8BV8T10UQd2O+r7
         OqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCP6Es4e3rWsPYH9x5OePRyIVO0g/AZMSWJc9/HjRaPe11Fa0ziOMA2/a/lcK3Kb0Aao3yqJi/UBRXJ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbD9B3aEvU6rhUHDTCKz1EhquN5grXa0R2Zp56GdUZqVDrKwi
	tmbUs2PQcZCdCiL+CUGdP7hpVDUi8+r+DL/IDP26CFQVwgHmF43nj0MLnEV2Mwz2p1INxlagoon
	elNLuXx14VNtybiCE4VvkDbUy9eeM8OU=
X-Gm-Gg: ASbGnctt6MiMlXZz+5JI0CqkWjH+z+K0yXLANUdpfrLzohTpqXa+jrRK9pSwkPUT7+z
	ieV9MCG9wmjY0UGmX6RqFXNct+iZ3CR6ruOgTIcPQuQaPsOEQQUEdFORm5RVdo0XJ93WM0G0ner
	xAgn4kcvk0GaXV7Z8CIeIsCLJcIRfDGtpl+Jq/V2pIonf2fWz61ih0uC6Sa+KxCTzpJF7DO8yAO
	gqS9WcvPiRVpE9zlrsHbn1rqvUKSTlDJbBK7Zrj0tOXrEGPnrfjfq8HPOGu
X-Google-Smtp-Source: AGHT+IEKMTxbFcAqJJs3pqOOQTiDsnpDKsflXjiTlx5yaR9ZYhjteOY9GsHf3z7fyVR7qJSJg+QljfP1XDamHWUqjvs=
X-Received: by 2002:a05:6512:b84:b0:592:f9e6:a617 with SMTP id
 2adb3069b0e04-592f9e6a809mr1988690e87.31.1761328006209; Fri, 24 Oct 2025
 10:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803-p3450-mts-bug-v2-0-6307125408c3@gmail.com>
 <20250803-p3450-mts-bug-v2-1-6307125408c3@gmail.com> <8ed69b4c-f656-47fa-a247-1c8d94dcc35d@nvidia.com>
In-Reply-To: <8ed69b4c-f656-47fa-a247-1c8d94dcc35d@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Fri, 24 Oct 2025 12:46:33 -0500
X-Gm-Features: AS18NWB0X2kanA5C8YSvXzeNGUy0EwS1NgCtJrnfR3pQ1y9nZ6F33BdAn_oIim8
Message-ID: <CALHNRZ86NjcNJhRJd+jtD_7fRTFJ2szPFAAN3HSad_xwnVrHWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: tegra: Add reserved-memory node for P3450
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:16=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> =
wrote:
>
>
> On 04/08/2025 04:14, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The Tegra210 L4T bootloader ram training will corrupt the in-ram kernel
> > dt if no reserved-memory node exists. This prevents said bootloader fro=
m
> > being able to boot a kernel without this node, unless a chainloaded
> > bootloader loads the dt. Add the node to eliminate the requirement for
> > extra boot stages.
>
> I test this platform and don't see any problems. I assume that this
> would prevent the board from booting.
>
> What bootloader are you using? Is this from a particular L4T release?

Please see the longer description of my setup on the revision v1 patch
here [0]. I am specifically using the cboot prebuilt from L4T r32.6.1
as it is the last version to support usb input in the fastboot menu
[1]. The rest of the boot stack is from L4T r32.7.6. The partition
layout xml is here [2], which requires setting odmdata bit 11 to allow
reading bootloader partitions off the sdcard. There is no u-boot
involved, only cboot.

I've had another report of the same issue, on a pure L4T r32.7.6 boot
stack as well. The Nvidia downstream u-boot won't copy
external-memory-controller nodes, namely the memory-region ones, from
the cboot dtb to the kernel dtb unless the phandles match. Nv-tegra
gitles isn't working right now, so I can't link directly, but on
branch l4t/l4t-r32.7.6-v2020.04, file arch/arm/mach-tegra/dt-edit.c,
see line 31. Which means that such only works if u-boot destination
FDT is the downstream dtb. Using a mainline dtb causes the
memory-region dt tables to not be available, thus the emc kernel
driver fails to probe and emc clock stays stuck at 204MHz on
p3450/p3541. Hence the user from the report trying to cut u-boot out
of the mix in order to get emc scaling. And then hit this issue.

You were able to boot with a mainline dtb on the DTB partition and a
kernel on LNX, without u-boot and without this change? I have not been
able to do this. The boot flow will get past nvtboot_cpu, but falls
apart inside cboot due to the corrupted in-ram dtb, never getting to
kernel logs.

Aaron

[0] https://lore.kernel.org/all/CALHNRZ_7wChDsvpUnQHnOTT9VzT1Lgg8JYgg13AFV8=
Jg_3itwQ@mail.gmail.com/
[1] https://forums.developer.nvidia.com/t/cboot-xusb-support-broken-since-r=
32-7-1/243534
[2] https://github.com/LineageOS/android_device_nvidia_porg/blob/f52038d326=
ef67002185dbe04e9ff1070db2be4c/flash_package/flash_android_t210_max-spi_sd_=
p3448.xml

