Return-Path: <linux-kernel+bounces-867356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B857C025DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE3563355
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57629ACF0;
	Thu, 23 Oct 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b="NxBP1aD2"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F2299A8C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235905; cv=none; b=FmFv+41W26JMY/TbZo6UafRZL/ZunWJfV0jbVJB+R0/VYbAZ6eNQdQxolPlnkKi4tZhNEu1xpQGHUBq//RT6CjXKfU5OPupqkoS7tTRFKyf7IF7zTZk1NY0tt2YoFq8zDwIUowxxxjQAmqugSijZUkA/0ZeChaCJ8MSKTrnDDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235905; c=relaxed/simple;
	bh=nUteSuOJ9LX9qDQVOKziBVr0BfsdekpVG7OD+xDvs0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KohapvWUw+N+DqBx5p2e8S+WcycttKpqEwhJxtBzS7+SNBN4aTv1VfxP3pqyD7HwY+obbDGfmp+9nAu7cE+h7RIWv3aNJON+IGpYse0eLkDJ94O03x3d4LpP1JRrrqqP0kmSOdnMNOzU4GrHqeHlvLX7XxRRYV8L3emSeogsf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr; spf=pass smtp.mailfrom=42.fr; dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b=NxBP1aD2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=42.fr
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42701b29a7eso573494f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=42.fr; s=gw; t=1761235901; x=1761840701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m9ah5kbgDLsSRMenHAMj3Q4xRuIZKbPu+Dxwh5kMt0=;
        b=NxBP1aD2f7NUEHt0f46KvaLX0Eu3b2V60gHnF/g/kYm5ue4a/YW7pU2dpLCjt0UZb4
         EgQLSeq7jccy6LALn5pVWVw9rorWCniIssLZPso2JWnSzE+bJZ2gzUWP2+gFg5mtuZ9S
         3mZjbIO4TF1u2mGL/cs3wef1N7MXSiLTMhTP5KIklqJEmae3bcNVDrrzI2sX5hysOe//
         HEpa/ZKahC/FVKQQ7cM7I+/x+rFT0vDNt2Y/2CFsR03H3mLuQz4vlF+TcovrccMoOc9B
         muBc4U332Djsfj2EpbP4Mza0xRTmiPKeZkE8j50hQCaztudS2jZj/l30Y7O4fv71BSBa
         bEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235901; x=1761840701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m9ah5kbgDLsSRMenHAMj3Q4xRuIZKbPu+Dxwh5kMt0=;
        b=TxobpxCEQe8m6GjJWPOfkLbxuHFstoRGPc6W6nk9Kh29uZIdum3Bri3qZaxVgF9s4a
         A6t4kTB6mrmhR4l2E05Pd0Fxe/WPGNzEZqxMxoe/98TZ8zREDgxVuFOVv2F5ZP4Y7yv3
         kmsNKdDwq4NxTNEUPP0CR6NFzjttszB+38yKs8IkJaxXaKxm9HLdFFFvouG4mEku5LhQ
         Hw3DL7EhcgshlAwO2fq+OToeZq6Db0SuBFt601bfSk4zjsRTTACk0beM3EvbsUb13pBr
         Obh6cLjh7YBnyT9fdkkx/yJq0SblGFnRd1c2zf08h/6TWoOaVY33CvN5HayIieR9EOhD
         JAbw==
X-Forwarded-Encrypted: i=1; AJvYcCXkB5b35DAY9flA3C9LlKuaC9cxbwB9nR/8smZYE5N9vYyJFkJneBYm4JKozx5p25+yZLeenGdb40sZ0aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMM/OTmen9Zb6MiG7kzA69TVH3tYiNT2JiqQ9QHLHc0HB+X7SH
	gtNnmP6Q38Ht7xaB582WsC5q+ZjyMEjhEtfLEkU7OZFV7qhV11b+G5KRbmxOh4zORIM=
X-Gm-Gg: ASbGncta2rnq46f0x/Rc6nSal9vWyHe8Qd02djVr8caEmnuHlnYzX6ZKZWF/qEEbQ9b
	1ljliJasPdLaElWx3tmbpv+C7XI4gz4aHdaQ2/BNB/iLaNQLFulr3nLmRQWqYikPOIIVW2b5cfa
	aQkEMlpV2n4nrzGDum+FpY7tPplC5Xu8TlpsxPdzKTM1s29ORmfXkY7Vm1BoEQa/zvlNf0lATFa
	I0c0BaiGPX3uz/xa1WWEIICAIz3CmxWz5t4ouA2IEZZFUYhJSPZgwxTzWiWhydP4UXAxOCOyfOK
	3DOomtvVVeS0e83KZiytqaEvSr1W70nY5zNOoeQ/l07vcQ9Yst39vCZsB1x7gMLoK2qut1H7Brj
	dBzEXZQ2CyuLmv3sa9TDakbWzGhy1HvGqp8aR3ZzEr+bmaVdV46xKynDAqVmcOGttQ9vQGwSd7A
	==
X-Google-Smtp-Source: AGHT+IH0/HC+MxAgbHtrHb8ogRis9t+C7apRxSN2Uz8hQycBWUjbbsufH11Skh1m0YQyGENnztKy1A==
X-Received: by 2002:a05:6000:984:b0:428:5673:11df with SMTP id ffacd0b85a97d-428567313d7mr4621322f8f.15.1761235901402;
        Thu, 23 Oct 2025 09:11:41 -0700 (PDT)
Received: from wow-42.42.school ([62.210.35.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298b9963ccsm3017836f8f.7.2025.10.23.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:11:41 -0700 (PDT)
From: Paul SAGE <paul.sage@42.fr>
To: paul.sage@42.fr,
	vinc@42.fr
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tg3: replace placeholder MAC address with device property
Date: Thu, 23 Oct 2025 18:08:42 +0200
Message-ID: <20251023160946.380127-1-paul.sage@42.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads a default placeholder mac address (00:10:18:00:00:00) from the mailbox.
The correct value on those systems are stored in the 'local-mac-address' property.

This patch, detect the default value and tries to retrieve the correct address from the device_get_mac_address function instead.

The patch has been tested on two different systems:
- iMac 20,1 (BCM57766) model which use the local-mac-address property
- iMac 13,2 (BCM57766) model which can use the mailbox, NVRAM or MAC control registers

Co-developed-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Paul SAGE <paul.sage@42.fr>
---
 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
 drivers/net/ethernet/broadcom/tg3.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d78cafdb2094..55c2f2804df5 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17042,6 +17042,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
+	u32 addr_low = (addr[3] << 16) | (addr[4] <<  8) | addr[5];
+
+	return addr_high == BROADCOM_OUI && addr_low == 0;
+}
+
 static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 {
 	u32 hi, lo, mac_offset;
@@ -17115,6 +17123,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
+
+	if (tg3_is_default_mac_address(addr))
+		device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..9fb226772e79 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -14,6 +14,8 @@
 #ifndef _T3_H
 #define _T3_H
 
+#define BROADCOM_OUI			0x00001018
+
 #define TG3_64BIT_REG_HIGH		0x00UL
 #define TG3_64BIT_REG_LOW		0x04UL
 
-- 
2.51.0


