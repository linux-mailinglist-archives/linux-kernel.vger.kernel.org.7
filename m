Return-Path: <linux-kernel+bounces-833725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2ABA2DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38BB6256DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87191288C2F;
	Fri, 26 Sep 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqbiffig"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD53A945
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873165; cv=none; b=IFK2QUCBVbxyA61FP4rg0meb2Bzz3R0GeYoAI9clRotsp0nzfQZNZ8MOQ6XNe9I04bMC+2cxDbbO6kLfaCLhgYkgTdLlJ+O4l1xUQnf6haFxTqlVgLm4IUm1kC7HL2krstQadWsvkyebENeYp3TMifydgBwMP5E8Fx+6pV1OVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873165; c=relaxed/simple;
	bh=yTrA1EeEFCkds8LAnq0eYYrzGRs6Lt5Z7d9jpFX23eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aiu/cWOhL6ZlYh4Cth9qSLYBzooEnkskLj3s+cRYXt6Ng0sr+FzlDnGl6BzVCtVCIXLhHUeFNDyVorbhgjvx1gr2enlqMXKUI1es3zykiqyBvpL8TyxboBC0FwEnk2iJzxMeQVghpyX0vDWMiqsreOuIjyCeoRkh8d0bcBv9vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqbiffig; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso1525639b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758873163; x=1759477963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xk9LaGpSzzuCcurgjZZBYiVFoaZUlO1vc9E6NF4Dpgk=;
        b=aqbiffigWHDCDcG8aX6s3NZt/Hfoxg544U+U9pqDPnkfOknYQRkLUK7F/zwFF/kbpT
         NC+gPqO+x4Q6UOtRfwC9ktRaaaCBselfHVzmDd7+m12THkxDdw0MPzf1zqMzoaJru8zQ
         iIzFfmFsXiGjuufv1Nd3jWqEBIMGQY6Xm9vx/UHIfJHCrrV9VHwA0dhm0DZfD9D2dI3z
         6EPIQ+WiYqoR3o4YS9LIhAqAyAw2qp62pMZZdD4XQdQ//C+JPp1EdMFkMHYcfZx9W/DU
         +YOqNnTJDSc/96DcbpHcMckcdskGtxLcI3eMwR7pREc0ayMV5tocqHRDpjYaxmk3Mhlb
         pBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758873163; x=1759477963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk9LaGpSzzuCcurgjZZBYiVFoaZUlO1vc9E6NF4Dpgk=;
        b=KTqNhLGlwHTD0YyvBrunaDF1hsYKAnE5f6DV9IH2IEsl0sn4fPqPlkTzTIxJ7UNr9j
         eNcTkvsh6jgmThvNHzd4ZZ0MghswOo+86ohGt9+c5eudYIVWnG3dGntmgyXVlAMlZ8yX
         7ujGk3EFaa7BPjm+UoeOfqu6jJjH1/6qA18pA3lvGFq+ND1HE8LBGd/PWORmk7IPNHHJ
         GQNl52RVCDYr+TuaydgYOaO/jiiWzA8MCvWS+MY91m0+r9uJcIs5wPDsY9HbozcE/RgE
         BPeaRweH39Z4LnxeURqiLcnKDEJT6NjklxiNcQUbr6nXYmr8WECag1e7fMvytYtr7pPL
         lLnw==
X-Forwarded-Encrypted: i=1; AJvYcCVNbuaf07FdLgUxtjLMU1rfacW0P7I9da5rfjxNM6E+9h1aG2HpHossSSdfUj2htePygCVTq1f8UOI81vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFG9jAWYJb78RjKe/YpACVeo0q18jIN5vVz8XN9bMto1XrC0rX
	qGzfAV7R61AG2CICdX/+SUcAoq4VJU5U/Pd4EcUPrXDyv8Gns0JULdQk
X-Gm-Gg: ASbGncvZomCxmv3mCSAwGGc30xnnLmbNynkPvAxOscQMU3Wulqs9RGcGHkurWc00wCg
	RvQBh+kBzjuiQ6fKTawoUiKhQGmF3/62LYUtKrORFFvnrtZ6tCtKPrJhXySj65WRCN37YrA6/iM
	I9wR/Ootbpu6jSB/s6pN4ez+4Z4Tc/epLyNQfBvQzXKJE+Ba8nKNLFocp6D8yv8kdcshM/ok/6Z
	0Q6mAd2TkRnBZKJNoUZ2I0qy2xXhWd5RS0cQvepvtsqnYDC19qlpBPKJZGh9AZkGCaQYxuLR8ou
	ufrwVXeBsEBsP6/co98etnQNbZX0A3SDFJSvbI0NMO6qUwtJuGg1andSE8mmGsXWpjfJr2LEsoa
	dktvTxF+AmCzvz6b4ALcIic2wStcfeobW3CB1bLxyx2LGOucF7sOBWrZSjRxunsy8q5mLBQdJYJ
	fJbg==
X-Google-Smtp-Source: AGHT+IHF0w8xrOwQ/WnUtuSb7hHzpglgBbu8ZnbFbkaVP1raUcfFCQ+iEO1NhbtJXsIqCjzZ2Z3SGg==
X-Received: by 2002:a05:6a20:4323:b0:266:1f27:a024 with SMTP id adf61e73a8af0-2e7d1d12f16mr7611800637.41.1758873162802;
        Fri, 26 Sep 2025 00:52:42 -0700 (PDT)
Received: from chandna.localdomain ([223.190.80.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm3973689a12.43.2025.09.26.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:52:42 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sahil Chandna <chandna.linuxkernel@gmail.com>
Subject: [PATCH] kallsyms: use kmalloc_array() instead of kmalloc()
Date: Fri, 26 Sep 2025 13:20:53 +0530
Message-ID: <20250926075053.25615-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc(sizeof(*stat) * 2, GFP_KERNEL) with
kmalloc_array(2, sizeof(*stat), GFP_KERNEL) to prevent potential
overflow, as recommended in Documentation/process/deprecated.rst.

Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 kernel/kallsyms_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index cf4af5728307..2b082a7e24a2 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -264,7 +264,7 @@ static int test_kallsyms_basic_function(void)
 	char namebuf[KSYM_NAME_LEN];
 	struct test_stat *stat, *stat2;
 
-	stat = kmalloc(sizeof(*stat) * 2, GFP_KERNEL);
+	stat = kmalloc_array(2, sizeof(*stat), GFP_KERNEL);
 	if (!stat)
 		return -ENOMEM;
 	stat2 = stat + 1;
-- 
2.50.1


