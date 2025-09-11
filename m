Return-Path: <linux-kernel+bounces-812120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435CB53339
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34E71C21156
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79821324B1E;
	Thu, 11 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY2aB+hs"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41E61FFE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596137; cv=none; b=DCPOXSwgU31zVqpdPp6eq3f082esn3sjTTvssP7ZWjEOvfYK6RggIuIvd8qFYZ2e32Twc6IsEUE28wNt3HObrAjRn1TemZw3WuN49SnPz51qLi9WUSnUKmjfBDUpLvn7q0ap7XQmgon1bMcL7gfoEzHpUvSHbwZpvE4QMdnvDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596137; c=relaxed/simple;
	bh=6tu2GgRecX6mADSNiyvsCz3mmOGNrk1CUTa+72aUpfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFvJH3YgZNzl7BeZHBI1YT7RqwyZw2rDxAG29sM5sXntodHHwrr4/5P5Gos77FLck7r7AUnRt+amUUasK/hFGtBnaFrIi+RZQyrnBkR9/Eva67Fw2hfA8W68B+c/yfy/rmXH7UaTN61UpYx/oYP3h79U0UAsooT1jmV8TGKrrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2aB+hs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so1063037a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596134; x=1758200934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYfwO6IxQ0zU5483Ah3qwMr68UquIj+n1A2JlvNeSS8=;
        b=BY2aB+hsRNgDPDfOR20w0/PWsaPbF7EN7Ak7Cn7a4XnbI7+JySAW0J0RrbmaiTQxKI
         bZqOkF/e7GAel/2O8NUPhcPey7rCTebBRnWHFzf1ajEJPJ/ajJURY0ko9FJ+62j2iiVK
         /ow/jbkI6a0WTe5NtgtO9QgVLHGVDnhUlTxrZDiMUkhViwPFAwXBg5vF6ahodHcBgOCt
         VTJsCEsqk9F4RGoQ69iTSGZIXFby3gOmdciVujcXpavNp7lCqqIAkmE2M6AsVvEmHYLk
         H/PTdVH9YMUCDcwD63iqy9vsy9XCSaYaH02OF6dDpvS77fWXT8nw5tjDVds0/EYhGzpm
         ZFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596134; x=1758200934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYfwO6IxQ0zU5483Ah3qwMr68UquIj+n1A2JlvNeSS8=;
        b=WKrVQ8/noGYf+MLoLezLAbo43o/efi9/TUNTgVDweJbF+cAQDAN566SE2KzAk5cXsX
         p8nldmkh65Mi49X6WFGfMQQXRlsupM0+GL2ofge+TKHgDXPmPfJmEXtmddtXZriDyMSR
         Fp5qLVjXqvVoRx4Ni1jMdrS1rPhKT8GMuuHYFxkr/4af7Z/eZFx5C7aei9tn2FvDS1BF
         RB+D93TycHKXajzZPGzAE5fGglIdenYnJkGz3c1Y89wTe8Bvfm6Ji+VNFt6h3d6F+g86
         q/2BvOlrmwdnko4v7Gvd60rxbdn2Q5U/lYWFuhlF1HSyrJBIB/4igE6jS6IG9nnMpsXQ
         THiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgB1fClQXTBZMBCyY6cK/8+vaFN/iEumQPPO24mmCmXgZaqXHHFN2q4BhhwoJyp7T9soNAWqxIwOG0riQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8yjGklvo0Xgdw6nG1gOXPspFyNMf/jtphVQDihTVoCpUfrYq
	dayieShpB+dEIGKtpmOi0t7Mx2Yn4NkrSn+3azhsgb0K8B5lLsll4JXX
X-Gm-Gg: ASbGncsRYgF/GsRRfNrTxIrNn3N9FFBmMUkfLcrXQH+xrgDF2g87fwTUDKfd0Uhslt3
	CJTdcjQO+Y0uCPIeOX3DsF0+T2l6pV1ixMrHHWaLyypI/+bNr6UBGGXjvOlCbMVzy+0PrWD+CVF
	KyOmJNGiybNsxQnOoxW8iepQXEO0/Cd30iFSArkckOWZTbTMQ0GibbOKNctOOF/1E/nP8CXGHzG
	PyF4vNeu/KVbNsI6XJwP+aYMsHA60SrvG3qUZC/UiBAnoz3CQnc0t7KSG1hrV1iU9l9H6H7qpxc
	MW5Ugf3oqgS20oe+NV3WsZ8lHNjHhe7eviUoxM0uKE09vtB+aiyUV10ZJygrgavko2LohhoqtZV
	3YsJN6kI9OTgTuga7kfxoDOvdPv4JUiB5T98NM5Y3e7CmgQPbDyMGXYPHyqjJGNYnWPBl/PVAfk
	W73Dh+5Q==
X-Google-Smtp-Source: AGHT+IF1qK2NqhfPfnYI/pqLXo5VsNdOwjXB+8puBwtknztnJSi9VTru+UFZzNb+Q3zjKSsNmXtj+Q==
X-Received: by 2002:a05:6402:27d1:b0:627:9d08:97a6 with SMTP id 4fb4d7f45d1cf-6279d089899mr13990549a12.18.1757596134332;
        Thu, 11 Sep 2025 06:08:54 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm1133038a12.24.2025.09.11.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:08:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 1/3] net: phy: introduce phy_id_compare_model() PHY ID helper
Date: Thu, 11 Sep 2025 15:08:31 +0200
Message-ID: <20250911130840.23569-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to phy_id_compare_vendor(), introduce the equivalent
phy_id_compare_model() helper for the generic PHY ID Model mask.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add review tag
- Fix copy-paste error in vendor_mask -> model_mask

 include/linux/phy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419adc3..6f3b25cb7f4e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1308,6 +1308,19 @@ static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
 	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
 }
 
+/**
+ * phy_id_compare_model - compare @id with @model mask
+ * @id: PHY ID
+ * @model_mask: PHY Model mask
+ *
+ * Return: true if the bits from @id match @model using the
+ *	   generic PHY Model mask.
+ */
+static inline bool phy_id_compare_model(u32 id, u32 model_mask)
+{
+	return phy_id_compare(id, model_mask, PHY_ID_MATCH_MODEL_MASK);
+}
+
 /**
  * phydev_id_compare - compare @id with the PHY's Clause 22 ID
  * @phydev: the PHY device
-- 
2.51.0


