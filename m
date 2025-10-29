Return-Path: <linux-kernel+bounces-876144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A12C1B414
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638AE660CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FA3358D3;
	Wed, 29 Oct 2025 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RuSYPpDF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5361EF09D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743754; cv=none; b=MXR19m9qnycVtdlFPY45Z7bu1QQXOV32lxYKDDOMScdL/T/P26ruLDA2xn2TgDgjB9pstRfFBb83v7gRg2QNi2mEWhs4SD+Eu+WW+YpfK7t8etHmRw0b/xLfwUUg78jU+4Bs61KsWtlcTry23fO1ZeEWD81n8feqRRggJmF2C4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743754; c=relaxed/simple;
	bh=idJ1/xpsY9Qz5yevc36Vw8gxViLPchWiyXx0zGa+jFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdHFLSUrgHG4ZOJkLigIf54FO3q4cWqMEmsqJOvV+SN8l5wMPTKYCjrIHUGhJgnWIWTKVK+LmOFFVZd7gIDdJi8y4mf7GtLKgrmmGu0Cv3ZWhDZFm27X9dxtYj2I3c+DROAOxhqVW9Uzs8Qk0U6Z4pC1wO6fkQddEN7pgn0ab7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RuSYPpDF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592fb80c2faso8596101e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761743751; x=1762348551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOUisOdkXU0bOduvB/ByBLb4wJp/5x2Vdu+Ct3A15wo=;
        b=RuSYPpDFB4REAVfafBOGVygb/P7rkfXo3U5o7RAbKuf+FFtQdoHehowXFNnsFCLPKM
         lsahh6Goc7ckmd8JBWRgi/E9gqB8MQg96XDwUWi1d+nXwsaHUHRbwiqSfcNcm1EzSoVf
         jitUK50/2fXnjO1Dg+OKrHZouoTWCKozi3cLm9ahFPz0neptppiUdWslHosJ+xsEqvLh
         qsoDLF3LmbaI28247Tn9fpyI7UXyXiTgY7h1kNq0Jd4W6EJiW+hPhx7bEenLKS2YGnbg
         M2a9IsdyW1RGosdkcI5gUgKW8d8oE0Zm2V25u9/caZzaH3cme21/ZyVfMtLzK7BUnoIf
         PAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743751; x=1762348551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOUisOdkXU0bOduvB/ByBLb4wJp/5x2Vdu+Ct3A15wo=;
        b=ETF6w1iwjltaZ73INCNb6q4eTeihGJWhpRgpzBArnXjewnWfhVX9a1LUvoaDCcN/6D
         1I8ICtwefhyB9xrPbEHI/iholXnmSYiwAYMqcNg7Dp5v4Wc4edrUvwxuv6XDfIvUhFGV
         Imb3tqwZMPQdDwMdSy0FxUipIzzmntTjEVdWwe91eMkoIsqoKJqabfJh9mnRNV0ByEf9
         52X+9grLQlU70z+pUovpEFaOxz6hQvVId+7oXUbKWnaw0MhCzj/Cg2suiggx2v+Giy0O
         iGpWDP9zm+wudTAFr2izN2M5fdeM4LNuwZAVSG6Wdnwgjxtj5hhQw9/y0pJtfVRFd5de
         lfrA==
X-Forwarded-Encrypted: i=1; AJvYcCVlrddUJpA+iDOXBBmrzKxbDA01Bv/H90cG4j/3Fv+Ec64CMtRv7wt6aOQCdhEe9uxI9A/9QK5rQ3NOAsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LYqHuwj4+dMCEPEA9N1ckHBiUO0yvclhchy//p+9y1WpLB/y
	1iJnqI+JDZwXLKiYCTHvEQAC0OL9/3PyanD7PBlKV3XPI5DbJK3dzeiaP11aNlc2t9o46QKWj3a
	ajo6qjhRU7JChollYJwCjFD7PrpTgF/8zwJ35ykvKIg==
X-Gm-Gg: ASbGncskGm9NblAnJl1GQyLHMeb7+EEQfVLNrC9Sq4Anv8xlezBK/pyyGRi8m0Sm152
	FUmgHhYj+q+D9AGK9/x+LhCNdJbUK8QvpOxVmnHMUHa2VtQ18hR1V/wHujH5ZWEhLTIjERbxIlF
	F5uZpvPXj+Fuc/rwqQADlwkyAIEsPiufbOZrWc8f5avyiILdas5tIkP+3JRfvFNgTIcKtsl1LyB
	Wz0Q9nMyt5/q8o0D31I3qZNp/rgRImU7Neaxo4MsfmqsNefZ+lljxs4gkhm2HbFsGUOd7AI0v53
	T9nDe766PRaa8CcE7B52rDQ3P6s=
X-Google-Smtp-Source: AGHT+IERc+XWdsch1n0sjpOQOzD+cW2IjfHO0Rpz1QeHwY2DnN9gsWkr3+lO2lQRgACmeZoFB2eG85VNyJBLdF9v7Qc=
X-Received: by 2002:a05:6512:e84:b0:593:5066:8e35 with SMTP id
 2adb3069b0e04-59412878b7emr1119097e87.13.1761743750670; Wed, 29 Oct 2025
 06:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com> <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 14:15:37 +0100
X-Gm-Features: AWmQ_bnxen2afRHV8wd2ApkjxBH0TleB__nu5t1NsDGu_HDLvXbdqDWBWRF_WWQ
Message-ID: <CAMRc=McWw6tAjjaa6wst6y3+Dw=JT8446wwvQ0_c5LHHm=1Y-Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:30=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Enable TC9563 PCIe switch pwrctl driver by default. This is needed
> to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
> Without this the switch will not powered up and we can't use the
> endpoints connected to the switch.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..fe5c9951c437a67ac76bf939a=
9e436eafa3820bf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -249,6 +249,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
>  CONFIG_PCI_ENDPOINT=3Dy
>  CONFIG_PCI_ENDPOINT_CONFIGFS=3Dy
>  CONFIG_PCI_EPF_TEST=3Dm
> +CONFIG_PCI_PWRCTRL_TC9563=3Dm
>  CONFIG_DEVTMPFS=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
>  CONFIG_FW_LOADER_USER_HELPER=3Dy
>
> --
> 2.34.1
>

Can't we just do the following in the respective Kconfig entry?

config PCI_PWRCTRL_TC9563
    tristate ...
    default m if ARCH_QCOM

Bart

