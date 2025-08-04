Return-Path: <linux-kernel+bounces-755600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF7B1A8F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8CB7A57C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8372C1AC43A;
	Mon,  4 Aug 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4NfnbrB"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D171D9A5D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331004; cv=none; b=cCbHGuevrFdVIu9w4NsetaietFTzwY70UWSGQOE4w8MywO5sCHmMssAkGxCJ6+tJFZOnTkBlJgQvKFs9Nj2/MAy5yFI1j3rGiBuYGQuLuhoQgYYL0rG5/TcXLykf+cvBlONn6/7KwbbP+jklkAgb3dh5+EWPM0hZ52VV5MPFbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331004; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngWV0fADlp9m2leeI529yqmfYNtNTZilLs0an1Ic9BEbpHgRIJdYFWdFJYQ5ZFME8dOCqpOOeAH0HXFezuvLJiPNqHbx5U1zUVyO0+iI+NTOUzWlwuhrHM8bazT9YZ/HBZuJuhJXCpaQLS2ua1GoQDp1nxc0E9mcjkZhD/ZgNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4NfnbrB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so3427893a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754331003; x=1754935803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=H4NfnbrBCyZFJFekUFs5UkNBTYt6Er2cqkhgWlAVyVVJL7RSj52Owk23I26jJil5WR
         TsYxz38aKhq0Qcb3QVY2bSfaOVCqhRuGyQ/vkdG28c4NQogP8bL2zzNQjr2wZvd9yCIq
         2HJrq0oty5nWJOxjkELmlox5QXGaYKPgiCZRwSA7a4cETWjM9/e8gcSWEEUn1nNj8SJk
         POYHXHano806DUbZequ3Y8y89vGe70juiugJJNF64qtZdw9Sty9W7sNVfXdAzG+oHOpe
         ZLqUt39u0Gd1WwuynGGeWbxTpGcIbpwm5qYe1g2nc2YzDP2E5/7BVh1UXW7IT8SON2wp
         CA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331003; x=1754935803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=XTotB0EkDN5V+IbfGHuAq7/x4QjYV19UotJ+A45Mz9dTm7G5a2RpfztwJEOBBVlF2t
         n7mUY6AbgLAPOhIE+IkL8r4OjnT4tXpgS5JQOfXr6MIPnLFI1+C83dixbmunajcOu00h
         3K+WomsZtqWITfBpvofwFvFtheK7VDCM7hdIVgeFuPXflS1DgjH0LP76eTcq5W8q6S8z
         ddzLMpfPNTD7tFRwVe2NJnsTZ+xL4A2pXffJjGUPcQPJINPhun6MDZq157p9vUCMGnHh
         rO7Jtx1BCsYCuXEdIZgpPplNj8b+6xFO3JJvo+ekwae1EklJy2J1eDXae6L8aZkiwNOW
         5QKw==
X-Forwarded-Encrypted: i=1; AJvYcCXfjIhGp25rvxzg/SNHMJoEy4w1q8oZkpUF4z2MKgzDPgZ7v8BgGaA443uR+eB1qUtj2kKQocOUiELPFBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4S5SJT4kOYF+WzpLm2D4J4jaQFq8ae7prfUXMgD+lvdzyaKIV
	iC+bCzdyCFCvfAtSMT3IE9Njl8aeQq0xwRTO1ueZJ0NUz5/mnwqpnbs+bhnEF9dUwfk=
X-Gm-Gg: ASbGncvRYxop+sw2XH5kkR7XcHVBD9/0XL8dTyCACWHzQrp3lmjxGcgEQwFiyVAdQ+x
	3yaQFeoOxUC7bdHK62cRwyf3WUcwtpw6dQ43GoH82KPqy11q2ebyC6Kv58H6Wuq368o1hMcEIBX
	So705B1MhniszLg66WlTFDICWLU/cxGeUQrO3sN5AcxmtfNtWe9D1rR0o7SHvoGFU5uKs/aRqos
	ncHr/XijhHNUl2NvH3+APucpf2UcugOn5PDylJ2KpjJ9bdLYurRVTHs9hW14GtgEX4NhJ5duz0L
	HgQMcuWZbgY4Z0YySjRebse8voybTXk9ONohm4xQQEYImdre8YpkQE/9i8uiS8oJuGewZB2CuKq
	9WHQXcXlEy9L44nEQJRVpPxV3BAqdMDA=
X-Google-Smtp-Source: AGHT+IFutXw1L/XOjScRsdDSpV+r6eKI63rbxdFUQe76zmXPfvquCWiV+zd8b3fzU48UPDGnuelkQQ==
X-Received: by 2002:a17:90b:4397:b0:31f:346:c670 with SMTP id 98e67ed59e1d1-321162cd915mr11001796a91.30.1754331002791;
        Mon, 04 Aug 2025 11:10:02 -0700 (PDT)
Received: from archlinux ([205.254.163.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb09d1dsm9508864a12.58.2025.08.04.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:10:02 -0700 (PDT)
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
Date: Mon,  4 Aug 2025 23:38:25 +0530
Message-ID: <20250804180825.15055-1-suchitkarunakaran@gmail.com>
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


