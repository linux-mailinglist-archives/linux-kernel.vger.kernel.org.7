Return-Path: <linux-kernel+bounces-878860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814BC21A05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF711AA3501
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8A375752;
	Thu, 30 Oct 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN+tFXfU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AF374AC5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847099; cv=none; b=u8JJAgLY3ApfsJVIxzEiVJoPE7BeYtOWj8l9x9g7G1bUhK1H/v4dpzpZqY8DlNtvzxlOIUDclGs292zXuVzYbrBAHLSon0rmGJ8sZgvzvzqNXftQ3BBHpCJv7ZlPShuvkX3blZI2pldQNZ9+54bbL0vWftABsvp+4Y0Q6BJ+hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847099; c=relaxed/simple;
	bh=6rJaHYLudOTTm3QmqB48Nxc1YcoHdZeo58CPf1gncKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNYQjVWz6FET74fqGKQDc4lupfNYjbjqGNqRKASUzr+dwD4Bhy1szuFV4wMxFAywA6LSrkxzME22Thq6zQSihGDSqbQIlcBe+CeKoteyUZpEiMeGTFZ5Rt7mv1U5+3eoN5AUVRdbYkvpCBivOV8f4iuQ1/+6VY17vKgfcK5ZFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN+tFXfU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso9496515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847096; x=1762451896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=gN+tFXfUhYd7AN3Egbhc+T7/pjjMN64BsyJlhBek2r3vzGltI3kPlI/rTbHDhObt/v
         KDuecshf8fz1/LKL+bgt6zTWG5uYBx98KpeqkELuXlTesVM8gspjIp8iuR4yzPH3BOhM
         Q7afw2djT/6wdIrjocj4Z0+aWgSpvOKEa6U/7oxh4957jYlIPv8JbOmV/AKNdC2BUxcE
         Uuk9TWfGk0msU8pD3UiTi54FxLCDgbIIPj9IvBuFUJioXNebhjbJ6y+/XMKLl96gyZe2
         y1NGgvNSCGB7rX09KdcbStfOVHdjViDBfcEqPggOCuTSn++ROLMrRusk6cyPkInqQhZU
         TuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847096; x=1762451896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=QR7QCzTyBk/5u41uzX+cFcZKoU+pLUmz1uXQvs2v2x/F2Zue5c+Uaw44GTmNX3+cNF
         MxzFrV72asjmY0PT/ciMvVY4XzvtIgqDOA0y3qpw0ZwiDV3wjwk3LgRbyZ4b7OQgHcOP
         6hLVOnIIz5eefPfRohyKXpfzftHs4dh6ZSyJECjfTZXtCKLmdVqIo3gBOELyhtYnUUhz
         QFodfIj67exkhdO69k1kAVC6sb6oC61WZIjfUHGUs6I0fzsYKHEEKaHc7fy9CJsDkmBI
         B2xjOGw+HLGaYdMRbaQ1LXs6UOaT7rd7+X9rcbw4vIJOBFBikVt7Ual4MHKENSRc/b41
         4T+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgHjUbsEHIAPvqCRUSyughRN61k+ooOQpdRKlOMeB5JRHImUXOUEDMh6H5Rfao3EvJro7ew9t4iJh5z8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJuNVvP5YJRQB2fZ7J36UioOxExa0QoqakyWWsRkfPSyzo+X7
	K/28Jv1HLm5RIncJ12t9DNSGhvm8oRTBbGBJtukK4qNKNB/CZIorRXk5
X-Gm-Gg: ASbGnctBlw8a7/mBYFnB8lK/W5Ipp3vqkqqe7btQF3caRRhJ9CyW8oJ3BrzWL1qK2Mq
	eNV5sb1TD5szidhYt5rvVent3I/YkzrN4EjmpLM1ewmYL41attE9R6qb/qpIudzjWvBzaeNG9aH
	nZTGEq1OratyrCYEtgfwJ8QbBQEr7rF28UeLm2FpgrAvFrZeSATzt76YFSUowAJDiBKuRO9GXCC
	/lLG0zjQg/oJMrXwvOi06KHdqX2iyZawgWIH9wTOlOHBv0Z6f6Exnig2r2MxtaphISDwzVLOac0
	9Y1b9cL6PU3ILXi6573apr9xltk7CedZzVJZNSk/U9VPUbXY6t9MEP4JgRzgYDJoVV7p8+LWWKq
	0MJh9ya88MVvjJ+5sAlyU1bZo4HEBc6hdjheI5aITMsLQ+OZG6XVJDEUJyCCL7PSNOmlh0htR6I
	RKSfIhoRIjwbTgfXds+dR1qrDDA/Kg3yP0F4aA8sK7+Lg/qohcTblmRm2uSomml6hs1t1LTVw=
X-Google-Smtp-Source: AGHT+IESJKAO8ONCerKPM8W5gyvkInHRoiE3CjlNsdnbfCKBMGmr+c3jFDp/+N+TA8ao+fo305pRQQ==
X-Received: by 2002:a05:6000:2f88:b0:426:d51c:4d71 with SMTP id ffacd0b85a97d-429bd675f4fmr449957f8f.8.1761847095655;
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:51 +0000
Message-ID: <20251030175811.607137-4-biju.das.jz@bp.renesas.com>
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


