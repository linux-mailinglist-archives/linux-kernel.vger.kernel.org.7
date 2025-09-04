Return-Path: <linux-kernel+bounces-799781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBDDB4302D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20348162CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC521FAC34;
	Thu,  4 Sep 2025 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idlu2/Bd"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7717C203;
	Thu,  4 Sep 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954871; cv=none; b=YRCc2mea4inQQ7cO5cKsoKToswW/J6+vzkfHsW/jmfwvRoFV69rPz3LRHQdHFxd2SQecCfLdAik7CtAulfhHC0uhSXqgF9qwYWBVjKRQdCjgEQKyYsG0lSD8b1AWpoHgDh78G3ma298iz8UtGHN5E6GC5E93jgfHD5plQvZX5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954871; c=relaxed/simple;
	bh=7TEQbJVJBXCCiacnB/Yp9DMsG1Vgkh81p75bgBk/TWM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8qoDBNVO1PzUHFkohqR8EVRHGcK1FEaJ+PdQoPI2xLE74zvGiiydvw1C/ugCetZTZCBXCyfioG4NTw6c4vZ1WBAcVfOpxD0qNxL68V8o6T0SXe5zo0nOclr+dW2Eb9K9NXVgLvLPcOcRatl01dVF7vvztrmb2+nXlQDLmvg9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idlu2/Bd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-315bb486e6dso502859fac.2;
        Wed, 03 Sep 2025 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756954869; x=1757559669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHYoZy1BbbBb9vcfhdtPl15TFAqdbk6Ii/kfuxxPco0=;
        b=idlu2/BdBVNqQp8ydvqxyBkrlfuBZCUJG7NxlaekyTdKcHYhDR8P9ATNp3pUnY4/CE
         4AQVgazFVEAyJdCjFME4O7CYXhMHVHynsYF6o8A8HITtxaKNjoy41VMA43w45wVTvj9q
         qoG2lR7wcUs9IhLfnS19ol6vIZ51fzffaN/rrzSPEjZBwqKfrSdeO5k8Tw1VcoD9QkCY
         SYhk98oDDqe4Xir5HE3RcVdBowSjlnIzltvujifZt9v2CpD9IsbjDr7LAFu0ZsEFP1sb
         JzAuTXZMpr3K1iHgJsLsM20D6IY5cCdz/wUf7t+AQ/u+s1Mp0mXH/CK8JkHYWuGe0Wsz
         R0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954869; x=1757559669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHYoZy1BbbBb9vcfhdtPl15TFAqdbk6Ii/kfuxxPco0=;
        b=pnYPUvcUInWgTIqpTqLc8ffUrK4iHkrxcnq+kjUer2R1G+0bEbdVJP2KjiQGIqD1mm
         fMbFtk7SZK1JXQIeXTfKpeBIjFv6GejLHpBQGiGsnfbn6hbDnMywHekUwZDMI+0SpfzN
         1gyubsl0ArVznvbKG6Sst6YBK34K4Rcux9gwChFrEJ7ZsWynLEOb+ls1a8uM6cbvN9Gu
         tgYYGp8Zw5YNBNdu+noF+3i1UrcgmwbuCl5D29Qn3Eok8c5+Ntk2ESwgJXoGSnhyg+D5
         ORJgU87BnEpBL/zeSE6YDky5++HZ52OYWitN9JLrf/tASHOzb6qcKJ2KBFrEe9Y0kCIB
         Usqw==
X-Forwarded-Encrypted: i=1; AJvYcCUx74TT5KuL+UpaTmZNhfLbpfzmbuBzI4YLxsqS+gZcvhwKe9PwLOAnYSPqU2vy2nGdwLr3+MAu5lI6eKPL@vger.kernel.org, AJvYcCWQubWCiu6PiL71anLjrUvXKCWlkb7pPc0pBGfpWPQfsPZDG4Bn7y6+Ae0gNu/ZOlpwt04b29AKnkV1@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRlgpcYAc7Huh0jFMuV08ICIdRZjwx4kWRsBAIEHSfDDR9w3z
	pdIQLnFebm36Cbzex011wTzwkAesuAD7WVJGBjWJrEtX3swjgdkVuphQ
X-Gm-Gg: ASbGncsv9JEGwzscg+4P1q9Y16S72ATIV5NjOfPqhLH6ma2tieav2r6BtXp2hc6eCI4
	Dp2StRL7z3T+ReKiYWOv2k7yn/PelOfSHgNt1ssNviHUh+OApQ216MOLWsKSXnR9tPZi+tv8kJs
	gj/WqyT8B4Ujt6l1ME6C0MPhxmu0dvlVkiEyH5F1DPYqtHba1ypuGXfepwtM2sGw51KDhbKsEle
	wG18QMqWfJMYnid5GFMwxug4GSNPoWF5sR9OAj+faC5KvRlr6Cgd0FIX0uGeVg/J14+5fYXMbQn
	4vmiAf9b1vtbzT2P4eN382N0EvMSuB2KIqTCJbM/Xep86qQut9jhFh/0MRG+YKdlmhHwfHBYFAm
	n6g9LC7AQfm8ViHtV+GJCCJAmWbVMPD7m
X-Google-Smtp-Source: AGHT+IEeO2nVtWYZaHo8wP52NN3KXbpMpsy1+TD/jG7mcZ7sL45J2EgJViHSBD5Zz1bzVMdn3YTMAw==
X-Received: by 2002:a05:6870:a90f:b0:315:9e4e:4f7f with SMTP id 586e51a60fabf-3196307efbbmr10158685fac.4.1756954869501;
        Wed, 03 Sep 2025 20:01:09 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319c704f44csm1327722fac.2.2025.09.03.20.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 20:01:08 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v3 2/3] riscv: sophgo: dts: sg2044: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Thu,  4 Sep 2025 11:00:59 +0800
Message-Id: <c38b9b1682af978473705b7e70b6faaa36fe5024.1756953919.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756953919.git.unicorn_wang@outlook.com>
References: <cover.1756953919.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Fixed msi irq type to be the correct type, although this
field is not used.

Tested-by: Inochi Amaoto <inochiama@gmail.com> # Sophgo SRD3-10
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 6ec955744b0c..320c4d1d08e6 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -214,7 +214,7 @@ msi: msi-controller@6d50000000 {
 			reg-names = "clr", "doorbell";
 			#msi-cells = <0>;
 			msi-controller;
-			msi-ranges = <&intc 352 IRQ_TYPE_LEVEL_HIGH 512>;
+			msi-ranges = <&intc 352 IRQ_TYPE_EDGE_RISING 512>;
 			status = "disabled";
 		};
 
-- 
2.34.1


