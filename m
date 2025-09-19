Return-Path: <linux-kernel+bounces-824247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE9B887F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB3D17D55C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D702F1FE3;
	Fri, 19 Sep 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZXxHTal0"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A12ECEAB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272371; cv=none; b=l1kAiZGicFnRcla16jLsly3PY+BdtRjp83WD2RajJ1EIF3AUTGFDbedYeqWRTWZ6E2QSDe7oIb+qD4IfJygOZ74WksLvLNh81Gk6FnkZkC9dqQAMpEjvwHG/sGslJekkCEL1POA2befYWSkhDKXdDXZ4cLk5o3H0aRodoDNVx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272371; c=relaxed/simple;
	bh=9ObgdudbHZjNAJMxy34yZ5sg9lOvahRsDrJ71ZljD6U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bXqi+pA+QFdIQAUljb1qmR3zaNYi1hbxr0fDUsPvrVhQptBbnTioS3Ca2OHbD6f2zWOPl6scYm8uKp/5xORtjQrGG3ZHubIzyVvEWdl0KUuvhyXRgoglmkHA2w1zcCaQxL2Kv5iiou9yhIk6wRnlx0Qh532PSfxAyJ8BI9YaboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZXxHTal0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso1495316a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758272369; x=1758877169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd4+r2dhQsnGJWDtpIiRBK1eOzcnNFsZ+J1UvHrl0i8=;
        b=ZXxHTal0LTynXoiR+T6F2gEuKB7nWgiLy2GeuONiYG1lTdPQ0TXw+uCwwBm0q5mHf/
         /c8MVoS1Z+7EE3p0kuyAmvn51fUYn6yGXAe7NMHQrBEorT/3c1SB7uPDwU+ZmrOfLcBZ
         SsBpkbbR/y+et4gk8sLVQGgL5CJw/NRrODjWjVARrjgJSjVvFz9JShoezG6+KfFIFy/m
         M5l7TJof5Ih7xiYVkD+dBcQ6hgJZzvGb/vB/VshHP7SxRYGHS9/rxb6GWdHqXD3UZKMm
         9z0M2FV1Xv7eGvv1W8Py8zK+HdGegvbmb0SVUmo6KsiAvPz7dTFmaXxnZkfkwL8ZQrLS
         D1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272369; x=1758877169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd4+r2dhQsnGJWDtpIiRBK1eOzcnNFsZ+J1UvHrl0i8=;
        b=El9EVZ9f4hiuGERtM6Z+fsTHAxcdEVfptcJX9v81oqNsjmqO5aPerScug/sa5goipU
         n7IyoIk8/HEMzMeASXsIfhmQhSWOshe3L4mN5BJB5icX6PymzSOxXCN1sWro2vm5wy1k
         QeoD9m/ZBD8v1gTkj4RULgesJx2b3qNz1OTlDkkgjYs9R8bcG1MNulbEDABIpvMK8vT6
         zdVO3d3MNdGmtczMrodShdvw/kRBhARuaSQhsja/4Ksf7+1UiPpf2qBLm3dh8vPTXaxi
         gCGBQfVhLVGDiqp9DiHa8sJacMC6CAfCrmfOFByxNuDbziLgkhgxIe+GOuiKGnUHv4NG
         RsOg==
X-Forwarded-Encrypted: i=1; AJvYcCW12qTcsIRtLA6PMyMUvQvCROSqL45cxHIJd3MsD9kElfIALpp7IbYInjPCRV1qhgUw1juKOVaw+1FEpBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxinbTRj2OPTlM24oroWelUo9Un2i0fKJ6XynAwPuuYzl0o5S
	ru7wk+zFMnOqQrjHbLOBsHMMK6ZqIv3lwv6eZ13tYL6TWf4d7eD+m6hI8K8Q1RylQ40=
X-Gm-Gg: ASbGncsGF+JZqh7Es2RaLCgX6mwrmP0t2YgggCJbkI+Ms8tNf86H7CTO60DHNsyNMuO
	lPeauyMXalCuymwapwIr6PveNH9bH/gX67Wa7jFlU90aKHdfLCTZVmD6SUvi7CS/Mb8Q3nLqViV
	9SOIaHU7clXpp05pejvlOT/3A7Y2Rh7kd3dBJkipKYFcLJcZc4phuxe8e94ULwia31YZVmbHhrx
	vk8tyubDiAPt83awZNS5gLhE6I0BxXisUiP/RzEtuDo96wVZiQZtC6COJ03Jw/6eGWcbkP68d++
	Mw1O9WJKoArF+vcGFg7/A3yH9eIEArQ9dWs6u4U4lzWX4U/llsfEs3yJwZ3N5u/XYNMLnlLyiFp
	FQScWjR+MH4SK9KMDQYHvbFiMycUMv8RzSUwrHBPxz6DJorEPPm9UzDHEfHUtvrA=
X-Google-Smtp-Source: AGHT+IHKd0DN1mMgIsdoDc2vCyjSm4FEnZTd1jI/4gD2C7NwmhKkFKPKgahyIRBmjtrslXkABEcCGA==
X-Received: by 2002:a17:90b:2fce:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-33097fee7c1mr2630942a91.13.1758272369344;
        Fri, 19 Sep 2025 01:59:29 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7ab97sm4687456b3a.14.2025.09.19.01.59.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 01:59:29 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	beata.michalska@arm.com,
	ptsm@linux.microsoft.com,
	sumitg@nvidia.com,
	yangyicong@hisilicon.com,
	cuiyunhui@bytedance.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] Add support for parse_acpi_topology() on RISC-V
Date: Fri, 19 Sep 2025 16:59:17 +0800
Message-Id: <20250919085918.5442-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
Place the struct cpu_smt_info{} in drivers/base/arch_topology.c instead of arch_topology.h

v2->v3:
Modify the return values of acpi_pptt_cpu_is_thread()

Yunhui Cui (1):
  arch_topology: move parse_acpi_topology() to common code

 arch/arm64/kernel/topology.c  | 87 +---------------------------------
 drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 90 insertions(+), 87 deletions(-)

-- 
2.39.5


