Return-Path: <linux-kernel+bounces-877475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F51C1E310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F88B1882EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F83002D6;
	Thu, 30 Oct 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAahmeyg"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA42F39CC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793775; cv=none; b=AuQpaTgUb94diAbOohh19S6qKlW3meFcpG75n1/syQ8RBvA3g2yvKo6UT08E0i2FFhR1azkoTiGXn6ZZ61vv0A/0m6+OTL19pbVdXBIx38Rqh8heKBrTq/Jjm2QNhQi6qcOL55ueJ0nIBae4PJ/EkuCygLSyZLprOJ3My9/yOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793775; c=relaxed/simple;
	bh=+yp0oNIbPIHplJ49C3RLHC542xFtRCi3lHAph1pF8Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jbFklBkFxsDnozSDkOr5jkbuJNNdA/jPjaQIDJVQVrPvTUhpuCC+r00mSXrzFQSeqlzCGTkcWWMZ2zlZRVzrsm39hdaVFZ3mscCAtvSx+CaJBJVNJWxzrTt8OksqlVn6nyp4nbD4ZKORQYDVsFRsLlceyaghzhtDZFrKygGK1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAahmeyg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8a479c772cfso35435685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793771; x=1762398571; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9yBtaoQMt4RjwkfwUxgTG/0MkFajbObVmdDtK6y0Xk=;
        b=mAahmeygZU8tG+XRElF0S7nhPGC5OAOrxLIjeMlwbgdhhaYbniVjLR4vVbICZndXXj
         2ePUNj+FWWvA0aCxKPE/O8AbqGnlk8zMXeNHjljFEYGoH3uXkWRHgipbV5majGmJ18q5
         oRSQIpCEtPPZ4SSrJXUzT6BvnsQeQj1ESlJ3e+G/YGG8IRcKHncl3cnIyVS3/p0Cw7u+
         B5w8+Sattxu4rI4VK+xORlEkjajRd4u4k6v16VqkvUoNebo0uYPS5Pyr3zgqws7GEFK7
         x2OiItvIuANMHBszNKWRwDA4UMrzbqAQu8EOXEpScbZ/mQgFL8wJad5qkviQSWPlNAgl
         QR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793771; x=1762398571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9yBtaoQMt4RjwkfwUxgTG/0MkFajbObVmdDtK6y0Xk=;
        b=hEGHxjs8fWw7ps3S+9L6fByzKq9bCL+2/cchbH8u8VhkoO1dLR2TH7+IvGwMyl7k2O
         fQn+AvAa1LtLWL9s0o1N+ulpaoA0nFH7S67n6hgtOwS159R2yzw2NalrAiN+OGqwn8Gd
         VE5SJLws7gzuBRtJIz9CNlTpeeMblfIq0rSd1/ConO+Paem4EM24wqIWtmgrY9CfSc5F
         RGSgzcbUTv/8OLyNxCCu1onPjEyXTuvjQFrNteqoqRmUiZESmIIUQE8BSofqIsUnmQwq
         lCyBmBV0UzB/kXkxhsvOlzPtZXk3Rm/9WDTNXTvkfI+PlXIXc9DY2QiVNj1F1GyYl4tK
         kf4A==
X-Forwarded-Encrypted: i=1; AJvYcCXAxgJZiuP5nSzJVmvb03v534CHkAKFxmC5uTIFqpOxLyK7P17ElIKyIjAGYmhl/LRNZFttNeZfbFmQd+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY9Ir0j+4x/MRUNuGEE5+Z5b/d5m9I8GLtONoIvTCjn3axi38
	1czEbhl9o8chtP0iLNc23CWPjZMVoGTVlo96bIl6qebZf3ibj4Cuz9GG
X-Gm-Gg: ASbGncvDZx6B54SGAcRIlooYbVPsU0yufyW30ozV2WDIHbosKx71Deqhq+S4L3HkToW
	9zEAfjZxMjJNfqzWbAFmDXU9irChJYTstb5DC0CjdrniMhTzW14gG5WLbBjH+0kNux+I1JU7WEj
	tAATgpfhggyREZ6tq0KX7O69njrG2gtOCKKFIWUbfOflUvPL2JoIVX+fOqd/DvgkpWfproJEVzg
	OYrc8SF64rmFkElWsLwU6nAT5GRgMGctBqxhVDhrTlpdMeiJ1bA8Yrowl/iGsS7O6to7zoDOOZA
	kp6i6EE0uMVcuBq109fZMGezA0gy704I/2SdBcbb/Ar4k9ZZ2p+U6+2QXcWL+9T5cfrpTeR33S1
	gEL/amXyCMS1DMth8ekhqYqTfW2v8/fN5LI6yZrwmJDDTqoCTA+txvBT8SWRER1YxanYqlSG6LP
	yRxGDTBjN2VAL4Ae32
X-Google-Smtp-Source: AGHT+IFSneEe/D0Nm5OTWim+N+3MwI7PLvrIFHurjKJIj/dFQhAHVJ8uDPxnXPaqhaufAkrkxzryiw==
X-Received: by 2002:a05:620a:2913:b0:89f:8089:332 with SMTP id af79cd13be357-8aa2c658481mr270286585a.27.1761793771563;
        Wed, 29 Oct 2025 20:09:31 -0700 (PDT)
Received: from [10.73.222.215] ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a6461sm1216363885a.30.2025.10.29.20.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:09:31 -0700 (PDT)
From: Samuel Kayode <samkay014@gmail.com>
Date: Wed, 29 Oct 2025 23:09:22 -0400
Subject: [PATCH] MAINTAINERS: update PF1550 driver email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-update-email-v1-1-f38f45aac2e8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOHWAmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3dKClMSSVN3U3MTMHN00i8QkE6MUw0TTVEsloJaCotS0zAqwcdG
 xtbUA6AFtqV4AAAA=
X-Change-ID: 20251029-update-email-f8ab42d1a5e9
To: Lee Jones <lee@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Samuel Kayode <samkay014@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761793770; l=974;
 i=samkay014@gmail.com; s=20251028; h=from:subject:message-id;
 bh=+yp0oNIbPIHplJ49C3RLHC542xFtRCi3lHAph1pF8Vk=;
 b=a2wytk14s8diN6iiqQV8aaMVjzlSE7YtEsqQfx/ZJgYXoe/Usct04+SEmzwzwdqb9Dv20yTJo
 nxQCcLNAWowAqXcKYuSZVFDGndaeD/JIiJbzfPZqslyOt9/j2pAJtMq
X-Developer-Key: i=samkay014@gmail.com; a=ed25519;
 pk=favoK08ilD1j62PrGf+RHihBzbqJGWMC6f2nszR5UIc=

Update Sam's email address for the PF1550 PMIC driver.

Signed-off-by: Samuel Kayode <samkay014@gmail.com>
---
I left Savoir-faire Linux but I do intend to continue maintaining this
driver.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a9330f05e2fca6b8661bb698dea17dcfd7fc254..c44d2cf7e7b85104a6eb09142da8ef3d9fa7e55d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18608,7 +18608,7 @@ F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
 NXP PF1550 PMIC MFD DRIVER
-M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+M:	Samuel Kayode <samkay014@gmail.com>
 L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml

---
base-commit: bb57b5ac4f83df384fcbc5ba38a397ca0eb91562
change-id: 20251029-update-email-f8ab42d1a5e9

Best regards,
-- 
Samuel Kayode <samkay014@gmail.com>


