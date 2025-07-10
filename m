Return-Path: <linux-kernel+bounces-725257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F97AFFC80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45E21C27960
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D429117A;
	Thu, 10 Jul 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cePqKeFs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8929009A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136547; cv=none; b=VsjIiFLcS5bB+2ClcLUbw8ZNUuYzg7bAZsPzEVt/2/oRVYvVuuXBwDB1+xCg3avD/888ATW7by093l5/Txo6N8GpYVn8p5EKN2PFUo2l69VR33Iz5++eDYTaFjOcN7g9K9aTOQhRpX6G1ER1/w1Nr04cEqj4HRnJYrtf8QWs3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136547; c=relaxed/simple;
	bh=d5di5HzftKV8939xRBa1b1yblY0USW29MqZCUuqgraA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qTH9osTvxNIKN1vCc7IkrPqI5TvctLr5RlCQeUSGv9eCwQh5Oprxb4R/PShto/iYt56lMnlanQ/ha5cKSxCyIg26oX7XXsbvrIFbwHQveac0Eiq53O0Gw0SuPcpU7DTORFBAWpfhSjDVAteZGKaxCZVeKizGpkCWdjape7X0FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cePqKeFs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237311f5a54so6453445ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752136545; x=1752741345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzAnVGMIiXBRTiiP1DJESZEHpVWEA8ASRbQw4C/IcNY=;
        b=cePqKeFszChCOE+Dt8qztGKV7WAemifDoOJFzH1xdxHdP/P+pTmzCLTwQAg8wUoYt2
         5lYKqpeHbgtqOJZcGChoTQkJgPn5GQPWcg3DJFDANNp5m66pzVrncGNdamsM+YBWoDT3
         gw0E2Z35cohqL6Y4Tkd3ZNkt2DpnKXU1amHHT+USJzxbaeH6GtVk1piyVnefLOhnFkuU
         shJrv8bLYHFAv5amKmwvryWFOXHJit2hzzTLpVCaBNkV0zWQpx6hRSd8bihaqYIfCKcn
         zvT2HHKY9qyFTFL6ZiO/dHC7ZSnhVC8Mkaf33ISlbOPeeAEGNhmKAi95bM+0OalKSVpv
         LsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136545; x=1752741345;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzAnVGMIiXBRTiiP1DJESZEHpVWEA8ASRbQw4C/IcNY=;
        b=PzSA/O52KPU08hZNFbNWe3ZuGKeSADx63G1/HuaA2XuxoxNTzx5XogFELO2JNLoL6a
         6VUSqKVsqnw1RBlVjCvbpuk62OEKCHz0e7xSnxNAjdXlyvCXPWVIUd9Xl8Lgz/2Fkw1f
         q8gDwpccGmr4+6Chhib9S3BsqWOj7NVpOqbgitQrLYgJwDqey5TjTPw3S8fj2ZbWnnoJ
         P5/dbPsP7PQfJpe6cGNnv5qCSEoXqZC+mPkSoI5GdogqeQc1QgwbIWB5mPHPFkDOwfxJ
         XWJWavx/3Erz+j6ApXJTJvotQAiKVPN1R8RRccTLgMvGxvyfLgv31WCR92t2u1KRi2aV
         WXTA==
X-Forwarded-Encrypted: i=1; AJvYcCW27H+UpWvsmf3ehKs44Pr+yRSnCb8xX/8n0YTABfbTxz8LVGansbNOC5iaihhnupZcHPEpRYOoDDs60qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeYD90qPF6SAq882GhWznHFmyZrxxNGItKymJLub2Db0B1Hgv
	BVmBM7iUVo3cpS7CCELq+0yFmuo9KpEdbG5ARulr0hH2S+asVmyEHEl86WitTXBRMbY=
X-Gm-Gg: ASbGncuG5FbAmmr3NQct7p1MPZDtAOCphzZNDtpCCeNOIAZVSmWPgY/aIk2n1uB7ASs
	i6/8+8VL0rIsKMVHrCvuFJPQjDoC5kDeWyXxbT5e/uH2NTM8uh2VEEiA0qMq61VsY1zG8eLJKmV
	LkTJ4fG0+Ln+0t6j/bYyGV+ZiO1P4dsdMe4VFnwvGTSTPLnkpPTBRDsGlHhVFRLezpZ2md3+L31
	GiNWOSp4q0VmHCf1qAl0Q0M6I/v2b0GLwEEib5SZuS85Z2FIu7uDNVWSkVwI15BG7LTFY/bRk5y
	lf9Q5bLq+kgd+5fXD2j0beFwO38UyBaSELUJzPnwBZkbdbmv09naUZm3hL/zJCKbmInj3DQNH37
	MvPrhZI/7mXlHJDl+pr0ri1H/phuvgbZozw==
X-Google-Smtp-Source: AGHT+IH1FXhHwkry8rqQNj86eFDFhygFgtZv0mBNeYCTjKFwkJESXNg6db3VIgb1DHM/glR9CTJNLg==
X-Received: by 2002:a17:902:f70a:b0:234:9375:e081 with SMTP id d9443c01a7336-23de488a306mr28819485ad.42.1752136544667;
        Thu, 10 Jul 2025 01:35:44 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad3absm15392655ad.83.2025.07.10.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:35:44 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 10 Jul 2025 08:34:31 +0000
Subject: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIABZ7b2gC/x3NQQrDIBBA0auEWXdAk9ZKr1KCGJ22A0HLDEhAc
 vdKl2/zfwclYVJ4TB2EGivXMmAvE6RPLG9CzsMwm/lm7tZgpoZxpwOFNbVQaqGwxRyE9po0NIt
 bdObqnbd+cTA6X6EXH//Hcz3PH9KJvINzAAAA
X-Change-ID: 20250710-dev-alex-riscv_none_bad_relocs_v1-ba6048681836
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=d5di5HzftKV8939xRBa1b1yblY0USW29MqZCUuqgraA=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDLyqwPF5OJaWuILDlRcb84/K7Xr+CGFdb6az+zXXWEMk
 /77w7m8o5SFQYyDQVZMkUXBPKGrxf5s/ew/l97DzGFlAhnCwMUpABNZ2MTIsD3BZOkaAZdzSwpc
 lpyPu/Yk6vXuT0pLJM/OW5590VLk/SWGv2IqB9jKEu4/kgqcFPGwWtrlwzWOkiyvaVfUth1zPsJ
 oxQoA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

Even though those relocations should not be present in the final
vmlinux, there are a lot of them. And since those relocations are
considered "bad", they flood the compilation output which may hide some
legitimate bad relocations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/tools/relocs_check.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
index baeb2e7b2290558d696afbc5429d6a3c69ae49e1..742993e6a8cba72c657dd2f8f5dabc4c415e84bd 100755
--- a/arch/riscv/tools/relocs_check.sh
+++ b/arch/riscv/tools/relocs_check.sh
@@ -14,7 +14,9 @@ bad_relocs=$(
 ${srctree}/scripts/relocs_check.sh "$@" |
 	# These relocations are okay
 	#	R_RISCV_RELATIVE
-	grep -F -w -v 'R_RISCV_RELATIVE'
+	#	R_RISCV_NONE
+	grep -F -w -v 'R_RISCV_RELATIVE
+R_RISCV_NONE'
 )
 
 if [ -z "$bad_relocs" ]; then

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250710-dev-alex-riscv_none_bad_relocs_v1-ba6048681836

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


