Return-Path: <linux-kernel+bounces-796020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61298B3FAFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D893BD5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A200027C866;
	Tue,  2 Sep 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VV9cfahB"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B427AC2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806468; cv=none; b=lHPJ7fk2QABwqhnUxcf9FaeExN3f4Lsu8++v9Ni4ucsCdqWqyuynGFoetQpZX83X/9Lo+rN+GfQPSZKsyTAnie+EkTkpmV3Kjd3iJ9YbpZ5W8WxssxknFnPT6G+ZqRuxhWQWl3Q+ZjPJOqmX8hAYnTIiP8G5LRxQpSqPSZsz9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806468; c=relaxed/simple;
	bh=tb+i42TjS4WClFhI4g/9RfeNIRUDoADVsxkZ23rVgfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IStgDX1EpvA6+Amr7QL1k+SwO7oTHbHGVJ9wr4Er06mImtkaKlSIuhAM5UJhRun6kVQLytfjNwuFnuvxpT+KZEmGUsFtN7wzG4ophmQiH0v4c/5qwK7oegJWYhA2xvnfJtVdMdl0BHrWpL16WkY8irlI8cy+UEhh6Xowk0OrQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VV9cfahB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so2695227f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756806464; x=1757411264; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C15nnHq5jGNekOrg1oEoMYGXiDnEqflax+NNj/Q5DWg=;
        b=VV9cfahBSdV4536rCamoWM4r3441c0MVAQG9l5kG5CkY8wAkR1Bxz5uI4+Em384vvu
         DSPx1Ei+RUHtz0sc2csR16kKcSTqR3HPhwmWoQsgwIvb8+xiWMRta0iZ/d52OS1AO/gG
         K2ElTRA5nVc1nyxjUURLBRMdE37vajeRARHWlDdsZ4b41dpq52VlYrhTGsBiPcCe/sLF
         9H4SBO6WUkBHnQ3qIH3Pjm7pajI3sgTES41W7d5urWjMfwMld8/lFALlDN1K4sG6HDqp
         V1qE3Djm2w0am5kYiJtISN8+FSvtiwq3DGNJkn85Dgy1AOo+fHjmTGjQAnVUvGMkPGtl
         c/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806464; x=1757411264;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C15nnHq5jGNekOrg1oEoMYGXiDnEqflax+NNj/Q5DWg=;
        b=vMa0JoHD9F0dAFTVzFCQZcnqploSQmnfmxbQw5/Ro7MvkpWyfMkg3xBfOvSsngtnXG
         I9rfazryFO3THZC1DYZ0AuypAxiETnUoQYa2M7wpu220kYF3hXTq5kUTFgxOzMS0rVn3
         +qJG4iRwJ+DmBkyatgMpacklAeYeSGCmXbmH2DhY8j2Dcd2jRdR0pxCzrz1akzMTvc24
         C8tYl2RqTifD/iSLgugYAXzepsiO1AX4Mc9WKZ9KlRLiL+4qBP7/ibMN6Wxg3naqpzBT
         F+aY51KYs4zwXtIXxblkeVzgjYMmOr9KF6e5ptX2v6AKyzn9iWyV575HC4IKMBb39QEa
         9/8w==
X-Forwarded-Encrypted: i=1; AJvYcCUVgrIqGru9ZDJjQavd3a1EE08grb0tMEU0mosRTaKAyy3ge3E/V9h2rTV7LSMmlrGrP4JUYcyOIQ0OgLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOK92VMPmtoP43nxeww0cnhi1HyQHUWveZVJu76kdeuDCvM2x/
	vDDkZalZ/TM1mH9hLWsBgDAsWgD7dzFMGo3gXTrrON5APVM8CBabou18qseJkEnq8N0=
X-Gm-Gg: ASbGncu5vwDqtdIGSOXR1+XDkg094tHiGeP1gAggo8g6mKU/K+YQd1oj06CyWc1fp3N
	t+CsZYdNt620p5W8pSpRTDdm+IATWZw2v1+b1bMggxs6ZDMtQ0/CMG2dyU9u4a/QPiWRTYiB28W
	TaXRkYcVKb8/XnJvYa4r5+XjLWRiXzZ1XsY3i+rEbxFV8+YX+fFnEHlcm3QhuMpo5hW3dRc2vSi
	jV4crcCsViEKUAL3m4PV94P6chnttGxW0LwxT01EQMqviU0Mq/UCg6YLHICvCEjxnt/G84VdOya
	fzBe0XIgt+glD5JhtBetxg/dQrMxpxqLkVGPzCeVv3YuDtD05kyFm4Up5h03vRVoxYwEyWcrrXN
	VpAaYEDDaKXie0ExUBfC3NW+TFTx6FgIQOJ+xxQ==
X-Google-Smtp-Source: AGHT+IF3trB+IqLVZP1NbcKHzI17jtlNkvyPbQokeVhgB/0JExvYEQ3RkklZMsS1InChMNxxtoDrQA==
X-Received: by 2002:a05:6000:4023:b0:3d9:b028:e278 with SMTP id ffacd0b85a97d-3d9b028e5c9mr1425217f8f.51.1756806464235;
        Tue, 02 Sep 2025 02:47:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d0a7691340sm18023223f8f.39.2025.09.02.02.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:47:43 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:47:40 +0300
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
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH v3 0/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <cover.1756800543.git.dan.carpenter@linaro.org>
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

v3: Mostly small cleanups.  Re-order device tree entries.  Remove unused
    label.  Use dev_err_probe().

v2: Major cleanups to device tree.  Fix sign-offs.  Re-write driver using
    keepouts.

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
 drivers/nvmem/s32g-ocotp-nvmem.c              | 100 ++++++++++++++++++
 6 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

-- 
2.47.2


