Return-Path: <linux-kernel+bounces-867722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18465C035D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D493B43E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CF2C11ED;
	Thu, 23 Oct 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6ejnNLy"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881E2BFC60
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250920; cv=none; b=hm33coMG5ie+JOw1cmgZw1M7ehB01Qld4jNPv+MeCNGwJIqx4ifDf7WjXGPCCQ3/spjD2fW08dc6dzduDG2PGDdJGP6D3LDztmqJfmcOqA6c8baq3gXtBCSJdTzU2UjaVhQ1z6dxwMc3hasQMRWSRur4reRwmn1IxSKfEkzKHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250920; c=relaxed/simple;
	bh=0deRAiZNqo43DCs6cJ6stmvrL1lZv3Xvisgmp/a5y6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfJm6KTIleseiYz6EGHS1b7MEbmPvwRyKSfFcvkPwdHgxR9qiPHNq17ea+vV4NlH/ktN14ocZbNC+yIthd6PhnULzhhpwFSEXBOaIxNQMLR/kTbVaYc2/cEDJRXS28FF3Iq5wRgQNxtq6AyN+NllXVoJA4nsakv6HP79vKX3M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6ejnNLy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-586883eb9fbso1479404e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250917; x=1761855717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWWlF7a8NkxPR0qV542zU2WOXGZPptylUFyt7ljt7lE=;
        b=c6ejnNLytxDMJiXP4D7nUfIhk+lNb2Gt38lWpS/EqMqI+ZWSZh/E8CL+mtNAFIvFLb
         wCzjMOKIQTE3x5G++tmxGkLyBmDqxdAuya/VYSUROUvjra8Fi7b87xE8wwpkrGZrgZOh
         fN5PFu76yvjO6L1mXUX0RiyR3KOG4WbFq6ABYllprgCmR5Da0xfmMt3kfyQE5XHjPQxj
         7S+aa9etbofwDZcA5dudqhYGiKN0NfSpjz6DaF71W8QtdCbfuwAeiiqP6+0UcfSR9Sfb
         CfgzoGJMSAY4vPQMUAly6vaBBoC5NfUbe828SQh0t2ikrZ9WzzW7F/hAht0KekQezpYK
         QJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250917; x=1761855717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWWlF7a8NkxPR0qV542zU2WOXGZPptylUFyt7ljt7lE=;
        b=M4LeAyh8/ByrtDzhRdjAmRvbmVlNExStfa7Anvv+zmvQqkvzf+NdZYTVu+HvYQNI+l
         zxSKmcJd/1Rx16wSRFlW5IVrqKldCVG6OV690enK5UfIiTb2CWZvQmQk7+A3xpY2aqNp
         PCFQkOk0ZJQKZ0IVIgnChDv/VRBR5pKhaLj9/K3xHUVCzsbTi7+OZTc23EQ/kvD0d12d
         Ow80AsbgxisVwmCVEt2sxobaqCI64Z2JiIxQPuCt1ooqdXRPuUfovnzVeyUu5/EWgOqB
         +bHTOocLq4IRJWUXL/kCrc1Lx5AzS+fzmpMqJGeggL/ywuUbbJna5KK1LKFuxAB2hqb7
         TExw==
X-Forwarded-Encrypted: i=1; AJvYcCXIpF5BtpoXJZOM8L4dU0ra9n7yMjKBNXt+2CXHV1/mmc2ZSt0ZVbJX53cWDUoXw2Y2lLmPtuYKi4VJZA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQRMQg7ic5rll/r36KAFI/WEmXLKnG3p7XvMpjqMkf57oFMNH
	ZdyekqWbjc+QaXTK2lfmBkNjzOmTH07GPV/ysRuAZmj9+4k4fkOuh30lTCO817Wu
X-Gm-Gg: ASbGncs+Kr3A32E/1XUl+dgr34OTcqoYr/nC+vc6d1HLGQtt86kLMq0AyIauscuZcsI
	QRyAnwvx4in+Ue6Bo31P5dNr3zvy2qjabMXw0053j0zBpxfTrrMVGleo+Rc1NEpvMyniPdyuON3
	T0y9z89cc6dprPuqWEpRMfyBLdEl2dodLk0cY35MKRVyVarMBRulWg6TBD6gpdv3mA15Dm29RvQ
	NzegLYEqyZ3nBS8RX+OTJ/NSQBwHCAhSgaqW1P4EFs6I05E4Ho0qd293LKb9Mr+GnHVrmCdcave
	g0lIqNdYEHju5H0h2g+AgYogoMqebRwKB99OXmU7VvLxKXYVYgqWJu8TBImoOYZeJIfhFdaIsOz
	zYlyzsJWr8Uo/KG+nBvcjRRPyKil22NguLVV/euS26In2dfqz2x54tr1SFPURNpZEggfdLJSzGn
	ybz57K/yLfFU3vVe23Qudz83pRO1UDDygVWIdjwbU=
X-Google-Smtp-Source: AGHT+IFOgC/A3kynZGTalg0DDaZm7NuA87OjJNy37bVaLvGsbYRVnJB1HXVotgPj69VJBT/wAeQz/A==
X-Received: by 2002:a05:6512:4028:b0:592:fa1b:b96a with SMTP id 2adb3069b0e04-592fa1bbc75mr464709e87.33.1761250917337;
        Thu, 23 Oct 2025 13:21:57 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:57 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: p.zabel@pengutronix.de,
	dan.carpenter@linaro.org,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 3/3] dmaengine: dw-axi-dmac: fix inconsistent indentation in pause/resume functions
Date: Thu, 23 Oct 2025 23:21:33 +0300
Message-ID: <20251023202134.1291034-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
References: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix smatch warnings about inconsistent indentation in dma_chan_pause()
and axi_chan_resume() functions.

The issue was with misaligned closing braces and incorrect indentation
of axi_dma_iowrite64() calls following if-else blocks.

The changes address code style violations by correcting misaligned
indentation in conditional blocks. Specifically, the closing braces
in if-else statements were improperly aligned, and subsequent calls
to axi_dma_iowrite64() had incorrect indentation levels.

These fixes ensure consistent code formatting according to kernel coding
standards while preserving the original functionality and improving
overall code readability.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1496c52f47a6..7b07bf5ac72b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1234,7 +1234,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
 			}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
@@ -1281,7 +1281,7 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-- 
2.43.0


