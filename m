Return-Path: <linux-kernel+bounces-741785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF69B0E8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C3F54742A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DF1E1DFC;
	Wed, 23 Jul 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO4S+uod"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831270805
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239780; cv=none; b=k+cvivXARNrS383uovctQboA7vs7S+kFzXu8tM4Rk86WyXyAfDA7mg62TDLHh3xe/SAA+fPX0kEhx9r5g8UMVmAnKdD0HB74qRGWiF/O2HTu1rMfKucWr8LIG9z2/pTMbtbwtgxT6+UPf8CHDg76RCOYql9rrhZr5+xhHzofkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239780; c=relaxed/simple;
	bh=QFKRLZq1jViLUrFFgY4EqBMAppV7vQ4CLQZ6OJVZN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9cepFcy20J2PhUNqzJL1huL3AfFVwWC61SrPLs91ragb8aZ7dpXEDdpRxuBXtDUsdZk5aC2CrJzbJ6KdckltWgeNQ0t560mQ+gwpKsvzWY3atKSor8mBW98a51QSzZDjfW3QH13OPaiAOOvXu/zNqxTxs5gexHISxmsQ3+mVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO4S+uod; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dea2e01e4so75260825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753239778; x=1753844578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVU69ud/HKBE0wXQv0Hj8YbM5okNm62Z9HWPPUeHvHs=;
        b=gO4S+uodqaMqXfRjin5WVZtCSI0RePD+OM1uzcd75EaIubxu5ODaalCvRxaLtwUkbc
         /vyFJADKjkWgFGyd7B/g4L68JcN0xHVFxksg+uxhh69ourNdflN3gXtB9n6jioPRQhKF
         v7O8qdmLi8qVVksdr0nTxvIz12erkQmX7+r83fQR2kSBVDjgf6RmKQMvIIkg3n1EsS23
         ZA8eeznya2PZvQuWau09uQJ9teIpGfg6ibe5FbzCpP8zlUYMrudo/iKaI9a6L9Pg8NPn
         Vhrd6oKfhFi0F7WvETnmSvISSxLFNaIzLuogFYsp/LgL2LTno47m0jwpl/YR45oNCeGJ
         zT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753239778; x=1753844578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVU69ud/HKBE0wXQv0Hj8YbM5okNm62Z9HWPPUeHvHs=;
        b=GytVNJocdTteBQCZ4tF2lLOU7HulZNyfpDiN7sJKeXuFSU0ikMk8t0E3jTovVuxFtl
         bp2mmI5CJMysBqd0fBatybeb1TfJ5HJO8dNkiET9iyTOz2j3ukam3eAv6Xmeuryps5wx
         NOcLQ/G5OVXy7Mhe5X8ncgxgeuudVdDBB88XB9UYkjJ6SRk08rUOZPRmMczNQNCVwZqd
         qJSDgqestYoRV9OAhjOE6QXeVOrfHENc+8YrDAMXqB5w9Y/iNUmaacDVI1rqeImcLR89
         wbAht8ROCBFyh5y3d5CZE4Qb0gOfvsWnizm1lJbJ63uwoQiuJY2xy/kc11dUzWB2t1V9
         TjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa0BW7pyrMmGY2PrZQlmIVI2tllLvnU/h3BPMhGhEDli21HGXTUtqymmnzjynqDzn9/cucX6w3yLPAIz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnOsP2arRC684jLLuYWRxNEoC2z9VQQAecwXXIS/9Ik3x1YMO
	2UoHVpFHizeZB4W16PA0gTGmPD86WTMMi+Bt3k91l7xUz1AqrbfO3b1R
X-Gm-Gg: ASbGncsG/be4ZxdotYOq/3/pGzBvg/HGiCzYawcHzxjP5cr3QVopIDehVoKKZNNmFen
	9hiWAk6bL6K++NESznAb4vHrlQzKO96ABKo85pPAnVSu/trys5U5hAx91Ej5d4WtIouHSXtrvyJ
	SsB32uJokHq1Uq0zTfYlQUpxQs8oeK77psVm184xwWCSeLegcIgu5Pa0mmrE1grWSTm/fp5K3gi
	KAzUT4sIaXxIlthW4/UVWbwa6CSbsI/K53uebnsj2FpTIQ98GO4FPNF+nprfePZyjd9YsD13Kgv
	dxbFs0vAG6erqlqZt3N24906YDMaSpYyXyGIekhqnB3bWDhaX+feRtyp6vNJCedzlIiMeWmqjX4
	M8eSt7Iqb6uFJvlfz2zQtFJKkJ/7b6UEyDmEiIuMDggG5iEBLpWb2Gb0w
X-Google-Smtp-Source: AGHT+IGJMDk+VYVJ0Q3CaqJxk0v0MZePpnW8gOcPw91Qrpg+OjI9fVaLWzvcF1IayvYBbs5Sx5fhRQ==
X-Received: by 2002:a17:903:19c6:b0:235:eb8b:9968 with SMTP id d9443c01a7336-23f981b602emr18069885ad.36.1753239778064;
        Tue, 22 Jul 2025 20:02:58 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d9504sm85546055ad.179.2025.07.22.20.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:02:57 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] checkpatch: warn about novice phrases in commit messages
Date: Tue, 22 Jul 2025 23:02:56 -0400
Message-ID: <20250723030257.66560-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721162437.6691-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add detection for common phrases that make patches appear less
confident. A single regex efficiently matches multiple patterns:
- 'please apply/merge/consider/review'
- 'hope this helps'
- 'my first patch/contribution'
- 'newbie/beginner here'
- 'not sure if (this is) correct'
- 'sorry if/for'

This check helps newcomers learn kernel communication style,
reducing patches dismissed for presentation rather than merit.

Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa..6953ad515 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3266,6 +3266,15 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
+
+# Check for novice phrases in commit message
+		if ($in_commit_log && !$non_utf8_charset) {
+			# Single regex with all phrases, using non-capturing groups as Joe suggested
+			if ($line =~ /\b(?:please\s+(?:apply|merge|consider|review)|hope\s+this\s+helps|my\s+first\s+(?:patch|contribution)|(?:newbie|beginner)\s+here|not\s+sure\s+if\s+(?:this\s+is\s+)?correct|sorry\s+(?:if|for))\b/i) {
+				WARN("COMMIT_MESSAGE_NOVICE",
+				     "Avoid apologetic or uncertain language - be direct and confident\n" . $herecurr);
+			}
+		}
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			if (ERROR("GERRIT_CHANGE_ID",
-- 
2.50.1


