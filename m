Return-Path: <linux-kernel+bounces-750052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13EB15699
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B79F548390
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7011369B4;
	Wed, 30 Jul 2025 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alGSwHb5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AF801
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835848; cv=none; b=pp2XgrodqZ4pOFaovZ+bQTfFuEwO38JmmU3oZsPzPghpf9/iaa6yB7LfZPB6WvTja4W3SxOlLXPV40qiIL4ZbqlaO946UDiuted6G1DHYAyXxe2Q/gtF+vjbB75dkbhyDQ3hv8Bp3cXhbimBHAt1WNN7KIM5BRgNADqB4nF0zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835848; c=relaxed/simple;
	bh=xyZ4PKsxhbFh8LNHdmLt9PmvCqfw+SXwlUH3hxSwz2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DhZbusqQTJYGDOvSR5MvB9uAZpIMpW1S7ywuVWC+uFIyVegpHCqg3vNnWWpFz202DqY3zi/IzhW3bXr7GxdyG03b4YMkoodUQh58kjqAvP6AYiMQFn7wp/A0OjtQMouuQBe5OeIR/NbTZIG3izXXHvcZ6xl8/GmYEtozYiXZUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alGSwHb5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-769a9c3bbc4so1427639b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753835845; x=1754440645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IH7dLAPML0i0J6f7OwlshtvTGBaOPfMPixeHtVKbTU=;
        b=alGSwHb5i05UydLycxzRmB2kmRpNqrJ9VDT4sTlXuG1Vy0iV++edFW90Eh4No5odbB
         E302aQn83PgORyp9UN4gidLnKvY+MoHX56/wS5bOvcPAp5MpcenviwsSg/TNOhVRoLat
         0KgnFDjf+xQ7TDSrcxaUxONfU4a+GO1RJxqzZN711x8eisns4xws61CqeFTtKoZG6k1+
         SaMvuIKD2EuytfK2tsv84KeC4VZK8ft/uUjPleUd8EEeFsr+/z3vo5sytf7UDxTxIu08
         TxCTPSxohfqVNv/oA6etsLzZ52pq1M6TUIwQNkw85ZK25rksoF85Q8P1TCB9W+tU03Cs
         A+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835845; x=1754440645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IH7dLAPML0i0J6f7OwlshtvTGBaOPfMPixeHtVKbTU=;
        b=BmXC2Z9GANIf5+j5RFp0qh0asXRnxVcQWYamnlCo7XG9SaYd/baUkj17pGzwCGUvtD
         V4k/Y80z8rHA4osN29uZA0ljrDENo4USw6KeAYy/31W9PDxgDeaKdYLXyuLK19mUEMXU
         yv/Kf5i5aBBkQOC7ZwazM489wMopH9SQ5LEXD05CN4UuGamP3ze1cHKyFigew3gWyoEz
         s/iFdAXeMIGP6/ienqEQLBLNFgTcWObYsinoK0vTON9zWD9sxv8JAaGoKlpwBY6wi4f/
         rlgcl0kNvVKioecM6WqZKfPqfCuGCTIadTroXSbCK2s4GvZKnA5rHh1+ajBYUqbV/nz9
         UzBg==
X-Gm-Message-State: AOJu0YymEYD7xNVWwhvA0HGeYic8bQIlMHxYV2AgY+krwZtj6Wb0+FGX
	1hp9spANV0FStbC+IZaq8Q3yAAH0p5MtVifiSv9Z+BAvNEbqoycj1yZV
X-Gm-Gg: ASbGncuvVr11bBT2YMMYn+aqTLmnHazpHVU926k92etSe1tQOc/IH7DM37v+y+35Tfm
	EXlDXLKOOVIcyECSBhYNanauzE4+d5Or2tPTpLre96rVRTshP2u8zseBO0BRhqaaeI1hsDqWQm7
	Pn3Wyv96fdJR2lTfq2DCkt3hUcFuZGxTs8+QymVuISxZsDR+nwlRBoXmhFPxmaO1TZ9HhkRXSC1
	tOdYypEld84IMIKTTjNQ38xD/Z/SL3Lp4rX4s239YZPNwkKOE9qyWRr8nDrKDCPwK/akp+gEmcD
	O0LmI7fy71RxDOAOZDWqVGPHZZZrHU7B3PKXyi4+F3M2Qq2O5px/w73KQqOPuj2JYT9bcWMQfAc
	710hsJn+iBrnFa3fXtxS17FwrTYOm22jGcDQneGcZ1N4=
X-Google-Smtp-Source: AGHT+IF3xpRXIap3nhoGNQtn5l2Jl04XHZsHgByFscuO5zQRsqQGugs2wjoagzsgM0Rt4W1ybC/yBQ==
X-Received: by 2002:a05:6a00:2347:b0:74e:c917:3b1a with SMTP id d2e1a72fcca58-76ab32e6e99mr2310545b3a.24.1753835845531;
        Tue, 29 Jul 2025 17:37:25 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm9099336b3a.117.2025.07.29.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 17:37:25 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v3] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Date: Wed, 30 Jul 2025 08:37:19 +0800
Message-Id: <20250730003719.1825593-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

In a private write transfer, the driver pre-fills the FIFO to work around
the FIFO_EMPTY quirk. However, if an IBIWON event occurs, the hardware
emits a NACK and the driver initiates a retry. During the retry, driver
attempts to pre-fill the FIFO again if there is remaining data, but since
the FIFO is already full, this leads to data loss.

Check available space in FIFO to prevent overflow.

Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
Changes since v2:
 update commit message

 drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7e1a7cb94b43..ece563353895 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -104,6 +104,7 @@
 #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
 #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
 #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
+#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
 #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
 #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
 
@@ -1304,14 +1305,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * FIFO start filling as soon as possible after EmitStartAddr.
 		 */
 		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
-			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
-			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
-
-			writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
-			/* Mark END bit if this is the last byte */
-			writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
-			xfer_len -= len;
-			out += len;
+			u32 space, end, len;
+
+			reg = readl(master->regs + SVC_I3C_MDATACTRL);
+			space = SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(reg);
+			if (space) {
+				end = xfer_len > space ? 0 : SVC_I3C_MWDATAB_END;
+				len = min_t(u32, xfer_len, space);
+				writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
+				/* Mark END bit if this is the last byte */
+				writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
+				xfer_len -= len;
+				out += len;
+			}
 		}
 
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-- 
2.34.1


