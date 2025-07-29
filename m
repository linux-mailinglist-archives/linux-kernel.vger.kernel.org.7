Return-Path: <linux-kernel+bounces-749719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12706B1520C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ED94E50D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF58220F35;
	Tue, 29 Jul 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BltOUalR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA91E3DF2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809889; cv=none; b=GzY5BR1nalNqV68BdexGcixU5eIJVvK8ae/nkBfk9awaq9DKHJDDuEOiC7+k1gkFqzkjxYRQbLu/4wPXHEdQNNYuQpvtEwBqYM5tjayzJiyEXjsgQglDi4qw/aZ6n9LZpeOAHquG/esIveN9o5PJxGhFHJBQ14Y8P8L9wXAdAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809889; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/S9K/zSc08bO7b+Az4zb9n+irW7CLtUeZJDWEsOJphfdCuvqbPpzPoD9iGV0YAmJOulen0KQrPD8faFjRmItQM5KIkPze3vDAgVHUCbS3wDRtPlx4see8+jcnEOP10dphCskgkh/1zyH5vINfFOHEOhmjz2ubzA1vJ6nIGoiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BltOUalR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ed9a17f1fso2256714a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753809887; x=1754414687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=BltOUalR86KPfYLq6oW44+c5qJ0ZEwmls6LVAHPs+OSztUWF71j+OM0tACRjWFxeG3
         tAv66pReN57VgWNMib6dG63oqwlRV061yFegIYiZ0lJ5VJVkYMvTPLqdjYrVrqJZHUwD
         oVvwPv+R23uZY1lPLiGczRzAckGmGBiTdoJqt5DdJgWeNjO7O9JrLAFNEAiooXMVyW8J
         ypKZX45/mRq8brR9FXfScnfoo7UuutvzIobolaOHecxsVC54v3JiE090CqJ2fkLHU8ox
         sVELCtbXu79DGoH8+WvV+mxurveArirXrLpWdoN8LM45waoEybLjkYxOtlPybefs7sAM
         kPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753809887; x=1754414687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=EP8E2jBwMLr58xJN1GZRhh3ha3XOlS1o3pE3/alrRkZ7Rmunfg/AIu6B/FRhXyakXc
         AxKF/7l1dxg2rVfQTkzjAJAw5u0TTqn9dOIdsHeRX/aE/XCpsdV2fH2RIO6/eq5qYjx2
         UiYdmQN0jWLy0DQgAv7oGI7jMVeSUzrckHdRhqroQLOLnkoRkwu6HIsSE/EINK9ng7FN
         fcYWqWFYc7QwhZFucpJ/aAbYwlkaclQoGzbP8zSbNPQuMKgENxIOzBdRFiTEdu2lhvfg
         gkn4bw3AeNS5aLx8qKEdHh29/lEQA2PxFBY1s1oJnGO85Tu0DKUYq8sgH6H3xgqwZ15I
         ZhAg==
X-Forwarded-Encrypted: i=1; AJvYcCVhcNSC1CnCSLnkQ7hPIuXFwrufU8mAA2Jcbg3OX6YbzIF79zWxPmRtM9eu/F7j9tlETyRp1ALMLggIkLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vfgKh1FWOhl88E3xs9wbcFGm3xJqGYPLP8Wuk0Kax/qQ/DjU
	qXUnohhMguZvMYaPNX5Ki13Ea+qY+ECzJQ12aDcQdCsY5YZmC0TssQcX
X-Gm-Gg: ASbGnctcq+C82UIF1YuaEz8P8Pi2NzV0406IAv+ShIyFnMJqcMyzNqIdzQqCLKCGu8q
	Dhik4FJ86N+Llzn4/ARq//qiXsHCvEtecJoRXKySHbgyw1BDX9FjbR9SOPCYnG28DD5xw/WV06Y
	ElnSv0j6RM/ykqjM7nJfHvqIyY5v2DA7H/qpQrnXTRRn2ShyXK53jfobjrUlgxKgET1LAYCbAhM
	tDHIwvm7bFVnwjsK+DSs2hsPaDCCJ+imtV+MT2D9pDLMqPDgHawvyPg2hndZ4u1hjmqBmzohQ63
	goshgrAL0mPrHTpvypXmQ5BqCgqm48NO7evvQlBbFuZSW/QXHHrVfaRQXEswS9qdv/jGX4JTc5o
	DYI2EE+vQbbSH58r6MHMm6eB4O5M+rME44OKWZuJI
X-Google-Smtp-Source: AGHT+IHxPVPNDARsw8xQ1vd23cug8FXnncAeKpA8e5jflbCVh7R1NkJvOBgRNA2botuGJ9l+BQYYaQ==
X-Received: by 2002:a17:90b:1d88:b0:31f:346:c670 with SMTP id 98e67ed59e1d1-31f5de5562fmr372362a91.30.1753809887062;
        Tue, 29 Jul 2025 10:24:47 -0700 (PDT)
Received: from archlinux ([205.254.163.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f328dd8a1sm2110943a91.26.2025.07.29.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:24:46 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v3] checkpatch: suppress strscpy warnings for userspace tools
Date: Tue, 29 Jul 2025 22:54:37 +0530
Message-ID: <20250729172437.19925-1-suchitkarunakaran@gmail.com>
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


