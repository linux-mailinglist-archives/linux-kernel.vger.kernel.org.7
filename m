Return-Path: <linux-kernel+bounces-871899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC832C0EC88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D6295023B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721E30C60C;
	Mon, 27 Oct 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2IonNmH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CF30C609
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576972; cv=none; b=WY/G5QiQWtYCEvV/uX18X9Z51/Ie/ZlOJjLEanlnLjUb6OU3Ic+YFc2rGFtn5vG/jtgVdNRQam3+9FRhzFiLfio/6YLcH/9ulaZN8Yi3yugc7XTLAhIYksdWz7VKjjTC0PFhTAY4bTXlS+SY7uq73GFT2tOQsVEBOoR5O/r28xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576972; c=relaxed/simple;
	bh=JQ2Eg/fxzgQwaU0erBgyehxjwvhanKuWBXC39MUZvkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UA8wLnbH7ePAfk+935yHjk7qFxL/YACcHuFIjDjuQWq+uJZ8Qd5ZkExt/9WoV4mG1m2Wkc9nck+kqtVkJMz0D9yKGzMGZNsAVBroELkAE7QnCfxLuXOhwJ7XCmIy4LT9PvenNvs5v4Af2SHe6ifdD24OI0qH8E36RNYZVOql/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2IonNmH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so928537b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576970; x=1762181770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yVMi7V8qTRELGGfV+IcZ9w9BuBp+eY7s7IocvDD4Ig=;
        b=e2IonNmHnm5w6HS+St6D0v35hy7/3yisM8VKUesngmTpdBvpCdCFcV3p52Z0I0Ouam
         USsY9KfytMQ3SV+KK3J/HoGllCTEtT8NBEUaDiY2tw+MaEMhSFkngOejGidqgRWX6a/o
         ZefxMXngBMVtsxPu+W6fBZhnnzBxAndZ+NrmKsoefM7PlzfCXdaRCyg5UiIxddFS/zYO
         f91ppe0YhGMdK8m6IzGwULhtlQldiPRbNFK6z1f5JpC5Ts/E0RAWoh3LT8NhVLSn6Ume
         YHgdSKEKv3HPK2dxLwh4dpdL7tyScNxdN28q9BP+8I9vF0rLPHcid08iLXnEEKZR+mZt
         hslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576970; x=1762181770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yVMi7V8qTRELGGfV+IcZ9w9BuBp+eY7s7IocvDD4Ig=;
        b=JdUfojXXw7JmJSg1Wg+qHBjMboKgbGLD4Pvb9QLKAQ3ggZ13flYaB06FT+w23ZfWL+
         ENOlKeoEVSLxIWNF2EbdOiRLzU+JQd5CAPyykAbVvIq1M356PbMxHzYTFLuK6fof0pdj
         hJ+lBBL6TCMPbxyojBFu4/Ne54HuBsY/jot+/n0BxUzAi7R6xHnpyFvouwpIoCFJ0oK8
         IjuoENlebqC0CE53JaEN+XhAyoZEubQ63WOIQqdYXub2FB9SI3G6NuzFboCy8QFe8INQ
         CEc52Fvvvt8W1Lmv3k9L5gQ5BKStu+nsyR46dUBty7V3Lo2UDbBRruJBw4optGfNh5iX
         OHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUojaQB/uoUDEvneQMohUp+E/qpdKKepUqHJ868hjmzoExM/3aK97GDYSKiK3k2x9ELhGPLb9/qrExAxfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNiOvCwYCFSN2nIyO+OdmjEG5LBZ6R8QWunxgpC6L0PchmUAx
	7Mq6+myg4CTJgwQq6hkXLmerEI2DKKuBxjH5IBL4FEx9+ErUtKyrLj3v
X-Gm-Gg: ASbGnct5q8IOylTA3RBp5Z1RhaTm+JFB4EShrkj1Qeyid9W/vNZDYlvKd/FhxsTcaYJ
	0gmicxuokjT5wp+AhnlabtMBVdVbjaA+qnBY11O98Z0qxvN2Oy/sZI2cPNg9ZcnCCyBN0N3CzAk
	1ixXB0qvId3OpDJ83fYy3jOsxFKTs2py3cc8SP7uEcfIrcuEGWuid2j6k1DIGlCGF+c6IgZdJB/
	tM2AzcDVsXg/TS38C1u5lm7xnek9kkDbU4W8tr3RwBQ440IJV3rnGtAcev6kUDOVcZLLxOJWhXa
	gnXQ4IgEAOZtrBbNHyDoejs8qaW/wq890z1tEjzth9bDICYsfBJPjMj4mPt2uwrqlo5kPNS+YfA
	O7MbVOEFjBNdLtqnNPZWwwjav9XvOPfRtQ5NXfejHTujvqCic5HeudyWjMwUw1hhobi+82CO3ou
	xDJBV3rrLo/Xo+NOBulXc=
X-Google-Smtp-Source: AGHT+IFNNRsqOAD0ej4MkP02YIZHAarj1O7wDlGaz+jF0eTKJU0nb26xxgTWECACFe3NIf0baZUBNA==
X-Received: by 2002:a05:6a00:c86:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a441b7aa11mr318696b3a.7.1761576970098;
        Mon, 27 Oct 2025 07:56:10 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm8373372b3a.12.2025.10.27.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:56:09 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 0/2] Add runtime PM support to Rockchip DW PCIe driver
Date: Mon, 27 Oct 2025 20:25:28 +0530
Message-ID: <20251027145602.199154-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce runtime power management support in the Rockchip DesignWare PCIe
controller driver.  These changes allow the PCIe controller to suspend and
resume dynamically, improving power efficiency on supported platforms.

Can Patch 1 can be backpoted to stable? It helps clean shutdown of PCIe.

Clarification: the series is based on

git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
branch : controller/dw-rockchip

Thanks
-Anand

Anand Moon (2):
  PCI: dw-rockchip: Add remove callback for resource cleanup
  PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe driver

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)


base-commit: 7ad31f88429369ada44710176e176256a2812c3f
-- 
2.50.1


