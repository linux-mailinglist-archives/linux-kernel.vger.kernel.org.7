Return-Path: <linux-kernel+bounces-856494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC24BE4522
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C03BF366
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A934DCC5;
	Thu, 16 Oct 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMgVxrMf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1A1C84B2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629595; cv=none; b=tri0DaTDdoaJF5SSWBoUqEK6EswDwg0/tSwkAbLo2Up5QfZoR497oMHSkrlSJAmo0qbvps62P2+dKpxxwMEjviyNyjWtMeiarUON5BwK2zELah3r6RhUctNUewgjWqj6wNIcNhUAP12fVNvB4UcouBx6KarCw799zK8IM/jrY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629595; c=relaxed/simple;
	bh=hKyfEzjFgM6gVDw5rNLNPi1mlTz27NLVHsHOOnG1Mj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8n623c/gSPMq6R1enKbpf0fKWH2DhzeXiHuEqWN/n0eqZsVIDgV9K0LE/J6jUm73F22Q1pFU2Rl4PIocaO62xbttCybOpnYUbdMRKfiD4fn2iIFUys4fuHFl0FGz+5qdzLkETA3Z4TrZ66cVuzn6nD02Jc+Tl2+7psBBwVhqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMgVxrMf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63994113841so1578128a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629591; x=1761234391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TWktSmOYD0YxtezmHYMgLXWGztB80rGJtdvycR/nII=;
        b=UMgVxrMfB+ucn8Z/udl7jq1+iEC4aSmdiXB+zvWxuud1qu/jDFCOcMf4ZaDOIob7Ui
         hFHhYXIqJozBPmZpcfBSohakh9uw1K96MWLjww8rq19+tq8sGMTPx1CkecRkkToR9ifu
         MEI6szIXpbygv+rY8ebVuvpUnSmUquhleYZe98uInV4icdgIePXmVWILi82jPrUXQBQ/
         ilws+kvY6nKi6BJV9DCVANMQ61vZYqLMO57CPjC4HItZCAEopSQa0p7BOPfO0pcPwiPj
         KzWmYwQlN9vvzpk4WtVZ7YUOeNP4ClI25p/ySSAFDXaUCB+pfldt6N/BX3tBCHKswq6+
         lwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629591; x=1761234391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TWktSmOYD0YxtezmHYMgLXWGztB80rGJtdvycR/nII=;
        b=PwClaJQPDH5o3je4tiRZ6sx2qJrJsK1HifwmoUBD2vjjWnTW7qSnxx22Df7/YTfpLK
         hZObsY+UK1/JiB+qFrs1se10fffqHROe96pxEUNCetQ62FsNrkMM6wSqs5RBd2ZhQMt0
         ek1sBD0WosCyXGDt9+jVCS9yQ9Ccm2FvKwzFlcOlxc5ii9KiNWwS9T3DU2I4RzIFrBM9
         pEMP4mMCD7eRv+U4G1aYGrif0Dg/OK3wOozyvYs5ZhfX+8qWwcZEJrtL5haw9SnulLfY
         YZIw448cqcgfk4u6MK29YSMo8Cs5gcsH3KWiPjkVX1RLkE//Zba5rVQjAtncLpz66bIG
         piNg==
X-Forwarded-Encrypted: i=1; AJvYcCXxb4TTDFUVSaZPIHseYQDqYgjWkn/cZFE+vfpDNojHH+0IJvgES88pXTacJD/jhlgypOjuOU78g7zGpHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3oqBbRd7pGXTmy/pawrV2XgyhWFIa0YmsB+oy/kMJllsbokZ
	/x1atJKG9KwNIkKXF2Fr9vFdVTotz7mIU8ryCnlRMQ1dmEQmbTjsBuL3
X-Gm-Gg: ASbGncvh6A1mrn3tVwz1h6t1iZ1i+i9X2rnLdXo9ybC49wkn1tLnjhwh5WrjTqIBnt3
	FVcxf/5ShweXcxccOH1dwSVmMmvbJIWz9c6oGF5dpMymf/TOt20oZnd/XDlw7hclpf9+1C6dH77
	U0PNjUTBVdUtLVpccssa2fHDEs13grfxfKgLIBkZyoJ3QNENwAi0YKhVbWN53JZvSUYeIFhHRKJ
	+G0F0ve7YwDpRYLxOwq+7M1+N1QLh3NeD9SLxqP5NmgtY4Bg6liDYxj5+/aL8xhffphnnnHh0m+
	54Ijluu3RhVnb21t9RP4vGqe3i63MnYfkT6Jq24sRIZ8pZm147EyNTIiXtWw0d+NDiRSMzZmCeJ
	8/1+h1Ez1XErb/sz2+pJADg930xeFDH7ltxdrGre6zpIbyxIeQ4u0/bTDuETmHgXEc5yFRLG93o
	Ccgo3a8tfcU2axW3hVbeiMqw7zaUi5
X-Google-Smtp-Source: AGHT+IGnqHL2OMLoVxnVXh78lstigDZESWT9J4TLCoo4obMWx1jVNLwRg34WrApclt+fzUU3eDNMKw==
X-Received: by 2002:aa7:df90:0:b0:631:bb4e:111a with SMTP id 4fb4d7f45d1cf-63c1f6dbea3mr228409a12.34.1760629590473;
        Thu, 16 Oct 2025 08:46:30 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c12279a54sm1237989a12.11.2025.10.16.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:46:30 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy.Paltsev@synopsys.com,
	Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Thu, 16 Oct 2025 18:46:24 +0300
Message-ID: <20251016154627.175796-1-a.shimko.dev@gmail.com>
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
    * add reset_control_deassert() to dw_remove() to have access to registers in
    case if reset has been asserted via suspend

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 73 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.43.0


