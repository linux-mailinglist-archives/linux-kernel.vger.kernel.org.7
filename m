Return-Path: <linux-kernel+bounces-765272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CACAB22DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374FC6251C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B582F90FB;
	Tue, 12 Aug 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU8d390v"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736D2F8BDB;
	Tue, 12 Aug 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016394; cv=none; b=Sh9nzC2dkl4PW0TAlpcIY+ezZaWhpyIOGAOVEFP6s+Hgw12pVf+0OpHhfVyz2U0lxclj/8q5VCn1/3tBDaFqH3W1/3UbLz4kcE4dKFVYspP+YXhgbFJEp/WDOsuWQFP+JbfRbiIrMKMRTQW3BlzSelZKJi+7p3UpsSvZrmXsgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016394; c=relaxed/simple;
	bh=f08XFR8IircaNgpPYMT7Fy0n+rjk6cJzLyG3MPy06O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYIUZhpR7vxZ0M0OIG1NWuH1+qJyKS9Rc6uUb4I+5A0MF2v5dtpBeef7FB26paxLEj0UXENT4OP2WZCo5sV1Eu0mBGun73tmGiDrna/HdUiTpmUljr0ckMvNeqoilEjs+lH9AAfv3UcetfTaluBHAKQcgV8/WjBTvzWp8M5HJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU8d390v; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b429abd429aso3106011a12.1;
        Tue, 12 Aug 2025 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016392; x=1755621192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUAqfV6P2BvW2KJeyshLxvsq1rnCHf6iWhSgNpwwIrI=;
        b=lU8d390v4MkE9aCJgTuei2Md9/rxeh/LggpHEj6iGEjy3Jj37TablaUKlJjdwoTDDq
         Arqux63YDSuH8jbDFug6h2gqGnF3bnVImBeGcyaKOrAzfd0Mt0oHI7TP1Y6iTQFJ3qVV
         lC2AdACSXokIOm3U5wxU2S+3kbPWzF3rkNjk/U51UgeME/wxEd0VGzYcuAitKaMBpvD+
         ALC136dUX5uUfQrwtj4fplX4sOq/6wAf77mi0glVaXLp35nPlYEZY24Ll4Fz6GMJO8L5
         Cr4PoxNCtAOX2VqVuYXSZ8e2MLFmvJxS6qLnM31xPd53NzE/jPCb5PpiCg9rz3Obyr3h
         2vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016392; x=1755621192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUAqfV6P2BvW2KJeyshLxvsq1rnCHf6iWhSgNpwwIrI=;
        b=v3lnL810z2DtPYfENpqHpxCsAIWybhK9/Q7qi3vVHUUsuF0GCAdoFyle1dmjrTFOGj
         Kl4+wsRgusHXsLOow13JlY3SvhQysBVGe/aCWwLG3q/5StdDcKgvJNsEmcFFMYvuiejZ
         aWCoSGzfa42zmpmmP883ne7L/cjToqDVErqq+bbFBpXpySpYznG4NSkpd8/BZCjC/ULr
         C2zTPuUBcWHf1guSSWrc3pMODq/IwwlWwEUP6LKsVnhEIiLN3FD46viGAleDDw95/dh3
         pbOXyF43jUGInA56zHt/s40rPxi4BZVW76NtMJLdCOf2AAP/9D7DF17/ptrT/Bh2K/fD
         gg6w==
X-Forwarded-Encrypted: i=1; AJvYcCWBbXvk2ze/kJBkavvTZFh19lD2WDj/3a7u5ew+RaYfT9jL2a8q2DAlKY4G7dFbZBSs0c6A7Iya2hhHBMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFw/gFaAVDqBLbumiiYAE5SDL7DtQFIqt0ppqDRzHqd44wLTwC
	Pr+GW1eMSiT+XYJBwj5sA3q8duPV+Wv/SRBBbT+Pz4l9Z3cfZ9wOrU7P+OXCTwqk0l8GAJ8=
X-Gm-Gg: ASbGncs8HHvPxDhSKcEBoJphr+MTs8K9s6LHvIJW6nDUVYDXBXGokgusziESJj4935O
	c8KvVxw4IAPgX8JI+oLEmhbh+063WzL0bDECl8ORi1Tm0QuwAzyBxEPSK/co+JqwY2H4r/sSqCJ
	s3VCuh9Km+jfUo4A2/I0ehBVO79rxmr8cxXNTTMpPpQQdMQEyF9wihgnZwUoILjG15g0Edol4wX
	y7oyitpjzw0KzZQ9YU/Q/2yWTUZPT9TXozxyU48BvPEeN0U0M1nY0x2H+g3APegmWsD7W3zUA7f
	5Lhlr6VHgOAA/O3G6sGFTbWl4EW7ZYsCdvjI5jmX+fLOwhyKqdOVu/az9Fjcs0YUY13vUBOeJyc
	+w0snU0rjmUKp66gWZyNgsplEqgQglrYLihZ3TD6c
X-Google-Smtp-Source: AGHT+IHqEZ3rQaVCy+twTsvOt2mx75csoIYg1bVSRcP0tmlZVXsZ7CWak3N01tkgaFoJP+dkNIsjYg==
X-Received: by 2002:a17:90b:1652:b0:321:cf49:2c04 with SMTP id 98e67ed59e1d1-321cf8e946cmr285135a91.9.1755016392088;
        Tue, 12 Aug 2025 09:33:12 -0700 (PDT)
Received: from kerneldocs.. ([157.51.85.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4290df0bdcsm11937060a12.34.2025.08.12.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:33:11 -0700 (PDT)
From: Nikil Paul S <snikilpaul@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nikil Paul S <snikilpaul@gmail.com>
Subject: [PATCH 2/2 v3] docs: rcu: Replace multiple dead OLS links in RTFP.txt
Date: Tue, 12 Aug 2025 16:32:34 +0000
Message-ID: <20250812163233.7330-2-snikilpaul@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a v3 update to the earlier "[PATCH 2/2] docs: rcu: Update
dead OLS link in RTFP.txt". In addition to fixing the OLS 2001 link from
v2, it also updates two more dead links from the OLS 2006 Proceedings.

Several references in RTFP.txt pointed to linuxsymposium.org, which is no
longer hosting the original documents. These have been replaced with
working copies hosted on kernel.org.

Changes since v2:
 - Updated two OLS 2006 abstract links in addition to the OLS 2001 link.

Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
---
 Documentation/RCU/RTFP.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index db8f16b392aa..8d4e8de4c460 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -641,7 +641,7 @@ Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
 ,Month="July"
 ,Year="2001"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2001/abstracts/readcopy.php}
+\url{https://kernel.org/doc/ols/2001/read-copy.pdf}
 \url{http://www.rdrop.com/users/paulmck/RCU/rclock_OLS.2001.05.01c.pdf}
 [Viewed June 23, 2004]"
 ,annotation={
@@ -1480,7 +1480,7 @@ Suparna Bhattacharya"
 ,Year="2006"
 ,pages="v2 123-138"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
+\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-131-146.pdf}
 \url{http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf}
 [Viewed January 1, 2007]"
 ,annotation={
@@ -1511,7 +1511,7 @@ Canis Rufus and Zoicon5 and Anome and Hal Eisen"
 ,Year="2006"
 ,pages="v2 249-254"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
+\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-249-262.pdf}
 [Viewed January 11, 2009]"
 ,annotation={
 	Uses RCU-protected radix tree for a lockless page cache.
-- 
2.43.0


