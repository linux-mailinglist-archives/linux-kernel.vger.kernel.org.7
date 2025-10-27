Return-Path: <linux-kernel+bounces-871210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D178C0CA1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97644F1782
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505042E7165;
	Mon, 27 Oct 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz4VuvRN"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA42E6CA8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556871; cv=none; b=F57Gu5il1WiZPCkf8Zd0vXaFX9LWJgDmFlCIi5I8Wa4m237YxHI8NQPcr3pICWiDtv/t6x/2RA45w45rMIh/4QSJslR9EZabjitpFh9iwQ5OlEBAUOYSyoqLtOe3C+JmWFPvVuwwjCaKpp20DIXSe3GHoimPSemGIx/A/tnwsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556871; c=relaxed/simple;
	bh=T2FiuKY307QUDrwGy2QITvUy0qfdAG9Duzl2cYto9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okabpmBMDYjspvFG1Jjt2/UO+l0fydTcWyhY5q+DkLQydShXvW0R5mcZnoK1CcisHJGjwxTypwX9FGPKF8u5xvNDJXnc3ew9KmFQ5c4tvyebmRqV3SZRrHaBkT1Ku2VDr1ZxLNechIHSkM8eYk91STU9rjp9w3v5McUn3vURE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz4VuvRN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3538728b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761556870; x=1762161670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=gz4VuvRNEdsyV2CwQzjgnFa8e2EC1C+ncCogYY5YYBJfGvdT137LLLvEldbGt9Skdd
         piyvtiRZfVdUqmIqBH5fenhgFCzGbf8DFKT9X/Cp8/nig4/KvxBZ3doKipj7WIPxaer3
         HqFTrOLdImrd+il0+dAV2e/kj3J05gmGq8Kdnz2Zl3sisYBZ0zi7B/PnTy58EFRb36Q1
         BNoEe7EziK1UnKnYwVp0+9U/AOVTaJ4+bDgGMXr56I4rQXVSKQoGvDJcI8l8vhX9lMWO
         irnIotddwQ2cv5YYM08QuWCwX5poJxmi9J1ec66ioFsZkXi+FOCPkm2ios66KL1gPBvp
         n9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556870; x=1762161670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=HNYQiYW71+X4RgjRy3Xnn47U751wv0ow9HpVHHGoftIwLRDvp7UjUxRy2lS3Do639Y
         smwNF31PF19JsGGeaF7XgdYQxI0pOhcGmO6I2lvkvO4KAHb/Qt0bmgQHaRByDAFncaNo
         PkSQvUmSzHQQfCDPoRGgWIZBii0ytuiBbvFnTHXLxZxhwjb1Jilrvk5PnRim4jC6Pe7g
         rOYI0G1i9QyNs1M2NGbpChctBmmgQBdOixYi3nTqwE3/QXI5yPWKD1ZWVBApO9XGFEGN
         555/LmagrA46UzfN9ENCK2/4T1MlfgI64B78OSLqAmjgtMUDLcH+qKhQqF98TqvSSzcQ
         TXTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOMgAEhkAy8IetKU3sBc1UAFPhLbXqX8QJY3qLQLhBk4FoMgfCx9mNd0ekBq7WGcWucALNDEwQJQLhyjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfrsMr/8SYkIh5XMHPYXUWc2d5VOlVSt8Mo7gg0kMsGnMHdCP
	iK1hGsBn6E8tRHa4e45RFpCOcRtNGw2LpKiufWjWr7+8GBQ1SLKlPZ+Y
X-Gm-Gg: ASbGncuho53AoR1V5eS44Era/H3DCKdZlQIHbbROn2GZiGrlx7s95sls6+MZLG6Rc1i
	aA7wobqS0SpTOFADjKfEy9FsqOo6gTykp7BafIVIPAO0f2CehVTkBgGW7PxrkxEEa2IX3BnDiyx
	20spCj+5HlI6Al0AaJTYpuHilaOp+U2teKFCKvFFRb2Kxmi9plrF8KaAqr9wuwcn7ZXLiEZ4q5W
	chBrltwFfeVWQXpFlV9U9PX16LHRyBH8HzyRL2Gl8gajvH4LKf9VB/fhIyuxOrM2Ku+zfr1YqGo
	Csr8Qk+tMrt7GJRu0+wBZA0hR/dMi8rC5U3HDYljnIN+aMonqCJT0fRbpSJiuqz05GoF60VpZOC
	DAGl0QQNPIOW/Zw63AaIIV1NUjt/alYcN0BGfCVMik7PIeh0zQZOtw6ulel0YpxalM68e3rD5M5
	Gjn8N80CC/kJYF22yKIoabqZ+Tlbeq+Xd9
X-Google-Smtp-Source: AGHT+IEcpagKOyJV1fsrM6dM/HwYD5VenCjDTs/rQ5hoHhvZqYSFHENXuZ7ikBTfiwnPt270HOJ/6A==
X-Received: by 2002:a17:902:e552:b0:290:ac36:2ed8 with SMTP id d9443c01a7336-290c9ce63d6mr414278245ad.24.1761556869605;
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b712ce3a90bsm7017409a12.25.2025.10.27.02.21.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Miroslav Ondra <ondra@faster.cz>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
Date: Mon, 27 Oct 2025 17:20:50 +0800
Message-Id: <20251027092053.87937-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for returned DMA addresses using specialized dma_mapping_error()
helper which is generally recommended for this purpose by
Documentation/core-api/dma-api.rst:

  "In some circumstances dma_map_single(), ...
will fail to create a mapping. A driver can check for these errors
by testing the returned DMA address with dma_mapping_error()."

Found via static analysis and this is similar to commit fa0308134d26
("ALSA: memalloc: prefer dma_mapping_error() over explicit address checking")

Fixes: 58ac1b379979 ("ARM: PL011: Fix DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..7f17d288c807 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -628,7 +628,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dmatx->len = count;
 	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-	if (dmatx->dma == DMA_MAPPING_ERROR) {
+	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
-- 
2.39.5 (Apple Git-154)


