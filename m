Return-Path: <linux-kernel+bounces-746753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AEB12AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710643B861C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943BD286888;
	Sat, 26 Jul 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwG3HNCM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E0376F1;
	Sat, 26 Jul 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537970; cv=none; b=b53AT/r8X6G/Yr90j8LiNpYmZ2wa+d5JRdFTb/MaHY80gecIFfq0F+1kq1juiFMyPTOzMnJibug8BeCoKJSAaPEmLfrde4nmrH1eh7sBz5sFknRl/BtDM9mYAoyTD/A54/1I8DKr6EypoCsqC5Ldg3iEIRyjpp2COVlgKlPQEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537970; c=relaxed/simple;
	bh=lFuPyRoz0shNaVNJDvmrl4WZAKtXA52saGklq7aY55A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlmtihabaziCfiJ/PuOTsZ8RMIBqcWIlkz67oZZAogFnN+Hjdm/VaYDMK+KVGKlaweKl5nF7W1vcKBjQuyALeGMWQsddSC56tGsnXqF/ZOvRpnSP2kAJ6K1M3LETFLxioekx1DJSq8+fUVffXd9bIPTq0yfeOG3hzKJCRXMDBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwG3HNCM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso155111f8f.2;
        Sat, 26 Jul 2025 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537967; x=1754142767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7gsK5t9my2KIvz/yOtyIav75bvnwncFskC7xHpOTE0=;
        b=ZwG3HNCM/5i++UHJHKzc8Z92YoxB15nAdj3rPiizG7R2m6BJkPhhofJSWUEWOPMVNF
         vwfADQe8bMfGIuzpBuXc1PDe4J2SPwoMqpKUEhBvDSuoKeDVIdGTAO6/6egNtEQL0RZ4
         /JDGqkrSXHTFTHOmKX5Yq4mLdVodZnJqeNSkegvQmPAbS3+Z117YbZnTxgighHyMXHCp
         8tl847ROEDLLqisQ8M5146cfpoUgy420xDc2/S9yprWPykyz8ntDZl5zG+Ask+VjL7yN
         QjRzAj+d786GxPsZrCE372d8hhwhbW5L174EDldUgDLcCdrKkkf8S4J6+QN32DDKmjf+
         W4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537967; x=1754142767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7gsK5t9my2KIvz/yOtyIav75bvnwncFskC7xHpOTE0=;
        b=J4Comly57MN6HeS1KzhoVNAHweZLB7f3DF46uj299DPZI4fWwGN8PxtPE9LOoLZAH+
         vviWfxMr2DPGVgHYPohOtKl6quf7POY1O+Jk2nxesBO+iJ41wQ7N0EETlKsV9FaWds36
         2pf/W1MG8aRIXJzKReEvMFarRbq6ZbNWQtYCmbCYhTVcR4qhob+dttna25AWqg/x5IUi
         7gugF23IaT11NRApgYKci2rHGlPhGkLvYCfhNibXwPzTtZtthaV/qtdeKHl5alMtfT6Z
         R0w+R7RYVslWZO4sD1c8D6IJh+tTttWctor6Ip3GtTfoiXjG0zV8AnL+ruR+6/V2YpHl
         xNAw==
X-Forwarded-Encrypted: i=1; AJvYcCWMbRtBqUQRkwSyeMdOciwnVGa5/I4EFpHOvz1oSQOIDEuhpqfWspE6TIgd2q3/hSFEB3nvKqHhhxz+@vger.kernel.org, AJvYcCWlYWrdLxZpnJ3tjaBOHevfEr/jspz4AOaoillgDnDAMKVuRKVAUSC9PnoRAy8REAb7ChRVWoVMhw1A+QNA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89fELBCpaEGPJkZPQQew5CE0vbuzX7D9X4yZAq+xG3qR0rwKV
	DC643QkyWGDSYu2MTOOwy4Du1NNTa19MgVKiFpU4PSSDZ4B0NCbJrEMMVIPZPXdHr94=
X-Gm-Gg: ASbGncsuxxIGMK+JWYmmwf6oh3Hxla9ds/n7kBCq4LFNb8ZYfhDVbBv/EOWIZu2j0qN
	OKMFdRA3vxBGFgAgLyiBYFv8Zt+9fbDxN26V+xEz5tlbDX4l2UxiCMIaFyZeJ19N/iK72+wqVqh
	dmSdPUiYHOnzdZBG6Q2/DCT8Oo0gdMSTUXE/ThZMl9t4C0zOYpbiv1dLc0RoyGOhjrPsVmi/nPe
	2xG4mz4hXDi8OkHWXjkX14K5QlIv3MZXbRlMUMKIiu0Ys/ZcDYcvHBSUnZudbSQX9HktsLEmeMH
	GPDul6iDz5FMZqp80MoGror3gelp6mFwRrl0+hcDUAh8VXimPRPc43hNFzbeqo6fy6aTzOPSI6i
	70OVd6XZEIcDVWmLCwHCGLit6PJdvEpDRkQ==
X-Google-Smtp-Source: AGHT+IFG+VyHIVOEUPTiiGdkm5FQonRW/tGNZ4tdFY0Z5nZCHqWSoyx0C46nntZCO+uU4P0jgMQ1Qw==
X-Received: by 2002:a05:6000:178a:b0:3a4:e193:e6e7 with SMTP id ffacd0b85a97d-3b7765ec686mr1949229f8f.5.1753537966540;
        Sat, 26 Jul 2025 06:52:46 -0700 (PDT)
Received: from gnulinux.home ([2a00:23c5:a31d:e401:17e9:5a63:c6ff:e542])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7811b82c6sm1184625f8f.49.2025.07.26.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:52:46 -0700 (PDT)
From: Harry Fellowes <harryfellowes1@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: antoniu.miclaus@analog.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Harry Fellowes <harryfellowes1@gmail.com>
Subject: [PATCH] dt: hwmon/adi,ltc2991.yaml: fix typo in shunt resistor description
Date: Sat, 26 Jul 2025 14:52:26 +0100
Message-ID: <20250726135225.3018-2-harryfellowes1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected the misspelled word "curent" to "current" in the description
of the shunt-resistor-micro-ohms property. This improves clarity and
maintains consistency in documentation.

Signed-off-by: Harry Fellowes <harryfellowes1@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
index 1ff44cb22ef4..2210764a81bb 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
@@ -49,7 +49,7 @@ patternProperties:
 
       shunt-resistor-micro-ohms:
         description:
-          The value of curent sense resistor in micro ohms. Pin configuration is
+          The value of current sense resistor in micro ohms. Pin configuration is
           set for differential input pair.
 
       adi,temperature-enable:
-- 
2.50.1


