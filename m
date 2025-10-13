Return-Path: <linux-kernel+bounces-850323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAC4BD2831
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF4464E5DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CF2FE580;
	Mon, 13 Oct 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if062vR2"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC82E6CC0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350659; cv=none; b=Go9/oMjn5sPsUMYM6NAS585FLFch9niZFYZV4Lb/pz4/pC5yADD0myAOxZnAIDqjOsnU0jNOV969FywtedmuWdA8e0sGRq2xZh/wuxtI2pEoTJki9788TCPUNMWDdmr1P7eUoPCMjk3hL4KLK+NazbrvUw0W6yXE/XobtsnEbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350659; c=relaxed/simple;
	bh=77NJvqQF1nAsnv1nanH3kBlJOQ9BOGCPO1Kjf8/3P4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LC7AJzYNDOBG90HDDXLU4CpUJuiSZ/4wITAPKyXQ1M28r+oRNSzjGwRfEtlqXCPEoGvLJEvThGn+CM4VWHxtBX1mscki8K+JG32y9HakOyTx/3HrfEoe/4DgtHtlj8XIOS/YWYRZCFt/Qkf83zmEko4ZjiZQ4ilqrGdcOU/6h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if062vR2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so3537418a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760350656; x=1760955456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wki4wD46J9sHWa2HWv+VTuD7xLgHt9zo+ivAkfQcV1Y=;
        b=if062vR2jPjECQvZWkd/vTCMEEIA9uppVwrnC1o/+cXtsmfd08UBdUn3K/oog3ctIO
         TVlqbEqiBlv/y7xKjnBz5NYgpZ09cPFT8/Z97wFWpdNrT290iX0MmLUyGsByK7029ZG8
         aGna1W020AJMJoEnWNRDiuUqbYcHFGVePhas/HHslzknt2jJO/9Ahr+8mlZoS8IMgQZq
         33cJd1IC+kcpeDatVwBs1iUkORsyFdtx5K9bU92DrSC4SHkQBWTGLlyU2RA3AdpwvsKQ
         a6PCj2aCzXLaZPzzUvLr3GjguXbxG8ffgoZ936KQ7+IO7yAY7jB7plILfOB1DhhtV3Gt
         9sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350656; x=1760955456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wki4wD46J9sHWa2HWv+VTuD7xLgHt9zo+ivAkfQcV1Y=;
        b=KlTNrtyI4GEnUUn/Auzr3CnFXLtWkm9BWq6lILDGrIrEpnAjDEsbD2XhULp1ckfBsd
         dN+1ShICNFKRhXez2j+4ReAq1RW8UZf9KC311C4D09BvACbofHV5GIug1+xWDBlS4rn9
         Rtb4jvCeWBVfCbyJbi1rh8HkFe1t34fYuD7ZnMY/homkouiZAebi2/JzwsfIHFcyjFeg
         SeuzghISOxk2kaeMO/kUleTW/hLh3HM9WUZdczCg3GBVHFVgzWO5ciWSuAj0IP2wzfKP
         LD8p47uziLQGEVuqTsXoiclZd1tAQLD05kdgw7NeRZmaKlKGAI8V46ynDZYLFMiMJEkz
         dEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDwEzOKttA6G8s8gY67BECc//pXpLpwPgNB23JWYKrIEcWV1fqBLX21tbkSTlSs6iTQ7YUj2BSzEE/AnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJppEbdAr0IaD2PmXuiFrubLj/gk9kMZ6FRvqiUDGGkpUSUYi
	4yQxg3l21m+LS/cDtWS1Nvp4SjDl5vDhDphqLc0pgVz89frV2oPgUGVy
X-Gm-Gg: ASbGncuLoCf8GKPer1QOyTqxfbSjTGRR/aMrRQXH6Kd6LZoagMAeWxUGv4v5LiaoNfW
	b00JU2AWyHp/dRf6Y57pmVaviFnB4OBBqniwxjyMHsjNXtNeKfXU2AIAJDpwSyZxbdduNOSFGX3
	O9L3vU5xEtp5spBcPGNRbzg14gPz1XbjP+09ba/rqfSxxnF2neIoUqQ1YYSj1zSt1mFXAnsg8NV
	wNuxzrA5+UGXeUMkzDrRlgiQcza0TTsknQqtIeTy/gUOBJLBJumeMCQs0+TJOvL9XDKyPqIQU9O
	op802DcoeTC4kn0/8Rl4aTp/DeHpgrgeSQs4nm2cUrYGNafBgVkhiHo562YCDBPCq1n7Dy8hdiB
	6x29q6QKKqKerfwfUAE40A02V4CID/3xJc+U1ayBrdVrOJMVTJw==
X-Google-Smtp-Source: AGHT+IFWUyq6JEcHtp3am/7eUBgtvhj0qj3bSnmWO1N5QwdAIzZeISWAhKZhiB/dnKtHDfPJBcdWEQ==
X-Received: by 2002:a17:90b:38d2:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33b5138401amr28464765a91.28.1760350656488;
        Mon, 13 Oct 2025 03:17:36 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a5656dsm7422864a91.11.2025.10.13.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:17:35 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 0/2] PCI: j721e: A couple of cleanups
Date: Mon, 13 Oct 2025 15:47:22 +0530
Message-ID: <20251013101727.129260-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

Thanks
-Anand

Anand Moon (2):
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 25 +++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.50.1


