Return-Path: <linux-kernel+bounces-829714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE13EB97B20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864642E5CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0312DE70D;
	Tue, 23 Sep 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="JRsbc8Lz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0DC2E0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665994; cv=none; b=o32fNaCMXZFIiQzgHCdX2atorzgqLXGj8/xj/NbVSr9zvWV9dNpKeEjcw+BvE3AwP2H5NQNNFj/rORik84yqPLuwbCxAGD8pnYp+ajHEzIlWwqgm0rDvyZm+Pi+EeJO42sw+Cp4KG4/XzviKuyoNDbDryfiVspkS/DtyPjy2Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665994; c=relaxed/simple;
	bh=kuspQguKDMN2QP07Ofn/e8FxPXEd28GZFNAFhZqNgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2hG74sUAb8H5SLRmKKR3juIrJOKdVs+vsT1KCN75QdTBbc0EYIdsjtgWhqXkR/Kzl0Ic7udxOQSSnXXhWXp+r+6ue8Puv5gi+CdT1VIxc2i2awuYpVxSI88cCeeYT81WzOZRKhKBDYj9ZMu8mBOL9FQswDWoQTAWZ6coJ9cu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=JRsbc8Lz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07c28f390eso1114448366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1758665989; x=1759270789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZoDAc2wyhln1U3oJuCYDkDreDeByhBAvuQoDZOwjao=;
        b=JRsbc8LzoWJwCsKiJq4Aq69W/JIuo33PBqrfTpNfx+32JmAtKbPlVWMWe6D4teO6kn
         pBHwwKy3HtAV/okeLhnLL9h6au0bllR2l+/KYhtOq60kyZ7If7zWhTDfyvdE9tFv6n3s
         SjB0SuhZXL+JWL5svwkTl6s1ObPklz6g4n1ADBG3BUFWaZyT0wwxYA52xTYBWBxNnY8C
         cIzAw+6oIIClTziHnqDwkivpdezua40Q0ZPk4YY9bGT44vRRN65H16HQZlnj2l/Q/9kK
         jia88MzZgdA+waCml5wolfcL5pWZ6JmYkBKZQsWSJSke6gV0tcqRLsLjWbCGdb+ZFnY4
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665989; x=1759270789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZoDAc2wyhln1U3oJuCYDkDreDeByhBAvuQoDZOwjao=;
        b=lYiiBeGxkid2cOEqLCy8HkWDWQPrthQvTJp6UCX7mdY1BTlsotjotfnRrfE4nEw2KP
         EiZy/+mnvMTxHfp2Sup1yfeeVDhCNngkz4QLCmMt0twxXjhcGuMUtErNIpl+TEYZP6AO
         8G3fFoFlf8dCBiOa4rFSDg7LN5du59fmqf4lNcezKfGdLL9OTv9l/DrkJNABPJ2NpQJS
         p1ATYiKx1LrC9kgFd2wxhXFyc7bmA/HgVFDc/CeBH0P8AlMxieW7LHEzIZWWqZSVcO1r
         HMV4lg52N5ZQUCBB2c3l7cja2CtZBjMPLHlR5aICC23BMQtr3hoUaVLOGgnxlMf6MtZW
         fWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmX0Qx/wthNRVjqDjdJhmtysJv1TPSGMBwA2QL0b/Xb7j4WcyCwyaY69SNIGNGzgwO+cKOlctvHNkNqYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrW+P5u6ulmtVVOhDFmPoj4BGj3cNFvyWIwrsaCJNMbRndeZC
	k+k3kSAyervNPRDydM8lZuyQ0+X9dxi2Kk2sm4wm0jz2iOux4TQnWjxDMTTDi3FDwzk=
X-Gm-Gg: ASbGncvWz8hXGSsfsn1oXPN2c10FofikqFk+ClDBYe5S3FVWdgZj6W70SMdRBZFzVkr
	RrJw2cGbfeRA9O+1tRs/98XqAeSNxStLPbCk0im0t9Py1Wq1VMofLp6etVwNOPH0DcECsgHO5hj
	kdIGcbRTG21VWj1pcjjSZWFWPjal1zIYJcWVTwQOnAmTt4/hxH6ugiVdYLJnrn0KgnywtB1+EEz
	fu7wjD+akoTCsvH/sKy21son3XJogqoIlR2piwPTqVjg2LrTdBvXqG+G9bt7nQ8LkEC3IefIDg4
	Rsyz1+grXdTWarAN9//WRJvy2VbOLvCdVShXavzzu02az8dg7Ygba3BtyTj4zueWp0YnTxB3ZZv
	JKLI14ggEtYhtf3cNHyKP1JCTLP1DkZGfowGbL+aEh+7tlartasGnJ5P3
X-Google-Smtp-Source: AGHT+IEzCEwbixWOf1mAG9edDAoF9t3pu71R6SaOM3SQN+LM7ZMPhOBWU5qdpOcyem+S8HdoFV3sDA==
X-Received: by 2002:a17:907:9627:b0:b08:85d0:3d8b with SMTP id a640c23a62f3a-b3026e7495dmr394989166b.21.1758665989378;
        Tue, 23 Sep 2025 15:19:49 -0700 (PDT)
Received: from localhost.localdomain ([178.224.220.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2c56c2389fsm581187066b.79.2025.09.23.15.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 15:19:49 -0700 (PDT)
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Date: Wed, 24 Sep 2025 00:17:33 +0200
Message-ID: <20250923221756.26770-1-marnix.rijnart@iwell.eu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
introduced a regression making it impossible to unset
SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
unsupported. Because these devices need RTS to be low on TX (fecf27a)
they are effectively broken.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
similar to commit 068d35a.

Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..a9da222bd174 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
 }
 
 static const struct serial_rs485 pci_fintek_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
 
-- 
2.51.0


