Return-Path: <linux-kernel+bounces-778981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829CB2ED7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F351C83C30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB928C011;
	Thu, 21 Aug 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX9a2Bh/"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAF253B43;
	Thu, 21 Aug 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753405; cv=none; b=j6AwqPVn7dyh52tpdzo+aMyl9B3e0k4fwRUAL9vMeufp4RAqiPN1l51bO6+5snRR7jO65Yr9wz2I52nPoGQdNX4A+wnyfWtulPlaQR5Jh0fuQSsaiEguRQewtqqXfx27lgtDtqwtmd8y/V0tyVajnuXzztvWiGX9WhqrdK4pg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753405; c=relaxed/simple;
	bh=BhUu/dqckzWlpFgGsZaoGhamQXuN74Ue3HJx1CshBqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geMgJV7AFRRa+ONRlVpDgCXzhmYQpRFHEjYEfXfRQuuvIupMz1vCDCW0/uMGkHkt3hdNXC08HyJCDudb8c+CxlZ2RjiaLH8fSnnxOhITO/XaohRFM2whyT3R1ftVMEcx/m2Gbvz11CZH8VO8wPGvod2XarT7p5sfvatIO5M1dfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX9a2Bh/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso113041a12.2;
        Wed, 20 Aug 2025 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755753403; x=1756358203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlTHfa+x0uudQk0OxSTFgf0vUez6OOiOBSo0LqzMZeY=;
        b=KX9a2Bh/BsMrrK46YPTb80T1+u+QvBtQpUWJj5N3T8EZw+Lu/5x3S15tHVcbRZo/D1
         1ps1ayCMpJ09Nmwa7AycrKa2nMGOlRGO3EnS7g2I8RLZFQQUyDyeYiaCSA9Qrs8ob/jf
         OAUjoJ3JcnLrXD+5Eh0Ja/D2hPwiXmTWhjsZd3MDLDe2QpEW11+ckEM8WUwrIc8rC6MA
         7bJaOgiVDAJwfz2vuvol0UpW6cYEkQFmJECzt1rkybGBPVnP8kE3oXVP60MWnfUtJaUo
         7CP8NIVHjrmsdev0dHVSoV6OsW5ULGq3awh/d3Rh6eaMry9qpLSpzyDzVindFdF8QLXf
         stKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755753403; x=1756358203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlTHfa+x0uudQk0OxSTFgf0vUez6OOiOBSo0LqzMZeY=;
        b=xT7JP/tR19EgyaOI6e3JDeoMvROZk8yl/WrzYS0HBjm0+5iv6jVrgmL1dEyRqE2BmG
         9/g+RBHHdhXo0IlyeiAZhCkEnMAnPuAFg3WMEuOC4QVGBl03A0ac7SYdzWqGVQduiqYb
         WgFeJYqbi9iGAGwFN5ewEZuJWSclMew4MylUeLF44MAdzf+O5n4vFtY3RzsgxMNy5wj6
         /4OtZmpUNHaM+PYUzMCwO6Etmaf8uLDuv7cIPvq8oNTmZkZjwNg6CQSrrIDufRnonqsd
         G4cbh3qKtZsw71zNnV9tmlbh/6IO8lC5GpTHRghN1dufm/X6ytOkjhky0Uql8ZgEt5t9
         /G5g==
X-Forwarded-Encrypted: i=1; AJvYcCV616InrcJZHHBr1pLHJ2vX2a10v2hUHwZlr7OxI7Oq3gkLy6W1NyjZuAo20dygMJFKMKQnrxLSuB0G/KJ6@vger.kernel.org, AJvYcCVu0U7FSCOZ5ypMvSJZG8cfbYz2+1G9hyUg7aHW0js+axZncnFcz+236SlhOrnCZEi6Jky0VRUzK90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4Xe4yjBmtsG5stIm6nIhyxHEUOEnjmcxxnECBlT1m8O096eN
	41/5aYNhZRK6u+xbWN2DE1ksuLbxeZwa8U8y4OLPx9f+/zjwr3xjfJAQ
X-Gm-Gg: ASbGncvQrs3VnO+n5vgOsZEEICd7fBoFEQEBvWfJJ+/7oYSkYKxNNc+MajP2pXahFDz
	FikN+akq6WPo4JTWzwBS83nJS5abcbIbE5wDAfe/RmdK0xdlAO9yi4f4Uep9qYPiHJRYNoX3HIA
	DzrVH8h9etPHEnuWpy+RB5pVhKuaovVkuVAsVpBYo3sFwD9o++DTiqG76u13QZXBUY2gSF7m+pi
	yA9AJXEJQsYvpGzOSOWhgj9QRlQ4e/S95lQUsjY7RA7TLKglQpkEbt7pXpdye5Lq78mcuV+gnrn
	RjxODjh5xAp8fZYrCNT/LvHRxnUQRA/IC+zaC9MCc8hRAE2ngPx0qs5JNRfi0T26RrBW/a/me4k
	Cia3WJ0yB0/0WD+2xCmCKvOjEBifsWyeKj+JirXcGIj7wpO3fpTN39pCsaB3XYN6EAu9Hc2rWXx
	U=
X-Google-Smtp-Source: AGHT+IFcNAi7YmrTTwPeJfG4g4IzNtFLqJ+Lotl3SbBTAxuRu5974wNQN3hli+1Ix2UxQ0JbmEng0g==
X-Received: by 2002:a17:903:32c2:b0:244:6b46:287b with SMTP id d9443c01a7336-245febee20emr17107765ad.20.1755753402588;
        Wed, 20 Aug 2025 22:16:42 -0700 (PDT)
Received: from primalkenja-desktop.hsd1.ca.comcast.net ([2601:646:9d00:1ed0:f117:a404:888:9420])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f1954456sm35285305ad.121.2025.08.20.22.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 22:16:42 -0700 (PDT)
From: Vivek Alurkar <primalkenja@gmail.com>
To: corbet@lwn.net
Cc: Vivek Alurkar <primalkenja@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] Fix typo in RAID arrays documentation
Date: Wed, 20 Aug 2025 22:16:21 -0700
Message-ID: <20250821051622.8341-2-primalkenja@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed "write-throuth" to "write-through".

Signed-off-by: Vivek Alurkar <primalkenja@gmail.com>
---
Changes since v1:
	-Changed '"write-through" and "write-back"' to
	'"write-through" or "write-back"' as suggested by Randy Dunlap.

 Documentation/admin-guide/md.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 4ff2cc291d18..04668272c0ee 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -758,7 +758,7 @@ These currently include:
 
   journal_mode (currently raid5 only)
       The cache mode for raid5. raid5 could include an extra disk for
-      caching. The mode can be "write-throuth" and "write-back". The
+      caching. The mode can be "write-through" or "write-back". The
       default is "write-through".
 
   ppl_write_hint
-- 
2.48.1


