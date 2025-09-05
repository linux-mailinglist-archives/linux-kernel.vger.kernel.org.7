Return-Path: <linux-kernel+bounces-801954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87997B44C09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3175816BC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192FF2741C0;
	Fri,  5 Sep 2025 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3OO1c7s"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91A257842;
	Fri,  5 Sep 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041048; cv=none; b=LnF/YJsjk1PE8o4ylOEHLMixfqyC13NOAPPkHEe/0R1SuMCDBxVgOOOh1Qt7odCztovx9JnpKETjMOscqAbTIrr0MO0h1Flwf1imP3UtyqI4zoUgNx5TdnIcoAYB/ILqiVCFipdQJmnF9IL2RM4kpzqiZKNZo8Mku0S0G9E5bLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041048; c=relaxed/simple;
	bh=0VwTyWOUqhECsbxWrb8mEhSwPQ/PCTbYnsNk/+jMRSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJxljq4XWLmGwH6soTdt+3sCV4t+CNQGvorLzBcHAnJ7RefGeUwcRaYpQfsxbWJ8GcqfxzmNi48nPt4ssfnSAR5v6HDKdg9KSYFNtDH+ISfMrFdNteEymS0abnN5Q120siYdnRvZ8LRjkJJl2BjpZqBsOSVLXZG77ObmjKyYQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3OO1c7s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32b70820360so1354323a91.2;
        Thu, 04 Sep 2025 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041046; x=1757645846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfJfdss/38RSY0RTrYoaMq8nr7FJ7yMCmd7sDXOBIE4=;
        b=j3OO1c7sSO2794Yo7Nq0/0hH+8THskV7WbPaBM0TYIr/sFT1z8W3YBTDEQNrf3HxIW
         Tw5tDNz9t/f1QK1fKx1bzkUDUVinYmz6+3ZK6MDhHJJ11Jy8QrGHVe5dRjVf21HplFTx
         7dnD569E4IddFkXf3SpuVnc8Yxd8dCayi7CGpUAtf+yrr+eJavmc2Cv1+kAV3hRSfkkc
         jd5VBO9k/LJ12ZKUO0U0PTlhU35hqxqy6Yi1cuRNTD5MSfyclNKlPVPPDooetA3ZTTb4
         HrkOhwRcoIZ4a5M5vGPncHgwI8WX2Xy4u+NvAkSlEMphJXlM1BeqV3XECxIUEifDK6tv
         illg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041046; x=1757645846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfJfdss/38RSY0RTrYoaMq8nr7FJ7yMCmd7sDXOBIE4=;
        b=TqpbpWDQqUTAJrZ8v6koc0XHCmmIlYFiB/t0xiARleZi7q/1llmBfAycfbUwFVC/VY
         QeMrScgIY2FNIdmkVGAnCEhZWXojGgRcQsfrTDIfP+QZm+XFFJb96xmkw17ezHsFig0L
         tICTc/OsUQNdLq2XeWKkebiC3L8WC5EeFSthI88ZZtxLTjVDaiQjB3f16g1Svl9NPxY2
         rrNHr67gINAu6ty08q/EcPPou+IOGrY6WfTWQfLtXjajdiVV6BJ33vMpJpIk8hlneqWo
         jr1gM2uJwzSbGlucnRoGzwR+BJtRW1b5yhTdD+y0om8VMhDpozGkgOY3ZSeX5ELbx9nM
         LRnw==
X-Forwarded-Encrypted: i=1; AJvYcCV8t7zlardGyRx0syOvsbuigrDFupqZqGmL7ghhz/EuuxVydgQ+LVbvwivD9Wi3F7/nzHq4xqC1A3+s@vger.kernel.org, AJvYcCV8yLxuXDXsdMO2wqoSosXRZ3t3jyaR61I6bcxo5jYif2Kq8Az54TvZ3ZvJTH83g1e8JcxKejPSUxLc8nN6@vger.kernel.org, AJvYcCWp/oX7FGurUNUz6znQSSWcuPIS9A5udtFXp0gc2dm+6JdSz6zmBex21EaT9RysxUtBLJ3Qu53Av5IX@vger.kernel.org
X-Gm-Message-State: AOJu0YywwniBL4mVOHktAJAkFY9+blCSdCiI89Oy2rNAGI+nxJjglPui
	ul+PBtBdR8C0jutjxCjVFGPXq/ZvZ+kT7bjp74+RqKQDPSW/pPUhyHG1
X-Gm-Gg: ASbGncvdd4jhILs0rdRgU/ukfWcE/58cwemPdjKh11hUl7h/elJ0mbWYcdxZtOmJ57g
	U6uJPZyzGV84GAZ2jhCYnRQPpZ33wTvBqCVAOaX7Fy+nhFa5LSrV6eUSHwhc9tGgS9gyDmvgD1W
	eRP22h3+sMpN8hV5ICcBeFK7dOvA7VzI3mgVVVA0jcMMiPTSeiDbvkhfDKVDE95y+wnhggy++xe
	kpaAsEKAIGHTP2pDAJxmOMk3s7LOz9YDanY6WhKmfTHAD2ZW62zMPD82z1otpwiEgrISso8ktYp
	Y3Nj0yx2lV7Tg5mSxU2hoam0TdeIa/q6XEaMf7tHcSYUELotpNUrg8uNfvhl+NDX/3MijLNKodw
	Pup+MFnmTtfrzStZa0/jKlA==
X-Google-Smtp-Source: AGHT+IH6KfxiNdSMUP/BpJqmlXaqQA2mXpzUuB8LyWMLU6lfm6qdp3trN+zpO7M53Lc1wJ4tYGO6hQ==
X-Received: by 2002:a17:90b:17cd:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-32ae706be21mr11175451a91.11.1757041046306;
        Thu, 04 Sep 2025 19:57:26 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:25 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 6/8] arm64: dts: rockchip: Add D-PHY for RK3368
Date: Fri,  5 Sep 2025 10:56:30 +0800
Message-Id: <20250905025632.222422-7-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3368 has a InnoSilicon D-PHY which supports DSI/LVDS/TTL with maximum
trasnfer rate of 1 Gbps per lane.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 9761dfc88..60e982a3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -883,6 +883,17 @@ vop_mmu: iommu@ff930300 {
 		status = "disabled";
 	};
 
+	dphy: phy@ff968000 {
+		compatible = "rockchip,rk3368-dsi-dphy";
+		reg = <0x0 0xff968000 0x0 0x4000>;
+		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_DPHYTX0>;
+		clock-names = "ref", "pclk";
+		#phy-cells = <0>;
+		resets = <&cru SRST_MIPIDPHYTX>;
+		reset-names = "apb";
+		status = "disabled";
+	};
+
 	hevc_mmu: iommu@ff9a0440 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff9a0440 0x0 0x40>,
-- 
2.39.5


