Return-Path: <linux-kernel+bounces-870071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27164C09D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FCF3A6BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FD301022;
	Sat, 25 Oct 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Lvfv4o"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508D2FFDF9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411980; cv=none; b=jHSqSPk44EODOUbe0NP6oFVf5lIsrkmoasIuHF8iJCjVnhnM4clR9NeZSKi9zXJ44bfRiBOpgqCXemXNSP9DvoCofROfxQizvE7jNbIIDseD3FICIrdaT//aEXqgImQUmHf6ie8cBwd/sgfmkTIms72S9E2Tt/Vn8HThYAClNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411980; c=relaxed/simple;
	bh=XPoMqDwwNJLwd6t8oOPZg8CGm6E3Kw7Z8uoFKk912hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3YflXO75vd7tmIXJ0lPooty5aCg0x4+CapzTc3HfN5PVTDHLkhJOps+/NFpSZXgrLz9PAZDxdm5V0yVgo7pQ7Li+R4G4GiHL2rQeyabXUde6AtnB0wmlU5X83psAyBW3q1Fg+2cA/osHTlVqUuMzRD2Y8JOBVS5wCxFVk3N0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Lvfv4o; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so3059986a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411978; x=1762016778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=h7Lvfv4oVmgMuQCLnbxUOz36SpE45JFOCd3yan6OQwEPCFfXV6BY+baecVkeuQgSdC
         mBfK4Ouv5JsYM5kgS/QWAL8TQcqO5pbN5I3hSBlnpQUmmzbnQWQvwj2HBtHTde4Lp4g3
         b4YVxEV+NKoMt7pYK5pLIHEC7oCtEXg+sKa4oWn6MAofJmw39fJmLR4ik46fM9EsUWhr
         eQ2mla3AB8U66e8SGZWWoBqQeCMUy82r78NJAmOlnY7tHuGHimBKrcs06oOtUGPGHlA6
         ujemapTFrzznxc+79y2PVYrcg5/N8Wpw1qQRkqMhzz6UyXh/6goeVhtVnJz6p4Z0YQla
         JxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411978; x=1762016778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=pqgz8kEa6Drqn9Usi4WgJOPlD/jm59qMGQQDBCsKwrUKDvalO/B1vwSvV/8MN9slTj
         83NOoibH5r0mwfVccCRjoQQo+dsWmNPMVo8alEXFj4ClFW9+7ToJDwm55FVUk1mZQKQM
         IQm3szTEgG2ZBDwTI3J9VmDrVJeuTPZmme4M0onGECh8gR6rdr0lIiwwWpVvAJlPUscL
         yL9IORGZxigzEdTjpOjZCdxR/Imzky3mNw7B5NX6Zvo1u3bLmtU0pCg9qGfTOVc2GwOp
         4RgQ1Sf84Nkzrwe+Z8A/7dB1DhBMHG6TRjWqHaZM0PiAN0dAc1j2hJF1tYrgjRBqOR8x
         LujQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMUm3RUnCPuFOu9Ln1FP2fcNBprif8wuaW2wC2LsvoYQw3D3hymHX7RdDvmIV+R3iRMrMFtVYtubZI9kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVw9JobU4l8AJ55HMuXxEv1aGl+QFoNrAndUk7oMc6Se232LC
	egzeccY3TGlys2oDY9wvgp7aR2+8gWCSDBwOdWcJJ5iFELok9FlBMqKx
X-Gm-Gg: ASbGncs9amNPlV3N/49RN2fxP5p9AOgwU/E+1+qQYwoyvwEhhltHur4f9cly39omf1x
	bIxtGcFFc0zntgrRXnm/JVzdc0Hv0M2SKx+GlhI5S4hveYBDoiXQTflf4Z4sV2D6/eVz6YaiTNC
	jP0BfdHbuoQ40TeQYtc16foEIlNtlu9BIgzVjyp3GbPXPqTKgh2numq7+JUgYXC6IoF2QreXcqS
	ibQAteJ/PTuBFvtR43vhjEO8c9JGSH+XrxuiRpaXE4xzadrTWiWv2m+3afLRAmGVMMfNRi6qgNC
	x+zI3Jj6+o3RTb+Ec7B0DBzzE7zpH3pnby1rck6Govzd28L5w1IEtyis0aNO6xtyrIvr25lyZqX
	qZcMRIBs/QFHH19xVV102IvD491Q6zCyE8GXIVnwjDNF9vKXEtQ8sg80SGp6mKVewsVysnLvEHt
	gbPQyoCpQxwGOAGxtFvg==
X-Google-Smtp-Source: AGHT+IHcunpgm/kUmSDaDAkhbrYQGDPGWnTI3si/TQgkka4BpRb5fy72VcvUXELVm0ssffWlf6x+fg==
X-Received: by 2002:a17:90b:4d91:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-33fafa65affmr11410120a91.0.1761411978336;
        Sat, 25 Oct 2025 10:06:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:18 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
Date: Sun, 26 Oct 2025 01:05:24 +0800
Message-ID: <20251025170606.1937327-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025170606.1937327-1-mmyangfl@gmail.com>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
macros use unsigned long as the underlying type, which will result in a
build error on architectures where sizeof(long) == 32.

Replace them with unsigned long long variants.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3e85d90826fb..85d995cdb7c5 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -328,23 +328,23 @@
 #define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
 
 #define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK(50, 40)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK_ULL(50, 40)
 #define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT((port) + 40)
-#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK(39, 36)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT_ULL((port) + 40)
+#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK_ULL(39, 36)
 #define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT(35)
-#define  YT921X_VLAN_CTRL_FID_M			GENMASK(34, 23)
+#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT_ULL(35)
+#define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
-#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT(22)
-#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT(21)
-#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK(20, 18)
-#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK(17, 7)
+#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
+#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
+#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
+#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
 #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_PORTn(port)		BIT((port) + 7)
-#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT(6)
-#define  YT921X_VLAN_CTRL_METER_EN		BIT(5)
-#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK(4, 0)
+#define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
+#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT_ULL(6)
+#define  YT921X_VLAN_CTRL_METER_EN		BIT_ULL(5)
+#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK_ULL(4, 0)
 
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
-- 
2.51.0


