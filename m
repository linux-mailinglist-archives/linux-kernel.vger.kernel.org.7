Return-Path: <linux-kernel+bounces-784878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB28B342D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2DC168293
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990142EF678;
	Mon, 25 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZJB48f3"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE22EE611
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131080; cv=none; b=Na13XNCYGX2QWD89BmXh6KrVy8hDBqI0WvadQV/pmDp0nEx/IVkYr/6lsiW8zvPFtV4q4GB2S+oYr2t0QJwOUPdCH7N7k11YzODxNvE8ym9Nt5dnE1EFrDnK7AJODvUdiFgfAiJLYMWpSO5vuu8KClMgcA3dM9Um8J834z/zuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131080; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1zrUeSx19zMXk6CIugK6eY3tk5PJ+rsEOlQ2nnnYBO3Nn6wZlgvpGP7+bnXEjjg78uA85OZchBn3stvxt2GMXQDzEDI5ksbm6HaKmK9dsqEMPac04eWY2Yo7m3Rb9xK+oXgIjdHoPzYUIMil2QRqpOVq3Nn5EDOWSRUT1IemvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZJB48f3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771e4378263so755967b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131078; x=1756735878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=KZJB48f3Vw4ZmDy9o+aclHXhFWNLVRjhhSYADNeRPSGBV7A/rjxZGPD3Hg32xrDG/Z
         c4SzTP8mm2H/h4aMMXhu+Mv4CnCUq9eHZIqDMHyU2ZMX+calv3CW4zPUz4z+LiBWbq1A
         jH5YxrLl3s3idXqX48o7jvImvaf45B/cQAEWcMtV6STu4cCfxHGm+VuZ3IqbLIJT6DT/
         NGxMSyHw15e4pl/Eekc9bk0WlYMubOe6JeWYQOhvXJBOfZAPyoXCXUe//D7YUPBO9ja/
         PfLeBq5k0aEVGQAGzGUqfxWr0+Sog2WP+CZqqs/b2bp3TXzvsoLU/2tChqhQ3UvoPXhG
         3ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131078; x=1756735878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=AhBqLb/3QF41vnjJBvFDGYp6RZtAd+DpfIk4IIftiiYAs6vtiKUK8Lr0htzNX1ICdV
         CPEEEDxfSAF3kF42EsJDsI0WTFhCDEVS7XA+E4yWumfPT4HBKwVcutzOl3xmGNHqcxqt
         ClA5fT/JiOGLYqnAHbO5vfoIPoSK8ChDVxcEf45qZysQ4z2TteoToZkT89BMSe3CbFIq
         XzlnAN6KcFY1+s5Xe+S8MJI6XjyfoSy5pYqyJcfVOHn1Mw3KXPYAheKbmJwrtgVlenMW
         IR0Gh7PshRqXJaEr8JTOYDPfPum22OhUpzBNktqsyRzZ1yhPtBTUsuwSDO3T+5Sun553
         tk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiySCCS+Kz+JLxp1tHjOO/TviW6IgcNh7irUFsW19M9/oL+4gTsoZ7TgPQ6BEEovNi+KoVkJtpETveqyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hHgBoNNkA23tQ9A8VVb7uCbf8XpjcTKDqIM8hZo4pDr4PwQO
	G/8YmmN3d/tVGVl5Jplw6JvhQwEhyACb62HL0Oou1/srfoaFakeTZPDF
X-Gm-Gg: ASbGncvi0w8xY/t0DqqX/PkpzgE5+ucnWdnnZqhNWj4gtA2VygRxzZtvpwIqEvMHTLC
	0M13fzLF/WZw6GIa7SzJC9GBkiWuKBglQcKJCXClMbKi+bGI00SSUSErgk5qh2lhokhxz+ZpHCC
	PLNNP7askwvL5kqn7Y+u7TK8gcaKceuCTDhR6QPzbjP7vIpKJq6lANlOp0Wfgh2+XzkPYmm7YcT
	RGhUeL5OAWwIatHXEMMXmUzygHbhxeYTH64zUq8JADe7MlLOf7BSBIXyfrzbC4EGhnJz+X9yNhv
	hmkOEMvrrlKyguTpt1WecSYXSPs9p5fDDRaGiAUHA0SUhZYPIpkUDjVxJc+QWlVFg/p70x5vfrF
	QXge9iUplKpAHDLFlF88t/HV6Cc+Yb9E=
X-Google-Smtp-Source: AGHT+IH9IQ/cnIrvgdxRRwfnU8634VcDlonbLYpJ52WBpEUVMfMAEG7Ir/57MCsg9YgcQrfLjX/DgA==
X-Received: by 2002:a05:6a00:14d4:b0:769:1f94:85bd with SMTP id d2e1a72fcca58-7702fc4681emr12769053b3a.23.1756131077273;
        Mon, 25 Aug 2025 07:11:17 -0700 (PDT)
Received: from archlinux ([205.254.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e912e40csm2108786b3a.44.2025.08.25.07.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:11:16 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v3 RESEND] checkpatch: suppress strscpy warnings for userspace tools
Date: Mon, 25 Aug 2025 19:40:56 +0530
Message-ID: <20250825141056.7683-1-suchitkarunakaran@gmail.com>
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


