Return-Path: <linux-kernel+bounces-858567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33100BEB28D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5AD1AE23BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77D32E13C;
	Fri, 17 Oct 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl4OBVZl"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B75320CC2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724706; cv=none; b=I35sRsh3Muuhk35PvShPxZLlfvxoLqcDqKTRgRMU1Yz7As/iwSTvt6E4DqsKAOI39nfCfbZiVBa8yJKvE3B0nboVz9VzEd1TrqQiqTcLL8tqGahlS4v3kZ3qB1woWsCt4uq9KQ/yB9xadtN0y9WMSEL2V+M6moL2SQTRsc3peYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724706; c=relaxed/simple;
	bh=r3dihmDf7EmTwHyOQk7Zkgw4snf1eF5k1wp6/pUMG+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoAaB7/jQs6z/YTETlkWG+CuRAVlqGh+woZHkrSa3i6id+GZXCXKOwQ8toieBvUPq741uaRzCmjuIPnF8lxtLMSkDJTMVAlrYK17wo/TUORRH0vdc3EUtXuRazxpfFR6R0AgnLo2rqlAngPTyotgGrFJuROnqeQGdHkgcxwQz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl4OBVZl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-796f9a8a088so2174310b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760724704; x=1761329504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFIEDJTAopNEIqPSdh3Jplcei1xeOHRhpzrjHf2iOMc=;
        b=dl4OBVZlGLH3QZINSVf9RfP3FLWtOp1hDEcpU56LB/ck2q7dy7iBk85r9prlZs01mb
         la8iwuKAsdssVw6rtHthQhzwF7EJCDa1Q9XEH8jnWt8DM3bRIz8QztQZuuFM5sRWW0yZ
         iTUnjGWqvle8X7tUtXd7uZEGIKnIC2u8uV5KvdOcI6HasgF4rYo3E1Hp244fHcpxGeBV
         k03ssilvPliiIgA6beHebkKRwRUDuFOcmVMfyoBNPj7Wmm6V0E7NIvs9BJolOQjj8cKC
         2/QbVuopRzIeIH+xsiAmoSl0sOShQZZfn8vo0hsuC/oG7WDjE6No/pmRsYQ0Ddyppt1J
         5ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724704; x=1761329504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFIEDJTAopNEIqPSdh3Jplcei1xeOHRhpzrjHf2iOMc=;
        b=UrNn52KXt35djDFuOQLbhRQlKT8/Dq40+uzgCEEut5V9VWoyAG8XeTzYPN+dmsfc9W
         9D3TRMDiRG1gL3nXJ74fqSjha5F97b+ZJC38qVfGPVRgq00BEyfIkmi+/bYpktsYsTU4
         PUJw32eZCHBpn2JCamSPFR1pWsw95L2xaGddlxp88HJ6R8N8ZoEHR9wzvZCXLeU/6Fe3
         +ZSAG5Kl3+P5/FfZApULzWp2mAN4leWf//PwuM8qRKU6llt0Wf0nT3RirK0hYHUp378M
         wxZ43/faS1gpk0xzLgFEYFhXRWZSP4Zk0KgvJRnLiQHf2atVyg06/pE7khcVAoHV074i
         Xeow==
X-Forwarded-Encrypted: i=1; AJvYcCUYRfFenH33DrZ6Ys/W9vrUKrJAUvAuwLVZxX62fE/raz1oj2uystEU2JWkINRsLhwEupRRDTTW9/Yt6z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLSRmMORUZitN+IY/JP5tW9GYuTUL5vDWK1nWB8B/MOIX0Rat
	urGFut2u0a2YjiDYd9orwXd9+rD/0zDS3Yw7EZorHFCvlpUwPcZ++zqN
X-Gm-Gg: ASbGnctQuWqcYmcCoim4WGM0ANj8KL9lQAxdiKbrsjdxFDt+ZppB00WF6JM/aeEH5i6
	41ye0J1zNih3HCdcn3726plJLkPkemHfFIB5IIFdiiMSSyih9Tt6QUeeUbabON45qA0DDCGCykn
	h8DDNyHHhWuJNCRHw10bdRu4j+0R8rN496YsgNBhQFHZ5mKHq6jTKRQDCrcVHZu48+ZEN/NrhuF
	suyEX/hx7vwQclj6xROpxt/HgWGsUvkwyLlnvuV7qwtZQirJChNJ5e2O0DmolDDRQy3EgtaGAZH
	MjypVHbx/aMoXeEK1dUwmE877+dfyLQWWCihkXwAry7rLKrmQ5RqoTZNMiqFaxPL6b0bT3t292a
	NVw/+dLJAesVqquiVTdqTYjKwgsSdXI4FPtZcmIZ8mCvqXpiAJ9FSlMlJ9Ddz19K63Dz3Nn8YrR
	lahW0lgeaqP4MZOaTtYMk=
X-Google-Smtp-Source: AGHT+IE1h8o5AFVacUuJYOfSDEzDV+0FD/VCXQsxR8OMX32EA6L/ZDfNJDJ4BWWf59gxnTA0758alA==
X-Received: by 2002:a05:6a00:182a:b0:781:556:f41 with SMTP id d2e1a72fcca58-7a220b07183mr5214886b3a.19.1760724704302;
        Fri, 17 Oct 2025 11:11:44 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24desm200093b3a.48.2025.10.17.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:11:43 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: zohar@linux.ibm.com,
	James.Bottomley@HansenPartnership.com,
	jarkko@kernel.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH] docs: trusted-encrypted: fix htmldocs build error
Date: Fri, 17 Oct 2025 23:41:15 +0530
Message-ID: <20251017181135.354411-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build error and
warning in trusted-encrypted.rst:

Documentation/security/keys/trusted-encrypted.rst:18: ERROR: Unexpected indentation.
Documentation/security/keys/trusted-encrypted.rst:19: WARNING: Block quote ends without a blank line; unexpected unindent.

Add a blank line before bullet list and fix the indentation of text to
fix the build error and resolve the warning.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---

Tested by running "make htmldocs" before and after the change,
ensuring that output renders correctly in browsers.

 Documentation/security/keys/trusted-encrypted.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 2bcaaa7d119b..eae6a36b1c9a 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -14,10 +14,11 @@ Trusted Keys as Protected key
 =============================
 It is the secure way of keeping the keys in the kernel key-ring as Trusted-Key,
 such that:
+
 - Key-blob, an encrypted key-data, created to be stored, loaded and seen by
-            userspace.
+  userspace.
 - Key-data, the plain-key text in the system memory, to be used by
-            kernel space only.
+  kernel space only.
 
 Though key-data is not accessible to the user-space in plain-text, but it is in
 plain-text in system memory, when used in kernel space. Even though kernel-space
-- 
2.43.0


