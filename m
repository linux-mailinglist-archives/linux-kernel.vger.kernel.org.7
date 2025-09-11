Return-Path: <linux-kernel+bounces-812526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E0B5393F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B81AC2166
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C803371EB3;
	Thu, 11 Sep 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY3POhRl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A53680B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607830; cv=none; b=LfKvoEHWG5qVttZvdIhEbnKdHIYwr1XAxfCxnyf5m9gQ/61fHKKCXrw7lzEej+EIexJDsP2J4jj2yMU+qxcKIzz9TOFHG7UqiV6qV0L/qRJxdtuXAqbs2XV1/broYqMSyDBKVUVIMKmSn68xjUWd7G/MLHhpMU2+TC7/gtJrU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607830; c=relaxed/simple;
	bh=gdRxCV3dbaFjfI2cfHOKBREPk9DDd3LTFs4jZWiRD54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiFrbTBJzX96y2ZUTPLUGJkVPxd3v0KKec7H3lncp7OK/0VlK+k1taWE+C8TVrriruJb1rLLK3BNyNsZwGoOEWZ0utLk1uDwSYHSzOB5aLJPznrVnzd7uNR60ZFpGAX+f/ksJWpItmeESl6ivsEkUqONBkFrAdKRPiQhylRJKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY3POhRl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77238a3101fso685586b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607826; x=1758212626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugQgxXVFkF9wG9b5WaSCNOwOilaoH403e0Uwi/B/lqY=;
        b=VY3POhRl4WhKQGA8AJ0dKvOnoo0nMKW4OaVEflC546K+yBqV+g93OKthqxw3uON+Cn
         v+yKQjQYKpYEr3EZTOgL5oI49CMr6pJOYRCyCfBJDMp8KFaOjqg4XjemA0LQEnwy2rhw
         TqwSFD9I3vNbSu9QXMS4nPMb8Zaq1yptL6BrcxFqKXiSyvUMWVyzu0Af8qlLaPRiXzIv
         B2eqghpFJopQUT45wpaIRbzOPIetKZJOZO00nYXTDS4Ipd8HIS5BJvUIv+UphppXOBEM
         iAyxNdnVqwilwf0tUan/OJm8q2N4qkouhVNt5/18Z6bcEhxQwiIU80rH1rL+/0UJ0bIS
         V5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607826; x=1758212626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugQgxXVFkF9wG9b5WaSCNOwOilaoH403e0Uwi/B/lqY=;
        b=EjZDDAw/JvVUvxJ4zbdlrIJtdC1Xd9jzGxA66aCwlqaxNacQFFwPuP4JaP/64jUupB
         NH4VJ/oCcYAZ31Go0UyLSrCtxJy/HE6w2D3tMOCJ47Si3VzK70kEgvLG9BSz9tMI4/Jx
         2bfXYg4768XVhoVBXs/lGLl4L0itzEl9BbelHPtInYMvVZxiMijjDkSKgxaTdCjTl7iD
         SvrKbPuqqVEMVTyAiD2CY9rmcjA9z36Q4aceFEHAsSu2pz6llm0RA9MlIwxSS0Jnqbva
         YW5FLul7T1+zMjOm0NwUQfTdsMQDt9I0KO2/SPkCV9jcDHuct5yUoSi7YGavusPF48oI
         v4OA==
X-Forwarded-Encrypted: i=1; AJvYcCXN3JweSPVO7rEKExEuyzfbP1zBQj1BbekRFAAXLhBAguETGt6h6fbEWX6l12euSu2OZ6hTzMePX7p4+qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAaT0vwQvAK/AaY2LwsD9ZZUSxcTqUD8Fobx5M5WZ3eWBs1a6
	ISRb9RjBCN1v17o2GbpmiUU22bKoHLj8YK0vmwyYLy91xSTiawdCVXfdz51Sqdc5Os8=
X-Gm-Gg: ASbGnctU/sIdk2MvnY94k3kTO3I6wUy26L8c4eEqws5kFtj2PfPGhcoOQWUwDPUkB7Q
	krRo7GKB9twMZJmalF/3eHIYyQ6reKU1ncYGnzgq6Tsc+YnD6ruHvEnYWOJdgBcwW39ZpW3eu9o
	9Q+OLFQoBY/BZb2EM/7y3Jyaj4a/IUuGWy16qwfSGDSb2y+Imkt5KYu1J42MrOXVfa/oPITuYfx
	Fyu0VFzdNrU3CZcaMHWI9v9RjJ7v88C2JdZXMueF6suLYJNLQhVVYxqLgyBh2YLBkLFpJx6ElBA
	x55rHEgjyg8e8qkrBvjw3irhh457Ql6ktPPcBoHBesLmnQwrjNSF4MIRKoKKV+6BztYdhE7Ahjk
	R10X30dKI949n4ZTVjcHqpcrDLIhouTpwv7sCKaUkTBD8dBt1qpYKayXhRmF1lps1mXVdGNqcN7
	pimy8gAlFbMBbQfxxpsbsDUjo8cxIW74DnbMhuGCM=
X-Google-Smtp-Source: AGHT+IEEi/kiOLuEW5zDU33cKWDz/GEJ/YhUOAwUcErjr+0ySOxI5rpKmstBb19ZMw68qtyisktweg==
X-Received: by 2002:a05:6a20:3d0a:b0:24a:a45d:7a26 with SMTP id adf61e73a8af0-25345a4498dmr27933903637.48.1757607826347;
        Thu, 11 Sep 2025 09:23:46 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c471dcsm2567567b3a.96.2025.09.11.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:23:45 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] Documentation/process: submitting-patches: fix typo in "were do"
Date: Thu, 11 Sep 2025 21:53:36 +0530
Message-ID: <20250911162336.16261-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a typo in submitting-patches.rst:
"were do" -> "where do"

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index cede4e7b29af..fcc08eb93897 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -343,7 +343,7 @@ https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
 As is frequently quoted on the mailing list::
 
   A: http://en.wikipedia.org/wiki/Top_post
-  Q: Were do I find info about this thing called top-posting?
+  Q: Where do I find info about this thing called top-posting?
   A: Because it messes up the order in which people normally read text.
   Q: Why is top-posting such a bad thing?
   A: Top-posting.
-- 
2.43.0


