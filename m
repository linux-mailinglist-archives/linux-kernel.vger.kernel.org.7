Return-Path: <linux-kernel+bounces-824912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E566B8A74C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74951C86624
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDA31E0FE;
	Fri, 19 Sep 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmhZBk7Y"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09E31E883
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297506; cv=none; b=ibeiY6nTbR3TIIRGyaNV/ubOnyBezCqwg4YdePD4sfD7Z3ul5ivLBibrhj5URFzeTa57Oub+/DmvEb5QoLrVR6T4RIXFq8xc8QaganaeSMc0Oi8YC9jdaj2uMVCGPvA60mFv1bZ+BbHr8E5u3fDeLOpBZ/8w3OWeBdqV+JyYTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297506; c=relaxed/simple;
	bh=N7YR47rPh9IYgAs1yBMwxo0aIg9W+HiNLeVlSehJYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dp1nV/W6Hc8yutByloMGL93TnqiZlRsYqeuCb0RMtU7uTAD8nl9lgvqtOUXCZzpgEOvTfj6g90bERhMeBfrnk1VDRns/hrs3x6NuZ4e+m2Fm0hgCrADWmElPMpnfTqXkpQ3DXnLpu65sX+c5y7+781UiJt9rwTJVwJzl5lvsKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CmhZBk7Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1776434f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297503; x=1758902303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtPW98rgBsi1AXsCtSgCobaGSpH9VMGiOKrsL1cwC2U=;
        b=CmhZBk7YvjaaQB1/Z8EKPyb7X76hrAYfY/BOhHSTKMMvJM4k8f8aEuMGJiCoevF5nb
         kXdBFDYOrS2JnpfqjeiB5BR2qdlyYsZv5KvNsMS0oT2d6ZPAgZWRCrD4J7dtoqmxqRXW
         +XtUc1gmBU2RnDlpArmgvUEMUGuoIWTqWuvlonNe8aTCgE2CBVXrqFHZolbZHEm1l5Y5
         JgiV+rRMBcn9Vmp+ofLgzWrNahe3fXsRYJqW+5Q3j8KdjVNYIxmRAkbqsGI9vr7VHRdn
         rwVOuEV1Hnd+T8vPuy5WDBq5i5CaFMRN/5bllbZesZVp/hie5OPnyBDNYNrNFJI+jMGs
         Mz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297503; x=1758902303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtPW98rgBsi1AXsCtSgCobaGSpH9VMGiOKrsL1cwC2U=;
        b=oR1Y6ftfbRrecYv5NPCLVC3bjqBWYjGYGR0UYYi35wC58Um/PSzDb4paTVo0E+U89x
         X/rs/8wKa3VuPuO4Yugu+TX40SXI4as0kF/vWPd3LdnqAoRflixDYdnqMDTmsKCdY/A+
         uqFMHIl6D2vOBuzOrKpim7f2mPj/kzNmmc4phkOMhkJlXzAmDZQw5FooyOREnyfPW9W7
         RyecuGmXkQmMscQQtcLLbmro2UpQloswCQLcrTMPe7wR6IULhsObsV352gkWKmChJGu4
         afqKp5UoL6d0QcMOE/Jt41x7pJaGWZ+ahqKSNBcx9aIOr1KOYh+m3W06XJc2F/0Pd0cM
         CTIA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ECtsN8rEeIa79gtV7twMaVXrufFD9LqHLSOm2Xa2iYuxUe3zcfvoOVIeiX7/6wt+05oUEI83J0WIvVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqgWOxpdvYljeO2whhDbhaGrnQ9+bJn8pOzmGXV6Bk7tm/8kc
	0RW7hpBx1t8C+/6JsKag58grWZ6MpbEfhFil9rn7YNvQrY3wW3jWecNBTkJcQw0mhKQ=
X-Gm-Gg: ASbGncte4yapI3wJ6zSKtIEH5NJxqVC2/DZLabWEr4qiYRnwH7Ox4p0HNANGdVQY7ep
	+fF+detacUGmFsAglU8rXju+eV/PwkbVAfSzb4mqEcraj3ISpcfdLoD3/H3qa0GEAyBAl9P2s1e
	ih5OGRNt5vYoXpwLFbRxX3O0BoYGnborDQpJNDqgxnyQ2JK3YeeAuUrYMaCiy0GGfxRHoXw+ROa
	MNR7Q71I0adj8JZghLTgneYphvyizaX5yOMzDlLqgHqLw9QrWHw+5SseczBQVQjB4wdWLVoW9OP
	MwfQ5mlUuJSS6p8DnjAKDnMZof79yy3GHy5sNggwhDZSpwTLcmu3X9UlpB3XJcWeHVqhOtxd1Ti
	Q1mJW83QdQGxKWVCDdQ3PAReLJA8BNXs=
X-Google-Smtp-Source: AGHT+IFYUaAn9i6Eqk0wNZqPapSoDfpti615G8HPJJeCq6Zt6cdqWx78zxKqOQok9+7kvdNqxLGyAw==
X-Received: by 2002:a05:6000:144b:b0:3ec:3d75:1310 with SMTP id ffacd0b85a97d-3ee205def16mr3262070f8f.30.1758297502881;
        Fri, 19 Sep 2025 08:58:22 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:9dd0:62bf:d369:14ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm8367224f8f.21.2025.09.19.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:58:22 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
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
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 0/4 v2] PCI: s32g: Add support for PCIe controller
Date: Fri, 19 Sep 2025 17:58:18 +0200
Message-ID: <20250919155821.95334-1-vincent.guittot@linaro.org>
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

Change since v1:

- Cleanup DT binding
  - Removed useless description and fixed typo, naming and indentation.
  - Removed nxp,phy-mode binding until we agreed on a generic binding.
    Default (crnss) mode is used for now. Generic binding wil be discussed
    in a separate patch.
  - Removed max-link-speed and num-lanes which are coming from
    snps,dw-pcie-common.yaml. They are needed only if to restrict from the
    the default hw config.
  - Added unevaluatedProperties: false
  - Keep Phys in host node until dw support Root Port node.

- Removed nxp-s32g-pcie-phy-submode.h until there is a generic clock and
  spectrum binding.

- Rename files to start with pcie-s32g instead of pci-s32g

- Cleanup pcie-s32-reg.h and use dw_pcie_find_capability()

- cleanup and rename in s32g-pcie.c in addtion to remove useless check or
  duplicate code.

- dw_pcie_suspend/resume_noirq() doesn't woork, need to set child device
  to reach lowest state.

- Added L: imx@lists.linux.dev in MAINTAINERS

Vincent Guittot (3):
  dt-bindings: PCI: s32g: Add NXP PCIe controller
  PCI: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 131 ++++
 MAINTAINERS                                   |   4 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-s32g-regs.h   |  61 ++
 drivers/pci/controller/dwc/pcie-s32g.c        | 578 ++++++++++++++++++
 7 files changed, 787 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c

-- 
2.43.0


