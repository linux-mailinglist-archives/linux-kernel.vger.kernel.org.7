Return-Path: <linux-kernel+bounces-893210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B704C46C92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F051886751
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E030E858;
	Mon, 10 Nov 2025 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXFr9Ov6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED9309EE5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780269; cv=none; b=YGIoqHAtQzC6DrbLTi9wGK8yBAm0iJrI1CiZBgSIg+T/RBdLO+IMXeKvbItWf1xCM/P8YUw7ixXTg8sLpvDcEyHxwHUwfzXwpxl8YE1uFiXjgs8Jg4rTdbJ9ieTSgNGLKM3Y50b31EBiB05ihMch7Ow2ynfpcbjwPtXy1Tm4Z48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780269; c=relaxed/simple;
	bh=qJ9dEuHA7QP47k8+mFjKN7aiDkO2eEnpi3eRdL/AdNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0uMeumUI58wW4jXLjD6HwzDjSvupNffVeooPexooEutOhyAvvKSp/rhBtQiBcjNyQo/LV0ehpFdXUBniyOjdaj4pMCFNekpIf+QqGgCrt2DBNBt1JZ60EhAOCipPPXCeF1nsWJPxwrBUn04jM06zjJBOdh/tCNMpVewa9fJ8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXFr9Ov6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72b495aa81so341802666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762780266; x=1763385066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ9dEuHA7QP47k8+mFjKN7aiDkO2eEnpi3eRdL/AdNc=;
        b=fXFr9Ov6yHGUbMykoVsX9+G6EUowpm6bxDPuwrjTtRd7U73N19SvQT6/EoWnof5IbF
         lm2umKVLmET914rzoC7gydt8dwC7FRrsunXkAC51ocb2SFyc+cdoG0LNcQH+bw491Qpe
         WLSFy7niB4N/Fa5Riq1CSeQ+KT/WABj63UcyMM0v1Jeez1lFwjbEFgWD41+Pi/41Ky8Z
         bsxEMHJOIQjz4c1Emk3RbSQ/RGAoiOTeySVvjGnMGMMLm1OcMmIHDm5J1Cjxm/xySxBy
         4ob6wQtvxCDZ4/RaY/NgFZbrhkLiXZJtCdyI13VPEp9cuEb1f9mEDM/wxXSukP22Pe+4
         Dv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780266; x=1763385066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ9dEuHA7QP47k8+mFjKN7aiDkO2eEnpi3eRdL/AdNc=;
        b=CQxOAKbHCkdx/k5hPvaOl42u2PcTOsNWY5BLmunS+UPAd1JKI855XNdG7x4yvYEQK0
         J8cP1nHdJUHvQzzMYBDgZzF8NudustjWABe+Mqp2+/lQJZWiTJ4ms9mzGt2E0DdbcaGS
         wVoc87ztH8ryZ2AdcYpt+FTA4kB6Eu/K1Psq3m6zlxRCsg/HYqtpQTdnzIWriCMBZLqO
         35kOlbN3faA5xSz0bdtQIwD+H524XIq1w3HwGgLSuej4tNonxvtYH+uDHYDFcZaU+dUU
         6CEeCFGS10kV6UD1B9/v7y06xrCXfRDJ7dwYHyazgaMktXHEA9n56zaY8yjf9GExWP6s
         s4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdy1SZnKT6WSWBJ/wmbFxhHNvuSZrsWoUlcbR0UG/nfIVKwvQHUB1PqIZYA33X6nl0n0ymTIuzKAKXcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsy7SJMEzgpcKkyDT9yjKhDUks1TJLz09Ir0lrJN3NbuBzbUW
	oWj/MRh9xM5h3iEXvxMpUQKJ0JnLzQjsGIKIzjYdjHsVkswayWmB8tiUDpXbjfGTrueHThMfE97
	kYdVaj4toBFi6Svxc9fYLdzAjgsDSK2yG9ulTBkSOBA==
X-Gm-Gg: ASbGncvISa9/HkIFkNXuiKrpTpaOMr1t9AVzlyZ6A8C1wlu264kNc23VYD4ANlCFkHn
	XbR+aqKh+ViSxvgroKMjvquOjc4Z/UXV2EVm3SGNct5Kg4LWdOMHLGmmra4FhA0tjNYfgaostFy
	lJETpBfnPJ4SvKp3BxwRgkk98wC8Cbsq3OTN35DYnBt82a/GvVAu3YTB2dhdwULp2g3+WOETJfN
	IzYxrlo3MbQOKrYACZdoszXoSBRzwy+9HR4ohnYIn5tfaFvHi8rVonvmhlMrSi1SQ8iHnAAMjqQ
	tW2L9msGrgARyzb5
X-Google-Smtp-Source: AGHT+IGPitg7K5XoZgRQkP9FaImCQLO1InXFpXMUt4u6tDzxq2I7G9KRZEGJLJgmks99vhYut7CnjxNMlDxBUQ3PjRE=
X-Received: by 2002:a17:907:3f26:b0:b3d:9261:ff1b with SMTP id
 a640c23a62f3a-b72e029316emr763218866b.5.1762780265467; Mon, 10 Nov 2025
 05:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 10 Nov 2025 14:10:53 +0100
X-Gm-Features: AWmQ_blKnASBsaS7hJ2XpHrQ-4sRSj2u5D16heHa45ya298_aUcuoaggfc-rRk8
Message-ID: <CACMJSevoC3xYoeodGYnY4_EFSexqbNLqT_7UbRu9DxDRx8_gzA@mail.gmail.com>
Subject: Re: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based allocations
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Xin Liu <xin.liu@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 15:38, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Devres APIs are intended for use in drivers, and they should be
> avoided in shared subsystem code which is being used by multiple
> drivers. Avoid using devres based allocations in the reboot-mode
> subsystem and manually free the resources.
>

You're making it sound as if there's some race condition going on.
That's not the reason. They should be avoided in subsystem code
because you have no guarantee that the function will be called after
the driver is attached to the device nor that it will not be
referenced after the managed resources were released after a driver
detach. It's about life-times not synchronization.

Bart

