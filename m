Return-Path: <linux-kernel+bounces-878842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A20C21960
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F44ECE55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3736CE15;
	Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llu4AxCb"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D936CA8F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846934; cv=none; b=ltLCqtXLNu/RiBemw85+M+uukNgfue4mc5WWppGcZE4V8WcfebGe725rCv4TGoWWfUVI8HCFHnEiZ/hHX66xS2QijwBgU4OQpyZCXxswKfVAtHTXGFNrOQOzxy1DVJWLZdacNDEXJMml/89tJ4YPvYSBax8wT/zw0uuMvDZvBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846934; c=relaxed/simple;
	bh=CGCGb9V5eBipiJiyKGzWDh8EBRU+yWeR3nCYNAfd3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM5N6fFFI+hwCJu4Hw/L2Z3hn+XRSYu1yyShAn+uCNqv58PFgPYCkOwhaXfrkOCSBqXe1Dtc4cn6Ihki0pqt5vuW/1S3jGERk8B/jDJQR9kd/g40iqP6jcr7FvqbFxdhppy58Qi9nYcIdLUw+l3C14WH0cfnvu4LCjahuvO5vY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llu4AxCb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429babfccd9so780683f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846930; x=1762451730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=llu4AxCbYEFeFmperq2HYGcElsxZtbHyCqW0L5UMacOds+BzpLFfE4RaM9nkFnlafC
         Y5dbIK8ueAplhvdOH2i1GZ5vKwa25+YQiWMmKClCg85yeRVGmfXhe+leyIyi4dOucgEb
         tRsMsgdQYAgpb4MW2eZZq7TaKNG/YraYHkzJBOivurrCtyiunJlirRb3a0kJT0q+/unf
         c25eCHAyf391GeUKNcIUpt9NNUUeFJnaY2jn8oA+qDoGA5nsFZXzyazAFa3JNhFC+XgX
         VMEL2EL89IAl8NhQ3wRS1bpZn/RpTUQEe24TnsLSIKnoKOVJNowktykzuKcAJZmN4JTA
         mY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846930; x=1762451730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=Wo8uyxoNDH13oyj9byY3LFAPiPl+Vj4qgAzawOA8O9nF5Zo7womLxalgaWA3zbrHm9
         BGmIDmT42u3jXKiw5IhA4vgpIuIAcPPqyGY90w1VIdasUfSgdKl1azE+DnsvldvXwRJ/
         jaWo8xGsW0g477hRJ0us8kYSjTvPofDmYxitR7JKYvA41mcznMYH+br6KCz5ed+fFU98
         EhhHHv3lB42yyahAPn49ah/qTxe7dIWzMpxUWpGokLu6WoSdw0/6JPk1I+/bdWlOg6S8
         D6kpvze0s6wo9osNRqS2qbJ3ph1sBvl9KysLKwnpEs0zfR2xKojzbM3Xo8uWLZmyMViu
         fVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7D9k6pwRtvK+FN53gZqyLo6L3yyTdwxqREIh/prAF5oFA2UjqmK+wcAKXHNIPnHje955RiEILoSS7d7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdKhTzoU7pdbXwdPTy2ft5v1+wedqoTj28PPnEwcf5MRcF9FQ
	1eQMLzPh/DC8q4vjatRhpdv9Y3ooSRUZX7315gi4ge+/Zk4DeXWiWiED
X-Gm-Gg: ASbGncs3rvTmW3A2E1K+uFv8z0qtPUt+HOFqmwUw8oRaoarqL+8ByEUu6cPph/vOGzT
	doOR5cM1g/fVD70fHwi3loqKKI/dEED48RzVtFsYjyLqK6TGJw/QIR1rynWa0TCLgBIs0HBxOyA
	y7du5+1sBUlaCp79eFU7pJi4RvuH/ed4A6sfO09JgcJzzG5gEzPyKhXfDjZlShFGK2v/quoNtAA
	Bn2yLPNq6azSyIB05IrO0KJ7rt5fuICE+7o/Dp6j4ByykewuSEUwdd02CZyINbG+ar1B6e82+XR
	qdcFWQ8ncCy+tLvVjDY+2ck6YB7Arb9yiHNHZAluxFLg/6SmY03gMty4K3YYYjOMT6Cc2d5sAOE
	PThe+LBHCB1vOEtwiJitRCybhkjE/8ekGcsnrozIqpLHzu9hIr6Q0eENJsuTUf/6/9I/E7m5kNR
	Zik5OsYVxxiCkOJFXfT03bC7kRWZ/FTVsFLxYBx6TvMXLknwcRWPN25J36WodKeq0f6drM95o=
X-Google-Smtp-Source: AGHT+IGYIITVqCReHtNAX7+uLzQsVs5gAndiYBJ77Fh5G2SnarCvdls7gc0J2+Oyf01J33C9+PqrNg==
X-Received: by 2002:a05:6000:24c2:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-429bd6aa1c5mr412181f8f.35.1761846929744;
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:55:06 +0000
Message-ID: <20251030175526.607006-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
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


