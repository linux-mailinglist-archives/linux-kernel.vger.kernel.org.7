Return-Path: <linux-kernel+bounces-768041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A06B25C42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB80163ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AFF25A327;
	Thu, 14 Aug 2025 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="n1p18cVn"
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11B258CF6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154335; cv=none; b=gu2L4Jp2BSKRDGRQFsOdjFTZuTYE3gZSjnMqLn6uepGeHaFdLICF1sL4LjKVTALQdIk6KF9Xnc00KgGyJ61Vb/+S4h92nMwhVKAF8xmOapvYwD4JqVDbuydTGpeKI8NBt/DJz9FXKPFggZPjAkMCMqVWCJlgxyECSW/dLeBmJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154335; c=relaxed/simple;
	bh=0SONc79+M4F5Fy8quIOdueQ4jkrHUL1smlCPEM8IKVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YUHNWoZZCvZWoHatkTp/Xoancuvk3lPJgaMuAGhSm9orr3U/WIdGBBSPlRYYPzBKhAvzpNNKiUNSFo/kC6gZvp1mJBNmw/zYHHmZ18ulPI+CMXd7FfZeqETn1/i0znITXNvInbToGpTz9a9UdGrKj394Em8fK6lQcmiFe2os0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=n1p18cVn; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E6DbnP010750
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=pPtIzBQ4qqBBxPwXppgvPl9H8B
	j48UMU3Ie34Hi7Exo=; b=n1p18cVnviQwI+tkl0s/942e5ixuL3oHE6aDbHQXYo
	Q7nsyy+ghUsxCpTx2ol/PVft76BVQjcz3hQAC9+AkNHbtEYYNCVlbW3lA1b3JRrt
	NJLScgu5nrJVZ8uj5fenNz/ZhlSBbj1iQbj4ggCr0Ijqhs7vFzVuFsE6lPfC7nXc
	OVh4UMrYI94jrLkE8aaHiIKyVqJER6Pf32z55AcpaNCrw2/KrN+rlQwVIKgybkTQ
	d8Is0Lsst4CbzpN5AwmbNd1HfrvOI9it8sfOqGs7ke7rINywmlI++IZjjMDMkyhb
	4Wc1QHs8s6Z4fBvu1Ln7MXeKFK/ZhuecTPrbSzg28BeQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 48gqh47y91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:52:06 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c4d944so15034121cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154326; x=1755759126;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPtIzBQ4qqBBxPwXppgvPl9H8Bj48UMU3Ie34Hi7Exo=;
        b=F8eb0GyXSQpOgfqlC2UP1jrTXoS18Lhz/VhghcvDtLqC00zkMCp4T+9kAz/zSMpxr1
         xgvUPxlcrHhv6H5nf5TOdiaM/y7pzOFTXuS5ntBTIbFfz/8lMyDZLze9Zl5Z8vHKMfpl
         1HNaViB3ebuQOQEzv5Rg72/TryI5D5I+PYGKrtER4v3fTU1uSvvyjkQaufo2H4IXjGkS
         2TKNefLiucNHdFLiHM+1+MP06EZBeKn79qfwGKflQvAnDqviXG3Wt4kGfSbQDNh+x95a
         Lw6Ufdybe8L4T33wSfRTFb6nIx9lPypHmi28IIQ1eTduRWbGHyzAlELzk0U604Gs4SNS
         5yag==
X-Forwarded-Encrypted: i=1; AJvYcCWIJ8/SL37wOlQq4S+IfMyXRZTUBKii0aYi6Ppmms7d46HqjJwPetk3wFtNHwSspXcAmuV/LFC9LBCCGGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrXHTEobLkaxhpn+t9DAEvBSa8gpjZSHp37trFhKYtmK9UmMR
	zqNxw3Uo5DU0Pbt/2rFhgiz9VTlVp2M+2vAi0wKjNtP7XRX/8oVMlwyzsth1QgTHGl3uMlUp+TF
	oL1TCOWjNQ990nh76mPjSuRUc+6xNxYz5+ezfyNCNqaLV61qlhqQn/UKpMtN19sdHKvpiwLcc
X-Gm-Gg: ASbGnct05vKjIcu5l5eWNxgDYUv5Etr7XJoaiUcz+VeDtktEd+aDghnWnVe8Q7L4INL
	Zb6jPvIUioJfcnYiO2avMWrjwO4bFhX71U4F7LNJKnIuENwzyRseLLEEva4gV02qLYXMlUjzcRS
	KkW4juLN0W3SkFq0BtGBWrJT/PVg+amHjM87+VQ6GO0q8g4tAMtYaq+9r9Iet5LYTTg8aZZHZOm
	TDkH/uEMztctnt451LysT5oAGPlVAlPLkeY3PY95tZn6XJDkyM+1dSl1pjG8s3UiKiBtENsWiiR
	khuhaRSgD/mHu1rdVr1Ja/gERfFXpqHqiuntSZKciYI3MZDe2/NT180FbSep5aZStYrDSqXSCID
	r8FY8yBXLIg==
X-Received: by 2002:ac8:5fc6:0:b0:4b0:7439:4578 with SMTP id d75a77b69052e-4b10abca984mr30407151cf.33.1755154325674;
        Wed, 13 Aug 2025 23:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq3dv25BPBGO1UYoji2p0IQ0vub/2hHhl7EyabyDycDYiWSKHCHWs+yzKSpVyt3zuaUYEdcg==
X-Received: by 2002:ac8:5fc6:0:b0:4b0:7439:4578 with SMTP id d75a77b69052e-4b10abca984mr30406941cf.33.1755154325184;
        Wed, 13 Aug 2025 23:52:05 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-183-206-55.red.bezeqint.net. [79.183.206.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b7ed5edsm8484345e9.3.2025.08.13.23.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:52:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 Aug 2025 02:51:57 -0400
Subject: [PATCH v2] lib/crypto: ensure generated *.S files are removed on
 make clean
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-crypto_clean-v2-1-659a2dc86302@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAIyHnWgC/3WMwQ6CMBAFf4Xs2RoKBdGT/2GIactWNsGWtNBIS
 P/dyt2807xkZoeAnjDArdjBY6RAzmaoTgXoUdoXMhoyQ1VWTdnxmmm/zYt76gmlZa0Sg+hqFKV
 RkJXZo6HPkXv0mUcKi/PbUY/89/4JRc7y+PXCVadM08q7dtP6ViTPOKzQp5S+MvHqsqsAAAA=
X-Change-ID: 20250813-crypto_clean-6b4d483e40fb
To: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755154323; l=2612;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=0SONc79+M4F5Fy8quIOdueQ4jkrHUL1smlCPEM8IKVs=;
 b=NHnqyN7w8qQyUx+t4c/nbbab14Qyty6Dm3TJiJ1XId9/KFWJbXKjMr3DyN//ekqiizOmcScVk
 JR2pxo//yZNBpl/uklLjefLU8iRe5CmTEJH/p0jpFzY0rb11pKCHflR
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA1NCBTYWx0ZWRfX0Ve3gHdKFw3i
 jBQpIw4tlm6o0iBC9dgFt9Ol6ZKGbMnm0j+ZHOHgQOg2zRvPJRNsPubs136bfujC1NQgDB33U0a
 uPdOnYp1QC/AhO42W0QCCCpExEv2KuLOF+F2EzkmOJsi/ZodjRtZxl3rmCEcD8wJHea755hNThM
 s6c2RuspLftcQijsCUegoDVv7Kze8ezVHlB1rUYSE+RRO0yT1ZH+BSiSOQOTBujEWp5HW7XL4Ge
 twvHX33y1YGgEpebsL3I08SGnVkRB8vhXY4XM5T9r/Q87aPGgjBze7dq0vnAAaj0TCj9EZ0qBg/
 qshwZFNUcBCDJ479/I0d+OE+Nd5FCS96M3Cj7BhUgyzsWAGN0p6SILklTkMTbqaQNkpwOzvr5/p
 4VedfdUi
X-Proofpoint-ORIG-GUID: JXSLjUo5-mQQbh8NqwhZqfGuJ0WV0ADO
X-Proofpoint-GUID: JXSLjUo5-mQQbh8NqwhZqfGuJ0WV0ADO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=10 bulkscore=10 mlxscore=1 adultscore=0 spamscore=1
 mlxlogscore=216 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508140054

make clean does not check the kernel config when removing files. As
such, additions to clean-files under CONFIG_ARM or CONFIG_ARM64 are not
evaluated. For example, when building on arm64, this means that
lib/crypto/arm64/sha{256,512}-core.S are left over after make clean.

Set clean-files unconditionally to ensure that make clean removes these
files.

Fixes: e96cb9507f2d ("lib/crypto: sha256: Consolidate into single module")
Fixes: 24c91b62ac50 ("lib/crypto: arm/sha512: Migrate optimized SHA-512 code to library")
Fixes: 60e3f1e9b7a5 ("lib/crypto: arm64/sha512: Migrate optimized SHA-512 code to library")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Fixed clean_files paths
- Link to v1: https://lore.kernel.org/r/20250813-crypto_clean-v1-1-11971b8bf56a@columbia.edu
---
 lib/crypto/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index e4151be2ebd4..539d5d59a50e 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -100,7 +100,6 @@ ifeq ($(CONFIG_ARM),y)
 libsha256-y += arm/sha256-ce.o arm/sha256-core.o
 $(obj)/arm/sha256-core.S: $(src)/arm/sha256-armv4.pl
 	$(call cmd,perlasm)
-clean-files += arm/sha256-core.S
 AFLAGS_arm/sha256-core.o += $(aflags-thumb2-y)
 endif
 
@@ -108,7 +107,6 @@ ifeq ($(CONFIG_ARM64),y)
 libsha256-y += arm64/sha256-core.o
 $(obj)/arm64/sha256-core.S: $(src)/arm64/sha2-armv8.pl
 	$(call cmd,perlasm_with_args)
-clean-files += arm64/sha256-core.S
 libsha256-$(CONFIG_KERNEL_MODE_NEON) += arm64/sha256-ce.o
 endif
 
@@ -132,7 +130,6 @@ ifeq ($(CONFIG_ARM),y)
 libsha512-y += arm/sha512-core.o
 $(obj)/arm/sha512-core.S: $(src)/arm/sha512-armv4.pl
 	$(call cmd,perlasm)
-clean-files += arm/sha512-core.S
 AFLAGS_arm/sha512-core.o += $(aflags-thumb2-y)
 endif
 
@@ -140,7 +137,6 @@ ifeq ($(CONFIG_ARM64),y)
 libsha512-y += arm64/sha512-core.o
 $(obj)/arm64/sha512-core.S: $(src)/arm64/sha2-armv8.pl
 	$(call cmd,perlasm_with_args)
-clean-files += arm64/sha512-core.S
 libsha512-$(CONFIG_KERNEL_MODE_NEON) += arm64/sha512-ce-core.o
 endif
 
@@ -167,3 +163,7 @@ obj-$(CONFIG_PPC) += powerpc/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_S390) += s390/
 obj-$(CONFIG_X86) += x86/
+
+# clean-files must be defined unconditionally
+clean-files += arm/sha256-core.S arm/sha512-core.S
+clean-files += arm64/sha256-core.S arm64/sha512-core.S

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-crypto_clean-6b4d483e40fb

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


