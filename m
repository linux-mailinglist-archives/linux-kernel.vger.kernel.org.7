Return-Path: <linux-kernel+bounces-850904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C246BD5272
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B441F561F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067631A7F3;
	Mon, 13 Oct 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpbuzf6C"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909B3128A9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369328; cv=none; b=ewVCEUSM6Gr+VEMiMjTeJ9zZty2oLVTH040Bcc6eDkS2DGk7tahuXZb1g2MY4nLKBX40D1i/kLNM7Ioe1/hQmwZ5gUKMKy13B2Br6X3ZH36BC7nkx3WEhK+WsvsH2jqqZL7uzpTxng9o9kVBSWWXKJTcGojSi4SinQ558dF/boI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369328; c=relaxed/simple;
	bh=WlMp0vM5w20TCEI5Z+Msdakq5JZXQl9RpmysD9Cx0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udTOnHjj0V2Cj9JY6ToPwLRc44OTPkLAyoeCchoTBPcPmkez5RHafxPwCXGAdL/atuJOjHDbeXc/G2c7TSIYysHIZ2w8HM3cvHwO8YfYy/ffmIvzFdM4wujdh1l4PGVtNnvLgCSd3XNI/udEpCLJ3/uWOG/Jp9BV/sdWMSjwJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpbuzf6C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b40f11a1027so779557366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760369324; x=1760974124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwMSoXVUaeG8vhH/f/stQ8wxLvQaR89cQ6n9U3aN0cs=;
        b=lpbuzf6CuyoNRN7hwEpS1PfTAze9vbuY+EIU7/hxY0K+2Y2vRYcKJEx+0hhAGPtFDv
         UTEP+vER94L2I61RWUcvq4/htmTWGbqN1xm0T+NQ3R2QEXajwIJ7uvn7GLf9/qTY56ip
         C21qKUnGX0dX5iTGp9f4aYPeXNh/VGHcSAR3jKq2Oje9T2gFYJeYBGm/CcPBamWyMjD5
         pSSAae4fry5p622EeH7yhrlgSjVhuwVRuV+6gq+x4V14RI7hW023uF/o4afZEN8ydake
         t/H5glPYJYH8Aw/zl2RTcGuuwRzDteSLAal1LkRbh3R/xrjFfcbdejOAN9YftVWIuack
         FoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369324; x=1760974124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwMSoXVUaeG8vhH/f/stQ8wxLvQaR89cQ6n9U3aN0cs=;
        b=nw8IEmMijGPGuqga/Yr/VjSPQNm6qNed/EzHoRo7aIU4ZyVfZp0gD4xYqQlay1lgn2
         +391WgLq21Q+4dFMYqpbGXyEdzWKB+U4DpDhre/6KY/w0cPmKElUAmpJl9+kGbdu+aC2
         +P2IYGVoV9Rf2F4uY9x0vimwqRY6+/cozt8Bhg+mvW2hcS6JCHQEUI88CvpksfMEI/CX
         lVYrcJhD/mRumWh12+rByunrBIRCLA3cosSR8sE+SKdoIAAJMKgUxMdG4DLjxCDy5cX3
         seiBk2dbmQgx5+mymvjWZrBH9yj2FhLw7C2RflHbrm1XdoX6/SwoxhXkS5JWG1Zqq0iz
         YMcw==
X-Forwarded-Encrypted: i=1; AJvYcCXCwHh4kcytCHXnxGWyf6yWSQNdWUnx3FW8svZtjWux1msBaCKuH1KXJXnZF75+/zrgXY/UWLMuJAKLPDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSPoLM1IXball/Y+Tc6ooI3lFtB8OUhLTwd23Sl1JMz+kE2Fs
	52h5BHEHOzCE08tGPFAFPu0Pv1qLdsvACCc3tPQbLIhfx3yQWTKtOLO0
X-Gm-Gg: ASbGncvXE6xyKmtCcAHgPYt8zD7im0Yvf6/Sfra4tVP6r1qvYZDnFSP4FYxoXlwaJSf
	uMxAG74UHbDrEaTBF13MSLIMrydLeAANyD7cRJt0OF/MCej4e6Kmv7elYv2M+uWEI2qYV3Jg7PK
	UiYGtTALwE6+LOO08hoNkcJBx+nf9hXNTOT3h2Tuo1+P6id/3M7ns05toucaNjo43cHCMHI1P8Z
	NpZqI3YCYXUVLN7iqP1CykyQzYJ3P+hXOi7tvYFxrjT7E2oIlM2Rj65K5fb6ES18DZZaKbcG1vh
	oKUJ/hc1XFd7QmSvoirvOP4MS3wjQcW4cPSa++5jCqjr5pY2zjvGQIYSyk8Syk7PJjZdcloKl69
	K8cVXpk1LjOCzmO8zIPs6BkoXtyATa0BAzJd+m///WTV3oOPKecM1kvkPtdf9/3i7Eg2BAS4geR
	i+oQT/Zvue7+6y1aFKsqGewQREeuL2o/G5
X-Google-Smtp-Source: AGHT+IH/kEGoSsNgpEJrmB2dhN7tK52GxxyaIXJai0G9MWbbAFq1kxi5vMJMyYElb4dKfPJMviVOZw==
X-Received: by 2002:a17:907:68a2:b0:b54:858e:736f with SMTP id a640c23a62f3a-b54858e73a1mr1347210266b.36.1760369324234;
        Mon, 13 Oct 2025 08:28:44 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8dasm965607766b.4.2025.10.13.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:28:43 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: b53: implement port isolation support
Date: Mon, 13 Oct 2025 17:28:34 +0200
Message-ID: <20251013152834.100169-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement port isolation support via the Protected Ports register.

Protected ports can only communicate with unprotected ports, but not
with each other, matching the expected behaviour of isolated ports.

Tested on BCM963268BU.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 25 ++++++++++++++++++++++++-
 drivers/net/dsa/b53/b53_regs.h   |  4 ++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..ad4990da9f7c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -632,6 +632,25 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 	b53_write16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, reg);
 }
 
+static void b53_port_set_isolated(struct b53_device *dev, int port,
+				  bool isolated)
+{
+	u8 offset;
+	u16 reg;
+
+	if (is5325(dev))
+		offset = B53_PROTECTED_PORT_SEL_25;
+	else
+		offset = B53_PROTECTED_PORT_SEL;
+
+	b53_read16(dev, B53_CTRL_PAGE, offset, &reg);
+	if (isolated)
+		reg |= BIT(port);
+	else
+		reg &= ~BIT(port);
+	b53_write16(dev, B53_CTRL_PAGE, offset, reg);
+}
+
 static void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
 {
 	struct b53_device *dev = ds->priv;
@@ -652,6 +671,7 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	b53_port_set_ucast_flood(dev, port, true);
 	b53_port_set_mcast_flood(dev, port, true);
 	b53_port_set_learning(dev, port, false);
+	b53_port_set_isolated(dev, port, false);
 
 	/* Force all traffic to go to the CPU port to prevent the ASIC from
 	 * trying to forward to bridged ports on matching FDB entries, then
@@ -2318,7 +2338,7 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
-	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD | BR_ISOLATED);
 
 	if (!is5325(dev))
 		mask |= BR_LEARNING;
@@ -2343,6 +2363,9 @@ int b53_br_flags(struct dsa_switch *ds, int port,
 	if (flags.mask & BR_LEARNING)
 		b53_port_set_learning(ds->priv, port,
 				      !!(flags.val & BR_LEARNING));
+	if (flags.mask & BR_ISOLATED)
+		b53_port_set_isolated(ds->priv, port,
+				      !!(flags.val & BR_ISOLATED));
 
 	return 0;
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 309fe0e46dad..c16b3e3e8227 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -120,6 +120,10 @@
 #define B53_SWITCH_CTRL			0x22
 #define  B53_MII_DUMB_FWDG_EN		BIT(6)
 
+/* Protected Port Selection (16 bit) */
+#define B53_PROTECTED_PORT_SEL		0x24
+#define B53_PROTECTED_PORT_SEL_25	0x26
+
 /* (16 bit) */
 #define B53_UC_FLOOD_MASK		0x32
 #define B53_MC_FLOOD_MASK		0x34

base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
-- 
2.43.0


