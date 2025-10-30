Return-Path: <linux-kernel+bounces-878843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E4C21975
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D82F04ED58E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76F36E34F;
	Thu, 30 Oct 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrMMf0Xg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040836CA7E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846935; cv=none; b=DT6FOXyxTm6pXjXgPR8EoKVg5ovE9/l0KaySGfu4r3hw8Saua+nbfoslq6eEU27FitpQgOIRPavyy3s8JLm0bs+HG48QY8U8Pey0jkDEqIf2eyhDvhpPsdMXS+HXjzRlncnFKoObwTxYmukrfAqt16vAD7BlshUUYCKvd4j7t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846935; c=relaxed/simple;
	bh=6rJaHYLudOTTm3QmqB48Nxc1YcoHdZeo58CPf1gncKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWaFTfVnzKPhFm8C/7Ly0m1heS4KTP6+XOhuIs9XamyRD5eeu10pQsXz/4BN0l8dnKZfKRt+L7a/qtH4MSWjwHMPwebt8IZVevAT68eppr+y/WPf5Q3MlWcviO6/AvrpTizI/Q75jnYZjkBvRH50L7GJ1pGWLH28eu5lABVdnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrMMf0Xg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475d9de970eso9671295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846930; x=1762451730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=PrMMf0XgSq1B0JXI4C70oCTj2Maqfp1aTPQyE4PfRxWdqt4RZSlYefFUdv8axPHcp1
         STUeFTfHz9GPVUjrC/5SHapO9lE02LoIsSbcamqAERyWb6Jta/HSzxqwpFbIqkspa301
         Qs4NdYB/PALTNM4Fylw/ORaandhlO9QN+9KGjy2+7mqGPwulG5FfCBpBBvKlYA8YQY+O
         tj8yisso6DiZySXDG82ICckzbG2Ne/lFWHThEG6ebrTQxIS9TpfKil/+Zt0UI1g4bU86
         VHO81rtR3k6k5Qd0LPeEmYjFktQwxT9EgtM+6Vsbm30b4TOlWyUdbL61BbaqB7aNNEiN
         0qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846930; x=1762451730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=ZIJnBIYbRI/2hIS7EAF6wlXg7vtH/8Py+3PBZ8wcK7THcDByKbwrg/BFi0lMWiSPFC
         D/8x4+cWmeiu1VTtbfq5M8uy16WuQai+CIs9bW0EL5tzw90ESvXW9TGJAfGwm8EAfXer
         7dqFwCert55tVc996l6ZqGBHRuv7mGOOtscsLQPgzG3bwZXWPpiare6kACz8zUvERwuQ
         yFWBl0T9cmRMSOZmr017aE7YCVyOkRfW6teVZTF0KePSbroS/UXdNUvMR/G2HUwSxSSP
         l2+E/us8N5WZXBVFwcDkBLGvtAjhtTgGyXbp3zoFjqGAu+4WlfIPnCBeRLyrqq7ko7XB
         am8A==
X-Forwarded-Encrypted: i=1; AJvYcCV2UqvkRtzAEPyOiSxnYlWbpuh3rCF3UdB3i/dnx/+yhvsa9qC2hC2X/qFBEiKF92PfE7oYohutf0l5dYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNKrALntXjhwIn518pHWzsWz++eZSa7vtwZDBXTd7ZuzXdWU5
	uo1Hqq/Cg5Pxo69xjHfrm634GrByX4WE2dX4qelFswB3Aa1SJqDsKM03TjqT9wQ0
X-Gm-Gg: ASbGncu1NZE20haKQHAug7+PSocDpEYvK+ch/5GhJUQw5Xh9/5vD7o9IXmVrOyaFwWf
	u56NkHvDWEmdRfK6+V/uXrNEetqMZQBe3RfGxNOv9XACwgp8kj9sPnp3sP50cqOgQ2MPnFmvf9e
	rk9V0VbgEM6vmc9F2HBCmU8Rh8MDPtcesFR9KCEop4CZcGtaZfHna0/jkd2NHEIeNefQezoosx0
	/P0qLb4Uk0nNV8ofl5eiajTXfeCjC5o8OubuFx2JlyvwVugQK1bbEyYxKzESv0/yeO5jE0arS8/
	mgPqgpCx4oseUK85wVG01X8b5RIjrwV/878SZRxJSIMYv7wKIn6JA1cs8bHqq1y3rY1WS34FT24
	801Vm0WeJNVJUGgZ8JAmDuuQDzkZx3UIQL3wtC6ASA2WbgwhUrn+19DFmYtqAs7Fs2cwl+x3tqG
	2gbu75seggdReYYJNFZho/gmK/10RGTJlTJQQG4O9YMn1atsNTXzdPAtAZpzbRfqhVxJYmRYc=
X-Google-Smtp-Source: AGHT+IFBi0hqrqgDBukpX7UuHHLxHjT0GA2iPHi9vZvzYJkR6850zvm4U+rMbHpm3ZqwPaCKtK5CeA==
X-Received: by 2002:a05:600c:64c5:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-477307c1fd3mr5174305e9.10.1761846930304;
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
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
Subject: [PATCH v2 03/13] serial: sh-sci: Drop extra lines
Date: Thu, 30 Oct 2025 17:55:07 +0000
Message-ID: <20251030175526.607006-4-biju.das.jz@bp.renesas.com>
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

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message 80-character->100-character.
 * Increased line limit for error messages to 100-column limit.
---
 drivers/tty/serial/sh-sci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b33894d0273b..e9345f898224 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3008,11 +3008,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			return PTR_ERR(clk);
 
 		if (!clk && sci_port->type == SCI_PORT_RSCI &&
-		    (i == SCI_FCK || i == SCI_BRG_INT)) {
-			return dev_err_probe(dev, -ENODEV,
-					     "failed to get %s\n",
-					     name);
-		}
+		    (i == SCI_FCK || i == SCI_BRG_INT))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
 		if (!clk && i == SCI_FCK) {
 			/*
@@ -3022,16 +3019,14 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n",
 						     name);
 		}
 
 		if (!clk)
 			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
-				clk, clk_get_rate(clk));
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name, clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
 	return 0;
-- 
2.43.0


