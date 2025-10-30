Return-Path: <linux-kernel+bounces-878861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B3C219CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8149B422F12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DB37575D;
	Thu, 30 Oct 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArECC7TG"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076036CDED
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847100; cv=none; b=rb5UmQq7Pl4QQJwR7c0CrTpVGgWi68iuBnnnK+MteRIXk7kyhpzYljeOQxzx/JB4Q6T5vSD9N+Mbmo3XPCnf7l6dBKv+B8g5FogLrXOvbTeJFT/8YElJq3WTlZz+ZRa9DIipeOfxW7MzfzvmwMYJikdCTFmtB0Hd3jEB+rbdsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847100; c=relaxed/simple;
	bh=CGCGb9V5eBipiJiyKGzWDh8EBRU+yWeR3nCYNAfd3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNcTyVfgrTGzS5noXtIDBIaoK5XhgLN51v7n/ij+bJAtJjX+5ftd3Sqd5TlcdgnQLfChzCtJKTcP8HXZ3wD0/cg5Skb2JrCjZ25Gz99vpz5bOVFp+1zjUyCuYOHjuvEcF/nBONGKB8jzKlROyM9UjuqXD78a6wLWGrkTEB0kLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArECC7TG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bcb25so811796f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847095; x=1762451895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=ArECC7TGGBErcGy2ngQS1TzpbESTXq2fI3lVCiD5EH0M9EB/iN+S9fqe1F0SDTvx+w
         JRDDibRt/I7TRNIG3jtHBBmgSMiBK1mC/xhSJhxy2LlVku908NFTbL0LYwp6wPTMe4NV
         xu4F9pLpC8XQmBG1yAtYQUow9hb12asJEJv7gWWpy+/pS5kwLPQACE2IsHeApihQDl5Q
         dB+JB7bA1zwxJr0j413pCoNUuAClLBR+TyDbYxitg1DPIFZ1IkrSLoQmCRWXgXmt+0wj
         k6o+3onn/EQvL4TBGCEo7mvV604KjI/OFQBx9H6nQ8N/VBKS/eKHUk3GCmRJD5DCEL3D
         hOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847095; x=1762451895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=GSa9vnaID4X1ESAtvc8vWYJwtiOd3XETzxN/i+9F54ngvm2uPlbPNxobD4BgOxcgj4
         Wj86zsgdFV9Xd8hmVm03wrYYEwNmrWcBup43ZO/0EfFbGgCCtzgvfFpZaLM3Nf5KB128
         GI7Ib+G7dZXoi9Vxsu8DPviDcbNwfz3t1bbS/tZkss0dckfBEQBtf4L8grGAu7ObtWfW
         UN18sHiH/kjBchN++xCdUe0v1K5kEp7uddIyBAyQaFC/sWLcw0agwTs5bFBWcgqX58vZ
         D2epUeU0GSl3ODzPRNbebo5BEmsQAP+HtwKeWsjMI2jYA4FgOOD0RIm6nn5yPzHyc/nU
         WkEw==
X-Forwarded-Encrypted: i=1; AJvYcCXGuDUbd/7HH6whiQLJPTYVVni8J57lTOy9Xm3ts9f5F/bez4a38m4YN/2sSBJyNKr5eAh2037eU7OgjoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWxBT0aIXFUECe1+3Eh/JfiBlKR2SNEcyeSKv7cqUCArU/07z
	EcqHGH+aVaiFpKMxkKaC/ZVB05g+r+DhJemEXgCv6FtOTWWlOTlYY8gM
X-Gm-Gg: ASbGncvn3LcFo9MUhdY+ZUHyXplR6uHJmER4WYm7m2PcT0/rBUmhSK8f1ladhoMIHAZ
	YhDQiGcn7RU40x4gyWSF9aD5bM95U8BxDO0TvE+VTZJMnFYJPGbFgGflHaVpW5k93osv0rFBZ11
	LmJJUzekKVHZM6a9UCX3NnAxxDr1tr9N9GICIAp23HrsJhBUAzW41MgCW/0a2Bd3RjPY9McpHh/
	vfm7myPRnNTHfmcsOxYCV/V4oKGQ2DFFZc+vLQMXpPND0ZSsJMbKw4XWlHbhc9LGJKTLSRMDc+4
	rJZGYvTo1YsDL3lx2jSSMmNQCx5b0gDOGmUH3gofjQyC1wCKd5qz4kJEE31vkqd7ZPDMPiHNO5Y
	jtFB0uJU/mloinOgUlMkc8LWoS4OtB/WQjRMQhTXS5o5+IzmN+cDTZNweFB45Rin6Oo9UsSRgUb
	fNuniwszSQJeEnuQ40NYxM0RWSg55I7MWPIWmBK7vJHDxmffLRHy3RQ/idvRBw
X-Google-Smtp-Source: AGHT+IF+7U/wNQ0NpxIF99gi4U8nhseKBZ5Da8Q6VFYrm3gmjFcz96pkmQpTdIaTfQVb/63+drU5Mg==
X-Received: by 2002:a05:6000:1863:b0:427:4b0:b3e5 with SMTP id ffacd0b85a97d-429bd6ada25mr459355f8f.47.1761847095143;
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 02/13] serial: rsci: Drop rsci_clear_CFC()
Date: Thu, 30 Oct 2025 17:57:50 +0000
Message-ID: <20251030175811.607137-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop rsci_clear_CFC() by reusing rsci_clear_SCxSR() as the contents of
both functions are the same.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 3e1f4b3c4e59..504361ed5ecc 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -199,11 +199,6 @@ static unsigned int rsci_get_mctrl(struct uart_port *port)
 	return 0;
 }
 
-static void rsci_clear_CFC(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
-
 static void rsci_start_tx(struct uart_port *port)
 {
 	struct sci_port *sp = to_sci_port(port);
@@ -275,7 +270,7 @@ static void rsci_transmit_chars(struct uart_port *port)
 			break;
 		}
 
-		rsci_clear_CFC(port, CFCLR_TDREC);
+		rsci_clear_SCxSR(port, CFCLR_TDREC);
 		rsci_serial_out(port, TDR, c);
 
 		port->icount.tx++;
-- 
2.43.0


