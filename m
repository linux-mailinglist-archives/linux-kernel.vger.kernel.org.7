Return-Path: <linux-kernel+bounces-858744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C228BEBB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57B21AE3301
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024C25F973;
	Fri, 17 Oct 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKSMlI1V"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120C354AC2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733463; cv=none; b=d0eiiWdbimx+sdc0x7Qil5v8wtGI5v8iD6bTsXZIybBZvELVuGe4j6v9GSffJVs6wiGULHhnN9hyfqhHv6w8+8lZ/B6VzFF1dLRG+ILxkd6TJEwzr+p3VvNAWr0J9G0qsELGO2X7/C2RieQW806PPKQeWCxNtuSZdPU36or5V/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733463; c=relaxed/simple;
	bh=t2vDXy/N2ueu39KGbBgzoIFHjBCJD6yAmUD06c2XdZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1Xubh5Oy6s2ca2x77147qDPrB9Er290dGi5OP9r/wkFQ9WSn2Dpl+QQTuJj/OQ8hQAOjG7UxsZ3le2a8AEO0rnaMKSZNBe9iGjWnc7SBR3f598HpAARz8rnAju+rRuDXy51jUubMwLqAPfh6BCqLvPBccPqor64QZU/I8AXhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKSMlI1V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so44362175ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760733461; x=1761338261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PJC7jMvSltr45N6j/1sXc1iZUOgofsB+o1CC9x8JZE=;
        b=WKSMlI1VVQL+fGdk+hnhtkNrPTxW+8gKTq46Vgla41KT1Gr7E+MrM/dNuaAkA8KP73
         dkaXvB1MFQ+dUbDhzfB5bpsa9t79bwsdfo6yzWjeHsGM9KUSlUiEbqikGEyKh+Mcrh38
         CNZLg0wQ3mLh4XJZfVNQhBrJxD3wkr11b5wjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733461; x=1761338261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PJC7jMvSltr45N6j/1sXc1iZUOgofsB+o1CC9x8JZE=;
        b=Jcy2Kk4RIr+1Z97RyeSBM4Zl0EPFLQIHtHviIQL6Um/oQ58/Ludf8AS15l9s4guclA
         tq7OQnLH7fRjQlSCknFXKs3+Fpg1NyoPFmQq94omSOPWroSuhxFRAv/caPMAiHYDm729
         1m3sxEFViy2l3rNQmd9eHFT4lSl7zIzYu48UDOkiDHhd18ZkaGqH3N2Mso9Tajgz0AIW
         8007aecWhU4mzQALB5hJcwylc0io1jM6Cms8dHs2PZD4tvYLz4P2lOyU7L3W6zHzLuZq
         pQdlbhvw4Xa03PQRptRE+AuH6Qw6pwwF5+SCr27sSV7LqLEM9M3MvCsc3z+v0Qc7wsiN
         XRKA==
X-Forwarded-Encrypted: i=1; AJvYcCW5JKhP9iKHszPlKGPdXs4arJDgkiI+Aoyt7OGIVIj3j+s48/eDffkOJzVLEaLwZyVR3x1fiaxxtfElFaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOop6luIAFvBraFlAWMB09R1cayjeBFHmnhhoHDfMZXImuIE8V
	jY3WuNE1lUkGVLzFcHTnSAi3NxPbzjSshsWB2ZXh/vkP4M8ODSVq4OKjhv+Ip0JvR+OvCoXT8jk
	6x2o=
X-Gm-Gg: ASbGncsXKgDC05eeNHoig2L2kulCr0adrQ1HUZKFbVpvSpTK4jZKdjEF60r7/+X8lDw
	4JhMekJGZUMPGreiFnRg1fJaY8Z56G8tvNsvOF/XGPNJXf6xPyBOeugkSxK/+SijncASf47N6vt
	CiXDnzljZkDLsZfSNwDSSwJvrjk+7/z2h5zk8JObYORZUio3jZHiBomU1b9mMyiigyF+rP/rQEx
	q38QaAR5BOOVnhI6nReZy2GyZH43j+sICwIqLjLMe3eCq313bsG94Wxwfp85noJk9/2YT2a5Iqz
	6xFGPUOXaG/FX0vBUVwWbsyJjMtqtPiGrnnjjRvaDKa1SYXlNR13T4LDAbXuigkHI8aFhQozeSE
	NvzFlWLWXAortUAMcrwtVEu64v7Bq4W4MDAKyoB5AnCYQmJO8N5/4SK6Y6f6ZxlltBpeAjaKhdi
	5vqLQv3ygu2vTtFNc/CDy4KBVt7Agg0u361QnP9twuwb+VDz22
X-Google-Smtp-Source: AGHT+IGroNG6E6CZwhT/9LbiABBUYxgk0gxokJeQCFd79Alxi774wplaobu25vmDQEPRfMelbU6gFg==
X-Received: by 2002:a17:903:22d2:b0:288:5ce8:ea74 with SMTP id d9443c01a7336-290c66da7e2mr76340735ad.3.1760733460923;
        Fri, 17 Oct 2025 13:37:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2924721936fsm4049835ad.114.2025.10.17.13.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:37:40 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] docs: checkpatch: Align block comment style
Date: Fri, 17 Oct 2025 13:37:11 -0700
Message-ID: <20251017203719.1554224-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ironically, the block style comments in the checkpatch documentation are
not aligned properly. Correct that.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---

Changes in v2:
 * Add Randy's Reviewed/Tested-by

 Documentation/dev-tools/checkpatch.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324..d7fe023b3080 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -461,16 +461,16 @@ Comments
     line comments is::
 
       /*
-      * This is the preferred style
-      * for multi line comments.
-      */
+       * This is the preferred style
+       * for multi line comments.
+       */
 
     The networking comment style is a bit different, with the first line
     not empty like the former::
 
       /* This is the preferred comment style
-      * for files in net/ and drivers/net/
-      */
+       * for files in net/ and drivers/net/
+       */
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
-- 
2.51.0.858.gf9c4a03a3a-goog


