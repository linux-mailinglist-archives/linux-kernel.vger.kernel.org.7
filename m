Return-Path: <linux-kernel+bounces-847449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BDBCADCB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55249354DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA6276059;
	Thu,  9 Oct 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPf7iiPi"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B772749C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043430; cv=none; b=rDXcJCDD87Glmoln/sZu6k50z9RHMAXACwWs9I0llk+/CcLgaDIghpH5kL8y+7XsMbgXlQ/lPgqBr+BNdb7w7pzLKB020Ckvv9Rw7sLyB+zmkHncrNoOfIOxX2CG7qAbq1PogJqbgaNwBXD9oWTMMBMf34cUunbVJagHvZ8QDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043430; c=relaxed/simple;
	bh=ObtF3qvZv5wx0HantbNW95jKmTegeqMeLEJQ423Ulbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ortva3NCu7rcam7S4mBZ5Sujya06LLILCfXQcoLQcnA0e1nUC3ptdrNxrd/sWw2Ma+TasI8EETsN6W5+Jy6od5yHmk8OGObXkEubaAXTdCoV2BhyO4FPeDkR44dpnmzAGOdnquJE/SBc8U71FEePLaDexnCFegm+YBstLRG5Yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPf7iiPi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781206cce18so1558135b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760043427; x=1760648227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0U17ptGvtCie7i1raH5xF1gZt/QiHby33L+InxvW2qI=;
        b=VPf7iiPiILDRrOMe83p/ms9cwU3ADvhImCtferxs+d8LPHkrN1Ga8KPeIXb27jgpCo
         ouicatJGR2xmBeXHxRjKuzm41ps4nINCpHA5wvDU2DDsYdCwqDxSB0pgnB9YIZV4g/mI
         FwPo3ZzDcZjjv3P0YmeJvxUOpseITb4m4NEu7Lg27G8Ay7YUUAH7QaPBfXlRe849OXEC
         z8afHGUQHXSxwBpPolXNEp3h8zIH7nGDZllsBAV2a2V54iPbmyCdF5Myvb4WXoFna4sr
         S4Kbhd1aZH3a6M/OtqXuiRnJYs0oicZ4uB5XRuKcUD0yk/v3jMwn5ouCoNCZyZsvf7DR
         jjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043428; x=1760648228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U17ptGvtCie7i1raH5xF1gZt/QiHby33L+InxvW2qI=;
        b=vjj1UURCInNbXf7TiLfVKmqRlV6C+dJDys9Z1r3yIyeWFdI0DuM0OlvuYWILZUudpO
         0B0oqKTRvYzzRcfTDG2JqQaVfn93gKioX+TP5+WGpilkaq3bSRWU9AouQKDklu2hCYLJ
         H9NuqZHPqQx5NbYlnGSLrVeYWnpu0vY2yNvrKehxvXLYwvHZLhpEBGU/Quw6xAe7k1DB
         fup30YtjWr1d3s0gtdp82hcCMTTFOhF2i1Dvri+YBuDNKW9OZ5di6sFUSahwRYFhiWxA
         Gn/gyf4VNcQEsxQwSBrBSgWXHI+YWq0guETFG6n2mMRd7Za8rK/HF8IBnVzB1ByApFgx
         rTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnnOkgcMyTelBr95pA72LWlIJmesXw2D6ftS2BE7nd0i6oyr0hw1IvmQRW9GAw+T7Y8vhRnolMEOdNJeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3e4UJ3SztNHC+ayr4Ctrsu35F7cvH08zZ2q6t2584dTsRUR7
	DRe8Fkv7SuYJQk9Pwh6+/RomoQ2Mo90tDoQg4z8QhmTbjmfmaMlHttTn
X-Gm-Gg: ASbGncvSrZFljC3zdXsqdkkY/7c5jpZznMR8dSArlZAOk3mXOc4jjhYH4olTbN0KWRf
	gTlGFI6TwrpNPeauntfITxpvuYVsRTXa0oMvnO3V2m6kFtD4oph2wBrDZQIhUIhqg37e2gV8s+G
	YDtXy97cyEL7TX7rHv7H7dxonBYOabbJVHRNr1+dAyDGOiEjqkCbWZdEy1Kyp8BxwVQIWatn4th
	kA2fS45y2GEJoBRYVfo5jT7B3RsahI6Jtb19ZoIwybYmXQHn5r/v2IKaYCOc3aB1lULoEfNoMDh
	6wmRyzwAcPCpsxd9L9dT/6vwDocXNeJK534kBQf6newFZZ2iKJw1/XH9IuBFdvGS2x1Xz75L5sV
	C7TnUu8I/+ggDPyIl6EG4OHHVHYnxxvMOLp0R1/JQ1+8wz+nAdVU4CST0OuYbqzYtRLB0bgN3xI
	KRpg/7kEvbeSL36cSLjXs1HvLehx/+Drk+eUl2oiVM+K1pS9rYrW6oPMD75A==
X-Google-Smtp-Source: AGHT+IEQ3CQYxnXD0r7zcZD/W4QYBcUzXDWpnIYyhdFQwzlX1UxVe1+oMTH1I901zaf2ZfVIMH+03Q==
X-Received: by 2002:a05:6a21:50f:b0:2c6:2c4c:fafa with SMTP id adf61e73a8af0-32da901461bmr11185277637.28.1760043427345;
        Thu, 09 Oct 2025 13:57:07 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac8d7fsm787678a91.21.2025.10.09.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:57:06 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: trivial-devices: add mps,mp9945
Date: Fri, 10 Oct 2025 04:54:57 +0800
Message-ID: <20251009205458.396368-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for MPS mp9945 controller.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
v2:
  - add Conor's Acked-by

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 58ff948d93c9..08e2ca1b573e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -317,6 +317,8 @@ properties:
           - mps,mp5998
             # Monolithic Power Systems Inc. digital step-down converter mp9941
           - mps,mp9941
+            # Monolithic Power Systems Inc. digital step-down converter mp9945
+          - mps,mp9945
             # Temperature sensor with integrated fan control
           - national,lm63
             # Temperature sensor with integrated fan control
-- 
2.43.0


