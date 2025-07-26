Return-Path: <linux-kernel+bounces-746849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBADB12BF4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F020B17FF2B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C828725C;
	Sat, 26 Jul 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzpDesje"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8A219300
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556083; cv=none; b=gOfteSh8I73H5OFY7Gtk91sqSwMU0nkTRvlnT2eC29gLZNWNjUp35QRb/EgF3N22kQkCAG5E3yy6tqWebdDROPb/Vf7jvciJS4/LE+pESoXRjhaGBzKg/H6FtxRN4UcEopwdZFWYZFZ+1MahVnRvvURFcm3XtvLO8XJYk6Qd2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556083; c=relaxed/simple;
	bh=jN/bOZJKSgFzgJ9o+tglJc09DttMQIfo7cYiDWe4YGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnUSpiG4UgFuqBkWgLtilFnNvROxCwTUL6hQrqct4M3Hz5AW5Itie8G15kNZxlqBEq1c1NugoNZouK7NxvCeoOlgp3P1Xt++lUr/Vr71M9Saj3CnnBM9eZeRFNnNnfURZDMm4TlNklFk9MQqTBvPDoCKl+tStcgdlg5LA4rKedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzpDesje; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23fc5aedaf0so4569355ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753556081; x=1754160881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kVErw+2M73e7AcLM+G/ti+P0e+oCHBlDMfj/liYyqY=;
        b=LzpDesjeyuyL//Rcqd+V2zHTj2O1P2oPKxzmzGI/RJ4dhNQPYT7KTqu4waQfrsYOGa
         BjbkHyRiC8abaN192kEB4+q1sPSRx1TWBUYAAk4CtwLccYjIHqnLZsPX7L/HkoDt1SLC
         aiYqT+0mtpYUoMlyymWO1kgmzHiwnTTdWcX9F8zR/lEVBV1LUEXUogcJAK8l3Uhdo4+p
         8VU9HI9QwTWJQAjpS32CN5qOiIxVfy2/K9IL2ibdUAjyNSNbCCpsjNeMxAmpcYpF8x8n
         MCFutYPhYGzK9eMCRWpxBYfm17mZeiLI7ZI5zblVioARcPNkG2cJyB1noSEaG9CCYIuW
         S2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753556081; x=1754160881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kVErw+2M73e7AcLM+G/ti+P0e+oCHBlDMfj/liYyqY=;
        b=iG9+SixIsCnsGOE/0A0zJHQqK2tFgHWaqNv/CvrzNIrB+wGpxnAqHUWaxUwfAplIkN
         M6sZ9dU3Gh0CvQ7NK2DBXDT7qNvCSHBDf8FHlt5496DGlKmtwZleU/anUbZasv03eSGa
         m1vgseTCcHMREizrE/By0uBKW/t3dhuvGpbrTCUFcHebgL9KvXxxeT+e5uOQnf6ORexe
         1zCOZCMZ/J/KiI7HSNaNncR1BtGzKgbEp9SH4hk/Dh7XE3M8fDPKDqdrX3I0TvCy2wIV
         YfO+pA5mA1iGAmezKeKTn2NKB+McC7Ks82+b2Jz9PVf82830srGYwiwO6M2F50wTlWZR
         tIjA==
X-Forwarded-Encrypted: i=1; AJvYcCXKj8+P8528aCsSkosDvYPdHSXslnqv8NBI3DGM39GsJM0zLVGr9yHjpNEjzo7fpf52PngUgRUUa+aD0pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvOw7arZ/NB1QWCPguAOAiFF9bLq/K10pedCSvbz+tB4EuCBa
	46b5csVwESW1rfEn5OZJmpmf4J+9VWddo4khxXAvCxXbQ1M5L6DcFIcnFJIClIe16pfZaw==
X-Gm-Gg: ASbGncv2fIBSJBCiD18t6to5ixFAbsZPBg7OmY8kJUvm2JBYHlNs2kqYv788uBKf52K
	Rhfq2Da5WRGhikD5ya8ZEMurE0yXDiLHbi0cuX9JfKsz0QB9stgssgVESUyoz20uUtlSKvVw9mL
	ART2f8jpNGI7Qicwm3EcLI0Ifpd4Qf/sZ4jvkriyzitZRkphymC5Cp1oDHYENiUuEUrepr4uRpt
	0Yv0I3wKGl25FIRwhiL4EdlqMz5Ir+sJ+MF9ceyXGvuZ3tzHe3qWkJgUTcivfR6rEUoHUQunrPE
	kyj8eUyl8w9AVaksdQqwKa0NlQfpZ21FVOLbgo1Odqz6yZbEFo2OO95wtwFlbt58tZCZAt5G0+7
	cmN8HKABOoiYxWnW9Iu75NBQypioN9g==
X-Google-Smtp-Source: AGHT+IG0sgdycRxmHC8UktEn55Lgz+Tj0EvhZYQqjFKoAy4OyWyzTwjzmUv5uOmTdoMhzt20izQ+Zw==
X-Received: by 2002:a17:903:204c:b0:23f:f96d:7579 with SMTP id d9443c01a7336-23ff96d7ab4mr5422885ad.37.1753556081277;
        Sat, 26 Jul 2025 11:54:41 -0700 (PDT)
Received: from archlinux ([205.254.163.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe512d29sm21363395ad.140.2025.07.26.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 11:54:40 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] checkpatch: suppress strscpy warnings for userspace tools
Date: Sun, 27 Jul 2025 00:24:32 +0530
Message-ID: <20250726185432.162632-1-suchitkarunakaran@gmail.com>
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
scripts/, which are userspace code where strscpy is not available. 
This patch suppresses these warnings for files in tools/ and scripts/.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..1533cfbc8305 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7020,19 +7020,19 @@ sub process {
 #		}
 
 # strcpy uses that should likely be strscpy
-		if ($line =~ /\bstrcpy\s*\(/) {
+		if ($line =~ /\bstrcpy\s*\(/ && $realfile !~ m@\btools/@ && $realfile !~ m@\bscripts/@) {
 			WARN("STRCPY",
 			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
 		}
 
 # strlcpy uses that should likely be strscpy
-		if ($line =~ /\bstrlcpy\s*\(/) {
+		if ($line =~ /\bstrlcpy\s*\(/ && $realfile !~ m@\btools/@ && $realfile !~ m@\bscripts/@) {
 			WARN("STRLCPY",
 			     "Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
 		}
 
 # strncpy uses that should likely be strscpy or strscpy_pad
-		if ($line =~ /\bstrncpy\s*\(/) {
+		if ($line =~ /\bstrncpy\s*\(/ && $realfile !~ m@\btools/@ && $realfile !~ m@\bscripts/@) {
 			WARN("STRNCPY",
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
-- 
2.50.1


