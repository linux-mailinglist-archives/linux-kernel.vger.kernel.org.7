Return-Path: <linux-kernel+bounces-822053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC1B82EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BD87B51D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47355217733;
	Thu, 18 Sep 2025 05:04:42 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB23FE5F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171881; cv=none; b=SghWJVxK/vagG9iMCNDdvoCgTZFfvZ9yaMqgosYv4qCpq7fMRLRxeetSOBHOqyDk3Ip9AV5K8uZCoRgmLrNldusaWI9gz2oxeWid3jUuaOm5/r1OUpzIWwREWRn0FywFpLctH5kfTuTQ0s/k4j598MKMYm2/s3DOSzwHTttuHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171881; c=relaxed/simple;
	bh=dJ2+G9CXdV7SdLfOc0J1n5M0+xeRl3cfsHMGusF+jOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFz3SHWFWsy20Cu4zijeBPWEGAghFi33O8GUylV5eXFwvFKRLaEDQgeY+a9REwQdz38J9AFnoAHV119X22YowJN1y85PWP5fYiJgbJtFcFxJidWR8UAnYHMKtFjNFLYTTY6BNqfAzgerXA4JX8TisKFKM6tunwj9Zo0GQxRmZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so217597f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171878; x=1758776678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i69tc5LqSYutpnPuXybPetu7m39RGyNdoIoy0x78ep0=;
        b=uoM4PP9ga9s0rrjt7K5SiAZaSVa2KqQtHIGftWTTEv5//mX7bkdbY0xXmnpmwD8Yco
         cujpkLQBYR2PBKDOkiTQBvhjfCB4apSuTH+8bCzOG7idHKryw8tQaU6yi8dlcizhvpAR
         zqpJgsJ+WBCUeHSRH+SbmBoDeTnAQbzU/9DK7WFunSvKmw04749v1D5SQKsdfeBOQpaf
         VTAOu/aaV5S0sjF58ubztRx+moFBqaGvxzFbERvRCcGJr9kLBwSVxAgztqaMjrqBJgYS
         UBa2uitXi5aENSOUECqSqHuheAuKAFN82A2hf3eNnbbB9k1MWUUZXME1wvo+eB5JDBwM
         AFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmwI11wwudm4+q8emMJxgz4cNPVVM2UzvgbYk6tqTRkSuKNRu+Ou3t4FpAbV6QGlJnvm1aW+9V+O7TtIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9b5h4d0SUrt0KPjyYiZrq4yyZO0feN+LjgrWN187QeRtQPHXd
	rJ8gjyoGs86pgVJJqfZakrMAe8iAlYOZs7g6Ta4SG36IbPfksTOIFF0a
X-Gm-Gg: ASbGncv7+d5McnXdX/V5x0TTwZPvXbFRbwc26IKm2lIXqzD8b2i1WnfuNSSKNFTlg/c
	zwbhACQU8RosFpCxanD2cIcb3jpQtHJ0cqtD6B4sqty7EUgeKjJK0xrATS5WuTCG6maqut+vL/J
	g6gYwmV5CnS7Z+pydr965dZQdNbYLYvGWR0YftsUf4ThA4gJJLy3Jek5v2VvWc5ngBGG90GdE0U
	sosAmz2TlyW/jZwzy5W1VLR4tsr4W88s6qKa6JWJGCu6PSEgUL6DUwC09h5/B/mZTrOrmHTnw0C
	lJgHOltG9DbtFP7HqCvb25BpMWNlXUeIn1LukKTGHrLCniU1itDUJ4u7jGnyNhrI3GtiHsd4tW3
	8Z7EZWvqi4hKXoPzgNFouT5gT8UQ=
X-Google-Smtp-Source: AGHT+IEipy1WMSokuL4yZS5rUn1njehy5C0LCE/S735hhPYb3oucQvGSCGf8/4wxTRJ70cZWL/yrcg==
X-Received: by 2002:a5d:5f91:0:b0:3dc:1473:18bd with SMTP id ffacd0b85a97d-3ecdf9be76fmr4130913f8f.3.1758171878179;
        Wed, 17 Sep 2025 22:04:38 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm1994409f8f.14.2025.09.17.22.04.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 22:04:37 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	kirill@shutemov.name,
	hughd@google.com,
	mpenttil@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new v2 0/2] mm/khugepaged: optimize collapse candidate detection
Date: Thu, 18 Sep 2025 13:04:29 +0800
Message-ID: <20250918050431.36855-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series improves the THP scanner by teaching it to detect unsuitable
collapse candidates, such as guard PTEs, earlier in the scan to avoid
wasted work.

Thanks,
Lance

---
v1 -> v2:
 - #01 Dropped patch that skipped mlocked VMAs from THP collapse, per
       discussion. Thanks a lot to Hugh, Kiryl, Lorenzo, Dev and Mika!
 - #02 Pick RB from Lorenzo - thanks!
       Update the changelog (per Lorenzo)
       Pick AB from David - thanks!
 - #03 Reuse SCAN_PTE_NON_PRESENT for guard PTEs (per Lorenzo)
 - https://lore.kernel.org/linux-mm/20250914143547.27687-1-lance.yang@linux.dev

Lance Yang (2):
  mm: make is_guard_pte_marker() available for hugepage collapse
  mm/khugepaged: abort collapse scan on guard PTEs

 include/linux/swapops.h |  6 ++++++
 mm/khugepaged.c         | 10 ++++++++++
 mm/madvise.c            |  6 ------
 3 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.49.0


