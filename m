Return-Path: <linux-kernel+bounces-732585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FBB06923
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E011896494
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5FA2C178D;
	Tue, 15 Jul 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCxGOQ5m"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF52BEC21;
	Tue, 15 Jul 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617651; cv=none; b=Y/LT0XA2Yg/boOIcKGZyyMsV6nKQMB8Q7VyiD+UyAKJMYjOUg10DxhwPyz5ta5fAyaIQzx2gGWRlJTbTd9aIBczdRGE6Ky9/b7fuz9hsAaxoCviF8s37iQrGCudXcs0AWeOXFOjZxktWQ1B7kImWdnegcebw4dZnhAKhKSwWhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617651; c=relaxed/simple;
	bh=yrluzH45Dsn6XaGZW7/NQKFSfg+yKKSg8nN2iCt5/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnJeafM9vMgt8vCpUgLJHD4LHzNiSHw6W4S1x9nVAt3zBVZeBz35YpmphmoHgPTfqM5v5QYs3PhkyXV8X20oW7p0xbQloMrtRmxj1LNvOsMQHs7rv9eDNyDbWGilLVdTJWqL+4uARAY0gVghd+rCgkhlq95x79hCWriWUP6TdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCxGOQ5m; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso3448505b3a.0;
        Tue, 15 Jul 2025 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617650; x=1753222450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrA4TJh+BvN7wjadeOIOqG++LC6BTg9ob7hjy1TX3gY=;
        b=XCxGOQ5mtCF4YcUNFHKy9Z+imU7BnYC4Oc0HV7hvpKCSoAuUtUbBBHC52CYrR5tGzd
         w1DoI48iOrACNFQNTEDUKaSPycahYztnfqczE0LTu4OIrgwdD9Wm1vWhmoxjwoclPSPY
         wBjr7oW/Gus7ylwrjWLhJf7xsxoebRr8zCMj6Eap6Vzuh964rdRZ/lai6AsDLqXiXMqK
         Ebz3giJeD8WUUYZmoabOID9UD/UzV1ZRw0vDgMMRNKQAcyUSbAMIsj/UCwO91fhPC4wb
         dpudKxg+dpaHkqheoYG8WQr2rE0dWBupqlB7SfmcrjbbWmLnJ4dTb7atdEWGLSWpMEjK
         NmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617650; x=1753222450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrA4TJh+BvN7wjadeOIOqG++LC6BTg9ob7hjy1TX3gY=;
        b=bXbBleY9mUvJpk8CzFnLd5yaG7INAhrYiJspuEqnctKowuRyPiZWSC8djQlFvEympO
         +skVWfjOWUEukQ2ZcQ97Yotbrr4rb7Lli5Byjtr2SI4XLv/ChmlgkpYTIplk0DYx0F8y
         cmcBMQz3AQ/+2Pqkr2B4sz96/HaqMAeZuroy37eYloY3XD8gMpmKe9w49IIN4JAIreRg
         YllgFuKl7F5BbHkzR6QNO1JoBabOr+hg0fadQZ2Zg4BSL0zGPJt7lWsP+BZHCHY7Vvs8
         nL9CCJOtRI45umZjUDBIFd6kBccmyHFT5Eo0b/vh5J/QuT/ywNNyNxkFUavN1zXfrFWF
         fYNg==
X-Forwarded-Encrypted: i=1; AJvYcCWjZ5RSMB4A1aordzxLfU0dALekI+vZcn/wqdtYpyWEuVO8FakmUAjwulEJW2QimuYzASaEM4h5nXKBQ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyE8YzKcE45hh5cVD1TSNf5AdXchzh9ZrtBLBwCXWIBmL1EhI
	m5/cQ3RCh5r1bUy61dVi4ljdwDZQo2LTg4ah0tKJb1KOE0E23FlpE6VZ
X-Gm-Gg: ASbGnctzAcgC9wEGuWOGYYumylCOgft8kJrYWPq8EmJrApIav/2eZyntxLNRZFDTuq6
	4EL44fsj9h1Oi5dBIG5RJ3aGSe66wXcKpJAh9qGyCIiOwkDekfCQgc5XHU1IrJpY3N1sKlB59i/
	wHjZCpbzDmsrEjKc6mjK4tTIWNWnJ3ozIrxGvVP9H3lxTalG2DFLjvOFoAxoqf+vAx/1SoTxG4G
	zEQOlMzdgnZHAKaoAbssgxWmYPfQdqgDaPoBSpgAFdJuwn3+h3w1LaZvMv+fVhv0/nOOvx81AZ+
	QpaSWKY3r0/oN3xnEKHaVO90nvQ971+5KlcGPTrIFoBMw2d/aTcqWbfD8rwjh37ppZzIehAezUU
	OCHBBvwhcKXM75r5IYpm3zA==
X-Google-Smtp-Source: AGHT+IEsInpCl2boS1cuUEjJoih0t5+paTL5H13Al6lEbtovW6VOt0TKWUcx6UhFT5+4ihi1IP+qdA==
X-Received: by 2002:a05:6a00:23d6:b0:736:d297:164 with SMTP id d2e1a72fcca58-7572267949emr327515b3a.1.1752617649472;
        Tue, 15 Jul 2025 15:14:09 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9dd5d30sm13132920b3a.5.2025.07.15.15.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:14:08 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: dts: sophgo: fix mdio node name for CV180X
Date: Wed, 16 Jul 2025 06:13:48 +0800
Message-ID: <20250715221349.11034-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the mdio multipledxer is marked as mdio device, the check complains
the mdio bus number exceed the maximum.

Change the node name to mdio-mux to remove the following warnings:
mdio@3009800 (mdio-mux-mmioreg): mdio@80:reg:0:0: 128 is greater than
the maximum of 31

Fixes: b7945143bc33 ("riscv: dts: sophgo: Add mdio multiplexer device for cv18xx")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507140738.XRjv3G8i-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202507121830.POx2KDVi-lkp@intel.com/
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 5f094c6085cb..27056ef70ce4 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -57,7 +57,7 @@ rst: reset-controller@3003000 {
 			#reset-cells = <1>;
 		};

-		mdio: mdio@3009800 {
+		mdio: mdio-mux@3009800 {
 			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			reg = <0x3009800 0x4>;
 			#address-cells = <1>;
--
2.50.1


