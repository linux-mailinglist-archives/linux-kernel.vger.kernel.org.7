Return-Path: <linux-kernel+bounces-787032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DDB370A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BCE1BA079A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27BD24CEE8;
	Tue, 26 Aug 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKt76xfJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE12D191C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226280; cv=none; b=oNG5HTpeGaal7k7ZY9ET/sz8xVXxHdo3koVCqVlbQDaBy53M1SyEba1IQ/Ko3deFmhUPuImQICIcli1kOelWwhOBAMlZrax2SJwytQaGV4108kH7YxLmTOEEHCQsU4/Y0BfNXDjVRs/fMn6rh5ExfhEMceKtVudDakwbRmbQ6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226280; c=relaxed/simple;
	bh=qoVpdmGthhQwIvIAInNuWNaL30K614K46buqtNbFa18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZZn4eocngtLGGK2NIlQ/AVkf9fmdoGl0dUJQahXoQgZ+3e9jc1ZpOC6cSG90ZjxkHO9B/bUbgxe79j7jUtpz/uH5rbksdT1RZz0588u3KL3Mue4jXD7Sc/o3o4vjVMmhGH2mAsOdxmVdDGTZKvKKOeKW4Qcuor+wAFqP93drys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKt76xfJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b618e067eso352255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756226276; x=1756831076; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXjzFWweCUpLGhqs+Qc2v5kfooS7EDEgFn61h3Rxlrg=;
        b=aKt76xfJkz5PSNmUMWf9Q0tQNHCrVhISqFfxoa57N6RO65DvZy2VBUZilaadGzbkE4
         7sziuB7SJJ5lkvo8NDeuW9K74plIRRrAMGLo2crv82aqno11dhyOyogymITSFVfunKDw
         EyyFzNq9umV/2C6FNzSHhNpsf3We/LpR+aV0cdyKWgDcb/Nikkvn4ugeVNBESX0vhONn
         30sKaXXj+aIIKdZdKaIxhJ5XG1YujV75SC71oxy/efUssBQ7b2/cQsQYUEx3GvQHhb4A
         YpuE/XvddhKVkKS6aDIPesmWslpL1a4B1hbklTWwc5VysRFzaNBYeDlahhPKg+6eixRy
         ecEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226276; x=1756831076;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXjzFWweCUpLGhqs+Qc2v5kfooS7EDEgFn61h3Rxlrg=;
        b=XPZYlSWZIQ1Oe4RHx9M5e1POGWMHxwCcGIzYN7y45GT8uo7z687S63ITwrS0uPG6St
         4QDyh5ZpMX0WiCZGdXwaC8a8dy4AC+S4VvbrGVJuuOFEnbw1+yM3b8I+fSKIJL8y3cIV
         TT22fQPa2u9OMhXjdEP0kHF7g0VfvkqCPlSw5S6LwpvKeFy48uklr5O+Qpsq/SFPzZ05
         X4lx4rdRDpf4FO8dgLBCsl2y2j7EvF9Mrn1obI9DSz/3tfRe4h7xxuQiKEnbXzbmut3Q
         GMQc8fpfkIHWKuLAoPum8M8rmIcC3/F/6PKPldNyaod1p2awv6hfkZCPZxA6LM88vpMP
         lC/g==
X-Forwarded-Encrypted: i=1; AJvYcCWTd0WZbBsC/gY5MzCA1hMyeplHq34iRq8+lefyAwY+Z7qy95EWKi1ijyNtId2ub6+AYNrooHhPrJtPeQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXU6WToLUrVmPfnZVePKHJ4fJEMr63zAmJpe3t6kkxgbcNWUb
	eOnBBzrmzCvoJQPbgFUTaD5nGNSjQ+Sw8kNHpvYiHcMik/ZXLPxFCXuJT7Hn+sB1EOA=
X-Gm-Gg: ASbGncui+p9OgDIgs7tmMzwdDgUhNXLRgTRCG9OmVMjpG9bja9r1hVDjj+YImSq14Jd
	bdZRDT4Oont5KLQImT4RfzV5/mK+gKr8FkSSLqbv1Qg8j0HEs4e7QlOAi2YG+87GkfEBVlj1Wr4
	i62jRSpuSo2ZXSwkdhCCC3et5f/nPKMmH4KcpB2Z/yjftdcNLAuaWz8F3CDPJxUwputL70zGo+y
	+1n/ID72+55H9DpVUF5x5CCldqFgcTteKYnTV8Ky46T3qOLAis9jV6VSGq/kS/GI3HNe7WM8yKk
	l07CvDYsQXjdZrv6/c+0zxi7tn/Lfeb39zTm5Fc507nZtUOHblxZsz1Vig5MqLa7PrZz7PMzdYw
	XH4+172BFTZyjpxc4VGjM+jeMGCY=
X-Google-Smtp-Source: AGHT+IFteKF0n9oClwejHyr5agehXDb0k7S2tqnIcjSRDmL+smq006tk4p7iGhuoEHb8FtlFd6aJOA==
X-Received: by 2002:a05:600c:19ca:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45b6870e3dfmr26425085e9.17.1756226275893;
        Tue, 26 Aug 2025 09:37:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c7113fdacfsm16879530f8f.35.2025.08.26.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:37:55 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:37:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Ciprian Costea <ciprianmarian.costea@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>, linaro-s32@linaro.org
Subject: [PATCH v2 0/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <cover.1756219848.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This driver provides a way to access the On Chip One-Time Programmable
Controller (OCOTP) on the s32g chipset.  There are three versions of this
chip but they're compatible.

v2:
I have fixed everything that people pointed out about version 1.

Sorry, Rob and Krzysztof, for the problems with the device tree YAML
file.  I had an issue with my dtschema installation and it's fixed now.

I also screwed up the From headers in v1.  I called git format-patch
without passing the --from argument.  I've fixed my scripts so that
won't happen again.  I also messed up the Signed-off by lines in patch
1 and 2.  Sorry!

My other mistakes were from not being a familiar enough with the
subsystem and those are addressed as well.  Especially re-writing the
driver using keepouts cut down a lot of lines of code.  I've tested it
and the results are the same before and after.

Ciprian Costea (2):
  dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
  nvmem: s32g-ocotp: Add driver for S32G OCOTP

Dan Carpenter (1):
  arm64: dts: s32g: Add device tree information for the OCOTP driver

 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  |  45 ++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |   7 ++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |   7 ++
 drivers/nvmem/Kconfig                         |  10 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/s32g-ocotp-nvmem.c              | 101 ++++++++++++++++++
 6 files changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

-- 
2.47.2


