Return-Path: <linux-kernel+bounces-827270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F0B91544
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C1177D69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552EA30CD87;
	Mon, 22 Sep 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdVfyIXV"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB130CB33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546779; cv=none; b=FPRBEswZc2pGcmdX3ZJCtWflIQZsjn6Mj++6CPcYXDGnBtx/5xVZ4KWC1ybleKY+ARHvX7hB8rn/Xolco/B5ITpzJlTBTzUDCj/ikC1bH4mbx386bi0ksYlUPjvq44sW7IPk7D9sbhTi/Cnk60oyE1Y6FgCU2HDohODYr0sN29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546779; c=relaxed/simple;
	bh=SAyUnJhCwMKSbhb7U5p01vudm4sy13VmR4oxIBmj0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZQdRmrlcDUzOj3vn9+Oa1PmPRpctGlkVfQu2oScwfMLmfMRKyPzFw/HGCb7A9pCrCOC94QBwyxIiIK9/6FlAAMhVC8IsHBmIPFF9uz53Yhb40fF9juakESOONVUcm/8bx7eXmVLQ4Js068Uvb34Ux5THiogPL73eHH9t0xTxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdVfyIXV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f2e960728so1517506b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546778; x=1759151578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=QdVfyIXVQgD8V8yNhNeo9v6DKyeuWl+MgNnxdDCSczYNxeL/ujp2p8PjCvFb+z9BB+
         RU8S21IyMa1tELKR2JYFTyhZiveOq0wt5vxuJh7n9agTjeBjntrIo3YcGfuhFqL6R14w
         eKunBNbsYuhzmkoPdsWEHDU4ccRKK+DGBweWYAxd4gW4OBNH85s+m+UJq5QEYCXVYTUN
         zbz1EP7XEiLxGiyfyJGuopoeg/6hC4v69Xf7Svxg2D3YlXHVbdU+4u+2I/nKkZXKFABB
         0BXbhY32YHxRzEEh+5MfKbdankBKagm68E2tPIPCbo7/p3F1KE9KhXXATjAVJXoiMDNN
         tlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546778; x=1759151578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=lCxO1KPPujUyIWAk2XxBaze40WqpC2U/YIvD6TYhzai7bGYIUwfM7PcqAXY/2B7wik
         qg1u+8WBD2W7dSmzY/RRLAUcD27hm/mHnGe/7Uaw180/XEAAp7lvEYRZIDnWd8/caJ5a
         l4HdmsEaJ42ZYkLzIjOiwDjQ7+KJE3EVw42pnSfneuZx9B1ZkBw361mZsKF6PASbbfUx
         8sOpz2gWhXijRbe4M+qd60Dj5it4BYnbzkB455MT1EQyBEAQBA7BdyZsABlF3GAuCq97
         2LIBuSUIsQTx5bQeplP6iHk3svnpDb/+QyZveI2xv97tCpE6AGcs2BfLfMs6o4vsdr5r
         NFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Vs7mUg3h3ouMismNbOLIzxJ9ZaDeYcezB0CTAlvu0lLwnR07rG3mjGEHfHd1fWVdfsGLKaAd7BdocG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA0c6hGUWeVZsq79/Fs2OdriadYenF1dVxd1jrwzEEsdY+k+5
	FV7wkIs8KsRO7tEeOsRpp0NZ4sYnkUvpNxbxk6ss93OyRLlkEIxTV539
X-Gm-Gg: ASbGncunM3xjpJEZ1uTl/Wdx5lYhtdLS4H8RcTtnyfPIy0zHfUpK3CR3h9DlCfKE5ZB
	2W4I2u6FczON2B97QrcqIp4QGuQ6ckfVhiqsqgu2XpQ4umg+M91NK2erncKn1lhgczsHHnU3i8m
	AUEE/w0by5YiaJC+gyUGqNxYuj4w46liPSflroTU9Phlfnh8F9O88/GVRbqenYKYIjDuY0x17rh
	3Bd0RjVAqzTt60CwO0yDUyaK3Hg/cWzS7saqWptW0cgek4RIh7TJohsogTB1LYrDsi/Q20rqbUC
	IB4wTRhVPW9IWWdwmbT1J+TQk3pmICnTlWbh7MdDlo48CHo9uq9oKGG2VKzrlnvwcEefjuG616T
	qsbm9JK6QXCMVSXkPbrLE7SOHeCqOAA==
X-Google-Smtp-Source: AGHT+IH6Ot1LK9QjB6FeC20glUfGDL/Gnk3tPXUiEAOeZtENxIjiU3TXsAP1et3k8LlFBwpL34RbSw==
X-Received: by 2002:a17:903:1a0d:b0:264:f3ed:ee10 with SMTP id d9443c01a7336-269ba40abc9mr164331725ad.11.1758546777656;
        Mon, 22 Sep 2025 06:12:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm130200055ad.35.2025.09.22.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:12:57 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 1/5] dt-bindings: ethernet-phy: add reverse SGMII phy interface type
Date: Mon, 22 Sep 2025 21:11:39 +0800
Message-ID: <20250922131148.1917856-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922131148.1917856-1-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 2c924d296a8f..8f190fe2208a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -42,6 +42,7 @@ properties:
       - mii-lite
       - gmii
       - sgmii
+      - rev-sgmii
       - psgmii
       - qsgmii
       - qusgmii
-- 
2.51.0


