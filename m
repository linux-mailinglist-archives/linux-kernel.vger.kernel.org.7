Return-Path: <linux-kernel+bounces-771320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212CB2857A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2187B1ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7A184E;
	Fri, 15 Aug 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="madUyDYm"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D919AD8B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281081; cv=none; b=CZdhK5PNjUAbknx+zBQrt5Njjfm+y1I/xxjHamm4T1NgZUq5kecWGSwwc7WBlj8CORvr1bGiAcp/+kZxcALXMsddCIXfkQSDkwEznfDZn73it1td1ot6rwqsHZ9nZMRd9oCXKh9UTqMS3++ovYWMAzw+XYFoAjYhbyS2+H79JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281081; c=relaxed/simple;
	bh=8tUVEOHCd6vgZOjmZ6wGCyZD35jdxuSt3593rFQJiRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOKLT7cSp12bCC+lhIihnoFxjQUh61Gem8yyUKBfFPZ2y+dLCHFfFWDKlL62I+iALT4Ejhl0iL7qyi+J6qyg7Bgix1gTRYZ8F5E1KG3qnp3e0+Q8sRUPILgSQ/l9etqXTMBo5JjJAlamVC9bAJQZL9TJgVD2Mm5sOaOSYJTWaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=madUyDYm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1218769b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755281079; x=1755885879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=madUyDYmR7WVgPeED2ipdUE3PKqWxiTKGT4FYvN4rYXcBJxxFZkOL24e5L/Pcwbg7u
         OmjQHqBAUlDd/UeI/jx72qUH5zudsnX8il3gJi6K4wesashvADDhKEo4XWraW3dMjoGw
         UGwmAgdeRbVij5O4LHH6O1SF4Vp3PnIKvYa9I2g09C8URC9WkPTnx2qmO2tYZElxBYkQ
         SNEgyOwpZ7gD1swAb2u6597CADZBWxUJWAlTccjFyTHxLfwLQV2NFrO7N5Ckf+FOFkoW
         zs6bhIvRkEygExnwMngMmnTfopTIGRzM0UhZX0M+YkkjEFc94N6cOsqn76Hds9fHbmxT
         DvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281079; x=1755885879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjnd6OOtdW9yy47zlEw4IHguBzP7Muvi9jj9yhTRBOE=;
        b=pQTt/jwWsd4EjJ+6T8RvsVLfXlqk5rDl7cG0LV5Ho8UN42fKDQi9jiOLJtzxg0DeHt
         qT6uZ3s67tcU5DI4PVwEzl7f0uyzGfP2KpUtoOXzMYsDeIh6MWB0ygIwDmr7XKJJxtap
         EW3ME8HVWjhhHLQGVeG8VzHZ/cxApmIHGkW8EPls/e/buzw7pLuHxvrmGxvv6W3NzcB6
         DJAI1TIwxqo81xQJZD55Gbm+g24ybLvYh68yV9GwUAAbDL8zO5TNWwvajOnzkhnNmd8F
         W0b6DAZNESAakqEkdRgKcKUR7iAgjY8Rek88Tog6Tfbi2bEm+NbllI7wTmbavQphoqYR
         +T7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIMaD9q8vl0IRAUDK7Jbhxu32mcJhph2wLwygoyOm5QO1P84I9qMwB5hp3vgDkKxPJmkHW6HhwSHNIKNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X9Ygz8BpgK43OAZszy64SznntWabpjdFGkjM3gZalV+FLYiL
	O51v5R6psaD1ogja5FHDRryOnU0RkJ1u3WYWTWfWdDEExyjKCBG9+ckOXuKyGjCR
X-Gm-Gg: ASbGncvlG1rlhdXGUPVL/Rs7TNWAJdGToJ9nHoXx/BYqTf3wygIw3U3fIIuinOVBEAK
	VM54kgJyE/nrAUjwMctdqrByCECcOty7d6Ccyc6WEUxv9bziOUh+sUd16LmPPhGlVH6XX6mgYHK
	+NyDge9TBrjz8kszde+Fg/iMgTMALYW0Dvq5QTWuIaIP+isQLpkLEBlRwBng8ca5XSWCIpKbo5H
	zU3cQqBE49vgVmYyZWplke0VMEqnsX3Cl/x0YBsABBkRNyLdbkK4qa4jNI3dNQEQm0eqOTr3bHg
	QJClz/zocNlTNbCh1tHK4Uz53emGTOWcApVC4WUkSfzz8qybheI8gGv1+pimmKmE6JvzAx4mN3o
	elMOJA13Nk5/qNgBDmmjxEMo10jvHT2oSMJJzNQHmvik=
X-Google-Smtp-Source: AGHT+IHdqRPTyIcttlXcxE7oZJD/Rxum8jhYUpDfRRXcp+yZKhKHRlr4U8LI87W+kih1ENq9zMjiOg==
X-Received: by 2002:a05:6a00:4fcf:b0:748:e1e4:71de with SMTP id d2e1a72fcca58-76e447dcb34mr3824537b3a.14.1755281078642;
        Fri, 15 Aug 2025 11:04:38 -0700 (PDT)
Received: from archlinux ([2401:4900:93f2:6a91:9b6f:8f9d:11b:d64a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4526cde0sm1579049b3a.23.2025.08.15.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:04:38 -0700 (PDT)
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
Date: Fri, 15 Aug 2025 23:34:28 +0530
Message-ID: <20250815180428.37795-1-suchitkarunakaran@gmail.com>
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


