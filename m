Return-Path: <linux-kernel+bounces-827195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C0B911B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C3516F59D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9F3064AE;
	Mon, 22 Sep 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpHuDnXi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF6283FDA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544009; cv=none; b=uPNxp9rDJp4e5UuELcGsO976zoF8y5h5xtuwUqWk2isdLCdfCeSWRZOP8qm/Q1OivOBCQMgxerDJ5MvA3nnmkxvz5En9c7SEWTenLhn8Fx8Jx92oOsmrTkCnEuixePipJ33Ey1kFE8cGnX6Xyl9K5MBDTP6mxqI/tc2/6wobM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544009; c=relaxed/simple;
	bh=8rrFH4hr1izK2boh2nC4Hg35q0qZ01RVDeNujNXSldA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkGTbXIj2qeAjkDiwwL/+U0NogrHfixWFJsYmhvJ4s1NLbVm2GYWPJXk0EUe7NndW94MZe5N/oTP13cF7U89+QUVoI5WUiPTyWw97ZHNzLC+sMp0ONzHlcsktorenrRiQCwci8QE8msYp2NkGO4uc9Fu68cWQ/mourbbh3FdpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpHuDnXi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f3580ab80so1089421b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544007; x=1759148807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuYpX09H9KFZrrARW2j/gLTHGPwYXK58O4y6cHUAgEk=;
        b=RpHuDnXi8++/EYGb8BS3KBgMmb04eX2add4EmMg/QaVDTDS9CwGrIFzhy9hu8P1FNI
         RjjczyFmhTdx1SGdH/Xv9CM73M1Sgfqw2Nedm1R2cIT5/A22ZCzpN7+WyXG+FpzDcJQR
         7RJH4Tm7iRM1n4VRKDCk/IQ184HYBBM7uMKDPLdaT3SRiGlGxVUQrE25Qb0YokfL7Uld
         SlbJOOMys6eu8cnQyaLxwEGH7ScHUnVnqnanFFGgfCBVLSLc1pTLnsaB8LdBe5VVdsko
         N+0bW8USzEcIJefi8a/tqSAZm5HoCCSr/NEMx5KjkzyLqTP3NIWIRRWTAb6xxo72P8L5
         W0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544007; x=1759148807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuYpX09H9KFZrrARW2j/gLTHGPwYXK58O4y6cHUAgEk=;
        b=J+JycGEmiYFYOlqibICB2aXXBD/frjt9LFQgs0gnaCNeTsfWzNb1kC80zPIS+AFhEn
         yokhm742uf+mH5YoMCPEXfftjcTRPeKAmAUWsimh4Z9uUjx9rfY4b6V0taHq5Ue9CHJB
         noKCii6xFGlhyyUB7FUfxKn4SS2c2WcTd5sm8xCx+PK2Pb9svckq9KpejcWp+E+uugJY
         oFhYwoq3s9gi6XnRjB+r3LTEcBdZyw+hH+ZC0mAwPC5AZK1RiJ6jDNC7DD6TB6+fBWHt
         Hsiz++ID8Yj7KItvUY6WGKUAY5x+f3JcG07G/lEo482gtOlRSR15Zf3Z+lT0fdzjtipC
         reXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0CcDOJFv8Ms7xSEsmVTwjPNl4+a8NYz6GnNDLlZ7s9b9nOnENgvdKOWx4kdEgPH/wWqkVexj9MmDUTTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCXfs5lOanO/5rBJhRyn7TtLS9NzPKDRMh6iR/6OTqk+1H+fO
	CjrbCx6qGPo0mMpJlovZ1//CL3T2582cHBkHfSdxIwjP7RO0/BsKM/gA
X-Gm-Gg: ASbGnctcEJo8asKIYN/TJjbxYO9Fi4imYEGV20+Oln+mJrdy5XcemEjIcsz/+9mjPJ7
	l1/NdtCtcdWWQjYBNMZBTbCezJBoBqWiyqF1AbIRYtPjPfOnPaa7vY/8gWx0titc/IeJBZarRYt
	DV/slNboIvEJXw7C3qYmtAYB4Gp1Rkc44zEbnuaPaxQ2Z7aRPQHQnd/Cb7h5JQS+vbImbMWdVQB
	T64UN2hVW3s2ay7BqnEM4X24j5kA3QPYNPVGsXHIPJXTO7AI9WruvRzZCTNY0FwMUjNoYswNlbQ
	NOLBs6M66sM5pE8YW+ls1CyvKfmmqieQXxIuPd1JtvAppdnidBuZRqoRa2UOKN/dgX4G1YNki5B
	VNJ5R0MYQdQZyJuTs3cu9NksHN0YLbTS2IV+9HKmHvkevpeqilk1sZ6i0MIl4BOhTHpIpNOUlLP
	ShADiEtLDQqy8awbSGsXViK3znuYG1jvrLZVHd
X-Google-Smtp-Source: AGHT+IGQk4YSEaazTSeAW+opKwRMG3/jSIGDBwzfBTJu+e2mXeNJbH/paF4r6nTXx3faaTTdcZJgjg==
X-Received: by 2002:a05:6a21:1349:b0:2c2:626b:b04c with SMTP id adf61e73a8af0-2c2626c16b4mr2853633637.35.1758544007027;
        Mon, 22 Sep 2025 05:26:47 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff447060sm11795362a12.53.2025.09.22.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:26:46 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] workqueue: fix texinfodocs warning for WQ_* flags reference
Date: Mon, 22 Sep 2025 12:26:06 +0000
Message-Id: <20250922122606.418533-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sphinx emitted a warning during make texinfodocs:

  WARNING: Inline literal start-string without end-string.

This was caused by the trailing '*' in "%WQ_*" being parsed as
reStructuredText markup in the kernel-doc comment.

Escape the '*' in the comment so that Sphinx treats it as a literal
character, resolving the warning.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..60f0c7d30337 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -490,7 +490,7 @@ void workqueue_softirq_dead(unsigned int cpu);
  * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
  * that the sum of per-node max_active's may be larger than @max_active.
  *
- * For detailed information on %WQ_* flags, please refer to
+ * For detailed information on %WQ_\* flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
  * RETURNS:
-- 
2.34.1


