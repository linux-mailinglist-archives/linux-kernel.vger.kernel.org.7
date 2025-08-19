Return-Path: <linux-kernel+bounces-776311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E63B2CBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2E91BC8C31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130F3090CF;
	Tue, 19 Aug 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSdGrhO4"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E042E2295;
	Tue, 19 Aug 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626823; cv=none; b=ZLqHrUIDNesfuwpsh2lN9/6w6PF0fMC7x44ibLL0Wx7KtLDZfsnMJ2GJsSfSycR9uocwoYhpTxt99K2TTfejhQghzR/SLn8q2/DIB7IwqC7IrheBd3lkgcX9UH+iB7XU6ENUzBofdhM01NxwsLFCO0U1uus8TJE/X1/xkB3UQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626823; c=relaxed/simple;
	bh=3DxhkkThZ4I+6qbZl2FvYXszNoptrc/VngFBPXWfh6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4RnOJ9kVb3CJHi4zsowvXEDZHfCjioojkFq91s61TkXsVQQkx91oKAIB2LV87cBqpPEky3GU+Tuz0SdGQtpj8aqQR0gB7fVo+AXsgf7N05vcAmac7BmjIE9SI/82htUsPFAePWXCybtMsqW3cmwxBYPrpGAb9sD5vGSX0tvoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSdGrhO4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b474e8d6d04so1572052a12.0;
        Tue, 19 Aug 2025 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755626820; x=1756231620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0R9p2fQn8GJnwVe64YN9Xd1bbPGafk73sPRkSBdSdk=;
        b=TSdGrhO4HZpRNIoTAmnivmGcJCPUj1PPyMWRNj5Up64j95MQg5tTr5KPUUj8v9mxjv
         puRsBCTzTdqWQHRc1jyaELXXuMB+OMnP/o1xZIu1a9TLLLUVR+rlLqLCBlwGMyRLQSzV
         OvO0MOPsfNhwHrqZWvJAbuqGBkqg0kRRbPOWB8KlQWpNa/+J5L5l4TxrlQBBm9KWH95O
         7p3D/PZH7N+m9f97mYI6JM6nVpocpVsgbZF0zkHvxUI/5dgD+ooU11+Lf2QN6Nubgfl+
         UWVgP6QhFkTr4jlEZJNuIuUxyG7rXEEU6rPzO574BgQf5OpqG56C9RZdR/HrP8Zr1hlF
         uzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626820; x=1756231620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0R9p2fQn8GJnwVe64YN9Xd1bbPGafk73sPRkSBdSdk=;
        b=Rnum4Kd4hGCB9qCaLObg8kPVIwxiy/RP1Mf5EztCF/3ZBbOGyp6Gw0eQ55H01Me/E+
         WXpNv9kWauo8+9GM9fyMgyZV1jy+5SktIMflgwvsN3r+1ByQQ8Ksvq35qGbusgbwdjnx
         fwRQ25NxU0dV9yUooG7k0JxXAnuozdYzvzUF4vrH4jDn+76O/V9PNipbXjJHyld6txkP
         4tBPYbGBEAVCqi8DtcoZWAfEQJvUmenWGTRrOQtI1khY8qnsh0r9ZfFZn9el1ZTiAmZS
         Jr/EIfZu+/kCSF9JXnjMfcO5vf807VqV3JQvVgS+1fohyD5g4orimeDo0sneqvnl9TCu
         xtng==
X-Forwarded-Encrypted: i=1; AJvYcCWReu4bLA2LeSCII8L0PhitjFcOoHjjabOnQEJEMb+3TTc8pHlv6QvIX8oxv7aSeXyUG+GfomJ9z78iMyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycK1cIWw9T5DCCsrpTd2nUVO0LiijDVRGWJeQIBSVThTBvvW5a
	6Zg1xtakTFN0/00+tugjCxJEikAWWJfZPZPC3ya13knhvtsyGlIP1O7cqLDskw+Lr2j9NNg=
X-Gm-Gg: ASbGncuNNlvEmJe2HFDeDE+gXeVVWlar7LFP1Xfhv6PgFWowGSfoyCgVTabrStYHi8O
	vkGctsIkSC44b09vJdnc99hYpjFL/P651MAEys2aE4Gbn7Kv/qFeME8UwzCt3+stNDR9Xl/aCdu
	O6X66ju/U60wm2Gj+maAwiaIG+SeiZ2PN/z4WGhJvNkcx2toqvAw+l5DUwb/wew2jfo0MLVLmTa
	mcmaX5o/zd5Y1/PGbDrO0vrZCYwdIpcym+Qk6YlX+EAHV32+BLuJvj7m0HY8YDq65ismwNVCHIX
	J+htqc6bZ6h5UR8VI9hk1Ks7ZMnFqyeSIWSwbo8s1xK26tHP+XWp0vs8arLCv3da+HtDdekeV5Q
	lMvfXfVbHEraw//jBoptXI1zFTrBfS2ipbbKFimzbZOOOUeUV9T8=
X-Google-Smtp-Source: AGHT+IEMUDDAgxGLdiNk+Ulj8E4woihdXtGuuFLm76/KtgRJfNvTjmcIEctMlTiCJ1kEYYd+Xu0+Qw==
X-Received: by 2002:a17:903:2389:b0:240:5c38:756b with SMTP id d9443c01a7336-245e030b78bmr37919655ad.14.1755626820047;
        Tue, 19 Aug 2025 11:07:00 -0700 (PDT)
Received: from kerneldocs.. ([157.51.109.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51ae48sm3200305ad.139.2025.08.19.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:06:59 -0700 (PDT)
From: Nikil Paul S <snikilpaul@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	snikilpaul@gmail.com
Subject: [PATCH v4] docs: rcu: Replace multiple dead OLS links in RTFP.txt
Date: Tue, 19 Aug 2025 18:05:46 +0000
Message-ID: <20250819180545.3561-2-snikilpaul@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates several dead OLS links in RTFP.txt, replacing them
with working copies hosted on kernel.org.

Originally posted as part of a 2-patch series, this is now being sent
as a standalone v4 patch to avoid confusion.

Changes since v3:
 - No change in content, only resubmitted as a single patch instead of
   "2/2" from the earlier series.

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


