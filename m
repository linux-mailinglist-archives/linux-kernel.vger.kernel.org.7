Return-Path: <linux-kernel+bounces-891708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFDC434DC
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647963B18CD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13932848A8;
	Sat,  8 Nov 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kaTCmhHs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AB21CC51
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762636529; cv=none; b=EkEV6JBw6qSOjTdbDbgjErqfWpVA4cI1nITjv9O8/WfVfxdIZspecpt/akJ4PmfEFTw8b+yLQB+reRzpIABdeD/vzwAROy1ulNOb7CrI2Lx5W5f/gIiSvDR18rRon29ZwJ9dlFCPVL75k3riWoC8nUujf2FA/HYTz87UkNUPgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762636529; c=relaxed/simple;
	bh=DJH0FRQQUZ6Updyb0ntVzpcrwPjqdx0h766mMGOKd64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=it0A04hSVAbkBo80/XNbMOqL/UlmMQVpnpT32IuvxpR0hoJardTWH+KjZYCA/1RG6UB3D4ckPO+sdgsn/1G+mqJsPHmQ0SNTHeK3DsR7LZmPhnWo8mT4yjk7Bxwu4vM6K0shchW07+OTj7Mlgi68PEx0/vOEhhcILiTXOk4wzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kaTCmhHs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso795236a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 13:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762636526; x=1763241326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZgY2Y5BzkIraCasJSMFe50CTMRyvNR5i+L9TZ55dRQ=;
        b=kaTCmhHsNIRvZeo5E/R9/fHL2GSO262ZD0Mp29IPAODbqNe+6lrj0cUolDIdtE42dZ
         NIPwrJIYRJoGMVHoUEPkDJFPhGKWA3GTNkDbSNdTGnh/r6tAl0gs0JonbCCw+CY7VCRT
         hxAOOfyOOH8RXoda71iJaDcKdd3vB0bzda2J7Kx9mlieEsVXj52iAF3WIwut2Nwg1eqL
         QzeFjgbmkSYRBI1CquexRzvSpOO6JzZmXIopH1djR2pMMBdiF9cOEX7UsBplv2fmFNvR
         fmyOFRgFvzOnO1gebzRpFJhRL1Z691D9I72XfPX2TCSrl1f9bwZ1iIjBLBPS9n+MuAos
         xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762636526; x=1763241326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZgY2Y5BzkIraCasJSMFe50CTMRyvNR5i+L9TZ55dRQ=;
        b=AC3Z0zW8haQlixaIh8jYEng3e/csovpd6UScCpqmoDbLjjNX5gQS7HfLsp0vK5a+MR
         w5pL7wJ4fDQe7ygBGHHPYVdWHoUbD4ogREn2RRojSmXwV9ztySZKNZ0J4IfJWsEv8+YV
         ox3iEo0bh+reW74EJS57pBVmhEoijEcGKcti0JIB6moouexQDDgMl+L+fWaQkXaGNFTH
         ZiTpA9F2oAl+e7dyVjTsT32wEYNulY89m/P0A1j1hlcLGGkTrMnha+04kRd7yU52rRf4
         +sHA4VhTNMsKlxzr6ELTaY/SPraZBLLQpT4UzP5rqVO6LwZ3kGa3cfCyvRfO7MLmD6rO
         6KJw==
X-Forwarded-Encrypted: i=1; AJvYcCVmoo10ClqhlOZQPB5ZFmixFxv4G00sgdxn9z6hnM6Oqa5iuahF9hpCCkrXpiEXyjQqwGNNEtwqz/8jBJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmY4+ia1+n0n7RCKqR11vVw6Tv4LPEVmfa7llGReZb6TrrZ3wF
	H6rvrJ8WA9uCd0bLVKbyWfY2c44nXQrwNxn1FChEhmE1PCyFa5hPnQYc
X-Gm-Gg: ASbGncvrDQMDN2PyVIa7iyNTq/CULgzCY+aEYORHE3M0q+If9f/pPT0kdyxCSIJF81K
	ZKSru0o5dyijYPauj63YVBF/PVti0t2kGGhqKaVOnfsHbE7vEOV/4myNtw7B3k2OtE3KRMd4HBU
	OroRAO8iomQ3yAjySdPoyZhu66lXMeRVqO48yr/SkeJUnZSpTqHPpjW4O6J64l2fW7u7e94RqZt
	L9F/pXGi4q0OmLs0n4+OrufHoWLFrDglI62bCvO7BVgV9f0odWBR8gHX+RcvJ3pQgboJVVJfb7i
	vzCwVa25yqgDiiPj2MCo4O4JBUor9MS0aHTnzDwKgOByALJSb4W/WQOODa/tkN8uGKF7VH5S+c+
	k3Gv1XNDXi4KBs8rrzZNDBCCT2Njh2V3xxiUlRgQV2p1Bd77WMoV7gYG+49FXWjgu+X32fhBIty
	w16ASzXpwRe+oACPh32nuTvsUSX9cVRTks9YFNR49/gDcB20W8KTivbMe2EtLnsEiNsKEaH+T2I
	iI+J5bKjJgEEqPD0cfNUSb3QN7I85lm+QqkC/34l2o=
X-Google-Smtp-Source: AGHT+IFDQ1XE4DMnxHGoDNAOKOn2R9RCApPoGixxW18C4L6aTC8U7/yf3/RbX4oWw9F4XY3sUBF55g==
X-Received: by 2002:a17:907:728f:b0:b71:ea7c:e501 with SMTP id a640c23a62f3a-b72df9055camr438123966b.4.1762636525488;
        Sat, 08 Nov 2025 13:15:25 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm625110666b.22.2025.11.08.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:15:23 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	neil.armstrong@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1] ARM: dts: meson: drop iio-hwmon in favour of generic-adc-thermal
Date: Sat,  8 Nov 2025 22:15:03 +0100
Message-ID: <20251108211503.1578711-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 85b21fdec906e ("thermal/drivers/generic-adc: Register thermal
zones as hwmon sensors") made "generic-adc-thermal" also register hwmon
attributes. That means we now have the temperature sensor shown twice:
- once from iio-hwmon
- and another time from generic-adc-thermal

We need the latter for SoC temperature control, so simply drop the
former so userspace doesn't see duplicate sensors. Also
generic-adc-thermal provides a better name to userspace
("soc_thermal-virtual-0") than iio_hwmon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/amlogic/meson.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
index 28ec2c821cdc..6792377b2841 100644
--- a/arch/arm/boot/dts/amlogic/meson.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson.dtsi
@@ -12,11 +12,6 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&saradc 8>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.51.2


