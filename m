Return-Path: <linux-kernel+bounces-808691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82819B50382
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D7C7ABFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85535E4CB;
	Tue,  9 Sep 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpVzNZJt"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718B36CC63
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437022; cv=none; b=ryUPrLipbSRRLbzDkon3r4wTdBl91WlYhvAQ/vDXC8qcra48IP7MFpR5uGpF+TYoKzt/5fyX0aYAw0qVnCjRW9BUc/ktcBJY1cTUMtfpbx98GSXWFbN04wgz17M0lW15T/Y5jmKncHPu/ImBuVs0QkvF6Fg3W9FPAWc7ZGSrKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437022; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsAsh9bYSSr9IpP03tUxlwFogfT+9Wggi4c35R0QO8Raj7VTkoIwJunHYqzDASwKlKn02620a9oQFIm7b12mi8J2xxwEioe+FcLQeZJ6JJ4pO2rax/C6uNeax6yXpyBo0qTSh21sWCxMRvV43RGtDxCSa36a3NezUPdbA0G1xMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpVzNZJt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32bab30eefbso4492134a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757437020; x=1758041820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=kpVzNZJtKkHSoVAvzxVjGdnfLP8QtV5M5Gkg/6OZwzfq0kU6TeeKChiQ0qX0/q4VyY
         5cIxBxKxaUuUl1237iLyG+Q/eYrU/lpcGyMCJgrhCHT5E4AhwfwxKt9InzX+Eg32ZnKx
         Wf2r+H7/I4RFrrsbdw2gqSiVrUHG6mELcBb//Yu9oseBnDOc4eoQ7MCfdAtuS5HmN2Jv
         01MQEOzEybnNxlhynwAm8sYlcJIqVUFPSgSr89jlNXYrHOiWjYDLoEAYqi2j1TZZm+q/
         Wc3yv6NMxWn4hJKwASanuTAUw+XlHShR+idsXmF6ZeK/NHF/lpvnw3GSDPIWNrtRYZeH
         V6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437020; x=1758041820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=S9G+Tfg+Bt2nH33D3LvvlHaQPQer+v5ejR+H396qm5slK585QZDLS8nCCjBUAzgbuf
         /hVTnBGDc+mWpZ26ohVW17CzTkZetjkqQ1NYqqIWgFc3gVmNMOBAcwvXVHFqLDa90fyt
         b0+qgix7UF7BS7lgxl3u3Q3vqYXAmAe5EHNzFcASMtrc+lh+EMSj+b8giVWM4hBB+LWx
         MxLh3TexgbzEeIXyphMdbRAd4CVFQgzqqap5QK5bAUxWXUcaGp8FQePmEOH7sJGq98JA
         /2rOLe+4JAnXsb6LCpLzxRjrCz7mb4ourSWD8pRJKTAbBNDZ6DeqwVX5I9g92fMrfVcv
         lNvg==
X-Forwarded-Encrypted: i=1; AJvYcCXoVod9UHG2p+NXDTBjvAxkiEvDU137v7jCZwcugjPWoEVQk+SxoGKw7hZfUJKCpa7lpALNnI4U9m8naVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVV927sygk3DtM8jHmWCu51Tzf9DJo7A3T9CzZN3+A55SBPJ4
	9UrLcDuFUsoIQWShTPu4/Ru800NhFNXODjPgiMrIRHD3P5EPbUbCmIBLp0grf3wW
X-Gm-Gg: ASbGnctX816Nm2OA+uHM3M1/psK5Kee5X1ZptpD0u9v3XtzpScH/ix0lq3aqxw4rpTc
	+Fu1G051HlmyesHo/Ge9CIGwA1/UCjxfRIAkPgCiugGRoX3NOnAeMOyPO6pQi3B9kmfPIXk29nf
	O4tipL8wO9H62h81PbKRzNKBMYPLIArdSQfL9IFizSy7xgKivdg8A2fy1XpMcXMFIkCAmEP3RQL
	fDmLNSI+r61OXTevpmDntalqypEsd27YeBAhDilsG1lce/SYKgIElKcpwS3CGNtBo31xocNk/sU
	AzCVNUQ9DJSJXq5wnOjgXhyahDccik7WBD1P0Tr8g6B739iNGNW7f1nc7zGO0P0xgtZKqFgB76v
	0SHG7WhwrDURQ++2s994DjprViEUr99YG9ASSlt11ZWc=
X-Google-Smtp-Source: AGHT+IHNvVmIh0VbYFtmaYW3XlgcgCJd29hirxMCPVEONgDWHBrkgn+SEMBTEYmL8zzJ/0MPz20xcA==
X-Received: by 2002:a17:90b:4ac3:b0:32d:6d19:37a7 with SMTP id 98e67ed59e1d1-32d6d193965mr13265770a91.9.1757437019988;
        Tue, 09 Sep 2025 09:56:59 -0700 (PDT)
Received: from archlinux ([205.254.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329dcc0af56sm23246877a91.24.2025.09.09.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:56:59 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v3 RESEND] checkpatch: suppress strscpy warnings for userspace tools
Date: Tue,  9 Sep 2025 22:26:52 +0530
Message-ID: <20250909165652.7937-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
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
---

Changes since v1:
- Create is_userspace function to check if the file is in userspace
  directories

Changes since v2:
- Change regex pattern to match top level directories only

 scripts/checkpatch.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..fe580b0810f9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2636,6 +2636,11 @@ sub exclude_global_initialisers {
 		$realfile =~ m@/bpf/.*\.bpf\.c$@;
 }
 
+sub is_userspace {
+    my ($realfile) = @_;
+    return ($realfile =~ m@^tools/@ || $realfile =~ m@^scripts/@);
+}
+
 sub process {
 	my $filename = shift;
 
@@ -7018,21 +7023,20 @@ sub process {
 #				}
 #			}
 #		}
-
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


