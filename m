Return-Path: <linux-kernel+bounces-881724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA7C28D02
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2177A188F9DF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB926C3AE;
	Sun,  2 Nov 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulh8MNM1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6B36124
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078093; cv=none; b=V4ID+0H2YyotqC2uc3J33vaUq70xBrirjQ0lytPv5gPQ0dm1uE4kVp2F/aa5lRch9UNh7y5Ak6ym+0h3npuGNHpGyUljpIkY0JFK1UKOPTbr9ZPBBqV0O40xtEkarqRumPnl0YTziwRyQ/iYBGefD7BTWOHTNNB7V+/Zw+y9I1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078093; c=relaxed/simple;
	bh=tA3WamGkzxLnaTBxEpR7Afe/4Mdf0Y+TETGijAd6X3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFbjT5Ol4XwV+7A38Ury6dqdDvDOYDFe/+IhPjJJhNqjqkMBkTFZAnn3QuxV3cDrvuEOY7Q1vP6GZjTBLxKfd2+2cmFunYWkoXo0N12LPpb9o7Ubzuojr1oO0pQ2ufx/bPGOLgoRMkTldwdEjlLnd7GZ3rKYPKtPS2aet2zgDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulh8MNM1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d70df0851so670793266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078090; x=1762682890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStBH8TctGPHxEfq/a3r8j8mNWuMDrDthcxYNhkb9VY=;
        b=Ulh8MNM1wo2zRPmJ6tJv0d8o55TBZXxc16eCP4y6E05SWh7sXjOZ1jEzBIGp5G82St
         fzGDzqvlGvUloXyzh7WwuEYNwUHLLyWmBOmjhNyxM6j6uobnA2UV6USHSU9xiMAZZmvv
         whQ2nLS5mzH6RjUmg8nEGwemJZToqHvJcpAtT1X9pyeo4CFtvRipaWfdyOm5gjpg9Q+W
         OlS9TkKrBy6ohwlq1PVlYKatWXRGDujsV4J/HFuG18zrRI4Szz1c+a01epWsC63oxVRV
         kd9j8f70jc2pv3FQU5Kv9aR45teXYYLlhK0thPL0JFceoll51yYjoQR2QBNdhwaDBXNj
         wunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078090; x=1762682890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStBH8TctGPHxEfq/a3r8j8mNWuMDrDthcxYNhkb9VY=;
        b=cFWeL3el+MDwAP3DHeHpRjLGSA12Ti6fZNclHXrT248RCDtFTTPowUNr7T9bERIXX8
         MvdxcyngyIBXTOwj8TtOMtMe7XfoWylqHHg+xZQB0o5Q1B7RlLjTePh8HdKilHYiv8wr
         4GOenXoKgGF1TWn/Z5cuaNd8clfBSQjhhdqgPkTCfaNjE3P+GHwZbQM/ZxGrIDuRN3Me
         hGugrgxN/AcMqSELbE6+LJXAw1PYR789V6RWtnoKG8Lk9l1rRuZ8UqwgxSOXezz7m51d
         A2SKAEBBSOoDMbtpSVoY2KmVW0AOPUh0/MGqEvjqEmlzFDYrzF+MCFzlhd4v5JgEejRp
         GEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUilxGQlh6srlMhKnPf2PPQgz3qbd16LPcJs61rce4w326H5klJGc+/LM8Qp6RiyZ3W0pUC9Qts7cItjYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFg35JHO3elpK6wf+QXR1HT3u6PlzmMBQKAs4sOwhhrj73O9o
	yFxDSQaVwd8bM/Ku9S1PTgtEN9AqtO2ImJVE628wj1rWE4bAXcSrpJjS
X-Gm-Gg: ASbGncuyubCIc2GLveEZTiGSp659pfsCV8FAXVdoCcqHV7iRbpsIxoQmKUjRpYUdZiu
	GqSWqJ8COaevdDwoC7D91z33F96rCvA+33NrRfx/pfJ5IrFw6MAbgljH5r/IS1hnH2PQ6bs9F8i
	lwYwGaGXCnFxkP16nWM+KNHrcfWDp3YCpeH5azwgNEhHgOsMH5iGuL3uYyL/hfFxCoSeWwqbvp0
	tlp8Ef9CjEMiV08JyD5vWL6aqiHxNm31Qsu9Nw69PqOH3cxANBz1KOxP5KNo/Rc8PJ6Wd0OusOd
	uB3lHw8fkgKoSBIkBeG8xegnhbvDZQwf72J8K3XHw71o0v4u/Jj5eq1EC8zXS4vnZGxCY3gMgZO
	c/lj0K+//OG6Jt8T4zVh0GPE2K0yrq21e9ELMGpIf5kcCp9bEiv7m0X2R/EnAKzTvEFALegmers
	bOnSOy8xHduWzWF7PX0v7aGKCcWtuPjq8/ilmxIj814FpSvmAVMG82AZQciZv8+w4G1EzyNNNoR
	E5TKw==
X-Google-Smtp-Source: AGHT+IG+eEnbIVIr3VFTaiiIEVBICkxTvYmwrL5KabaROTdtYo6BQDIRH4CfNWGQGBfJK2kGkaj3aw==
X-Received: by 2002:a17:907:1b10:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b7070133963mr987837166b.17.1762078089780;
        Sun, 02 Nov 2025 02:08:09 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077d18d59sm687901766b.75.2025.11.02.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:09 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: b53: fix enabling ip multicast
Date: Sun,  2 Nov 2025 11:07:56 +0100
Message-ID: <20251102100758.28352-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102100758.28352-1-jonas.gorski@gmail.com>
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the New Control register bit 1 is either reserved, or has a different
function:

    Out of Range Error Discard

    When enabled, the ingress port discards any frames
    if the Length field is between 1500 and 1536
    (excluding 1500 and 1536) and with good CRC.

The actual bit for enabling IP multicast is bit 0, which was only
explicitly enabled for BCM5325 so far.

For older switch chips, this bit defaults to 0, so we want to enable it
as well, while newer switch chips default to 1, and their documentation
says "It is illegal to set this bit to zero."

So drop the wrong B53_IPMC_FWD_EN define, enable the IP multicast bit
also for other switch chips. While at it, rename it to (B53_)IP_MC as
that is how it is called in Broadcom code.

Fixes: 63cc54a6f073 ("net: dsa: b53: Fix egress flooding settings")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 drivers/net/dsa/b53/b53_regs.h   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..77571a46311e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -371,11 +371,11 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		 * frames should be flooded or not.
 		 */
 		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IP_MC;
 		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 	} else {
 		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-		mgmt |= B53_IP_MCAST_25;
+		mgmt |= B53_IP_MC;
 		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 	}
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 309fe0e46dad..8ce1ce72e938 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -111,8 +111,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
-#define  B53_IP_MCAST_25		BIT(0)
-#define  B53_IPMC_FWD_EN		BIT(1)
+#define  B53_IP_MC			BIT(0)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
 
-- 
2.43.0


