Return-Path: <linux-kernel+bounces-857850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F258FBE811C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8489A1AA1E02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850E311C05;
	Fri, 17 Oct 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gavs/aOc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CD30F556
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697002; cv=none; b=jcjdt6HvH/TnnGzZN7AFQUr4RkyRqAZe9TMODdQbvZFm2byYdNA1WyL5m4hoUSDZMgi3HRRuwdftO6pK/6JbNo+7ID2okgKzbBjQaPFxeQqdeWKw9NOByILCbnqa2PX5y6uM//kxAs50sRPi8wfodC9258wfWblYIrrTLNJQAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697002; c=relaxed/simple;
	bh=bFzBxCYSLJLC2MX2D/+1wvpsD2+zTvyLj1zRe/3pI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsPpsYQNRoiQv7iRhE5lwVTtdBxRKeCEvsALK9ygTdZ/TepRRYZ6UZXKtb8M2ek3MR2qblpKMsAfG8WPJAFgHAlWfT2W7tbf96ZeuKF0BMKN8FCIZnX4NkEQlVq5BfTcv1/8nyJfh+FJQoXt/dm6GS6XVLoMcX6KvcowyYhQYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gavs/aOc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3da3b34950so280415966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760696998; x=1761301798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqvm+FvUGGdtRylrUSb6iKBuvJCIycpT57JXF4tXRWc=;
        b=gavs/aOcok0WY5orXnHMHR+cleSjgXPykIdUWrMHmBX1pTfwgJ6ceTB1F73CI6u10P
         RzjE/eGGWnNUo/owF2ejwG5KUeX3vsSIOQ6+2IfYCwTprt5ocLf82IH2wlnuxQOBguSQ
         DxUrX7WvjHtdb9D3IT0AsuhkF0gdxrRQEDVp2qQ7DXUHdQGd5MQvKuJEg2fZOrCITRFF
         hnkZpXrjxAX3G2XlENfzSAzdE6toj/XODldcACb4cuicsQMJbnBekcammz7G57critoj
         IbhV3kRAbJMS47pHHp31giZYmYoNhE4p1cZHJN9HsJ2KyH2vkmMn6cHYKayvgyijlT6g
         cfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696998; x=1761301798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cqvm+FvUGGdtRylrUSb6iKBuvJCIycpT57JXF4tXRWc=;
        b=YOHjUzU5b8UQ8Qm8UhFMAJ2wvBpQVfA2ruBFNL3K3it4IOr1KGNsUb1xGD4n9uXrwS
         +6TPsrvulNq7zdpgJhk7wbIr1fdZhTIM7vY/o6FE05dWr/qucZUFZ1uGA+TbkDBUlxs8
         MC0qgpcMOBpMhRH1cBSCYkesVbk1vZ2k00ZLxPs9cRD315yHJ50cBcAp4KnZcLjY5+jr
         +RxD30BW5gfvOG0iPY8wqEtD0VzqeivdiEv4/HN9C/vTyXvavSBD0fziWiFK2USZr9ey
         BJqV/GPuArcpfPmJKIhpzG/GH9WXHcg2pwze+kCGpJrlGM9h02tL/6s9/VLJ5PpGckn7
         t6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHtF1Z20wyavXRS/gn9xqo8Jf++XNEazzm1CsjqjeYpYxOr+5PWey0jt2ZJbEH+qns2cC3D89TxDYyc+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyIphxBWw18SOrHuYXjxfcLO13zeSPn58Er8ZajBME3bun8Lh
	s7hIlwmhti9OaJmNh3wo3SfTPbtInXvzdYKq/1Tz62w39Qe2XYK5X25s
X-Gm-Gg: ASbGncvTBOr66rY2xfIiurwaG/y83iH7z4nItL6sdxgeNXP0LMHxkDZkCr4nRPnVUvO
	LKu/hMJAr8O3b0+MOluo6r8cuTwi27IbwQi4RJq5zBGr2bQ+jMGV25JT04FsZLPR4e8e3QrSlZ2
	NXPBbwq4iY7/dhM1vokNzfXSliH0UXm5jomriWFkpmrzgpwThqNkc8ziXCV1LEqX9OffyDlSZoY
	1IsV38Bx5a9CjMkc3BrWKuNC+6vD1S6vy2w7ErADAPfH4MicLkC8RdnF3JjsEqqoag8psPrN7kX
	u3foehuMOwU/hA5JmmQ+LWBfoMeJG7vgkelyY6/vdxRHpLct9ZB+Bd+ZHZ1MrVis0fk8iqImdBZ
	STqIAfbwjGoBGVFVbrslg4BB+lyBHXg+J5DPSzffZ/Y4389TMJ7sffWgEDTWYQ74zyWRJa2bpak
	O5+zQIMpEf9gXYaDTD
X-Google-Smtp-Source: AGHT+IHhRfymyE7H7W9XmHZdTf7jW9emSkbTcMJSr3rPCnTSzRknlKYAgBM44E0dPLSJ7+01KB9GgQ==
X-Received: by 2002:a17:907:94c3:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b6472b60410mr328553266b.4.1760696998502;
        Fri, 17 Oct 2025 03:29:58 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm780513166b.43.2025.10.17.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:29:58 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy.Paltsev@synopsys.com,
	Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Fri, 17 Oct 2025 13:29:47 +0300
Message-ID: <20251017102950.206443-1-a.shimko.dev@gmail.com>
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
    * Add error handling for reset_control_deassert() functions
    * Add error log for reset_control_assert() function in suspend

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 81 ++++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.43.0


