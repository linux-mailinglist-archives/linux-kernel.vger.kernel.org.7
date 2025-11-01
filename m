Return-Path: <linux-kernel+bounces-881308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2EC27F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E893634A048
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411752F90DC;
	Sat,  1 Nov 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QphTfCzi"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB12F5A03
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003698; cv=none; b=D791bx9VDjPXbrLCZUEbotRKtVb9eMVs5InCH76LuAlvAA6AAs4/pWTdWcAYcIU4gq7HWw6ygSyF6b9Z+wF2WyrkatE6jHjT7iiOWq+HxvTlgyKLNK8AFJPFa8crrJOpo20gdlH3+A76ZrE0UVNrybztwSwEsDRlzOUaGkbnui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003698; c=relaxed/simple;
	bh=p/JaJlQiawxX+qh5jQdUefNsfFmb3Jnk5eyI2KNhtQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYrY14GLsWoYrVSzubcPWZrCT1Pc93rcgq4ieIK07HiZT+lo0AJlCc1bvMLU4NZypYwxrUzO8HJUw5fWZNkRQeVq9PyMPT/e8rsUgrVWj5BuebGHcHsh5edXXvY+8CHs0cBK2qYMjoK7TtVGJVtFEPDS/XaT6Q9d5jYayfrJSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QphTfCzi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so74208a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003695; x=1762608495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyUKEht0XIqrrj737jBfGR8saqpCsaWS6/0aBz7Ix5A=;
        b=QphTfCziKDbHio5XHJ1QIUEWQVLgknzt36XP84oKHudsQByD07qzLiXDgUcpM/yPVp
         x8/8OQ3XNVD9pVBOfYCVFbzchldcuyLa6Z8RTx3k0aGsurOChndjTYD9WlT68Z8RAnMc
         YDRYJeoplpMfk6W9F2oAbpRNL57nGJLdlW/xcrCanNcGlKW6qbg62WXR+v9L6EqQ+ZRA
         BCsSSdPuNqKD41Ob8cIyMmiSoHlG2wspBlWvGp26IHuir7nQLGSwDjELN7lZX5tB+JW+
         75LDHXreg4U8X020nEsG3TApYBYhEVuKiCvMgJnPSF9jydeM2/4tw1jWbaJ8ZwbkoaZ7
         nx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003695; x=1762608495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyUKEht0XIqrrj737jBfGR8saqpCsaWS6/0aBz7Ix5A=;
        b=GGw/Cw8WRW0GdscHtK9+8MuQrD6UwqNjVu9+/ncMAjwvhk77DQPB42ebAmLlOuydRg
         bZHmJbi2G1yGl17ww/+G43B9FOm7lTJ8YG7mz6rzQyKdS8NeVtn9NgsJVMYzitPH/CE9
         ZK3sjM92TOKXy5TaaMtpIZhs3CgEj/aEwsxNS5ErUJWLy44emSJ0cUHRdBzYlTdZqA/3
         TmRvVLDGZDmBQRUrrqJerFP0/NHR9qQ7ZFejEWe3pYFqrmWbADwhmhFxQE9phMVATSlP
         QN8Zy5QMQO5/vusm7ZwVLd7Ytup0Q3uPUIXi0Ky2oBI+HykbltMnCKtmhCWsSaHzyLQB
         426A==
X-Forwarded-Encrypted: i=1; AJvYcCW4ajuhe3FsV2PUa8oo1ehSMJ8bBnwh3xKHUXCbdte37Dph8ubrKE7zjcNGnU7XvgRgcZFjfUKaAAbgJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvYLJG/kq7WAacGJ+nxzZ1UIpRwKSj/rgPVGUlh3k0hrJbTTh
	1bITthZFbXmvwXw1gI2X9kcx7mlk9MbFFFt5XPe5PeM4wW5Wv8W2C1bj
X-Gm-Gg: ASbGnctd+yxS4Uh7lvntCd7vRyPxZTZrT4p0Sy5n/MsOgeMkCV2/LDICqj01hPs1L61
	rQAxImeDB0gS/K+UH+CLBMCsKp4eW+33bnTRNMkUL+eZ5AUmXQGDkg+UbboHUc/F0IudYSoRlOP
	/oy8w6y6JflZER9AnYE9cIaY8OHGTbTb8fLRMm5C66UC5yYziZwQafZnJpDF+G2IfEMWEsWMVPO
	3pF2LYsWX9ylQBOFyo3DLvvL1YBjpdPDkNWOrrlVI7AdvJFDVhYTZolw9+TXfH8LisapAUq9GaC
	HloP/iOGj1byF3wOop/rWKyA2/vOs41Ne42wtImc9rE9OBhtLVaU+4zqLSoqV0F4lful5cnb6bJ
	4Nfp1t6i7u5rnwCn49+Y4x0xe5RR0BhHpPYZ1z+s+f9aWVYwxGyYt/ZUPEWmjT9aWT2UdV+rA65
	9uzP+4QSdqmJLEk0cihkQbzhqaY+pQ4rpi8Kl/pfxryT1dtnca54aPj8E0
X-Google-Smtp-Source: AGHT+IEEQTNiPubQPSJRq8duksf5867j4xSrXX+HY1Q9sgUvD7OFjRQ80gz9j/l/eCC8Aks6wfF77Q==
X-Received: by 2002:a05:6402:350d:b0:63c:4537:75a3 with SMTP id 4fb4d7f45d1cf-64076f751admr6576636a12.16.1762003694895;
        Sat, 01 Nov 2025 06:28:14 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b390d71sm4264125a12.12.2025.11.01.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: b53: fix resetting speed and pause on forced link
Date: Sat,  1 Nov 2025 14:28:06 +0100
Message-ID: <20251101132807.50419-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101132807.50419-1-jonas.gorski@gmail.com>
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no guarantee that the port state override registers have their
default values, as not all switches support being reset via register or
have a reset GPIO.

So when forcing port config, we need to make sure to clear all fields,
which we currently do not do for the speed and flow control
configuration. This can cause flow control stay enabled, or in the case
of speed becoming an illegal value, e.g. configured for 1G (0x2), then
setting 100M (0x1), results in 0x3 which is invalid.

For PORT_OVERRIDE_SPEED_2000M we need to make sure to only clear it on
supported chips, as the bit can have different meanings on other chips,
e.g. for BCM5389 this controls scanning PHYs for link/speed
configuration.

Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..cb28256ef3cc 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1372,6 +1372,10 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	else
 		reg &= ~PORT_OVERRIDE_FULL_DUPLEX;
 
+	reg &= ~(0x3 << GMII_PO_SPEED_S);
+	if (is5301x(dev) || is58xx(dev))
+		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+
 	switch (speed) {
 	case 2000:
 		reg |= PORT_OVERRIDE_SPEED_2000M;
@@ -1390,6 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 		return;
 	}
 
+	if (is5325(dev))
+		reg &= ~PORT_OVERRIDE_LP_FLOW_25;
+	else
+		reg &= ~(PORT_OVERRIDE_RX_FLOW | PORT_OVERRIDE_TX_FLOW);
+
 	if (rx_pause) {
 		if (is5325(dev))
 			reg |= PORT_OVERRIDE_LP_FLOW_25;
-- 
2.43.0


