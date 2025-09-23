Return-Path: <linux-kernel+bounces-829402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0710B96FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A0918A5D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49A27A127;
	Tue, 23 Sep 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNjzvTCi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22461BE5E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647853; cv=none; b=qc/rtfdZL0cPbJKY9/XfFXbxAUbtOWNXdk+WxNyy4GguYcSM2WkXjx0CZVhnwx1K5yV6OFGJEGWi/OlhLrdJ8/1bClsUAjmgSFWifDBuvISxDBeIi6w/DwTzIJqaq1xjdtHardknat1Lh8FWzBwwnrKxgA6k4lfkb/vbk37s0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647853; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDpWnF5LVqeZ+FCt+yZszIpnMq2/8BybCWt3BU9bOx32QFtp9UvZcn871PWoyfKkU1tKWgHdLMFKuIQF7AeaSie6auQoXX3beeWVg85Nn68Rc02tAS/abgV9jRlXW/zyWEJ5/EYWGK3gjNsUHpr7AC7ZX4g+Wit19E/3aCC5AKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNjzvTCi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-279e2554c8fso25329415ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758647851; x=1759252651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=YNjzvTCimq5oXRfLouTl3cKGHW4ItnaZXMGBkomfRgO0x6V8Y08IJg2Ow6w4N4SQd+
         RUI/Ff292L4wLsb4io3KQ+HSilafQUS+WX4acO2/Ze6rQxH1VcsGFVWGVNxibaYzEddb
         mNQmMmSwZy7dRGeJN7ALf38RrOexmUWkPyWaCkK6t7OS5NXA2W5pthqM5X7BKC/ZUkDv
         Cpvkzpw2G2T/K7GPjhuMgFTUMRNFehZsCh7FaC+MU0NJPP7k9y13YI+8TaVLSIhWp90S
         AZFXAduroPTtKF4rN7jq+XG8eyFo3QU3jHetpAxC8A1kNfPOKh5t8v8Tk6DGHteVEcdi
         tExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647851; x=1759252651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=n5WfmP9KSuNxL2zKadX7OJni386LJjxr5iY8Jky4ANr7UxA3n5Lj6oGM/h59bixbOB
         L6nY4a419W4Az172kvpFjR8ONOKH0LoUBgra/qSU81jXi/2YxdWz3jfcpOUHGqmN0Dp4
         EgQk0EMY7BRi30Uvy7TFknvUM9SOOE0Azz3ZzzBjm2eI9ejx6Zq3GoOa3Jh7MJnElJ0K
         FBa6aTAVEvVV4i065X8FJHq1Nd7jPMcZF1/bvOhbQ+CRzEyBjJeSy4CQmnC1QxpqEMvM
         qtfbdBT9ipyKpGld4OfTjTMouK5IA7HnJL3RXKJe0MfH2NfNWvQUj/v3bsVblB0CuDWX
         WILA==
X-Forwarded-Encrypted: i=1; AJvYcCUSxhOMvBrqqabXd/t50r0mLY9UhhRXc+oixFZsVTzQFmHCS0o0MWT/d+RFYWd307bWSppJr81E9oHoSqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TWVlPU5Bqlqdyo32eRBb1q1353KGxEDVbt6M9Iok+Nv96zPD
	iwKSV61xA91Vr+jlCaswHLAP1WUSxguFRfJcHswQtQcFoLd1V+sCrdoO
X-Gm-Gg: ASbGncuWdnWRCaV4DJx6dm7M7JVK1mdnI9wK4ZS505r4nyLBRQdiponM3pVPchM1i04
	tXpxe+MPloGbomT20AlbvlO1pQ24YJX84xtJlzUUhydGBFRMYo7z/HTTr5WzGUJOW+a8cOjXJej
	zdvLjCZN8sZE7Kiv059KAUz+mFpMYfD7RC9p75Gsz8mZHVlFdkNYwLavAWyQcK5m+ucR8cZgH2M
	3BMJoRN387JvFdiCWJ2CJeiseBRfj2l4VFTS9MMHwR1u1cNC++TKoNSzAE4Xafmj76xIQ/tuyde
	hBbzI3RJrI1TaAk6bHBKoOKOqDI7thQry1yTKmJolXfC+RsTocamIzYJXMBABCiKiHpsJoHrRLO
	sehlAeEmopQj0kSHvVDghQoNtOuJ3OPQ=
X-Google-Smtp-Source: AGHT+IHWorezdwiA6RzXzvfO0t+6UZxC8wq///4YmgQHnZLcUQTRpHa0/r7Tk1dgg2DcxEs5rHtD1Q==
X-Received: by 2002:a17:902:db0f:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-27cc46b25afmr47229825ad.22.1758647851122;
        Tue, 23 Sep 2025 10:17:31 -0700 (PDT)
Received: from archlinux ([205.254.163.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df76dsm163283095ad.74.2025.09.23.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:17:30 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v3 RESEND] checkpatch: suppress strscpy warnings for userspace tools
Date: Tue, 23 Sep 2025 22:47:21 +0530
Message-ID: <20250923171722.7798-1-suchitkarunakaran@gmail.com>
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


