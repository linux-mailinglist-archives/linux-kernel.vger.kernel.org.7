Return-Path: <linux-kernel+bounces-814198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4DB550A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1257C4523
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4530FF3F;
	Fri, 12 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL6JFHwK"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498630F7F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686481; cv=none; b=Bmh/SlFudfC+ixTbrP56/SxVNRaM6GwL+sI7TW2uxMy8+92LPvErAgajHq039WeV+/FPV+uyDIAr3rEP5yK7A6U98rLn4Gc/5x6GN2irKV3lZxDjKADDgLyyiyimOKYDmvu433rec00KqHx80tC0eooankdOH+adVjeJcyUsB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686481; c=relaxed/simple;
	bh=P/I0o3Ct3tb/qJdXM8/n0dAX0XqgE4/yICfEQ61ZAYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kONfikCnOOzq5CW4ApAZQCwKlsddOaEkHv5Sii4DyYn1DdcDlXA5uZGAVIq2jZ35qGSxhDnt9LQDeaF+MmXKeAmizJxRguuFAJUhTrc45dG0JQmzD1VxsMeIfbx+kVhmXTkjcAsOduLZJuOUHVSnW/FcP+jXg9bSaOP52LvLgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aL6JFHwK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3dad6252eacso851088f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686478; x=1758291278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYPHqMTKCV/4SepZAwfa5rvCiamyWF/H10RFWd8DrNU=;
        b=aL6JFHwK23xkKMtouQob03v2a9zHWiaSdve+K6yEB+izJWMvTZnDB6Wtmt5NQuBaVi
         fW5mdSkWt/2m5woac6nszCxhQ7ZcLQjM/47Lcb8ky0UIJ6PjG6+hiaIlVvhmakchxrNn
         et/W3hmitlYpebfvtzEmlBwTwjAPIHMsCgkFrExmKUF3M9+wzSz7xORMbnoZ2ItENJx/
         1KrSM2SNwHFjDIaHAjhLQDjKE9u1WAsL90eEc+V9YpcSKAErN9vnxwziGKzvU5bE3RiN
         l5gv5HqHsCxLPZZK0cPZ7b+KZYlPX3nCs27Aap4HsSnENgPM7TcvUYIR7GIXb5+UFYw4
         bZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686478; x=1758291278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYPHqMTKCV/4SepZAwfa5rvCiamyWF/H10RFWd8DrNU=;
        b=qSIVjjrnvqpxH64sJm951ScpE9C/cOp1zO4GezUvBHSAA7G69uw5+PrhBm1AISjlXR
         WuPFjrR1GCWJ9SDJbhAOWxntp5FEryBFvj8cm2JZufyEPDwadFfkibOTZzKDeBoSqo+1
         nGyyjZhRLxLpNvCzQfQu6Y0mvRZpCLOiRz4HDD5XjSdLKFEqMfsA8fhyL4W5/AzwoESP
         w+T1zyOdg1tni0IzpsLlfAgw1ezcReEcxPu6wzKvFmihaIRzc7XpyFwcqrGgHj9H99Uq
         yXntZuL5f6arUrXyG2Q7hjNeeUMrXj2/miHGva7NQuUa5ZvSHeLmDwT7R3sfyPwPx2Jm
         bnIw==
X-Forwarded-Encrypted: i=1; AJvYcCVyJXEegySFMT3ENscAVKDOPfr/EHSgmDsxMi7VrUOhj8ptqxsmo7Cv9n7FaXkTK0L+xkZeUkMOmYSQyb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2rtA9qtfCYKpAFbEz75bDe+G3CUwZ/MkyNKVnp4OA8XzXzGI
	ROp+ViOs5YWyLSXZJKgn79RdGc28Pl6w/4g1It14YrdtjLhUe7xDSLOM4Rgw5oFsJOI=
X-Gm-Gg: ASbGncu9fp3SADDWxNqJhtCAkJXaDto2CKKRgMjAk13C2JNbu6McwceaMf1edo/6PQ7
	V2gV78almTC8IEibK6uKS5Q+SyD+bdYwY8EHFFvA9ALLpGNH53HArE8QohHwzzdYjiwdLP2EEAS
	gz445g2PNAwZOroYsc/mSIPuCwQpGYH3zV8lq8vghAxvg9vEb2hA6MbwqAzqQMbarHCsVJSSQ2S
	/LWaTfM+59jTqrtpinPMAGZD9fYjypAXqbYsEyRO86/dB/0xNsD1ZFVllZi09mGlqaituTZ0jlY
	1UUHPAVLH8hpWxUDRVwwVE8twS120K7UnSvA0ExA0GSwMCCIxluxvbIBkppeRvRPk5052hDmkHS
	HaJbh3d8jPn99fZnUMhSA77VOCHTkLWWKQfTDgZr3JQ==
X-Google-Smtp-Source: AGHT+IHmuQ4etOmxfxR5erD34BAIdfgntlZi1sczMbDFjFRnIdZIcAxN0Jzl68sTWuowQwjuFwFKgQ==
X-Received: by 2002:a5d:5d05:0:b0:3e7:46bf:f8bd with SMTP id ffacd0b85a97d-3e765793224mr2876593f8f.23.1757686477682;
        Fri, 12 Sep 2025 07:14:37 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:36 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] pcie: s32g: Add support for PCIe controller
Date: Fri, 12 Sep 2025 16:14:32 +0200
Message-ID: <20250912141436.2347852-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G SoC family has 2 PCIe controllers based on Designware IP.

Add the support for Host mode.

Ciprian Costea (1):
  pcie: s32g: Add Phy clock definition

Vincent Guittot (3):
  dt-bindings: pcie: Add the NXP PCIe controller
  pcie: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 +++++
 MAINTAINERS                                   |   3 +
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pci-s32g-regs.h    | 105 +++
 drivers/pci/controller/dwc/pci-s32g.c         | 697 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-s32g.h         |  45 ++
 .../linux/pcie/nxp-s32g-pcie-phy-submode.h    |  15 +
 8 files changed, 1047 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pci-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pci-s32g.c
 create mode 100644 drivers/pci/controller/dwc/pci-s32g.h
 create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h

-- 
2.43.0


