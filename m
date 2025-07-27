Return-Path: <linux-kernel+bounces-747094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F0B12F94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA3B174C68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0838215798;
	Sun, 27 Jul 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqhl9wX1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA544212B2F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753620658; cv=none; b=ZjHKM1C84CGsRcnByZeKSvQbnFaBR2T+kX2OveZ7ArOyMpS7CP4Vclm3gFPssDTS3Kbm6cRDDdjQ9dWmLfPqmIHHjN57mj48aSAmCAJvG0hDH0tW+QZ3UMpcQx8jdtQ1sUP9OfVBMnM20XqWcRF22BO1jfA61YkOnNWwL4fPEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753620658; c=relaxed/simple;
	bh=qphoEMJcvtchYG0cd1lDMN9S2qws/1jokATGeV0IvRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhE/tJug4FRj5rify9a3xPp4JkHSllnz1f3RqXnMpm65XlOlKpmFbba7ZTIU8aJZoGW1UrYfZfJMwlgINz6iEZOq1sv03SfTPD4OmKCxL3Qp85RZHSEtmxj7W8G0W3Q9TAin1Wa555FRYzKAUdOgVJ0SaYrk6VDl3jvIreXw+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqhl9wX1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b54af901bso2292537b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753620656; x=1754225456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OniimkhjVvSRmOjn7OfXVTo4mIJlM2vbjYTCYN8vti4=;
        b=mqhl9wX1WB5fg46dmkZM4JMA98KRQvT9iYOBqtuBVxNoy9nrVIAFJJ65iTwt2JeFU9
         hhxtNE1LHWTrA/LzG5niHCmyogqjcpye/vcME55SsqtHvNAbrW7He9G3I9mLL44P0wjW
         FYpQ3/tTbSNhupK3GT2n6Q27n0ycyCcneT8sSeEwkUyGjy7Vcr4IYaRS3vjM/erEgKzG
         1RSWA2m9FGQeNsQa5ijm9lqL4OaMUzdWOvGdZWLxe6SekM+35wjKsPf17ZpwAFUWG43c
         vPHrjLGBNZIqGXmm9AtRslCFK+IbsXedBInthbCCd/oJcYj0724mBGosOeEezJFDe5Ya
         rpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753620656; x=1754225456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OniimkhjVvSRmOjn7OfXVTo4mIJlM2vbjYTCYN8vti4=;
        b=LRfdlAf2MDDUiL0/8CKb5IOc7G5nHZg3YDaIqwFU5oxwfq5fdAvZLGAPJc0NA/ilZm
         vc6xygR/kHa8+hrzlkgvsyH1aWz6LG+El+lM+pelYeuw/18cpRZ5RDqO9NeO4s5GrdQu
         JQmH8UXD68CGEJtaq7qkB4RKl8EaXVi2UM1IllUjvPcgMZBUMA/VNrCu5vUpQc4xO7+/
         iMlxzpsU0auj+QlPIgg5HuqO9cu/5z1z/eHykJJzdaTFxBz62gqVxP/B1AbjMnGC73eh
         wAw+IOF6y3m+T53Xn9qhRT9oxDf5qZLlH7s1sJ8hUVto0KRhYXHt9EZYtLo//TXhre++
         z0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWg1FtjO1WSKA/DLVu75TfDQQN0+xXOQgrXy4T+dc8v0xYx1IZW6IE0uF6dErrQT50Ccy0Ga6mqCdkdrVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaizC1cScmdG3N3Ec5qL7IF3eBuoj5GBXMMKNNbvTxVNd8TpKv
	OVeMb0p/7X1R3y/1dEEnhMdVFN9cn3fvVq0rXTehy+ML32feLh5J6swg
X-Gm-Gg: ASbGncuvN8J86IrGcGgRq9Xk5ztNSDUCKIav/rZlBEfs16xDNdBKJqvin70DYAKtkJv
	+VNQ+ekXxxdy+psDzxIqAtIbpWt0Pqe/ZH5PTyZxhpsxIp2S27rNIsKm3AOnPcsGNR7WGTRDAdK
	T1kdRMr4rlBag1TU411Xnl5w03nqcBr7JKEaX2JUNz/AQea1/TeVGGb5GGsLPG6qwQYcL2okxtL
	UtKHfkyG2ysvVUoNFQj6KpcNbK2XjoWkrxACiYXJp+YuGzozL97dsy7fDbiiNRGzzu8xYQIex8s
	W068CfXdAq3nr4soh+d+plMkTEu4fTuxBQVKb2gkNFA5p+v8CokeUShfdEVPyen/NiQvThVMtlP
	dvYMuiSw7Poa5xanITvo8e/1Kb/FxDNI=
X-Google-Smtp-Source: AGHT+IH1flJT/T4l3mHSvsO0oBzDl0gqh5Ie6QQ/+2/IZOeyCeYqWnPuNL8IEyNBDHU0KD+WMklzow==
X-Received: by 2002:a05:6a00:1890:b0:748:fe1a:3432 with SMTP id d2e1a72fcca58-76336a3b834mr9228192b3a.9.1753620655613;
        Sun, 27 Jul 2025 05:50:55 -0700 (PDT)
Received: from archlinux ([205.254.163.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02640sm3471873b3a.37.2025.07.27.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 05:50:55 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v2] checkpatch: suppress strscpy warnings for userspace tools
Date: Sun, 27 Jul 2025 18:20:44 +0530
Message-ID: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch.pl script currently warns against the use of strcpy, 
strlcpy, and strncpy, recommending strscpy as a safer alternative. 
However, these warnings are also triggered for code under tools/ and 
scripts/, which are userspace utilities where strscpy is not available.
This patch suppresses these warnings for files in tools/ and scripts/.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Changes since v1:
- Create is_userspace function to check if the file is in userspace
  directories
---
 scripts/checkpatch.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..472cd8aac9c3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7019,20 +7019,24 @@ sub process {
 #			}
 #		}
 
+        sub is_userspace {
+            my ($file) = @_;
+            return ($file =~ m@\btools/@ || $file =~ m@\bscripts/@);
+        }
 # strcpy uses that should likely be strscpy
-		if ($line =~ /\bstrcpy\s*\(/) {
+		if ($line =~ /\bstrcpy\s*\(/ && !is_userspace($realfile)) {
 			WARN("STRCPY",
 			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
 		}
 
 # strlcpy uses that should likely be strscpy
-		if ($line =~ /\bstrlcpy\s*\(/) {
+		if ($line =~ /\bstrlcpy\s*\(/ && !is_userspace($realfile)) {
 			WARN("STRLCPY",
 			     "Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
 		}
 
 # strncpy uses that should likely be strscpy or strscpy_pad
-		if ($line =~ /\bstrncpy\s*\(/) {
+		if ($line =~ /\bstrncpy\s*\(/ && !is_userspace($realfile)) {
 			WARN("STRNCPY",
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
-- 
2.50.1


