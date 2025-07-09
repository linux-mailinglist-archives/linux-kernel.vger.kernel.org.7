Return-Path: <linux-kernel+bounces-722593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0EAFDCAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00C658265C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1AB18FDAF;
	Wed,  9 Jul 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVcINdYS"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B21DDA18;
	Wed,  9 Jul 2025 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022866; cv=none; b=QXpRwltHtgZ8QPsI8vnzaPLIbqP5jdH+4e19NMUyWorI8mayN6DR4EaR7ZjpYuF5D3vxDa1CAxD8mQwwff95ySQgnC0MLSij92usFtnvfOerwW1Z1er2eGXIMR/4EoAcDPFFyw8DGWyefRVyK18CkeyNrsgw4KHudhZL5fopjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022866; c=relaxed/simple;
	bh=K439CV0Hr790Er9RUMtoSY+/LksLRGeekuflMOjQ/tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBkdXDVIlyUlj2kuYO91JecWS5SKwpkPXZ1RpQrrQstcgWh6EuIDPWENjS7DbR4lP+GwPW8pDmLBg/TQi7zevS55X+8i0tL9qRSxdCPF3BXavrXdQyteYFNw5vh7y2fbQ9dYMCnmZRSQj1Y7gNyWSRbWmf59P1HLV7zK9RKoqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVcINdYS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5040446276.1;
        Tue, 08 Jul 2025 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022864; x=1752627664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4j5uWVr2okio0nPQPsshhbU5KAvZtN3lS96eXXErJM=;
        b=CVcINdYSTaKsxOqaFlFSrbvcfJ03JMQm/kD4KfrBlzZBsSS/17xMHfVvQ4/wzrcSJi
         ikyBS/2404wrDX9eUSPRRqfKQT41qX13YiL4GAhnXnUu/d3RC8+O4OTFo4lHNzRA8kek
         7k+dFyjHFZ+HAFKpFrh1qIlrMJLezfQxfH9AeoBMEC1wlUJLk/Shmllc7CGmgdwo/cin
         JQBjHKuzFxxZ1leQbXYoivgAjbDpjiNstnanxwjr+HkkEnfdXfiuPjrO7R6WMZjdE0b2
         oAam2DTpFhayJYlfKDtQG7QccKCJujLoicSIPAZcJ4Z6xJ+Sl2rbCA4Mw5+rkpVb5hjP
         FBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022864; x=1752627664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4j5uWVr2okio0nPQPsshhbU5KAvZtN3lS96eXXErJM=;
        b=A4Ud6E3xTSWbw9bHLy6AT9RYnZ0De2srWSVJVda9Mw+k6vlEhBxwoR5nxfN2v237yC
         vO4t3A6NHhYmjYPq9Pqflrl9+wM3M1+txbvUBQeC2AL/cBIoNwkBXqtSQDFqH1TXmqRj
         91zoc8prrmWtnkIuWSeAIQ0e/ysFoOYCE3XN4MxshFcwuQmMXrGuQoM10n9sOd+Se07n
         yFBQKBEEtz4lgCuGDaRTvmElB/sWfhVaE5HadyfrHxhSv0qo+XSf4g+5SDDHI1YNKQ0P
         o5Qa6XyhhyhA+/Bz8MN2zexHfPfzN3ig6G+pEzBhyFlNbObbSMRAOiij5BMSc3yX4KkO
         +v3A==
X-Forwarded-Encrypted: i=1; AJvYcCVE/hG1S2zj4rJ36/2iQ8rAxx3NK8X7ifaMR5379J3bxEhrTRMtuAhi0ybIwmWCubnRD7iAtR6tf/20ja3a@vger.kernel.org, AJvYcCXblB1Y7cmU4FAaE5IUmkXsPoGzWWxoxcsWsklP80XcL3FMR4sbmeaEntO67M6HUesFCDRj6NT3mzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttW63JRqQMaD2K03jYzlWxCfZTzvDfptWQhx7B8jrgB3iuMlI
	L0nIBEffBUnEGIW5QcFm8FATGxl2XjFhKvJ7R6lAk4qNz4uMloNSD4yr
X-Gm-Gg: ASbGncu4knCMHDYHJ9ka9BU+lWwQAnp1SuwxFGoyqhQ/4i86U5uyZ8AWAIrAaA+B4ab
	7iabqbnSYXgJVDtTWYG8EwT5G44f1DHl9nZQrtV5vwHhs2v1uO33PHHAD8Y/m1RlK9pUf56Ally
	dHDaxwcdGZrUx8IiodVAe70iRcAk5LmWaI6bOrb4BCglZqOqQsjs8qU/fpxyH0Wu63OUtpFGg2H
	q2rf75FXzR5YPwDR7cVmCygII/E8rsIDJg0se+Pg8eRC++iGnjndTRmQtdVAsMBfsQ0AzyZXjeT
	pzLEOxcaJIhkhx1JRwX/FDSNns4WFaEdynNuggJkGRLG6WpBZ2rJur/5aBkd5P0IK+L/laLCYHq
	AQEr47FM=
X-Google-Smtp-Source: AGHT+IHLPdZoeujPLqUztp6UuADx4QDXfITwDq09vzFE768onA06GI5SAONpI024p+kEEi9lspLVXA==
X-Received: by 2002:a05:6902:6886:b0:e84:1f9f:1344 with SMTP id 3f1490d57ef6-e8b6e0e4588mr825062276.19.1752022864185;
        Tue, 08 Jul 2025 18:01:04 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:01:03 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 10/13] Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
Date: Tue,  8 Jul 2025 19:59:40 -0500
Message-ID: <20250709005952.17776-11-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Document that the migrate_{hot,cold} schemes can be used by the vaddr
operations set.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ddc50db3afa4..03f8137256f5 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -452,9 +452,9 @@ that supports each action are as below.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``migrate_hot``: Migrate the regions prioritizing warmer regions.
-   Supported by ``paddr`` operations set.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``migrate_cold``: Migrate the regions prioritizing colder regions.
-   Supported by ``paddr`` operations set.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
-- 
2.43.0


