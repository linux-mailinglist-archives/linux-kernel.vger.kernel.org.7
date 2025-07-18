Return-Path: <linux-kernel+bounces-736229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B515B09A46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C57E7B2764
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02A31C8632;
	Fri, 18 Jul 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dts8MzDu"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F32D613
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810681; cv=none; b=rUpJRP9P96DLQWo3RbgUE8gTh1j1t6kbORqoH+RvfPj5FU8G0HMzcBZ7UaCOLqoTQL/g01RHwvVJptt/YazYZ3lZE1JC2JXExORZvhsWOttE4D43mK851xblsXBbk0XHa9O1zGEDKVxNbiQvDuBzn2O3CHyXPIEal0ONgEH7xSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810681; c=relaxed/simple;
	bh=mEG+3qu1LZ4Qr0eUy+etpzDn1dyxCvAy3vRk51Y0nXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u15d6CAnKnlhlWvKT/arasGJ/jqTPOGayeMX9XYp2Sz8XrDU4LPMDCINThlw7uieSsj5BI4ZVms6xakUaUkjB79rX+jeA+rXhCs/qSLn4T6OxQYjVCGcl+eq95LC/I5VerVDbGuMz0/ojLLXq/GjqtPZipaguJnxPEcMzf7K10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dts8MzDu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7df981428abso261979385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752810678; x=1753415478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxkGXRTeFfkWRd9oP9ruPIr1F1mdu36w07MbLrTSqQo=;
        b=dts8MzDu7WVzjoOBg/MU1DrqGouMjU2P1GMyN9g4P2zRD5oy/7b8g/0SbLQeWcMuLo
         J9ZLYKuOzpvuN7/NTJ6DYWb8Dqzznj/MOA+yoj27IwW3zNId9ZooMg51TbFuqPJ0VDPZ
         0UFcJUTmSl2kU1sRyq+QYjX4XDVW7WDWrrNnXMrJZ7fioOIQl7EYuIVQi/pqJ9p+I/up
         asWyeTVoPGUKTbgQjlKkh3J0V5/SNIXiieWHMIK6Q9Xk1u/XqEr8tTmIBMmOPLrnoMaK
         6r617spFu7HD+ytxapbmieEgNWhly8WDZGnL0QSUGLdFC0REgTod1t6/G19fUZNUG6Jq
         FMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810678; x=1753415478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxkGXRTeFfkWRd9oP9ruPIr1F1mdu36w07MbLrTSqQo=;
        b=kmc7MEIZifv62+FKUjVR1EZ2ajO/bEzIH6BcqZffm8yINpWp6rjZWGPx0NmvWQNNro
         hbMdL+c2Um+VKqlj64cICzf/wxVzcpzZ3tT1ORb/8XXLXW0Uq58KNcUCh25PIp8205ge
         xmyHt4vgE7u5XjlVCEyRQJLAJJgxfZclPSmvOMNOl5CpSAYCuQs/EYcIEPmH0/ldwulh
         hSsl81943QuahviA/tZF3THAvEruxPuAoIIr2rwCmPgjY32lRZ/HBFwVt4puvlATpwGb
         gKvbwJf4zsexi5dMy1ydqCo9IFH0zr6VQXslfSyz9bHRd+Jgqn/GflpsGvSJ0YNCmcSO
         d2Lw==
X-Gm-Message-State: AOJu0YwUAyeiTh04ntdgHoIIpgC5c6xh6MdhJEAPAvTanaEb1o0rq8Zo
	0RCjmdOk2cwR97tSlIFxHV15gsMy3mL3FdRWJ83aA2b1t217zW+VNVhgszWmVWIW3pI=
X-Gm-Gg: ASbGncvcPGsXYoNACGnQDyoV8XrR+EcJ9fjJrlhydFPGJZBV4ZZb0I6tdVeSTOjPnWV
	Kj2lET5diQPBCHo9UP6tpde2Ab3csYIZalaJid9vNApTrx31WaOdzS5F6kDehDGdDETWobfzviy
	7iX6iRHz+Eb6ZU+g5n1Og2ITiWKDHEcQ4d+0DajXF5nkyNJWCmkYBQQSpuG4BUEOXaiMzsZ3Ud9
	d/hKwXvLYg+P9lxJPBISP0HywXZDb+bkngBo2JG3B7c2010wp+aZWx82D/YKPqlPURqnxVKEvPs
	hponUM0q0qftiBo1yv0nfW56XQX5QXRd1v2QMu2vlckrr2Nh1/7Lx3X7rWGnthTypElXinYhEIn
	hwQwQM3PlF5tmZjH4QbC23kEh7/9Ewb7c/Ulgmoi7ArXPEVTGyit6
X-Google-Smtp-Source: AGHT+IFAAqsQTlabYyGANB5F87X2+0OGPMxjbs81tlwEojHVfPqXtsqCfkfoOhyv9h2TxbxpLGfxnA==
X-Received: by 2002:a05:620a:2852:b0:7e3:5129:db49 with SMTP id af79cd13be357-7e356b06e5dmr206752285a.45.1752810678397;
        Thu, 17 Jul 2025 20:51:18 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c6402fsm41717285a.81.2025.07.17.20.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:51:17 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH 2/2] checkpatch: warn when patch version changelog is in wrong place
Date: Thu, 17 Jul 2025 23:51:13 -0400
Message-Id: <20250718035113.49455-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a check to warn when a patch version changelog (e.g., "v2: Fixed
review comments") appears in the commit message instead of after the
--- separator.

The kernel documentation and maintainer preferences indicate that
patch version changelogs should be placed after the --- separator
so they don't become part of the permanent git history.

This check warns on patterns like:
- "v2: description of changes"
- "changes in v2:"
- "changes since v2:"

The check only triggers for patches labeled v2 or higher in the
Subject line.

Example output:
WARNING: Version changelog should be after the --- separator, not in commit message
v2: Fixed review comments from maintainer

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a6..af8a05f3e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2669,6 +2669,7 @@ sub process {
 	my $commit_log_has_diff = 0;
 	my $reported_maintainer_file = 0;
 	my $non_utf8_charset = 0;
+	my $patch_version = 0;		#Patch version from Subject line
 
 	my $last_git_commit_id_linenr = -1;
 
@@ -3265,6 +3266,11 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
+# Check patch version from Subject line
+		if ($line =~ /^Subject:\s*\[PATCH\s+v(\d+)(?:\s+\d+\/\d+)?\]/i) {
+			$patch_version = $1;
+		}
+
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			if (ERROR("GERRIT_CHANGE_ID",
@@ -3485,6 +3491,14 @@ sub process {
 			    "8-bit UTF-8 used in possible commit log\n" . $herecurr);
 		}
 
+# Warn if version changelog is in commit message instead of after ---
+		if ($in_commit_log && $patch_version > 1 && !$has_patch_separator &&
+		    ($line =~ /^\s*v\d+\s*:/ ||
+		     $line =~ /^\s*changes\s+(?:in|since)\s+v\d+/i)) {
+			WARN("VERSION_CHANGELOG_PLACEMENT",
+			     "Version changelog should be after the --- separator, not in commit message\n" . $herecurr);
+		}
+
 # Check for absolute kernel paths in commit message
 		if ($tree && $in_commit_log) {
 			while ($line =~ m{(?:^|\s)(/\S*)}g) {
-- 
2.39.5 (Apple Git-154)


