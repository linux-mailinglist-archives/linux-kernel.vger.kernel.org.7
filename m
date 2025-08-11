Return-Path: <linux-kernel+bounces-762864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D4B20B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C966162216
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D521E08B;
	Mon, 11 Aug 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2N5qD3d"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DD218599
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921734; cv=none; b=AkiyFCoIoAhQc6OulrCmaELTj1evucU7z/dYzOWzdeVoQFbX8BF42YZI7yhHcxF8W87usADxpGGMggUwVt7K8ltYSzmUXLmQ80ELp2boBP/8tSs1vNo04x0C1wHRiP0pxxQq2PcCjK5zBFcrZngyB8OjRmZArbcGpQITbMbXOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921734; c=relaxed/simple;
	bh=GgTedC3H+eqwGWuvamKaf6D4osHTsX7u0PmKCWiC5qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aENKWrpFOTu3IjAQM3mhVZG7ee1w7HZBCN+H/h0a0JMrZ9RXO7/Hy1K3KbbJjGkpywm2LenUtjlEmi5rkolanydFZSD/F9MMdX7glM+x9gk+GOwR9LC6y1/CnCnc0SaKbpVYTzNc0J8ieg62AwHQ2LbjR6SvMa2UbxFjqobPr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2N5qD3d; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-617b526d402so632657a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754921730; x=1755526530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNA8iFqzL6qzbh6WBBPgT81FgWKTS2Sk37AwyCWlBGY=;
        b=A2N5qD3dmQtCmkPbwtMi22gr3ZSMIuF6QmZeK+3VEv9DR3ETkhMmWIyX2boC8DTqeu
         F6Tbd1dfs2NdiNCoquWo24tMtOFUMY+wDHq3kv64CLzY5WfCDlHNn5zfvv+Srigbpw56
         M5lb3FQiXxvV5WEI00XbhCiNdmCpEhI0Cp+BpW1/8pdfesPtUqzWqyJa/MLRJaWWZlKa
         0S7pBlNkXlBqVso5lvvAdWarQgCDqdac1Xz36j6EtlV1ynU5qObgWr0RbexwkcASeqIA
         KbQCYd/9lqy0G4k9dcslVj1Htau702mcL3GjIyfVG638hOw5uwg1FEy7wy2fdZ/lkOKq
         iviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921730; x=1755526530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNA8iFqzL6qzbh6WBBPgT81FgWKTS2Sk37AwyCWlBGY=;
        b=oTVfQ1niiXa1hVve8B6k63t+0RtTT1dcviCtj+y5GW7PNkvq/DQUnBUAKr4hJlCtDX
         R5mL6yK/e7UP2QpjIUEqmm4PV0w+LuRaTTybIossse+QiJW0dKLF7eFyQlYJL5UCZhu5
         V5pijo+8LiRaduax5fK0lfJSbu6BQ0lI5RiSIAhnHror+BVKfsdqDTQjh9V802r5Z+xd
         8BjgJderqLIslieSqyXXCy46W4iu2nd/ZB7JL7ZXKuH8711fz/n6/m7HUxauWUj8dovk
         gFN5rPBIJVFbsI3CDQumXdRrltPWsmE/UILlJH7NpLid9DJ4n7jBx2Ydac473raDjkKy
         Yh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFmkkIjb4NzWnFXgJwyFmibTxUzyoNft0pYKG6ASbBKLeqMdaztogsfeapNMnpU8X5SH5Veg8YxVARDZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eXpGb/rc1Juk6vnwJ8WPerPTUKTP6O7IAuZVTTHdC6mcXUv0
	TjouXR0rZof82RCbybaItH/N84YVY/MWWDpRplJ2+8KziinfaMssNlIrz9koiRp655o=
X-Gm-Gg: ASbGncso6djfxFWg2dC2dhJIS2wDbC51N/liUY5QHPzhjLfoNoZqwF8fibyrQyW2u8n
	42m00CPStC6G6pG5HOoLZrqIVFqQeciTli3fQCgOCiXuJoFxdx7pVZKhjfRWQV9u99rSJTLm/mS
	l2LIFBvh/3VdFM9mDrP5reb3NuOu0kBOZexgjrZ9JQZlHSFdgbc35j7xQMjZch3N+P/bxOw5Fs3
	hQXiBV0zEqjxJB4RWRiwR4bFUTnx4oYwEE4wW8RQ36tq42VRMRSLjunF983SW2nkVu1QtFqU4d6
	oFNmtEyT3F+/m35kYjHQw2aQjuHfTzMsY4pzNfJt5DBdg0B+YY9tK/8aAhzJZT1NCIsw1Q5oIpy
	iDERdRy2sXQWbnjm33tHTaZbWfIxFLl3nJA==
X-Google-Smtp-Source: AGHT+IHAygobEGiV/EQmEH+EomKzx4R0eZdqjy9CgtIpiz1r2MQuZDal1lyU8YfvqW6ryYkgxuvnKw==
X-Received: by 2002:a05:6402:40d1:b0:617:be23:1111 with SMTP id 4fb4d7f45d1cf-6180afb0786mr3370254a12.7.1754921729836;
        Mon, 11 Aug 2025 07:15:29 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615c57f9fd0sm17333490a12.11.2025.08.11.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:15:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v2] regulator: dt-bindings: infineon,ir38060: Add Guenter as maintainer from IBM
Date: Mon, 11 Aug 2025 16:15:27 +0200
Message-ID: <20250811141526.168752-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=GgTedC3H+eqwGWuvamKaf6D4osHTsX7u0PmKCWiC5qk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomfr+Z33oN8yHkHq2Ur+59H5VGRH01BufhEBeN
 SOT7ngoNguJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJn6/gAKCRDBN2bmhouD
 1zlBD/wOnfv9rtrSEHox/rZR7LIkrrh2EhPsGVmxgJbDWJ3A6iNyfCZTNAwgNftMngQisg3IvaT
 mMsoHA2eDxfCWw3CAzzmmsQ2wGEqGOcM5ml1sckLfWUo1qVeg3GSilgpxtYpTgBolfIFhgwgN9i
 MVSxIi6roIlNz/Bfq1uMnQb5lEca3iZyfng9655C/XnP2qbBJ1Bqhfeb0rMfmDnJKv8WHT7EVG5
 wnLlKOQySKkkl/+/Rt/ImmOyE13HSajCY7cYeMiutMimhhtq/5cCBsesMX9CS+829suMNsV6Qms
 dw7xEybfynaSEaVn6/tUdk4H39rhXSQ1KtgsDgJaCn7QSVVoqjgvSmnNZL//RYbRI2GCbsadrpy
 4tvGOB7TnXMzoyGRCqRx77AaO89MQwusBmbhSoby15ZFV7jTOnaylKdGG3xet7wsGYtUIewSWbN
 7h/2OHafHXW0UwPWSZgz7W4M/0RsHld7jYcqiWcbHTCLfCvb7njXg8CLPdUIcb8u6XxRt4rrVSW
 wqGLmBkQbVXwID6yLdcmnp4kIL6igqoNQfKtlOi3c1+g9aJJDUceVHwPm7zVLdjvZd0/TwfR7ad
 hYPcvZUOTZac436BeDbceIzQhijSQmAo4ETyanYvocQ0eDdR2CNceZrIXlS6pdf6tif0KJL15Hk CnNr+7Zzlp332oA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The infineon,ir38060 binding never got maintainer and fake "Not Me"
entry have been causing dt_binding_check warnings for 1.5 years now:

  regulator/infineon,ir38060.yaml: maintainers:0: 'Not Me.' does not match '@'

Guenter agreed to keep an eye for this hardware and binding.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ninad Palsule <ninad@linux.ibm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Guenter instead of Ninad.
---
 .../devicetree/bindings/regulator/infineon,ir38060.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
index e6ffbc2a2298..57ff6bf1e188 100644
--- a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
+++ b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Infineon Buck Regulators with PMBUS interfaces
 
 maintainers:
-  - Not Me.
+  - Guenter Roeck <linux@roeck-us.net>
 
 allOf:
   - $ref: regulator.yaml#
-- 
2.48.1


