Return-Path: <linux-kernel+bounces-874158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986BBC15A42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589DF1B2255C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F210343D9E;
	Tue, 28 Oct 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxxlHrae"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA21343D60
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666808; cv=none; b=QCTnToMbizzhW1kLbvhfzg5EpIOUz00Ch55j2h4CZ6Az1y4y/Igs6hdfBxjwog6P+jLPclejtxr1RWFwtMRl1S6w9q5GBVTV8g6pbRaLb168UghHAic7JaUMP9hQlQO6JOC7UdTsPxSrw/c/qUwI767V2uSg2ZwfguTv9gbBFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666808; c=relaxed/simple;
	bh=AobRNxgST8zQe+P/0s/nrftHbBH4Gr6BiCzGVmdCIbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duBJk299niLfzjXhUYFTSKhN/ChYwPk0AKwuBZ3uy8ZoTp0EdLn2QHgaoyYUMcaJXGiW9RJ1FBmsaOaDv9YYpEqUTbDXrSWOm2cU9I8McGR8/D2xxglrmgZEngIKhl5QUhxwVmtxzbtz1Z0MkrcTRQMI88wjfLE38dHHOtj/Ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UxxlHrae; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso417045f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761666804; x=1762271604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXDC7M6kaxSAFbWMJYcixkWhlLJArFQmLx6hgFHXx14=;
        b=UxxlHraeHchuNuVy083vve6bfyMYIr9qwmjxJTL+3hspt7P4GdTajQSJ/JgMFT+ZrC
         uTCp3oabe9prNEurPYfixSOYHIMZQDXJpeCvGkxYBmBaGBtKRwl7uTgCAAniMX3XL5bP
         Lus/FdaAND+k71d/g61nMZWIVPkfRo5/+Vb18EeYe+80npNQ0S85E+MC0wFRHEz3BD8r
         t03oQZ2g6taYX/upmiSJtlYqRU0u0Oy+/BegpXFJl6MjNVQLoWJk2MHUjk/AMaSYm2fW
         w+hnMlNOukQy6vni9H5uy1tsC8RMcN15pOZ2Fhe2gRBkqMnIvzBqKvVxQOqsLA5gjWIJ
         yPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666804; x=1762271604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXDC7M6kaxSAFbWMJYcixkWhlLJArFQmLx6hgFHXx14=;
        b=nBvtaaPGeHulKo5tSLVYDlMpKvBdJiADxnoumgOAWq3pymBIXCo+s1JugSo/QYUOhi
         3TZUApdOgOObBTgSVaVPov9F/3pudmLshPWMF/CjRvXO31Lt+yP0VeAnO2lPPqswnM0r
         PjRj8863NHfIWPsG4ZFA5fCw2kYCg9XY1z2dNo29Jug+mLiQ//e/o6hLi32V8xXtWUuG
         Oj06K2DSp8z1UhJ+SIGfqfv2zegtA1tLY6dW/LVLuxm+8Jdqi28w1bhQvFrTwOILf+6u
         ZswN/UNXqiqzQNKzRb8K8oXGENl2D7fcoWsVOP5Wo38ZK4UxPLr8dyIvaPeny5Xl4Nkg
         77JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7+kOshhhb35k+/ziAlIcUpy3fkw95Bwlhzm88DUD6CIXOHY9qR7aOpnPOPDmQ5OMKt1N52TetU2cpXWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQutHwQmfROklmW2fyPcfLQV0aN/VQg9AfNbu/aPRXo2Ut+xO
	3Zr/4tguNHihouMQII8Tty/w04uO/esSA9AB5BKwskbiHYUDnCexfDdZOGHOdWuSlcg=
X-Gm-Gg: ASbGnctHEvoKmgHwIlVrM+q4i0LbLfMzt712TQbNlF93HzxMCvdgXUHmWxlflqHePwl
	DlcDOaQJnlBoxyDnAqWix+6PdaD9XtJYU+o6Sa9QOtAAXW/KbgzciyxSyVE0u35nKy4d9URKy8k
	vOqpPaXneqCi398uwUdwTZgCA4eEBKePxwdYMIxrKcGc1qkYe8PSXlJM0+WmzEijPyv5gGwgsuk
	T3iC2D4L7rIvWMGF1RFumEwx3nY8cuSh7MU3sd+HJcpUltNI3LoZTyOyxY2Et/HsxPBmTJ4adgS
	yZ27x+es/hqbI06Trje4WNafe1pvTWZC/YWJJEQ+zzgzsBtzQWRcm3M8SOk+INhSP/vRPSb3jO/
	k2bdk0dHMTbqm3d9m9gaeqyK58cZ03+BliZYfAAGrpx9nb2KbpiCEKiclhHf/nGe2npMxWYFOhO
	AHoPVb/Z/kfHM=
X-Google-Smtp-Source: AGHT+IH41j4JtLznpnUlgn2fs08an0M9cSbhtKiZFIJBMeH8gjS49gF30paXeW6FuOaAsnvR2KptlQ==
X-Received: by 2002:a05:6000:4287:b0:3ea:4a1d:b542 with SMTP id ffacd0b85a97d-429a7e79ec0mr1797115f8f.3.1761666804285;
        Tue, 28 Oct 2025 08:53:24 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm20717047f8f.4.2025.10.28.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:53:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as Qualcomm hci_qca maintainer
Date: Tue, 28 Oct 2025 16:53:21 +0100
Message-ID: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no dedicated maintainers of Qualcomm hci_qca Bluetooth
drivers, but there should be, because these are actively used on many
old and new platforms.  Bartosz Golaszewski agreed to take care of this
code.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
Don't orphan, add Bartosz.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8abdc0e50699..8a2c5fb0ba55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21145,6 +21145,7 @@ F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
 QUALCOMM BLUETOOTH DRIVER
+M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/bluetooth/btqca.[ch]
-- 
2.48.1


