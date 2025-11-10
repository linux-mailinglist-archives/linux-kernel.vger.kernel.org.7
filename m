Return-Path: <linux-kernel+bounces-894353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449CC49D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE035188D202
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDA305E09;
	Mon, 10 Nov 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMfnUB62"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80B337113
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819085; cv=none; b=NFRq7LEk4SXwgS0EaoyMOLfL5oeVP6ycy6wLGHk7xo3mHRrx8cUmVrc1UlqseP9aGS3kR6Ho8BkuS9IvpETQlJQfQO0SHoj/tmjGj/mFC/uGFbtcNoE/YQt9t6bfkxzXs1EttKINJaW1KgIg2QCekz6d3HMF+7aqKo3Er1Ve5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819085; c=relaxed/simple;
	bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5x4+YTG28AgejATvnCOxj9T85HaIAGj07qtdRMTuTUPgCGQchlbQCmtuAsGLzKRQXGAhnp2c+ajNLI/inxKfomnSb2vzvuAgQPdDtmenaPzv9DUpCrUAi/YP+e09p6p0o3o45sNlI3w6+j4mgoYz+xgu4bvL2keaIyQTNESAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMfnUB62; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d54f657fso29922001fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762819082; x=1763423882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
        b=rMfnUB62IkZBgU4Z+MwGW9CfUGrmA19YQdXxMpBNsOeSJ0mEIRcXgpji9QXC0EYyJa
         o+/Tku8BunlJT5rqpTHIDQcnC0gQ3F+JkdSrYjtxQfXoIsyhWp6/QS7GuituJLbu5Vwy
         Y2z36yLhaznblXd+6FSzx3ztBGjYUzzA+q46QqvbjDXeQi0qTzWXA3AuPHvGZXRtu8Cq
         RTZKrvyOiNDmIj/4kKFajk4V5MVhg+bkHb0LR2U8TtduyxRf1DorNvQFruPMZ/SbpwDG
         13aG9D3U2O+aC7XKZ2XKF3l80D0Wm2qCGZQQeTFm/o11lzRynFNQt5R4bLoZZjz8H5GR
         UBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819082; x=1763423882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
        b=uMvE9huTqF/hxC/M9sQgAd2r/Da8862kL4s9Mi5Gb6AENo3JFmOJ4VOBLYMnmgdhDI
         pvELlsdQCG+61Mc2HdjsAisygj35g16lVRE1LYNfHaWOShdorHkKSLTHc/bRHjsfXguZ
         R1uFnw2bjZ27o/vsQStLM2tNztqcKDOgvGjg/yUQRwlA6VlDLn3CmzW/6/6QCaVdAkl8
         RJ4fEKZ8vvk4ve2Q7+Bvm+Ewl7gu/eMphNfeOF14fT0YNORPSTwQ3pzqTvhb9sIV5lB7
         S+OOXap9VeM505MgJfFuo0m7135+ldEQFvy6pZNwgY3xxaIVrPM0MPJmuFUOYE/auiRY
         qFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6G2uwkm5mFOGfo0ZHkN2r71Rg3IlDGLLszVzcFOV7iFzqsQJmHxgpuwmBzrBq40JEpIXba3SeQvmWQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcSm9Ept+DMvp3ciI4zxrrtDtskLTN3imAxk94XVKPjIpAkgV
	T0S9gQ3cRU/3mgdshE/eCqwpq1CK6eBisxxk7ODA3QJzLp9/1KvyJxHlU4oY9DEdiWh4doET75s
	5Xah8CzB9HhSH7+MY1Z4eFyrAsSaNtJxAXhbc45KHjQ==
X-Gm-Gg: ASbGncsLaXt10hO2VfuPcBprzYKs0xSFqLXxBsHTGfYS/bqzTSS+dLEnx7a9HG0itQK
	9w/E7g9U9CJajZtr34RK/6p4kjwVaUFS8Qo33heSOxHseC8ekyN1wKtSsLDeQ0VygNaN1ib1tmo
	XXoEhdb621POE793p4cPIjjC/5N7MDZ9qiLfYRSK9A/UcOIpOX/me/yMELDiMCEGScUwqyl3QVz
	hMYo2nZPFW1SO5jIMeWVDfWQrC+3STEEM9CCB/kl6Wec6HFubKVfYIcfJ2yGfTyeU9dD8M=
X-Google-Smtp-Source: AGHT+IGq8/YFN7hlWLIK9a4/CG12Y6T0bDy/N5/JTLofPKZElIMDZsi5lcAadM+CuswrNL2lnuY1YgL0/HzwYkg+O1w=
X-Received: by 2002:a05:6512:b03:b0:594:4a5a:346 with SMTP id
 2adb3069b0e04-5945f15bf72mr2619011e87.17.1762819081904; Mon, 10 Nov 2025
 15:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com> <20251107-wakeirq_support-v5-2-464e17f2c20c@oss.qualcomm.com>
In-Reply-To: <20251107-wakeirq_support-v5-2-464e17f2c20c@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 00:57:50 +0100
X-Gm-Features: AWmQ_blAezbQ4rkb-Vrevk4Zgb5huFnQ0lcUTpotRRUAIJPGPB05jzXROpJ4ido
Message-ID: <CACRpkdY9HsnG=xo=swnMcVha+unmvmxR6e6Ynsj09srM_tPmWA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: Add support for PCIe WAKE# interrupt
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:22=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:

> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Beacon is a hardwar=
e
> mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
> support in PCI framework.
>
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4, WAKE# can
> also be terminated at the switch itself. To support this, the WAKE#
> should be described in the device tree node of the endpint/bridge. If all
> endpoints share a single WAKE# line, then WAKE# should be defined in the
> each node.
>
> To support legacy devicetree in direct attach case, driver will search
> in root port node for WAKE# if the driver doesn't find in the endpoint
> node.
>
> In pci_device_add(), PCI framework will search for the WAKE# in its node,
> If not found, it searches in its upstream port only if upstream port is
> root port to support legacy bindings. Once found, register for the wake I=
RQ
> in shared mode, as the WAKE# may be shared among multiple endpoints.
>
> When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
> a pm_runtime_resume(). The PM framework ensures that the parent device is
> resumed before the child i.e controller driver which can bring back devic=
e
> state to D0.
>
> WAKE# is added in dts schema and merged based on below links.
>
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundr=
u@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

The GPIO parts look all right to me, a bit complex since we can't use
devm_* stuff here, but that happens.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

