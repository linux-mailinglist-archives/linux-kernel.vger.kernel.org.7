Return-Path: <linux-kernel+bounces-778372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FAB2E4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E9616E6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF042749EA;
	Wed, 20 Aug 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USAUCJTw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A68224B01;
	Wed, 20 Aug 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713422; cv=none; b=oHNsByRrzpWg1A98R3FkntmDBiFv5JUpyA5B6UhL1INWmg5RDCsk8073DhT2TRmMYHLoK3W54e+9Y/sYbuTiyqNpT2b/PC4JCq0u+8VXdJPiw4KkUFQLde0KadbEYShh2bpVu5ftT1PTl9zkt2wxoY/4bfTcn0Za8pzT60eEI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713422; c=relaxed/simple;
	bh=FJxphuTyUVocXd/pa2H2+aAq89f2FJJnAgj6E0GIPc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nwj76xVwLriWgdp5V06sOMQnwEj3JQU5yyiEEEeCogaj5nckr1I0MaxvwdYrepNdU0699orZWBwMBDY14NRugPIKthuwSHl0gXHhXp8IpTqQ4XqOiRJM7HmUkN3t52p5v1mCHaNiU9uA9amwTUuFI0z9WabP1rcf4aM9YhdP5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USAUCJTw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445824dc27so1246705ad.3;
        Wed, 20 Aug 2025 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713419; x=1756318219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBEVB9H4EoZDoSSlySK1aiGBE2ClU4D49thMvdHYEzI=;
        b=USAUCJTwqQynuxPbtnGLh17T2qQkVV7D/g/2uiGL0s5greRShryMjy3jofq0NOdwM0
         CTFHfhottFpL3LRw6LyRCHquD227qKWKmF72jFdnNS/C8LeNLpSuIpDLPSZ23ZR818qV
         V9pyPyXnqaQzu4rP2nNsow79hZNugIOhE69aUSjk/ZXLiW3vv0rKVcyk/rtATLEe1BiK
         oSdnAbnhdA1+nlE2MObTme1GbUh0m+3ONrYNrGK/J7CPlOtgZx0tGSnqtZ9P0Ztslu1u
         BCKlPZuQmJz+foZouJPPdmOe7i2YVKvn+8SGgwWGCCb21D3xzm4/UtHnITE8al5oEz0U
         SKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713419; x=1756318219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBEVB9H4EoZDoSSlySK1aiGBE2ClU4D49thMvdHYEzI=;
        b=joSWU4IorEVsbgh3ov2GgalQPKZ0MiEjn9Qs8OCZUoBgiUlzUQBvCGBKmrmTZlivPU
         QPkHLXw4Y9NK++mjadlMWL1ic+Kz3WINGsfd5byKzJ+MoAi87zzuGcHNuEVfgDv2i6PS
         zIAE8WkvdjBEigzDd2HuGLeu2tU2YbSkn9/ujesLxKt7Aebbv3bxWAAbXY5ixvpgtqpC
         dWWj//BNktR9a2BuBohdz9kLpwiDu93IIE3mZNQug0TcGkaW61Ol6+h0p6EhDry/X0MR
         60tBnkpvZcdWrnjk3rKzvF91QZOmqWwiaEnnLO9iQEfoPXxKytXciuD5mc+WAUwudKXR
         1vng==
X-Forwarded-Encrypted: i=1; AJvYcCUaD8W7r3Cy8WsbkW5VjhI6xAG6MneaxSIRUjYg/dd79NucICVdIwXvswYojFj7b4wUY5pUmBaUFiajOQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5CYEAo3BcHqTxCqioBtQGPnQh3lDpkbbMUbLLwFnjoIU/ONt
	99l9zhnXHc1BCQDihKP03Hpj9P6HYwKgyUFKdYj3s/l7ti70Nl2tdBtxbj6hNbRU
X-Gm-Gg: ASbGnctymyvnu7EyJrBHW+r5cyBJ9QncvOHnFeAxaq81WBgygZXOSSKeTXDOtYRDPfS
	svT4DloITVCizjdVvlTrrEfxXspcnzGV6L5esYQ1yDK6t/p36kJWl4OV0w1p0pKTv7Xjk3nsdeR
	+K5/VEKSuKzbxWaTIVEc70wwrOWj2mxs/Yt8zq+GoiBtnUEv9CczcB7lcvovFzVHznR1kF+uJ+O
	5oxJg/ewDkztRP7uY42JBa603LXDn5N7O5XeGMErXvMxa+69w2Y96q2SPcWjMuw/tvAWKLL9MDK
	s2+IIxW9wirodKKBR0qODN6/2+dL+PUp9MJbGfFkfXQiTLA4T8Z+kcJ97gGe9xnwcuAv0mZ4PZs
	wWBicMPGnxVE=
X-Google-Smtp-Source: AGHT+IEpkl493kQ0YKFiRGAgQWELm5+0QmGeW3PSVaUEBDhf3NGLVGC8IEpypNw0+gCfcyWn/od7/Q==
X-Received: by 2002:a17:902:e811:b0:23f:f68b:fa1d with SMTP id d9443c01a7336-245ef217714mr54934255ad.39.1755713419280;
        Wed, 20 Aug 2025 11:10:19 -0700 (PDT)
Received: from lt.. ([101.0.62.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f7b77sm32776715ad.117.2025.08.20.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:10:18 -0700 (PDT)
From: eisantosh95@gmail.com
To: devicetree@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	Santosh Mahto <eisantosh95@gmail.com>
Subject: [PATCH] docs: devicetree: fix typo in writing-schema.rst
Date: Wed, 20 Aug 2025 23:40:13 +0530
Message-Id: <20250820181013.17817-1-eisantosh95@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Santosh Mahto <eisantosh95@gmail.com>

Fixes a spelling mistake in writing-schema.rst:
"interpretted" → "interpreted"

Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
---
 Documentation/devicetree/bindings/writing-schema.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 470d1521fa174..fcd4726f8df4c 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -53,7 +53,7 @@ description
   The default without any indicators is flowed, plain scalar style where single
   line breaks and leading whitespace are stripped. Paragraphs are delimited by
   blank lines (i.e. double line break). This style cannot contain ": " in it as
-  it will be interpretted as a key. Any " #" sequence will be interpretted as
+  it will be interpreted as a key. Any " #" sequence will be interpreted as
   a comment. There's other restrictions on characters as well. Most
   restrictions are on what the first character can be.
 
-- 
2.34.1


