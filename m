Return-Path: <linux-kernel+bounces-886534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECD1C35DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53BB74F8388
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86B31E10C;
	Wed,  5 Nov 2025 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1xA9WFF"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14803A41
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349731; cv=none; b=rARVcCDmUpbi2RRbgD1oddIuM0/LseRRWZ0vXeHcHaXEYuzC5EA9eqiD45CgD/LyRDQGmaVhFiEGTh71JFd4jGFUBHm2WlaEnyhx7mFPxJGJz89MneOh+MEefj/JmwdEKbkCoygIryziNs3/RZyT00aEmIPSI4TqSjDYZ3pT2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349731; c=relaxed/simple;
	bh=YVzjZNvEY5wlcsOgc5iechhwm+0MSXEhvT2EVqSRpM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L9/ouZF1tQCQ1dB0IMm+/0aenQ/7o0DGeauiwh2CdqxXtskojLYiZH98GgHjkRhCq6RMMORjhA6RazIZtRedsyP5RT/QjIc2eBH6c7CV0cZvPtZX6EuClvpCTVCw+B7v0GrDgFlAT7XS1fdFS7Y/73FZ/oVRkYbbGZEUiLjt8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1xA9WFF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3103540b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349729; x=1762954529; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMcpJM9U609o9K6c/w24YMzRJfQOd+BnRUVotnA4m/o=;
        b=F1xA9WFF/c1QCjJ8qbDs76E/GIGR7d4k59pjS61abxgu+zw8ibTnVYbEl6P0+MncCe
         Mjypz1FAm6JlFDNEGdjKV9dk0Wg4ly/Te3T00sv6RQSDNIGCNwObx2sBkHN1iFr+IX16
         d102L7CKiVpualBJK93o7ZnHImxF7eg+AZRhB4R3QCWc+SYlzAtwc30mqTXIXluplJDr
         1Kj2a5UJ8wv6hpUgZ8DLWuuilj84R33aEhCNTe6Z8GiRvi8CkLJrYkKD5U/8p7vjJvQh
         ognYsUZAQk1bL/oskiCX8Fk6ollbChqtMJxmpehE4siqy9MIicPSZc0g6NO0yteP1RR0
         v5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349729; x=1762954529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMcpJM9U609o9K6c/w24YMzRJfQOd+BnRUVotnA4m/o=;
        b=FEvUWHnpYO2ZGp2r7kCiTrUvhXfE8hJicEDN/VjyWYZkhTdTrebvArZSEMsBuRVBEo
         DvBfvLxspyDg8pr8ZMl/7Dl+U1R+HwiJmQKnM86viBfijuc48FadzFleRhKPJLCYF/l6
         UeFDq+DhHJzRHE6vJIKV9u0hMqaSIKfn9nCjBrErp4nX4Fg7vY3/JeAT1KKOVaj9fhlR
         MHn6QnGHNGAtuXonkVlBxPCBOmu+DlpRJrgVlihOLKxo0lObxhZv6Fm+0guldt9dmKaO
         UPjOWwdI041TH2mEWkXvu3yQ9y8U2okbuRXtoej2Fb+DusPq5ydFA1nOGBFQYWZLQiEV
         jwXQ==
X-Gm-Message-State: AOJu0Yx+LBJQQQ8i570gtb/93USM3s1nOCrSMxUCxUCg4jx/21LAyGCE
	WJgPQ1190dJ/P1ur6mPJ89cOB+dLiT8pzHVkGP37OioWL/cLiVUBtZ9t
X-Gm-Gg: ASbGnctIvJs1CTY3lz1MkUke6DqCqYPqofdP0Ormo2sGr490ChRmB/Q5aSPrYDpvsQO
	IU9UkqhnoUQQnLsNwdSyzpzuQ+CEMXhs4UjTMaFDednXyf+dDmQm09pNovGt4brfODisJmTbAzu
	tfzYvWS7Q6NBSQ1GK/d/9f9nMf6Xsg6q1RepLyfxfwpg4OhUAuRyhf1MX8qt/d9DnT/+SJGaSap
	2EvkUnziT6Xj9isV16vtlBE+XHtZK5jaMQDhWlstIqZ1hTVtiGv5ftn/oCs3fwVq9KEDDfUgmnW
	DnfrixK1Hlfq/9pASsTsU8PSn6Md+zG7RD+UebVzZYqtiCX6fwLR1+Vm4dPut+yH6pVCuCcSwal
	j3xxy7U8C9Xd/Le3Pq5bjdejzIFnggrAY+sBWnvteVSL+AWk+IoCcCTokAs3uFvKxp1aF3AkQ
X-Google-Smtp-Source: AGHT+IEMZ5fuJ86E4V4D8bLK1dn2Zk3jFYtQ6tft/Z6WD2q8e+rKY6orgtWKTyq3NHL/DJeWpblx2Q==
X-Received: by 2002:a05:6a00:1496:b0:781:556:f33 with SMTP id d2e1a72fcca58-7ae1cb64038mr4101234b3a.5.1762349728805;
        Wed, 05 Nov 2025 05:35:28 -0800 (PST)
Received: from localhost ([2408:841b:d10:e194:6f22:8ad4:a287:fde3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3824e5bsm6367965b3a.17.2025.11.05.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:35:28 -0800 (PST)
From: Encrow Thorne <jyc0019@gmail.com>
Date: Wed, 05 Nov 2025 21:35:02 +0800
Subject: [PATCH RFC] reset: fix BIT macro reference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIVSC2kC/x3MQQqDMBBG4avIrB0wMSL0KqULTX51oESZ0VIQ7
 25w+S3eO8mgAqNXdZLiJyZrLnB1RXEZ8gyWVEy+8Z1zTcc6RVYYdpYcv0cCj7IbB8TetyEkN7R
 U4k0xyf8Zvz/XdQPqOefCaAAAAA==
X-Change-ID: 20251105-rfc-reset-include-bits-4ec72344d1a3
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Troy Mitchell <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org, Encrow Thorne <jyc0019@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762349722; l=926;
 i=jyc0019@gmail.com; s=20251009; h=from:subject:message-id;
 bh=YVzjZNvEY5wlcsOgc5iechhwm+0MSXEhvT2EVqSRpM4=;
 b=z5nNIh0yvOYQCqTKP/x+gq/NSPx+Kb6ubMHvNUA3XLH4pmdjKlDl9WzqfSI/MDGI8PrtxpTG0
 si9n5TeXXGKDvKiuYB5D5lX3MGVDb6ZCd4hh3GTXEuAnAfKS4tixy5G
X-Developer-Key: i=jyc0019@gmail.com; a=ed25519;
 pk=nnjLv04DUE0FXih6IcJUOjWFTEoo4xYQOu7m5RRHvZ4=

RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
include bits.h or bitops.h. This causes compilation errors when
including reset.h standalone.

Include bits.h to make reset.h self-contained.

This patch is sent as RFC to discuss whether including bits.h in
reset.h is appropriate.

Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
---
 include/linux/reset.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 840d75d172f6..d3102eef085e 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 
 struct device;
 struct device_node;

---
base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
change-id: 20251105-rfc-reset-include-bits-4ec72344d1a3

Best regards,
-- 
Encrow Thorne <jyc0019@gmail.com>


