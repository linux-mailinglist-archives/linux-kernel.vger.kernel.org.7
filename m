Return-Path: <linux-kernel+bounces-739620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF08B0C8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5074A5455AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068B2E040B;
	Mon, 21 Jul 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idpnsOsm"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE8283FC3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115087; cv=none; b=ecdPS1xt0ID7A/2LlhSPDis2rXMKaGTGWy2T345ltmVyA+QVbmn/emJa+9eLZv9DDPzLZbHgl3NiNXYwW2fzNnEf9savSZMIGQquuFt9SRK2tAKMD1NLlt41XOrODa3u7IzgGKASQbD+hmtAHf3pzzsZHPb4pxY9vhX/lEbVc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115087; c=relaxed/simple;
	bh=mkPqh9ZQMv8XAAZ6Wx7UKBWRdr4Jz8IsvnulgV6cVWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1MWRdDZymT8h/zPySh/Ge1vGdc9EeOF9NdTP7yHty8mdHHhgfhNsCtqeRjO0yOewxwmCt3KeiPSJMrq8VkhWhDR2Urk30gkZOQ1BrPWL08FlRGZh0Vo/QZcRDp4PkTNiRpbekOoyuriQaAxixI7JgR8GYyYRKPUnac2opTx/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idpnsOsm; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e7e4432f5so2522991a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753115085; x=1753719885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBy8B7TcdFM2mKA7s4GNVXXp7XJykXTtiPsgAKrxGcU=;
        b=idpnsOsmLIfGYJpK/uP/00qMv7PLcQP7qQ+R7a3bVF03wAgSJv4JjdHA6HrNyRrmXv
         OMY7nIByhQ/GvXwuSSSnmccEMruiXKvr0YT8OwA+nuoBPUtM+ubQjM3aFVHF6MHQGq5v
         6PNt+5C0ptjVM//TDpWI0F/9iU/zbsdPgtRkE7OG/8Yh9Ra4qtP+l0dIVZ1/BRy1QPoj
         CMwClFvLpBfEeYcRpe2qmXdLnfOzCkf+IOZH9kS5p/bVw/tQ6ZzeW4/axLhJXeeLP5xO
         A3CnD/4qdMXq/oVblW0mNM1Pii4ah0g1PdkqFO6nr/bn85B9jZg52xtDGbsrBB0K/TK4
         9x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115085; x=1753719885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBy8B7TcdFM2mKA7s4GNVXXp7XJykXTtiPsgAKrxGcU=;
        b=hMK8NjXfcPxGjWuKKhKMt+IaRZta5iSvYftT0FVt5TO0nkepzvmSg6IL0w4jj4WG7e
         MoV7M0Kww1O1G40IhcoO5b+J0QxB1YuQKAm1GMsINpNXa9H3G3waZXTst/s7YQ2hS1V6
         RKDItLoc8YgtFg8OoKlMLjth4mfqsx8cbqy6wDQzMZNBB9G3jQIKM4PJVC1s1Hf3q3Qb
         gNTwrjC7VtBPbhHcyepFnBlbWnzafkI6LpeX603x64fSs9SCTtqORn+GEDZF8DKJ3hn6
         YDTe/zTaf6gu1KiLsNI8Hns/2oiBNvZFF5oUX0ZH/5ZESBOEHhc5vNCaVbv+fn0POqp4
         u1ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2LbE+mXdHoVda+QfVsTZ/O9feClR6o8I/upAbqQz/jvRFRNC1detzYJXvGLT86sjUHLeLPjAJfl8xlng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gdO1DQCUUnzSnn0djTgzfvEeKiyxW49MHX46jOH0/5Vc1hHW
	FbnOGerGCRgWH4n64/zNESZu1ClhxHXrnXhRPNYPoZqcRAKwb/3Im8orKNjO2rG3utA=
X-Gm-Gg: ASbGncv2JTiTOv0CwcKgAtg/Ol7fnZqGBFAJba9sShkGY/b+hMqO8Wrg98rpgc7yM9A
	xzZG11CryeMUieytZ3JQLeuaq2XOrTzTE42rgeyGKaEEolnKS69AbhPKDv01OJDs2mfE9+4IFED
	nMWUZByQnsJQ5VocZ6x3yRVsxF4iIgGu/2o1UIqUsILSglrtgEA1vN7h/VwnJzSD40zgno8kOcG
	T+GzgruWHtflWBMPoAvDX4IPis4d2nC9aQQ9VqltWLEoqmcGinU6otrD/yXY9rJ3YwV0W5HwKxg
	LOyTFYko4yewnIh5c1vADOed2quCuN+dd0mzPr14Yis1cqKmEt76+Q6LPJ1xr9S6tLWpIUt3msw
	Hb5ETrbh2sJlOBa18EyjVwnG3aBc+91qp5Z9cSKkeZkqFP/bD8yrHAg==
X-Google-Smtp-Source: AGHT+IG0dvQmI9B3D6RtQQkBZaXwq0ii5HxbMf+PW+Grd1to9T6jYxFTN+BHhnlqWEziolmEPH82jg==
X-Received: by 2002:a05:6830:f81:b0:73b:2df2:a84 with SMTP id 46e09a7af769-73e66124b51mr14806542a34.4.1753115084776;
        Mon, 21 Jul 2025 09:24:44 -0700 (PDT)
Received: from fedora (181-162-150-76.baf.movistar.cl. [181.162.150.76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bca6b5sm2935120a34.59.2025.07.21.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:24:44 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH 1/3] checkpatch: warn about novice phrases in commit messages
Date: Mon, 21 Jul 2025 12:24:32 -0400
Message-ID: <20250721162437.6691-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detection for common phrases used by newcomers that make patches
look less professional, such as "please apply" or "please consider".

These phrases are unnecessary and can make the submission appear less
confident. The kernel development process expects direct, professional
communication without apologetic or pleading language.

This check helps newcomers learn the expected communication style,
reducing the chance of patches being dismissed due to poor presentation
rather than technical merit.

Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa..7ccdc774a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3266,6 +3266,26 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
+
+# Check for novice phrases in commit message
+		if ($in_commit_log && !$non_utf8_charset) {
+			my @novice_phrases = (
+				qr/please\s+(apply|merge|consider|review)/i,
+				qr/hope\s+this\s+helps/i,
+				qr/my\s+first\s+(patch|contribution)/i,
+				qr/(newbie|beginner)\s+here/i,
+				qr/not\s+sure\s+if\s+(this\s+is\s+)?correct/i,
+				qr/sorry\s+(if|for)/i,
+			);
+
+			foreach my $phrase (@novice_phrases) {
+				if ($line =~ /$phrase/) {
+					WARN("COMMIT_MESSAGE_NOVICE",
+					     "Avoid apologetic or uncertain language - be direct and professional\n" . $herecurr);
+					last;
+				}
+			}
+		}
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			if (ERROR("GERRIT_CHANGE_ID",
-- 
2.50.1


