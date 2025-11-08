Return-Path: <linux-kernel+bounces-891676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D16C433A8
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F393347E05
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02884265623;
	Sat,  8 Nov 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmyjTPiT"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A614884C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629752; cv=none; b=h0g2aFbOVPJlEJCQqXGaE94IwizMyOOh3LVjtJoTcu81disuzZFOBQVSloBl8HOSDh11ViIrib0NJkJ7aDsmlkAyugT16nWpVO3qVT+CuaV3bfCRfAWaIbvkF0Bv/gbAk+EmRNVg0DfALjjIuhKm2FIxn+bIwEfqrAQLxdScuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629752; c=relaxed/simple;
	bh=up4+T+Vlgr3bfen8hI6CHhXyKacPmsvTPK5j8/l7Q4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPgsoZ9GQ10DD/MDAaFzA3BWHwBDU38etGA5yoW6b8ARAiQ5ohBkGR/cjwEJjjaHNoTBaoa5qvQAYZHHDpPJkNZeGMD79rYOWNChbDiRfL3ckjcPFj13Og9t/CAHDpr8VuzTHv3lNGwBnDnfnlaPAnnmKOc5hRau24syV3BsEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmyjTPiT; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4331b4d5c6eso7395785ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629750; x=1763234550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03K14G0YoonwYbFA43DX/6Sm2xq1yhV7AwclEvpudeM=;
        b=YmyjTPiTUoSn4eviA3N9Yu3CvnhJfQeQ6tvw/7Qdv99QzqjuE7h5Bke+hyinsidFk6
         EQCiDQm4xksFIvMur7ZMy6TR1NIh+JWNVb7Q4CyqOjZveNb7iSbILTX70NA9qvuGXmCe
         zVQjHnEG5uHy+xpV483tgsM6OW8FBD458WiCvNRQ1CSOCuSav6JmSegTSaPlfQdSTPfY
         PD8VchaF0Hll2ovm0Ft/TTk8ZBfsF6jH4iBgHyaGdzse0JekGRjxBeN8TygBBNq225kY
         EGVsS0tcs+wEk4Pe5vJXdF+NBbbp5YkCfJTMF8xnL6o/+l+lMF+40SjwYuIZ5rvF1NKA
         O32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629750; x=1763234550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03K14G0YoonwYbFA43DX/6Sm2xq1yhV7AwclEvpudeM=;
        b=bb9m3Ezcgvw0TLNL4gbUcCSnLON3bfXVn7IPJ7YdzG93+pPNhGPxbtmUbYuzG6lmUd
         +D8yWNeUcb/caPqZeFowoYsZO0THvqU5zVS+Pt06/10G/q6y36zm4bhsIJnz8BP8r7pi
         3FwlUijD5FGD9M/eFnNCMT/0VH5ntExNVTeJ0Wi7Qm5KALJgEgGhQKV72rv0tE9rs6Hf
         g5Z/b2sLVFWAhiga3uda6ELvD/JreT9TjcOb3uClO6YP9k+TeBiO/UBN4dB6dOrKZhQW
         btU545EqG0ImSj6XVy+/DStPRLR+WN8fuz3ZtFiebNFGcib3t1tRBn6yDQM9/CwW8+lL
         Oc3w==
X-Forwarded-Encrypted: i=1; AJvYcCVWek1Z0dNViB/O/14OClk55lUu+AemkaYodpnrZj+GRCHUDKPVQgJzPMzjYkXVttl/qqut4z0Wx7KtCQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7OvZzfnP8NHYpb+0zpGqLETYEgNy1XS2c6MPSzqW9eYjwsMZ
	o0ZPWlTBEW/oeKkB7xLeA0UaP0ovVKGuARvUvz02Nif9P6sY+80zYxyA
X-Gm-Gg: ASbGncsaL0l4xTWqVMOLxCf5Uu+0k74eDkBli39b1x3+kCjbiJsT0eFLtU2JPtGWWzB
	hiwbmFzlY3GP6r0Fitl+refyLd3ns3hA+TDQbRe5gku5LtqZOi37S2KdvdfBoxV2mQ5Ut/31RYo
	I4sYSQOD/zj9WRY7vKD0p+iDYuPYP4SjRun7wOguexg/4xL6oL6klXChKC3N2j/Msw3d7JU1l7S
	NRgy+HG1q01cwaJSqQd5QHJVBRNVIuRRTJTko3i9dkzfEiTF5h3N5bvgtFlNbi7KlCir/WEaWFj
	wSnONbMYnwMsG37LbVuHjgiBzfjAtMEvofpN5XELdwbKz8dokVoC/4iu6SBt2hIiCFY4dyQGMSt
	jXwSLWYKJlu6kF9UwJg2yPQZIaiwVsNVjR3aTzhnkGIs48N9/vw+YCjWvM40cRhj3bB4Yg9ddND
	TqEyk2gOe3M4ky9eN47RUYIPeZFGHB5LzI6CNzIC25W1oL/tW4a0L2anSu9Aa/sA==
X-Google-Smtp-Source: AGHT+IEz3FESVkX5elsfVenCRkFYCsyWww7qdldsgfZPcmJ5WrW9qgOug9eVK4qHiNMge6D5SMistw==
X-Received: by 2002:a05:6e02:3813:b0:433:330a:a572 with SMTP id e9e14a558f8ab-43367de5254mr54763635ab.13.1762629750036;
        Sat, 08 Nov 2025 11:22:30 -0800 (PST)
Received: from localhost.localdomain ([2601:246:5f80:2880:499b:78c9:9e03:a278])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-433796a9952sm1681465ab.28.2025.11.08.11.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Nov 2025 11:22:28 -0800 (PST)
From: pierwill <pierwill@gmail.com>
X-Google-Original-From: pierwill <pierwill@users.noreply.github.com>
To: tglx@linutronix.de
Cc: bp@alien8.de,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pierwill <pierwill@users.noreply.github.com>
Subject: [PATCH] docs: Fix missing word in spectre.rst
Date: Sat,  8 Nov 2025 13:22:16 -0600
Message-Id: <20251108192216.28534-1-pierwill@users.noreply.github.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrects a missing word in the hardware vulnerability docs.

Signed-off-by: pierwill <pierwill@users.noreply.github.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 991f12adef8d..4bb8549bee82 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -406,7 +406,7 @@ The possible values in this file are:
 
   - Single threaded indirect branch prediction (STIBP) status for protection
     between different hyper threads. This feature can be controlled through
-    prctl per process, or through kernel command line options. This is x86
+    prctl per process, or through kernel command line options. This is an x86
     only feature. For more details see below.
 
   ====================  ========================================================
-- 
2.39.5 (Apple Git-154)


