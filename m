Return-Path: <linux-kernel+bounces-662167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A3AC367C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 21:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BA13A7414
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97EC263F40;
	Sun, 25 May 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0V+YS5Z"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AAE1F582B
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201177; cv=none; b=X/PbDJsZ7OTQ91fgBmjM86MVN//DWCn8XlAq9/nohAqZMKJcSJpJn25BgrlPZU6JvaIERI48nVBCFU7/qF3C6YiBL66pxtUgf8DWj2A0o6HmucRvsT5djUTHZHGvjtVd32tMmmM592vGcP8ShN+kLznyx6c3GEpgnUYBbXcRBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201177; c=relaxed/simple;
	bh=o+zBjGEsV7Nh+L1RgHv+ue70NZrWkIlXCtf5K78wx4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SH4jhy53EAYkDPVVyWH8E7jmMG7zN/nh8ixddLiBbtPvFoDD9dBPj0hEpyx27taG/m9cxJcAJvZPtbim3iD2zkKP/6woPnCkID01vVyPEoFKgxmG7uZfLXKpz1dilsRh+P7YAnlhJrWOgZRbbrV8jXRq/4wFoHvakB0jtBLcN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0V+YS5Z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad57357567eso20406166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748201172; x=1748805972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRUlUb2Nyou4yT6I2joJv08pZwPgcDoL02K0xyB1KO0=;
        b=T0V+YS5ZKBAQZhEFr/dzPJNg/tNvdWV65ch7W9l4UDi8Xb3dNo209SyDe1Wv3R41f9
         n4nl1LY/elurXxwQctaZD4JvVXPwnRutZs/b22XbW5RzL/FVsmA5MvvYmP82gcEGR9oe
         SFRW4E34MDt185tdUgVlAXq/mXln5mnuXopv4EjfczK3ikdfoVGDFrSrf9tfhMHH4BDH
         WE9eQUDoeS550nu+aLaWu+Hsswto2N5ozosVoukGAInl+UsHROao6ZtpnwhpqI2RVbdA
         EPbKaJR/ZgrlkpDXPG8O8NdYSIXAs7GgRfY07Zg4ECcUOI6u1orY9EFwGDqOQ/tv5mdj
         s/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201172; x=1748805972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRUlUb2Nyou4yT6I2joJv08pZwPgcDoL02K0xyB1KO0=;
        b=PfDT+DrOb/Sd67XPPc1dICc15nBmvrSY8DzJVM8l0JlDmeEPfastnhG2Dvb+hpc1dR
         jfYfb0fRAlcWPHwYE34Iy4eNxiZC9UH446RsyDEJP7S6siQXAnMDQBTy7BxNVrmwm73X
         TaeSwu/Tgv0STvGQ1q0n3ZGneXKIFw5xKDR1+yEaqY8rgVTx3TKWU/wxM5tzGhayOk78
         NDiX1NhtgJOmSkX09A3wkVH3x6Agwka8DC3tfEDJgEqwoS5eASLZp3fwsTnzbIujovnV
         Up0ePf1qXE8xwvhmg+GnyUYFOb57YNyi5twRXUPHp8g4griCIBgaQ2XLO06btIokEPcL
         mPDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUwdU+s29oATRMGxYz5xoM1B0OIATfSwIyr49T51i6RbcRQhGbIYSnLJw022QQhU7MQuhRGOUputXA7Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxbWkomrhIKTKSKpaHPaNsaMQ3mjOFQscRwMeE+Weh+P9jPy43
	AkUeA3ZaHFkJtbmxfizIygWFcPR6/QMm75zKyqvoQ60cTblPIFWpWD/5O2fVVwUfdVQ=
X-Gm-Gg: ASbGncsVCTOCniPvLmy8cfrYSYg/0UYuktfGLb6bDUq5KGXkLZy34G5GLQNaK846rQY
	bwr9pSCqIj3AuU1NlyO7jhLD/kkMnh/xkkJAjrf45EQUBEjaVBhi4VGU6Q5pc+WvhijYJBArXJm
	yL55mTv/DAwnt8kBaWngW1sC6XIA87X0O1lgQpnkcMeAwoDp8o4HR+hoBv+xHiegs9CA7Y0TZmN
	xNabzlv/KVPyPoLlzBGCQrIRwr5SOOr7X1E0recrbZ89P0aUTpqRpNzndqVg7MbTALJtLGbRMAv
	buCVsjaHGBbEsqqlLB7Pz+NfRNzvU0YJN2zOcyNE5puHnvQF4AEIFVTDY3UL24/UscYB2PU=
X-Google-Smtp-Source: AGHT+IFfVGR4L1d0PIoviI/b+XKZl0sNPX164Vzih1wiSBouIe+9mrXc8wqt/Sq/Vx6fXa6iQWj4Eg==
X-Received: by 2002:a17:907:2ceb:b0:ad5:1ba6:2177 with SMTP id a640c23a62f3a-ad85b07045emr167943066b.1.1748201172238;
        Sun, 25 May 2025 12:26:12 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047738sm1578899866b.19.2025.05.25.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:26:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 May 2025 21:26:01 +0200
Subject: [PATCH 1/5] dmaengine: dw-edma: Drop unused dchan2dev() and
 chan2dev()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-dma-fixes-v1-1-89d06dac9bcb@linaro.org>
References: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
In-Reply-To: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=o+zBjGEsV7Nh+L1RgHv+ue70NZrWkIlXCtf5K78wx4U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoM27NXGulQywd4dJ4611aeRv85F9RHzesFtso/
 62/9leqmbyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDNuzQAKCRDBN2bmhouD
 10ncD/93/gwptNOF8A4DYHiNDQDKbYhjto0iBfiweR/TZ6d3Q/pLlF0Hbu66qmHNU5pfJegAgBn
 cFN2/YrsB18l6BZcsei98IKE4uBfSlRRaaYPoBjxBjRnEmKax0Q7F4/Cd4odJsW1uCVAbZyEfBh
 qthWjO5vfh8KhTKHLzPNLf6CmP3NKqEA6qrSKATF2cv/Bbfr73TjJtiy41isPszfgreQ5KBaTvW
 iA6mMjXiy1kzU6FzTzqjaSJkSmnSwkwtqKlZscyFJRQAAY6GKpJlUBjR6Ya9FQCguqctjUsPDEw
 l2bcjaNVJJKbEfhqqOcECBIqkifPB2+45ySPmITfzbEoNcr7FPFVSqGyulYoeAkSfOHGQecZP71
 zzC8z+mP2dCxJ7ADr/xaCBWv+LZNxvo4Ncr+bfDi0OHEr+Yw56h9htWIx+e7fbErev/O49z2Lm5
 rzpmIkvF6THIWr5yDcHiXI7SxXo6mnjE7NQFlLYd6dM1wYXD70GThVa0P5qB42wa0q5BbKDantv
 RWdO3ROT4dgc3mg/wUl4Q3zLAt6TaSKCDf3BMqHNBvlljUmKk8JjpDz+ph9T0zNfzImePycLUvb
 eHgN3AkKni0nASXsQ0Be5Zg1NaN+toueZmEDbYQzHt+KeLRHMzibDL1ObgMAUdty061ETITM5AM
 GGy1XYugSkYkNpg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static functions dchan2dev() and chan2dev() are not used, W=1 build:

  dw-edma-core.c:27:16: error: unused function 'dchan2dev' [-Werror,-Wunused-function]
  dw-edma-core.c:33:16: error: unused function 'chan2dev' [-Werror,-Wunused-function]

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2b88cc99e5d2d7c1ea4489d4a8f561ee5f0785d..b43255f914f3395f5d0be438151d9dd0d52764ff 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -23,18 +23,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-static inline
-struct device *dchan2dev(struct dma_chan *dchan)
-{
-	return &dchan->dev->device;
-}
-
-static inline
-struct device *chan2dev(struct dw_edma_chan *chan)
-{
-	return &chan->vc.chan.dev->device;
-}
-
 static inline
 struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
 {

-- 
2.45.2


