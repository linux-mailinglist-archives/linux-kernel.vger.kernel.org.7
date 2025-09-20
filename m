Return-Path: <linux-kernel+bounces-825851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B23B8CF22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6E17C80EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58622238C07;
	Sat, 20 Sep 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIHssG4g"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E812376F2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758395867; cv=none; b=kX1/mdSYBCMxWapYg56L94ZM3o1Mp76RniqEOUrTA+GBDWuKTI8E+8pPSlk5Iz9iGfH9lSQ6CiPoXNZGFdtTpRscO4RHjoEZTpbe5XIxQp6MuAXGfzNLtcA3PsNzB6BAVyTXeXJZXMXwQEwJTV6uLaP0Rj/cvv3x+v7WZ77i1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758395867; c=relaxed/simple;
	bh=VXhQ/46RyA4dTSCM/jKNIFCldKvMR/nbIDhjM+NTVTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAOzYnXoZ8sKFq5MuKzAtKerd5KyWOGUFsCcz83Cq5kM3Ujujiso+/zhg0mCuGSljqkPsVn+P75DYML8Ju8JULRl1Lh3dkcf9TVmAeWAPafIWGgLokt4a/N2nsR3aT4wAoN9Kpy6srG76SqJ61KLULxxZnAoFtsnNK4J4phedYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIHssG4g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330631e534eso2744967a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758395866; x=1759000666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv+t2rS9vLu7zOpVhzxfMKjww6cCPuDXCk54kDg9LLY=;
        b=XIHssG4gDqW5QuwXOkHJ+7rIs6QZRvtOfDKm01FyYdb2L9ikh7EGSXw9R0UzHit+fA
         7pJTxhRVF4yDJYWbm+HCjvGpoIq2hQNYOIR0qZNicXN1+xNwtdcwvQ6Ibdq+xhHV3Od9
         9s8zApzqzAimASNW43RIEL2BuTQSIxwxypupp3hzBr7HNqWzOZI5Kb+PLzlMHuFI94iz
         4WgHAonD7MuEwmd0ZeFwN3NP8paKyrgSFp9nb6sv8pdAuKDfEwLP+shyPaAYKY0dh8A9
         HMajREvdyIlzZllCq3jHALMobvse5k7wC48DtsmTVvacrYlyqP7KvgdW+MUm7wqUhb2+
         1DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758395866; x=1759000666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv+t2rS9vLu7zOpVhzxfMKjww6cCPuDXCk54kDg9LLY=;
        b=UF/+5okENdpvV1a9xb0shdMq0Yz1MFYkNsLUywBH1RjSQ4OHmbJrz9V6jgSOAkNfeN
         0QF762hFt/aKm+y+NzrkG93GOcJGJfjIWOMQvd+r1IEoSd8bqNQkx0L6QgpsPPacyMsu
         3+f8R18rjyZFAry5oXjFtsQPApOFv/QRwwqSVy1ik4CvNyjzYicqqD4INSs4NMgwXaZO
         4eRW82xaj14TiT4U9xVMPxhRFDz7mc9JWadzpL/X2hmiXGR+vAi5Db70BLo3lPWIL3hp
         1eA25l8KhUpISmBQ8Di8P+zXIxbejnBlCiS6/hXzJVOhKK/YCw9VBDSL1LCzgXphs5Vm
         2MnA==
X-Forwarded-Encrypted: i=1; AJvYcCW61Ja9Tea6tCAWtT0UZEybWQA2VBqf2RW3hrvfQ3/MvUANFxIn/WqnvzUnM1ftBhXdXsYxM+LKyJ6wHeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKS/VefbrwoHBy8QiSkDA5mP9/5tX/L9PKfKAi8yREhNPxUHM/
	UufI0QqwxBbL5H6+23NvCr5y15lS4AzrhcZWGEDqv77BSGH4w/JYI8GU
X-Gm-Gg: ASbGncunla+GdHiM2eKZKWPl2j8Mks8kaf6rMqe0QkehOA/2do+8724bkkhhfCFcyp+
	I3yH9sx2Dj2tCDngMpHCDiId02Onvfs+5wE6yZAz43swU5QbyewZD41Cy4MgQ8HSvhC3/d/r0yL
	tK1tJrs+0tZt224y7Ny1vjx/dHZMTlsWtPVPPlYXjRRvFjjnKrJ6xFBoBNZqp2rh9htvXPAHmX4
	A1UC6SCvdoU+EyVh3dDEUjquF3PhD9/Pmr2W734ZwWmqqRiec7GPN1DESN5zuN9z4jfdLY0ydLS
	UrFlVfDotYpoaE74lzDWhXAt5YevfVwdAPn6Nx4fzqNyTsp3L1KDkLxDSlanG2ThY3sQTk7Qqjy
	+lmf97gJaq8OXvUrIAqhwEcvZCw2qfAOCZFp3zkORSotCRp28A/TAOfHPVnd/xpKDuvawcKQLE7
	p3N6WHp/0F7e82qzwW/6tTB/qXjDRI
X-Google-Smtp-Source: AGHT+IEJ7Iamw1ZU0fymOaS1+7kZXHHtOoQORKIvbN+CH9xL1qQlDIAkegTMeAx3Vok154cEG62wTQ==
X-Received: by 2002:a17:90b:4d85:b0:32e:a535:4872 with SMTP id 98e67ed59e1d1-33097fd43c5mr8692434a91.2.1758395865587;
        Sat, 20 Sep 2025 12:17:45 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060617ccasm8637158a91.3.2025.09.20.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:17:45 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v2] Documentation/process: submitting-patches: fix typo in "were do"
Date: Sun, 21 Sep 2025 00:38:56 +0530
Message-ID: <20250920190856.7394-1-yashsuthar983@gmail.com>
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
v2: Resending patch as v1 received no reply. No code changes.

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


