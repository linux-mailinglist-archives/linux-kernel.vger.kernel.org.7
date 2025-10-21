Return-Path: <linux-kernel+bounces-863118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76056BF710B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E3506243
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9C33890B;
	Tue, 21 Oct 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="RTOYt8oh"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4833B964
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056703; cv=none; b=cxVGqDEppUgcTVyf8kWsZbkYal/22aCSgZq7p20cNgbERI3AzptRK6QMDJ3+6xBz9hw2bcMOnS/lMhBxQ+4ib00qoRwq4yHBnW/Vl4iOr+jYhl9bVDhjW6homNyD4hRFyvXociQit+r6tLeESAV4qVr4H3Ta+a9AHoTTz8GYxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056703; c=relaxed/simple;
	bh=nJ8qmVLEdW1ZEKtkDKPhjo2mIQSR4IMCnR1vG0g39L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jwQbWeq7qRJl7kurQ4Ds1N4A0Ee4kj3CphKbrpeRrUGYSeFItR+9HRoSeJZe+7OwkzqJoVko7gKFFdVs1fAtUbBKuITSNzmJ4v1ar6Vwte/dx8qc8BCDj75oLRWubNccUrPpaA+Y87nBSF6MZzwT2euBp1I6M4y9hrqKE+vLgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=RTOYt8oh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5579235200so3654843a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761056698; x=1761661498; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5yrIH16VdtQnXKqOoCR9M7OMtn3Y/VQPkSPu3Ni2NI=;
        b=RTOYt8ohQ3EnXutc0k0kdOQqTB9dllt9mOu7g5nFPJ9l2X5laOKs1oMtIhdnxcBbz4
         rMJnQg9YzOkAn373SMOdEIJ1RlvrlPrIwj7Uh0Vfsdrag9taYIiF14bBYjWOV2tSEmPW
         m3PTf+Bgsg1K4esMBQBqdfazXvHAXgCS3kO7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056698; x=1761661498;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5yrIH16VdtQnXKqOoCR9M7OMtn3Y/VQPkSPu3Ni2NI=;
        b=LC97nnXK4I7i2lH+dJJOa/5elm43h5bl3+Ehip3x7PMDjp3Mh7kUwRL9GQX8vJMfvT
         5ypAlcmZmm0E2feupUApRV09vt0ES0eLrzef3TsWISqwWx18LYBLBo/yFt1KD8b1Unxe
         5rYhwppTfTqy3nQNpXCVnJ020TsLnfvk1q2jfI+ppTFr55wUM9eWXNODW3kMX+0KVxZD
         7uhEcM+t3JkfPHT8XxrI8m6U+1/eFfOx9qZ6fkt6ib6tI5ixfhvCLKUGqpGd+9B0zjuu
         6F/qQkVekoMUPzKcpbjBiYT4mCgmcfhZkOsekit7WW2/8iV2N+bHMLbvjNI4hJGOcm1m
         6lHQ==
X-Gm-Message-State: AOJu0YyOn4P2Z4wmkVzelDOxOsPsqBgR/nmUu+KtFa2ODbSfyUjmUu1M
	tJXPN6ch2JQOBDR8DpOiWHTiDRAW+KG/3SMvBeNiBvQQMon9TTVa+MmzaJNvne75gHIXeh1dtp/
	gkQmtHQUn5BN5pb+5AAjfG9XVtFFfNcH1JfN5iy1wx/fTfvXI3o8e1s/32HqK92/KLANF7K2cCM
	A=
X-Gm-Gg: ASbGncuIWZN3iyyYtpaBpvDPuMteBcjELMCk/fE8BZXnnvLjN9SktaHLU6rE97sN6yu
	jI+XmGeNZp7aPmda2DBmjjN6DwQox/WJDpP7FNFMST12n3iUp0ZDzurSSRTBhjh4uwRu47LyhdW
	zgXBEZk4M4MbVxisbNdZzKesMvKotQ1AmakKL54BvvR2EtXJzI/NOEWZvHTp1cmHyNxogTPpqq6
	rFaLpi45yhhHGer1AjawfqIIBDmTXwCEBl71Bq9jfz0xj2GAWCEROOKBc9TzeUCIvwz05+N06qL
	7vxlr5F6o1XmsmoWn4/O4/SZnuAhuPdYbOlwEcFRt5CBzTCbi3OIjc3SKuFlLikw7Lr6k8GwMo+
	JmS8QfDuOL1SsCOBHAT1J4PvZv1Pyho1PArjirebh2dn5V9xT4CzCg3Nd3cOKMaE3xx1jdGXqmB
	3tb9cWL7cwwlit0Rp2WvwEbUl4qiQ5NSzJmHOHd2pyQxL14O0zrda/nmoH0DLKLEl+WGBDFVx5L
	HbY
X-Google-Smtp-Source: AGHT+IH8jNhH9Amt7Yj3lSS+yNuB5baQk6aU5WZR43d0YuxGanuuOJ2pn7ncx3+h2L7IStwIGUzvwA==
X-Received: by 2002:a17:903:1a4c:b0:290:ac36:2ecc with SMTP id d9443c01a7336-290c9cbc190mr215744485ad.18.1761056698185;
        Tue, 21 Oct 2025 07:24:58 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc83esm111652815ad.38.2025.10.21.07.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:24:57 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] spell-check:encryption spelling fix
Date: Tue, 21 Oct 2025 19:54:51 +0530
Message-ID: <20251021142451.35451-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/crypto/sa2ul.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sa2ul.h b/drivers/crypto/sa2ul.h
index 12c17a68d350..b743476ca12c 100644
--- a/drivers/crypto/sa2ul.h
+++ b/drivers/crypto/sa2ul.h
@@ -124,7 +124,7 @@ struct sa_tfm_ctx;
  * Encoding of F/E control in SCCTL
  *  Bit 0-1: Fetch PHP Bytes
  *  Bit 2-3: Fetch Encryption/Air Ciphering Bytes
- *  Bit 4-5: Fetch Authentication Bytes or Encr pass 2
+ *  Bit 4-5: Fetch Authentication Bytes or Encryption pass 2
  *  Bit 6-7: Evict PHP Bytes
  *
  *  where   00 = 0 bytes
@@ -298,7 +298,7 @@ struct sa_ctx_info {
  * @dev_data: struct sa_crypto_data pointer
  * @enc: struct sa_ctx_info for encryption
  * @dec: struct sa_ctx_info for decryption
- * @keylen: encrption/decryption keylength
+ * @keylen: encryption/decryption keylength
  * @iv_idx: Initialization vector index
  * @key: encryption key
  * @fallback: SW fallback algorithm
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

