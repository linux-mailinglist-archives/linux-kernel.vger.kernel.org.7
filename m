Return-Path: <linux-kernel+bounces-850869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB8BD4BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FB4027A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9430F52D;
	Mon, 13 Oct 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsWEYKve"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E430EF96
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368826; cv=none; b=QjJUKPM3gDL9Ze6MOSE+s5RPWTl47/qarpyPikYY36u7GRzzRr6ua8U0BrVZ3w7Z9R5IslxUIFb7ZfsAzEC72qHAsL9c1wAfeLchgIoew9NTZN6FklvU4BxNgzFaQyy4QKpLPHNXlIoZZXFJJaEngiayno2t8AMFvKR1NZkRzDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368826; c=relaxed/simple;
	bh=K8AAoiZgUUO3ges/u/HpnwBtA9qJAuWVHK8IuNIXlO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBjshjMocJ86ry4kheuqajB5gf9lMyMcPjjfbv0beGVzNAPaYHkZzAfcYQk2IoqaIa+6qxwYpuTMgR+715HoqIQHECS6dyJWe2yB+PamkGjdEMX5RI9CHXT/+o/LFl6IBaKnakrqoVMZIFeCVff6ebVzUf++CTNYRlBUdgTWTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsWEYKve; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f8986so39794335ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368824; x=1760973624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWw3pYmfnmGvB+YkCO3yexV5qTzE3+kQSnnpQTIm/9c=;
        b=KsWEYKve4jnlMMghMmCdHKeR6bPWaFg9Rie1liX6xmaqEy5hZipoUD7epP1zwOB8Qz
         u/55EWfveLK6Coiwqw0QrGC5g+/d6w2z/pP4+oGHUiGebaMLTm+FUGgpb2fpcIwEK7Mu
         Cd2SQzZHtQEVV/DUgXJdzxxvkGb5wRUFm41sLNY7FJO0GYdJCNdjs9Ijel+qHh+lFVFW
         zApu47h2JP3DatNadGziTJ9DGpcaLXBqUt8oKtrXw4NH8c22WBkxhl7Vf8LtIXTvbO2N
         z/opr0sBlO4ZIIeh0e8rYzSitv/TuaRTuL5PtnvKu8PertUf8uyt7DgNFonSNqOxtLlA
         JIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368824; x=1760973624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWw3pYmfnmGvB+YkCO3yexV5qTzE3+kQSnnpQTIm/9c=;
        b=QsqdZ2EvXcqo+Ug+8H5rRfuwfweVuGafJtrd8Mhj2hNWzlla4EMW76qOMsZ2Hh85Bf
         2O8ye4FjJW5dVjHq9VpXevPVKaWLhrw8FHKVvEYAw0AF08vrXrGOzYh5sfbnx/JZj+75
         Ygu/59ZEI17r9TzkYDtVziJzMQkGVcrFfMHWBxkB9dNz9JtMbjrNRRCKGp2SP9tXsCVY
         ARY9GavCVMjTD/9BLrBl4z2qPLRCwUHG8zJL+SAQ5OwXa0zXhIoPG0ruT6DHbVEZ6Ypw
         5vnUKIshW6vxfgd0RXa+P1FBv9wJGERNh7UrseYvyiGi5Zt0RgqOO23qsR6x4Cny3EJf
         hyNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKlBYh2fuXxufh2+czJVYG6znoJ/lkS921DH8BXlApzwsebo0TnK8CyMo6tZThn/gJIXt+iF3G4Yj6M1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxE8Aq0aS1QcZzsfbIUdPeEIKRYz2VnZ6ae13hLSuGblNV4fH
	ADMiCnv5wpwMPHtHdQxiFrD5m2TZgccMiepY/oH5kiLL9vQ62F+vSyZ6
X-Gm-Gg: ASbGnctwd+RBNzKJhOxt44/euTA4fH96hxMMnMM0+RjsEhhUEQOK3v96XOr/fUngMLW
	Eqb+nCOq8V0WW+4YExWaTT8zHBx+qvZ9awSDcXg7UPnX3yraUqxEPuWI+jexNkYkZ1AN3mkZPfo
	RC0zUKxBbtKztix/dNQ5MbWRxzacyY45Q9Ms/Wm2jR4aJn2nRWeZYBZ3i7H8QSO0AwICJrpvm2r
	MV9j+VoFLETpZRVRxbi5e0pqb1g53bm8kMsWmD06s2HcMNscKhwfNTI55N43oreayTskRk6qqXf
	d5y7GwOKMOaNf3wN/1T6luS67ay4da+Mh2wZWlVrRJIM8huLHDERfjt0C3IwhpnkveW9R6Z1Cve
	jhpcfefwJoKVDeJpJtgYBS8NiSWDs3xlcm6jhS5baSj863EUeWQ==
X-Google-Smtp-Source: AGHT+IED5HSARgZp3w1i5vJ/5lba5zHCV8vbpThYRazELMLhgYDV4CSz/po8MO0H+ROXoU4f3DVC/w==
X-Received: by 2002:a17:903:3b86:b0:28e:7567:3c4b with SMTP id d9443c01a7336-29027373b18mr314146635ad.16.1760368823921;
        Mon, 13 Oct 2025 08:20:23 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f05bcasm136560245ad.84.2025.10.13.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:20:23 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] arm64: dts: rockchip: odroid-m1: Add pinctrl for I2S1 8ch TX path
Date: Mon, 13 Oct 2025 20:50:03 +0530
Message-ID: <20251013152011.131118-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable proper pin multiplexing for the I2S1 8-channel transmit interface by
adding the default pinctrl configuration which esures correct signal routing
and avoids pinmux conflicts during audio playback.

Changes fix the error
[  116.856643] [    T782] rockchip-pinctrl pinctrl: pin gpio1-10 already requested by affinity_hint; cannot claim for fe410000.i2s
[  116.857567] [    T782] rockchip-pinctrl pinctrl: error -EINVAL: pin-42 (fe410000.i2s)
[  116.857618] [    T782] rockchip-pinctrl pinctrl: error -EINVAL: could not request pin 42 (gpio1-10) from group i2s1m0-sdi1 on device rockchip-pinctrl
[  116.857659] [    T782] rockchip-i2s-tdm fe410000.i2s: Error applying setting, reverse things back

Fixes: 78f858447cb7 ("arm64: dts: rockchip: Add analog audio on ODROID-M1")
Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDMI], device 0: fe400000.i2s-i2s-hifi i2s-hifi-0 [fe400000.i2s-i2s-hifi i2s-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: RK817 [Analog RK817], device 0: fe410000.i2s-rk817-hifi rk817-hifi-0 [fe410000.i2s-rk817-hifi rk817-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 0f844806ec54..442a2bc43ba8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -482,6 +482,8 @@ &i2s0_8ch {
 };
 
 &i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_lrcktx &i2s1m0_sdi0 &i2s1m0_sdo0>;
 	rockchip,trcm-sync-tx-only;
 	status = "okay";
 };

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.50.1


