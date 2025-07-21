Return-Path: <linux-kernel+bounces-739335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74802B0C4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C2554001E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E92D6619;
	Mon, 21 Jul 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty81iSNz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F862D5C61
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103258; cv=none; b=J0IB0JbsQxoXJnpUK0XAG3K6Q3WqxUG2oUis13VdyYOJuYIlixhjWZkkjmeFntYi+7+4pxa3+H7tgKkr86Rl4GmK1CFHsks7Ckq5sO/SyuZ04eoF/OPjzQpuGwczIhCWejStRMczuEUx3eyAjDHpS1va4XPIxpEFujbxrxjyo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103258; c=relaxed/simple;
	bh=q6B21jNgjxNNbn1toxYsG2+TSTzsrfyP6+kfk/EB6Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6DMOxjiYMYemxbDeYo+nDR9e0p/Gj8Dl2yIMOP+BAMcpIcLrqxiSiwUS8LkqEGNCZkcR+AkYhFS2upD+GnxFczZgzleNrDcx5vzx85MUg+SNweAlSNCs9FszPQBuzrdJBFreNv5pPHxO1woniBPv/jeeF+SIboTskUJoXLZI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty81iSNz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d54214adso30729855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753103254; x=1753708054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLCx+sqKyQ6H6n1t1Iho4DguHkaJ1c+mG90AYPKk4U0=;
        b=Ty81iSNzrC9KzrU8swPLxqlrsQtu1aRMfFEEmD3dZfuxdBlX5mLnhHJgjHSyIw/8wX
         oMByNMiIVw5Zz8bpwNAaw1grgaGwKu6f3wUjZdJVpy5fK780cm/sWwMIAz3c1Fe3KlEN
         J8gKfEmIrAV7ZdL3uznEDO7pSRNntxYwnbiF9dTg+SPJExRiSXCdqRXgiI8gJ1OEcDt+
         CuLQ3YxP1Ej87hX3DXKGAxV2n2QWKxPDB1X0vAJslWdA+k2MUwdNDf5Cl8Xj4MhpScMD
         bp9wtHlGiXRLhBrIx3zJ9oySHcVzRwV98eGKZdyy9LEVE5PUxlqbI8u0J8mru8Irh+La
         0w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103254; x=1753708054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLCx+sqKyQ6H6n1t1Iho4DguHkaJ1c+mG90AYPKk4U0=;
        b=aYQlhGwiNCHsXkjSB6/ArlwmOqA6hDFfb9ageOQMh99ZIpuuUwuKR9DoewanW32VK4
         lIStYWLHgIkh2E5NpcVY/49WyRwbVUHrk4fWWy+84ouE2DppB6NMz23AikPGmdwzUROB
         vhbueMDfnL2bWQJl9f952Zh+ZKfbMSNYQckzcH9FfErZ51FoWDo86WT4KWz0aZB3SblL
         ScRaS/yiZOy1ORMMy7jOd41w9m2vnvOqUdh3D/t0+DVBNfgwrtqGeZsEIkH+V8R0RdCB
         QmaY+uog/SmGfnVry0+KofCKb//8DpHtvKQXkZqpqa6Aezitn16u+ZaTk+PsxwbgWZnt
         2Hzg==
X-Forwarded-Encrypted: i=1; AJvYcCW0g8QCzaQdtewfGNrx7R5kwtnee70b4R6b+rsrG6/+iLSt5AeGYFMSa6vyH2krhiU26FXE0Ou7/mCBcoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW00jDR8RtI9n+z3iwWejchKh11Z4vrIILRk149lerjt/BKdMt
	NBrObFMzmeYJmCohPy9vkcQSjUYBS3xKUst2yt7+KXbBdjkUeqR9RyJT
X-Gm-Gg: ASbGncutfzJaPznMTzeDe8PX9dCi7SZw1GDX88XO3mVvTC5OsUXYGy3QmEC5qtx8AGM
	8Eldo05wgDvgFBxNkskFFqXLM07SYytqwBf6kJeGxBMOTwVWTtc9n2NjxccRFqaHPW8T3k1Wq2k
	p31czl5gtAg1zi+faupkemlB0R7F1bwKjqEox7Qm0YaQt7HYzfylypzS3ktomca8/sQB340Kqmx
	SHW5kJz0zIdt8y9LEZLhtDk1CxYJSrHHIrK4/JJ39E1CImGxDIJuy53XCT2Hjy1JUqz3o8poL+W
	27OEhaNQdWKlRklqJnTlbrcIkqUqgGHNOummUuwvofukBtZw+DAltxLZwjulLzpXCkH9LBzs7NF
	eFYFfJda9hXspA3c+icyujptxtoxXK6MsBOQpWEDSqCOzAB8A60W1ZYA2GLVXuWsKlt641Rp6+g
	==
X-Google-Smtp-Source: AGHT+IHmDCTmiGnsqtX1YVYWRcIXEER5wbunM4O6C5Aoi5lFM6U8OAVQsEhiHj1NA9lOUgYhy7795g==
X-Received: by 2002:a05:600c:4f42:b0:456:eab:6344 with SMTP id 5b1f17b1804b1-456352f8f1emr129426955e9.15.1753103254113;
        Mon, 21 Jul 2025 06:07:34 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm157681365e9.8.2025.07.21.06.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 06:07:33 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	arnd@arndb.de,
	wei.liu@kernel.org,
	romank@linux.microsoft.com,
	mhklinux@outlook.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	kvmarm@lists.linux.dev
Cc: roypat@amazon.com,
	Jack Thomson <jackabt@amazon.com>
Subject: [PATCH] arm64: kvm, smccc: Fix vendor uuid
Date: Mon, 21 Jul 2025 14:05:58 +0100
Message-ID: <20250721130558.50823-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Commit 13423063c7cb ("arm64: kvm, smccc: Introduce and use API for
getting hypervisor UUID") replaced the explicit register constants
with the UUID_INIT macro. However, there is an endian issue, meaning
the UUID generated and used in the handshake didn't match UUID prior to
the commit.

The change in UUID causes the SMCCC vendor handshake to fail with older
guest kernels, meaning devices such as PTP were not available in the
guest.

This patch updates the parameters to the macro to generate a UUID which
matches the previous value, and re-establish backwards compatibility
with older guest kernels.

Fixes: 13423063c7cb ("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID")
getting hypervisor UUID")
Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 include/linux/arm-smccc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 784ebe4607a4..50b47eba7d01 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -113,7 +113,7 @@
 
 /* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
 #define ARM_SMCCC_VENDOR_HYP_UID_KVM UUID_INIT(\
-	0xb66fb428, 0xc52e, 0xe911, \
+	0x28b46fb6, 0x2ec5, 0x11e9, \
 	0xa9, 0xca, 0x4b, 0x56, \
 	0x4d, 0x00, 0x3a, 0x74)
 

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.43.0


