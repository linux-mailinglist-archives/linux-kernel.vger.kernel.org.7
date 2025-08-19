Return-Path: <linux-kernel+bounces-775099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BFB2BB39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4200F1961C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E1311599;
	Tue, 19 Aug 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq2LWC5T"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FD3112DF;
	Tue, 19 Aug 2025 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590130; cv=none; b=rnRDCKMRRYuoURtMc7rjiV7fs+0WFq2jK3PnzXYquxKUGJrBlbRJ83x/2+QM0k3bqDcski3W6hWkHK1U9m9AnxzJPxnW1gpVLGc2Tu5JA/wYxy73EaXmAQoN/6vH9uUKTKRw6/iS0yxdWbzMm7Up2bSDJKdIzDBpF+/z11upmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590130; c=relaxed/simple;
	bh=UpqudjCF+oB1lBwcMFop1UyT1+UQt8dVoXwuO3KWn7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWGx3KFJt67poxzWwumt0uABCM3UD8J1ddP4motIzIEGzBtxa2ckJHzGdgDSmlI+6HfZLpXiSS/K6sfDBxVXu3UmBW96Ujn2ffIpj0VIzHHlKqC/8viQwwyvYGdqUte51QEZwVQazFOeyq2s17DjjvzP4PHqEMocpiQs0ttWMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq2LWC5T; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e67c95so5858441a91.3;
        Tue, 19 Aug 2025 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755590128; x=1756194928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5Aq+ST5cYyv8tlu5A5YNOSa76L+WIXOA4kn5tBLtHw=;
        b=iq2LWC5T1Q87MctF5uzVxyd8kKLHRP2v+0u9wZ9PfYlzIsiIc3UDO2OSIi/c2sgC0n
         coq4DVH9pe/Z0B9sTB+1tOk/xTrVKDUpPs41l9VzBMovWAcG94OurgbE2ToEJi+bObOZ
         QqCWo4r47HR0AYFHgvfnovkzbuKUN9MjUiB07qZXtb8pPAW1lukJ4NInC2ftWMy88Rr9
         GAwTVEREEGknN9p4P18cRHD73iJH8O6feRV76uAEQzZ443Bd4kxg3yRzbi4GApNmxuBx
         kgGL/PaKP5HUu+AWLdd0Fu6PMmAVGmY87wL28KbdmKa1fcCVNCVqUGz7+q/SedhcfmDP
         dH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590128; x=1756194928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5Aq+ST5cYyv8tlu5A5YNOSa76L+WIXOA4kn5tBLtHw=;
        b=vDYGAcmsdBzzMLDE+Gm+BM4LZbSmjqU8zqgLWlYbaRPBmXp6JcDKWKdBYxLbULku0k
         JtxpnH04POLe8Hf/oRDWML54E1h3R8aVoQcpWCjSZEbTVDLp6IVSQqaMHw15C5EdnxNW
         tckR3qutPQinkZ0geVk6leGz2SxFVFMw7j4/V6OLJ0PI1yhUQ5c8CdIFd+eYGVed3eUr
         zWR2uYSnT87mrGYja3ROq7JJpqFA6ds8eLO5Y72EBup6PD/iFPLQGWFeRQUyDnp2j1Kq
         0eiswbj4DS5gpwL8xB1S3Pkp0me1CrLHfR3+Npt1IRZmMbERieUtMjbfF3yfAAAQUbqT
         ew4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF0gREN9pxdMH9fpTn8/rYVhVb+2Qd7q0+T0FW2bG3dwkBc0MrTqphIkULQE4/3HA+TVfSnX/c7IisXvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYZAPkd3KvCbnUDPsddC99zUdw04QXtU2DeGFBWAvpJQ7TcTw
	bH2W7aOLtyWYrVt5gtZNCMcMboPbO4YZLdIsBDbEG5OUNxylYiG0ShKZBuWGZ7kT
X-Gm-Gg: ASbGncvjl9QYrqtMdc/MbgwVqNslbbKWfIh7dKhmaf7bJy6Vz4bbUN5+/PLdU5gK+op
	5A1W4U41wSib8Srw12CfGN7NfKBH4+rrYAldXeLJMLyMzMB67BVXKEhkzMqeb+ZnYJP3IX44gLl
	ihk4kt697bZ/f8exW3yI1nB6OJmcZxW0w+nPSeBCu+ei3n1mjFCofE+UCQtUiRkrrHv5JLTty7V
	BupdJETC7m8e61qwYgcTEJ5gfzEzr08h8OvtrHY7ewwl8Jm7opNVaS1GmoVaznhZcyOd0E3Qh34
	Qrzzcs9dIMaRtP9d06zAgA7mlWoQqGRVwsyTrvo1A9DbO9+OODAku/AL8/oyzgUVQLU2jQ12K4g
	F3Kjuc3tHSWuoVbaQYA==
X-Google-Smtp-Source: AGHT+IF1CAYew4CGA4v+u7+nVAa0yl7ZMPkqTWB83cnzs2wUTgdyhQO16uHY7uws+QlbrVRoF6b+qg==
X-Received: by 2002:a17:90b:39cd:b0:31e:d929:5ca5 with SMTP id 98e67ed59e1d1-32476a132fbmr2297388a91.1.1755590128116;
        Tue, 19 Aug 2025 00:55:28 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32330f8309asm13542871a91.4.2025.08.19.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:55:27 -0700 (PDT)
From: Dongjin Kim <tobetter@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Change ethernet TXD timing delay value
Date: Tue, 19 Aug 2025 16:55:21 +0900
Message-Id: <20250819075522.2238643-1-tobetter@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Very poor network performance is observed on the ODROID-M1 Board
(REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
this problem can be resolved after changing the value of TXD
timing to 0x35 from 0x4f.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 0f844806ec542..e1a550a04498e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -210,7 +210,7 @@ &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
 	status = "okay";
 
-	tx_delay = <0x4f>;
+	tx_delay = <0x35>;
 	rx_delay = <0x2d>;
 };
 
-- 
2.34.1


