Return-Path: <linux-kernel+bounces-796750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58BB406B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FAB54020C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1DF3594B;
	Tue,  2 Sep 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM7gw4ko"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8312F068A;
	Tue,  2 Sep 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823279; cv=none; b=Vr1keZKve57vqr0nHfep8V2xo67abjoi1HWV9157NJEJSoc9z2FkOozK/vkvOh7Aoq5T3j86zpeb2dYt4tByw6nZzH57a+I4OQ6t1F32XkQw3c0g82eOdX9XiN5Y3oObbkHAyITkG5rH3MmyhxW2PZ77Kre4D8T1BAzyQ8RFNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823279; c=relaxed/simple;
	bh=GH2KBlUCdxMbygi8Wxkk4u2Oeqbo5kQFRmBakx/0VNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbU3/BufFc5Fw2tuTYzsJFHeE8FQs8FcCL7zveTcIkOnTBwevHixCtBbitmGjT5/Z+Z1UhvtE+aKDfy+GaE7rpTW0YgeTbWrTp5L5d2KUgWkHDM+Eeb9VmAo2xok/RjBZWpWdDV6tZxVaAFx9zEpEg85e6+E+X+CnY2gKMAFqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM7gw4ko; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso2106509b3a.1;
        Tue, 02 Sep 2025 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756823278; x=1757428078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RI8YMTsM5bdTgr8RWxuM+JDoufQWgHL5ULIyIPG/LZI=;
        b=HM7gw4koi/t5Gg4kG6EQ1ur9AkuF2mhSHkblkCfZhSDZcmTQn4xjtsCzJr8SO7Pvwg
         6gd+PMHIaQja6KzfDUm0VeuBnhC+MZSu6P8eWJSuEgF2ZVujd/NxZUh6jBwuj/2ExTKd
         2ld4POJzquKCqPVwK3OiXikJYk4c2IVZ6AClyKPEHVGtZ5XdzaXgGcgSor3HKIuObDw/
         1/ntJbJeNOzzV1PFOZs+3iIHetNWGmH3CFpoysrBs8cUzBJ+HNR1x358fBQAUNkd8psm
         +UPofq894IJ33uIQ65OcPSTOJzdrk8q1gngheoIg6i8kknHOx813EGMNECIvSFpaYA8d
         mTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823278; x=1757428078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RI8YMTsM5bdTgr8RWxuM+JDoufQWgHL5ULIyIPG/LZI=;
        b=queF/3yQylnWQBXHS3RXLIOQ3HZ/wTO+V7qSpL5MMR+kB+WcyfOpNBlJzWB1IxSaD8
         Cvtip6We3hirOaG6uDBwxx568oIyTcP5OciGzgNVZ16+Q36qUCtNEDueHvxk77qxxxMt
         EJC+S5oLUv2zKBjltOlX+yUr+CI2oJQwdX2oawRYN7c7yL9lHCWdbdnWeKth78pmfnDP
         n7YXdFQalebT/CZgtCxkCW3x/IaVTtHprrs+L3FjBnuI7UqxS+2qXUL1zH4rQmziFs9z
         fqrJzTiccRxs5PI9YBP8esECs2fbugHSxrFYr1D01ZNflVad+ortMcl1/UgWGPh+OFSo
         b3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/HwrRn5BXaAXQBz2WvZFJ9Rom2U679bkfgMEzy3gH2NuGY49LxcfxP+DUzMWCGSYZ4DvLnRerTID@vger.kernel.org, AJvYcCXjp4zaeT5fkPxzZ7y8jQXz8A6nFHomsc+xPN6lsR+S7uG3+0giWiYOvGidUPPDfMNFOaom2m47G1a68mre@vger.kernel.org
X-Gm-Message-State: AOJu0YzsiEbUDynip9QZLDc2JgZTW0Qlar0jx6bUeM81s+dzev/Db3gl
	90+3sXUr/4sh9eD5U9jvYYydfJq+P9VjlGOdHLY3zjGPl5bOk3HAwS4vapi7m7gB
X-Gm-Gg: ASbGncvD2TJCYA/FeySvc/ai9wiQTEVD5HuA1VZ77045t8geUfrBoUNjEQbDWOnKbry
	n2DocPlspIaSwvK+k7uIYdR9JS/yD0Z9XrMQeyrh0mFfh7L90JrQsw0KH79U9KLmyhGTliXwvqf
	p/XFuSiZUnlw5CCE5Vuin7xq/7yOUh8J5ElM1FdrxI1O8s1yCtWwsoKMojnpmsUS3HVrYSwXiJQ
	hM2aAsqJaZmdaXWxzhTEijY/UqI9wIrtLAi7P15jVjv/4/2QmQ67AmbzQeSp/EXll7Kdvl5d8cH
	e9X0DGzwKM6ZiOlPewiZWV/hLL9F4aMV3X92XGG4DTXVhQ11IVzrQEysgtA3qM/RO/wleoZTisg
	OEpS7yRsvSOH5q3fVFOgdSxO823dGS/V9+DUcuCuG8fA8USCEvDLcapweKFr30TSDfWQe557GpK
	1I2MNiFzw4Gw==
X-Google-Smtp-Source: AGHT+IH2QNpk1G1oizVTAfMmh5EaVxtk0njE1AkNCw3NMyiQa5CgglA4xj1JT4wDYc1iakVEZBu9RQ==
X-Received: by 2002:a05:6a00:4b56:b0:74e:ab93:422b with SMTP id d2e1a72fcca58-7723e21a5femr17292235b3a.4.1756823277725;
        Tue, 02 Sep 2025 07:27:57 -0700 (PDT)
Received: from johnson-VirtualBox.. (211-22-107-155.hinet-ip.hinet.net. [211.22.107.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm13893756b3a.30.2025.09.02.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:27:57 -0700 (PDT)
From: Johnsodn Huang <kusogame68@gmail.com>
To: lee@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sef1548@gmail.com,
	Johnson Huang <kusogame68@gmail.com>
Subject: [PATCH] dt-bindings: fix typo in documentation Correct a typo in the documentation by replacing "abd" with the correct word "and". This improves readability and avoids confusion in the description.
Date: Tue,  2 Sep 2025 22:27:49 +0800
Message-ID: <20250902142749.13724-1-kusogame68@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnson Huang <kusogame68@gmail.com>

Co-developed-by: Nick Huang <sef1548@gmail.com>
Signed-off-by: Nick Huang <sef1548@gmail.com>
Signed-off-by: Johnson Huang <kusogame68@gmail.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index d783cc4e4e..d16c82e398 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -41,7 +41,7 @@ properties:
   clock-output-names:
     maxItems: 1
 
-# The BD71847 abd BD71850 support two different HW states as reset target
+# The BD71847 and BD71850 support two different HW states as reset target
 # states. States are called as SNVS and READY. At READY state all the PMIC
 # power outputs go down and OTP is reload. At the SNVS state all other logic
 # and external devices apart from the SNVS power domain are shut off. Please
-- 
2.43.0


