Return-Path: <linux-kernel+bounces-867719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38342C035C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966FD4EB2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D2279346;
	Thu, 23 Oct 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgNeFsJ5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CC26D4E5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250907; cv=none; b=L01UIs3dlc7hf9gr9lSMBk22Jd3n0sqUKWZN29NKj/ZqWmDxsZcObf1N27t3hL1FFXMb4DTksboQfJddg896iwLXvSgYz5LwuAKlKZ2+3rlg6mSsOPXRGrdwmHL8HjOhJ8LBv9/1d+aWm7ePb0k6oSn9aC5rrgEl563cYfaQ+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250907; c=relaxed/simple;
	bh=jg9Nj/uwtLYP7rKhbQsQ7kSR+mSXhYHhP6Bl67TYfp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL6/EfVqprVwlhMID8Jc56F0aq8AabNKmccnSI4fN7N9PdT9VhcMsMtpQtFOYqcepfAIUgaQL7mfWgRzf4nlcQHOl6k00puhrpf4ORJKvLapUC+aaZOkr42wGfSIxCUztsQEuciq9neNYInPgsJ0xjl7z1MlFZJ67XClGZ/EpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgNeFsJ5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-591ebf841ddso1460366e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250904; x=1761855704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kL73NZxCKZV/Vxcl52xdrdbzC56KEpGIIaj0Zz2QuQ=;
        b=MgNeFsJ5mDS9hgqPEiHM8XZohT68JrGOR6rFST7m/O/hjr7MLmKNYBxk7shgAbK0y2
         Fi2/gATE3hJS+B1qphOCTk2LbCsO0Fqcs85WmMKUX02yxgvrhyAgu+eHRGgQkoQkdlr0
         bcnXKC/+74+S8ITaAjtcCyR1d8Mx3xUaR/Bulyn7xPKDFCPwo+TsWpVH8Jb3L+K7lxou
         H0XYAjXlkneoUcex8pM1GGH75jwkvsKH9aSLSR/nCG8CWV3N4Xs8BKqqAIfZ6R52e8TD
         CpC3CDoyhtfxkDLoumoeVpChIMGJrqAWXjrGuiWv4jxSgQ17LfJPP/0aLsdQBC6LvOZT
         v+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250904; x=1761855704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kL73NZxCKZV/Vxcl52xdrdbzC56KEpGIIaj0Zz2QuQ=;
        b=DaQIHqF+fm5FOYN43JmY/ibU8P3OYHQYEW5dkR+VmszY3mIv1lu4H0GhhAEWuk3Q3H
         ROSbDJsQ/15p5xyIqfFGCSHck6Z0NdBMxPWLFnx776h5eK3Mov5WfnQfwx0n9oDrnEAP
         LbpxaqIX7Cs0WAvIpTp2Vnv6Qqp3/X1x+3LeTFTDfi/iivVi7DOvTd77DKH7B1PoJevq
         f8bMTKTfe+FVUaF8bmGHo1rUiRm4bSqQeBR6uuc84u3xadhOcRpXi2DXNU8OH8Fw6CAA
         Y/ppKMVoJTPldNBMWYzkkexx0udp6bQEHsH/vD+eccP1HWU5QoAgqvtBt1c4Llzbz8Fu
         qo8A==
X-Forwarded-Encrypted: i=1; AJvYcCU4y5rjM/dDhZuYduCvegB6rRHLqfi34cyo4TSrQsTc6aQg/ep5DP25qXkG2nipHGxHojRSqYNttt5daGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQjd1uOtpMDbFUtSNaWr8WUttoME6FS99IolfpLlg7PYClEN8
	V/QDt9UFBcI8XOn9d3rouBoiWj3T3nuZL4+LHLSdKa3ugZ0QANAAcZUg
X-Gm-Gg: ASbGncsxcYMpOylZrwZ/3xffXSUvubGXc78iwZKJAYKZbTOWIhHFjDPlBwf7kYsaA8H
	j9Djii2vn1DpPAXiKP2mjFIYML1DHa5vLVzUfym4mDp/wWrZTx1QvhOJOCeCvGL4l19kC+aNeBS
	1bXLhMH6B/IfkYpMP32ItIDqbt5fK3m33rF7Y2PjYhBZBYOF+EeD1ehANzAmodJVM6zHOtsDeoK
	YJ/yUSw4K/HAoZkEk4J6oHEK+F3BPLQVX4jV06SPq5qZ6iRP67Z4JhTuCQHG9PbD/z8aaZFXrL9
	dGpQwDBob5KYXXFfyWuImr4pWQ6Iz0cEV4WMPiDlZMUpYE/chPAmNVRKrd3tt37Ybk9dXCgJ+TM
	CLo9Kgin9HNWta0O7Xqk/OrM3DxrrPAmw2/ImYf0EQe1mSsV7jwwUdRDSA4lQnoeyDlol25nHG7
	oxu/bRgamgtZCCNqYRYFTwTgr4bP3HP65rRpwNEbY=
X-Google-Smtp-Source: AGHT+IFTmBTr6oLYnlbZQcvona8DC7BiSktyWlirSoHiBOhCLaOcy5aDyxlYtINFoyEba3yb5UlPpQ==
X-Received: by 2002:a05:6512:2246:b0:592:fae7:52da with SMTP id 2adb3069b0e04-592fae7531fmr311361e87.42.1761250903821;
        Thu, 23 Oct 2025 13:21:43 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:43 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	dan.carpenter@linaro.org,
	Eugeniy.Paltsev@synopsys.com,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 0/3] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Thu, 23 Oct 2025 23:21:30 +0300
Message-ID: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

This patch series improves the dw-axi-dmac driver in two areas:

Patch 1 simplifies the power management code by using modern kernel
macros and removing redundant wrapper functions, making the code more
maintainable and aligned with current kernel practices.

Patch 2 adds proper reset control support to ensure reliable
initialization and power management, handling resets during probe,
remove, and suspend/resume operations.

For debugging, I used dev_info from the suspend/resume functions.
Before pushing, I removed dev_info from the driver.

Suspend:
echo 0 > /sys/module/printk/parameters/console_suspend
echo mem > /sys/power/state
...
[  195.339311] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.350274] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.361223] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
...

Resume:
...
[  200.669945] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.680975] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.692108] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
...

Patch 3 resolves the following smatch warnings:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1237 dma_chan_pause() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1284 axi_chan_resume() warn: inconsistent indenting

To check the fix of the warnings:
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) C=2 \
    CHECK="../smatch/smatch -p=kernel" \
    drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.o

--
Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251012100002.2959213-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * https://lore.kernel.org/all/20251013150234.3200627-1-a.shimko.dev@gmail.com/T/#u
  v3:
    * https://lore.kernel.org/all/20251016154627.175796-1-a.shimko.dev@gmail.com/T/#t
  v4:
    * https://lore.kernel.org/all/20251017102950.206443-1-a.shimko.dev@gmail.com/T/#t
  v5:
    * Fix smatch warnings about inconsistent indentation in dma_chan_pause()
    and axi_chan_resume() functions.

Artem Shimko (3):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support
  dmaengine: dw-axi-dmac: fix inconsistent indentation in pause/resume
    functions

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 90 +++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 52 insertions(+), 39 deletions(-)

-- 
2.43.0


