Return-Path: <linux-kernel+bounces-838021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C45BAE3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BC31944952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3B25334B;
	Tue, 30 Sep 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJLUTKd3"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37051FF7BC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254533; cv=none; b=Y43DVzlf2HNVSLhIs3sDjyABMA5yyU/r111GaA6QEzV1AeliS1bn7UR4YPCKGUjMlkGd9AXozwQmQ78xw3hi5CRFBrk+SVvjPa9lEucqsF0s7dA6HydXhY3UQl/mEn72NENHa6Z/OfW9gan/k1KXFEYBulG3EZrvGmTyHB2ccUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254533; c=relaxed/simple;
	bh=4MlEhhaEJFg/VQYMrmuKC13C2/nF6IWoZSw/Ec98vW4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LSXjAv8aNS4zk5qEcjcNn46q/MhifpJ+V6hfcT3elOpiPZ8pBnJzSPTaLV0Kzr/llxEbyugym9ZIxBYkK1gmSXiaCbGZf8Pt3j8Oxp2tVpQC2ZQqjFYBFogxiEf21Pmi63ugG+/B+FK8VfC748IG1n/jQ4Ru7KWyryJ0LgO9GsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJLUTKd3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so48106675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759254530; x=1759859330; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq6R6SU4rLr/GrLGHLGq6gkj6VLshSOm1bf7ZPl8UYI=;
        b=SJLUTKd3YXA1znPNC5ulXtc9RwlcIA/3SqicdMalNHA71uOGxjoEvkSeMDsptq9Aix
         5X2PJhAILHx2R5FDv22HHFYhhqzCHpRFipAsNacuLmGb4CjIVu1OxxhfXrwO8XbZXZ1J
         /atfSSayDl/YCa/Nos13ZsZzGIT2w8zYvnl+nKIXWOuloZwy+PSgopSUa1fnUlTTKMiF
         dIg7HB7HF/Y12K+lbcRPwhNlZ9n2yg08t2pGwY0o0MpE2T20GzQyRl8+pS+6JlKRTywm
         LGC/PJMINTpvB4NXK3DogRagOOfM0Jr32s0trje18tsjEzdNlHjTWAw0KzkRSPjMUb7p
         BpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759254530; x=1759859330;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mq6R6SU4rLr/GrLGHLGq6gkj6VLshSOm1bf7ZPl8UYI=;
        b=rNlvCr3hp09C83sqrhF4wbpzPO35IeQ3eQ0G7zSQall377EkiwC4ldtLrvkYNGT3AK
         XnjfBqePzCbWDQ4W/Go4lIYNPKxZ+gWVu4pr76KpFhww9A7I9CP7KT9Qt0plBFQh084t
         zp4w40yZxJDkgARy5WJPcSJN3bEQldyav0JD6Hz8Um3VqsMSIeShltodiqTQheFsMgin
         jvAhc6n9u2QNvAWh+ysUiRIFeaz/86eYHFpjlUGnxam8rP4jzOsmXqneXSypaK+XxmZ2
         IUZlxvMMlFZxGmc5KeOwRdQIJ3p2T81XxSWS3/jOwj3Uc1Eg8POuh8P1ANasMQAiV/NK
         6zIA==
X-Forwarded-Encrypted: i=1; AJvYcCU14mSnUs1B7Q2qEdANW3lQPkJ58WqKQujRMxEgJGGPOH/HaVPF45J8xWmcgq5OKaUQvr/YDWzX8SqY7FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehhlSSxAIpLZrXRM7GZF+/HHCR92koMc4tukm7LAUYWdJI7je
	ywRu4RLyMlujFNMZo22PLDqYgCtXP/2jkpxa3g2HQ85OaDeSx5sW4Jg0emuPEa7ZzIs=
X-Gm-Gg: ASbGnctyyZ3bIXVY8e+z0M8zp82IInfTtYs2C1V00KAsdqT1xuneH5mXd4AgG48/L2e
	7H/1KS3T4QwhSoH7sE/4GHUm7IVTXoR1fD1YLC4C74VFpbJGAjpjHmrAXtmtZHGkWr+DXkdilag
	/KThzwNg8btAonAKx8c+9f+6DtlVetO1Y71HfT/XdVuM341RqU+y0JtXNR+b9hXWSm+hNrEQWFx
	wfDp8tPcBT1bdu/6dxE6FwwHF0XNh+wPoSM8smR06cw2/TfUwkh9pG4HSTNWfngFpPTTeZYoYYI
	9ds4JM8aYUB35o0SovrmCwxTKArQoLbhApVAGtroAdwHl2qf8IlYgRhg3lBBbHgGmH5zo+dP4aQ
	84GZTNSB+CYloC6bFqbwI8p2J92rlR3e1DxCK664GvJr1EqQMm1pJvaSBaOI=
X-Google-Smtp-Source: AGHT+IFWwL3OmBkLMnlz7uL7VcuwGSis12CpJmftU7X9TJAiNKLravUOGrhixS5GMO5ETLsekrs9fQ==
X-Received: by 2002:a05:6000:4282:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-425577f4cb8mr509794f8f.14.1759254530117;
        Tue, 30 Sep 2025 10:48:50 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:248:54ff:fe20:c34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm23545897f8f.3.2025.09.30.10.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 18:48:48 +0100
Message-Id: <DD6BOLBXKBYP.2NVXRXGJ9W3IG@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aiqun.yu@oss.qualcomm.com>,
 <tingwei.zhang@oss.qualcomm.com>, <trilok.soni@oss.qualcomm.com>,
 <yijie.yang@oss.qualcomm.com>, "Tengfei Fan"
 <tengfei.fan@oss.qualcomm.com>, "Qiang Yu" <qiang.yu@oss.qualcomm.com>,
 "Manish Pandey" <manish.pandey@oss.qualcomm.com>, "Ronak Raheja"
 <ronak.raheja@oss.qualcomm.com>, "Jishnu Prakash"
 <jishnu.prakash@oss.qualcomm.com>, "Kamal Wadhwa"
 <kamal.wadhwa@oss.qualcomm.com>, "Jyothi Kumar Seerapu"
 <jyothi.seerapu@oss.qualcomm.com>, "Prasad Kumpatla"
 <prasad.kumpatla@oss.qualcomm.com>, "Hangxiang Ma"
 <hangxiang.ma@oss.qualcomm.com>, "Vikash Garodia"
 <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH 00/20] arm64: dts: qcom: Introduce Kaanapali platform
 device tree
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Jingyi Wang" <jingyi.wang@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>

On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
> Introduce the Device Tree for the recently announced Snapdragon SoC from =
Qualcomm:
> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdrago=
n-8-series-mobile-platforms/snapdragon-8-elite-gen-5
>
> Bindings and base Device Tree for the Kaanapali SoC, MTP (Mobile Test Pla=
tform)
> and QRD (Qualcommm Reference Device) are splited in three:
>
> - 1-3: MTP board boot-to-shell with basic function.
> - 4-16: More feature including PCIE, sdcard, usb, DSPs, PMIC related, tse=
nse, bus, crypto etc. Add QRD board support.
> - 17-20: Multimedia features including audio, video and camss.
>
> Features added and enabled:
> - CPUs with PSCI idle states and cpufreq
> - Interrupt-controller with PDC wakeup support
> - Timers, TCSR Clock Controllers
> - Reserved Shared memory
> - GCC and RPMHCC
> - TLMM
> - Interconnect with CPU BWMONs
> - QuP with uart
> - SMMU
> - RPMHPD and regulator
> - UFS with inline crypto engine (ICE)
> - LLCC
> - Watchdog
> - cDSP, aDSP with SMP2P and fastrpc
> - BUS with I2C and SPI
> - USB2/USB3
> - Modem(see crash after bring up)
> - SoCCP
> - SDHCI
> - random number generator (RNG) and Qcrypto
> - tsens
> - PCIE
> - coresight
> - Bluetooth
> - WLAN
> - Audio

Were everything described as audio enabled and tested? As far as I was awar=
e
some devices required some soundwire rework to support soundwire microphone=
s.
Is it finished? I don't see this linked here, but you state that audio
features "added and enabled".

Do we understand this correctly that, I presume, everthing that is more-or-=
less compatible                                                            =
                                                                           =
                                                                           =
                                                                           =
                                                   =20
with previous platforms were added and enabled (with renames) but not _all_=
 ?

Probably some rewording is required.

Best regards,
Alexey


