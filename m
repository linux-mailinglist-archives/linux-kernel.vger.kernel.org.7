Return-Path: <linux-kernel+bounces-841159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55470BB65E7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD1C4E9FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC52D0C8A;
	Fri,  3 Oct 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htj7KhcW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2D2C15AA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483818; cv=none; b=dlIiSgNew6NU5YqZBJPJvPBvUorV3KlUtQTLIMVLORXOi53YGv704OW6kp6QGDmyhsU9vz9Z7jRi6gpF0k1F4SnCpc+6A4AUmVhha72Rsdps81smDxUEfDfcVxFvTCqxpG0OiMgWceHaYGl+ZtQqKYlmL5U0HT4ke16Kkrd0IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483818; c=relaxed/simple;
	bh=XI/qi6Okuo9kJdiQntzZ1a9/oDWTMJdYxZI4E72cdcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KOXD+BCghLfClwhOkb49AhZROE6n0jnCIYZlm1mgc5qjHbtNNz+Q2bVHXsdkJ+SqcvOlgXI7rrDPXDQ3e9Rt9OtBsF8ai64h0vee6BeOIKGmAAg4fuoSqFeITCcUqrkKlehZlwokFZ1ztxI6mD2X0sJ9jp9UIs0FdREaaB8cPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htj7KhcW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1333772f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483815; x=1760088615; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhgLDi6NThV7CDsUpk/weXQLRMerlf2Ax6eN1eI2x/g=;
        b=htj7KhcWtAJ6kzxA8KHsMV5wCKGtv4xfMrGsiKmaf0TAW4pHDlrrTcG5JSacJYA2FE
         +Xjrxg5A/SxwnbyzJxddxaEQC3q8/0A1ZpN758o74QqzH3vR0vLv0hJLjbVujp2jrIAN
         eaou4vHCMY3fApdX3L556bg0W3CUubGc3tVFBCSO05ongOg/gMidRMflrMkIBGenTgU+
         +d2StVoMoiwdP3b1jWuE6naY7SH8HA1U6zdedbcxp7xFUWHcnCtmbXYXalIX1wCg5JGF
         D1tTtC+n6cCWnk0lDAPaPoe/HZhbd+K47dVLW0peIdtAYt/9S2YUHWFjaLGqWCgTRpJS
         wboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483815; x=1760088615;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhgLDi6NThV7CDsUpk/weXQLRMerlf2Ax6eN1eI2x/g=;
        b=OiHh1dnN3r8DPtzO3CxDKZb2Ze4laNA6vs+oD5WuB+Rku29yZKX3fOY+V+jIwlpzB1
         kjOldRzMnl7AjoHKrL6uMIKJgsYGVwn/Aacejy/HF45gal57ZFXQOvipTgvhu5aCeseF
         1EBuRJWjCVfSLv7FTRBNUqSKNeWu6fiHA+l3YW+zyY+M1d8zageN+MoOdok059HxVPqM
         f21xOoUjyJJeSYsSoU+Vq0R6SoZVmWPBbTIrCRyM2TD8iIhJ7oMwR+gsvgtYbv2cN0aQ
         K+hpIzQvPCxtjiSCKr9Rr3DijRo14DlPU7mTNheEWae7R/b5yJRl2tWC7008jWcNoTCO
         hkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh6RvT5SzgdEwhM2iEdrn4WxFpMHddAhMa14sEE1nXOg0DkFxygNZRvDD9yndP96SgFY/98AyGNSjZQfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWV+psLxHpKEwxikuTTq0bnkL0qs0e0D99Q2ADtdjJQRMMMKo
	Pspy1EWSVV5g6j+lE6eKxBHcELzuRq7/EAlQdWmqmum8LLNWAKhLUodRM+QjFDDl1BM=
X-Gm-Gg: ASbGnctzeR8o20aFD4cK9XIwuJtH3Xf+vesKrc0BwmpWHnVVuMP+o95ZBKyNwge5wX6
	+pYiBnoyaJV4hn6VQiK2tMH9umwwcHqNq/ecoHImTXtid9Mipr4f+6lCHz+3YI0kGoDCgLhuo8U
	lYp2xLVd7eNJHsrOZUn9f61JCnqroFIox9jI3QDwVHy4Ho8/TUc82Pe2KMOztFG+z9flsxYKggH
	Vgvw9guV75R4TXOVivZYCjsPSX/ff1PpueMC7TMwsJySS31RDvK21C1qkdGQsoWye/S8lGk12x1
	FnV9xKoLGmR2rfjBtgkkBl0Taa9EjexFRrjJ10W9YzlvuWr7+Si0s5rSqBQyfRnDEdarceLV7Xp
	nkkrcv9/B1tOMLgGTubFQmb3J4oj+rYwNQo2ZQ6BIj6LyTNxiwJFh1p9Y
X-Google-Smtp-Source: AGHT+IHx8gWCZHt+AQN+RQlxboRGMUkamgU3aSxPItSzubRdggN8p2qx6XItQb7Bkrq5pYJJkn1S/w==
X-Received: by 2002:a05:6000:2283:b0:40f:288e:996f with SMTP id ffacd0b85a97d-425671c2f8fmr1476726f8f.63.1759483814628;
        Fri, 03 Oct 2025 02:30:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f01absm7082890f8f.44.2025.10.03.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:30:14 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:30:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] mtd: nand: realtek-ecc: Fix a IS_ERR() vs NULL bug in
 probe
Message-ID: <aN-XoqpP2Jz75pjj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dma_alloc_noncoherent() function doesn't return error pointers, it
returns NULL on error.  Fix the error checking to match.

Fixes: 3148d0e5b1c5 ("mtd: nand: realtek-ecc: Add Realtek external ECC engine support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mtd/nand/ecc-realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ecc-realtek.c b/drivers/mtd/nand/ecc-realtek.c
index 7d718934c909..7c275f1eb4a7 100644
--- a/drivers/mtd/nand/ecc-realtek.c
+++ b/drivers/mtd/nand/ecc-realtek.c
@@ -418,8 +418,8 @@ static int rtl_ecc_probe(struct platform_device *pdev)
 
 	rtlc->buf = dma_alloc_noncoherent(dev, RTL_ECC_DMA_SIZE, &rtlc->buf_dma,
 					  DMA_BIDIRECTIONAL, GFP_KERNEL);
-	if (IS_ERR(rtlc->buf))
-		return PTR_ERR(rtlc->buf);
+	if (!rtlc->buf)
+		return -ENOMEM;
 
 	rtlc->dev = dev;
 	rtlc->engine.dev = dev;
-- 
2.51.0


