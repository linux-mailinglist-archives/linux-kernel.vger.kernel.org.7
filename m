Return-Path: <linux-kernel+bounces-747489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B317B1346E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D637A267B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578E231A3B;
	Mon, 28 Jul 2025 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNHo7mhA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990A22D9E9;
	Mon, 28 Jul 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682192; cv=none; b=URtkgAEQSv0kucO1bmiFzw4sha2BNdqWBB29d8d46WTypGThhbeSQhtn5liuqE+LTeELi6gblAG3nI7Tc/RFsvQoc/9wT+/G4h0KKc+0gsnersobtkQpyMA+KQHZNiijP61EqAqo9OrRX+rkdtyX+kZgjOzVYHX1nfeFCfChcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682192; c=relaxed/simple;
	bh=qlhilCZGKKSiOlEPy3DmYQvC++31dQaQe8EIeK8TUxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc3H7at4Z7jAB4SQLyYUZE6PfCC4rcqutiRIp+UVIWAfH27B2jSq0tRUfHarIFdFYDf3CUuCUEHrU+ocRw9HfPyikC+0lYkY5nJdV5j/JDPEZP8Kz04bHILTYX2PPvL7tOXgwWAo9SR2/QOf2XU+ub8lGd/wYc2G6JRoVjC6mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNHo7mhA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2363616a1a6so31736875ad.3;
        Sun, 27 Jul 2025 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682191; x=1754286991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rbQVOsnj8MtiW9Jyx4x7uRijCuPdjPgMW3Or5zSI/4=;
        b=ZNHo7mhA99akNfZhaLAu/zo08ESFi23ZaKjEVMk/MPAQ3nw870xsDHgAArptbdVkKV
         jtxKAb5b91i2w3/4NIUHJxkgMYA6q4yD2O3xJTsUJW/UAZCYrBru3ZMe9zctw+w8ikAw
         2xG9Z+SOWzAFsN1LXbFHS76ox+ZxIBy35AaNUucve5QUXxKO0Pc67g3mBQL05yGCdZpI
         1xAqWC5oe8SOMrOMYSGq+bP76c/rk2W2cIMbTDztv9O9NTKj3fqPS5WcboMpaVWOI5+I
         2X6rvUWU+5IVW3u9FrYYcImQ3HelrbFAKMHOUq+x9iP1E7fpDDV/4jPXRPbk/xXIIW8U
         fkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682191; x=1754286991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rbQVOsnj8MtiW9Jyx4x7uRijCuPdjPgMW3Or5zSI/4=;
        b=S2qZurkoRMOkWZmxFTBZq7NTh89wMQck5u8tSSXGGTh+WLj/zUVeItYvYYIQnQfOwL
         RyK7aT98gPm0fghgWol6+EbuLX0JAednXWrreXavt7hfeAsrgLcqZWctW4ZuwHvag0T+
         SeYpto6fFJXk/iaIyC1MRykupc8fwR1tqrjhbx6t9W2SWAhBf4hhQ7nV+VxVvj4HlIqZ
         gSpfYPvH6z7v0WjS2M0i9KKtgtOtEAe6oLa5noVcj2bGjrXCaj3u4cko2CQkP5eEwLBj
         /jBCk+rt7fezZ8LMd2+K4LOvzd+VTJ21XB4TKBA3EVsLgpeIGIJXVpCbpUe12xTyOSR2
         2jLA==
X-Forwarded-Encrypted: i=1; AJvYcCU+6KWwhhsR7gqjr7lhUJBVX4nNYxuP2ttx4e7AHiHb7xhBNVuDAJCWU1mkaxj4kQV1iBajz7tPw0LCE95G@vger.kernel.org, AJvYcCUyg58ZTGfydZ0mNuu3Bb2tOsiXcoznA3m/kqQZXGnAWpGxs7wazgEA7kl+yejkioZGtGTQTLBMpLou@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOavE2c0TpyydDk3S8/pVqBCqu4quw6PT0LPKnSfRsZDytK90
	CwhN165OgejvxpH4VZBp1bxDWlKDADho/KY/01w52xn9/EwJEbWNgtrM
X-Gm-Gg: ASbGncvhiBtDwjgmpSufgmVFpygMUKQ3Zm3Uh+xWKZkUMunNLlxLftgkDKH3xBZvk2t
	sm5TxukQh2+Ix6Oijpi47wlG4LiTfedUdvHo3cr3PpupYxVPEuDzMB5+cP86kjrh0UmGALECtMc
	G9jN2IdY3HMVklZ4aqSBMrV/M9KMtt1L0OIN11b2NTkQ5w7k9O15TECJdiRE1xk8QaDzXuR8K7R
	x/qmlMO4vdCMDtMsN+3cc35WV3gmaM6n5UYnWmWsMOq1ORZCwNN8TucLOMhxoEeXR3zFtBpMJVo
	Sb1EP4Nug8gO4k+KmilSZ0/c8c7yqNpPb08Zkr+kvBl4oekXPYquOe/SGVQkoEcPDzz4t8GqQ83
	jsMJee4B3D1viTZm02Ae6B9HxA1u0PYc+2WrGC8GCdAiQyWc4dQSe/V0zfzM8oKnD2qv3H7UgEB
	A=
X-Google-Smtp-Source: AGHT+IEsZ+Ve7h/dSpvrm5oVG5f63/zmNJSGPRE5zLBLKub43uiQvcH1rH25UaQZkyLxvP17RPIH6g==
X-Received: by 2002:a17:902:f70d:b0:240:3ed3:13f6 with SMTP id d9443c01a7336-2403ed3167cmr11337685ad.18.1753682190828;
        Sun, 27 Jul 2025 22:56:30 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:30 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 05/13] ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
Date: Sun, 27 Jul 2025 22:56:07 -0700
Message-ID: <20250728055618.61616-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Add facebook-bmc-flash-layout-128-data64.dts (with 64MB datastore) to be
used by Meta Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2 per Andrew's suggestion).

 .../facebook-bmc-flash-layout-128-data64.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
new file mode 100644
index 000000000000..efd92232cda2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 63 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x3f00000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (64MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@4000000 {
+		reg = <0x4000000 0x4000000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.47.3


